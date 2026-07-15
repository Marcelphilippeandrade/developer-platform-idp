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

## Cenário 3 — Usuário cancela a instalação

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

# Matriz de Validação

| Cenário | Status |
|----------|--------|
| Java já instalado | ✅ PASS |
| Instalação automática do Java | ✅ PASS |
| Cancelamento da instalação do Java | ✅ PASS |

---

# Histórico de Execução

| Data | Sprint | Commit | Responsável |
|------|--------|---------|-------------|
| 15/07/2026 | Sprint 3 | Commit 4 | Marcel Philippe Abreu Andrade |

---

# Conclusão

Os testes executados confirmam que o fluxo de instalação do Java está funcionando conforme o esperado para os principais cenários previstos:

- Ambiente previamente configurado.
- Ambiente sem Java instalado.
- Cancelamento da instalação pelo usuário.

Com essa validação concluída, o fluxo implementado para o Java passa a servir como referência para a implementação dos próximos componentes da Developer Platform, como Maven, Node.js, Docker, kubectl, Minikube e demais dependências da estação de desenvolvimento.