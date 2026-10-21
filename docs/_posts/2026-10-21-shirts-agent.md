---
layout: post
title: "shirts-agent: a Spring AI agent that recommends a shirt"
description: "A Spring Boot and Spring AI example where a model calls a @Tool method over a catalog and returns a structured recommendation."
tags: [Java, Spring Boot, Spring AI, LLM]
links:
  - url: "https://github.com/josesaid/shirts-agent"
    label: "Source on GitHub"
---

An AI agent recommends a t-shirt in a requested color. The model calls an annotated `@Tool` method, `ShirtCatalogTool.findShirtByColor`, over an in-memory catalog and returns a structured `Shirt`.

The request flows through a controller, a service that validates input (invalid input returns HTTP 400 without calling the model), the agent, and the tool.

**Stack:** Java 21, Spring Boot 3.5.6, Spring AI 1.1.8, OpenAI `gpt-4o-mini`, Maven.

```bash
export OPENAI_API_KEY=sk-...
mvn spring-boot:run

curl -X POST http://localhost:8080/api/shirts/recommend \
  -H "Content-Type: application/json" \
  -d '{"item":"playera","color":"red"}'
```
