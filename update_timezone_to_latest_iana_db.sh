#!/usr/bin/env bash
##############################################
### FOR EXPERIMENTAL USE ONLY!!            ###
###                                        ###
### Updates the timezone package's IANA    ###
### database to the latest release without ###
### waiting for a new timezone pub release ###
###                                        ###
### Usage:                                 ###
### ./update_timezone_to_latest_iana_db.sh ###
##############################################
set -euo pipefail

cwd=$(pwd)
timestamp=$(date -u '+%Y%m%d_%H%M%S_%Z')

# Detect installed timezone version via dart pub deps:
installed_timezone_version=$(dart pub deps --json | python3 -c "
import json, sys
deps = json.load(sys.stdin)
print(next(p['version'] for p in deps['packages'] if p['name'] == 'timezone'))
")

echo "Installed timezone version: $installed_timezone_version"

# Determine pub cache location:
# F-Droid builds set PUB_CACHE to project root; otherwise use ~/.pub-cache.
PUBCACHEDIR="${PUB_CACHE:-$HOME/.pub-cache}"
TZPKG="$PUBCACHEDIR/hosted/pub.dev/timezone-${installed_timezone_version}"

if [ ! -d "$TZPKG" ]; then
    echo "Error: timezone package not found at $TZPKG"
    exit 1
fi

# Backup directory:
BAKDIR="$HOME/Temp"
mkdir -p "$BAKDIR"
TZPKG_BAK="$BAKDIR/timezone-${installed_timezone_version}_${timestamp}"

# Save original PUB_CACHE for cleanup:
original_pub_cache="${PUB_CACHE:-}"

# Restore PUB_CACHE and working directory on exit (success or failure):
cleanup() {
    echo "Restoring environment..."
    if [ -z "$original_pub_cache" ]; then
        unset PUB_CACHE
    else
        export PUB_CACHE="$original_pub_cache"
    fi
    cd "$cwd"
}
trap cleanup EXIT

# Remove older backups (glob must be unquoted for expansion):
echo "Removing old backups from $BAKDIR..."
find "$BAKDIR" -maxdepth 1 -name "timezone-${installed_timezone_version}_*" -exec rm -rf {} +

# Back up the current package before modifying it:
echo "Backing up $TZPKG -> $TZPKG_BAK"
cp -r "$TZPKG" "$TZPKG_BAK"

# Work in the backup copy (not the live package):
cd "$TZPKG_BAK"

# Point PUB_CACHE to a temp dir so dart pub get inside refresh.sh
# doesn't try to write to the real cache:
export PUB_CACHE=/tmp/tz-pub-cache-$$  # $$ = PID, avoids collisions
mkdir -p "$PUB_CACHE"

# Run the upstream refresh script to fetch latest IANA data:
echo "Running tool/refresh.sh..."
tool/refresh.sh

# Copy generated files back to the live package:
echo "Copying updated IANA data to $TZPKG..."
cp -v lib/data/* "$TZPKG/lib/data/"
cp -v lib/src/common_locations.dart "$TZPKG/lib/src/"

# Clean up temp pub cache:
rm -rf "$PUB_CACHE"

echo ""
echo "Done. IANA database updated in $TZPKG"
echo "Backup at: $TZPKG_BAK"
echo ""
echo "To restore the original IANA database:"
echo "  rm -rf \"$TZPKG\" && cp -r \"$TZPKG_BAK\" \"$TZPKG\""
echo "  OR "
echo "  rm -rf \"$TZPKG\" && flutter pub get  (re-downloads timezone from pub.dev)"
