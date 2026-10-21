---
layout: post
title: "taller-spring-security: a course API ready for security"
description: "A Spring Boot REST API for courses and enrollments, deliberately unsecured as the baseline for a Spring Security workshop."
tags: [Java, Spring Boot, Spring Security, JPA]
links:
  - url: "https://github.com/josesaid/taller-spring-security"
    label: "Source on GitHub"
---

A course platform where instructors publish courses, students enroll, and paid content should be visible only to enrolled students. The baseline is intentionally unsecured. The workshop adds authentication and authorization step by step.

Architecture: feature packages (`internal/appuser`, `internal/course`) with controller, usecase, service, DAO and JPA layers, plus MapStruct for DTO mapping.

**Stack:** Java 25, Spring Boot 4.1.1, Spring Data JPA, H2, MapStruct, Maven.

**Roadmap:** JWT authentication, a `SecurityFilterChain`, role and ownership checks with `@PreAuthorize`, JSON 401/403 responses, and security and integration tests.
