#!/bin/bash
set -euo pipefail
shopt -s nocasematch
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

if [[ ${VERSION_FILE:-} == *package.json ]]; then
    VERSION=$(sed -n 's/.*"version"\s*:\s*"\(.*\)".*/\1/p' "$VERSION_FILE")
elif [ -n "${VERSION_FILE:-}" ]; then
    VERSION=$(sed -n 's/.*<[Vv]ersion>\(.*\)<\/[Vv]ersion>.*/\1/p' "$VERSION_FILE")
else
    VERSION=$(sed -n 's/.*AssemblyInformationalVersion("\(.*\)\.{{REV}}.*/\1/p' AssemblyInfo.cs)
fi

OUT="${GITHUB_OUTPUT:-build.env}"
echo "version=$VERSION" >> "$OUT"

if [[ "$COMMIT_TAG" =~ ^v${VERSION}(\.|-RC)([0-9]+)$ ]]; then
    echo "rcnum=${BASH_REMATCH[2]}" >> "$OUT"
    echo "release=${VERSION}.${BASH_REMATCH[2]}" >> "$OUT"
else
    echo "release=${VERSION}.0" >> "$OUT"
fi
