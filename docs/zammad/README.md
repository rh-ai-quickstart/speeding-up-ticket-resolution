# Zammad ticketing channel

This folder is a **thin integration layer** over the pinned upstream app in **`it-self-service-agent/`** ([browse at pinned commit on GitHub](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/8d7da399430629feecab61326eb8b4445cf22a0a); repo [`rh-ai-quickstart/it-self-service-agent`](https://github.com/rh-ai-quickstart/it-self-service-agent)). Submodule branch policy and SHA: [docs/upstream.md](../../docs/upstream.md).

## Documentation policy (recommended split)

| Maintain **here** (wrapper) | Maintain **upstream** (`it-self-service-agent`) |
|----------------------------|------------------------------------------------|
| Why this repo exists, compatibility matrix, bump workflow | Makefile targets, Helm charts, values files, long README sections |
| Operator framing for **OpenShift + Zammad** without duplicating every flag | Generic install docs, evaluation guides, architecture deep-dives |
| Links to upstream on GitHub (**`blob`/`tree`** URLs at the pin in [docs/upstream.md](../../docs/upstream.md))—not relative paths under this repo, which break on GitHub for submodules | Anything that changes every release (exact step order, new targets) |

**Rule of thumb:** If a paragraph duplicates upstream `Makefile` comments or `helm/*.yaml` comments, replace it with a **link** and one sentence of wrapper-specific context.

**Canonical sources for ticketing:**

- [`Makefile`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/8d7da399430629feecab61326eb8b4445cf22a0a/Makefile) — search targets **`helm-install-ticketing`**, **`deploy-zammad`**, **`zammad-bootstrap-token`**, **`zammad-set-token`**, **`undeploy-zammad`**
- [`helm/values-ticketing.yaml`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/8d7da399430629feecab61326eb8b4445cf22a0a/helm/values-ticketing.yaml), [`helm/zammad/`](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/8d7da399430629feecab61326eb8b4445cf22a0a/helm/zammad)
- Same pin as **Current pin** in [docs/upstream.md](../../docs/upstream.md); update those URLs when you bump the submodule.

## Documents

| Doc | Purpose |
|-----|---------|
| [component-map.md](component-map.md) | ServiceNow vs Zammad vs shared platform (stable mental model) |
| [prerequisites.md](prerequisites.md) | Wrapper-oriented prereqs; defers versions to upstream README |
| [install-openshift.md](install-openshift.md) | Entry command + links—**not** a second copy of upstream install steps |
| [configure-channel.md](configure-channel.md) | Secret contract + token flow; defers commands to Makefile |
| [troubleshooting.md](troubleshooting.md) | Quick index; upstream owns root-cause fixes in charts/code |
| [smoke-tests.md](smoke-tests.md) | Minimal post-install checks |
