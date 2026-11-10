set -euo pipefail
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# Builds and pushes every *.dockerfile in the repo root to ghcr.io (requires docker login to ghcr.io first).
# Requires: RELEASE. Needs "packages: write".
ext="${DOCKERFILE_EXT:-dockerfile}"
registry="ghcr.io/${GITHUB_REPOSITORY,,}"

for f in *."$ext"; do
  [ -e "$f" ] || continue  # skip if no files exist

  name="${f%.$ext}"
  echo "Building and uploading $name.$ext"

  docker buildx build \
    --file "$f" \
    --tag "${registry}/${name,,}:${RELEASE}" \
    --tag "${registry}/${name,,}:latest" \
    --push .
done
