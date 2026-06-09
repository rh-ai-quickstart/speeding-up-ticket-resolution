# Component map: ticketing vs ServiceNow

File-level detail drifts when upstream changes; **`it-self-service-agent`** is authoritative. This map stays as a **stable conceptual** split.

All paths below are under the submodule **`it-self-service-agent/`**.

## Shared core (both channels)

These components run for the standard agent platform; they are **not** ServiceNow-specific:

| Piece | Role |
|-------|------|
| **request-manager** | Sessions, routing, APIs for inbound work |
| **agent-service** | LangGraph agents (e.g. routing / ticket-review flows) |
| **integration-dispatcher** | Delivers outbound replies on channels (Slack, email, webhook, …) per [INTEGRATION_GUIDE.md](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/26a5a1d7922d303e5354fc2d9c293bdf39fc8640/guides/INTEGRATION_GUIDE.md) |
| **PostgreSQL / pgvector** | Request and session state |
| **Mock eventing vs Knative** | Test profile (`values-test.yaml`) vs prod eventing |

## ServiceNow-specific (skip for Zammad-only)

| Piece | Notes |
|-------|--------|
| **`mcp-servers/snow`** | MCP server for ServiceNow APIs |
| **`mock-service-now`** | Dev mock for SNOW |
| **`helm`** values under ServiceNow keys | Credentials and toggles for SNOW MCP |

Disable or omit SNOW-focused options when you only care about Zammad.

## Zammad ticketing stack

| Piece | Role |
|-------|------|
| **`helm/values-ticketing.yaml`** | Enables `zammad.enabled`, MCP URI, **`zammad-mcp`** MCP server |
| **`helm/values.yaml`** (`zammad`, `mcp-servers.mcp-servers.zammad-mcp`) | Defaults for Zammad URL, MCP image (`ghcr.io/basher83/zammad-mcp`), toggles |
| **`zammad-mcp` deployment** | MCP HTTP server; reads **`ZAMMAD_URL`** and **`ZAMMAD_HTTP_TOKEN`** from Secret |
| **`<release>-zammad-credentials` Secret** | Keys `zammad-url` (API base, typically `…/api/v1`) and `zammad-http-token` |
| **`helm/zammad/` + `helm/values-zammad-deploy.yaml`** | In-cluster **Zammad** via upstream Helm wrapper (official Zammad subchart + bootstrap Job) |
| **`zammad-bootstrap`** Job | Seeds groups/users via `zammad-bootstrap/` container image |
| **`helm/zammad-embed/`** | Static embed snippet + **`ssa-zammad-embed`** Route for chat widget preview |
| **Routes `ssa-zammad`, `ssa-zammad-embed`** | OpenShift Routes for UI / embed (created by upstream charts; main chart installs first so FQDN can be applied) |

## End-to-end intent (reference)

1. Operators deploy the main chart **with ticketing values** so agent workloads and **`mcp-zammad`** exist.
2. Operators deploy **Zammad** (`deploy-zammad`) so tickets and the chat channel can live in-cluster.
3. An **HTTP API token** is placed in **`self-service-agent-zammad-credentials`** (default secret name pattern from upstream `Makefile`) so MCP can call Zammad’s API.

Full chat ↔ agent automation may depend on additional webhook or blueprint wiring upstream; treat **ticket creation + MCP API access + UI** as the baseline this repo documents first.
