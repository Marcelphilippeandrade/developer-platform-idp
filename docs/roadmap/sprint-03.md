# Sprint 03

## Objetivo

Criar o instalador da estação de desenvolvimento.

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

Planejado.

Próximas implementações:

- Yarn

---

### Commit 8

Planejado.

Próximas implementações:

- Docker

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