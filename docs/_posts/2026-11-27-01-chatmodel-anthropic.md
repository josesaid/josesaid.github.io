---
layout: post
title: "01-chatmodel-anthropic: your first LangChain4j chat with Claude"
description: "A minimal Java 21 example that builds an AnthropicChatModel with LangChain4j and sends one prompt to Claude."
tags: [Java, LangChain4j, Anthropic, Claude]
links:
  - url: "https://github.com/josesaid/01-chatmodel-anthropic"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/01-chatmodel-anthropic/"
    label: "Project page"
---

A short LangChain4j example: it creates an `AnthropicChatModel` with the builder (API key, model name, temperature, max tokens) and sends one prompt to Claude. The API key is read from the `ANTHROPIC_API_KEY` environment variable and is never stored in the repository.

**Stack:** Java 21, LangChain4j 1.24.1 (`langchain4j-anthropic`), Maven.

```bash
export ANTHROPIC_API_KEY=your-key-here
mvn -q compile exec:java
```
