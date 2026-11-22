---
layout: post
title: "routing-workflow: classify first, then answer with Spring AI and Claude"
description: "Spring Boot 4.1 and Spring AI 2.1 command-line app that classifies support tickets with structured output and sends each one to a specialized prompt."
tags: [Java, AI, Agents, Routing]
new: true
external_url: "https://dev.to/said_olano/routing-workflow-with-spring-ai-classify-first-then-answer-4m4b"
links:
  - url: "https://github.com/josesaid/routing-workflow"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/routing-workflow/"
    label: "Project page"
---

routing-workflow shows the routing pattern from Anthropic's *Building Effective Agents*: an LLM first classifies an input, then the input goes to a prompt written for that category. The example uses four support routes: billing, technical, account and product.

`RoutingWorkflow` asks the model to pick one route and return its reasoning as a `RoutingResponse` record. It then looks up the selected route in a map of prompts and returns that prompt's answer. An unknown route name fails fast.

**Stack:** Java 17, Spring Boot 4.1.1, Spring AI 2.1.0-SNAPSHOT, Anthropic Claude (OpenAI and Ollama optional). No storage, no HTTP endpoints. Based on the Apache 2.0 Spring AI examples. Setup is in the [README](https://github.com/josesaid/routing-workflow#readme).
