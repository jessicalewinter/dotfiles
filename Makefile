default: help

.PHONY: help setup

help:
	@echo "  Usage:\n    \033[36m make <target>\n\n \033[0m Targets:"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "     \033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup-terminal: ## Install project required dependencies
	@./scripts/setup-terminal.sh

setup-tools:
	@./scripts/setup-tools.sh
	@$(MAKE) add-hooks

add-hooks:
	@./scripts/git/add-hooks.sh
