#!/bin/bash

set -e

mode=$1

# flutter_active='/snap/bin/flutter'  # default, installed via snap
flutter_active="$HOME/Android/flutter/bin/flutter";  # installed manually via GH clone
flutter_version=`$flutter_active --version`

apk_output_path='build/app/outputs/flutter-apk/app-release.apk'
destination_path='/media/linux/'

build_timestamp=$(date -u '+%Y%m%d_%H%M%S_%Z')
build_all_log="build_all_$build_timestamp.log"

rm -rf $build_all_log

echo "----"
echo "[$build_timestamp] Building apk, web, linux..."
echo "Flutter: $flutter_active"
echo "----"
echo

echo "# apk"
$flutter_active build apk --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
echo

echo "# web"
$flutter_active build web --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
echo

echo "# linux"
$flutter_active build linux --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
echo

if [ "$mode" == "split" ] ; then
  echo "# apk (--split-per-abi)"
  $flutter_active build apk --release --dart-define=BUILD_TIMESTAMP="$build_timestamp" --split-per-abi
  echo
fi

echo "All builds done."
echo -e "Last full build: $build_timestamp\nFlutter: $flutter_active\nmode: $mode" > $build_all_log
echo -e "Flutter version: $flutter_version" >> $build_all_log
echo

# overwrite is fine (mostly), but only if all builds succeed
cp -v "$apk_output_path" "$destination_path"

exit