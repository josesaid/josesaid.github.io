---
layout: post
title: "aws-architecture-diagrams: a catalog of 12 AWS reference architectures"
description: "Self-contained HTML diagrams that go from a static site on S3 to serverless, event-driven, data, generative AI, EKS and multi-region designs."
tags: [AWS, Architecture, Cloud, Diagrams]
links:
  - url: "https://github.com/josesaid/aws-architecture-diagrams"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/aws-architecture-diagrams/"
    label: "Project page"
---

aws-architecture-diagrams is a browsable catalog of 12 AWS reference architectures, each one a self-contained HTML page with no build step.

The diagrams start simple and add one concern at a time: a static site, layered security with WAF and KMS, CI/CD with CodePipeline, a dynamic site with ALB, ECS and RDS, and a serverless app with Amplify and Cognito. They then cover asynchronous processing with SQS, events and orchestration with Step Functions, real time with AppSync and DynamoDB Streams, a data lake for analytics, generative AI with RAG on Amazon Bedrock, managed Kubernetes with EKS, and multi-region disaster recovery.

The catalog is in the [project page](https://josesaid.github.io/aws-architecture-diagrams/), and each diagram is listed in the [README](https://github.com/josesaid/aws-architecture-diagrams#readme).
