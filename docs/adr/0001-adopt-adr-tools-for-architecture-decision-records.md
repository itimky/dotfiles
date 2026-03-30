# 0001. Adopt adr-tools for architecture decision records

Date: 2026-03-30

## Status

Accepted

## Context

The monorepo has many packages, apps, and evolving design choices.
Decision context is currently spread across multiple locations and formats.
Resulting fragmentation makes decision rationale, considered alternatives, and active constraints hard to understand.

Motivation: a single, tidy, and predictable record system for both humans and coding agents.

## Decision

Use ADRs as the standard format for monorepo-level architecture design decisions.
Manage ADR records with the third-party tool `adr-tools`.
Store records in `docs/adr` using sequential numeric filenames.

Set repository conventions:

- `docs/adr` is the canonical ADR database for monorepo-level decisions.
- `.adr-dir` points tooling to `docs/adr`.
- ADR files follow the `NNNN-short-title.md` format.
- ADRs use one consistent section structure: Status, Context, Decision, Consequences.

## Consequences

Positive:

- Decision history becomes explicit, searchable, and consistent.
- Contributors and agents can quickly recover architectural intent.
- PRs and implementation changes can reference stable decision IDs.

Trade-offs:

- Writing ADRs adds process overhead.
- Teams must keep records current and avoid stale decisions.

Operational notes:

- New monorepo-level decisions should include a new ADR.
- If a decision is replaced, create a new ADR and mark old records as superseded.
