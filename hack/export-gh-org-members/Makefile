.DEFAULT_GOAL := help
.PHONY: help build run

IMAGE_NAME = 3scale/export-team-memberships

check: ## Checks if the required files are present
	@test ! -z "${OCTOKIT_ACCESS_TOKEN}" \
		|| { echo "OCTOKIT_ACCESS_TOKEN env var not defined."; exit 1; }
	@test ! -z "${ORG}" \
		|| { echo "ORG env var not defined."; exit 1; }
help: ## Prints this help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build a docker image with the script
	docker build --rm -t $(IMAGE_NAME) .

run: check ## Runs the scrip in docker for the Github org defined in $ORG env var.
	@docker run -v $(PWD)/data:/data -e OCTOKIT_ACCESS_TOKEN=${OCTOKIT_ACCESS_TOKEN} $(IMAGE_NAME) $(ORG)
