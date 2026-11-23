---
layout: post
title: "evaluator-optimizer: one model writes, another critiques, until it passes"
description: "Spring Boot 4.1 and Spring AI 2.1 example where a generator LLM writes code and an evaluator LLM returns a verdict and feedback in a refinement loop."
tags: [Java, AI, Agents, Evaluation]
new: true
external_url: "https://dev.to/said_olano/evaluator-optimizer-with-spring-ai-one-model-writes-another-critiques-1pj1"
links:
  - url: "https://github.com/josesaid/evaluator-optimizer"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/evaluator-optimizer/"
    label: "Project page"
---

evaluator-optimizer shows the evaluator-optimizer pattern from Anthropic's *Building Effective Agents*: a generator LLM produces a solution, an evaluator LLM judges it with explicit criteria, and the feedback goes back to the generator until the verdict is PASS.

`EvaluatorOptimizer` keeps every previous attempt and the latest feedback in a growing context, and maps each generation and evaluation to a record with Spring AI's structured output. The sample has no round limit, so the article also shows how to add one.

**Stack:** Java 17, Spring Boot 4.1.1, Spring AI 2.1.0-SNAPSHOT, configurable model provider. Setup is in the [README](https://github.com/josesaid/evaluator-optimizer#readme).
