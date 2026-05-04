#!/usr/bin/env bash
# Same file set as CI: docs/**, examples/**, repo-root *.md (not submodule / .github).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

# shellcheck disable=SC1091
. "$ROOT/scripts/upstream-doc-urls.lib.sh"

# Read-only: same pin rules as sync-upstream-links (without modifying files).
if ! upstream_doc_validate_sha_lengths; then
  exit 1
fi

SUBMODULE="it-self-service-agent"
if [ -d "$SUBMODULE/.git" ] || [ -f "$SUBMODULE/.git" ]; then
  PIN="$(git -C "$SUBMODULE" rev-parse HEAD)"
  if ! upstream_doc_assert_urls_match_pin "$PIN"; then
    exit 1
  fi
else
  echo "warning: submodule ${SUBMODULE} missing — skipping pin match (clone with --recurse-submodules)." >&2
fi

VERSION="${MARKDOWN_LINK_CHECK_VERSION:-3.10.3}"
CONFIG=".markdown-link-check.json"

if command -v markdown-link-check >/dev/null 2>&1; then
  run_mlc() { markdown-link-check "$@"; }
else
  run_mlc() { npx --yes "markdown-link-check@${VERSION}" "$@"; }
fi

ec=0
while IFS= read -r -d '' f; do
  run_mlc -q -c "$CONFIG" "$f" || ec=1
done < <( (
  find docs examples -name '*.md' -print0
  find . -maxdepth 1 -type f -name '*.md' -print0
) | sort -z )

exit "$ec"
