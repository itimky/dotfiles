# dotfiles

Shared shell, editor, package, and devcontainer configuration for local machines and project workspaces.

## Layout

- `base/`: core shell, git, tmux, vim, and base package setup
- `dev/`: developer tooling such as VS Code settings and devcontainer files
- `etc/`: extra machine-level packages
- `adr/`: architecture decision records and repository policy history
- `Makefile`: human-oriented install and wiring entry points

## Quick start

Clone the repository, then run the human setup path:

```sh
git clone git@github.com:itimky/dotfiles.git
cd dotfiles
make install-base
```

Optional human setup:

```sh
make install-dev
make install-etc
```

For any repository root that should consume the shared devcontainer files, run the shell function exposed by this dotfiles setup:

```sh
dotfiles-local-wire
```

## Commands

Human-oriented one-time and convenience setup commands live in [`Makefile`](/workspace/Makefile).

- `make help`: list available targets
- `make install-base`: wire base dotfiles and install base tools
- `make install-dev`: wire developer settings and install developer tools
- `make install-etc`: install extra packages

Local repository wiring uses `dotfiles-local-wire`, a shell function defined in [`base/zsh.rc`](/workspace/base/zsh.rc). Run it from any repository root to link the shared devcontainer files from this repository. The underlying implementation uses `make local-wire`.

Coding agents must not use `make`. `make` targets are reserved for human-oriented one-time runs and convenience workflows. Agents should read files directly and make targeted edits instead of invoking repo automation.

## Organization Notes

Base machine configuration is isolated under `base/`. Development-environment overlays live under `dev/`. Optional extras stay in `etc/`. Repository-level decisions belong in `adr/`.

Change the source files in those directories, not generated symlinks in `$HOME` or a consumer repository.

## Safe Changes

- Keep changes scoped to the directory that owns the behavior.
- Preserve the separation between base machine setup, developer tooling, and optional extras.
- When repository structure or workflow expectations change, update this README and add or revise an ADR when the change is architectural.

## ADRs

Use [`adr/README.md`](/workspace/adr/README.md) as the entry point for decision records. Read the latest numbered files in [`adr/`](/workspace/adr/) for current repository decisions.

## Troubleshooting

- If VS Code or shell config does not update, check whether the expected symlink target points back into this repository.
- If setup behavior is unclear, inspect the owning file in `base/`, `dev/`, or [`Makefile`](/workspace/Makefile) before changing automation.

## Contributing

Keep docs short, update affected setup files directly, and record cross-cutting repository decisions in `adr/`.
