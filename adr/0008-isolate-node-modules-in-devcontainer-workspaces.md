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

Host cleanliness is also a hard constraint.
An implementation that depends on additional host-side synchronization tooling would complicate workspace orchestration and expand the host dependency surface, which conflicts with the sandbox goal.

Tool compatibility is another hard constraint.
Many Node.js tools assume a conventional project-root `node_modules` layout.
Any mechanism that requires manual per-tool path reconfiguration, including for tools such as Vitest, would create ongoing maintenance burden and future fragility.

The repository already contains a partial rebuild-on-entry path.
The current Dev Container lifecycle attempts container-side installation through `pnpm`, but that flow does not yet provide a shared pnpm store across projects.
That partial implementation still improves the experience after switching from host-side development back into Dev Containers because the container can reconstruct Linux-side dependencies.

## Decision

Treat `node_modules` as container-private dependency state within an otherwise host-synchronized workspace.

The draft boundary remains:

- Dev Containers remain the supported filesystem sandbox for agents and container-side tooling.
- The project workspace remains synchronized between host and container by default.
- `node_modules` and other proven OS-sensitive dependency trees must be isolated from the host.
- Local build artifacts remain in the synchronized workspace unless a specific artifact is shown to be OS-dependent.
- Persistence should stay layered: workspace sync for project files, named volumes for reusable container state, and container-private storage for OS-sensitive package trees.

Selection weighting for the implementation remains:

1. Isolation correctness
2. Workspace synchronization fidelity
3. Standard Node.js workflow compatibility
4. Operational simplicity

Mechanism status by vector:

1. Vector 1: sync exclusion plus dedicated container volume
   Excluded.
   This vector introduces a new host-side tooling dependency, complicates workspace orchestration, and pollutes the host.
   That trade-off is incompatible with the goal of keeping the isolation workflow inside the container boundary.
2. Vector 2: relocated modules directory inside the container
   Excluded.
   This vector requires manual configuration for tools that assume a standard project-root `node_modules` layout.
   That burden is unacceptable because it would require special handling for tools such as Vitest and likely for future repository tooling.
3. Vector 3: container-private shadow workspace
   Selected as the primary direction.
   The effective Node.js workspace should be materialized inside the container and kept isolated from the host while preserving a standard project layout for Node.js tools.
   The current candidate tool is Unison because it can provide two-way synchronization entirely within the container boundary.
   Additional research is required to compare Unison with other suitable tools and to select the final implementation.
   Two orchestration models remain under evaluation: an in-container process and a sidecar container.
4. Vector 4: rebuild-on-entry dependency tree with persistent package store
   Accepted as a supporting mechanism.
   The current repository already partially implements this direction by attempting container-side dependency installation through `pnpm`.
   A shared pnpm store across projects is not yet implemented, but the mechanism is accepted because it improves the experience after returning from host-side development without Dev Containers.

Unsupported mount pattern:

- Bind-mount the workspace from the host and overlay `/workspace/node_modules` with a nested volume in the same tree.
- This pattern is considered non-portable for the target macOS plus OrbStack plus Compose Dev Container workflow because the subtree remains shared in practice.

## Consequences

Positive:

- The Dev Container boundary becomes a real filesystem sandbox for OS-sensitive Node.js dependencies.
- macOS host tooling and Linux container tooling can coexist without corrupting each other's `node_modules`.
- Most project files and local build artifacts can still flow through the synchronized workspace.
- Agent sessions can keep layered persistence without collapsing the host-container boundary.
- No new host-side synchronization dependency is required.
- The primary direction preserves a conventional project-root `node_modules` layout inside the effective container workspace.
- The accepted rebuild-on-entry path already improves the return path from host-side development into Dev Containers.

Trade-offs:

- Shadow workspace synchronization adds another filesystem layer and a larger operational surface than a plain bind-mounted workspace.
- A synchronization tool must still be selected, integrated, observed, and recovered when failures occur.
- An in-container process and a sidecar container have different lifecycle and operability costs, and both require comparison before implementation is finalized.
- Shared pnpm store behavior across projects still needs design and implementation work.
- Cross-platform onboarding remains sensitive to container runtime behavior even after excluding host-side tooling dependencies.

Open research items:

- Compare Unison with other two-way synchronization tools that can operate fully within the container boundary.
- Compare orchestration through an in-container process versus a sidecar container.
- Define lifecycle, conflict handling, and recovery behavior for the selected synchronization mechanism.
- Define the final shape of a shared pnpm store across projects.
