# Zammad ticketing channel

This folder is a **thin integration layer** over the pinned upstream app in [`it-self-service-agent/`](../../it-self-service-agent) ([`rh-ai-quickstart/it-self-service-agent`](https://github.com/rh-ai-quickstart/it-self-service-agent)). Submodule branch policy and SHA: [docs/upstream.md](../../docs/upstream.md).

## Documentation policy (recommended split)

| Maintain **here** (wrapper) | Maintain **upstream** (`it-self-service-agent`) |
|----------------------------|------------------------------------------------|
| Why this repo exists, compatibility matrix, bump workflow | Makefile targets, Helm charts, values files, long README sections |
| Operator framing for **OpenShift + Zammad** without duplicating every flag | Generic install docs, evaluation guides, architecture deep-dives |
| Links into the submodule tree (relative paths) or GitHub **`tree/<SHA>`** permalinks using the pin from [docs/upstream.md](../../docs/upstream.md) | Anything that changes every release (exact step order, new targets) |

**Rule of thumb:** If a paragraph duplicates upstream `Makefile` comments or `helm/*.yaml` comments, replace it with a **link** and one sentence of wrapper-specific context.

**Canonical sources for ticketing:**

- [`Makefile`](../../it-self-service-agent/Makefile) — search targets **`helm-install-ticketing`**, **`deploy-zammad`**, **`zammad-bootstrap-token`**, **`zammad-set-token`**, **`undeploy-zammad`**
- [`helm/values-ticketing.yaml`](../../it-self-service-agent/helm/values-ticketing.yaml), [`helm/values-zammad-deploy.yaml`](../../it-self-service-agent/helm/values-zammad-deploy.yaml), [`helm/zammad/`](../../it-self-service-agent/helm/zammad/)
- Browse on GitHub at the pinned commit: `https://github.com/rh-ai-quickstart/it-self-service-agent/tree/<SHA>` (use **Current pin** in [docs/upstream.md](../../docs/upstream.md) for `<SHA>`)

## Documents

| Doc | Purpose |
|-----|---------|
| [component-map.md](component-map.md) | ServiceNow vs Zammad vs shared platform (stable mental model) |
| [prerequisites.md](prerequisites.md) | Wrapper-oriented prereqs; defers versions to upstream README |
| [install-openshift.md](install-openshift.md) | Entry command + links—**not** a second copy of upstream install steps |
| [configure-channel.md](configure-channel.md) | Secret contract + token flow; defers commands to Makefile |
| [troubleshooting.md](troubleshooting.md) | Quick index; upstream owns root-cause fixes in charts/code |
| [smoke-tests.md](smoke-tests.md) | Minimal post-install checks |
