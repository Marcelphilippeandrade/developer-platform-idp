# Developer Workstation

## Objetivo

Esta documentação descreve como configurar uma estação de desenvolvimento capaz de executar integralmente a Developer Platform (IDP).

Ao final deste guia será possível:

- Executar o Backstage localmente
- Executar a Platform API
- Gerar novos microserviços
- Criar repositórios automaticamente no GitHub
- Executar pipelines GitHub Actions
- Publicar imagens no GitHub Container Registry (GHCR)
- Realizar deploy automático no Kubernetes (Minikube)
- Registrar automaticamente componentes no catálogo do Backstage

## Índice

- Arquitetura da Plataforma
- Requisitos
- Sistema Operacional
- WSL
- Git
- Java
- Maven
- Python
- Node.js
- NVM
- Yarn
- Docker Desktop
- Kubernetes
  - kubectl
  - Minikube
- GitHub
  - Personal Access Token
  - Variáveis de ambiente
  - GitHub Runner
- GitHub Container Registry (GHCR)
- Backstage
- Platform API
- Templates
- Cloudflare Tunnel
- Primeira execução
- Troubleshooting
- Roadmap

## Arquitetura da Plataforma

### Componentes

A Developer Platform é composta pelos seguintes componentes:

- Backstage Developer Portal
- Platform API
- Templates (Golden Paths)
- GitHub
- GitHub Actions
- GitHub Runner Self-hosted
- GitHub Container Registry (GHCR)
- Kubernetes (Minikube)
- Catálogo do Backstage

### Fluxo de Provisionamento

O fluxo abaixo apresenta a visão geral de como um novo microserviço é criado, desde a solicitação realizada pelo desenvolvedor até o deploy automático no Kubernetes.

```text
                           Developer
                               │
                               ▼
                    ┌──────────────────┐
                    │    Backstage     │
                    │ Developer Portal │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │   Platform API   │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ Template Engine  │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ GitHub Repository│
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ GitHub Actions   │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ Self-hosted      │
                    │ Runner           │
                    └───────┬──────────┘
                            │
           ┌────────────────┴────────────────┐
           ▼                                 ▼
┌────────────────────┐              ┌────────────────────┐
│ Docker Build       │              │ kubectl apply      │
└─────────┬──────────┘              └─────────┬──────────┘
          ▼                                   ▼
┌────────────────────┐              ┌────────────────────┐
│ GitHub Container   │              │ Kubernetes         │
│ Registry (GHCR)    │              │ (Minikube)         │
└────────────────────┘              └─────────┬──────────┘
                                              ▼
                                   ┌────────────────────┐
                                   │ Running Service    │
                                   └────────────────────┘
```

### Descrição do Fluxo

1. O desenvolvedor acessa o Backstage Developer Portal.
2. Seleciona um Golden Path para criação de um novo microserviço.
3. O Backstage envia a requisição para a Platform API.
4. A Platform API executa o Template Engine responsável pela geração do projeto.
5. O projeto é criado utilizando um dos templates disponíveis na plataforma.
6. O Backstage cria automaticamente um novo repositório no GitHub.
7. O código-fonte gerado é enviado para o repositório recém-criado.
8. O componente é registrado automaticamente no Software Catalog do Backstage.
9. O GitHub Actions inicia a pipeline de Integração Contínua (CI).
10. O GitHub Runner Self-hosted executa o build da aplicação.
11. A imagem Docker é publicada no GitHub Container Registry (GHCR).
12. O pipeline realiza o deploy automático da aplicação no Kubernetes (Minikube).
13. O GitHub Actions aguarda a conclusão do rollout do Deployment para garantir que a aplicação esteja saudável.
14. O microserviço fica disponível para utilização e pronto para ser consumido.

## Requisitos

Antes de iniciar a instalação da Developer Platform, certifique-se de possuir os seguintes requisitos:

- Windows 11
- WSL2 habilitado
- Ubuntu 22.04 LTS
- Conexão com a Internet
- Conta no GitHub
- Permissão para criar Personal Access Tokens (PAT)

---

## Sistema Operacional

### Objetivo

Definir o ambiente base utilizado para desenvolvimento e validação da Developer Platform.

### Ambiente utilizado

| Componente | Versão |
|------------|---------|
| Windows | 11 |
| WSL | Ubuntu 22.04 LTS |

### Verificação

No Windows execute:

```powershell
winver
```

No WSL execute:

```bash
lsb_release -a
```

### Problemas comuns

- WSL não instalado.
- Distribuição Linux diferente da utilizada na documentação.

---

## WSL

### Objetivo

Executar todos os componentes da plataforma em um ambiente Linux utilizando Windows Subsystem for Linux (WSL2).

### Instalação

Consulte a documentação oficial da Microsoft para instalação do WSL2 e do Ubuntu 22.04.

### Verificação

```bash
wsl --status
```

Resultado esperado:

- WSL versão 2
- Ubuntu instalado

### Problemas comuns

- Virtualização desabilitada na BIOS.
- WSL1 instalado em vez do WSL2.

---

## Git

### Objetivo

Controlar o versionamento do código-fonte da plataforma e dos microserviços gerados.

### Instalação

Instale o Git utilizando o gerenciador de pacotes da distribuição Linux.

### Verificação

```bash
git --version
```

### Problemas comuns

- Git não instalado.
- Usuário e e-mail não configurados.

---

## Java

### Objetivo

Executar aplicações Spring Boot e realizar o build dos projetos utilizando Maven.

### Instalação

Instale o Java 21 (Temurin).

### Verificação

```bash
java -version
```

Resultado esperado:

```
Java 21
```

### Problemas comuns

- JAVA_HOME não configurado.
- Versão diferente da suportada.

---

## Maven

### Objetivo

Gerenciar dependências e realizar o build dos projetos Java.

### Instalação

Instale o Maven.

### Verificação

```bash
mvn -version
```

### Problemas comuns

- JAVA_HOME incorreto.
- Maven não encontrado no PATH.

---

## Python

### Objetivo

Executar a Platform API responsável pela geração dos projetos.

### Instalação

Instale o Python 3.

### Verificação

```bash
python3 --version
```

### Problemas comuns

- Python não instalado.
- Ambiente virtual não configurado.

---

## Node.js

### Objetivo

Executar o Backstage Developer Portal.

### Instalação

Instale o Node.js utilizando o NVM.

### Verificação

```bash
node -v
```

### Problemas comuns

- Node instalado manualmente.
- Versão incompatível.

---

## NVM

### Objetivo

Gerenciar diferentes versões do Node.js.

### Instalação

Instale o NVM utilizando o script oficial.

### Verificação

```bash
nvm ls
```

### Problemas comuns

- nvm.sh não carregado no .bashrc.
- PATH incorreto.

---

## Yarn

### Objetivo

Gerenciar dependências do Backstage.

### Instalação

Instale o Yarn.

### Verificação

```bash
yarn -v
```

### Problemas comuns

- Yarn não instalado.
- Node.js não carregado.

---

## Docker Desktop

### Objetivo

Executar containers Docker utilizados pela plataforma.

### Instalação

Instale o Docker Desktop para Windows com integração ao WSL.

### Verificação

```bash
docker version
```

```bash
docker ps
```

### Problemas comuns

- Docker Desktop desligado.
- Integração com WSL desabilitada.

---

## Kubernetes

### Objetivo

Executar localmente os microserviços gerados pela plataforma.

### kubectl

#### Objetivo

Gerenciar o cluster Kubernetes.

#### Verificação

```bash
kubectl version --client
```

#### Problemas comuns

- kubectl não instalado.
- PATH incorreto.

### Minikube

#### Objetivo

Disponibilizar um cluster Kubernetes local.

#### Verificação

```bash
minikube status
```

Resultado esperado:

- host Running
- kubelet Running
- apiserver Running

#### Problemas comuns

- Docker Desktop desligado.
- Cluster parado.

---

## GitHub

### Personal Access Token

#### Objetivo

Permitir que o Backstage crie repositórios automaticamente utilizando a API do GitHub.

#### Verificação

Verifique se a variável de ambiente foi carregada corretamente:

```bash
echo $GITHUB_TOKEN
```

Caso a variável esteja configurada corretamente, o terminal deverá exibir o token.

#### Problemas comuns

- Token expirado
- Token não configurado
- Escopos insuficientes
- Token não carregado no ambiente

---

### Variáveis de ambiente

#### Objetivo

Centralizar todas as configurações locais necessárias para execução da Developer Platform.

---

#### Arquivo `.env.example`

O arquivo `.env.example` serve como modelo para criação do arquivo `.env`, contendo apenas exemplos de configuração utilizados pela Developer Platform.

##### Boas práticas

O arquivo `.env.example` **não deve conter informações sensíveis**.

Nunca adicione:

- Personal Access Tokens (PAT)
- Senhas
- Chaves privadas
- GitHub Secrets
- Credenciais de provedores Cloud (AWS, Azure, GCP, Cloudflare, etc.)

As credenciais reais devem existir apenas no arquivo `.env`, que está listado no `.gitignore` e nunca deve ser versionado.

##### Exemplo

Arquivo `.env.example`:

```text
GITHUB_TOKEN=
GHCR_USERNAME=your-github-username
MINIKUBE_PROFILE=minikube
BACKSTAGE_PORT=3000
PLATFORM_API_PORT=8000
```

Após copiar o arquivo:

```bash
cp .env.example .env
```

Edite o arquivo `.env` informando os valores reais do ambiente.

##### Observação

O GitHub Push Protection bloqueia automaticamente commits contendo credenciais válidas.

Caso isso ocorra:

- Remova imediatamente o segredo do arquivo.
- Recrie o commit utilizando `git commit --amend`.
- Realize um novo push.

---

#### Carregando as variáveis de ambiente

Após configurar o arquivo `.env`, carregue as variáveis antes de executar qualquer componente da Developer Platform:

```bash
source scripts/load-env.sh
```

O bootstrap executará automaticamente:

- Validação da existência do arquivo `.env`
- Carregamento das variáveis de ambiente
- Validação das variáveis obrigatórias
- Interrupção da execução caso alguma configuração esteja ausente (Fail Fast)

Valide se as variáveis foram carregadas corretamente:

```bash
echo $GITHUB_TOKEN
echo $BACKSTAGE_PORT
echo $PLATFORM_API_PORT
```

Resultado esperado:

```text
ghp_xxxxxxxxxxxxxxxxxxxxxxxxx
3000
8000
```

##### Importante

Não execute:

```bash
./scripts/load-env.sh
```

nem:

```bash
bash scripts/load-env.sh
```

Esses comandos executam o script em um novo processo (*subshell*). Como consequência, as variáveis de ambiente são descartadas ao final da execução e **não permanecem disponíveis** no terminal atual.

Sempre utilize:

```bash
source scripts/load-env.sh
```

---

### GitHub Runner

#### Objetivo

Executar localmente os workflows do GitHub Actions utilizando um Self-hosted Runner.

#### Verificação

Inicie o Runner:

```bash
./run.sh
```

Ou verifique no GitHub se o Runner aparece com o status **Idle**.

#### Problemas comuns

- Runner Offline
- Runner removido do repositório
- Token expirado

### Arquivo .env.example

#### Objetivo

O arquivo `.env.example` serve como modelo para criação do arquivo `.env`, contendo apenas exemplos de configuração utilizados pela Developer Platform.

#### Boas práticas

O arquivo `.env.example` **não deve conter informações sensíveis**.

Nunca adicione:

- Personal Access Tokens (PAT)
- Senhas
- Chaves privadas
- Secrets do GitHub
- Credenciais de provedores Cloud (AWS, Azure, GCP, Cloudflare, etc.)

As credenciais reais devem existir apenas no arquivo `.env`, que está listado no `.gitignore` e nunca deve ser versionado.

#### Exemplo

Arquivo `.env.example`:

```text
GITHUB_TOKEN=
GHCR_USERNAME=your-github-username
MINIKUBE_PROFILE=minikube
BACKSTAGE_PORT=3000
PLATFORM_API_PORT=8000
```

Após copiar o arquivo:

```bash
cp .env.example .env
```

Edite o arquivo `.env` informando os valores reais do ambiente.

#### Observação

O GitHub Push Protection bloqueia automaticamente commits contendo credenciais válidas.

Caso isso ocorra:

- Remova imediatamente o segredo do arquivo.
- Recrie o commit utilizando `git commit --amend`.
- Realize um novo push.

---

### Carregando as variáveis de ambiente

Após configurar o arquivo `.env`, carregue as variáveis antes de executar qualquer componente da Developer Platform:

```bash
source scripts/load-env.sh
```

O bootstrap executará automaticamente:

Caso alguma configuração obrigatória esteja ausente, o bootstrap interromperá imediatamente a execução (Fail Fast), informando qual variável deve ser corrigida.

- Validação da existência do arquivo `.env`
- Carregamento das variáveis de ambiente
- Validação das variáveis obrigatórias
- Interrupção da execução caso alguma configuração esteja ausente

Valide se as variáveis foram carregadas corretamente:

```bash
echo $GITHUB_TOKEN
echo $BACKSTAGE_PORT
echo $PLATFORM_API_PORT
```
Resultado esperado:

```text
ghp_xxxxxxxxxxxxxxxxxxxxxxxxx
3000
8000
```

#### Importante

Não execute:

```bash
./scripts/load-env.sh
```

nem:

```bash
bash scripts/load-env.sh
```

Esses comandos executam o script em um processo separado e as variáveis de ambiente **não permanecerão disponíveis** no terminal atual.

Sempre utilize:

```bash
source scripts/load-env.sh
```

---

### GitHub Runner

#### Objetivo

Executar localmente os workflows do GitHub Actions utilizando um Self-hosted Runner.

#### Verificação

Inicie o Runner:

```bash
./run.sh
```

Ou verifique no GitHub se o Runner aparece com o status **Idle**.

#### Problemas comuns

- Runner Offline.
- Runner removido do repositório.
- Token de registro expirado.
- Serviço não iniciado.

## GitHub Container Registry (GHCR)

### Objetivo

Armazenar as imagens Docker geradas pela pipeline.

### Verificação

```bash
docker login ghcr.io
```

### Problemas comuns

- Permissões insuficientes.
- Namespace incorreto da imagem.

---

## Backstage

### Objetivo

Portal central para criação e gerenciamento de microserviços.

### Verificação

```bash
yarn start
```

Acesse:

```
http://localhost:3000
```

### Problemas comuns

- Node não carregado.
- GITHUB_TOKEN ausente.

---

## Platform API

### Objetivo

Gerar automaticamente novos projetos a partir dos Golden Paths.

### Verificação

```bash
uvicorn app.main:app --reload
```

Acesse:

```
http://localhost:8000/docs
```

### Problemas comuns

- Ambiente virtual não ativado.
- Dependências não instaladas.

---

## Templates

### Objetivo

Definir a estrutura padrão dos microserviços gerados pela plataforma.

### Verificação

Verifique se o diretório existe:

```bash
ls ~/platform/templates
```

### Problemas comuns

- Placeholders hardcoded.
- Template desatualizado.

---

## Cloudflare Tunnel

### Objetivo

Expor serviços locais para acesso externo quando necessário.

### Verificação

```bash
cloudflared tunnel list
```

### Problemas comuns

- Tunnel parado.
- Token inválido.

---

## Primeira execução

Após concluir todas as instalações:

1. Inicie o Docker Desktop.
2. Inicie o Minikube.
3. Execute a Platform API.
4. Execute o Backstage.
5. Verifique se o GitHub Runner está online.
6. Crie um microserviço utilizando um Golden Path.
7. Valide a execução da pipeline.
8. Valide o deploy automático no Kubernetes.

---

## Troubleshooting

Esta seção reúne os principais problemas encontrados durante o desenvolvimento da plataforma e suas respectivas soluções.

Exemplos:

- GITHUB_TOKEN não encontrado.
- ImagePullBackOff.
- GHCR Unauthorized.
- kubectl rollout timeout.
- Placeholder hardcoded.
- Node.js não carregado via NVM.
- Runner Offline.

---

## Roadmap

Próximas evoluções previstas para a Developer Platform:

- Setup automatizado da estação (`setup.sh`)
- Validação automática do ambiente (`doctor.sh`)
- Integração completa com TechDocs
- Novos Golden Paths
- Observabilidade da plataforma
- Deploy em ambiente cloud