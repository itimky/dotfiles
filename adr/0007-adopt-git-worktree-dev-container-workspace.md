# 7. Adopt git-worktree Dev Container workspace

Date: 2026-04-13

## Status

Draft

## Context

This repository treats environment isolation as a primary constraint.
The current Dev Container workflow bind-mounts the consumer repository into `/workspace` and opens that path as the effective project root.

That layout keeps host and container source trees identical, but it also couples OS-sensitive dependency state and build state across the host and the container boundary.
Architecture-specific toolchains, package trees, and generated artifacts can become incompatible when a host checkout and a Linux Dev Container share the same working tree.

The supported workflow requires a stronger filesystem boundary without moving repository history into a container-only clone.
The host checkout must remain the source of truth for Git history.
The container must mount only the host `.git` path, materialize an effective workspace inside the container, and preserve that workspace on a persistent named volume.

The workflow must also support practical recovery.
Host Git can prune linked-worktree metadata because the container worktree path does not exist on the host.
Container startup therefore must detect missing or stale linked-worktree metadata and restore it from the persistent workspace volume.

Host and container workflows still need shared Git state.
Commits, refs, and stashes must remain visible across both environments through the shared `.git` path.
Uncommitted working-tree edits do not need live synchronization and should remain local to each worktree.

## Decision

Adopt the following Dev Container workspace contract:

- Mount only the host Git metadata into the container at `/mnt/workspace/.git`.
- Use `/home/vscode/workspace` as the only supported container workspace root.
- Preserve `/home/vscode/workspace` on a project-scoped named volume that is persistent but not shared across repositories.
- Create or reuse branch `devcontainer` for the container worktree.

Container startup must manage the workspace as a linked worktree against the shared Git metadata:

- When the workspace volume is empty and branch `devcontainer` does not exist, startup must create `/home/vscode/workspace` as a linked worktree on branch `devcontainer`.
- When the workspace volume is empty and branch `devcontainer` already exists, startup must attach `/home/vscode/workspace` to that existing branch.
- When `/home/vscode/workspace` already contains a valid linked worktree, startup must reuse it.
- When `/home/vscode/workspace` is non-empty but linked-worktree metadata under the shared Git path is missing or stale, startup must reconstruct the linked-worktree admin files and restore the `.git` pointer inside `/home/vscode/workspace`.
- When recovery metadata is reconstructed, startup must rebuild the workspace index without discarding working-tree edits.
- When branch `devcontainer` is missing during recovery, startup must fail with a clear error.
- When `/home/vscode/workspace/.gitmodules` exists, startup must initialize workspace submodules.

Supported Git-sharing behavior is limited to shared repository state:

- Host and container share commits, refs, and stashes through the mounted `.git` path.
- Host and container do not share live uncommitted working-tree edits.
- `/workspace` is not a supported compatibility alias after implementation.

## Consequences

Positive:

- The container gains a real filesystem boundary for OS-sensitive dependency and build state.
- The host checkout remains the source of truth for Git history and repository metadata.
- The container workspace persists across restarts without exposing the live host working tree inside the container.
- Shared Git history, refs, and stashes remain available across host and container workflows.

Trade-offs:

- Container startup becomes responsible for linked-worktree bootstrap and recovery logic.
- Host Git can prune linked-worktree metadata for the container workspace because the container path is not host-visible.
- Recovery requires direct reconstruction of linked-worktree admin files when Git CLI repair is insufficient.
- Host and container working-tree edits diverge until changes are committed, stashed, or reapplied explicitly.
