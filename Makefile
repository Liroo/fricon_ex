# Build configuration
# -------------------

APP_NAME = `grep -Eo 'app: :\w*' mix.exs | cut -d ':' -f 3`
APP_VERSION = `grep -Eo 'version: "[0-9\.]*"' mix.exs | cut -d '"' -f 2`
GIT_REVISION = `git rev-parse HEAD`

# Introspection targets
# ---------------------

.PHONY: help
help: header targets

.PHONY: header
header:
	@echo "\033[34mEnvironment\033[0m"
	@echo "\033[34m---------------------------------------------------------------\033[0m"
	@printf "\033[33m%-23s\033[0m" "APP_NAME"
	@printf "\033[35m%s\033[0m" $(APP_NAME)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "APP_VERSION"
	@printf "\033[35m%s\033[0m" $(APP_VERSION)
	@echo ""
	@printf "\033[33m%-23s\033[0m" "GIT_REVISION"
	@printf "\033[35m%s\033[0m" $(GIT_REVISION)
	@echo "\n"

.PHONY: targets
targets:
	@echo "\033[34mTargets\033[0m"
	@echo "\033[34m---------------------------------------------------------------\033[0m"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# Build targets
# -------------

.PHONY: build
build: ## Build the Docker image for the OTP release
	mix compile

.PHONY: prod-release
prod-release: prod-dependencies ## Create a new release of the app based on the settings in mix.exs using the prod env
	MIX_ENV=prod mix release


ifeq (rel-cmd,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: rel-cmd
rel-cmd: # running the task after prod-release
	_build/prod/rel/fricon/bin/fricon $(RUN_ARGS)

.PHONY: prod-start
prod-start: prod-dependencies ## Start the server into production without release
	## Compile
	MIX_ENV=prod mix compile
	## Migrate DB
	MIX_ENV=prod mix ecto.migrate
	## Run the server
	MIX_ENV=prod mix phx.server

.PHONY: prod-dependencies
prod-dependencies: ## Instal dependencies in prod
	mix deps.get --only prod

# Development targets
# -------------------

.PHONY: run
run: ## Run the server inside an IEx shell
	iex -S mix phx.server

.PHONY: prepare
prepare: ## Install dependencies for CI/CD
	mix deps.get

.PHONY: dependencies
dependencies: ## Install dependencies
	mix deps.get --force

.PHONY: clean
clean: ## Clean dependencies
	mix deps.clean --unused --unlock

.PHONY: test
test: ## Run the test suite
	mix test

# Check, lint and format targets
# ------------------------------

.PHONY: check
check: check-format check-unused-dependencies check-code-security check-code-coverage

.PHONY: check-code-coverage
check-code-coverage:
	mix coveralls

.PHONY: check-code-security
check-code-security:
	mix sobelow --config

.PHONY: check-format
check-format:
	mix format --dry-run --check-formatted

.PHONY: check-unused-dependencies
check-unused-dependencies:
	mix deps.unlock --check-unused

.PHONY: format
format: ## Format project files
	mix format

.PHONY: lint
lint: lint-elixir ## Lint project files

.PHONY: lint-elixir
lint-elixir:
	mix compile --warnings-as-errors --force
	mix credo --strict