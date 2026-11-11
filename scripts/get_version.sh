#!/bin/bash
set -euo pipefail
shopt -s nocasematch

if [[ ${VERSION_FILE:-} == *package.json ]]; then
    VERSION=$(sed -n 's/.*"version"\s*:\s*"\(.*\)".*/\1/p' "$VERSION_FILE")
elif [ -n "${VERSION_FILE:-}" ]; then
    VERSION=$(sed -n 's/.*<[Vv]ersion>\(.*\)<\/[Vv]ersion>.*/\1/p' "$VERSION_FILE")
else
    VERSION=$(sed -n 's/.*AssemblyInformationalVersion("\(.*\)\.{{REV}}.*/\1/p' AssemblyInfo.cs)
fi

echo "version=$VERSION" >> "$GITHUB_OUTPUT"

if [[ "${GITHUB_REF_TYPE:-}" = "tag" && "$GITHUB_REF_NAME" =~ ^v${VERSION}(\.|-RC)([0-9]+)$ ]]; then
    echo "rcnum=${BASH_REMATCH[2]}" >> "$GITHUB_OUTPUT"
    echo "release=${VERSION}.${BASH_REMATCH[2]}" >> "$GITHUB_OUTPUT"
else
    echo "release=${VERSION}.0" >> "$GITHUB_OUTPUT"
fi
