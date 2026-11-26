---
layout: post
title: "idempotency-demo: charge at most once with Idempotency-Key in Spring Boot"
description: "A Spring Boot payments endpoint where retries replay the stored response, a reused key with another body gets 422, and concurrent requests are resolved by a UNIQUE key."
tags: [Java, Spring Boot, Architecture, Idempotency]
new: true
links:
  - url: "https://github.com/josesaid/idempotency-demo"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/idempotency-demo/"
    label: "Project page"
  - url: "https://josesaid.github.io/idempotency-demo/diagrams/english/workflow-english.html"
    label: "Flow diagrams (English)"
  - url: "https://josesaid.github.io/idempotency-demo/diagrams/spanish/flujo-espa%C3%B1ol.html"
    label: "Diagramas (español)"
---

idempotency-demo shows how a `POST /payments` endpoint can charge at most once per `Idempotency-Key`. `PaymentFacade` hashes the request body, looks the key up and, for a new key, has `IdempotencyReserver` commit a `PROCESSING` row in its own transaction (`REQUIRES_NEW`) before the simulated provider is called. The response is stored when the charge finishes, so retries get it back with `200 OK` and never reach the provider.

A reused key with a different body gets `422`. When several requests race with the same new key, the database `UNIQUE` constraint lets only one INSERT win: that request charges and answers `201`, the others answer `409` while it is still processing. If the provider throws, the reservation is released so the key can be retried. The tests fire 8 concurrent requests and check that exactly one charge happens.

The flow diagrams ([English](https://josesaid.github.io/idempotency-demo/diagrams/english/workflow-english.html), [español](https://josesaid.github.io/idempotency-demo/diagrams/spanish/flujo-espa%C3%B1ol.html)) show the path of one request, the decision flow, the row states and the five scenarios. Each scenario has its own sequence diagram:

| Scenario | English | Español |
|---|---|---|
| A. First request (201) | [Sequence diagram](https://josesaid.github.io/idempotency-demo/diagrams/english/scenario-a-first-request.html) | [Diagrama de secuencia](https://josesaid.github.io/idempotency-demo/diagrams/spanish/escenario-a-primera-peticion.html) |
| B. Retry with the same key (200) | [Sequence diagram](https://josesaid.github.io/idempotency-demo/diagrams/english/scenario-b-retry-same-key.html) | [Diagrama de secuencia](https://josesaid.github.io/idempotency-demo/diagrams/spanish/escenario-b-reintento-misma-clave.html) |
| C. Same key, different body (422) | [Sequence diagram](https://josesaid.github.io/idempotency-demo/diagrams/english/scenario-c-different-body.html) | [Diagrama de secuencia](https://josesaid.github.io/idempotency-demo/diagrams/spanish/escenario-c-cuerpo-distinto.html) |
| D. Concurrent requests (201 + 409) | [Sequence diagram](https://josesaid.github.io/idempotency-demo/diagrams/english/scenario-d-concurrent-requests.html) | [Diagrama de secuencia](https://josesaid.github.io/idempotency-demo/diagrams/spanish/escenario-d-peticiones-concurrentes.html) |
| E. Provider failure (500 → 201) | [Sequence diagram](https://josesaid.github.io/idempotency-demo/diagrams/english/scenario-e-provider-failure.html) | [Diagrama de secuencia](https://josesaid.github.io/idempotency-demo/diagrams/spanish/escenario-e-falla-del-proveedor.html) |

**Stack:** Java 21, Spring Boot 3.3.5 (Web, Data JPA), H2 in memory, Maven. Run instructions are in the [README](https://github.com/josesaid/idempotency-demo#readme).
