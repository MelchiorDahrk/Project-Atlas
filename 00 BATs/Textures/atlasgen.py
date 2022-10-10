#!/usr/bin/env python3

# Requires python 3.7 or newer

import argparse
import os
import sys
from fractions import Fraction
from subprocess import check_call, check_output
from typing import Optional


def generate_atlas(atlas_file: str, base_width_override: Optional[int]):
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
    # Determine Atlas Size from ratios
    # TODO: Perhaps using the median of the sizes for all textures?
    base_size_file = list(ratios)[0]
    base_ratio = ratios[base_size_file]
    output = check_output(
        ["magick", "convert", base_size_file, "-format", "%w", "info:"],
        encoding="utf-8",
        text=True,
    )
    base_width = base_width_override or int(int(output) / base_ratio)

    # Commands are merged into one magick convert call
    # (requires adding a '-write' before each output)
    # This also allows the use of mpr references between commands
    outputs = []
    combined_commands = []
    for command in commands:
        # TODO: template arithmetic language for specifying custom sizes
        # for use with things like -extent
        # In addition to fractions, it should support multiplication, so you can do things like `3/4 * width`
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
        if output.endswith(".dds"):
            new_command.extend(["-define", "dds:compreession=dxt1"])
        # Make sure parent directories of the output file exist
        if not output.startswith("mpr:"):
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
        if filename.endswith(".bmp"):
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
