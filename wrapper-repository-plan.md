# Wrapper repository plan: IT self-service agent + Zammad

This document captures the approach for a **wrapper repository** that uses [rh-ai-quickstart/it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent) as its upstream base **without forking**, while owning documentation and how-tos for the **Zammad channel** and ticketing-component installation.

## Goals

- **Upstream stays canonical**: fixes and features land in `it-self-service-agent`; this repo consumes them deliberately.
- **This repo owns the Zammad story**: install order, OpenShift/Zammad wiring, secrets, runbooks, and thin glue upstream does not ship (upstream highlights ServiceNow / `mcp-servers/snow` today).
- **No fork**: dependency + documentation, not a long-lived divergent copy.

## Pinning upstream: options

| Approach | Pros | Cons |
|----------|------|------|
| **Git submodule** (e.g. `it-self-service-agent/` at pinned commit) | Explicit version; reviewers see exact SHA; standard Git | Clone needs `--recurse-submodules`; bumps are explicit commits |
| **Git subtree** | No submodule UX | Merge noise; upstream pulls need discipline |
| **Docs-only + version pin file** | Simplest clone | No local upstream tree; links only |
| **Automation (e.g. Renovate)** | Automated bump PRs | Needs CI and policy |

**Recommendation**: submodule at a fixed path at repo root (e.g. `it-self-service-agent`) for repos that reference paths in scripts or examples.

### Upstream branch policy

- **Track [`dev`](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/dev)** when choosing which upstream commits to submodule-pin (`.gitmodules` sets `branch = dev` for `--remote` hints).
- The wrapper still stores a **fixed SHA** (submodules do not float); bumps follow upstream `dev` after validation. Switch back to `main` or release tags if/when that better matches stable installs.

## Suggested layout

```
.
├── README.md
├── docs/
│   ├── README.md
│   ├── zammad/                 # Zammad layer (see docs in this folder)
│   └── upstream.md
├── .gitmodules
└── it-self-service-agent/      # Submodule → rh-ai-quickstart/it-self-service-agent @ pinned SHA
```

Optional later: **`examples/`**, **`scripts/`** — thin overrides or wrappers around upstream Helm/Ansible only if needed.

**Principles**

- Prefer **linking** to upstream `docs/` / `guides/`; duplicate only Zammad deltas.
- Maintain a **compatibility matrix**: wrapper revision, submodule SHA, OCP/OAI versions, Zammad version.
- Keep **glue thin**: umbrella Helm, Kustomize overlays, or Ansible var files with documented paths into the submodule.

## Implementation phases

### Phase 1 — Skeleton and policy

1. Create the GitHub repository.
2. Add submodule:  
   `git submodule add https://github.com/rh-ai-quickstart/it-self-service-agent.git it-self-service-agent`
3. Document clone/update in `docs/upstream.md`:  
   `git clone --recurse-submodules`; prefer **pinned SHA** bumps via PR over blind `--remote`.
4. Note in contributing guidelines: bump submodule when validating new commits on upstream **`dev`** (still recorded as a SHA in this repo).

**Status:** Done in this repo—submodule at `it-self-service-agent/`, see [docs/upstream.md](docs/upstream.md) and [CONTRIBUTING.md](CONTRIBUTING.md). Create the GitHub remote (or push to `origin`) if not already published.

### Phase 2 — Zammad documentation

1. Map which upstream components apply to the ticketing channel (e.g. dispatcher, helm, ansible, agent services); note ServiceNow-specific vs generic pieces.
2. Author Zammad-specific docs: flows, secrets, Routes, alignment with upstream configuration.
3. Add troubleshooting and minimal smoke tests (e.g. synthetic ticket → observable agent behavior).

**Status:** See [docs/zammad/README.md](docs/zammad/README.md) and [docs/README.md](docs/README.md). Pages **link** into **`it-self-service-agent/`** for canonical procedures (Makefile, Helm); the wrapper avoids duplicating long install guides. Submodule pin: [docs/upstream.md](docs/upstream.md).

### Phase 3 — Automation and maintenance

1. **CI (lightweight)**: submodule present; optional markdown/link checks; optional `UPSTREAM_SHA` in README for audits.
2. Optional: Dependabot/Renovate for submodule update PRs.
3. **Tags**: e.g. `v2026.04.1` with changelog “tested with upstream SHA …”.

### Phase 4 — Glue (only if needed)

1. Add `examples/` and `scripts/` that **call** upstream Helm/Ansible with documented values—still no fork.
2. If upstream cannot absorb required changes: contribute upstream first; avoid a patch fork until necessary.

## Risks

- **Submodule friction**: mitigate with a one-line clone recipe; GitHub renders submodule at a commit (read-only browsing still works).
- **Upstream drift**: document supported upstream range; open issues when assumptions break.
- **Secrets**: placeholders only in examples; point to OpenShift Secrets patterns.

## Success criteria

A new contributor can: clone with submodules, follow one Zammad install path, deploy using pinned examples against a documented upstream SHA, and bump upstream in a single reviewed change with an updated compatibility matrix.

---

*Last updated: 2026-04-17*
