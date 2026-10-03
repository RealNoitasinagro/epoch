#!/usr/bin/env python3
"""
Generates national capital city names (EN + DE) from Wikidata (P36).
Capitals essentially never change -- this is NOT meant to run as part
of the routine IANA/CLDR regeneration cycle, just occasionally.

Writes:
  lib/models/generated/wikidata_capitals_en.g.dart
  lib/models/generated/wikidata_capitals_de.g.dart

Usage:
  python3 tools/generate_wikidata_capitals.py
"""

import json
import os
import sys
import urllib.parse
import urllib.request
from collections import defaultdict
from datetime import datetime, timezone

DEFAULT_OUT_DIR = "lib/models/generated"
WIKIDATA_ENDPOINT = "https://query.wikidata.org/sparql"

QUERY = """
SELECT ?countryCode ?capitalLabelEn ?capitalLabelDe WHERE {
  ?country wdt:P297 ?countryCode;
           wdt:P36 ?capital.
  ?capital rdfs:label ?capitalLabelEn .
  FILTER(LANG(?capitalLabelEn) = "en")
  OPTIONAL {
    ?capital rdfs:label ?capitalLabelDe .
    FILTER(LANG(?capitalLabelDe) = "de")
  }
}
"""


def fetch_capitals():
    url = WIKIDATA_ENDPOINT + "?query=" + urllib.parse.quote(QUERY) + "&format=json"
    request = urllib.request.Request(
        url, headers={"User-Agent": "Epoch-tz-search-tooling/1.0"})
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            data = json.load(response)
    except Exception as e:
        sys.exit(f"Wikidata query failed: {e}")

    capitals_en = defaultdict(list)
    capitals_de = defaultdict(list)
    for row in data["results"]["bindings"]:
        code = row["countryCode"]["value"]
        name_en = row["capitalLabelEn"]["value"]
        if name_en not in capitals_en[code]:
            capitals_en[code].append(name_en)
        if "capitalLabelDe" in row:
            name_de = row["capitalLabelDe"]["value"]
            if name_de not in capitals_de[code]:
                capitals_de[code].append(name_de)
    return capitals_en, capitals_de


def write_capitals(path, capitals, dart_variable):
    with open(path, "w", encoding="utf-8") as f:
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        f.write("// GENERATED FILE -- DO NOT EDIT BY HAND.\n")
        f.write("// Source: Wikidata Query Service (wdt:P36) -- a one-time\n")
        f.write("// query, not part of the routine IANA/CLDR regeneration\n")
        f.write("// cycle (capitals essentially never change).\n")
        f.write("// Regenerate with: python3 tools/generate_wikidata_capitals.py\n")
        f.write(f"// Last generated: {now}\n\n")
        f.write("// National capital city name(s) by ISO 3166-1 alpha-2 code.\n")
        f.write("// A list, not a single value: some countries have more than\n")
        f.write("// one capital (e.g. South Africa).\n")
        f.write(f"const Map<String, List<String>> {dart_variable} = {{\n")
        for code in sorted(capitals):
            items = ", ".join(f"'{_escape(n)}'" for n in capitals[code])
            f.write(f"  '{code}': [{items}],\n")
        f.write("};\n")


def _escape(name):
    return name.replace("'", "\\'")


def main():
    os.makedirs(DEFAULT_OUT_DIR, exist_ok=True)
    capitals_en, capitals_de = fetch_capitals()
    write_capitals(os.path.join(DEFAULT_OUT_DIR, "wikidata_capitals_en.g.dart"),
                    capitals_en, "wikidataCapitalsEn")
    write_capitals(os.path.join(DEFAULT_OUT_DIR, "wikidata_capitals_de.g.dart"),
                    capitals_de, "wikidataCapitalsDe")
    print(f"Countries with EN capital: {len(capitals_en)}")
    print(f"Countries with DE capital: {len(capitals_de)}")


if __name__ == "__main__":
    main()
