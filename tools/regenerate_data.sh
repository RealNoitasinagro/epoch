#!/usr/bin/env bash
# Regenerates lib/models/generated/*.g.dart. Run from the repo root.
#   tools/regenerate_data.sh iana <tzdata-source-dir>   # every IANA release
#   tools/regenerate_data.sh cldr [<cldr-json-dir>]     # every CLDR release
#   tools/regenerate_data.sh rare <tzdata2016a-dir>     # legacy abbreviations, Wikidata capitals
set -euo pipefail

case "${1:-}" in
  iana)
    python3 tools/generate_iana_data.py --tzdata-source-dir "${2:?tzdata source dir}"
    ;;
  cldr)
    dir_args=()
    if [[ -n "${2:-}" ]]; then dir_args=(--cldr-json-dir "$2"); fi
    for script in country_names exemplar_cities metazone_names windows_zone_names; do
      python3 "tools/generate_cldr_${script}.py" "${dir_args[@]}"
    done
    ;;
  rare)
    python3 tools/generate_legacy_abbreviations.py \
        --tzdata-source-dir "${2:?tzdata2016a dir}" --from-year 1970
    python3 tools/generate_wikidata_capitals.py
    ;;
  *) sed -n '2,5p' "$0"; exit 64 ;;
esac

git status --short lib/models/generated
echo "Next: flutter test test/timezone_data_test.dart && dart run tools/explain_tz_search.dart --redundant"
