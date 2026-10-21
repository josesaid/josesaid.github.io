---
layout: post
title: "studentsWithMCPServer: an MCP server and a Claude agent over a Spring Boot API"
description: "Spring Boot 3.5 microservice that exposes student-management logic as MCP tools that Claude calls through tool calling."
tags: [Java, Spring Boot, Spring AI, MCP, Claude]
links:
  - url: "https://github.com/josesaid/studentsWithMCPServer"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/studentsWithMCPServer/"
    label: "Project page"
---

A Spring Boot 3.5 microservice that manages students and shows how an MCP server can expose business logic as tools. The REST API and the MCP tools share one service layer, and a Claude agent calls the tools through Spring AI tool calling.

The project includes a REST API documented with Swagger UI, an MCP server on the Streamable HTTP transport, and an embedded MCP client that runs an end-to-end demo at startup.

**Stack:** Java 21, Spring Boot 3.5.15, Spring AI 1.1.8, Anthropic Claude, H2, Maven.

The full setup, endpoints and configuration are in the [project README](https://github.com/josesaid/studentsWithMCPServer#readme). The project page is [here](https://josesaid.github.io/studentsWithMCPServer/).
