
help: ## List all available targets
    @echo "  Usage:\n    \033[36m make <target>\n\n \033[0m Targets:"
    @fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "     \033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup_terminal: ## Configure terminal to install all deps
    @./scripts/setup_terminal.sh

