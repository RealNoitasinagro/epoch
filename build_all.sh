#!/bin/bash

set -e

cwd=$(pwd)

case $cwd in
    $GH_Epoch)
        unset PUB_CACHE  # just in case...
    ;;
    $GL_Epoch)
        export PUB_CACHE=$GL_Epoch/.pub-cache
    ;;
    *)
        echo "Invalid directory!!";
        exit 1
esac

what=$1  # apk, web, linux, abisplit, most, all, fdroid
mode=${2:-release};
dryRun=${DRY_RUN:-0}

if [[ ! ( "$what" == "apk" || "$what" == "web" || "$what" == "linux" || "$what" == "abisplit" ||
          "$what" == "most" || "$what" == "all" || "$what" == "fdroid" ) ]] ; then
    echo "Invalid variant '$what' (must be 'apk', 'web', 'linux', 'abisplit', 'most', 'all' or 'fdroid')"
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
    *)  # all or fdroid
        skipApk=0
        skipWeb=0
        skipLinux=0
        skipSplit=0
    ;;
esac


# +++ CONFIGURATION ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
skipChecksums=0
skipCopy=1
useLogging=1

# flutter_active='/snap/bin/flutter'  # default, installed via snap
flutter_active="$HOME/Android/flutter/bin/flutter";  # installed manually via GH clone
flutter_version=`$flutter_active --version`

apk_output_path='build/app/outputs/flutter-apk'
destination_path='/media/linux/'
checksum='/usr/bin/sha256sum'
build_timestamp=$(date -u '+%Y%m%d_%H%M%S_%Z')
dir_logs='.logs'
build_all_log="${dir_logs}/build_all_${build_timestamp}.log"
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function run_flutter {
    local _variant=$1
    local flutter_command="$flutter_active build $_variant --$mode"
    if [ "$what" != "fdroid" ] ; then
        flutter_command="$flutter_command --dart-define=BUILD_TIMESTAMP=$build_timestamp"
    fi

    if [ "$dryRun" -eq "1" ] ; then
        echo "$flutter_command"  # dry-run
    else
        $flutter_command
    fi
}


mkdir -p $dir_logs

tee $build_all_log << EOF
----
[$build_timestamp] Building $what... (mode = $mode, dryRun = $dryRun)
Flutter: $flutter_active
$flutter_version
Logfile: $build_all_log
Repo: $cwd
skipApk: $skipApk | skipWeb: $skipWeb | skipLinux: $skipLinux | skipSplit: $skipSplit | skipChecksums: $skipChecksums | skipCopy: $skipCopy | useLogging: $useLogging
----

EOF

echo "# apk"
if [ ! "$skipApk" -eq "1" ] ; then
    run_flutter 'apk'
else
    echo "Skipped."
fi
echo

echo "# web"
if [ ! "$skipWeb" -eq "1" ] ; then
    run_flutter 'web'
else
    echo "Skipped."
fi
echo

echo "# linux"
if [ ! "$skipLinux" -eq "1" ] ; then
    run_flutter 'linux'
else
    echo "Skipped."
fi
echo

echo "# apk (--split-per-abi)"
if [ ! "$skipSplit" -eq "1" ] ; then
    run_flutter 'apk --split-per-abi'
else
    echo "Skipped."
fi
echo

echo "+++ All builds done. +++"
echo

echo "# Calculating $checksum checksums..."
if [ ! "$skipChecksums" -eq "1" ] ; then
    for f in $apk_output_path/*.apk ; do
        $checksum $f | tee -a $build_all_log
    done
else
    echo "Skipped."
fi
echo | tee -a $build_all_log

echo "# Listing output files..."
ls -l $apk_output_path | tee -a $build_all_log
echo | tee -a $build_all_log

if [ ! "$skipCopy" -eq "1" ] ; then
  echo "# Copying output files..."
  # overwrite is fine (mostly), but only if all builds succeed
  cp -v $apk_output_path/*.apk $destination_path
  echo
fi

if [[ ( "$cwd" == "$GL_Epoch" && "$mode" != "release" && "$dryRun" -eq "0" ) ||
      ( "$cwd" != "$GL_Epoch" && "$what" == "fdroid" && "$dryRun" -eq "0" ) ]] ; then
    tee -a $build_all_log << EOF
+++++ <!> WARNING <!> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+ Output *.apk files were not built properly for a release, do NOT upload to GitHub!!"
+ variants: $what | mode: $mode
+ CWD: $cwd | Releases: $GL_Epoch"
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

EOF
fi

if [[ "$cwd" == "$GL_Epoch" && "$what" == "fdroid" && "$mode" == "release" &&
      "$dryRun" -eq "0" && "$skipChecksums" -eq "0" && "$useLogging" -eq "1" ]] ; then
    tee -a $build_all_log << EOF
***** INFO *****************************************************************************************
* Output *.apk files should be good to release, for GitHub and F-Droid.
****************************************************************************************************

EOF
fi

if [ ! "$useLogging" -eq "1" ] ; then
    rm -v -f $build_all_log
    echo
fi

exit