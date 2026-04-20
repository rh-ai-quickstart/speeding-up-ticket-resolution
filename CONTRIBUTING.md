# Contributing

## Submodule bumps

- The upstream app lives in **`it-self-service-agent`** at the repo root (submodule → [it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)).
- When moving to a newer upstream revision, **advance the pin from upstream `dev`** (see [Upstream branch policy](docs/README.md#upstream-branch-policy) in [docs/README.md](docs/README.md)); validate locally, then commit the updated submodule pointer.
- Update [docs/upstream.md](docs/upstream.md): **Current pin** and, when applicable, the **Compatibility matrix**.
- Skim [docs/](docs/README.md) and [docs/zammad/](docs/zammad/README.md): if upstream moved Makefile paths or renamed targets, fix **links** (keep procedural detail in the submodule).
- Prefer a single commit that only bumps the submodule (and doc table), with a message like `chore: bump upstream it-self-service-agent`.

## Documentation

- **Repo-wide split** (wrapper vs submodule): **[docs/README.md](docs/README.md)**.
- **Zammad:** **[docs/zammad/README.md](docs/zammad/README.md)** — thin layer; **canonical** procedures live under **`it-self-service-agent/`** (`Makefile`, `helm/`, `guides/`). Add long generic content upstream via PR when possible; here, update links and short deltas when you bump the submodule.

## Automation

- **CI** (`.github/workflows/ci.yml`): confirms recursive submodule checkout and basic repo integrity; Markdown link job is **non-blocking** (`continue-on-error`). Root **`make help`** is exercised after checkout to catch broken glue; **`make check-links`** matches the same link check you can run locally.
- **Dependabot** (`.github/dependabot.yml`): may propose submodule bumps weekly. Merge only after validating upstream and updating [docs/upstream.md](docs/upstream.md).
- **Version tags:** see [docs/releases.md](docs/releases.md).

## Glue (`Makefile`, `scripts/`, `examples/`)

Keep glue **thin**—delegate to **`it-self-service-agent/Makefile`**. When changing root targets or scripts, update [docs/glue.md](docs/glue.md) if the maintainer checklist there needs to change.
