# Upstream submodule (`it-self-service-agent`)

This repo vendors [rh-ai-quickstart/it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent) at **`it-self-service-agent/`** (repository root). On disk that is the submodule checkout; on **GitHub** the parent repo only stores a submodule pointer—so wrapper docs link to upstream as **`https://github.com/rh-ai-quickstart/it-self-service-agent/tree/<Pinned commit>/…`** (files use **`blob`** instead of **`tree`**). The Git tree records a **pinned commit SHA**; it does not float with upstream `dev` until someone bumps the submodule intentionally.

## Clone this repository

Always clone with submodules so `it-self-service-agent` is populated:

```bash
git clone --recurse-submodules https://github.com/<org>/<this-repo>.git
cd <this-repo>
```

If you already cloned without submodules:

```bash
git submodule update --init --recursive
```

## Current pin

| Field | Value |
|--------|--------|
| Submodule path | `it-self-service-agent` |
| Remote | `https://github.com/rh-ai-quickstart/it-self-service-agent.git` |
| Branch policy | Advance pins from upstream **`dev`** (see [CONTRIBUTING.md](../CONTRIBUTING.md)) |
| Pinned commit | `0b5f37bfe00b7710cfe1076cde3071467477d989` (update this row when you bump) |

## Bump the submodule (maintainers)

After validating new commits on upstream **`dev`**:

```bash
cd it-self-service-agent
git fetch origin
git checkout dev
git pull origin dev
cd ..
git add it-self-service-agent
git commit -m "chore: bump upstream it-self-service-agent to $(git -C it-self-service-agent rev-parse --short HEAD)"
```

Do **not** rely on blind `git submodule update --remote` without reviewing upstream changes and updating docs or the compatibility table below.

Then run **`make sync-upstream-links`** from the repo root. That script finds the full SHA already embedded in upstream **`blob`/`tree`** URLs in Markdown, and replaces it with **`it-self-service-agent`’s current `HEAD`** in every `docs/`, `examples/`, and repo-root `*.md` file that contained the old value (including **Pinned commit** and the compatibility table below). Pass a specific 40-character SHA as the only argument if you must override `HEAD`. GitHub cannot substitute env vars or templates in Markdown—this command is the supported maintenance shortcut.

Review **`git diff`** before committing.

## Compatibility matrix (fill in over time)

| Wrapper / doc revision | Submodule SHA | OpenShift / OAI (tested) | Zammad (tested) |
|------------------------|-----------------|---------------------------|-----------------|
| Current (upstream **`dev`**) | `0b5f37bfe00b7710cfe1076cde3071467477d989` | — | — |
