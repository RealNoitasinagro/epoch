#!/usr/bin/env bash
# fastlane/build_info.sh
# Generates .build_info.env for --dart-define-from-file, consumed by the
# F-Droid build recipe (metadata/io.github.RealEarthling.epoch.yml).
set -euo pipefail

repo_status=$(git rev-parse --short HEAD)

timezone_version=$("$FLUTTER_BIN/dart" pub deps --json | python3 -c "
import json, sys
deps = json.load(sys.stdin)
print(next(p['version'] for p in deps['packages'] if p['name'] == 'timezone'))
")

iana_version=$(grep 'Timezone data version' \
    "$PUB_CACHE/hosted/pub.dev/timezone-${timezone_version}/lib/data/latest.dart" \
    | cut -d':' -f 2 | sed -r 's/^\s+//')

echo "BUILD_INFO=Repo: $repo_status | timezone: $timezone_version | IANA db: $iana_version" > .build_info.env
