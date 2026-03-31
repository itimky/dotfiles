# 4. Sandbox VS Code plugins

Date: 2026-03-31

## Status

Accepted

## Context

AI agents run with user-level privileges and can access the host filesystem, potentially exposing sensitive data such as private keys.

## Decision

Use the VS Code Dev Containers extension to isolate AI Chat extensions from the host filesystem, mounting only the directories they need.

## Consequences

Positive:

- Strong filesystem isolation via a sandbox container
- Straightforward to adopt within the existing VS Code extension ecosystem

Trade-offs:

- Some additional maintenance overhead
- Tied to VS Code and its extension ecosystem
- Creates friction between host and container OSes to maintain a consistent base toolset

Operational notes:

- Workspaces must be opened via Dev Containers
- Persist remote VS Code extension installs and state inside Docker volumes so extension authentication is not lost when the container is recreated
