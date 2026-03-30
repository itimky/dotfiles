# dotfiles

Some config files for various tools

## Installation

```shell
git clone ... --recursive
./setup.sh
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
