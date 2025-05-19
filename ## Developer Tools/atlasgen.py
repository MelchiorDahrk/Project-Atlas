#!/usr/bin/env python3
# This is free and unencumbered public domain software. For more
# information see http://unlicense.org/ or the accompanying LICENSE file.

"""
Project Atlas generator helper

Requires python 3.7 or newer

Uses a .atlas template file to produce a texture atlas.

The template file consists of a list of imagemagick convert commands
(not including the "magick convert" part), and the expected widths
of the textures.

E.g.
```
# The first line which is nonempty and not a comment is used as the generator name
Example Generator
# Files can also include comments
[widths]
texture1.dds = 512
texture2.dds = 256
texture3.dds = 256

[commands]
texture2.dds texture3.dds +append mpr:temp
texture1.dds mpr:temp -append eg_atlas.dds
```

Performs the following:
- Resizes textures to the correct size relative to the atlas size.
- Detects the size of the atlas based on the median size of the input textures
  (after adjusting for the widths)
- Allows the atlas width to be referenced in commands using expressions such as {3*width/2}
  (only fractions and multiplication are supported).
- Defines dds compression options for output dds files.
- Combines the commands into a single magick command, allowing the use of in-memory mpr labels
  See https://imagemagick.org/Usage/files/#mpr
- Creates parent directories for output files if they don't exist already.
- Removes temporary .bmp files
"""

import math
import argparse
import os
import sys
import re
import operator
import shlex
from statistics import median_high
from functools import reduce
from fractions import Fraction
from subprocess import check_call, check_output
from typing import Tuple, List, Dict, Optional, Callable
import glob
from dataclasses import dataclass

NUM_COLUMNS = 3


def valid_multiplier(multiplier: int) -> bool:
    # Multipliers must be a power of 2 to ensure that the resulting texture dimensions are powers of 2
    if multiplier > 0 and math.log(multiplier, 2).is_integer():
        return True
    print("Multipliers must be positive powers of 2 (1/2, 1, 2, 4, 8, etc.)")
    return False


def prompt_number(
    prompt: str,
    maximum: Optional[int] = None,
    valid: Optional[Callable] = None,
    allow_default: bool = False,
) -> Optional[int]:
    choice = None
    while not isinstance(choice, int):
        try:
            if maximum is not None:
                print(f"{prompt} [0 - {maximum}]: ", end="")
            else:
                print(f"{prompt}: ", end="")
            choice = input()
            if choice.strip() == "":
                if allow_default:
                    return None
                raise ValueError()
            choice = int(choice)
            if (
                valid is not None
                and not valid(choice)
                or maximum is not None
                and choice > maximum
                or choice < 0
            ):
                choice = None
        except ValueError:
            print("Invalid number try again!")
        except EOFError:
            sys.exit(1)
    return choice


def print_options(options: List[str], start=0):
    """Displays the list with indices, in multiple columns"""
    max_length = max(len(item) for item in options)
    num_length = len(str(len(options)))
    column = 0
    for index, item in enumerate(options):
        # Print a newline only on the third column
        lineend = "  "
        if column == NUM_COLUMNS - 1:
            lineend = "\n"
        print(
            str(index + start).rjust(num_length),
            "-",
            item.ljust(max_length),
            end=lineend,
        )
        column = (column + 1) % NUM_COLUMNS

    if column != 0:
        print()


def get_path(texture_name: str) -> str:
    """Returns the path for the file. Meant to be patched to support systems like OpenMW/Portmod"""
    return texture_name


@dataclass
class AtlasGen:
    filename: str
    name: str
    widths: Dict[str, int]
    variables: Dict[str, int]
    commands: List[str]

    def __init__(self, atlas_file: str):
        self.filename = atlas_file
        self.widths = {}
        self.variables = {}
        self.commands = []
        with open(atlas_file, encoding="utf-8") as file:
            section = None
            name = None
            for line in file.readlines():
                # Ignore comments and empty lines
                if line.startswith("#") or not line.strip():
                    continue
                if name is None:
                    self.name = name = line.strip()
                    continue
                if (
                    line.startswith("[variables]")
                    or line.startswith("[widths]")
                    or line.startswith("[commands]")
                ):
                    section = line.strip().strip("[]")
                    continue
                if section == "widths" and "=" in line:
                    texture_file, _, width = line.rpartition("=")
                    self.widths[texture_file.strip()] = int(width.strip())
                if section == "variables" and "=" in line:
                    variable_name, _, value = line.rpartition("=")
                    self.variables[variable_name.strip()] = int(value.strip())
                elif section == "commands":
                    self.commands.append(line.strip())

        assert (
            self.widths
        ), "There must be at least one texture file as input to the atlas"
        assert self.commands, "There must be at least one command to generate the atlas"


def detect_multiplier(atlas: AtlasGen) -> Fraction:
    outputs = check_output(
        ["magick", "convert"]
        + list(map(get_path, atlas.widths.keys()))
        + ["-format", "%w ", "info:"],
        encoding="utf-8",
        text=True,
    ).split()
    expected_values = list(atlas.widths.values())
    multipliers = [
        int(int(width) / expected_width)
        for width, expected_width in zip(outputs, expected_values)
    ]
    return Fraction(median_high(multipliers))


def generate_atlas(atlas: AtlasGen, multiplier: Optional[Fraction] = None):
    print(f"Generating {atlas.name} atlases")
    # Determine Atlas base width, using the median texture size after adjusting for the ratios
    if multiplier is None:
        multiplier = detect_multiplier(atlas)
        print(f"Detected a multiplier of {multiplier}")

    # Commands are merged into one magick convert call
    # (requires adding a '-write' before each output)
    # This also allows the use of mpr references between commands
    outputs = set()
    combined_commands = []

    def arithmetic_sub(string: str) -> str:
        """
        Evaluates arithmetic patterns in the input

        They can include fractions and multiplication
        E.g. {2*1/2}, {width/2}, {10*width/2}
        """

        def inner(match):
            expr = match.group(0).strip("{}")
            for key, value in atlas.variables.items():
                if key in expr:
                    expr = expr.replace(key, str(value * multiplier))
            return str(reduce(operator.mul, map(Fraction, expr.split("*"))))

        return re.sub(r"{([0-9.]+|\*|\/|[a-zA-Z]+)+?}", inner, string)

    for command in atlas.commands:
        command = arithmetic_sub(command)
        new_command = []
        output = shlex.split(command)[-1]
        outputs.add(output)
        for word in shlex.split(command)[:-1]:
            if word.lower().endswith(".dds"):
                # Each input texture is resized so that textures being larger/smaller
                # than expected does not break the atlas
                width = multiplier * atlas.widths[word]
                new_command.extend(["(", get_path(word), "-resize", str(width), ")"])
            else:
                new_command.append(word)
        # Set compression for dds outputs
        # so that it doesn't have to be specified in the template
        # (can still be overridden by the template)
        if output.lower().endswith(".dds") and "dds:compression=" not in command:
            new_command.extend(["-define", "dds:compression=dxt1"])
        # Make sure parent directories of the output file exist
        if not output.lower().startswith("mpr:"):
            os.makedirs(os.path.dirname(output), exist_ok=True)
        new_command.append("-write")
        new_command.append(output)
        combined_commands.extend(["("] + new_command + [")"])
    # null: is necessary since there is no final output. Each command has its own output.
    print("Running imagemagick")
    check_call(
        ["magick", "convert", "-respect-parentheses"] + combined_commands + ["null:"],
    )

    # Clean up temporary files
    if outputs:
        print("Cleaning up")
    for filename in outputs:
        if filename.lower().endswith(".bmp"):
            os.remove(filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generates texture atlases based on template files and loose textures. "
        "If executed without arguments, runs in interactive mode"
    )
    parser.add_argument(
        "atlas_file", help="Atlas template file for processing", nargs="*"
    )
    parser.add_argument(
        "--multiplier",
        help="Size multiplier for the atlas. "
        "If omitted, it will be detected based on the sizes of the input textures",
        type=Fraction,
        nargs="?",
    )

    args = parser.parse_args(sys.argv[1:])

    if not args.atlas_file:
        # Find all the categories and loose files in the atlas directory
        # Nested categories are not supported
        all_files = []
        categories = {}
        loose = []

        basepath = os.path.join(os.path.dirname(sys.argv[0]), "atlas")
        for entry in os.listdir(basepath):
            path = os.path.join(basepath, entry)
            if os.path.isdir(path):
                atlas_files = list(
                    map(
                        AtlasGen,
                        glob.glob(
                            os.path.join(path, "**/*.atlas"),
                            recursive=True,
                        ),
                    )
                )
                categories[entry] = atlas_files
                all_files.extend(atlas_files)
            else:
                file = AtlasGen(path)
                all_files.append(file)
                loose.append(file)

        # Print generator options
        options = {}
        options[0] = all_files
        print_options(["All Generators"])
        index = 1
        # Print each category, and the individual generators in each category
        for category, atlas_files in categories.items():
            print()
            options[index] = atlas_files
            print_options([f"All in the '{category}' category"], start=index)
            index += 1
            print_options([file.name for file in atlas_files], start=index)
            for file in atlas_files:
                options[index] = [file]
                index += 1

        # Print uncategorised files at the end
        if loose:
            print()
            print_options([file.name for file in loose], start=index)
            for file in loose:
                options[index] = [file]
                index += 1

        choice = prompt_number("Which patcher should be run?", maximum=index - 1)
        multiplier = prompt_number(
            f"What multiplier should be used? This value scales the output size of all atlases.{os.linesep}"
            f"A multiplier of 1 will produce atlases using the vanilla texture sizes.{os.linesep}"
            "If left blank, the multiplier will be detected based on the size of your textures",
            valid=valid_multiplier,
            allow_default=True,
        )
        for file in options[choice]:
            generate_atlas(file, multiplier)

    for file in args.atlas_file:
        generate_atlas(AtlasGen(file), args.multiplier)
