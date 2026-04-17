# Install on OpenShift (ticketing profile)

**Canonical procedure lives in the submodule.** Do not maintain a second full install guide here—follow upstream **`Makefile`** and chart values.

## Before you start

1. Clone this repo **with submodules**: [docs/upstream.md](../../docs/upstream.md).
2. Work from **`it-self-service-agent/`** at the pinned commit (same doc).
3. Set **`NAMESPACE`** for every upstream `make` target that requires it (upstream errors if unset).

```bash
cd it-self-service-agent
export NAMESPACE=my-ticketing-demo
```

## Primary install path

Run upstream **one-shot ticketing** install:

```bash
make helm-install-ticketing NAMESPACE="${NAMESPACE}"
```

**What to read while it runs:**

- Target implementation and printed checklist: [`Makefile`](../../it-self-service-agent/Makefile) (`helm-install-ticketing`, `_helm-install-ticketing-single`, `_helm-install-ticketing-print-checklist`, `deploy-zammad`).
- Values overlays: [`helm/values-ticketing.yaml`](../../it-self-service-agent/helm/values-ticketing.yaml), [`helm/values-test.yaml`](../../it-self-service-agent/helm/values-test.yaml) (as referenced by that target).
- Zammad deployment stack: [`helm/zammad/`](../../it-self-service-agent/helm/zammad/), [`helm/values-zammad-deploy.yaml`](../../it-self-service-agent/helm/values-zammad-deploy.yaml).

Expect **15+ minutes** on first deploy (Zammad dependencies). Watch pods: `kubectl get pods -n "${NAMESPACE}" -w`.

## Manual or split deploys

If you do not use the one-shot target, you must still satisfy the same ordering and wiring the Makefile encodes (placeholder Secret → main chart with ticketing values → Zammad release → token → restarts). **Use the Makefile as the spec**, not this page.

## Uninstall

Use upstream **`make helm-uninstall`** (same `NAMESPACE`); it tears down the main release and Zammad-related resources per the Makefile. Confirm data retention policy before running.
