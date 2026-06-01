# Thin wrapper Makefile — delegates to it-self-service-agent (upstream source of truth).
SUBMODULE := it-self-service-agent
MARKDOWN_LINK_CHECK_VERSION ?= 3.10.3

.PHONY: help
help:
	@echo "ticket-resolution-agent — delegates to $(SUBMODULE)/Makefile"
	@echo ""
	@echo "From repo root (Zammad ticketing profile):"
	@echo "  make install NAMESPACE=<ns>     upstream: helm-install-ticketing"
	@echo "  make uninstall NAMESPACE=<ns>   upstream: helm-uninstall"
	@echo "  Other upstream vars (e.g. ZAMMAD_URL): same as submodule — use VAR=value or export."
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

.PHONY: install uninstall
install:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-install-ticketing

uninstall:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) helm-uninstall

.PHONY: test-short-ticket-laptop-refresh-scout-deploy
test-short-ticket-laptop-refresh-scout-deploy:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) test-short-ticket-laptop-refresh-scout-deploy

.PHONY: test-short-ticket-laptop-refresh-70b-deploy
test-short-ticket-laptop-refresh-70b-deploy:
	@test -f $(SUBMODULE)/Makefile || { echo "error: submodule missing; run: git submodule update --init --recursive"; exit 1; }
	$(MAKE) -C $(SUBMODULE) test-short-ticket-laptop-refresh-70b-deploy
