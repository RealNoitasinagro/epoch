"""Shared header for generated Dart files, plus data-version lookup."""
import json
import os
import sys
from datetime import datetime, timezone


def cldr_data_version(cldr_json_dir):
    """E.g. 'CLDR 49.0.0', from cldr-core/package.json."""
    path = os.path.join(cldr_json_dir, "cldr-core", "package.json")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- check --cldr-json-dir")
    with open(path, encoding="utf-8") as f:
        return f"CLDR {json.load(f)['version']}"


def tzdata_data_version(tzdata_source_dir):
    """E.g. 'tzdata 2026e', from the 'version' file of a tzdata release."""
    path = os.path.join(tzdata_source_dir, "version")
    if not os.path.isfile(path):
        sys.exit(f"Not found: {path} -- is this a tzdata source directory?")
    with open(path, encoding="utf-8") as f:
        return f"tzdata {f.read().strip()}"


def write_header(f, source, regenerate_command, data_version):
    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
    f.write(f"// Source: {source}\n")
    f.write(f"// Data version: {data_version}\n")
    f.write(f"// Regenerate with: {regenerate_command}\n")
    f.write(f"// Last generated: {today}\n\n")
