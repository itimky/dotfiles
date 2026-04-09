# dotfiles

Shared shell, editor, package, and devcontainer configuration for local machines and project workspaces.

## Overview

This README is the front door for the repository.
Tracked documentation and tracked workflow or integration manifests are the source of truth for repository behavior, workflow, and constraints.
Use this file for the top-level repository model and current contract.
Use [`src/devcontainer/README.md`](src/devcontainer/README.md) for Dev Container mechanics and [`adr/README.md`](adr/README.md) for architecture decisions.

## Repository Model

Consumer repository documentation describes each consumer project.
This repository provides shared shell, editor, and Dev Container workflow wiring across isolated workspaces.
Tracked repository documentation and tracked workflow or integration manifests define supported repository behavior.
When tracked documentation and tracked workflow or integration manifests conflict, the implementation-defining tracked manifest describes the current behavior until the documentation is aligned.
Consumer repositories remain assistant-agnostic by default, but may carry tracked `.devcontainer` or MCP-related configuration when that configuration is part of the supported workflow.
Local assistant state is disposable, non-authoritative, and should be persisted by assistant tooling outside the workspace tree.
Use [`src/devcontainer/README.md`](src/devcontainer/README.md) for persistence, mounts, and volume detail.

## Current Workspace Contract

Dev Containers are the supported isolated workflow boundary for this repository.
The current consumer repository workspace is still bind-mounted directly at `/workspace`, and VS Code opens that path as the effective project root.
The ADR 0008 shadow-workspace target is not implemented yet.
`dotfiles-local-wire` is the entry point for wiring consumer repositories into the shared Dev Container workflow.

Use [`src/devcontainer/README.md`](src/devcontainer/README.md) for current Dev Container detail.
Use [`adr/0008-isolate-node-modules-in-devcontainer-workspaces.md`](adr/0008-isolate-node-modules-in-devcontainer-workspaces.md) for the accepted target-state workspace contract.

## Layout And Ownership

- `src/`: shell, git, tmux, vim, Homebrew inputs, VS Code settings, and Dev Container files
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

Local repository wiring uses `dotfiles-local-wire`, a shell function defined in [`src/rc.zsh`](src/rc.zsh). The function links the shared files from `src/devcontainer/` into the current repository's `.devcontainer/` directory.

`make` targets are reserved for one-time setup and convenience workflows. Routine repository changes should be made by editing the owning files directly instead of routing work through repository automation.

## Safe Changes

- Keep changes scoped to the directory that owns the behavior.
- Preserve the separation between base machine setup, developer tooling, and optional extras.
- When repository structure or workflow expectations change, update this README and add or revise an ADR when the change is architectural.

## ADRs

Use [`adr/README.md`](adr/README.md) as the entry point for decision records. Read the latest numbered files in [`adr/`](adr/) for current repository decisions.

## Troubleshooting

- If VS Code or shell config does not update, check whether the expected symlink target points back into this repository.
- If setup behavior is unclear, inspect the owning file in `src/` or [`Makefile`](Makefile) before changing automation.

## Contributing

Keep docs short, update affected setup files directly, and record cross-cutting repository decisions in `adr/`.
