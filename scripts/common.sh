# Shared GitHub Actions environment helpers. Source this file from other scripts.
# Provides the values formerly supplied by GitLab CI predefined variables.

PROJECT_NAME="${GITHUB_REPOSITORY#*/}"
if [ -n "${GITHUB_EVENT_PATH:-}" ] && [ -f "$GITHUB_EVENT_PATH" ]; then
  FULL_SHA="$(jq -r '.pull_request.head.sha // empty' "$GITHUB_EVENT_PATH")"
fi
FULL_SHA="${FULL_SHA:-${GITHUB_SHA:-}}"
SHORT_SHA="${FULL_SHA:0:7}"
COMMIT_TAG=""
if [ "${GITHUB_REF_TYPE:-}" = "tag" ]; then
  COMMIT_TAG="$GITHUB_REF_NAME"
fi
