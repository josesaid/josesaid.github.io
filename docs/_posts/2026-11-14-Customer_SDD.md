---
layout: post
title: "Customer_SDD: a customer CRUD API built with Spec-Driven Development"
description: "Spring Boot 3.5 and Java 21 REST API where each operation is written first in a spec, traced in tests by its ID, and only then implemented."
tags: [Java, Spring Boot, Architecture, SDD]
links:
  - url: "https://github.com/josesaid/Customer_SDD"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/Customer_SDD/"
    label: "Project page"
---

Customer_SDD is a small customer CRUD REST API used to practice Spec-Driven Development. The spec in `docs/specs/customer.md` is the source of truth: it defines the entity, five operations (CUST-01 to CUST-05), their status codes and the error format.

Every test in `CustomerApiTest` carries the operation ID in its `@DisplayName`, so each rule in the spec maps to at least one test. Behavior changes start in the spec, then the tests, then the code, until `mvn test` passes.

The API creates, reads, lists, updates and logically deletes customers. Emails are normalized to lowercase and must be unique, delete is idempotent and only sets `active = false`, and all errors are RFC 7807 `ProblemDetail` responses with per-field validation details.

**Stack:** Java 21, Spring Boot 3.5.4 (Web, Data JPA, Validation), H2 in-memory, JUnit 5 and MockMvc. Setup is in the [README](https://github.com/josesaid/Customer_SDD#readme).
