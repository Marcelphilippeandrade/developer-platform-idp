# Platform Architecture

## Components

### Backstage

Developer Portal.

Responsibilities:

- Catalog
- Templates
- Scaffolder

---

### Platform API

FastAPI service.

Responsibilities:

- Receive requests from Backstage
- Invoke generators

---

### Generators

Shell scripts responsible for generating source code.

---

### Templates

Golden paths.

Examples:

- springboot-api
- springboot-postgres-api

---

### GitHub Actions

Build and publish containers.

---

### Kubernetes

Runtime platform.