# Backend flow mapping

> TEMPLATE — filled by the agent during `tasks/PROJECT-KICKOFF.md`.
> Default target: n8n workflows exposing webhook APIs. Adapt if the project
> picks another backend.
> See `docs/example/` for a completed version.

## Ingress pattern (suggested)

A single ingress keeps the app simple and the backend swappable:

```mermaid
flowchart LR
  app[Android app] -->|"POST /requests"| hook[Webhook]
  hook --> validate{"Schema + auth valid?"}
  validate -->|no| reject[Reject 4xx]
  validate -->|yes| switch["Switch by request type"]
  switch --> handler[Process handler]
  handler --> respond["Respond (data / job id)"]
```

## Process lanes

| Request type | Workflow | Steps | External calls | Responds |
|--------------|----------|-------|----------------|----------|
| — | — | — | — | — |

## Workflow split

<!-- How workflows are organised: one per domain? one per request type?
     Naming convention. -->

- (decided at kickoff)
