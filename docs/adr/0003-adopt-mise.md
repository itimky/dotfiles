# 3. Adopt mise

Date: 2026-03-30

## Status

Accepted

## Context

This repository currently uses multiple version-management approaches (`asdf`, `pyenv`, and separate language-specific setup).
Using one manager across languages reduces maintenance burden and shell setup complexity.

## Decision

Choose `mise` as the default runtime version manager.

Why:

- Compatible with existing `.tool-versions` and common asdf plugins.
- Supports multi-language management in one place.
- Simplifies Go and Python version handling.

Replacement scope:

- Replace: `asdf`, `pyenv`, `pyenv-virtualenv`.
- Replace: hardcoded Go version PATH wiring with `mise`-managed Go versions.
- Replace from baseline Brewfile when managed by `mise`: `python@*`, `node`, `openjdk`.
- Remove `poetry` from baseline Brewfile; add it only where project workflows explicitly require it.

## Consequences

Positive:

- Less tool to manage in this repo.
- Faster local tooling and simpler runtime management.

Trade-offs:

- A new tool to learn.
- Some teams may prefer the longer-established defaults (`asdf`/`pyenv`).

Operational notes:

- New projects and local environment updates should default to `mise`.
- Existing `.tool-versions` and `.python-version` files can remain during migration.
