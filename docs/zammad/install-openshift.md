# Install on OpenShift (ticketing profile)

**Canonical procedure lives in the submodule.** Do not maintain a second full install guide here—follow upstream **`Makefile`** and chart values.

## Before you start

1. Clone this repo **with submodules**: [docs/upstream.md](../../docs/upstream.md).
2. Stay at the **repository root**, or **`cd it-self-service-agent`**—either way you must be on the **pinned** submodule commit (same doc).
3. Set **`NAMESPACE`** for every ticketing `make` target (upstream errors if unset).

```bash
export NAMESPACE=my-ticketing-demo
# Optional if you prefer working inside the submodule:
# cd it-self-service-agent
```

## Primary install path

**Option A — from this repo’s root** (delegates to the same upstream target):

```bash
make install NAMESPACE="${NAMESPACE}"
```

**Option B — inside the submodule** (equivalent):

```bash
make helm-install-ticketing NAMESPACE="${NAMESPACE}"
```

**What to read while it runs:**

- Target implementation and printed checklist: [`Makefile`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/ccc789f9539ea980952c296b91e5744773c8f74b/Makefile) (`helm-install-ticketing`, `_helm-install-ticketing-single`, `_helm-install-ticketing-print-checklist`, `deploy-zammad`).
- Values overlays: [`helm/values-ticketing.yaml`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/ccc789f9539ea980952c296b91e5744773c8f74b/helm/values-ticketing.yaml), [`helm/values-test.yaml`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/ccc789f9539ea980952c296b91e5744773c8f74b/helm/values-test.yaml) (as referenced by that target).
- Zammad deployment stack: [`helm/zammad/`](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/ccc789f9539ea980952c296b91e5744773c8f74b/helm/zammad), [`helm/values-ticketing.yaml`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/ccc789f9539ea980952c296b91e5744773c8f74b/helm/values-ticketing.yaml).

Expect **15+ minutes** on first deploy (Zammad dependencies). Watch pods: `kubectl get pods -n "${NAMESPACE}" -w`.

## Manual or split deploys

If you do not use the one-shot target, you must still satisfy the same ordering and wiring the Makefile encodes (placeholder Secret → main chart with ticketing values → Zammad release → token → restarts). **Use the Makefile as the spec**, not this page.

## Uninstall

From repo root: **`make uninstall NAMESPACE="${NAMESPACE}"`**, or inside **`it-self-service-agent/`**: **`make helm-uninstall NAMESPACE="${NAMESPACE}"`**. Either tears down the main release and Zammad-related resources per the Makefile. Confirm data retention policy before running.
