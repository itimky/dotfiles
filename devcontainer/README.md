# Dev Container

This directory owns the shared Dev Container template used by this repository and by consumer repositories wired through the local dotfiles workflow.

## Scope

Use this document for Dev Container-specific current structure, operational detail, and file ownership.
Use ADRs for architectural decisions and future-state contracts.

Relevant ADRs:

- [`adr/0006-define-isolated-development-tooling-boundary.md`](../adr/0006-define-isolated-development-tooling-boundary.md)

## Files

- `devcontainer.json`: VS Code Dev Container entry point, workspace folder, and lifecycle commands
- `docker-compose.yaml`: service definition, bind mounts, and shared named volumes
- `Dockerfile`: base image and container-local tool installation
- `Makefile`: install targets run inside the container

## Current Layout

Current implementation details:

- The Dev Container service runs as a single long-lived `devcontainer` service.
- The dotfiles repository is mounted at `/mnt/dotfiles`.
- The consumer repository is mounted at `/mnt/workspace`.
- VS Code opens `/mnt/workspace` as the effective project root.
- `onCreateCommand` runs `make -f "${DOTFILES}"/devcontainer/Makefile install`.
- The `install` target reinstalls dotfiles, runs `mise install`, and conditionally runs `pnpm install`.

Persistent state currently backs these locations:

- `/home/vscode/.codex`: project-scoped Compose-managed volume for per-project assistant state
- `/home/vscode/.cache`: explicitly shared named volume
- `/home/vscode/.codex-shared`: explicitly shared named volume used for shared assistant-side state such as auth wiring and `config.toml`
- `/home/vscode/.local`: explicitly shared named volume
- `/home/linuxbrew/.linuxbrew`: explicitly shared named volume

## Ownership Boundaries

Change the file that owns the behavior:

- Edit `devcontainer.json` for VS Code-facing configuration
- Edit `docker-compose.yaml` for mounts, service shape, and named volumes
- Edit `Dockerfile` for image contents and bootstrap tooling
- Edit `Makefile` for install behavior

Use this file for the detailed current Dev Container contract.
Do not treat this directory as the source of architectural truth for repository-wide isolation boundaries.
Architectural constraints and accepted filesystem contracts belong in ADRs.
