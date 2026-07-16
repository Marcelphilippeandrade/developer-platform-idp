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

# Matriz de Validação

| Cenário | Status |
|----------|--------|
| Java já instalado | ✅ PASS |
| Instalação automática do Java | ✅ PASS |
| Cancelamento da instalação do Java | ✅ PASS |
| Maven já instalado | ✅ PASS |
| Instalação automática do Maven | ✅ PASS |
| Cancelamento da instalação do Maven | ✅ PASS |

---

# Histórico de Execução

| Data | Sprint | Commit | Responsável |
|------|--------|---------|-------------|
| 15/07/2026 | Sprint 3 | Commit 4 | Marcel Philippe Abreu Andrade |
| 16/07/2026 | Sprint 3 | Commit 5 | Marcel Philippe Abreu Andrade |

---

# Conclusão

Os testes executados confirmam que os fluxos de instalação automática do Java e do Apache Maven estão funcionando conforme o esperado para todos os cenários previstos.

Foram validados com sucesso:

- Ambiente previamente configurado.
- Ambiente sem o componente instalado.
- Cancelamento da instalação pelo usuário.
- Validação pós-instalação.
- Exibição da versão instalada.

Com essa validação concluída, a arquitetura implementada para Java e Maven passa a servir como padrão para os próximos componentes da Developer Platform, como Node.js, npm, Yarn, Docker, kubectl e Minikube.