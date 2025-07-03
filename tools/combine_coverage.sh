#!/usr/bin/env bash

escapedPath="$(echo `pwd` | sed 's/\//\\\//g')"

# ignoredPaths=("mystiq_types")

# # shellcheck disable=SC2068
# for ignoredPath in ${ignoredPaths[@]}; do
#   if [[ "$escapedPath" == *"$ignoredPath"* ]]; then
#     exit 0;
#   fi
# done

if grep flutter pubspec.yaml > /dev/null; then
  if [ -d "coverage" ]; then
    # combine line coverage info from package tests to a common file
    if [ ! -d "$MELOS_ROOT_PATH/coverage" ]; then
      mkdir "$MELOS_ROOT_PATH/coverage"
    fi
    sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> "$MELOS_ROOT_PATH/coverage/lcov.info"
    rm -rf "coverage"
  fi
fi
