# Smoke tests (minimal validation)

**Upstream may add richer tests** (evaluations, integration suites). Treat this as a **short operator checklist** after **`make helm-install-ticketing`** completes; the Makefile prints URLs and follow-up steps—preserve that output.

## Quick checks

1. **Pods:** `kubectl get pods -n "${NAMESPACE}"` — Zammad stack and **`self-service-agent-***`** workloads reach **Running** (allow time after first install).
2. **Route:** `oc get route ssa-zammad -n "${NAMESPACE}" -o jsonpath='{.spec.host}{"\n"}'` — open **`https://<host>`** (login per upstream demo defaults or your replacements in [`helm/values-ticketing.yaml`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/790351abb8ce23940258650674700e5c56a4b1bf/helm/values-ticketing.yaml)).
3. **API path:** `curl -sk -o /dev/null -w "%{http_code}\n" "https://<host>/api/v1/"` — expect **401/403** without auth, not connection failure.
4. **Secret:** `kubectl get secret self-service-agent-zammad-credentials -n "${NAMESPACE}" -o jsonpath='{.data.zammad-http-token}' | base64 -d | wc -c` — non-zero after token bootstrap.
5. **MCP logs:** `kubectl logs -n "${NAMESPACE}" deploy/mcp-zammad-mcp --tail=50` (adjust deployment name if prefixed).

Optional: create a test ticket in Zammad UI to confirm basic product health; end-to-end **chat → agent** automation depends on upstream wiring beyond this smoke list.
