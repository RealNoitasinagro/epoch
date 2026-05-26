#!/bin/bash

set -e

mode=$1

skipApk=0
skipWeb=0
skipLinux=0
skipSplit=1
skipChecksums=0
skipCopy=0

# flutter_active='/snap/bin/flutter'  # default, installed via snap
flutter_active="$HOME/Android/flutter/bin/flutter";  # installed manually via GH clone
flutter_version=`$flutter_active --version`

apk_output_path='build/app/outputs/flutter-apk'
apk_universal='app-release.apk'
destination_path='/media/linux/'
checksum='/usr/bin/md5sum'
build_timestamp=$(date -u '+%Y%m%d_%H%M%S_%Z')
dir_logs='.logs'
build_all_log="${dir_logs}/build_all_${build_timestamp}.log"


mkdir -p $dir_logs

echo "----"
echo "[$build_timestamp] Building apk, web, linux..."
echo "Flutter: $flutter_active"
echo "Logfile: $build_all_log"
echo "----"
echo

echo "# apk"
if [ ! "$skipApk" -eq "1" ] ; then
    $flutter_active build apk --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
else
    echo "Skipped."
fi
echo

echo "# web"
if [ ! "$skipWeb" -eq "1" ] ; then
    $flutter_active build web --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
else
    echo "Skipped."
fi
echo

echo "# linux"
if [ ! "$skipLinux" -eq "1" ] ; then
    $flutter_active build linux --release --dart-define=BUILD_TIMESTAMP="$build_timestamp"
else
    echo "Skipped."
fi
echo

if [[ ! "$skipSplit" -eq "1" || "$mode" == "split" ]] ; then
    echo "# apk (--split-per-abi)"
    $flutter_active build apk --release --dart-define=BUILD_TIMESTAMP="$build_timestamp" --split-per-abi
    echo
fi

echo "+++ All builds done. +++"
echo -e "Last full build: $build_timestamp\nFlutter: $flutter_active\nmode: $mode" > $build_all_log
echo -e "Flutter version: $flutter_version" >> $build_all_log
echo >> $build_all_log
echo

echo "# Calculating $checksum checksums..."
if [ ! "$skipChecksums" -eq "1" ] ; then
    for f in $apk_output_path/*.apk ; do
        $checksum $f | tee -a $build_all_log
    done
else
    echo "Skipped."
fi
echo

if [ ! "$skipCopy" -eq "1" ] ; then
  echo "# Copying $apk_universal..."
  # overwrite is fine (mostly), but only if all builds succeed
  cp -v "$apk_output_path/$apk_universal" "$destination_path"
  echo
fi

exit