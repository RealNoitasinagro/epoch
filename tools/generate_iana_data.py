#!/usr/bin/env python3
"""
Generates Dart data files for Epoch's timezone search from an extracted
IANA tzdata *source* distribution (not the compiled /usr/share/zoneinfo
binaries -- see note below on why).

Get the source distribution, e.g.:
  curl -O https://data.iana.org/time-zones/releases/tzdata2026d.tar.gz
  mkdir tzdata2026d && tar xzf tzdata2026d.tar.gz -C tzdata2026d

Reads, from <tzdata-source-dir>:
  - zone1970.tab                       (zone <-> country-code mapping)
  - iso3166.tab                        (country code -> English name)
  - africa, antarctica, asia, australasia, backward, etcetera, europe,
    factory, northamerica, southamerica
    (source files containing "Zone" and "Link" directives -- parsed
    directly to classify canonical zones vs. Link aliases)

Writes (relative to --out-dir, default: lib/models/generated):
  - zone1970_countries.g.dart
  - iso3166_country_names_en.g.dart
  - iana_canonical_zones_snapshot.g.dart
  - iana_links_snapshot.g.dart

Usage:
  python3 tools/generate_iana_data.py --tzdata-source-dir /path/to/tzdata2026d

Regenerate this data whenever the tzdata source is updated (e.g. after an
IANA release bump), then review the resulting git diff before committing
-- especially additions/removals in the canonical-zones and links
snapshots.

WHY THE SOURCE, NOT /usr/share/zoneinfo:
"Canonical zone" vs. "Link" is a distinction made in the tzdata SOURCE
via explicit "Zone" and "Link" directives. How a given OS/distro then
*compiles* that source into /usr/share/zoneinfo is an independent
packaging decision -- some distros represent a Link as a filesystem
symlink, others as a full copy of the target's compiled binary (e.g.
observed on Ubuntu, for compatibility with environments that mishandle
symlinks). Classifying canonical-vs-link by symlink-or-not therefore
reflects packaging, not the actual tzdata Zone/Link distinction, and
was found to misclassify entries (e.g. "Europe/Amsterdam" appearing as
"canonical" when it is a Link in the source). Parsing the source
directly avoids this.

CAVEAT (first draft, not yet validated end-to-end):
DEFAULT_SOURCE_FILES below matches what a "typical" default build
compiles (excludes backzone/systemv, which many distros omit by
default). If the resulting canonical count doesn't match what the
`timezone` Dart package actually loads at runtime, the most likely fix
is adjusting this file list to match how the target distro's tzdata was
actually compiled -- compare against `tz.timeZoneDatabase.locations
.length` (with the "all" dataset loaded) and adjust accordingly.
"""

import argparse
import os
import re
import sys
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"

# Source files parsed for Zone/Link directives. Deliberately excludes
# "backzone" (zones retired from the primary data, only compiled in with
# an explicit zic flag) and "systemv" (POSIX-style names, also excluded
# from most default builds) -- see CAVEAT above.
DEFAULT_SOURCE_FILES = [
    "africa", "antarctica", "asia", "australasia", "backward",
    "etcetera", "europe", "factory", "northamerica", "southamerica",
]

ZONE_LINE_RE = re.compile(r"^Zone\s+(\S+)")
LINK_LINE_RE = re.compile(r"^Link\s+(\S+)\s+(\S+)")
CONTINUATION_RE = re.compile(r"^[ \t]")


def strip_comment(line):
    # '#' starts a comment running to end of line; the tzdata source
    # format has no quoting that would make a literal '#' meaningful.
    idx = line.find("#")
    return line if idx == -1 else line[:idx]


def parse_tzdata_source_file(path, canonical, links):
    """
    Parses one tzdata source file for "Zone NAME ..." and
    "Link TARGET LINKNAME" directives, adding to the shared
    `canonical` set and `links` dict (link_id -> target_id).
    """
    with open(path, encoding="utf-8") as f:
        in_zone_block = False
        for raw_line in f:
            line = strip_comment(raw_line).rstrip("\n")
            if not line.strip():
                continue

            zone_match = ZONE_LINE_RE.match(line)
            if zone_match:
                canonical.add(zone_match.group(1))
                in_zone_block = True
                continue

            link_match = LINK_LINE_RE.match(line)
            if link_match:
                target, link_name = link_match.group(1), link_match.group(2)
                links[link_name] = target
                in_zone_block = False
                continue

            if in_zone_block and CONTINUATION_RE.match(raw_line):
                # Continuation line of a multi-line Zone block (rule
                # changes over time) -- the zone itself is already
                # recorded via the initial "Zone" line.
                continue

            in_zone_block = False


def parse_zone1970_countries(path):
    """Returns {zone_id: [country_code, ...]} from zone1970.tab."""
    result = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if not line or line.startswith("#"):
                continue
            fields = line.split("\t")
            if len(fields) < 3:
                continue
            codes = fields[0].split(",")
            zone_id = fields[2]
            result[zone_id] = codes
    return result


def parse_iso3166_names(path):
    """Returns {country_code: english_name} from iso3166.tab."""
    result = {}
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if not line or line.startswith("#"):
                continue
            code, name = line.split("\t", 1)
            result[code] = name
    return result


def dart_string_list(items):
    return "[" + ", ".join(f"'{item}'" for item in items) + "]"


def write_generated_header(f, source_description):
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
    f.write(f"// Source: {source_description}\n")
    f.write("// Regenerate with: python3 tools/generate_iana_data.py\n")
    f.write(f"// Last generated: {now}\n\n")


def write_zone_countries(path, zone_countries):
    with open(path, "w", encoding="utf-8") as f:
        write_generated_header(f, "zone1970.tab")
        f.write("// Maps an IANA zone identifier to the ISO 3166-1 country\n")
        f.write("// code(s) that use it, as assigned by zone1970.tab.\n")
        f.write("const Map<String, List<String>> zoneCountryCodes = {\n")
        for zone_id in sorted(zone_countries):
            f.write(f"  '{zone_id}': {dart_string_list(zone_countries[zone_id])},\n")
        f.write("};\n")


def write_country_names_en(path, names):
    with open(path, "w", encoding="utf-8") as f:
        write_generated_header(f, "iso3166.tab")
        f.write("// English country names by ISO 3166-1 alpha-2 code.\n")
        f.write("const Map<String, String> countryNamesEn = {\n")
        for code in sorted(names):
            escaped = names[code].replace("'", "\\'")
            f.write(f"  '{code}': '{escaped}',\n")
        f.write("};\n")


def write_canonical_snapshot(path, canonical_ids):
    with open(path, "w", encoding="utf-8") as f:
        write_generated_header(f, "tzdata source Zone directives (" + ", ".join(DEFAULT_SOURCE_FILES) + ")")
        f.write("// Snapshot of canonical IANA zone identifiers at\n")
        f.write("// generation time. Compared against the live tz package\n")
        f.write("// data in tests to detect additions/removals across IANA\n")
        f.write("// database bumps. A diff here is a prompt to review and\n")
        f.write("// regenerate -- it does not by itself mean anything is\n")
        f.write("// broken (additions are normal; removals would be very\n")
        f.write("// unusual and deserve closer attention).\n")
        f.write("const List<String> ianaCanonicalZonesSnapshot = [\n")
        for zone_id in sorted(canonical_ids):
            f.write(f"  '{zone_id}',\n")
        f.write("];\n")


def write_links_snapshot(path, links):
    with open(path, "w", encoding="utf-8") as f:
        write_generated_header(f, "tzdata source Link directives (" + ", ".join(DEFAULT_SOURCE_FILES) + ")")
        f.write("// Maps a deprecated/alias IANA zone identifier (an IANA\n")
        f.write("// \"Link\" directive in the tzdata source) to the\n")
        f.write("// canonical identifier it resolves to. A Link is\n")
        f.write("// guaranteed by tzdata to share identical time-transition\n")
        f.write("// history with its target -- there is no historical\n")
        f.write("// accuracy lost by treating them as equivalent for\n")
        f.write("// search/display purposes.\n")
        f.write("const Map<String, String> ianaLinksSnapshot = {\n")
        for link_id in sorted(links):
            f.write(f"  '{link_id}': '{links[link_id]}',\n")
        f.write("};\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                      formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--tzdata-source-dir", required=True,
                         help="Path to an extracted tzdata SOURCE distribution "
                              "(e.g. from tzdata2026d.tar.gz) -- not /usr/share/zoneinfo")
    parser.add_argument("--out-dir", default=DEFAULT_OUT_DIR)
    parser.add_argument("--source-files", nargs="*", default=DEFAULT_SOURCE_FILES,
                         help="Which source files to parse for Zone/Link directives "
                              "(default matches a typical build; adjust if your "
                              "canonical count doesn't match the Dart package's)")
    args = parser.parse_args()

    zone1970_path = os.path.join(args.tzdata_source_dir, "zone1970.tab")
    iso3166_path = os.path.join(args.tzdata_source_dir, "iso3166.tab")

    if not os.path.isfile(zone1970_path) or not os.path.isfile(iso3166_path):
        sys.exit(f"Expected zone1970.tab and iso3166.tab under {args.tzdata_source_dir}")

    canonical_ids = set()
    links = {}
    for filename in args.source_files:
        path = os.path.join(args.tzdata_source_dir, filename)
        if not os.path.isfile(path):
            print(f"Warning: source file not found, skipping: {path}", file=sys.stderr)
            continue
        parse_tzdata_source_file(path, canonical_ids, links)

    zone_countries = parse_zone1970_countries(zone1970_path)
    country_names = parse_iso3166_names(iso3166_path)

    os.makedirs(args.out_dir, exist_ok=True)

    write_zone_countries(
        os.path.join(args.out_dir, "zone1970_countries.g.dart"), zone_countries)
    write_country_names_en(
        os.path.join(args.out_dir, "iso3166_country_names_en.g.dart"), country_names)
    write_canonical_snapshot(
        os.path.join(args.out_dir, "iana_canonical_zones_snapshot.g.dart"), canonical_ids)
    write_links_snapshot(
        os.path.join(args.out_dir, "iana_links_snapshot.g.dart"), links)

    print(f"Canonical zones: {len(canonical_ids)}")
    print(f"Links: {len(links)}")
    print(f"Zones with country data: {len(zone_countries)}")
    print(f"Countries: {len(country_names)}")


if __name__ == "__main__":
    main()
