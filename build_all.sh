#!/bin/bash

set -e

mode=${1:-release};

if [[ ! ( "$mode" == "release" || "$mode" == "profile" || "$mode" == "debug" ) ]] ; then
   echo "Invalid mode '$mode' (must be 'release', 'profile', 'debug' or remain empty = release)"
   exit 1
fi


# +++ CONFIGURATION ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
skipApk=0
skipWeb=1
skipLinux=1
skipSplit=1
skipChecksums=1
skipCopy=1

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
    mode=$1
    variant=$2
    flutter_command="$flutter_active build $variant --$mode"
    if [ "$mode" != "release" ] ; then
        flutter_command="$flutter_command --dart-define=BUILD_TIMESTAMP=$build_timestamp"
    fi
    $flutter_command
}


cwd=$(pwd)
mkdir -p $dir_logs

tee $build_all_log << EOF
----
[$build_timestamp] Building apk, web, linux... (mode = $mode)
Flutter: $flutter_active
$flutter_version
Logfile: $build_all_log
Repo: $cwd
skipApk: $skipApk | skipWeb: $skipWeb | skipLinux: $skipLinux | skipSplit: $skipSplit | skipChecksums: $skipChecksums | skipCopy: $skipCopy
----

EOF

echo "# apk"
if [ ! "$skipApk" -eq "1" ] ; then
    run_flutter $mode 'apk'
else
    echo "Skipped."
fi
echo

echo "# web"
if [ ! "$skipWeb" -eq "1" ] ; then
    run_flutter $mode 'web'
else
    echo "Skipped."
fi
echo

echo "# linux"
if [ ! "$skipLinux" -eq "1" ] ; then
    run_flutter $mode 'linux'
else
    echo "Skipped."
fi
echo

echo "# apk (--split-per-abi)"
if [ ! "$skipSplit" -eq "1" ] ; then
    run_flutter $mode 'apk --split-per-abi'
else
    echo "Skipped."
fi
echo

echo "+++ All builds done. +++"
echo

echo "# Calculating $checksum checksums..."
if [ ! "$skipChecksums" -eq "1" ] ; then
    echo "Repo: $cwd" >> $build_all_log
    for f in $apk_output_path/*.apk ; do
        $checksum $f | tee -a $build_all_log
    done
else
    echo "Skipped."
fi
echo

echo "# Listing output files..."
ls -l $apk_output_path | tee -a $build_all_log
echo

if [ ! "$skipCopy" -eq "1" ] ; then
  echo "# Copying output files..."
  # overwrite is fine (mostly), but only if all builds succeed
  cp -v "$apk_output_path/*.apk" "$destination_path"
  echo
fi

exit