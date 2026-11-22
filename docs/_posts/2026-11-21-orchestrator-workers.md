---
layout: post
title: "orchestrator-workers: a model plans the subtasks, workers execute them"
description: "Spring Boot 4.1 and Spring AI 2.1 example where an orchestrator LLM returns structured subtasks and worker calls produce each piece."
tags: [Java, AI, Agents, Orchestration]
new: true
external_url: "https://dev.to/said_olano/orchestrator-workers-with-spring-ai-let-the-model-decide-the-subtasks-1618"
links:
  - url: "https://github.com/josesaid/orchestrator-workers"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/orchestrator-workers/"
    label: "Project page"
---

orchestrator-workers shows the orchestrator-workers pattern from Anthropic's *Building Effective Agents*: a central model reads the task, decides which subtasks are needed, and hands each one to a worker prompt.

`OrchestratorWorkers` maps the orchestrator's answer to an `OrchestratorResponse` record with an analysis and a list of `Task` records. It then runs one worker call per task and returns a `FinalResponse` with the analysis and the worker outputs. The sample runs workers one after another; parallel workers are a natural next step.

**Stack:** Java 17, Spring Boot 4.1.1, Spring AI 2.1.0-SNAPSHOT, Anthropic Claude. Setup is in the [README](https://github.com/josesaid/orchestrator-workers#readme).
