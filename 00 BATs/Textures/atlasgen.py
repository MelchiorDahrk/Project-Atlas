#!/usr/bin/env python3
# This is free and unencumbered public domain software. For more
# information see http://unlicense.org/ or the accompanying LICENSE file.

"""
Project Atlas generator helper

Requires python 3.7 or newer

Uses a .atlas template file to produce a texture atlas.

The template file consists of a list of imagemagick convert commands
(not including the "magick convert" part), and a ratio that indicates
the width the texture is expected to be,  relative to the overall width of the atlas.

E.g.
```
# Files can also include comments
[ratios]
texture1.dds = 1
texture2.dds = 1/2
texture3.dds = 1/2

[commands]
texture2.dds texture3.dds +append mpr:temp
texture1.dds mpr:temp -append eg_atlas.dds
```

Performs the following:
- Resizes textures to the correct size relative to the atlas size.
- Detects the size of the atlas based on the median size of the input textures
  (after adjusting for the ratios)
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
from statistics import median_high
from functools import reduce
from fractions import Fraction
from subprocess import check_call, check_output
from typing import Tuple, List, Dict, Optional


def read_atlas(atlas_file: str) -> Tuple[Dict[str, Fraction], List[str]]:
    ratios = {}
    commands = []
    with open(atlas_file, encoding="utf-8") as file:
        section = "ratios"
        for line in file.readlines():
            # Ignore comments
            if line.startswith("#"):
                continue
            if line.startswith("[ratios]"):
                # Just exists for readability
                continue
            if line.startswith("[commands]"):
                section = "commands"
                continue
            if section == "ratios" and "=" in line:
                texture_file, _, ratio = line.rpartition("=")
                ratios[texture_file.strip()] = Fraction(ratio.strip())
            elif section == "commands":
                if line.strip():
                    commands.append(line.strip())

    assert ratios, "There must be at least one texture file as input to the atlas"
    assert commands, "There must be at least one command to generate the atlas"
    return ratios, commands


def generate_atlas(atlas_file: str, base_width_override: Optional[int]):
    ratios, commands = read_atlas(atlas_file)

    # Determine Atlas base width, using the median texture size after adjusting for the ratios
    if base_width_override is not None:
        base_width = base_width_override
    else:
        outputs = check_output(
            ["magick", "convert"] + list(ratios) + ["-format", "%w ", "info:"],
            encoding="utf-8",
            text=True,
        ).split()
        ratio_values = list(ratios.values())
        sizes = [int(int(size) / ratio) for size, ratio in zip(outputs, ratio_values)]
        base_width = median_high(sizes)

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
            expr = expr.replace("width", str(base_width))
            return str(reduce(operator.mul, map(Fraction, expr.split("*"))))

        return re.sub(r"{([0-9.]+|\*|width)+?}", inner, string)

    for command in commands:
        command = arithmetic_sub(command)
        new_command = []
        output = command.split()[-1]
        outputs.append(output)
        for word in command.split()[:-1]:
            if word.lower().endswith(".dds"):
                # Each input texture is resized so that textures being larger/smaller
                # than expected does not break the atlas
                width = base_width * ratios[word]
                new_command.extend(["(", word, "-resize", str(width), ")"])
            else:
                new_command.append(word)
        # Set compression for dds outputs
        # so that it doesn't have to be specified in the template
        if output.lower().endswith(".dds"):
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
    parser.add_argument("atlas_file", help="Atlas template file for processing")
    parser.add_argument(
        "--width",
        help="Width of the atlas. If omitted, will be detected from the input textures",
        type=int,
        nargs="?",
    )

    args = parser.parse_args(sys.argv[1:])
    generate_atlas(args.atlas_file, args.width)
