# 7. Adopt git-worktree Dev Container workspace

Date: 2026-04-13

## Status

Accepted

## Context

This repository treats environment isolation as a primary constraint.
Shared host and container working trees couple OS-sensitive dependency state and build state across the host and container boundary.
Architecture-specific toolchains, package trees, and generated artifacts can become incompatible when a host checkout and a Linux Dev Container share the same working tree.

The supported workflow requires a stronger filesystem boundary without moving repository history into a container-only clone.
The host checkout must remain the source of truth for Git history.
The current manifests mount the dotfiles repository at `/mnt/dotfiles`, mount host Git metadata at `/mnt/.git`, and materialize an effective worktree inside the container at `/home/vscode/worktree`.

Host and container workflows still need shared Git state.
Commits, refs, and stashes must remain visible across both environments through the shared `.git` path.
Uncommitted working-tree edits do not need live synchronization and should remain local to each worktree.

The tracked Dev Container lifecycle is intentionally narrow.
`devcontainer.json` defines a single create-time bootstrap command, and `devcontainer/Makefile` owns the linked-worktree bootstrap and dependency installation steps.

## Decision

Adopt the following Dev Container workspace contract:

- Mount the dotfiles repository at `/mnt/dotfiles`.
- Mount the host Git metadata into the container at `/mnt/.git`.
- Use `/home/vscode/worktree` as the supported container worktree root.
- Create or reuse branch `devcontainer` for the container worktree.
- Run `make -f "${DOTFILES}"/devcontainer/Makefile install` during container creation.
- Let `devcontainer/Makefile` own the current bootstrap sequence:
  - Reinstall dotfiles with `make -C "${DOTFILES}" install`.
  - Create or reuse the linked worktree at `${WORKTREE_DIR}` from `${DOTGIT}`.
  - Run `mise install` in the worktree.
  - Run `pnpm install --frozen-lockfile` only when `pnpm` is available.

Supported Git-sharing behavior is limited to shared repository state:

- Host and container share commits, refs, and stashes through the mounted `.git` path.
- Host and container do not share live uncommitted working-tree edits.

## Consequences

Positive:

- The container gains a real filesystem boundary for OS-sensitive dependency and build state.
- The host checkout remains the source of truth for Git history and repository metadata.
- The effective project root is consistent across `devcontainer.json`, `Dockerfile`, and `Makefile`.
- Shared Git history, refs, and stashes remain available across host and container workflows.

Trade-offs:

- Container startup owns only create-time linked-worktree bootstrap and dependency installation.
- The current manifests do not declare a dedicated named volume for `/home/vscode/worktree`.
- Host and container working-tree edits diverge until changes are committed, stashed, or reapplied explicitly.
