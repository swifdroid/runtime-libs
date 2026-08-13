# Context Loading Rules

Mandatory progressive-loading discipline for `core-libs` agents.

## Default Budget

- load **1 primary architecture owner**;
- load **at most 2 supporting owners** only when needed;
- inspect the **smallest relevant build/module/script subset**;
- sibling repositories are **0 by default**.

Do not bulk-load all AAR modules, binary directories, sibling repositories, or historical release evidence.

## Loading Sequence

1. Read root `AGENTS.md`.
2. If the work is non-trivial iterative LLM-assisted development, load `DEVELOPMENT_ORCHESTRATION.md` and `ARTIFACTS_WORKFLOW.md`. These are operational routing docs and do not consume architecture-owner slots.
3. Use `ARCH_INDEX.md` to choose the primary owner.
4. Read `SOURCE_MAP.md` before broad discovery.
5. Inspect the exact root/module Gradle files, script, binary paths, changelog entries, or consumer rules involved.
6. Add a sibling repository only for a concrete downstream compatibility question.
7. Stop loading once ownership, scope, and required evidence are clear.

## Escalation

Cross-module release migrations or repository-wide audits may exceed the default budget deliberately. State why broader context is required, then return to focused ownership after the audit.

