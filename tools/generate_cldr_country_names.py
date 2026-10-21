#!/usr/bin/env python3
"""
Generates German country names for Epoch's timezone search from a local
clone of unicode-org/cldr-json.

Reads:
  <cldr-json-dir>/cldr-localenames-full/main/{de,en}/territories.json

Writes:
  lib/models/generated/cldr_country_names_de.g.dart
  lib/models/generated/cldr_country_names_en.g.dart

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
DEFAULT_OUT_FILE_DE = "cldr_country_names_de.g.dart"
DEFAULT_OUT_FILE_EN = "cldr_country_names_en.g.dart"
DEFAULT_CLDR_JSON_DIR = os.path.expanduser("~/Work/cldr-json/cldr-json")
ALPHA2_CODE = re.compile(r"^[A-Z]{2}$")


def load_territories(cldr_json_dir, locale):
    path = os.path.join(cldr_json_dir, "cldr-localenames-full", "main", locale, "territories.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    territories = data["main"][locale]["localeDisplayNames"]["territories"]
    # Keep only plain ISO 3166-1 alpha-2 codes; drop UN M49 region codes
    # (e.g. "005" for South America) and "-alt-..." display variants:
    return {code: name for code, name in territories.items() if ALPHA2_CODE.match(code)}


def write_country_names_de(path, names, locale):
    locale_capitalized = locale.capitalize()
    dart_variable = 'cldrCountryNames' + locale_capitalized
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-localenames-full, main/" + locale + "/territories.json\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_country_names.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// Country names by ISO 3166-1 alpha-2 code.\n")
        f.write(f"const Map<String, String> {dart_variable}" + " = {\n")
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

    os.makedirs(args.out_dir, exist_ok=True)
    for locale in ("de", "en"):
        language = "German" if locale == "de" else "English"
        out_file = DEFAULT_OUT_FILE_DE if locale == "de" else DEFAULT_OUT_FILE_EN
        names = load_territories(args.cldr_json_dir, locale)
        write_country_names_de(os.path.join(args.out_dir, out_file), names, locale)
        print(f"{language} country names: {len(names)}")


if __name__ == "__main__":
    main()
