# 8. Isolate node_modules in Dev Container workspaces plan

## Stage 1: Research and selection

### Steps:

1. Compare `unison`, `mutagen`, `syncthing`, and screened-out alternatives against ADR 0008 constraints
2. Narrow the shortlist to tools that support pairwise two-way synchronization inside the container boundary without host-side tooling or per-tool Node.js path rewiring
3. Compare orchestration through an in-container process versus a sidecar container
4. Populate Results section below with current findings and revise the ranking if validation changes the result

### Results:

**Architectural direction from ADR 0008:**

- Vector 3 is the selected primary direction
- Vector 4 is the accepted supporting mechanism
- Sync-tool selection remains open

**Current ranking:**

- `unison`
- `mutagen`
- `syncthing`

**Why the shortlist narrows to `unison` and `mutagen`:**

- Both fit pairwise two-way synchronization between two roots inside the container boundary
- Both support ignore configuration and continuous synchronization without host-side tooling
- Both preserve a standard project-root `node_modules` layout in the effective container workspace

**Current comparison:**

- `unison` is the best current fit for a two-root container-private shadow workspace
- `mutagen` is the fallback candidate if `unison` shows correctness or operability problems
- `syncthing` is viable but lower-fit because its device-oriented service model is broader than this use case
- `lsyncd` and `rsync` mirroring are screened out because the model is source-to-target, not pairwise bidirectional synchronization
- `mirror`, `csync`, and `csync2` are screened out due to weaker fit and extra complexity

**Open implementation branch:**

- `in-container process`
- `sidecar container`

## Stage 2: Validation tasks

### Steps:

1. Validate `unison` in an in-container process prototype
2. Validate `unison` in a sidecar-container prototype
3. Keep `mutagen` as the fallback candidate if `unison` fails correctness or operability checks
4. Define conflict handling, lifecycle, recovery behavior, and container startup semantics for the selected synchronization mechanism
5. Define the final shape of a cross-project `pnpm` store that supports Vector 4
