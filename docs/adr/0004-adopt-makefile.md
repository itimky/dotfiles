# 4. Adopt Makefile

Date: 2026-03-31

## Status

Accepted

## Context

The repository command set has grown, and some steps are still undocumented or undefined. Current toolset:

- git submodules
- setup.sh
- brew (installation step is missing)
- adr

## Decision

Introduce a Makefile covering both existing and missing parts of the toolset: pulling submodules instead of cloning with --recursive, wiring symlinks via setup.sh, installing Homebrew, installing packages from Brewfile, an `install` target that runs all of the above, and a default help target that lists available commands with descriptions.

## Consequences

Positive:

- A single source of truth
- `make` is installed almost everywhere

Tradeoffs:

- Additional maintenance overhead
