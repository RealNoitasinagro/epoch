#!/usr/bin/env python3
"""
Generates city names for Epoch's timezone search from a local
clone of unicode-org/cldr-json.

Reads:
  <cldr-json-dir>/cldr-dates-full/main/{de,en}/timeZoneNames.json

Writes:
  lib/models/generated/cldr_exemplar_cities_{de,en}.g.dart

Usage:
  python3 tools/generate_cldr_exemplar_cities.py
  python3 tools/generate_cldr_exemplar_cities.py --cldr-json-dir /other/path
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime, timezone


DEFAULT_OUT_DIR = "lib/models/generated"
DEFAULT_OUT_FILE_DE = "cldr_exemplar_cities_de.g.dart"
DEFAULT_OUT_FILE_EN = "cldr_exemplar_cities_en.g.dart"
DEFAULT_CLDR_JSON_DIR = os.path.expanduser("~/Work/cldr-json/cldr-json")


def _collect_exemplar_cities(node, prefix, out):
    """
    Recursively walks the CLDR zone-name tree. Zone identifiers can be
    nested more than two levels deep (e.g. America/Argentina/Buenos_Aires,
    America/Indiana/Indianapolis).
    """
    for key, value in node.items():
        if not isinstance(value, dict):
            continue
        zone_id = f"{prefix}/{key}" if prefix else key
        exemplar = value.get("exemplarCity")
        if isinstance(exemplar, str):
            out[zone_id] = exemplar
        children = {k: v for k, v in value.items()
                    if isinstance(v, dict) and k not in ("long", "short")}
        if children:
            _collect_exemplar_cities(children, zone_id, out)


def load_cities(cldr_json_dir, locale):
    path = os.path.join(cldr_json_dir, "cldr-dates-full", "main", locale, "timeZoneNames.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    zones = data["main"][locale]["dates"]["timeZoneNames"]["zone"]
    cities = {}
    _collect_exemplar_cities(zones, "", cities)
    return cities


def write_city_names(path, names, locale):
    locale_capitalized = locale.capitalize()
    dart_variable = 'cityNames' + locale_capitalized
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-dates-full, main/" + locale + "/timeZoneNames.json\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_exemplar_cities.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// City names by IANA zone identifier.\n")
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
        names = load_cities(args.cldr_json_dir, locale)
        write_city_names(os.path.join(args.out_dir, out_file), names, locale)
        print(f"{language} city names: {len(names)}")


if __name__ == "__main__":
    main()
