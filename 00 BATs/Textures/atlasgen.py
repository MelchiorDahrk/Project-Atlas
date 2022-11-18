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
from typing import Tuple, List, Dict, Optional


def get_path(texture_name: str) -> str:
    """Returns the path for the file. Meant to be patched to support systems like OpenMW/Portmod"""
    return texture_name


def read_atlas(atlas_file: str) -> Tuple[Dict[str, int], Dict[str, int], List[str]]:
    widths = {}
    variables = {}
    commands = []
    with open(atlas_file, encoding="utf-8") as file:
        section = None
        for line in file.readlines():
            # Ignore comments and empty lines
            if line.startswith("#") or not line.strip():
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
                widths[texture_file.strip()] = int(width.strip())
            if section == "variables" and "=" in line:
                variable_name, _, value = line.rpartition("=")
                variables[variable_name.strip()] = int(value.strip())
            elif section == "commands":
                commands.append(line.strip())

    assert widths, "There must be at least one texture file as input to the atlas"
    assert commands, "There must be at least one command to generate the atlas"
    return widths, variables, commands


def generate_atlas(atlas_file: str, multiplier: Optional[Fraction] = None):
    widths, variables, commands = read_atlas(atlas_file)

    # Determine Atlas base width, using the median texture size after adjusting for the ratios
    if multiplier is None:
        outputs = check_output(
            ["magick", "convert"] + list(map(get_path, widths.keys())) + ["-format", "%w ", "info:"],
            encoding="utf-8",
            text=True,
        ).split()
        expected_values = list(widths.values())
        multipliers = [
            int(int(width) / expected_width)
            for width, expected_width in zip(outputs, expected_values)
        ]
        multiplier = Fraction(median_high(multipliers))

    # Commands are merged into one magick convert call
    # (requires adding a '-write' before each output)
    # This also allows the use of mpr references between commands
    outputs = []
    combined_commands = []

    def arithmetic_sub(string: str) -> str:
        """
        Evaluates arithmetic patterns in the input

        They can include fractions and multiplication
        E.g. {2*1/2}, {width/2}, {10*width/2}
        """

        def inner(match):
            expr = match.group(0).strip("{}")
            for key, value in variables.items():
                if key in expr:
                    expr = expr.replace(key, str(value * multiplier))
            return str(reduce(operator.mul, map(Fraction, expr.split("*"))))

        return re.sub(r"{([0-9.]+|\*|[a-zA-Z]+)+?}", inner, string)

    for command in commands:
        command = arithmetic_sub(command)
        new_command = []
        output = shlex.split(command)[-1]
        outputs.append(output)
        for word in shlex.split(command)[:-1]:
            if word.lower().endswith(".dds"):
                # Each input texture is resized so that textures being larger/smaller
                # than expected does not break the atlas
                width = multiplier * widths[word]
                new_command.extend(["(", get_path(word), "-resize", str(width), ")"])
            else:
                new_command.append(word)
        # Set compression for dds outputs
        # so that it doesn't have to be specified in the template
        # (can still be overridden by the template)
        if output.lower().endswith(".dds") and "dds:compression=" not in command:
            new_command.extend(["-define", "dds:compreession=dxt1"])
        # Make sure parent directories of the output file exist
        if not output.lower().startswith("mpr:"):
            os.makedirs(os.path.dirname(output), exist_ok=True)
        new_command.append("-write")
        new_command.append(output)
        combined_commands.extend(["("] + new_command + [")"])
    # null: is necessary since there is no final output. Each command has its own output.
    check_call(
        ["magick", "convert", "-respect-parentheses"] + combined_commands + ["null:"],
    )

    # Clean up temporary files
    for filename in outputs:
        if filename.lower().endswith(".bmp"):
            os.remove(filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
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
    for file in args.atlas_file:
        print(f"Generating atlases from {file}")
        generate_atlas(file, args.multiplier)
