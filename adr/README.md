# Architecture Decision Records (ADR)

This directory is the canonical decision database for monorepo-level architecture and design choices.

## Goals

- Keep decisions explicit, concise, and easy to scan.
- Preserve context for future contributors and agents.
- Make decision history auditable over time.

## Tooling standard

This repository uses [`adr-tools`](https://github.com/npryce/adr-tools) for ADR lifecycle management.

- ADR directory: `adr/`
- Directory hint file: `.adr-dir`
- Filename pattern: `NNNN-short-title.md`

## Record format

Every ADR must include these sections in this order:

1. `# N. Title`
2. `Date: YYYY-MM-DD`
3. `## Status`
4. `## Context`
5. `## Decision`
6. `## Consequences`

Use direct and concrete wording. Keep each section focused and short.

## Writing style

- **No pronouns.** Write in the third person or impersonal voice. Replace "we decided" → "the decision is", "our system" → "the system".
- **No "want".** Express motivation objectively. Replace "we want faster builds" → "the motivation is faster builds" or "faster builds are required".
- **No "I", "we", "our", "they", "you", "their".** These leak team-specific voice and age poorly.
- Be declarative: state facts, constraints, and decisions — not intentions.

## Workflow

1. Install `adr-tools` locally.
2. Create a record with `adr new "Short decision title"` or the local wrapper command when available.
3. Fill in context, decision, and consequences.
4. Open a PR and reference the ADR in related code/docs changes.

## Scope and references

- Use this directory for monorepo-level and cross-package decisions.
- Product-specific narrative decisions can stay in local product docs, but technical decisions that affect the monorepo should be captured here.
- Reference ADRs from code comments, PR descriptions, and docs when relevant.
