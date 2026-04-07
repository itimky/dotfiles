# 8. Isolate node_modules in Dev Container workspaces

Date: 2026-04-07

## Status

Accepted

## Context

Dev Containers are the repository filesystem sandbox for agents and container-side tooling.
The project workspace remains synchronized between host and container, and that model remains acceptable for source files and local build artifacts that are not OS-sensitive.

`node_modules` is the exception.
Sharing a macOS dependency tree with a Linux container causes binary mismatches, reinstall churn, and non-deterministic tool behavior.

The current Dev Container wiring bind-mounts the project into `/workspace`.
In the target macOS plus OrbStack plus Compose Dev Container workflow, overlaying `/workspace/node_modules` with a nested volume does not isolate that subtree.
Host and container still observe the same directory in practice.

Two constraints further narrow the design space:

- No additional host-side synchronization tooling
- No per-tool path rewiring for Node.js tools that expect a project-root `node_modules`
- No workflow-critical repository state stored only in disposable container volumes
- No requirement to use VS Code Dev Containers as the only viable development workflow
- No requirement to depend on remote repository availability for routine local development

The repository already attempts container-side dependency installation through `pnpm`, but without a shared pnpm store across projects.

## Decision

Treat `node_modules` as container-private dependency state within an otherwise host-synchronized workspace.

Boundary:

- Dev Containers remain the supported filesystem sandbox for agents and container-side tooling.
- The project workspace remains synchronized between host and container by default.
- `node_modules` and other proven OS-sensitive dependency trees must be isolated from the host.
- Local build artifacts remain in the synchronized workspace unless a specific artifact is shown to be OS-dependent.

Mechanism status by vector:

1. Vector 1: sync exclusion plus dedicated container volume
   Excluded.
   This vector requires host-side synchronization tooling.
2. Vector 2: relocated modules directory inside the container
   Excluded.
   This vector requires per-tool module-path rewiring.
3. Vector 3: container-private shadow workspace
   Selected as the primary direction.
   The effective Node.js workspace should be materialized inside the container, isolated from the host, and kept in a standard project layout.
   Sync-tool selection and implementation planning continue in `adr/0008-isolate-node-modules-in-devcontainer-workspaces-plan.md`.
4. Vector 4: rebuild-on-entry dependency tree with persistent package store
   Accepted as a supporting mechanism.
   Container-side `pnpm` installation already partially implements this path.
   A shared pnpm store across projects is not yet implemented.
5. Vector 5: repository clone stored inside the container
   Excluded.
   This vector moves repository state into disposable volumes and couples routine development to VS Code, Dev Containers, and remote repository reachability.

Unsupported mount pattern:

- Bind-mount the workspace from the host and overlay `/workspace/node_modules` with a nested volume in the same tree.
- In the target macOS plus OrbStack plus Compose workflow, the subtree remains shared in practice.

## Consequences

Positive:

- The Dev Container boundary becomes a real filesystem sandbox for OS-sensitive Node.js dependencies.
- macOS host tooling and Linux container tooling can coexist without corrupting each other's `node_modules`.
- Most project files and local build artifacts can still flow through the synchronized workspace.
- No new host-side synchronization dependency is required.
- The primary direction preserves a conventional project-root `node_modules` layout inside the effective container workspace.
- The accepted rebuild-on-entry path improves the return path from host-side development into Dev Containers.

Trade-offs:

- Shadow workspace synchronization adds another filesystem layer and a larger operational surface than a plain bind-mounted workspace.
- Additional synchronization tooling is required inside the container boundary.
- Shared pnpm store behavior across projects still needs design and implementation work.
- Keeping the repository source of truth on the host remains a hard requirement, which excludes some otherwise simpler container-only workflows.
