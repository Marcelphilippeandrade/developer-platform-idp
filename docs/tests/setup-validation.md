# Validação do Setup

## Visão Geral

Este documento descreve os cenários de validação executados para o script `setup.sh` da Developer Platform.

O objetivo é garantir que o processo de configuração da estação de desenvolvimento funcione corretamente em diferentes cenários de instalação e configuração do ambiente.

---

# Ambiente de Testes

## Sistema Operacional

| Componente | Versão |
|------------|---------|
| Windows | 11 |
| WSL | 2 |
| Ubuntu | 22.04 LTS |

## Branch

```
feature/developer-workstation
```

## Script Validado

```
scripts/setup.sh
```

---

# Cenários de Validação

## Cenário 1 — Java já instalado

### Objetivo

Validar que o `setup.sh` detecta uma instalação existente do Java sem tentar reinstalá-lo.

### Resultado esperado

- Detectar o Java instalado.
- Exibir a versão instalada.
- Não solicitar instalação.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 2 — Java não instalado

### Objetivo

Validar que o `setup.sh` instala automaticamente o OpenJDK 21 quando o Java não está disponível.

### Resultado esperado

- Detectar ausência do Java.
- Solicitar confirmação ao usuário.
- Atualizar a lista de pacotes (`apt update`).
- Instalar o OpenJDK 21.
- Validar a instalação.
- Exibir a versão instalada.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 3 — Usuário cancela a instalação do Java

### Objetivo

Validar que o processo de instalação é interrompido quando o usuário opta por não instalar o Java.

### Resultado esperado

- Detectar ausência do Java.
- Solicitar confirmação ao usuário.
- Usuário responde **Não**.
- Encerrar o setup.
- Exibir mensagem informando que a instalação foi cancelada.

### Resultado obtido

**PASS**

---

## Cenário 4 — Maven já instalado

### Objetivo

Validar que o `setup.sh` detecta uma instalação existente do Apache Maven sem tentar reinstalá-lo.

### Resultado esperado

- Detectar o Maven instalado.
- Exibir a versão instalada.
- Não solicitar instalação.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 5 — Maven não instalado

### Objetivo

Validar que o `setup.sh` instala automaticamente o Apache Maven quando ele não está disponível.

### Resultado esperado

- Detectar ausência do Maven.
- Solicitar confirmação ao usuário.
- Instalar o Apache Maven.
- Validar a instalação.
- Exibir a versão instalada.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 6 — Usuário cancela a instalação do Maven

### Objetivo

Validar que o processo de instalação é interrompido quando o usuário opta por não instalar o Apache Maven.

### Resultado esperado

- Detectar ausência do Maven.
- Solicitar confirmação ao usuário.
- Usuário responde **Não**.
- Encerrar o setup.
- Exibir mensagem informando que a instalação foi cancelada.

### Resultado obtido

**PASS**

---

## Cenário 7 — Runtime Node.js já instalado

### Objetivo

Validar que o `setup.sh` detecta uma instalação existente do Runtime Node.js sem tentar reinstalar seus componentes.

### Resultado esperado

- Detectar o NVM.
- Detectar o Node.js.
- Detectar o npm.
- Exibir as versões instaladas.
- Não solicitar instalação.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 8 — Runtime Node.js não instalado

### Objetivo

Validar que o `setup.sh` instala automaticamente o Runtime Node.js quando ele não está disponível.

### Resultado esperado

- Detectar ausência do NVM.
- Solicitar confirmação ao usuário.
- Instalar o NVM.
- Carregar o NVM na sessão atual.
- Validar a instalação do NVM.
- Instalar o Node.js LTS.
- Validar o Node.js.
- Validar o npm.
- Exibir as versões instaladas.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 9 — Docker Desktop instalado, porém desligado

### Objetivo

Validar que o `setup.sh` detecta quando o Docker Desktop está instalado, porém não está em execução, orientando corretamente o usuário a iniciá-lo antes de continuar.

### Resultado esperado

- Detectar ausência do Docker CLI.
- Detectar o Docker Desktop instalado.
- Informar que o Docker Desktop não está em execução.
- Orientar o usuário a iniciar o Docker Desktop.
- Encerrar o setup.
- Não executar a validação do Docker Compose.

### Resultado obtido

**PASS**

---

## Cenário 10 — Docker Desktop não instalado

### Objetivo

Validar que o `setup.sh` detecta a ausência do Docker Desktop e orienta corretamente o usuário para realizar sua instalação antes de prosseguir.

### Resultado esperado

- Detectar ausência do Docker CLI.
- Detectar ausência do Docker Desktop.
- Exibir instruções para instalação do Docker Desktop.
- Orientar a habilitação da integração com WSL.
- Orientar a reinicialização do WSL.
- Encerrar o setup.

### Resultado obtido

**PASS**

---

## Cenário 11 — Docker Runtime e Docker Compose já instalados

### Objetivo

Validar que o `setup.sh` detecta uma instalação funcional do Docker Runtime e do Docker Compose sem realizar nenhuma ação adicional.

### Resultado esperado

- Detectar o Docker.
- Capturar a versão instalada do Docker.
- Detectar o Docker Compose.
- Capturar a versão instalada do Docker Compose.
- Não exibir mensagens de orientação do Docker Desktop.
- Continuar normalmente a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 12 — Yarn já instalado

### Objetivo

Validar que o `setup.sh` detecta uma instalação existente do Yarn sem tentar reinstalá-lo.

### Resultado esperado

- Detectar o Yarn instalado.
- Exibir a versão instalada.
- Não solicitar instalação.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

---

## Cenário 13 — Instalação automática do Yarn

### Objetivo

Validar o fluxo de instalação automática do Yarn quando ele não está disponível.

### Resultado esperado

- Detectar ausência do Yarn.
- Solicitar confirmação ao usuário.
- Iniciar o processo de instalação.
- Validar a instalação.
- Exibir a versão instalada.
- Continuar a execução do setup.

### Resultado obtido

**PASS**

### Observação

Durante a homologação foi utilizada uma simulação controlada da instalação para preservar a integridade do ambiente de desenvolvimento.

O comando real:

```bash
npm install --global yarn
```

foi temporariamente substituído por uma simulação do processo de instalação.

A homologação da instalação real será realizada futuramente em um ambiente limpo (VM, WSL recém-instalado ou container).

---

## Cenário 14 — Usuário cancela a instalação do Yarn

### Objetivo

Validar que o processo de instalação é interrompido quando o usuário opta por não instalar o Yarn.

### Resultado esperado

- Detectar ausência do Yarn.
- Solicitar confirmação ao usuário.
- Usuário responde **Não**.
- Encerrar o setup.
- Exibir mensagem informando que a instalação foi cancelada.

### Resultado obtido

**PASS**

---

# Matriz de Validação

| Cenário | Status |
|----------|--------|
| Java já instalado | ✅ PASS |
| Instalação automática do Java | ✅ PASS |
| Cancelamento da instalação do Java | ✅ PASS |
| Maven já instalado | ✅ PASS |
| Instalação automática do Maven | ✅ PASS |
| Cancelamento da instalação do Maven | ✅ PASS |
| Runtime Node.js já instalado | ✅ PASS |
| Instalação automática do Runtime Node.js | ✅ PASS |
| Docker Desktop instalado e desligado | ✅ PASS |
| Docker Desktop não instalado | ✅ PASS |
| Docker Runtime já instalado | ✅ PASS |
| Yarn já instalado | ✅ PASS |
| Instalação automática do Yarn | ✅ PASS |
| Cancelamento da instalação do Yarn | ✅ PASS |

---

# Histórico de Execução

| Data | Sprint | Commit | Responsável |
|------|--------|---------|-------------|
| 15/07/2026 | Sprint 3 | Commit 4 | Marcel Philippe Abreu Andrade |
| 16/07/2026 | Sprint 3 | Commit 5 | Marcel Philippe Abreu Andrade |
| 22/07/2026 | Sprint 3 | Commit 6 | Marcel Philippe Abreu Andrade |
| 26/07/2026 | Sprint 3 | Commit 7 | Marcel Philippe Abreu Andrade |
| 29/07/2026 | Sprint 3 | Commit 8 | Marcel Philippe Abreu Andrade |

---

# Conclusão

# Conclusão

Os testes executados confirmam que os fluxos de instalação e validação do Java, Apache Maven, Runtime Node.js, Docker Runtime e Yarn estão funcionando conforme o esperado para todos os cenários previstos.

Foram validados com sucesso:

- Ambiente previamente configurado.
- Ambiente sem o componente instalado.
- Instalação automática dos componentes suportados.
- Validação pós-instalação.
- Diagnóstico do ambiente Docker.
- Orientação para inicialização do Docker Desktop.
- Orientação para instalação do Docker Desktop.
- Exibição das versões instaladas.
- Continuidade do processo de configuração da estação de desenvolvimento quando todos os componentes estão disponíveis.

Durante a homologação do Yarn foi utilizada uma simulação controlada da instalação para preservar a integridade do ambiente de desenvolvimento. A validação da instalação real será executada futuramente em um ambiente limpo.

Com essa validação concluída, a arquitetura implementada para Java, Apache Maven, Runtime Node.js, Docker Runtime e Yarn passa a servir como padrão para os próximos componentes da Developer Platform, como kubectl e Minikube.