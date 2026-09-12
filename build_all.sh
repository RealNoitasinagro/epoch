#!/bin/bash

# typical uses:
# $GH_Epoch: apk, web, linux, most, (all)
# $GL_Epoch: all, (abisplit)

set -e

cwd=$(pwd)

case "$cwd" in
    "$GH_Epoch")
        unset PUB_CACHE  # just in case... default: $HOME/.pub-cache
    ;;
    "$GL_Epoch")
        export PUB_CACHE="${GL_Epoch}/.pub-cache"
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
useOffline=0
skipClean=1
skipAnalyze=0
skipTest=0
skipChecksums=0
skipCopy=0
useLogging=1

# flutter_active='/snap/bin/flutter'  # default, installed via snap
flutter_active="$HOME/Android/flutter/bin/flutter"  # installed manually via GH clone
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

timezone_url='https://pub.dev/api/packages/timezone'
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


flutter_version=$($flutter_active --version)

installed_timezone_version=$(dart pub deps --json | python3 -c "import json,sys; deps=json.load(sys.stdin); print(next(p['version'] for p in deps['packages'] if p['name']=='timezone'))")

if [ "$useOffline" -eq "1" ] ; then
    latest_timezone_version='???'
    timezone_latest_dart="${PUB_CACHE:-$HOME/.pub-cache}"/hosted/pub.dev/timezone-"${installed_timezone_version}"/lib/data/latest.dart
else
    latest_timezone_version=$(curl -s "$timezone_url" | python3 -c "import json,sys; print(json.load(sys.stdin)['latest']['version'])")
    timezone_latest_dart="${PUB_CACHE:-$HOME/.pub-cache}"/hosted/pub.dev/timezone-"${latest_timezone_version}"/lib/data/latest.dart
fi

if [ -e "$timezone_latest_dart" ] ; then
    installed_iana_database=$(grep 'Timezone data version' "$timezone_latest_dart" | cut -d':' -f 2 | sed -r 's/^\s+//')
else
    echo "Could not find $timezone_latest_dart -- timezone package upgrade needed!"
    echo "(installed: $installed_timezone_version, latest: $latest_timezone_version)"
    exit 1;
fi

if [ "$cwd" == "$GL_Epoch" ] ; then
    repo_status=''
else
    repo_status=$(printf '%s @ %s %s\n' "$(git branch --show-current)" "$(git rev-parse --short HEAD)" "$(test -z "$(git status --porcelain)" && echo '' || echo '(dirty)')")
fi


function run_flutter_build {
    local -a variant=("$@")
    local flutter_command_build=(
      "$flutter_active"
      build
      "${variant[@]}"
      --"$mode"
      --no-pub
    )

    if [ "$cwd" == "$GL_Epoch" ] ; then
        build_info=$(printf '%s | %s | %s' "Repo: $repo_status" "timezone: $installed_timezone_version" "IANA db: $installed_iana_database")
        # flutter_command_build+=("--dart-define=BUILD_INFO=$build_info")  # would require metadata update + MR
    elif [ "$cwd" == "$GH_Epoch" ] ; then
        build_info=$(printf '%s | %s | %s | %s' "Build: $build_timestamp" "Repo: $repo_status" "timezone: $installed_timezone_version" "IANA db: $installed_iana_database")
        flutter_command_build+=("--dart-define=BUILD_INFO=$build_info")
    fi

    echo '#' "${flutter_command_build[@]}" | tee -a "$build_all_log"
    if [ ! "$dryRun" -eq "1" ] ; then
        "${flutter_command_build[@]}"
    fi
}


mkdir -p $dir_logs

tee "$build_all_log" << EOF
----
[$build_timestamp] Building $what... (mode = $mode, dryRun = $dryRun)
Flutter: $flutter_active
$flutter_version
Installed timezone: $installed_timezone_version | latest: $latest_timezone_version
Installed IANA database: $installed_iana_database
Logfile: $build_all_log
Workspace: $cwd | $repo_status
useOffline : $useOffline | skipClean: $skipClean | skipAnalyze: $skipAnalyze | skipTest: $skipTest | skipApk: $skipApk | skipWeb: $skipWeb | skipLinux: $skipLinux | skipSplit: $skipSplit | skipChecksums: $skipChecksums | skipCopy: $skipCopy | useLogging: $useLogging
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
if [ ! "$useOffline" -eq "1" ]; then
    flutter_command="$flutter_active pub get --enforce-lockfile"
    echo "# $flutter_command" | tee -a "$build_all_log"
    if [ ! "$dryRun" -eq "1" ] ; then
        $flutter_command
    fi
else
    echo "Skipped."
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
    run_flutter_build 'apk' '--split-per-abi'
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

if [[ ( "$cwd" == "$GL_Epoch" && "$dryRun" -eq "0" && ("$mode" != "release" || ! -e "${GL_Epoch}/.git-commit") ) ||
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
      "$skipChecksums" -eq "0" && "$useLogging" -eq "1" && -e "${GL_Epoch}/.git-commit" ]] ; then
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
