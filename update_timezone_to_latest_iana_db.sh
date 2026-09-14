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

# Grab the IANA version *currently* in the live package, before touching it:
current_iana_in_pkg=$(grep 'Timezone data version' "$TZPKG/lib/data/latest.dart" 2>/dev/null | cut -d':' -f 2 | sed -r 's/^\s+//' || echo "unknown")
echo "Installed IANA db version: $current_iana_in_pkg"

# Two SEPARATE directories: one untouched backup (never written to after
# creation), one disposable working copy that tool/refresh.sh is allowed
# to modify however it likes:
TZPKG_BAK="$BAKDIR/timezone-${installed_timezone_version}_iana-${current_iana_in_pkg}_${timestamp}"
TZPKG_WORK="/tmp/tz-work-${installed_timezone_version}-$$"

# Save original PUB_CACHE for cleanup:
original_pub_cache="${PUB_CACHE:-}"

# Restore PUB_CACHE and working directory on exit (success or failure),
# and always remove the disposable working copy:
cleanup() {
    echo "Restoring environment..."
    if [ -z "$original_pub_cache" ]; then
        unset PUB_CACHE
    else
        export PUB_CACHE="$original_pub_cache"
    fi
    cd "$cwd"
    rm -rf "$TZPKG_WORK"
}
trap cleanup EXIT

# Remove old backups (only prune ones older than 30 days, never the one
# we're about to create):
echo "Removing old backups from $BAKDIR..."
find "$BAKDIR" -maxdepth 1 -name "timezone-*" -mtime +30 -exec rm -rf {} +

# Create the untouched backup first, from the still-pristine live package:
echo "Backing up $TZPKG -> $TZPKG_BAK"
cp -r "$TZPKG" "$TZPKG_BAK"

# Create a SEPARATE disposable working copy for refresh.sh to run in –
# never the backup itself, so the backup stays pristine no matter what
# refresh.sh does internally:
echo "Creating disposable working copy at $TZPKG_WORK"
cp -r "$TZPKG" "$TZPKG_WORK"
cd "$TZPKG_WORK"

# Point PUB_CACHE to a temp dir so dart pub get inside refresh.sh
# doesn't try to write to the real cache:
export PUB_CACHE=/tmp/tz-pub-cache-$$  # $$ = PID, avoids collisions
mkdir -p "$PUB_CACHE"

# Run the upstream refresh script to fetch latest IANA data:
echo "Running tool/refresh.sh..."
tool/refresh.sh

# Copy generated files from the working copy back to the live package:
echo "Copying updated IANA data to $TZPKG..."
cp -v lib/data/* "$TZPKG/lib/data/"
cp -v lib/src/common_locations.dart "$TZPKG/lib/src/"

echo ""
echo "Done. IANA database updated in $TZPKG"
echo "Backup (untouched, pristine) at: $TZPKG_BAK"
echo ""
echo "To restore the original IANA database:"
echo "  rm -rf \"$TZPKG\" && cp -r \"$TZPKG_BAK\" \"$TZPKG\""
echo "  OR "
echo "  rm -rf \"$TZPKG\" && flutter pub get  (re-downloads timezone from pub.dev)"
