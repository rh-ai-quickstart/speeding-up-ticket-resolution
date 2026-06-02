# Releases and tags (wrapper repo)

This repository is a **thin wrapper**; semantic versioning can track **documentation + submodule pin** together.

## Tag format

Use calendar or semantic tags as your team prefers, for example:

- **`v2026.04.17`** — date-based
- **`v1.2.0`** — semver for wrapper milestones

## What to record at tag time

When creating a tag, note the **upstream submodule SHA** this wrapper was tested against (same value as [docs/upstream.md](upstream.md) **Current pin**):

```text
ticket-resolution-agent v2026.04.17
  submodule it-self-service-agent @ 1da6909b42b2b59bc37a8aee96189c82a332efb2
  optional: OpenShift / OAI / Zammad versions validated
```

## Commands

```bash
# Ensure docs/upstream.md Current pin is up to date, then:
git tag -a v2026.04.17 -m "docs: tested with it-self-service-agent @ <full-sha>"
git push origin v2026.04.17
```

Replace the message with your actual smoke-test notes.

## Dependabot submodule PRs

[Dependabot](../.github/dependabot.yml) may open weekly PRs that bump `it-self-service-agent`. Merge only after validating upstream changes and updating [upstream.md](upstream.md); treat tags as snapshots **after** those merges if you release often.
