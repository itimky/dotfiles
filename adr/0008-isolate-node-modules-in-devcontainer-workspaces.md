# 8. Isolate node_modules in Dev Container workspaces

Date: 2026-04-07

## Status

Draft

## Context

This repository uses Dev Containers as the practical filesystem sandbox for coding agents and container-side development tooling.
That sandbox is intended to behave like a personal remote screen: some state persists across sessions, some state is shared across projects, and the project workspace remains synchronized between host and container.

The synchronized workspace model is acceptable for source files and for local build artifacts that are not OS-dependent in this repository.
`node_modules` is a special case because its contents are OS-sensitive and must not be shared between a macOS host and a Linux container.
Sharing that tree across the boundary can produce broken native modules, wrong binaries, reinstall churn, and non-deterministic editor or test behavior.

The current Dev Container wiring bind-mounts the project workspace into `/workspace`.
A tempting implementation is to add a second mount that overlays `/workspace/node_modules` with a named volume.
In the target macOS host workflow using OrbStack and Compose-backed Dev Containers, that nested mount does not provide reliable separation.
The host and container still observe the same `node_modules` tree in practice, which defeats the isolation goal.

## Decision

Treat `node_modules` as container-private dependency state within an otherwise host-synchronized workspace.

The draft boundary is:

- Dev Containers remain the supported filesystem sandbox for agents and container-side tooling.
- The project workspace remains synchronized between host and container by default.
- `node_modules` and other proven OS-sensitive dependency trees must be isolated from the host.
- Local build artifacts remain in the synchronized workspace unless a specific artifact is shown to be OS-dependent.
- Persistence should stay layered: workspace sync for project files, named volumes for reusable container state, and container-private storage for OS-sensitive package trees.

Selection weighting for the implementation should be:

1. Isolation correctness
2. Workspace synchronization fidelity
3. Standard Node.js workflow compatibility
4. Operational simplicity

Solution vectors under consideration:

1. Sync exclusion plus dedicated container volume
   Use a workspace synchronization mechanism that can exclude `node_modules` from host sync, then back that path with a named volume or container-private directory.
   This is the preferred vector when the synchronization engine provides stable exclusion semantics.
2. Relocated modules directory inside the container
   Keep `/workspace` synchronized, store installed modules in a container-private path outside the synchronized tree, and expose that path through package-manager configuration, symlinks, or runtime path wiring.
   This vector fits cases where the toolchain tolerates a nonstandard module location.
3. Container-private shadow workspace
   Keep the host-visible checkout as the sync source, materialize a second project tree inside the container with `node_modules` excluded, and run installs and tooling in that shadow tree.
   This vector fits cases where standard Node.js project layout must be preserved inside the effective working tree.
4. Rebuild-on-entry dependency tree with persistent package store
   Persist only the package-manager store in a named volume and recreate `node_modules` in a container-private location on create or start.
   This vector fits cases where deterministic rebuilds are preferred and reinstall cost is acceptable.

Unsupported vector:

- Bind-mount the workspace from the host and overlay `/workspace/node_modules` with a nested volume in the same tree.
- This pattern is considered non-portable for the target macOS plus OrbStack plus Compose Dev Container workflow because the subtree remains shared in practice.

## Consequences

Positive:

- The Dev Container boundary becomes a real filesystem sandbox for OS-sensitive Node.js dependencies.
- macOS host tooling and Linux container tooling can coexist without corrupting each other's `node_modules`.
- Most project files and local build artifacts can still flow through the synchronized workspace.
- Agent sessions can keep layered persistence without collapsing the host-container boundary.

Trade-offs:

- Path handling becomes more complex than a plain bind-mounted workspace.
- Some package managers, editor tools, and scripts assume `node_modules` lives directly under the project root and may need extra wiring.
- Shadow workspaces or sync exclusions add operational complexity and more failure modes than the default Dev Container mount model.
- Cross-platform onboarding becomes more sensitive to container runtime and sync-engine behavior.
- A portable solution may reduce compatibility with simple host-side Node.js workflows in the same checkout.

Open selection criteria:

- Reliable isolation on macOS hosts using OrbStack and Compose-backed Dev Containers
- Minimal surprise for standard Node.js, pnpm, and editor workflows
- Clear persistence semantics across container rebuilds, sessions, and projects
- Low maintenance burden for future repository consumers
