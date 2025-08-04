#!/bin/bash
set -e

BASE_REF=$1

CHANGED_FILES=$(git diff --name-only origin/"$BASE_REF"...HEAD)

CHANGED_RELEVANT=$(echo "$CHANGED_FILES" | grep -E '\.dart$|pubspec\.yaml$' || true)

if [ -z "$CHANGED_RELEVANT" ]; then
  echo "NO_CHANGES"
  exit 0
fi

AFFECTED_PATHS=""

# Ensure we're only capturing valid directories with pubspec.yaml
for file in $CHANGED_RELEVANT; do
  dir="$file"
  while [ "$dir" != "." ] && [ "$dir" != "/" ]; do
    if [ -f "$dir/pubspec.yaml" ]; then
      AFFECTED_PATHS="$AFFECTED_PATHS $dir"
      break
    fi
    dir=$(dirname "$dir")
  done
done

# Deduplicate and clean up the paths
AFFECTED_PATHS=$(echo "$AFFECTED_PATHS" | xargs -n1 | sort -u | xargs)

if [ -z "$AFFECTED_PATHS" ]; then
  echo "NO_CHANGES"
  exit 0
fi

echo "$AFFECTED_PATHS"
