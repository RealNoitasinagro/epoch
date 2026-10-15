#!/usr/bin/env python3
"""
Generates the alphabetic time zone abbreviations that tzdata used before
2016b (ART, BRST, ICT, ...) from an old tzdata SOURCE release (2016a).

tzdata has used numeric abbreviations ("+03") for new zones since 2016b,
so these names no longer appear in any current source. Users still type
them, so we recover them from the last release that had them.

How: compile the old data with the system's zic, then ask Python's
zoneinfo for the abbreviation in effect on the 15th of every month
between --from-year and --to-year. Only plain alphabetic names are kept
(numeric ones like "+0530" are skipped).

Reads (from --tzdata-source-dir, e.g. $WORK/tzdata/tzdata2016a):
  africa antarctica asia australasia backward etcetera europe factory
  northamerica southamerica

Writes (to --out-dir, default lib/models/generated):
  legacy_abbreviations.g.dart

Usage:
  python3 tools/generate_legacy_abbreviations.py \
      --tzdata-source-dir /path/to/tzdata2016a [--show-collisions]
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zoneinfo
from collections import defaultdict
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"
SOURCE_FILES = [
    "africa", "antarctica", "asia", "australasia", "backward",
    "etcetera", "europe", "factory", "northamerica", "southamerica",
]
ZONE_RE = re.compile(r"^Zone\s+(\S+)")
# Letters only; "ChST" has a lowercase t, so mixed case is allowed.
ABBREVIATION_RE = re.compile(r"^[A-Za-z]{2,6}$")


def find_zic(explicit):
    for candidate in (explicit, shutil.which("zic"), "/usr/sbin/zic"):
        if candidate and os.path.isfile(candidate):
            return candidate
    sys.exit("zic not found -- pass --zic /path/to/zic")


def existing_source_files(source_dir):
    paths = []
    for name in SOURCE_FILES:
        path = os.path.join(source_dir, name)
        if os.path.isfile(path):
            paths.append(path)
        else:
            print(f"Warning: source file not found, skipping: {path}", file=sys.stderr)
    return paths


def zone_ids_from_source(paths):
    ids = []
    for path in paths:
        with open(path, encoding="utf-8") as f:
            for line in f:
                match = ZONE_RE.match(line)
                if match:
                    ids.append(match.group(1))
    return ids


def compile_zones(zic, paths, out_dir):
    result = None
    # "-b fat" exists in zic >= 2019b; retry without it for older builds.
    for extra in (["-b", "fat"], []):
        result = subprocess.run([zic, "-d", out_dir, *extra, *paths],
                                capture_output=True, text=True)
        if result.returncode == 0:
            return
    sys.exit(f"zic failed:\n{result.stderr}")


def collect_abbreviations(zone_ids, compiled_dir, first_year, last_year):
    zoneinfo.reset_tzpath(to=[os.path.abspath(compiled_dir)])
    zoneinfo.ZoneInfo.clear_cache()
    result = {}
    for zone_id in zone_ids:
        try:
            tz = zoneinfo.ZoneInfo(zone_id)
        except (zoneinfo.ZoneInfoNotFoundError, ValueError):
            print(f"Warning: not compiled: {zone_id}", file=sys.stderr)
            continue
        found = set()
        for year in range(first_year, last_year + 1):
            for month in range(1, 13):
                name = datetime(year, month, 15, 12, tzinfo=tz).tzname()
                if name and ABBREVIATION_RE.match(name):
                    found.add(name)
        if found:
            result[zone_id] = sorted(found)
    return result


def write_output(path, abbreviations, first_year, last_year):
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    with open(path, "w", encoding="utf-8") as f:
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: tzdata 2016a (last release with alphabetic "
                "abbreviations), compiled with zic.\n")
        f.write(f"// Sampled monthly, {first_year}-{last_year}.\n")
        f.write("// Regenerate with: python3 tools/generate_legacy_abbreviations.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// Zone identifiers are the ones from 2016a: many are links today.\n")
        f.write("// Not gated by DST: these are historical names users may still type.\n")
        f.write("const Map<String, List<String>> legacyAbbreviationsByZone = {\n")
        for zone_id in sorted(abbreviations):
            items = ", ".join(f"'{a}'" for a in abbreviations[zone_id])
            f.write(f"  '{zone_id}': [{items}],\n")
        f.write("};\n")


def main():
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--tzdata-source-dir", required=True,
                        help="Extracted tzdata2016a source directory")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR)
    parser.add_argument("--zic", default=None)
    parser.add_argument("--from-year", type=int, default=1970)
    parser.add_argument("--to-year", type=int, default=2016)
    parser.add_argument("--show-collisions", action="store_true",
                        help="List abbreviations used by more than one zone")
    args = parser.parse_args()

    zic = find_zic(args.zic)
    paths = existing_source_files(args.tzdata_source_dir)
    if not paths:
        sys.exit(f"No source files found in {args.tzdata_source_dir}")
    zone_ids = zone_ids_from_source(paths)

    with tempfile.TemporaryDirectory() as compiled_dir:
        compile_zones(zic, paths, compiled_dir)
        abbreviations = collect_abbreviations(
            zone_ids, compiled_dir, args.from_year, args.to_year)

    os.makedirs(args.out_dir, exist_ok=True)
    write_output(os.path.join(args.out_dir, "legacy_abbreviations.g.dart"),
                 abbreviations, args.from_year, args.to_year)

    zones_by_abbreviation = defaultdict(list)
    for zone_id, names in abbreviations.items():
        for name in names:
            zones_by_abbreviation[name].append(zone_id)
    shared = {a: z for a, z in zones_by_abbreviation.items() if len(z) > 1}

    print(f"Zones with legacy abbreviations: {len(abbreviations)} of {len(zone_ids)}")
    print(f"Distinct abbreviations: {len(zones_by_abbreviation)}")
    print(f"Abbreviations shared by several zones: {len(shared)}")
    if args.show_collisions:
        for name, zones in sorted(shared.items(), key=lambda kv: -len(kv[1])):
            print(f"  {name}: {len(zones)} zones")


if __name__ == "__main__":
    main()
