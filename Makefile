# Thin wrapper Makefile — delegates to it-self-service-agent (upstream source of truth).
SUBMODULE := it-self-service-agent
MARKDOWN_LINK_CHECK_VERSION ?= 3.10.3

# Auto-detect VERSION from the outer repo's branch when not explicitly set.
# Reads BASE_VERSION from the submodule Makefile so this stays in sync as versions bump.
# On dev branch: passes VERSION=<base>-dev to match CI-built dev images.
# Override any time with: make install VERSION=<tag>
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
_BASE_VERSION := $(shell grep '^BASE_VERSION :=' $(SUBMODULE)/Makefile 2>/dev/null | awk '{print $$3}')
_DEV_VERSION := $(_BASE_VERSION)-dev

ifeq ($(origin VERSION),undefined)
  ifeq ($(GIT_BRANCH),main)
    VERSION_ARG :=
  else
    VERSION_ARG := VERSION=$(_DEV_VERSION)
  endif
else
  VERSION_ARG := VERSION=$(VERSION)
endif

.PHONY: help
help:
	@echo "ticket-resolution-agent — delegates to $(SUBMODULE)/Makefile"
	@echo ""
	@echo "From repo root (Zammad ticketing profile):"
	@echo "  make install NAMESPACE=<ns>     upstream: helm-install-ticketing"
	@echo "  make uninstall NAMESPACE=<ns>   upstream: helm-uninstall"
	@echo "  make helm-status NAMESPACE=<ns> upstream: helm-status"
	@echo "  Other upstream vars (e.g. ZAMMAD_URL): same as submodule — use VAR=value or export."
	@echo ""
	@echo "  VERSION is auto-detected from the outer repo branch:"
	@echo "    main   → submodule default ($(_BASE_VERSION))"
	@echo "    other  → VERSION=$(_DEV_VERSION)   (dev images)"
	@echo "  Override: make install NAMESPACE=<ns> VERSION=<tag>"
	@echo ""
	@echo "Other:"
	@echo "  make submodule-status    git submodule status --recursive"
	@echo "  make check-links         Vets upstream blob/tree SHAs vs submodule; then HTTP link check (CI)"
	@echo "  make sync-upstream-links Rewrite upstream github.com/.../blob|tree/<sha>/ URLs to submodule HEAD"
	@echo ""
	@echo "Requires submodule: git submodule update --init --recursive"
	@echo "Docs: docs/zammad/install-openshift.md · docs/glue.md"

.PHONY: check-links sync-upstream-links
check-links:
	@env MARKDOWN_LINK_CHECK_VERSION="$(MARKDOWN_LINK_CHECK_VERSION)" ./scripts/check-markdown-links.sh

sync-upstream-links:
	@./scripts/sync-upstream-github-links.sh

.PHONY: submodule-status
submodule-status:
	git submodule status --recursive

.PHONY: install uninstall helm-install-ticketing
install helm-install-ticketing:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-install-ticketing $(VERSION_ARG)

uninstall:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-uninstall

.PHONY: helm-depend
helm-depend:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-depend

.PHONY: namespace
namespace:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) namespace

.PHONY: test-short-ticket-laptop-refresh
test-short-ticket-laptop-refresh:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) test-short-ticket-laptop-refresh

.PHONY: test-long-ticket-laptop-refresh
test-long-ticket-laptop-refresh:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) test-long-ticket-laptop-refresh

.PHONY: helm-status
helm-status:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-status

.PHONY: jaeger-deploy
jaeger-deploy:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) jaeger-deploy

.PHONY: jaeger-undeploy
jaeger-undeploy:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) jaeger-undeploy

.PHONY: deploy-nemo-guardrails
deploy-nemo-guardrails:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) deploy-nemo-guardrails

.PHONY: undeploy-nemo-guardrails
undeploy-nemo-guardrails:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) undeploy-nemo-guardrails

.PHONY: build-all-images
build-all-images:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) build-all-images $(VERSION_ARG)

.PHONY: push-all-images
push-all-images:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) push-all-images $(VERSION_ARG)
