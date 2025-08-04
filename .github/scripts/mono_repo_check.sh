#!/bin/bash
error=false;

dartPackages=$(find . -name "pubspec.yaml");

analysisFiles=$(find ./*/* -name "analysis_options.yaml");
for analysisFile in $analysisFiles
do
  if [ -e "$analysisFile" ]; then
    echo "$analysisFile shouldn't exist in mono repo dart packages" 1>&2;
    error=true;
  fi
done

# Check for .github to be available only on root folder
# shellcheck disable=SC2046
if [ $(find . -name ".github" -type d | wc -l) != 1 ]; then
  echo ".github can only be allowed at root package." 1>&2;
  error=true;
fi

if $error; then
  echo "Job Failed"
  exit 1
fi
