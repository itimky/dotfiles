# 6. Define isolated development tooling boundary

Date: 2026-04-05

## Status

Accepted

## Context

This repository treats environment isolation as a primary constraint.
Developer tooling choices must preserve a practical isolation boundary between host and container environments.

In VS Code remote workflows, some extensions run in the local extension host on the client side while others run in the remote extension host inside the container.
That split execution model is incompatible with this repository's stricter isolation goals when the tooling is tightly integrated with proprietary GitHub or Copilot services.
Such integrations can move editor context, prompt context, extension state, or telemetry across the container boundary, persist state on the host side, and reintroduce that state in later sessions.
Any tooling that weakens the host-container boundary in that way is treated as an isolation breach.

At the same time, isolated development still needs a practical day-to-day container boundary.

## Decision

Define the supported isolated development boundary as follows:

- Dev Containers remain in use for isolated development.
- VS Code AI features and GitHub-provided plugins are outside the supported workflow.
- Repository guidance must not depend on proprietary AI or GitHub editor integrations.
- Repository documentation must describe workflows that remain valid without those integrations.

## Consequences

Positive:

- The repository keeps a practical isolated development workflow for daily use.
- Supported tooling stays aligned with the repository's isolation requirements.
- Documentation can describe a stable workflow without relying on host-persistent proprietary integrations.

Trade-offs:

- Some convenience features from proprietary editor ecosystems are intentionally excluded.
- Dev Containers remain in use despite their proprietary ecosystem ties because they remain the currently accepted practical isolation boundary.
