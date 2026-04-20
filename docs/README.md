# Documentation in this repository

This repository is a **thin wrapper** around [rh-ai-quickstart/it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent): upstream stays the **canonical** codebase and charts; here we maintain the **Zammad ticketing channel** story—install ordering, OpenShift/Zammad wiring, secrets, runbooks, and thin glue—not a fork of the application.

## Goals

- **Upstream stays canonical**: fixes and features land in `it-self-service-agent`; this repo consumes them deliberately.
- **This repo owns the Zammad narrative**: integration notes upstream does not center (upstream highlights ServiceNow / `mcp-servers/snow` today).
- **No fork**: dependency via submodule plus documentation, not a long-lived divergent copy.

## Split of responsibility

| Where | What belongs there |
|-------|-------------------|
| **`it-self-service-agent/`** (submodule) | **Canonical** install procedures, Helm values, Makefile targets, guides under `docs/` and `guides/`. This is where generic, detailed content should land long term. |
| **`docs/` here** | **Thin layer**: submodule workflow ([upstream.md](upstream.md)), compatibility pins, and **integration-oriented** notes (e.g. `zammad/`) that point at the submodule instead of copying step-by-step procedures. |

## Pinning upstream

| Approach | Pros | Cons |
|----------|------|------|
| **Git submodule** (e.g. `it-self-service-agent/` at pinned commit) | Explicit version; reviewers see exact SHA; standard Git | Clone needs `--recurse-submodules`; bumps are explicit commits |
| **Git subtree** | No submodule UX | Merge noise; upstream pulls need discipline |
| **Docs-only + version pin file** | Simplest clone | No local upstream tree; links only |
| **Automation (e.g. Renovate)** | Automated bump PRs | Needs CI and policy |

**Recommendation:** submodule at a fixed path at the repo root (`it-self-service-agent`)—matches how we reference paths in glue and docs.

### Upstream branch policy

- **Track [`dev`](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/dev)** when choosing commits to submodule-pin (`.gitmodules` sets `branch = dev` for `--remote` hints).
- This repo stores a **fixed SHA** (submodules do not float); bumps follow upstream `dev` after validation. Use **`main`** or release tags upstream when that better matches stable installs.

## Principles

- Prefer **linking** to upstream `docs/` / `guides/`; duplicate only Zammad deltas here.
- Maintain a **compatibility matrix** (wrapper/submodule SHA, OpenShift/OAI, Zammad) in [upstream.md](upstream.md).
- Keep **glue thin**: root **`Makefile`** and **`examples/`** only delegate or document paths into the submodule ([glue.md](glue.md)).

## Risks

- **Submodule friction**: use the one-line clone recipe on the root [README](../README.md); GitHub renders the submodule at a pinned commit for browsing.
- **Upstream drift**: document supported assumptions; open issues when they break.
- **Secrets**: placeholders only in examples; use OpenShift Secrets patterns in real environments.

## Success criteria

A new contributor can clone with submodules, follow one Zammad install path, deploy against a **documented submodule SHA**, and bump upstream in a single reviewed change with an updated compatibility matrix.

## What's in place

| Area | Where |
|------|--------|
| Submodule clone / bump / **Current pin** | [upstream.md](upstream.md), [CONTRIBUTING.md](../CONTRIBUTING.md) |
| CI (submodule sanity, **`make check-links`**) | [.github/workflows/ci.yml](../.github/workflows/ci.yml) |
| Submodule bump PRs | [.github/dependabot.yml](../.github/dependabot.yml) |
| Tags and release notes | [releases.md](releases.md) |
| Root glue + maintainer checklist | [glue.md](glue.md), root **`Makefile`**, **`examples/`** |

**Directory layout:** see the tree in the root [README](../README.md#repository-layout).

## When something changes upstream

After bumping the submodule ([CONTRIBUTING.md](../CONTRIBUTING.md)), refresh **links and short “delta” paragraphs** in `docs/` if behavior changed. Prefer **opening PRs upstream** for long procedural content so this repo stays pointers + policy.

See [zammad/README.md](zammad/README.md) for how that applies to the ticketing channel.

**Glue at the repo root** (optional convenience only): [glue.md](glue.md).

Releases and tagging this wrapper (with submodule SHA in release notes): [releases.md](releases.md).
