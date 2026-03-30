# dotfiles

Some config files for various tools

## Installation

```shell
git clone ... --recursive
./setup.sh
```

`setup.sh` only ensures directories exist and creates symlinks for dotfiles.

Homebrew package management is performed directly with `brew` commands using the repo `Brewfile`.

## Homebrew Workflow

```shell
# from repo root

# install/update everything declared in Brewfile
brew bundle

# upgrade already-installed formulas and casks
brew upgrade

# capture current machine state back into Brewfile
brew bundle dump --force
```

## Architecture Decision Records (ADR)

Monorepo-level architecture decisions are tracked in `docs/adr` using `adr-tools`.

Conventions:

- `docs/adr` is the canonical ADR directory.
- `.adr-dir` points tooling to `docs/adr`.
- ADR filenames use `NNNN-short-title.md`.
- ADR sections are: Status, Context, Decision, Consequences.

Common workflow:

```shell
# From repo root
adr new Adopt example decision
adr list
```

When replacing a decision, create a new ADR and mark the old ADR as superseded.

tmux conf found [here](https://github.com/JohnMurray/dotfiles)
