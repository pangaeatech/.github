set -euo pipefail

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
