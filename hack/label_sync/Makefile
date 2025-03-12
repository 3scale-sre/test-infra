.DEFAULT_GOAL := help

GITHUB_OAUTH_FILE ?= "$(PWD)/secrets/oauth"
LABELS_FILE ?= "$(PWD)/labels.yaml"
LABELS_DOCS_TEMPLATE ?= "$(PWD)/README.md.tpl"
LABELS_DOCS_OUTPUT ?= "$(PWD)/README.md"

help: ## Prints this help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: run-3scale-sre run-3scale ## Runs the label sync against 3scale-sre and 3scale repos

check: ## Checks if the required files are present
	@test -f $(GITHUB_OAUTH_FILE) \
		|| { echo "$(GITHUB_OAUTH_FILE) not found."; exit 1; }
	@test -f $(LABELS_FILE) \
		|| { echo "$(LABELS_FILE) not found."; exit 1; }

docs: ## Runs the label sync against 3scale-sre entire org
	docker run \
		--rm \
		--volume $(GITHUB_OAUTH_FILE):/etc/github/oauth \
		--volume $(LABELS_FILE):/etc/config/labels.yaml \
		--volume $(LABELS_DOCS_OUTPUT):/tmp/labels.md \
		--volume $(LABELS_DOCS_TEMPLATE):/tmp/labels.md.tpl \
		gcr.io/k8s-prow/label_sync:latest \
			--config=/etc/config/labels.yaml \
			--action=docs \
			--docs-template=/tmp/labels.md.tpl \
			--docs-output=/tmp/labels.md

run-3scale-sre: check ## Runs the label sync against 3scale-sre entire org
	docker run \
		--rm \
		--volume $(GITHUB_OAUTH_FILE):/etc/github/oauth \
		--volume $(LABELS_FILE):/etc/config/labels.yaml \
		gcr.io/k8s-prow/label_sync:latest \
			--config=/etc/config/labels.yaml \
			--confirm=true \
			--orgs=3scale-sre \
			--token=/etc/github/oauth

run-3scale: check ## Runs the label sync againts a set of 3scale org repos
	docker run \
		--rm \
		--volume $(GITHUB_OAUTH_FILE):/etc/github/oauth \
		--volume $(LABELS_FILE):/etc/config/labels.yaml \
		gcr.io/k8s-prow/label_sync:latest \
			--config=/etc/config/labels.yaml \
			--confirm=true \
			--only=3scale/platform,3scale/3scale-saas \
			--token=/etc/github/oauth