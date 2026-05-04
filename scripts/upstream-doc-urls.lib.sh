# Shared helpers for upstream GitHub URLs in wrapper Markdown (blob/tree pin).
# shellcheck shell=bash
# Sourced from repo root (cd there before sourcing).

upstream_doc_collect_md() {
  find docs examples -name '*.md' -print 2>/dev/null || true
  find . -maxdepth 1 -type f -name '*.md' -print 2>/dev/null || true
}

# Extract 40-hex SHAs from well-formed rh-ai-quickstart/it-self-service-agent/(blob|tree)/… URLs.
upstream_doc_url_sha_pattern='rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{40}'

upstream_doc_extract_shas_from_urls() {
  local f
  while IFS= read -r f; do
    [ -n "$f" ] && [ -f "$f" ] || continue
    grep -ohE "$upstream_doc_url_sha_pattern" "$f" 2>/dev/null | sed 's#.*/##' || true
  done < <(upstream_doc_collect_md) | sort -u | sed '/^$/d'
}

# Malformed length in URL path → GitHub 404; cheap check without HTTP.
upstream_doc_validate_sha_lengths() {
  local f
  local bad=0
  while IFS= read -r f; do
    [ -n "$f" ] && [ -f "$f" ] || continue
    if grep -qE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{1,39}/' "$f" 2>/dev/null; then
      echo "error: $f — upstream URL has a SHA shorter than 40 hex (404 on GitHub)." >&2
      grep -nE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{1,39}/' "$f" >&2 || true
      bad=1
    fi
    if grep -qE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{41,}/' "$f" 2>/dev/null; then
      echo "error: $f — upstream URL has a SHA longer than 40 hex." >&2
      grep -nE 'rh-ai-quickstart/it-self-service-agent/(blob|tree)/[0-9a-f]{41,}/' "$f" >&2 || true
      bad=1
    fi
  done < <(upstream_doc_collect_md)
  return "$bad"
}

# Read-only vet: every upstream blob/tree URL must use exactly the expected submodule pin (single SHA everywhere).
upstream_doc_assert_urls_match_pin() {
  local expect="$1"
  local unique_shas
  local line_count
  local only

  unique_shas=$(upstream_doc_extract_shas_from_urls)
  if [ -z "$unique_shas" ]; then
    return 0
  fi

  line_count=$(echo "$unique_shas" | sed '/^$/d' | wc -l | tr -d ' ')
  if [ "$line_count" -gt 1 ]; then
    echo "error: multiple distinct SHAs in rh-ai-quickstart/it-self-service-agent/(blob|tree)/ URLs:" >&2
    echo "$unique_shas" | sed 's/^/  /' >&2
    echo "  normalize with: make sync-upstream-links" >&2
    return 1
  fi

  only=$(echo "$unique_shas" | head -1)
  if [ "$only" != "$expect" ]; then
    echo "error: docs pin upstream URLs at ${only} but submodule HEAD is ${expect}." >&2
    echo "  run: make sync-upstream-links   (or bump submodule first, then sync)" >&2
    return 1
  fi
  return 0
}
