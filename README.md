# Ticket resolution agent (Zammad wrapper)

Documentation and integration notes for running the **Zammad ticketing channel** with **[it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)**. The application source and Helm charts live in the submodule **`it-self-service-agent/`** at a **pinned commit**—not in this repo’s root.

## Clone

```bash
git clone --recurse-submodules https://github.com/<org>/ticket-resolution-agent.git
cd ticket-resolution-agent
```

If you already cloned without submodules: `git submodule update --init --recursive`.

Submodule workflow and compatibility: **[docs/upstream.md](docs/upstream.md)** · **[CONTRIBUTING.md](CONTRIBUTING.md)**

## Documentation

| Topic | Location |
|--------|-----------|
| Wrapper vs upstream split | [docs/README.md](docs/README.md) |
| Submodule bumps / pins | [docs/upstream.md](docs/upstream.md) |
| Zammad channel (thin layer; links into submodule) | [docs/zammad/README.md](docs/zammad/README.md) |

## Deploy

Install and upgrade paths use **`make`** and Helm **inside** the submodule (for example **`make helm-install-ticketing`**). Start at **[docs/zammad/install-openshift.md](docs/zammad/install-openshift.md)** and follow upstream **`it-self-service-agent/Makefile`** as the source of truth.

There is **no** Helm chart published from the root of this repository.

## Repository layout

```
.
├── docs/
│   ├── README.md           # Documentation split (wrapper vs submodule)
│   ├── upstream.md         # Submodule clone, bump, compatibility matrix
│   └── zammad/             # Zammad ticketing notes (links upstream)
├── it-self-service-agent/  # Git submodule — app, Helm charts, Makefile
├── CONTRIBUTING.md
├── wrapper-repository-plan.md
└── README.md
```

## References

- Upstream repository: [rh-ai-quickstart/it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)
