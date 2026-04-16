# [INSERT quickstart title here]

<!-- CONTRIBUTOR TODO: update title ^^

*replace the H1 title above with your quickstart title*

TITLE requirements:
	* MAX CHAR: 64
	* Industry use case, ie: Protect patient data with LLM guardrails

TITLE will be extracted for publication.

-- >



<!-- CONTRIBUTOR TODO: short description

*ADD a SHORT DESCRIPTION of your use case between H1 title and next section*

SHORT DESCRIPTION requirements:
	* MAX CHAR: 160
	* Describe the INDUSTRY use case

SHORT DESCRIPTION will be extracted for publication.

-->

## Overview

<!-- CONTRIBUTOR TODO: add overview

*Describe the quickstart at a high level. What does it do? What problem does it solve?*

-->

## Detailed description

<!-- CONTRIBUTOR TODO: add detailed description.

This section is required. Describe the quickstart use case in more detail.

This is not a technical description. This is about the workload.

Technical description comes later.

-->


### See it in action

<!--

*This section is optional but recommended*

Arcades are a great way to showcase your quickstart before installation.

-->

### Architecture diagrams

<!-- CONTRIBUTOR TODO: add architecture diagram.

*Section is required. Put images in `docs/images` folder*

-->


## Requirements


### Minimum hardware requirements

<!-- CONTRIBUTOR TODO: add minimum hardware requirements

*Section is required.*

Be as specific as possible. DON'T say "GPU". Be specific.

List minimum hardware requirements.

If your quickstart deploys a model, include its resource requirements. For example:

**Main LLM (only when deploying a model with the chart):**
- CPU: X vCPU (request) / Y vCPU (limit)
- Memory: X GiB (request) / Y GiB (limit)
- GPU: 1 NVIDIA GPU (e.g., A10, A100, L40S, T4, or similar)

> **Note**: If users bring their own model endpoint (MaaS), the LLM resources
and GPU are not required.

If your quickstart does NOT deploy a model, just list the resources your
application needs.

-->

### Minimum software requirements

<!-- CONTRIBUTOR TODO: add minimum software requirements

*Section is required.*

Be specific. Don't say "OpenShift AI". Instead, tested with OpenShift AI 2.25

If you know it only works in a specific version, say so.

-->

### Required user permissions

<!-- CONTRIBUTOR TODO: add user permissions

*Section is required. Describe the permissions the user will need. Cluster
admin? Regular user?*

-->


## Deploy

### Prerequisites

Before deploying, ensure you have:
- Access to a Red Hat OpenShift cluster with OpenShift AI installed
- `oc` CLI tool installed and configured
- `helm` CLI tool installed
- Sufficient resources available in your cluster

<!-- CONTRIBUTOR TODO: add or remove prerequisites as needed -->

### Installation

1. Clone the repository:
```bash
git clone https://github.com/rh-ai-quickstart/YOUR_QUICKSTART_NAME.git
cd YOUR_QUICKSTART_NAME
```

2. Create a new OpenShift project:
```bash
PROJECT="my-quickstart"
oc new-project ${PROJECT}
```

3. Install using Helm:

```bash
helm install my-quickstart ./chart --namespace ${PROJECT}
```

<!-- CONTRIBUTOR TODO:

Customize the installation step above to match your quickstart.

Key things to update:
- Replace "my-quickstart" and "YOUR_QUICKSTART_NAME" with your actual names
- Add any additional --set flags specific to your quickstart
- If your quickstart requires a model, keep the model options section below
  and remove this comment
- If your quickstart does NOT require a model, remove the model options section
  below entirely

-->

#### If your quickstart requires a model

**Option A: Use your own model (MaaS - Model as a Service)**

If you have an existing model endpoint, provide the model name, endpoint, and API key:
```bash
helm install my-quickstart ./chart --namespace ${PROJECT} \
  --set model.name=YOUR_MODEL_NAME \
  --set model.endpoint=YOUR_MODEL_ENDPOINT \
  --set model.api_key=YOUR_API_KEY
```

> **Note**: The `model.endpoint` should be the full URL including protocol and port if needed (e.g., `https://my-model.example.com` or `http://my-model:8080`).

**Option B: Deploy with a model included in the chart**

If you don't provide any model configuration, the chart will deploy a default model on your cluster:
```bash
helm install my-quickstart ./chart --namespace ${PROJECT}
```

> **Note**: Option B requires a GPU available in your cluster for the LLM deployment. See [Minimum hardware requirements](#minimum-hardware-requirements) for details. You must add your own model InferenceService template under `chart/templates/` for this option to work.

#### Testing model access (before deploying)

If you are bringing your own model (Option A), you can verify the endpoint is reachable **before** installing the chart:

```bash
oc run test-model-access --rm -it --restart=Never \
  --image=registry.access.redhat.com/ubi9/ubi-minimal:latest \
  -- /bin/sh -c 'curl -sf --max-time 10 \
    -H "Authorization: Bearer YOUR_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"YOUR_MODEL_NAME\", \"messages\": [{\"role\": \"user\", \"content\": \"Say hello in one word.\"}], \"max_tokens\": 10}" \
    "YOUR_MODEL_ENDPOINT/v1/chat/completions" && echo "" && echo "SUCCESS" || echo "FAILED"'
```

Replace `YOUR_API_KEY`, `YOUR_MODEL_NAME`, and `YOUR_MODEL_ENDPOINT` with your actual values.

### Validating the deployment

After installing the chart, you can run the included Helm test to verify model connectivity:

```bash
helm test my-quickstart --namespace ${PROJECT}
```

<!-- CONTRIBUTOR TODO: add additional validation steps specific to your quickstart,
such as checking routes, accessing a UI, etc. For example:

```bash
echo https://$(oc get route/my-app -n ${PROJECT} --template='{{.spec.host}}')
```

If your quickstart does not use a model, remove the helm test step above
and add your own validation steps.
-->

### Uninstall

To remove the deployment:
```bash
helm uninstall my-quickstart --namespace ${PROJECT}
```

## Repository structure

```
.
├── chart/                    # Helm chart for deploying the quickstart
│   ├── Chart.yaml            # Chart metadata
│   ├── values.yaml           # Default configuration values (model info, resources, etc.)
│   └── templates/            # Kubernetes resource templates
│       ├── test-model-access.yaml  # Helm test for verifying model connectivity
│       └── ...               # Add your templates here (deployments, services, etc.)
├── docs/
│   └── images/               # Architecture diagrams and screenshots
└── README.md
```

<!-- CONTRIBUTOR TODO:

Update the tree above to reflect your actual structure.

The `chart/` folder is where your Helm chart lives. At minimum it should contain:
- Chart.yaml with your chart metadata
- values.yaml with your configurable values (include model configuration only
  if your quickstart requires a model)
- templates/ with your Kubernetes resource templates

If your quickstart includes application source code (e.g., a web UI, API server),
add it as a sibling directory to chart/. For example:
  ├── my-app/                 # Application source code
  │   ├── app.py
  │   ├── Containerfile
  │   └── requirements.txt

-->

## References

<!--

*Section optional.* Remember to remove if do not use.

Include links to supporting information, documentation, or learning materials.

-->

## Technical details

<!--

*Section is optional.*

Here is your chance to share technical details.

Welcome to add sections as needed. Keep additions as structured and consistent as possible.

-->

## Tags

<!-- CONTRIBUTOR TODO: add metadata and tags for publication

TAG requirements:
	* Title: max char: 64, describes quickstart (match H1 heading)
	* Description: max char: 160, match SHORT DESCRIPTION above
	* Industry: target industry, ie. Healthcare OR Financial Services
	* Product: list primary product, ie. OpenShift AI OR OpenShift OR RHEL
	* Use case: use case descriptor, ie. security, automation,
	* Contributor org: defaults to Red Hat unless partner or community

Additional MIST tags, populated by web team.

-->
