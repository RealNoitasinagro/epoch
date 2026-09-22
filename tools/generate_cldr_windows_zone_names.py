#!/usr/bin/env python3
"""
Generates Windows-style time zone display names for Epoch's timezone
search from a local clone of unicode-org/cldr-json.

Reads:
  <cldr-json-dir>/cldr-core/supplemental/windowsZones.json

Writes:
  lib/models/generated/cldr_windows_zone_names.g.dart

Usage:
  python3 tools/generate_cldr_windows_zone_names.py
"""

import argparse
import json
import os
import sys
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"
DEFAULT_CLDR_JSON_DIR = os.path.expanduser("~/Work/cldr-json/cldr-json")

# Only territory="001" (the global default) is used: it gives exactly
# one Windows display name per IANA zone. windowsZones.json also has
# many territory-specific override entries which would otherwise add
# noise/duplicates for little benefit here.
GLOBAL_TERRITORY = "001"


def load_windows_zone_names(cldr_json_dir):
    path = os.path.join(cldr_json_dir, "cldr-core", "supplemental", "windowsZones.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        data = json.load(f)

    try:
        entries = data["supplemental"]["windowsZones"]["mapTimezones"]
    except KeyError as e:
        sys.exit(f"Unexpected structure in {path}: missing {e}. "
                 f"Top-level keys found: {sorted(data.keys())}")

    result = {}
    for entry in entries:
        m = entry["mapZone"]
        if m["_territory"] != GLOBAL_TERRITORY:
            continue
        windows_name = m["_other"]
        for zone_id in m["_type"].split():
            result.setdefault(zone_id, []).append(windows_name)
    return result


def write_windows_zone_names(path, names):
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: unicode-org/cldr-json, cldr-core, "
                "supplemental/windowsZones.json (territory=001)\n")
        f.write("// Regenerate with: python3 tools/generate_cldr_windows_zone_names.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// Windows-style time zone display name(s) by IANA zone\n")
        f.write("// identifier (English only -- CLDR's Windows mapping has\n")
        f.write("// no per-locale names).\n")
        f.write("const Map<String, List<String>> windowsZoneNames = {\n")
        for zone_id in sorted(names):
            items = ", ".join(f"'{n}'" for n in names[zone_id])
            f.write(f"  '{zone_id}': [{items}],\n")
        f.write("};\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cldr-json-dir", default=DEFAULT_CLDR_JSON_DIR,
                         help=f"Path to the cloned unicode-org/cldr-json repo "
                              f"(default: {DEFAULT_CLDR_JSON_DIR})")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR)
    args = parser.parse_args()

    names = load_windows_zone_names(args.cldr_json_dir)
    os.makedirs(args.out_dir, exist_ok=True)
    write_windows_zone_names(
        os.path.join(args.out_dir, "cldr_windows_zone_names.g.dart"), names)
    print(f"Zones with a Windows display name: {len(names)}")


if __name__ == "__main__":
    main()
