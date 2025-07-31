#!/bin/bash -ex

GITDATE="`git show -s --date=short --format='%ad' | sed 's/-//g'`"
GITREV="`git show -s --format='%h'`"
REV_NAME="citra-${OS}-${TARGET}-${GITDATE}-${GITREV}"

# Find out what release we are building
if [[ "$GITHUB_REF_NAME" =~ ^canary- ]] || [[ "$GITHUB_REF_NAME" =~ ^nightly- ]]; then
    RELEASE_NAME=$(echo $GITHUB_REF_NAME | cut -d- -f1)
else
    RELEASE_NAME=head
fi

mkdir -p artifacts
mkdir "$REV_NAME"
mv build/bundle/* "$RELEASE_NAME"
7z a "$REV_NAME.7z" $RELEASE_NAME
mv "$REV_NAME.7z" artifacts/