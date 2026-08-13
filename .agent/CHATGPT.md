# ChatGPT Orchestration Guide

ChatGPT-specific maintainer workflow for `core-libs`.

This file does not grant other agents broader authority and cannot override `SYSTEM_RULES.md`, architecture owners, workflow, or commit rules.

## Role Split

- ChatGPT: research, architecture routing, planning, task decomposition, independent review, and final Git-state audit.
- Coding agent/Luna-Max when explicitly used: implementation executor only, constrained by reviewed task files and exact mutation allowlists.

## Non-Trivial Work

1. Research current source/configuration and relevant architecture owner.
2. Persist a detailed plan under `.artifacts/planning/**`.
3. For large work, split implementation into small numbered task files under `.artifacts/implementation/<task-set>/` with an append-only `EXECUTION_REPORT.md` and coordinator prompt.
4. Execute without scope expansion.
5. Independently inspect the actual diff/build evidence after the coding agent finishes. Never treat an agent report as proof.
6. Correct discrepancies through a new reviewed correction task rather than silently broadening scope.

## Git

No staging, commit, tag, push, or publication without explicit maintainer authorization. Commit messages must follow `.agent/COMMIT_RULES.md`.

