#!/bin/bash
set -e
git fetch --tags
TAGS=( $(git tag -l "autobuild-*" | sort -r) )

KEEP_LATEST=12

LATEST_TAGS=()

CUR_MONTH="-1"

for TAG in ${TAGS[@]}; do
    if [[ ${#LATEST_TAGS[@]} -lt ${KEEP_LATEST} ]]; then
        LATEST_TAGS+=( "$TAG" )
    fi
done

for TAG in ${LATEST_TAGS[@]}; do
    TAGS=( "${TAGS[@]/$TAG}" )
done

for TAG in ${TAGS[@]}; do
    echo "Deleting ${TAG}"
    gh release delete --cleanup-tag --yes "${TAG}" || true
done

git push --tags --prune
