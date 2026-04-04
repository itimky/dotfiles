# 4. Sandbox VS Code plugins

## Stage 1: Research and design

### Steps:

1. Research suitable base container images and configurations for Dev Containers it terms of compatibility with this repo tooling and workflows, and security hardening best practices
2. Compare options and select a base image and configuration to use as a template for the sandbox containers, justifying the choice based on security, compatibility, and maintenance considerations for this repo
3. Populate Results section below with absolute minimum brief of the previous steps

### Results:

**Selected base image: `mcr.microsoft.com/devcontainers/base:noble`**

**Candidates considered:**

- `mcr.microsoft.com/devcontainers/base:noble`
- `mcr.microsoft.com/devcontainers/base:debian`
- `mcr.microsoft.com/devcontainers/universal`
- `debian:bookworm-slim`

* `debian:bookworm-slim` opted out for too much maintenance burden
* `universal` is too bloated and considered an overkill for a sandbox
* `base:noble` was selected over `base:debian` as a more developer-friendly option in terms of packages freshness.

**Key security hardening defaults:**

- must run as root user due to rootless docker limitations
- mounts only non-sensitive host directories

## Stage 2: Implementation details

### Steps:

1. Create `devcontainer.json` in devcontainer dir of the repo, configuring mounts of git config, agents configs, common persisten volume, per-project persistent volumes
2. Set plugins
3. Wire shell and dotfiles
4. Install mise and try install local packages in persistent volume
