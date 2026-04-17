# Troubleshooting (Zammad ticketing)

**Upstream is the authority** for chart and code fixes. Use this page as a **quick index**; open issues or PRs on [`rh-ai-quickstart/it-self-service-agent`](https://github.com/rh-ai-quickstart/it-self-service-agent) when behavior is wrong in **`it-self-service-agent`**.

## First checks

| Area | Where to look |
|------|----------------|
| Install order, FQDN, token steps | [`Makefile`](../../it-self-service-agent/Makefile) targets **`helm-install-ticketing`**, **`deploy-zammad`**, **`zammad-bootstrap-token`** |
| Zammad pod failures | `kubectl logs` / `kubectl describe` for `zammad-railsserver`, Elasticsearch, etc. |
| MCP auth to Zammad | Secret keys in [configure-channel.md](configure-channel.md); logs on deployment **`mcp-zammad-mcp`** (name may vary with release prefix—`kubectl get deploy -n "$NAMESPACE" \| grep -i zammad`) |
| Redirect / HTTPS behind Route | How upstream sets **`ZAMMAD_FQDN`** / **`ZAMMAD_HTTP_TYPE`** in **`deploy-zammad`** |
| Wrong platform version | Submodule pin in [docs/upstream.md](../../docs/upstream.md) vs upstream README |

## Submodule drift

If steps in this repo do not match what you see in the submodule, confirm:

```bash
git submodule status
```

Bump or roll back per [docs/upstream.md](../../docs/upstream.md), then prefer **relative links** under `it-self-service-agent/` over outdated prose here.

## This repository only

Open an issue **here** for **wrapper** problems: missing links, wrong pointers, or docs that contradict the submodule at the pinned SHA.
