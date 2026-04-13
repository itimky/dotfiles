# dotfiles

Shared shell, editor, package, and devcontainer configuration for local machines and project workspaces.

## Overview

This README is the front door for the repository.
Tracked documentation and tracked workflow or integration manifests are the source of truth for repository behavior, workflow, and constraints.
Use this file for the top-level repository model and current contract.
Use [`devcontainer/README.md`](devcontainer/README.md) for Dev Container mechanics and [`adr/README.md`](adr/README.md) for architecture decisions.

## Repository Model

Consumer repository documentation describes each consumer project.
This repository provides shared shell, editor, and Dev Container workflow wiring across isolated workspaces.
Tracked repository documentation and tracked workflow or integration manifests define supported repository behavior.
When tracked documentation and tracked workflow or integration manifests conflict, the implementation-defining tracked manifest describes the current behavior until the documentation is aligned.
Consumer repositories remain assistant-agnostic by default, but may carry tracked `.devcontainer` or MCP-related configuration when that configuration is part of the supported workflow.
Local assistant state is disposable, non-authoritative, and should be persisted by assistant tooling outside the workspace tree.
Use [`devcontainer/README.md`](devcontainer/README.md) for persistence, mounts, and volume detail.

## Current Workspace Contract

Dev Containers are the supported isolated workflow boundary for this repository.
The consumer repository Git metadata is mounted at `/mnt/workspace/.git`.
The effective container workspace lives at `/home/vscode/workspace` on a project-scoped named volume, and VS Code opens that path as the effective project root.
ADR 0007 records the accepted Git-worktree workspace contract that replaces the deleted ADR 0008 reference.
`dotfiles-local-wire` is the entry point for wiring consumer repositories into the shared Dev Container workflow.

Use [`devcontainer/README.md`](devcontainer/README.md) for current Dev Container detail.
Use [`adr/0007-adopt-git-worktree-dev-container-workspace.md`](adr/0007-adopt-git-worktree-dev-container-workspace.md) for the accepted workspace contract.

## Layout And Ownership

- `homebrew/`, `zsh/`, `vim/`, `git/`, `vscode/`, `devcontainer/`: shared configuration and workflow assets
- `adr/`: architecture decision records and repository policy history
- `Makefile`: setup and wiring entry points

Change the source files in those directories, not generated symlinks in `$HOME` or in a consumer repository.

## Setup And Wiring

Clone the repository, then run the base setup path:

```sh
git clone git@github.com:itimky/dotfiles.git
cd dotfiles
make install
```

Optional setup:

```sh
make brew-bundle-client
make brew-bundle-gnu
make brew-bundle-workstation
make brew-bundle-xyz
make wire-vscode
```

For any repository root that should consume the shared Dev Container files, run:

```sh
dotfiles-local-wire
```

One-time and convenience setup commands live in [`Makefile`](Makefile).

- `make help`: list available targets
- `make install`: wire shell/editor config and install the default tool set
- `make brew-bundle-client`: install client-specific Homebrew packages
- `make brew-bundle-gnu`: install GNU compatibility Homebrew packages
- `make brew-bundle-workstation`: install workstation Homebrew packages
- `make brew-bundle-xyz`: install extra Homebrew packages
- `make wire-vscode`: wire shared VS Code settings

Local shell wiring now lives under `~/.config/zsh` and `~/.config/vim`. `make wire-zsh` symlinks [`zsh/env`](zsh/env) to `~/.zshenv` as the bootstrap that sets base environment values and `ZDOTDIR`, and symlinks [`zsh/rc`](zsh/rc) to `~/.config/zsh/.zshrc` as the interactive shell entrypoint.

Local repository wiring uses `dotfiles-local-wire`, a shell function defined in [`zsh/rc`](zsh/rc). The interactive shell config also owns plugin loading and deferred completions. The function links the shared files from `devcontainer/` into the current repository's `.devcontainer/` directory.

`make` targets are reserved for one-time setup and convenience workflows. Routine repository changes should be made by editing the owning files directly instead of routing work through repository automation.

## Safe Changes

- Keep changes scoped to the directory that owns the behavior.
- Preserve the separation between base machine setup, developer tooling, and optional extras.
- When repository structure or workflow expectations change, update this README and add or revise an ADR when the change is architectural.

## ADRs

Use [`adr/README.md`](adr/README.md) as the entry point for decision records. Read the latest numbered files in [`adr/`](adr/) for current repository decisions.

## Troubleshooting

- If VS Code or shell config does not update, check whether the expected symlink target points back into this repository.
- If setup behavior is unclear, inspect the owning top-level config directory or [`Makefile`](Makefile) before changing automation.

## Contributing

Keep docs short, update affected setup files directly, and record cross-cutting repository decisions in `adr/`.
