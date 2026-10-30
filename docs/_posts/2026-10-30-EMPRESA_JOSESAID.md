---
layout: post
title: "EMPRESA_JOSESAID: a microservices platform for a company's core operations"
description: "Eleven Spring Boot 4 microservices covering sales, purchasing, inventory, billing, accounting, compliance and reporting, secured with RS256 JWT and JWKS."
tags: [Java, Spring Boot, Microservices, Spring Cloud, Security, Kafka, PostgreSQL, Docker]
links:
  - url: "https://github.com/josesaid/EMPRESA_JOSESAID"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/EMPRESA_JOSESAID/"
    label: "Project page"
---

EMPRESA_JOSESAID is a platform of eleven microservices for a company's core operations. Nine business services handle customers, users and access, billing and payments, accounting, inventory, purchasing, sales, legal documents and executive reporting. A Eureka registry and a single API gateway sit in front of them.

Each business service owns its PostgreSQL database and user. Access tokens are signed with RS256, and services validate them with the public key from a JWKS endpoint, so no shared secret is needed between services.

Writes that create orders, payments, journal entries, inventory movements and purchase orders accept an optional `Idempotency-Key` header. A repeated request returns the original response, and keys are valid for 24 hours. Supplier tax data and legal documents are encrypted with AES-256, and an HMAC index keeps them searchable.

**Stack:** Java 21, Spring Boot 4.1, Spring Cloud Gateway, Eureka, Spring Security, Spring Data JPA, Flyway, PostgreSQL 17, Apache Kafka 4.0, Prometheus, Grafana, Jaeger, Testcontainers and Docker Compose.

The whole platform starts with one `docker compose up`. The project page has the architecture diagram, the services table and the technical manual, and the setup is in the [README](https://github.com/josesaid/EMPRESA_JOSESAID#readme).
