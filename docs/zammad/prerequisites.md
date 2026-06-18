# Prerequisites (Zammad on OpenShift)

## Authority for versions and requirements

Use **[upstream `README.md`](https://github.com/rh-ai-quickstart/it-self-service-agent/blob/5af29a5b8780d7de448135bf45a0fda247799736/README.md)** and upstream guides for **supported OpenShift / OpenShift AI versions**, CLI versions, and resource assumptions. This file only lists **wrapper-relevant** expectations.

## Cluster

- **OpenShift** project namespace with quota for the self-service stack **plus** Zammad (Elasticsearch, PostgreSQL, Redis, Memcached, Zammad workloads). First bring-up is often **10–20+ minutes**.
- **SCC / UID**: upstream `deploy-zammad` uses the namespace **`openshift.io/sa.scc.uid-range`** annotation to set Zammad `securityContext`—use a normal user project (`NAMESPACE` passed to `make`).
- **LLMs**: Ticketing does not remove the base chart’s model / OpenShift AI expectations; see upstream README.

## Tools

- **`oc`**, **`kubectl`**, **`helm`** (v3)—as required by upstream `Makefile` targets you run from **`it-self-service-agent/`** ([upstream tree at pin](https://github.com/rh-ai-quickstart/it-self-service-agent/tree/5af29a5b8780d7de448135bf45a0fda247799736)).

## Planning

You will align Zammad API URL and MCP token with the Secret contract in [configure-channel.md](configure-channel.md); exact defaults are set in the Makefile and Helm values linked from [install-openshift.md](install-openshift.md).
