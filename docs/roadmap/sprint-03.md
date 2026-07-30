# Sprint 03

## Objetivo

Criar o instalador da estação de desenvolvimento.

---

## Estratégia de desenvolvimento

Todos os componentes da Developer Platform seguem o mesmo fluxo de implementação:

1. Definição da arquitetura.
2. Detecção do componente.
3. Captura da versão instalada.
4. Instalação (quando suportada).
5. Validação pós-instalação.
6. Testes ponta a ponta.
7. Documentação.
8. Commit e homologação.

---

## Funcionalidades

### Commit 1

Criação da estrutura inicial do `setup.sh`.

---

### Commit 2

Detecção do ambiente.

**Implementações:**

- Sistema Operacional
- Distribuição Linux
- Versão Ubuntu
- WSL2

---

### Commit 3

Validação dos pré-requisitos do sistema.

**Implementações:**

- Git
- curl
- wget
- unzip
- sudo

---

### Commit 4

Instalação automática do Java.

**Implementações:**

- Detecção do Java
- Captura da versão instalada
- Solicitação de instalação
- Atualização da lista de pacotes
- Instalação automática
- Validação pós-instalação
- Exibição da versão instalada
- Testes ponta a ponta

---

### Commit 5

Instalação automática do Apache Maven.

**Implementações:**

- Detecção do Maven
- Captura da versão instalada
- Solicitação de instalação
- Instalação automática
- Validação pós-instalação
- Exibição da versão instalada
- Testes ponta a ponta

**Melhorias Futuras**

- Detectar componentes instalados no Windows.
- Recomendar instalação nativa no Ubuntu.
- Validar o PATH da estação de desenvolvimento.

---

### Commit 6

Instalação automática do Runtime Node.js.

**Implementações:**

- Detecção do NVM
- Instalação automática do NVM
- Carregamento do NVM na sessão atual
- Validação pós-instalação do NVM
- Instalação automática do Node.js LTS
- Validação do Node.js
- Validação do npm
- Exibição das versões instaladas
- Tratamento de erro durante a instalação do Node.js
- Testes ponta a ponta

**Cenários Validados**

- Ambiente com Runtime Node.js previamente instalado
- Ambiente sem Runtime Node.js instalado

**Melhorias Futuras**

- Detectar automaticamente instalações do NVM mesmo quando `NVM_DIR` não estiver definido.
- Tornar a detecção do Runtime Node.js mais resiliente ao ambiente do shell.
- Melhorar o tratamento de falhas durante o download do instalador do NVM.

---

### Commit 7

**Objetivo**

Garantir que a estação de desenvolvimento possua um ambiente Docker funcional, validando a disponibilidade do Docker CLI, do Docker Desktop e do Docker Compose.

---

**Implementações**

- Detecção do Docker CLI.
- Captura da versão instalada do Docker.
- Detecção do Docker Desktop.
- Verificação da instalação do Docker Desktop no Windows.
- Orientação para inicialização do Docker Desktop quando instalado.
- Orientação para instalação do Docker Desktop quando ausente.
- Detecção do Docker Compose.
- Captura da versão instalada do Docker Compose.
- Encerramento controlado do setup quando o Docker não está disponível.
- Testes ponta a ponta.

---

**Cenários Validados**

- Docker Desktop instalado e desligado.
- Docker Desktop não instalado.
- Docker Desktop iniciado.
- Docker CLI detectado e versão capturada.
- Docker Compose detectado e versão capturada.

---

**Melhorias Futuras**

- Validar automaticamente quando o Docker Desktop terminar de inicializar.
- Detectar problemas na integração WSL.
- Detectar quando a integração WSL estiver desabilitada.
- Melhorar as mensagens de erro.

---

### Commit 8

**Objetivo**

Garantir que a estação de desenvolvimento possua uma instalação funcional do Yarn, realizando sua detecção, instalação automática (quando necessário) e validação pós-instalação.

---

**Implementações**

- Detecção do Yarn.
- Captura da versão instalada.
- Solicitação de instalação ao usuário.
- Instalação automática do Yarn via npm.
- Validação pós-instalação.
- Exibição da versão instalada.
- Encerramento controlado quando a instalação é recusada.
- Testes ponta a ponta.

---

**Cenários Validados**

- Yarn previamente instalado.
- Instalação automática do Yarn.
- Cancelamento da instalação pelo usuário.

---

**Melhorias Futuras**

- Permitir seleção da versão do Yarn.
- Validar versões mínimas suportadas.
- Detectar automaticamente instalações realizadas via Corepack.
- Adicionar suporte ao modo de simulação (`--dry-run`) para homologação sem alterar o ambiente.

---

### Commit 9

Planejado.

Próximas implementações:

- kubectl

---

### Commit 10

Planejado.

Próximas implementações:

- Minikube

---

### Commit 11

Planejado.

Próximas implementações:

- Resumo final da estação de desenvolvimento.

---

## Entregas

- `scripts/setup.sh`

---

## Status

🚧 Em andamento

Commit 8 concluído.
Próximo objetivo: Commit 9 — kubectl.