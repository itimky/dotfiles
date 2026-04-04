# 5. Reorganize repository layout

Date: 2026-04-04

## Status

Accepted

## Context

The repository root had accumulated unrelated files and directories.
Top-level clutter made navigation, automation, and agent-oriented discovery less predictable.
The latest layout update moved related assets into grouped directories.

## Decision

Adopt a grouped repository layout:

- `adr/` holds architecture decision records.
- `base/` holds shared shell, editor, and baseline package-manager files.
- `dev/` holds development-environment assets
- `etc/` holds optional or machine-specific package-manager inputs.

Update repository tooling and documentation to reference the grouped paths instead of the former root-level locations.

## Consequences

Positive:

- The repository root becomes easier to scan.
- Related configuration files become easier to find and maintain.
- Automation can target clearer path boundaries.

Trade-offs:

- Existing scripts and docs must be updated after path moves.
- External references to former paths may break until migrated.
