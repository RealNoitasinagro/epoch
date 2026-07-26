#!/bin/bash

# typical uses:
# $GH_Epoch: apk, web, linux, most, (all)
# $GL_Epoch: all, (abisplit)

set -e

cwd=$(pwd)

case "$cwd" in
    "$GH_Epoch")
        unset PUB_CACHE  # just in case...
    ;;
    "$GL_Epoch")
        export PUB_CACHE="$GL_Epoch"/.pub-cache
    ;;
    *)
        echo "Invalid directory! (Run from the right location, and/or check env variables.)";
        exit 1
esac

what=$1  # apk, web, linux, abisplit, most, all
mode=${2:-release};
dryRun=${DRY_RUN:-0}

if [[ ! ( "$what" == "apk" || "$what" == "web" || "$what" == "linux" || "$what" == "abisplit" ||
          "$what" == "most" || "$what" == "all" ) ]] ; then
    echo "Invalid variant '$what' (must be 'apk', 'web', 'linux', 'abisplit', 'most' or 'all')"
    exit 1
fi

if [[ ! ( "$mode" == "release" || "$mode" == "profile" || "$mode" == "debug" ) ]] ; then
   echo "Invalid mode '$mode' (must be 'release', 'profile', 'debug' or remain empty = release)"
   exit 1
fi

case "$what" in
    'apk')
        skipApk=0
        skipWeb=1
        skipLinux=1
        skipSplit=1
    ;;
    'web')
        skipApk=1
        skipWeb=0
        skipLinux=1
        skipSplit=1
    ;;
    'linux')
        skipApk=1
        skipWeb=1
        skipLinux=0
        skipSplit=1
    ;;
    'abisplit')
        skipApk=1
        skipWeb=1
        skipLinux=1
        skipSplit=0
    ;;
    'most')
        skipApk=0
        skipWeb=0
        skipLinux=0
        skipSplit=1
    ;;
    *)  # all
        skipApk=0
        skipWeb=0
        skipLinux=0
        skipSplit=0
    ;;
esac


# +++ CONFIGURATION ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
skipClean=1
skipAnalyze=0
skipTest=0
skipChecksums=0
skipCopy=0
useLogging=1

# flutter_active='/snap/bin/flutter'  # default, installed via snap
flutter_active="$HOME/Android/flutter/bin/flutter"  # installed manually via GH clone
flutter_version=$($flutter_active --version)
latest_timezone_version=$(curl -s "https://pub.dev/api/packages/timezone" | python3 -c "import json,sys; print(json.load(sys.stdin)['latest']['version'])")
installed_timezone_version=$(dart pub deps --json | jq '.packages[] | select(.name=="timezone") | .version')
if [ "$cwd" == "$GL_Epoch" ] ; then
    file_to_check="$PUB_CACHE"/hosted/pub.dev/timezone-"${latest_timezone_version}"/lib/data/latest.dart
else
    file_to_check="$HOME"/.pub-cache/hosted/pub.dev/timezone-"${latest_timezone_version}"/lib/data/latest.dart
fi
if [ -e "$file_to_check" ] ; then
    iana_database=$(grep 'Timezone data version' "$file_to_check" | cut -d':' -f 2 | sed -r 's/^\s+//')
else
    echo "Could not find $file_to_check -- timezone upgrade needed?"
    exit 1;
fi

target_platform_android_arm='app-armeabi-v7a-release.apk'
target_platform_android_arm64='app-arm64-v8a-release.apk'
target_platform_android_x86_64='app-x86_64-release.apk'
target_platform_android_all='app-release.apk'
apk_output_path='build/app/outputs/flutter-apk'
destination_path='/media/linux'
checksum='/usr/bin/sha256sum'
build_timestamp=$(date -u '+%Y%m%d_%H%M%S_%Z')
dir_logs='.logs'
build_all_log="${dir_logs}/build_all_${build_timestamp}.log"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function run_flutter_build {
    local _variant=$1
    local flutter_command="$flutter_active build $_variant --$mode --no-pub"
    if [ "$cwd" == "$GH_Epoch" ] ; then  # no build timestamps in $GL_Epoch
        flutter_command="$flutter_command --dart-define=BUILD_TIMESTAMP=$build_timestamp"
    fi

    echo "# $flutter_command" | tee -a "$build_all_log"
    if [ ! "$dryRun" -eq "1" ] ; then
        $flutter_command
    fi
}


mkdir -p $dir_logs

tee "$build_all_log" << EOF
----
[$build_timestamp] Building $what... (mode = $mode, dryRun = $dryRun)
Flutter: $flutter_active
$flutter_version
installed timezone: $installed_timezone_version | latest: $latest_timezone_version
installed IANA database: $iana_database
Logfile: $build_all_log
Workspace: $cwd
skipClean: $skipClean | skipAnalyze: $skipAnalyze | skipTest: $skipTest | skipApk: $skipApk | skipWeb: $skipWeb | skipLinux: $skipLinux | skipSplit: $skipSplit | skipChecksums: $skipChecksums | skipCopy: $skipCopy | useLogging: $useLogging
----

EOF

echo "# clean"
if [[ ! "$skipClean" -eq "1" || "$cwd" == "$GL_Epoch" ]] ; then
    flutter_command="$flutter_active clean"
    echo "# $flutter_command" | tee -a "$build_all_log"
    $flutter_command
else
    echo "Skipped."
fi
echo

echo "# pub get"
flutter_command="$flutter_active pub get"
echo "# $flutter_command" | tee -a "$build_all_log"
if [ ! "$dryRun" -eq "1" ] ; then
    $flutter_command
fi
echo

echo "# analyze"
if [ ! "$skipAnalyze" -eq "1" ] ; then
    flutter_command="$flutter_active analyze --no-pub"
    echo "# $flutter_command" | tee -a "$build_all_log"
    if [ ! "$dryRun" -eq "1" ] ; then
        $flutter_command
    fi
else
    echo "Skipped."
fi
echo

echo "# test"
if [ ! "$skipTest" -eq "1" ] ; then
    flutter_command="$flutter_active test --no-pub"
    echo "# $flutter_command" | tee -a "$build_all_log"
    if [ ! "$dryRun" -eq "1" ] ; then
        $flutter_command
    fi
else
    echo "Skipped."
fi
echo

echo "# apk"
if [ ! "$skipApk" -eq "1" ] ; then
    run_flutter_build 'apk'
else
    echo "Skipped."
fi
echo

echo "# web"
if [ ! "$skipWeb" -eq "1" ] ; then
    run_flutter_build 'web'
else
    echo "Skipped."
fi
echo

echo "# linux"
if [ ! "$skipLinux" -eq "1" ] ; then
    run_flutter_build 'linux'
else
    echo "Skipped."
fi
echo

echo "# apk (--split-per-abi)"
if [ ! "$skipSplit" -eq "1" ] ; then
    run_flutter_build 'apk --split-per-abi'
else
    echo "Skipped."
fi
echo

echo "+++ All builds done. +++"
echo | tee -a "$build_all_log"

echo "# Calculating $checksum checksums..."
if [[ ! "$skipChecksums" -eq "1" && ! ( "$what" == "web" || "$what" == "linux" ) ]] ; then
    for f in "$apk_output_path"/*.apk ; do
        $checksum "$f" | tee -a "$build_all_log"
    done
else
    echo "Skipped."
fi
echo | tee -a "$build_all_log"

if [[ ! ( "$what" == "web" || "$what" == "linux" ) ]] ; then
    echo "# Listing output files in $apk_output_path..."
    # shellcheck disable=SC2012
    ls -l "$apk_output_path" | tee -a "$build_all_log"
    echo | tee -a "$build_all_log"
fi

if [[ ! "$skipCopy" -eq "1" && ! ( "$what" == "web" || "$what" == "linux" ) ]] ; then
  echo "# Copying output files..."
  # overwrite is fine (mostly), but only if all builds succeed; copy linux bundle manually if needed
  cp -v $apk_output_path/*.apk $destination_path
  echo
fi

if [[ ( "$cwd" == "$GL_Epoch" && "$mode" != "release" && "$dryRun" -eq "0" ) ||
      ( "$cwd" != "$GL_Epoch" && "$what" == "all" && "$dryRun" -eq "0" ) ]] ; then
    tee -a "$build_all_log" << EOF
+++++ <!> WARNING <!> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ Output *.apk files were not built properly for a release, do NOT upload to GitHub!!
+ variants: $what | mode: $mode
+ CWD: $cwd | Releases: $GL_Epoch
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

EOF
fi

if [[ "$cwd" == "$GL_Epoch" && "$what" == "all" && "$mode" == "release" &&
      "$dryRun" -eq "0" && "$skipAnalyze" -eq "0" && "$skipTest" -eq "0" &&
      "$skipChecksums" -eq "0" && "$useLogging" -eq "1" ]] ; then
    rm -v -f $destination_path/*.apk
    cp -v $apk_output_path/${target_platform_android_arm} $destination_path
    cp -v $apk_output_path/${target_platform_android_arm64} $destination_path
    cp -v $apk_output_path/${target_platform_android_x86_64} $destination_path
    cp -v $apk_output_path/${target_platform_android_all} $destination_path
    echo

    tee -a "$build_all_log" << EOF
***** INFO *****************************************************************************************
* Output *.apk files should be good to release, for GitHub and F-Droid.
****************************************************************************************************

EOF
fi

if [ ! "$useLogging" -eq "1" ] ; then
    rm -v -f "$build_all_log"
    echo
fi

exit