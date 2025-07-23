# ==============================================================================
# CONFIGURAÇÕES GERAIS
# ==============================================================================

# Define o "alvo" (goal) padrão para 'help'. Se 'make' for executado sem argumentos,
# ele mostrará a ajuda em vez de executar o primeiro alvo do arquivo.
.DEFAULT_GOAL := help

# Garante que o Makefile pare imediatamente se um comando falhar.
# -o errexit: Aborta se um comando falhar.
# -o pipefail: Considera falha em um pipe se qualquer parte dele falhar.
SHELL := /bin/bash
.SHELLFLAGS := -o errexit -o pipefail -c

# Declara alvos que não são arquivos. Isso evita conflitos com nomes de arquivos
# e melhora o desempenho.
.PHONY: help elastic-up elastic-down app-build app-up app-down

# Variáveis para os comandos do Docker Compose, evitando repetição.
ELASTIC_COMPOSE = docker-compose
APP_COMPOSE = docker-compose -f app/docker-compose.yml


# ==============================================================================
# ALVOS DO PROJETO
# ==============================================================================

elastic-up: ## 🐳 Elastic: Sobe os contêineres do Elasticsearch em background
	@echo "=> Subindo contêineres do Elastic..."
	@$(ELASTIC_COMPOSE) up -d

elastic-down: ## 🐳 Elastic: Para e remove os contêineres do Elasticsearch
	@echo "=> Parando contêineres do Elastic..."
	@$(ELASTIC_COMPOSE) down

app-build: ## 🚀 App: Constrói (ou reconstrói) e sobe os contêineres da aplicação
	@echo "=> Construindo e subindo a aplicação..."
	@$(APP_COMPOSE) up -d --build

app-up: ## 🚀 App: Sobe os contêineres da aplicação em background
	@echo "=> Subindo a aplicação..."
	@$(APP_COMPOSE) up -d

app-down: ## 🚀 App: Para e remove os contêineres da aplicação
	@echo "=> Parando a aplicação..."
	@$(APP_COMPOSE) down


# ==============================================================================
# COMANDO DE AJUDA (HELP)
# ==============================================================================

help: ## ✨ Exibe esta mensagem de ajuda
	@echo "Uso: make [alvo]"
	@echo ""
	@echo "Alvos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
