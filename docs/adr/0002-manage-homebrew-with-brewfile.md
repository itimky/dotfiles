# 2. Manage Homebrew with Brewfile

Date: 2026-03-30

## Status

Accepted

## Context

This repository is used to provision and maintain development environments across multiple machines.
Homebrew packages are currently installed and updated imperatively, which can drift over time between hosts.
That drift makes bootstrap behavior less predictable and makes it harder to audit why tools are present or missing.

Motivation: keep machine setup reproducible and track package changes in version control.

## Decision

Manage Homebrew dependencies with a repository-owned `Brewfile` and treat it as the source of truth for brew-managed software.

Set repository conventions:

- Define required formulas, casks, and taps in `Brewfile` at the repository root.
- Run package management directly through `brew` commands (for example, `brew bundle`).
- Review and update `Brewfile` through normal pull request workflow.
- Avoid undocumented ad hoc package installs; package additions should be reflected in `Brewfile`.
- Keep `setup.sh` out of Homebrew management scope; it only ensures required directories exist and creates symlinks.
- Keep `README.md` aligned with these conventions.

## Consequences

Positive:

- Package state is easier to keep consistent across machines.
- Homebrew dependency changes get explicit history and code review.
- Onboarding and machine recovery become more reliable.

Trade-offs:

- `Brewfile` requires ongoing maintenance as tooling needs change.
- Exact list of packages will be reused across machines

Operational notes:

- Brew package management is executed directly via `brew` commands.
- `setup.sh` is limited to dotfile wiring (directory creation and symlinks).
- Existing machines may need a one-time alignment step to reconcile local state.
