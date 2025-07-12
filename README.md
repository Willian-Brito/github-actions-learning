# 📱 Todo List App

Este repositório é baseado na aplicação oficial [todo-csharp-sql](https://github.com/Azure-Samples/todo-csharp-sql) da Microsoft. A aplicação demonstra uma API REST simples para gerenciamento de tarefas ("todos"), desenvolvida com ASP.NET Core e utilizando SQL Server como base de dados e React no Front-end.

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/web.png"/>
</div>

## 🧩 Arquitetura Original do Todo List App

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/resources-with-apim.png"/>
</div>

## 🎯 Objetivo

O objetivo principal deste repositório é **criar uma estrutura profissional de CI/CD utilizando GitHub Actions**, aplicando boas práticas de automação para projetos .NET.

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/ci-cd.png"/>
</div>

## 🧪 Projeto de Integração Contínua (CI)
Executada automaticamente a cada `push` ou `pull request` na branch principal (`main`):

**1. Versionamento**
  - Atualiza automaticamente a versão do projeto com base em tags.

**2. Build da Aplicação**
  - Compila a solução com dotnet build para garantir que o código não tenha erros de compilação.

**3. Execução de Testes**
  - Lint
  - Testes Unitários
  - Testes de Integração
  - SCA (Análise de Composição de Software)
  - SAST (Teste de Segurança Estáticos)

**4. Packing**
- Empacota a aplicação em um ou mais pacotes `.nupkg` ou prepara os artefatos com `dotnet pack`.

**5. Publicação de Artefatos**
  - O build é ser empacotado e salvo como artefato.

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/ci.png"/>
</div>

## 🚀 Projeto de Entrega Contínua (CD)
Executada automaticamente a cada geração de release e faz o deploy em ambientes de staging ou produção.

**1. Deploy em Homologação**
  - Automatiza o deploy para um ambiente de testes após o merge na branch principal.
  - Testes e2e
  - Testes de Performance
  - DAST (Teste de Segurança Dinâmicos)

**2. Deploy em Produção**
  - Após a validação e aprovação, o projeto poderá ser publicado automaticamente em ambientes de produção nas principais nuvens:
    - Google Cloud Platform (GCP)
    - Microsoft Azure
    - Amazon Web Services (AWS).

**3. Notificações (Opcional)**
  - Integra com ferramentas de comunicação (Slack, Teams, e-mail) para notificar falhas ou sucessos no pipeline.

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/cd-2.png"/>
</div>

---

# 🛠️ Introdução ao GitHub Actions

O GitHub Actions é uma poderosa funcionalidade do GitHub que permite automatizar workflows de CI/CD (Integração Contínua / Entrega Contínua) diretamente dentro do seu repositório.

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/inicio.png"/>
</div>

## 📌 O que é ?

GitHub Actions é um sistema de automação baseado em eventos, usado para:

- Testar código automaticamente (CI)
- Buildar e publicar pacotes/imagens (CD)
- Fazer deploys em produção, staging ou homologação
- Rodar scripts de verificação, lint, segurança, etc.
- Integrar com serviços externos (Docker Hub, Azure, AWS, etc.)

## 🔗 Como funciona?
Você define workflows como arquivos YAML no diretório:
```bash
.github/workflows/
```
**Exemplo de arquivo:** `.github/workflows/ci.yml`

Cada workflow é ativado por gatilhos, como:

- `push`
- `pull_request`
- `schedule` (cron)
- `workflow_dispatch` (manual)

## 🧩 Componentes do GitHub Actions

<div align="center">
  <img src="https://raw.githubusercontent.com/Willian-Brito/github-actions-learning/refs/heads/main/assets/componentes-github-actions.png"/>
</div>

### 🔀 1. Workflow
É um **processo de automação configurável**, é o **arquivo principal de automação**, escrito em **YAML**, que define quando e o que deve ser executado.

- Local: `.github/workflows/nome-do-workflow.yml`
- Pode conter um ou mais jobs
- Executado em resposta a eventos

**Exemplo:**
```yaml
name: CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Rodando build..."
```

### ⚙️ 2. Jobs
São **blocos de execução (steps ou actions) independentes** dentro de um workflow.

- Cada job roda em um runner separado
- Você pode ter múltiplos jobs (por exemplo: `build`, `test`, `deploy`)
- Pode configurar dependências entre jobs

**Exemplo:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Compilando..."

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Testando..."
```

### 🔁 3. Steps
São os passos executados dentro de um job.

- Executam comandos ou actions
- Podem usar scripts shell (`run:`) ou ações reutilizáveis (`uses:`)

**Exemplo:**
```yaml
steps:
  - name: Checkout do código
    uses: actions/checkout@v3

  - name: Instalar dependências
    run: npm install
```

### ⚡ 4. Actions
São componentes reutilizáveis que fazem tarefas específicas.

- Criadas pela comunidade ou por você
- Exemplos: `actions/checkout`, `actions/setup-node`, `docker/build-push-action`

**Exemplo:**
```yaml
- uses: actions/checkout@v3
- uses: actions/setup-node@v3
  with:
    node-version: 18
```
Você pode criar suas próprias actions também, com `Docker` ou `Node.js`.

### 🔔 5. Events
São os gatilhos que disparam o workflow.

- Podem ser manual ou por agendamento
- Alguns exemplos de eventos: 
    - `create` 
    - `pull_request`
    - `issue_comment` 
    - `push` 
    - `schedules`
    - `project_card` 
    - `workflow_dispatch`

**Exemplo:**
```yaml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
```

### 🧑‍💻 6. Runners
São os ambientes onde os jobs rodam.

- É um **servidor** que executa um **workflow** quando um **evento** ocorre
- GitHub fornece **runners hospedados:** ubuntu-latest, windows-latest, macos-latest
- Você pode configurar seus próprios **self-hosted runners**
- Cada **runner** executa um **job** por vez.

**Exemplo:**
```yaml
runs-on: ubuntu-latest
```

### 🔐 7. Variáveis e Segredos (Secrets & Vars)
O GitHub Actions permite definir valores dinâmicos e seguros por meio de:

🔡 Variáveis (`env:`)
- São visíveis e acessíveis no workflow
- Usadas para reutilizar valores comuns

```yaml
env:
  NODE_ENV: production
  APP_PORT: 8080
```
Ou por step:

```yaml
- run: echo "Porta: $APP_PORT"
```

### 🔒 Segredos (secrets)

- São valores sensíveis  (tokens, senhas, chaves)
- São definidos no GitHub:
    - Repositório → Settings → Secrets and variables
- Usados com `secrets.NOME`

```yaml
- name: Autenticar no Docker Hub
  run: docker login -u ${{ secrets.DOCKER_USER }} -p ${{ secrets.DOCKER_PASS }}
```

> ⚠️ Os segredos são mascarados nos logs e não podem ser impressos com `echo`.


### ✅ Resumo rápido (tabela)

| Componente    | O que é?                                                         |
| ------------- | ---------------------------------------------------------------- |
| **Workflow**  | Arquivo `YAML` que define a automação                            |
| **Jobs**      | Blocos paralelos (ou dependentes) de execução                    |
| **Steps**     | Comandos ou ações dentro de um job                               |
| **Actions**   | Scripts reutilizáveis para tarefas comuns                        |
| **Events**    | Gatilhos que disparam o workflow                                 |
| **Runners**   | Máquinas onde os jobs são executados                             |
| **Variáveis** | Valores reutilizáveis definidos com `env`, visíveis no workflow  |
| **Segredos**  | Valores sensíveis (tokens, senhas), acessados via `secrets.NOME` |

---

## 📝 Arquivos YAML
O **YAML (Yet Another Markup Language — ou "YAML Ain’t Markup Language", na definição moderna)** é um formato de arquivo muito usado para configuração, especialmente em ferramentas como:

- GitHub Actions (`.yml`)
- Docker Compose (`docker-compose.yml`)
- Kubernetes (`deployment.yaml`)
- CI/CD (GitLab, Travis, etc.) 

### 📘 Principais Características do YAML

| Característica          | Descrição                                                                 |
| ----------------------- | ------------------------------------------------------------------------- |
| **Leve e legível**      | Usa indentação com espaços para estruturar dados, sem colchetes ou chaves |
| **Baseado em texto**    | Fácil de ler e escrever, ideal para configs versionadas                   |
| **Hierárquico**         | Representa estruturas aninhadas com **espaços**                           |
| **Suporta comentários** | Começam com `#`                                                           |

### 🔧 Regras importantes
- ❗ Indentação é obrigatória (use espaços, nunca tab)
- ✅ Nomes e valores são definidos como chave: valor
- 🔢 Suporta listas, objetos e tipos primitivos

### 🧩 Tipos de dados suportados

```yaml
# String
nome: "Willian"

# Número
idade: 30

# Booleano
ativo: true

# Lista
tecnologias:
  - docker
  - vue
  - dotnet

# Objeto
banco:
  host: localhost
  porta: 5432
```

### 🛑 Dicas para evitar erros

| Erro comum                             | Correção                            |
| -------------------------------------- | ----------------------------------- |
| Usar tab para indentar                 | Use **espaços** (2 ou 4, padronize) |
| Esquecer dois pontos                   | Cada chave deve ter `:` após o nome |
| Não manter indentação                  | Indente corretamente os blocos      |
| Tipar sem aspas valores com `:` ou `#` | Use aspas para strings especiais    |
