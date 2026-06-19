# Contributing

## Submodule bumps

- The upstream app lives in **`it-self-service-agent`** at the repo root (submodule → [it-self-service-agent](https://github.com/rh-ai-quickstart/it-self-service-agent)).
- Run the Nightly Submodule bump action to create PR to pull in latest dev version of it-self-service-agent to dev branch or wait until nightly scheduled run

## Glue (`Makefile`)

Keep glue **thin**—delegate to **`it-self-service-agent/Makefile`**.
