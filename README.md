# Projeto de Estudo: Elastic Stack com Django

Este projeto é um ambiente de desenvolvimento para estudar a integração da Elastic Stack (Elasticsearch, Kibana, Beats, APM) com uma aplicação Django.

## Visão Geral

O projeto consiste em:

- **Aplicação Django:** Uma aplicação web simples para gerar dados e logs.
- **Elasticsearch:** Para armazenamento e busca de dados.
- **Kibana:** Para visualização e análise dos dados no Elasticsearch.
- **Metricbeat:** Para coletar métricas do host e dos contêineres Docker.
- **Heartbeat:** Para monitorar a disponibilidade dos serviços.
- **APM Server:** Para monitorar a performance da aplicação Django.
- **Nginx:** Como proxy reverso para a aplicação Django.

## Pré-requisitos

- Docker
- Docker Compose
- Make (opcional, para usar os comandos do `Makefile`)

## Como Executar

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/higorrsc/fc-hrsc-elastic-stack.git
   cd fc-hrsc-elastic-stack
   ```

2. **Crie a rede Docker:**

   ```bash
   docker network create observability
   ```

3. **Inicie a stack do Elastic:**

   Use o Makefile para subir os serviços do Elastic (Elasticsearch, Kibana, Beats, APM):

   ```bash
   make elastic-up
   ```

   Ou, se não estiver usando o `make`, execute o comando `docker-compose` diretamente:

   ```bash
   docker-compose up -d
   ```

4. **Inicie a aplicação Django:**

   Use o Makefile para construir e subir os contêineres da aplicação (Django, Nginx):

   ```bash
   make app-build
   ```

   Ou, se não estiver usando o `make`:

   ```bash
   docker-compose -f app/docker-compose.yml up -d --build
   ```

## Acessando os Serviços

- **Aplicação Django:** [http://localhost](http://localhost)
- **Kibana:** [http://localhost:5601](http://localhost:5601)
- **Elasticsearch:** [http://localhost:9200](http://localhost:9200)
- **APM Server:** [http://localhost:8200](http://localhost:8200)

## Comandos Úteis (Makefile)

- `make help`: Exibe a lista de todos os comandos disponíveis.
- `make elastic-up`: Sobe os contêineres do Elastic.
- `make elastic-down`: Para e remove os contêineres do Elastic.
- `make app-build`: Constrói e sobe os contêineres da aplicação.
- `make app-up`: Sobe os contêineres da aplicação.
- `make app-down`: Para e remove os contêineres da aplicação.

## Estrutura do Projeto

```
.
├── apm/                  # Configurações do APM Server
├── app/                  # Aplicação Django
│   ├── codeprogress/     # Projeto Django
│   ├── exemplo/          # App Django
│   ├── Dockerfile        # Dockerfile da aplicação
│   └── docker-compose.yml # Docker Compose da aplicação
├── beats/                # Configurações dos Beats
│   ├── heartbeat/
│   └── metric/
├── elasticsearch_data/   # Dados do Elasticsearch
├── nginx/                # Configurações do Nginx
├── .gitignore
├── compose.yml           # Docker Compose da stack Elastic
├── Makefile              # Comandos para facilitar o desenvolvimento
└── README.md
```

## Tecnologias Utilizadas

- **Backend:** Django 3.0.8
- **Servidor Web:** Nginx
- **Banco de Dados:** SQLite (padrão do Django, para simplicidade)
- **Observabilidade:**
  - Elasticsearch 7.13.0
  - Kibana 7.13.0
  - Metricbeat 7.13.0
  - Heartbeat 7.13.0
  - APM Server 7.13.0
- **Containerização:** Docker, Docker Compose
