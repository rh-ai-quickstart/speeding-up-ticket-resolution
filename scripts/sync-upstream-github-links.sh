#!/usr/bin/env bash
# Rewrite GitHub URLs that point at rh-ai-quickstart/it-self-service-agent at blob/tree/<sha>
# to use a new full SHA (default: current it-self-service-agent HEAD).
#
# GitHub does not substitute env vars in Markdown; this script is the practical equivalent for bumps.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1
# shellcheck disable=SC1091
. "$ROOT/scripts/upstream-doc-urls.lib.sh"

SUBMODULE="it-self-service-agent"

# Replace blob/tree segments that are not exactly 40 hex (typo, truncated leading digit) with the canonical pin.
repair_malformed_upstream_shas() {
  local new="$1" f
  while IFS= read -r f; do
    [ -n "$f" ] && [ -f "$f" ] || continue
    if grep -qE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{1,39}/' "$f" 2>/dev/null \
      || grep -qE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{41,}/' "$f" 2>/dev/null; then
      SYNC_UPSTREAM_SHA="$new" perl -i -pe \
        's{(rh-ai-quickstart/it-self-service-agent/(?:blob|tree)/)[0-9a-f]{1,39}(/)}{$1.$ENV{SYNC_UPSTREAM_SHA}.$2}eg;
         s{(rh-ai-quickstart/it-self-service-agent/(?:blob|tree)/)[0-9a-f]{41,}(/)}{$1.$ENV{SYNC_UPSTREAM_SHA}.$2}eg' \
        "$f"
      echo "  repaired malformed upstream SHA in $f (using pin below)"
    fi
  done < <(upstream_doc_collect_md)
}

NEW_SHA="${1:-}"
if [ -z "$NEW_SHA" ]; then
  if [ ! -d "$SUBMODULE/.git" ] && [ ! -f "$SUBMODULE/.git" ]; then
    echo "error: pass NEW_SHA as first argument, or initialize submodule: git submodule update --init --recursive" >&2
    exit 1
  fi
  NEW_SHA="$(git -C "$SUBMODULE" rev-parse HEAD)"
fi

if ! printf '%s' "$NEW_SHA" | grep -qxE '[0-9a-f]{40}'; then
  echo "usage: $0 [<40-char-lowercase-hex-sha>]" >&2
  echo "  default: rev-parse HEAD of ${SUBMODULE}/" >&2
  exit 1
fi

repair_malformed_upstream_shas "$NEW_SHA"

if ! upstream_doc_validate_sha_lengths; then
  exit 1
fi

UNIQUE_SHAS=$(upstream_doc_extract_shas_from_urls)
if [ -z "$UNIQUE_SHAS" ]; then
  echo "No GitHub upstream blob/tree URLs found in Markdown — nothing to rewrite."
  exit 0
fi

LINE_COUNT=$(echo "$UNIQUE_SHAS" | sed '/^$/d' | wc -l | tr -d ' ')
if [ "$LINE_COUNT" -gt 1 ]; then
  echo "error: found multiple distinct SHAs in upstream blob/tree URLs:" >&2
  echo "$UNIQUE_SHAS" | sed 's/^/  /' >&2
  echo "Normalize manually, then re-run." >&2
  exit 1
fi

OLD_SHA=$(echo "$UNIQUE_SHAS" | head -1)
if [ "$OLD_SHA" = "$NEW_SHA" ]; then
  echo "Docs already reference ${NEW_SHA} — no changes."
  exit 0
fi

echo "Rewriting upstream GitHub links: ${OLD_SHA} -> ${NEW_SHA}"

sed_inplace() {
  local file="$1"
  if [ "$(uname -s)" = Darwin ]; then
    sed -i '' "$2" "$file"
  else
    sed -i "$2" "$file"
  fi
}

while IFS= read -r f; do
  [ -n "$f" ] && [ -f "$f" ] || continue
  if grep -q "$OLD_SHA" "$f"; then
    sed_inplace "$f" "s/${OLD_SHA}/${NEW_SHA}/g"
    echo "  updated $f"
  fi
done < <(upstream_doc_collect_md)

echo "Done. Review with: git diff -- docs examples '*.md'"
