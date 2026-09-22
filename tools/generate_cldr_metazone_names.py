#!/usr/bin/env python3
"""
Generates metazone data for Epoch's timezone search from a local clone
of unicode-org/cldr-json: which IANA zone belongs to which CLDR
"metazone" (a group of zones sharing the same historical rules), plus
the localized generic/standard/daylight display names per metazone.

NOTE: the exact JSON structure of metaZones.json is assumed from memory
and not fully verified -- if this script exits with an "Unexpected
structure" error, it prints the available keys at that point; share
those and we'll adjust the script together.

IMPORTANT: metazone membership alone does NOT tell you whether a given
zone currently observes DST (e.g. Africa/Algiers and Africa/Tunis share
a metazone with Europe/Berlin, but no longer observe DST themselves).
Do not blindly attach a metazone's "daylight" name to every zone in
that metazone -- gate it on that zone's own currently-computed hasDst
(offsetWinter != offsetSummer), the same way countryNames/
exemplarCityNames are computed getters rather than static per-entry
data. See project notes on the Africa/Tunis case.

Reads:
  <cldr-json-dir>/cldr-core/supplemental/metaZones.json
  <cldr-json-dir>/cldr-dates-full/main/{de,en}/timeZoneNames.json

Writes:
  lib/models/generated/cldr_zone_metazone.g.dart
  lib/models/generated/cldr_metazone_names_en.g.dart
  lib/models/generated/cldr_metazone_names_de.g.dart

Usage:
  python3 tools/generate_cldr_metazone_names.py
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"
DEFAULT_CLDR_JSON_DIR = os.path.expanduser("~/Work/cldr-json/cldr-json")


def _require(d, key, context_path):
    if key not in d:
        sys.exit(f"Expected key '{key}' not found while parsing {context_path}.\n"
                  f"Available keys at this level: {sorted(d.keys())}\n")
    return d[key]


def _collect_zone_metazones(node, prefix, out):
    """
    Recursively walks the CLDR metazoneInfo.timezone tree (same
    Area/Location/... nesting as the exemplarCity tree). A "leaf" is
    identified by having child values that themselves contain a
    "usesMetazone" key (the ordinal-indexed historical assignments,
    e.g. {"0": {"usesMetazone": {...}}, "1": {...}}).
    """
def _collect_zone_metazones(node, prefix, out):
    """
    Recursively walks the CLDR metazoneInfo.timezone tree. A leaf is a
    JSON array of (possibly historical) {"usesMetazone": {...}} entries;
    anything else (a dict) is a further path segment (continent, or a
    sub-region like America/Argentina) to recurse into.
    """
    for key, value in node.items():
        zone_id = f"{prefix}/{key}" if prefix else key

        if isinstance(value, list):
            current = None
            for entry in value:
                uses = entry.get("usesMetazone", {})
                if "_to" not in uses:
                    current = uses.get("_mzone")
            if current is None and value:
                # all entries had an "_to" -- fall back to the last one:
                current = value[-1].get("usesMetazone", {}).get("_mzone")
            if current:
                out[zone_id] = current
            continue

        if isinstance(value, dict):
            _collect_zone_metazones(value, zone_id, out)


def load_zone_metazones(cldr_json_dir):
    """Returns {iana_zone_id: metazone_id} -- current assignment only."""
    path = os.path.join(cldr_json_dir, "cldr-core", "supplemental", "metaZones.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)

    supplemental = _require(data, "supplemental", path)
    meta_zones = _require(supplemental, "metaZones", "supplemental")
    metazone_info = _require(meta_zones, "metazoneInfo", "supplemental.metaZones")
    timezone_entries = _require(metazone_info, "timezone", "supplemental.metaZones.metazoneInfo")

    result = {}
    _collect_zone_metazones(timezone_entries, "", result)
    return result


def load_metazone_names(cldr_json_dir, locale):
    """Returns {metazone_id: {'generic': ..., 'standard': ..., 'daylight': ...}}."""
    path = os.path.join(cldr_json_dir, "cldr-dates-full", "main", locale, "timeZoneNames.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)

    main = _require(data, "main", path)
    locale_data = _require(main, locale, "main")
    dates = _require(locale_data, "dates", f"main.{locale}")
    tz_names = _require(dates, "timeZoneNames", f"main.{locale}.dates")
    metazones = _require(tz_names, "metazone", f"main.{locale}.dates.timeZoneNames")

    result = {}
    for mz_id, mz_data in metazones.items():
        long_names = mz_data.get("long", {})
        result[mz_id] = {
            "generic": long_names.get("generic"),
            "standard": long_names.get("standard"),
            "daylight": long_names.get("daylight"),
        }
    return result


def write_zone_metazone(path, zone_metazones):
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-core, "
                "supplemental/metaZones.json\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_metazone_names.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// Current CLDR metazone assignment by IANA zone identifier.\n")
        f.write("const Map<String, String> zoneMetaZone = {\n")
        for zone_id in sorted(zone_metazones):
            f.write(f"  '{zone_id}': '{zone_metazones[zone_id]}',\n")
        f.write("};\n")


def write_metazone_names(path, names, locale):
    dart_variable = "metazoneNamesEn" if locale == "en" else "metazoneNamesDe"
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-dates-full, "
                f"main/{locale}/timeZoneNames.json (metazone/long)\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_metazone_names.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// Localized long generic/standard/daylight names by CLDR\n")
        f.write("// metazone identifier. Any of the three may be null if CLDR\n")
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

    os.makedirs(args.out_dir, exist_ok=True)

    zone_metazones = load_zone_metazones(args.cldr_json_dir)
    write_zone_metazone(
        os.path.join(args.out_dir, "cldr_zone_metazone.g.dart"), zone_metazones)
    print(f"Zones with a metazone assignment: {len(zone_metazones)}")

    for locale in ("en", "de"):
        names = load_metazone_names(args.cldr_json_dir, locale)
        out_file = f"cldr_metazone_names_{locale}.g.dart"
        write_metazone_names(os.path.join(args.out_dir, out_file), names, locale)
        print(f"Metazones with {locale} names: {len(names)}")


if __name__ == "__main__":
    main()
