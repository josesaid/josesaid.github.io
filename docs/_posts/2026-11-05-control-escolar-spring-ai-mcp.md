---
layout: post
title: "Control Escolar: a school management system with Spring AI and an MCP server"
description: "Spring Boot 4.1 school app with a Spring AI 2.0 assistant (chat memory, RAG, safeguards, streaming, structured output) and an MCP server exposing 16 tools over Streamable HTTP."
tags: [Java, Spring Boot, AI, MCP, RAG, Tool calling, Security]
links:
  - url: "https://github.com/josesaid/control-escolar-spring-ai-mcp"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/control-escolar-spring-ai-mcp/"
    label: "Project page"
---

Control Escolar is a school management web app: students, teachers, subjects, classrooms, schedules, grades, reports, users and roles, with form login and role-based access through Spring Security.

On top of it sits an AI assistant built with the Spring AI `ChatClient`. It keeps one conversation per user in a JDBC chat memory, answers questions about the school rules and calendar with RAG over a `SimpleVectorStore`, blocks sensitive words with `SafeGuardAdvisor`, streams answers over SSE and returns a structured student analysis with `.entity(...)`. Its one write tool, `registrarCalificacion`, reads the user's role from the `ToolContext`, so the model cannot grant itself permission.

The same tool methods are also published by an MCP server at `/mcp` (Streamable HTTP): 16 tools, five resources, a resource template, three prompts and argument completions, ready for MCP Inspector or any other MCP client.

**Stack:** Java 21, Spring Boot 4.1.1, Spring AI 2.0.1, OpenAI `gpt-4o-mini` and `text-embedding-3-small`, Spring Security, Spring Data JPA, Thymeleaf, H2 (PostgreSQL optional) and Micrometer Prometheus.

The app also runs without an OpenAI key: the MCP tools keep working and the rules search falls back to keywords. Setup is in the [README](https://github.com/josesaid/control-escolar-spring-ai-mcp#readme).
