# Contributing

## Submodule bumps

- The upstream app lives in **`it-self-service-agent`** at the repo root (submodule → [it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)).
- When moving to a newer upstream revision, **advance the pin from upstream `dev`** (per [wrapper-repository-plan.md](wrapper-repository-plan.md)); validate locally, then commit the updated submodule pointer.
- Update [docs/upstream.md](docs/upstream.md): **Current pin** and, when applicable, the **Compatibility matrix**.
- Prefer a single commit that only bumps the submodule (and doc table), with a message like `chore: bump upstream it-self-service-agent`.

## Documentation

Zammad-specific installation and channel setup will live under `docs/zammad/` (see plan in [wrapper-repository-plan.md](wrapper-repository-plan.md)). Prefer linking to upstream `docs/` / `guides/` when possible; duplicate only deltas.
