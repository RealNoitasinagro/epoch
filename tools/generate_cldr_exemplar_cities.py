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
from generated_header import write_header, cldr_data_version

DEFAULT_OUT_DIR = "lib/models/generated"
DEFAULT_OUT_FILE_CITIES_DE = "cldr_exemplar_cities_de.g.dart"
DEFAULT_OUT_FILE_CITIES_EN = "cldr_exemplar_cities_en.g.dart"
DEFAULT_OUT_FILE_ZONE_LONG_DE = "cldr_zone_long_names_de.g.dart"
DEFAULT_OUT_FILE_ZONE_LONG_EN = "cldr_zone_long_names_en.g.dart"
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


def _collect_zone_names(node, prefix, cities, long_names):
    for key, value in node.items():
        if not isinstance(value, dict):
            continue
        zone_id = f"{prefix}/{key}" if prefix else key
        exemplar = value.get("exemplarCity")
        if isinstance(exemplar, str):
            cities[zone_id] = exemplar
        long_block = value.get("long")
        if isinstance(long_block, dict):
            variants = {k: long_block.get(k) for k in ("generic", "standard", "daylight")}
            if any(variants.values()):
                long_names[zone_id] = variants
        children = {k: v for k, v in value.items()
                    if isinstance(v, dict) and k not in ("long", "short")}
        if children:
            _collect_zone_names(children, zone_id, cities, long_names)


def _get_zones(cldr_json_dir, locale):
    path = os.path.join(cldr_json_dir, "cldr-dates-full", "main", locale, "timeZoneNames.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)
    zones = data["main"][locale]["dates"]["timeZoneNames"]["zone"]
    return zones


def load_cities(cldr_json_dir, locale):
    zones = _get_zones(cldr_json_dir, locale)
    cities = {}
    _collect_exemplar_cities(zones, "", cities)
    return cities


def load_zones(cldr_json_dir, locale, cities):
    zones = _get_zones(cldr_json_dir, locale)
    zone_names = {}
    _collect_zone_names(zones, "", cities, zone_names)
    return zone_names


def write_city_names(path, names, locale, data_version):
    locale_capitalized = locale.capitalize()
    dart_variable = 'cldrCityNames' + locale_capitalized
    with open(path, "w", encoding="utf-8") as f:
        source_description=f"unicode-org/cldr-json, cldr-dates-full, main/{locale}/timeZoneNames.json"
        write_header(f, f"{source_description}",
                     "python3 tools/generate_cldr_exemplar_cities.py", data_version)
        f.write("// City names by IANA zone identifier.\n")
        f.write(f"const Map<String, String> {dart_variable}" + " = {\n")
        for code in sorted(names):
            escaped = names[code].replace("'", "\\'")
            f.write(f"  '{code}': '{escaped}',\n")
        f.write("};\n")


def write_metazone_names(path, names, locale, data_version):
    locale_capitalized = locale.capitalize()
    dart_variable = 'cldrZoneLongNames' + locale_capitalized
    with open(path, "w", encoding="utf-8") as f:
        source_description=f"unicode-org/cldr-json, cldr-dates-full, main/{locale}/timeZoneNames.json (metazone/long)"
        write_header(f, f"{source_description}",
                     "python3 tools/generate_cldr_exemplar_cities.py", data_version)
        f.write("// Localized long generic/standard/daylight names by IANA\n")
        f.write("// zone identifier. Any of the three may be null if CLDR\n")
        f.write("// has no name for that variant in this locale.\n")
        f.write("const Map<String, ({String? generic, String? standard, String? daylight})> "
                f"{dart_variable} = {{\n")
        for mz_id in sorted(names):
            n = names[mz_id]

            def q(v):
                return f"'{v.replace(chr(39), chr(92) + chr(39))}'" if v else "null"

            f.write(f"  '{mz_id}': "
                    f"(generic: {q(n['generic'])}, standard: {q(n['standard'])}, "
                    f"daylight: {q(n['daylight'])}),\n")
        f.write("};\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cldr-json-dir", default=DEFAULT_CLDR_JSON_DIR,
                         help=f"Path to the cloned unicode-org/cldr-json repo "
                              f"(default: {DEFAULT_CLDR_JSON_DIR})")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR)
    args = parser.parse_args()

    data_version = cldr_data_version(args.cldr_json_dir)
    os.makedirs(args.out_dir, exist_ok=True)
    for locale in ("de", "en"):
        language = "German" if locale == "de" else "English"
        out_file_cities = DEFAULT_OUT_FILE_CITIES_DE if locale == "de" else DEFAULT_OUT_FILE_CITIES_EN
        cities = load_cities(args.cldr_json_dir, locale)
        write_city_names(os.path.join(args.out_dir, out_file_cities), cities, locale, data_version)
        print(f"{language} city names: {len(cities)}")
        out_file_zone_names = DEFAULT_OUT_FILE_ZONE_LONG_DE if locale == "de" else DEFAULT_OUT_FILE_ZONE_LONG_EN
        zone_names = load_zones(args.cldr_json_dir, locale, cities)
        write_metazone_names(os.path.join(args.out_dir, out_file_zone_names), zone_names, locale, data_version)
        print(f"{language} zone names: {len(zone_names)}")


if __name__ == "__main__":
    main()
