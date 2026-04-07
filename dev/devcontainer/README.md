# Dev Container

This directory owns the shared Dev Container template used by this repository and by consumer repositories wired through the local dotfiles workflow.

## Scope

Use this document for current Dev Container structure, file ownership, and operational expectations.
Use ADRs for architectural decisions and future-state contracts.

Relevant ADRs:

- [`adr/0006-define-isolated-development-tooling-boundary.md`](../../adr/0006-define-isolated-development-tooling-boundary.md)
- [`adr/0008-isolate-node-modules-in-devcontainer-workspaces.md`](../../adr/0008-isolate-node-modules-in-devcontainer-workspaces.md)
- [`adr/0008-isolate-node-modules-in-devcontainer-workspaces-plan.md`](../../adr/0008-isolate-node-modules-in-devcontainer-workspaces-plan.md)

## Files

- `devcontainer.json`: VS Code Dev Container entry point, workspace folder, and lifecycle commands
- `docker-compose.yaml`: service definition, bind mounts, and shared named volumes
- `Dockerfile`: base image and container-local tool installation

## Current Layout

Current implementation details:

- The Dev Container service runs as a single long-lived `devcontainer` service.
- The dotfiles repository is mounted read-only at `/dotfiles`.
- The consumer repository is bind-mounted at `/workspace`.
- VS Code opens `/workspace` as the effective project root.
- Setup hooks call `make -C /dotfiles install-base` on create and `make -f /dotfiles/Makefile local-install` after create.

Persistent shared volumes currently back these locations:

- `/home/vscode/.codex`
- `/home/vscode/.cache`
- `/home/vscode/.codex-shared`
- `/home/vscode/.local`
- `/home/linuxbrew/.linuxbrew`

## Ownership Boundaries

Change the file that owns the behavior:

- Edit `devcontainer.json` for VS Code-facing configuration
- Edit `docker-compose.yaml` for mounts, service shape, and named volumes
- Edit `Dockerfile` for image contents and bootstrap tooling

Do not treat this directory as the source of architectural truth for workspace isolation.
Architectural constraints and accepted filesystem contracts belong in ADRs.

## Current Limitation

The current implementation still bind-mounts the effective workspace directly at `/workspace`.
That means the ADR 0008 target-state isolation model is not implemented yet.

In particular, the repository does not yet provide:

- a host bind mount remapped to `/workspace-host`
- a container-private effective workspace at `/workspace`
- an in-container synchronization process between those roots

## Planned Direction

ADR 0008 defines the target-state workspace contract for isolating `node_modules` from the host while keeping repository files synchronized.
The implementation and validation work for that change is tracked separately in the ADR 0008 plan document.

Until that work is validated and landed, this README documents the current Dev Container layout rather than the planned shadow-workspace layout.

## Safe Changes

- Keep this document aligned with the current files in this directory
- Update the relevant ADR when changing architectural constraints or accepted workspace contracts
- Add operational notes here only after the behavior exists in the checked-in Dev Container files
