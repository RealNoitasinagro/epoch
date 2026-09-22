#!/usr/bin/env python3
"""
Generates German country names for Epoch's timezone search from a local
clone of unicode-org/cldr-json.

Reads:
  <cldr-json-dir>/cldr-localenames-full/main/de/territories.json

Writes:
  lib/models/generated/cldr_country_names_de.g.dart

Usage:
  python3 tools/generate_cldr_country_names.py
  python3 tools/generate_cldr_country_names.py --cldr-json-dir /other/path
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"
DEFAULT_OUT_FILE = "cldr_country_names_de.g.dart"
DEFAULT_CLDR_JSON_DIR = os.path.expanduser("~/Work/cldr-json/cldr-json")
ALPHA2_CODE = re.compile(r"^[A-Z]{2}$")


def load_territories(cldr_json_dir):
    path = os.path.join(cldr_json_dir, "cldr-localenames-full", "main", "de", "territories.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    territories = data["main"]["de"]["localeDisplayNames"]["territories"]
    # Keep only plain ISO 3166-1 alpha-2 codes; drop UN M49 region codes
    # (e.g. "005" for South America) and "-alt-..." display variants:
    return {code: name for code, name in territories.items() if ALPHA2_CODE.match(code)}


def write_country_names_de(path, names):
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-localenames-full, main/de/territories.json\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_country_names.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// German country names by ISO 3166-1 alpha-2 code.\n")
        f.write("const Map<String, String> countryNamesDe = {\n")
        for code in sorted(names):
            escaped = names[code].replace("'", "\\'")
            f.write(f"  '{code}': '{escaped}',\n")
        f.write("};\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cldr-json-dir", default=DEFAULT_CLDR_JSON_DIR,
                         help=f"Path to the cloned unicode-org/cldr-json repo "
                              f"(default: {DEFAULT_CLDR_JSON_DIR})")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR)
    args = parser.parse_args()

    names = load_territories(args.cldr_json_dir)
    os.makedirs(args.out_dir, exist_ok=True)
    write_country_names_de(os.path.join(args.out_dir, DEFAULT_OUT_FILE), names)
    print(f"German country names: {len(names)}")


if __name__ == "__main__":
    main()
