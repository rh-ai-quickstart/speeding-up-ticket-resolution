# Glue and maintainer checklist

This document describes **wrapper glue** (root `Makefile`, `scripts/`, `examples/`) and what **maintainers should verify** when bumps, CI, or releases change. Upstream behavior stays authoritative under **`it-self-service-agent/`**.

## Glue plan

**Goal:** Operators can run installs from the **repository root** without memorizing paths, while **install logic remains** in [it-self-service-agent/Makefile](../it-self-service-agent/Makefile).

| Artifact | Role |
|----------|------|
| **Root `Makefile`** | Delegates to the submodule with `make -C it-self-service-agent …`. Same targets, same variables (`NAMESPACE`, optional upstream vars). |
| **`scripts/`** | Optional POSIX sh wrappers that call the root Makefile or submodule Makefile—convenience for automation that prefers a script entrypoint. |
| **`examples/`** | Documentation and **non-secret** placeholders only (env var names, namespace reminders). No credentials; values overrides belong as references into submodule paths. |

**Rules**

- Do **not** duplicate Helm ordering or Zammad wiring at the wrapper root; link to [docs/zammad/install-openshift.md](zammad/install-openshift.md) and upstream `Makefile`.
- When upstream renames targets, update **delegating** targets and docs here—keep changes small.

## Maintainer checklist

Use these checks when reviewing **submodule bumps**, **Dependabot PRs**, or **release tags**.

### 1. Submodule pin (source of truth)

| Check | Where |
|--------|--------|
| Recorded SHA matches the commit you tested | [docs/upstream.md#current-pin](upstream.md#current-pin) **Current pin** row |
| Git index matches docs | `git submodule status` → compare to table |
| Compatibility matrix updated if you validated OCP/Zammad | [docs/upstream.md](upstream.md) matrix |

### 2. Automation (CI + bots)

| Check | Where |
|--------|--------|
| Submodule checks out and `Makefile` exists | [.github/workflows/ci.yml](../.github/workflows/ci.yml) `verify-submodule` |
| Docs/links not badly broken | **`make check-links`** in CI (`markdown-links` job, non-blocking)—same script as locally |
| Dependabot proposed bump | [.github/dependabot.yml](../.github/dependabot.yml)—merge only after manual validation and doc updates |

### 3. Glue sanity (after changing Makefile/scripts)

| Check | Command / expectation |
|--------|------------------------|
| Help runs without submodule commands that need `NAMESPACE` | `make help` |
| Delegation is a straight pass-through | Root targets only `make -C it-self-service-agent …` with the same target names upstream documents |
| Scripts are thin | `scripts/*.sh` should only set/clear env and `exec make` or `make -C` |

### 4. Releases (optional snapshot)

| Check | Where |
|--------|--------|
| Tag message names upstream SHA | [docs/releases.md](releases.md) |

### Reviewer shortcut (PR that bumps submodule)

1. `git submodule status` matches **Current pin** in `docs/upstream.md`.
2. Links in `docs/` still resolve (spot-check or wait for CI link job).
3. If root `Makefile`/`scripts/` changed: `make help` and targeted `make -n` smoke if available.

---

*See also: [README.md](../README.md) repository layout · Zammad path: [docs/zammad/install-openshift.md](zammad/install-openshift.md).*
