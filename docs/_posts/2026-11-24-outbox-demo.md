---
layout: post
title: "outbox-demo: transactional outbox and idempotent consumer in plain Java"
description: "A dependency-free Java demo where the order and its event are saved in one transaction, a relay publishes to a simulated Kafka, and the consumer skips duplicates."
tags: [Java, Architecture, Messaging, Kafka, Event-driven]
new: true
links:
  - url: "https://github.com/josesaid/outbox-demo"
    label: "Source on GitHub"
  - url: "https://josesaid.github.io/outbox-demo/"
    label: "Project page"
  - url: "https://josesaid.github.io/outbox-demo/diagrams/english/workflow-english.html"
    label: "Flow diagrams (English)"
  - url: "https://josesaid.github.io/outbox-demo/diagrams/spanish/flujo-espa%C3%B1ol.html"
    label: "Diagramas (español)"
  - url: "https://dev.to/said_olano/at-least-once-delivery-without-double-charges-the-outbox-pattern-in-plain-java-3pp8"
    label: "Article on dev.to"
---

outbox-demo shows two patterns that work together in event-driven systems. On the producer side, `OrderService` writes the order and an outbox row in the same transaction, and `OutboxRelay` publishes pending events afterwards with retries and a `DEAD` state after three failed attempts. On the consumer side, `PaymentConsumer` records each event ID in `processed_events` inside the business transaction, so redelivered messages are skipped.

Five scenarios cover the normal flow, a relay crash, a consumer crash before the offset commit, a temporary broker failure and a permanent one. Kafka and the database are simulated with plain Java classes, so it runs with only a JDK.

The full walkthrough is in the dev.to article [At-Least-Once Delivery Without Double Charges](https://dev.to/said_olano/at-least-once-delivery-without-double-charges-the-outbox-pattern-in-plain-java-3pp8), and the flow diagrams ([English](https://josesaid.github.io/outbox-demo/diagrams/english/workflow-english.html), [español](https://josesaid.github.io/outbox-demo/diagrams/spanish/flujo-espa%C3%B1ol.html)) show the event's path, the outbox states and the five scenarios.

Each scenario also has its own sequence diagram, with every call between the classes:

| Scenario | English | Español |
|---|---|---|
| A. Normal flow | [Sequence diagram](https://josesaid.github.io/outbox-demo/diagrams/english/scenario-a-normal-flow.html) | [Diagrama de secuencia](https://josesaid.github.io/outbox-demo/diagrams/spanish/escenario-a-flujo-normal.html) |
| B. Relay crash | [Sequence diagram](https://josesaid.github.io/outbox-demo/diagrams/english/scenario-b-relay-crash.html) | [Diagrama de secuencia](https://josesaid.github.io/outbox-demo/diagrams/spanish/escenario-b-caida-del-relay.html) |
| C. Consumer crash | [Sequence diagram](https://josesaid.github.io/outbox-demo/diagrams/english/scenario-c-consumer-crash.html) | [Diagrama de secuencia](https://josesaid.github.io/outbox-demo/diagrams/spanish/escenario-c-caida-del-consumidor.html) |
| D. Temporary broker failure | [Sequence diagram](https://josesaid.github.io/outbox-demo/diagrams/english/scenario-d-temporary-broker-failure.html) | [Diagrama de secuencia](https://josesaid.github.io/outbox-demo/diagrams/spanish/escenario-d-falla-temporal-de-kafka.html) |
| E. Permanent broker failure | [Sequence diagram](https://josesaid.github.io/outbox-demo/diagrams/english/scenario-e-permanent-broker-failure.html) | [Diagrama de secuencia](https://josesaid.github.io/outbox-demo/diagrams/spanish/escenario-e-falla-permanente-de-kafka.html) |

**Stack:** Java 17+, no external libraries. Run instructions are in the [README](https://github.com/josesaid/outbox-demo#readme).
