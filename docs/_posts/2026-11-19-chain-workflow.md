---
layout: post
title: "chain-workflow: prompt chaining with Spring AI and Claude"
description: "Spring Boot 4.1 and Spring AI 2.1 command-line app that runs four sequential LLM calls to turn a text report into a sorted markdown table."
tags: [Java, AI, Agents, Prompts]
links:
  - url: "https://github.com/josesaid/chain-workflow"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/chain-workflow/"
    label: "Project page"
---

chain-workflow shows the prompt chaining pattern from Anthropic's *Building Effective Agents*: a task is split into fixed steps, and each LLM call works on the output of the previous one. Each call has a simpler job, which trades some latency for accuracy.

The app passes a sample Q3 performance report through four system prompts: extract the numeric values and their metrics, convert them to percentages, sort them in descending order, and render a markdown table. `ChainWorkflow` loops over the prompts with a Spring AI `ChatClient` and prints every intermediate step.

**Stack:** Java 17, Spring Boot 4.1.1, Spring AI 2.1.0-SNAPSHOT, Anthropic Claude (OpenAI and Ollama optional). No storage, no HTTP endpoints. Based on the Apache 2.0 Spring AI examples. Setup is in the [README](https://github.com/josesaid/chain-workflow#readme).
