#!/usr/bin/env bash
# Delegate to upstream Makefile (same contract as root Makefile).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec make -C "${ROOT}" install "$@"
