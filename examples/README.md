# Examples (placeholders only)

This directory holds **documentation and non-secret placeholders** for the ticketing path. **Install orchestration** lives in **`it-self-service-agent/`** ([`Makefile` at pinned upstream commit](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/16cd45fac5a1b1d6a49cb1532baa17e8f12823ca/Makefile), `helm/`).

## Before you use anything here

1. Clone with submodules: [docs/upstream.md](../docs/upstream.md).
2. Use a **pinned** submodule commit; keep **Current pin** in that doc accurate.
3. Do **not** commit real credentials, kubeconfig bodies, or tokens—use OpenShift Secrets and your team’s secret store.

## Typical flow (from repo root)

```bash
export NAMESPACE=my-team-ticketing
make install NAMESPACE="${NAMESPACE}"
```

## Where real values live

Upstream charts and sample values paths are under **`it-self-service-agent/helm/`**—see [docs/zammad/install-openshift.md](../docs/zammad/install-openshift.md). Add team-specific overrides by following upstream patterns; keep wrapper deltas small and documented.
