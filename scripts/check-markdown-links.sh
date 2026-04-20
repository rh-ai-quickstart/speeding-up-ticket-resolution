#!/usr/bin/env bash
# Same file set as CI: docs/**, examples/**, repo-root *.md (not submodule / .github).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

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
