# Misc
DOCKER_COMP = docker compose
.DEFAULT_GOAL = help
.PHONY        = help

## —— 🎵 🐳 The Traefik portainer Makefile 🐳 🎵 ——————————————————————————————————

##
## Commands
## ---------
network:
	docker network ls | grep public-dev || docker network create public-dev
	docker network ls | grep traefik-global-proxy || docker network create traefik-global-proxy

start: network ## Start the docker-dev-host stack
	@$(DOCKER_COMP) --profile common --project-name docker-traefik-portainer up --detach

test: network ## Start the docker-dev-host "hello-world" container
	@$(DOCKER_COMP) --profile common --project-name docker-traefik-portainer --profile test up --detach

down: ## Stop the docker-dev-host stack
	@$(DOCKER_COMP) --profile common --project-name docker-traefik-portainer --profile deprecated --profile test down --remove-orphans

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##
## Deprecated
## ---------
start-dns: network ## Start the docker-dev-host stack including the deprecated dnsmasq container
	@$(DOCKER_COMP) --profile common --project-name docker-traefik-portainer --profile deprecated up --detach