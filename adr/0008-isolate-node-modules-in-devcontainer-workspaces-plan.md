# 8. Isolate node_modules in Dev Container workspaces plan

## Stage 1: Research and selection

### Steps:

1. Compare `unison`, `mutagen`, `syncthing`, and screened-out alternatives against ADR 0008 constraints
2. Narrow the shortlist to tools that support pairwise two-way synchronization inside the container boundary without host-side tooling or per-tool Node.js path rewiring
3. Compare orchestration through an in-container process versus a sidecar container
4. Select one orchestration model and record the rationale
5. Populate Results section below with current findings and revise the ranking if validation changes the result

### Results:

**Decision baseline from ADR 0008:**

- Vector 3 is the selected primary direction
- Vector 4 is the accepted supporting mechanism
- The ADR target-state filesystem contract is the evaluation baseline for sync-tool selection and validation
- Final sync-tool selection remains pending validation

**Selected orchestration model:**

- `in-container process`

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

**Orchestration comparison:**

- `in-container process` is selected because it fits the current single-service Dev Container model, keeps synchronization lifecycle inside the main filesystem sandbox, reuses the existing persistent volumes, and avoids extra cross-container permissions and startup coordination.
- `sidecar container` is not selected because it adds compose-service complexity, shared-volume wiring, readiness ordering, and cross-container observability overhead without adding meaningful isolation for this use case.

## Stage 2: Validation tasks

### Steps:

1. Manually validate a remapped host bind mount at `/workspace-host` and reserve `/workspace` for the container-private effective workspace in a Docker-enabled environment
2. Manually validate `unison` as an in-container process that materializes `/workspace` from `/workspace-host`
3. Validate synchronization scope for the selected mechanism, including exclusion of `node_modules` and other proven OS-sensitive dependency trees from synchronization
4. Validate that VS Code and container-side tooling can use `/workspace` as the effective root without per-tool Node.js path rewiring
5. Validate `mutagen` against the same baseline if `unison` fails correctness or operability checks
