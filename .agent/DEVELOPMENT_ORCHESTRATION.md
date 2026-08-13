# Development Orchestration

Model-independent authority for coordinating `core-libs` repository work with LLMs and coding agents.

This file owns **roles, delegation, review, and gates**. Detailed `.artifacts/**` structure and task/report mechanics are owned by `ARTIFACTS_WORKFLOW.md`.

## Roles

### Coordinator / Reviewer

For non-trivial work, the reasoning/review layer:

- restores current context from real Git/source/stable docs;
- performs or directs focused runtime/toolchain/packaging research;
- designs and independently audits the implementation plan;
- decomposes substantial work into numbered surgical task files;
- gives the implementation executor only a short coordinator prompt;
- independently inspects actual source/configuration/diff/Git after execution;
- turns audit findings into focused correction task files;
- synchronizes durable stable documentation after accepted work;
- keeps commit, push, tag, and publication as separate explicit gates.

Executor reports are evidence, never proof.

### Implementation Executor

The executor implements an already-reviewed task contract:

- read the next numbered task immediately before work;
- modify only its explicit scope/allowlist;
- follow closed mechanics without redesigning packaging/release architecture;
- run required validation and inspect the actual diff;
- append execution evidence;
- continue automatically to the next already-approved task after PASS;
- stop the whole run on a genuine out-of-scope blocker.

The executor does not broaden scope merely to keep moving.

## Default Flow

```text
verify current repository state
-> focused research
-> reviewed plan
-> independent plan audit
-> numbered surgical task files
-> short coordinator prompt
-> autonomous sequential execution + append-only evidence
-> independent source/configuration/diff/Git audit
-> numbered correction wave if needed
-> independent re-audit
-> durable-doc synchronization
-> explicit commit gate
-> explicit push/tag/publication gate when requested
```

For non-trivial iterative work, `ARTIFACTS_WORKFLOW.md` is mandatory and externalizes this flow under `.artifacts/**`.

## Delegation Rule

Never send an implementation executor one huge prompt containing several independent behaviors or a full correction audit.

Instead:

1. group work into tightly coupled, independently verifiable behaviors;
2. put detailed mechanics, allowlists, validation, and stop conditions into numbered task files;
3. give the executor one compact coordinator prompt that lists those files and the autonomous task loop.

If the coordinator prompt starts duplicating all task details, fix the decomposition before execution.

## Planning Gate

Non-trivial production/build work requires reviewed planning when it crosses multiple modules/files, changes Swift Android runtime inputs, binary/module membership, ABI layout, Gradle/AAR behavior, publication configuration, or downstream consumer compatibility.

The plan must be grounded in current source/Git/toolchain evidence and close:

- scope/non-goals;
- intended runtime/toolchain provenance;
- module/binary/build ownership mechanics;
- allowed/forbidden mutation paths;
- downstream compatibility evidence when required;
- validation and stop conditions.

Known plan defects are corrected before implementation.

## Independent Audit

After executor work, independently inspect:

- complete Git status/changed paths;
- actual changed build/configuration/script/binary metadata;
- runtime provenance, module membership, ABI/library layout when affected;
- packaging/publication boundary changes;
- required downstream compatibility evidence;
- forbidden/deferred scope;
- actual validation evidence.

If the coordinator/reviewer cannot directly execute a required build/runtime/consumer verification because its current tool surface lacks the necessary environment or command capability, it must not leave that evidence permanently unverified. Create a focused read-only verification task/prompt for an agent that does have the required environment/tools, require exact commands/observations and a written report artifact, then review that report together with every repository fact that can still be checked directly. Clearly distinguish delegated execution evidence from directly inspected source/Git evidence.

If defects remain, create a new focused numbered correction wave instead of one large correction prompt.

## Milestone Completion Audit

When a repository roadmap/task milestone is being closed, passing implementation tasks, correction waves, builds, and consumer checks is not sufficient by itself.

Before declaring the milestone complete or moving it to the final commit/release gate, run one additional independent conformance audit using a different strong reviewer model/session from the implementation executor and, where practical, from the primary coordinator that designed the work.

The final auditor reviews the complete delivered milestone against the current roadmap and relevant stable architecture/governance owners, including runtime provenance, packaging mechanics, compatibility boundaries, and deferred scope. Record the review under `.artifacts/reviews/`. A blocker reopens a focused correction wave; only a clean verdict allows stable milestone/task state to mark completion.

## Prompt Rules

Agent prompts are written in English unless the maintainer explicitly requests otherwise.

Every prompt should identify the repository/context, role, exact scope or task files, mutation permissions, Git prohibitions, stop conditions, and expected evidence.

Do not make prompts self-contained by duplicating large task files. For artifact-driven execution, self-containment means the prompt explicitly points to the authoritative local task artifacts the executor must read.

## Context Discipline

Do not bulk-load all task files into coordinator/executor context.

- The coordinator/reviewer loads only artifacts and repository evidence needed for the current planning/audit step.
- The executor reads the next numbered task immediately before executing it.
- Operational docs do not consume architecture-owner slots; architecture loading remains governed by `CONTEXT_LOADING_RULES.md`.

## Git Gates

Implementation remains unstaged unless the maintainer explicitly authorizes staging/commit scope.

Normal implementation tasks forbid staging, commit/amend, merge/rebase/reset/restore/clean/stash, branch mutation, push, tag/publication, unrelated fixes, and history rewriting.

Commit/push/tag/publication remain separate phases governed by `COMMIT_RULES.md` and explicit maintainer authorization.

## Disposable Working Memory

`.artifacts/**` may be deleted or absent on another machine. Stable workflow/architecture must remain recoverable from `AGENTS.md`, `.agent/**`, Git, source/build configuration, and current maintainer instruction.

Use `ARTIFACTS_WORKFLOW.md` for artifact structure, `NEW_CHAT.md` reconstruction, task/report conventions, verification delegation, correction waves, milestone reviews, and promotion of durable facts back into stable docs.
