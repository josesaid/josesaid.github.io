---
layout: post
title: "parallelization-workflow: concurrent LLM calls with Spring AI and Claude"
description: "Spring Boot 4.1 and Spring AI 2.1 command-line app that runs four stakeholder analyses as parallel LLM calls and returns them in input order."
tags: [Java, AI, Agents, Concurrency]
new: true
links:
  - url: "https://github.com/josesaid/parallelization-workflow"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/parallelization-workflow/"
    label: "Project page"
---

parallelization-workflow shows the parallelization pattern from Anthropic's *Building Effective Agents*: independent LLM calls run at the same time and their outputs are aggregated. The pattern has two forms: sectioning, which splits a task into independent subtasks, and voting, which runs the same prompt several times to compare answers.

The app sends one prompt, "analyze how market changes will impact this stakeholder group", with four inputs: customers, employees, investors and suppliers. `ParallelizationlWorkflow` submits one Spring AI `ChatClient` call per input to a fixed thread pool of 4 workers, waits with `CompletableFuture.allOf` and returns the answers in the same order as the inputs.

**Stack:** Java 17, Spring Boot 4.1.1, Spring AI 2.1.0-SNAPSHOT, Anthropic Claude (OpenAI and Ollama optional). No storage, no HTTP endpoints. Based on the Apache 2.0 Spring AI examples. Setup is in the [README](https://github.com/josesaid/parallelization-workflow#readme).
