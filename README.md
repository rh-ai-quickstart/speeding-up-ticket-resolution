# Ticket resolution agent (Zammad wrapper)

Documentation and integration notes for running the **Zammad ticketing channel** with **[it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)**. The application source and Helm charts live in the submodule **`it-self-service-agent/`** at a **pinned commit**—not in this repo’s root.

## Clone

```bash
git clone --recurse-submodules https://github.com/<org>/ticket-resolution-agent.git
cd ticket-resolution-agent
```

If you already cloned without submodules: `git submodule update --init --recursive`.

Submodule workflow and compatibility: **[docs/upstream.md](docs/upstream.md)** · **[CONTRIBUTING.md](CONTRIBUTING.md)**

**Upstream submodule pin:** full SHA is in **[docs/upstream.md#current-pin](docs/upstream.md#current-pin)** — update that table whenever you bump `it-self-service-agent`.

## Documentation

| Topic | Location |
|--------|-----------|
| Wrapper vs upstream split | [docs/README.md](docs/README.md) |
| Submodule bumps / pins | [docs/upstream.md](docs/upstream.md) |
| Zammad channel (thin layer; links into submodule) | [docs/zammad/README.md](docs/zammad/README.md) |
| Tags and release notes (submodule SHA) | [docs/releases.md](docs/releases.md) |
| Glue (Makefile) and maintainer checklist | [docs/glue.md](docs/glue.md) |

## Deploy

Run **`make install NAMESPACE=…`** from the repo root (see [`Makefile`](Makefile)), or **`make helm-install-ticketing`** inside **`it-self-service-agent/`** — same upstream behavior. Procedures and Helm live in the submodule; start at **[docs/zammad/install-openshift.md](docs/zammad/install-openshift.md)**.

There is **no** Helm chart published from the root of this repository.

## Maintenance & CI

- **CI** runs on **pull requests** to **`main`** and **`dev`**: verifies **`it-self-service-agent`** checks out as a submodule (see [.github/workflows/ci.yml](.github/workflows/ci.yml)). A non-blocking job runs **`make check-links`** (same as locally).
- **Dependabot** can open weekly PRs for the submodule (see [.github/dependabot.yml](.github/dependabot.yml)); review against upstream release notes before merging.
- **Tags / releases:** see **[docs/releases.md](docs/releases.md)**.

## Repository layout

```
.
├── Makefile                # Delegates ticketing targets to it-self-service-agent/Makefile
├── .github/
│   ├── dependabot.yml      # Weekly submodule update PRs (optional review)
│   └── workflows/ci.yml    # Submodule presence + Markdown link check
├── docs/
│   ├── README.md           # Documentation split (wrapper vs submodule)
│   ├── glue.md             # Glue + maintainer checklist
│   ├── upstream.md         # Submodule clone, bump, compatibility matrix
│   ├── releases.md         # Tagging notes
│   └── zammad/             # Zammad ticketing notes (links upstream)
├── examples/               # Placeholder notes (no secrets)
├── scripts/                # check-markdown-links.sh — used by make check-links
├── it-self-service-agent/  # Git submodule — app, Helm charts, Makefile
├── CONTRIBUTING.md
└── README.md
```

## References

- Upstream repository: [rh-ai-quickstart/it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)
