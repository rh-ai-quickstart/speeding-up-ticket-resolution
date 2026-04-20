# Documentation in this repository

## Split of responsibility

| Where | What belongs there |
|-------|-------------------|
| **`it-self-service-agent/`** (submodule) | **Canonical** install procedures, Helm values, Makefile targets, guides under `docs/` and `guides/`. This is where generic, detailed content should land long term. |
| **`docs/` here** | **Thin layer**: submodule workflow ([upstream.md](upstream.md)), compatibility pins, and **integration-oriented** notes (e.g. `zammad/`) that point at the submodule instead of copying step-by-step procedures. |

## When something changes upstream

After bumping the submodule ([CONTRIBUTING.md](../CONTRIBUTING.md)), refresh **links and short “delta” paragraphs** in `docs/` if behavior changed. Prefer **opening PRs upstream** for long procedural content so this repo stays pointers + policy.

See [zammad/README.md](zammad/README.md) for how that applies to the ticketing channel.

Releases and tagging this wrapper (with submodule SHA in release notes): [releases.md](releases.md).
