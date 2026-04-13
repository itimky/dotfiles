# Dev Container

This directory owns the shared Dev Container template used by this repository and by consumer repositories wired through the local dotfiles workflow.

## Scope

Use this document for Dev Container-specific current structure, operational detail, and file ownership.
Use ADRs for architectural decisions and future-state contracts.

Relevant ADRs:

- [`adr/0006-define-isolated-development-tooling-boundary.md`](../../adr/0006-define-isolated-development-tooling-boundary.md)
- [`adr/0007-adopt-git-worktree-dev-container-worktree.md`](../../adr/0007-adopt-git-worktree-dev-container-worktree.md)

## Files

- `devcontainer.json`: VS Code Dev Container entry point, worktree folder, and lifecycle commands
- `docker-compose.yaml`: service definition, bind mounts, and shared named volumes
- `Dockerfile`: base image and container-local tool installation
- `Makefile`: worktree bootstrap and install targets run inside the container

## Current Layout

Current implementation details:

- The Dev Container service runs as a single long-lived `devcontainer` service.
- The dotfiles repository is mounted at `/dotfiles`.
- The consumer repository Git metadata is mounted at `/mnt/worktree/.git`.
- The effective consumer worktree is materialized at `/home/vscode/worktree`.
- VS Code opens `/home/vscode/worktree` as the effective project root.
- Setup hooks call `make -C /dotfiles install` on create and `make -f /dotfiles/devcontainer/Makefile install-worktree` after start.
- When the worktree volume is stale, startup recreates the linked worktree and restores the saved files onto it.

Persistent state currently backs these locations:

- `/home/vscode/worktree`: project-scoped Compose-managed volume for the container worktree
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
- Edit `Makefile` for linked-worktree bootstrap, recovery, and install behavior

Use this file for the detailed current Dev Container contract.
Do not treat this directory as the source of architectural truth for worktree isolation.
Architectural constraints and accepted filesystem contracts belong in ADRs.
