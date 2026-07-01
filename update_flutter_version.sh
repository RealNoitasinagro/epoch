#! /bin/bash

timestamp=$(date +"%Y-%m-%d %H:%M:%S %Z")

flutter_version_file='.flutter-version'
gh_workflow_build_android='.github/workflows/build-android.yml'
gh_workflow_deploy_web='.github/workflows/deploy-web.yml'

flutter_version_old=$(grep Flutter $flutter_version_file | cut -d' ' -f 2)

flutter --version > $flutter_version_file
echo -e "\npinned: $timestamp" >> $flutter_version_file

flutter_version_new=$(grep Flutter $flutter_version_file | cut -d' ' -f 2)

sed -i -r "s/flutter-version: '$flutter_version_old'/flutter-version: '$flutter_version_new'/" $gh_workflow_build_android
sed -i -r "s/flutter-version: '$flutter_version_old'/flutter-version: '$flutter_version_new'/" $gh_workflow_deploy_web

exit

