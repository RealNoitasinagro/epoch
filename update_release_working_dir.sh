#!/usr/bin/env bash
set -euo pipefail

source_branch='main'
source_remote="origin/${source_branch}"

# Make sure $GH_Epoch is on the correct branch, and the working directory is clean:
# shellcheck disable=SC2154
current_branch=$(git -C "$GH_Epoch" branch --show-current)
if git -C "$GH_Epoch" diff --quiet && git -C "$GH_Epoch" diff --cached --quiet; then
    working_dir_status='clean'
else
    working_dir_status='dirty'
fi
if [[ "$current_branch" != "$source_branch" || "$working_dir_status" != "clean" ]] ; then
    echo "Releases should be done from a clean $source_branch branch!";
    echo "(Current branch is $current_branch, status $working_dir_status.)"
    exit 1
fi

git -C "$GH_Epoch" fetch origin --quiet
local_commit=$(git -C "$GH_Epoch" rev-parse "$source_branch")
remote_commit=$(git -C "$GH_Epoch" rev-parse "$source_remote")
if [[ "$local_commit" != "$remote_commit" ]]; then
    echo "Local $source_branch is not in sync with $source_remote – push first!"
    exit 1
fi


# shellcheck disable=SC2154
target="$GL_Epoch"
tmp_bak="/tmp/gl-update-bak-$$"  # PID-Suffix gegen Kollisionen
mkdir -p -v "$tmp_bak"

# Rescue directories that must survive the wipe:
for dir in .logs .pub-cache; do
  if [ -d "$target/$dir" ]; then
    mv -v  "$target/$dir" "$tmp_bak/"
  fi
done

# Clean and recreate target:
rm -rf -v "$target"
mkdir -p -v "$target"

# Export exact HEAD commit (no untracked/modified files):
# shellcheck disable=SC2154
git -C "$GH_Epoch" archive --format=tar HEAD | tar -x -C "$target"

# Record which commit was exported:
{
  git -C "$GH_Epoch" branch --show-current
  git -C "$GH_Epoch" rev-parse HEAD
} > "$target/.git-commit"

# Restore rescued directories:
for dir in .logs .pub-cache; do
  if [ -d "$tmp_bak/$dir" ]; then
    mv -v "$tmp_bak/$dir" "$target/"
  fi
done

# rm -rf "$tmp_bak"

cp -v "$GH_Epoch"/android/key.properties "$GL_Epoch"/android
cp -v "$GH_Epoch"/android/app/upload-keystore.jks "$GL_Epoch"/android/app

echo
echo "Synced $(tail -1 "$target/.git-commit" | cut -c1-8) from $source_branch to $target."
echo

exit 0
