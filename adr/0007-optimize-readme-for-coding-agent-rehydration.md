# 7. Optimize README for coding agent rehydration

Date: 2026-04-05

## Status

Accepted

## Context

The current `README.md` is intentionally short, but it does not give new contributors or coding agents enough context to understand the repository shape quickly.
That increases repeated repo rediscovery work for common tasks such as setup, navigation, maintenance, and targeted edits.

## Decision

Use the repository `README.md` as the primary rehydration document for both humans and coding agents, with coding agent performance as the primary optimization target.

The README should be expanded to include, in this order:

1. A short project overview
2. Repository layout with top-level directory responsibilities
3. Quick start and installation path
4. Common human-oriented one-time setup commands and local workflow commands
5. Notes on how the repository is organized
6. Development workflow and safe change practices
7. Links to architecture decisions in `adr/`
8. Brief troubleshooting guidance
9. Short contribution guidance

The README must also follow these constraints:

- State explicitly that coding agents must not use `make`; `make` targets are for human-oriented one-time runs and convenience workflows.
- Keep the README compact and direct, using the absolute minimum wording required to answer "what is here, how do I use it, and where do I change things?" for both humans and coding agents.
- Link to deeper documents instead of duplicating long explanations in the README.

## Consequences

Positive:

- New contributors can build a correct mental model of the repository faster.
- Coding agents can recover useful context from a small number of stable files instead of rediscovering repository structure repeatedly on each prompt.
- Human convenience workflows remain documented without implying that coding agents should invoke them.

Trade-offs:

- The README now has to be maintained as a living orientation document rather than a minimal landing page.
- Keeping the README both compact and clear requires more editorial discipline than either a minimal placeholder or a long-form guide.
- Structural changes to the repository should be reflected in both the README and relevant ADRs.
