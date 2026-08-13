# Artifacts Workflow

Stable operational authority for how `core-libs` uses transient `.artifacts/**` working memory during research, planning, implementation, correction, verification, audit, and chat handoff.

This file defines the **workflow around artifacts**. Artifact contents never outrank `AGENTS.md`, stable `.agent/**` owners, current Git/source/build configuration, or explicit maintainer instruction.

## Core Principle

`.artifacts/**` is disposable external working memory.

It exists to keep long iterative work precise without forcing one prompt or one chat context to carry the entire task.

It may be deleted at any time, absent on another machine or clean clone, or intentionally rebuilt from current repository facts.

Therefore:

- stable rules and durable architecture never depend on `.artifacts/**` existing;
- `.artifacts/**` is ignored by Git;
- plans/reports/task files are execution instructions and evidence, not permanent product authority;
- after meaningful durable changes, synchronize the relevant stable `.agent/**` owner instead of relying on an artifact forever;
- if artifacts disappear, reconstruct only what current Git/source/stable docs still support; never invent lost historical evidence.

## Mandatory Use for Substantial Iterative Work

Use `.artifacts/**` to externalize context before implementation when work is non-trivial, multi-file, cross-module, runtime/toolchain-sensitive, packaging/publication-sensitive, or otherwise cognitively dense.

Preferred lifecycle:

```text
restore current repo context
-> focused research
-> write research evidence
-> write implementation plan
-> independently audit plan
-> decompose implementation into surgical task files
-> run implementation executor task-by-task
-> append execution evidence after every task
-> independently audit actual repository state
-> create surgical correction tasks when needed
-> validate again
-> run final milestone review when closing a milestone
-> synchronize durable docs
-> separate commit/push/tag/publication gates
```

Do not collapse a large researched implementation into one enormous executor prompt.

## Mandatory Large-Task Decomposition Rule

When implementation contains multiple natural behavior groups, multiple independent mutations, multiple modules/ownership boundaries, several validation phases, or enough detail that a single executor prompt becomes long or cognitively dense, the coordinator MUST decompose it before execution.

Detailed implementation mechanics belong in numbered `.md` task files under `.artifacts/**`.

The executor receives one **short generic coordinator prompt** that only tells it:

- which repository to work in;
- which numbered task files to execute and in what order;
- to read each task immediately before executing it;
- to obey each task's allowlist/stop conditions;
- to append a report after every task;
- to continue automatically to the next task when the current task passes;
- to stop the entire run on an out-of-scope blocker rather than redesigning;
- not to stage/commit/push/tag/publish unless separately authorized.

The coordinator prompt must NOT duplicate the detailed requirements already stored in task files.

### Practical Split Threshold

Split rather than sending one large implementation prompt whenever any of these is true:

- more than one independently verifiable behavior is changing;
- more than one module/build boundary is involved;
- runtime binary and packaging/configuration changes form distinct phases;
- implementation and downstream validation require distinct gates;
- the prompt would need long detailed mechanics;
- a failed middle step should prevent later work from executing.

Prefer several precise tasks over one overloaded prompt, but do not create artificial one-line tasks that destroy locality. One task should represent one tightly coupled behavior group with one meaningful verification gate.

## Recommended Directory Structure

Use a task-specific slug rather than one global plan for substantial work.

```text
.artifacts/
├── NEW_CHAT.md
├── planning/
│   └── <work-slug>/
│       ├── RESEARCH_REPORT.md
│       ├── IMPLEMENTATION_PLAN.md
│       └── PLAN_AUDIT.md
├── implementation/
│   └── <work-slug>/
│       ├── 01-<task>.md
│       ├── 02-<task>.md
│       ├── ...
│       ├── EXECUTION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── corrections/
│   └── <work-slug>/
│       ├── 01-<correction>.md
│       ├── 02-<correction>.md
│       ├── ...
│       ├── EXECUTION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── verification/
│   └── <work-slug>/
│       ├── VERIFICATION_TASK.md
│       ├── VERIFICATION_REPORT.md
│       └── COORDINATOR_PROMPT.md
├── reviews/
│   └── <focused-review>.md
└── patches/
    └── <temporary-patch-evidence>
```

Use only directories/files needed by the current work. Do not manufacture empty bureaucracy.

## Planning Artifacts

### `RESEARCH_REPORT.md`

Stores verified implementation-time evidence needed to design the work, for example:

- current branch/HEAD/status and preservation constraints;
- affected Gradle/module/script/binary topology;
- intended Swift Android toolchain/runtime provenance;
- current library/module membership and ABI layout;
- downstream consumer facts when relevant;
- known constraints/unknowns;
- facts later tasks must not rediscover from memory.

Research must distinguish verified facts from architectural conclusions.

### `IMPLEMENTATION_PLAN.md`

Contains the reviewed implementation design:

- exact goal/scope/non-goals;
- runtime/toolchain provenance decisions;
- affected module/build topology;
- exact mutation paths;
- cross-boundary sequencing;
- downstream compatibility strategy;
- validation strategy;
- explicit deferred work.

It should be implementation-ready before an executor receives production mutation work.

### `PLAN_AUDIT.md`

Records an independent audit of the plan against current Git/source/build configuration, stable governance, architecture owners, and relevant toolchain evidence.

Do not treat a plan as ready merely because it was written.

## Surgical Implementation Task Contract

Each numbered implementation/correction task should contain only the context needed for one tightly coupled batch.

Use this shape when applicable:

```text
# Task NN - Title

## Goal
## Preconditions
## Allowed production paths
## Required implementation
## Runtime / packaging rules
## Explicitly forbidden work
## Verification
## Completion report
## Stop conditions
```

Every task must make scope mechanically clear enough that the executor does not need to invent architecture.

Important:

- exact path allowlists are strongly preferred;
- state which earlier task output may be relied on;
- include the smallest meaningful build/AAR/layout/consumer gate;
- identify binary provenance or module-membership checks when relevant;
- if a task uncovers a plan contradiction requiring broader scope, it stops instead of silently widening scope.

## Autonomous Executor Loop

For prepared multi-task work, the implementation executor follows this loop:

```text
read Task NN completely
-> inspect required current Git/source/build facts
-> implement only Task NN allowlist
-> run Task NN verification
-> inspect actual diff
-> append Task NN result to EXECUTION_REPORT.md
-> if PASS: immediately continue to Task NN+1
-> if BLOCKED: append blocker and stop entire run
```

The executor does not ask for confirmation between already-approved numbered tasks.

## `EXECUTION_REPORT.md`

Execution reports are append-only evidence.

After each task append a distinct section containing:

- actual paths changed;
- implementation facts;
- exact validation commands/results;
- binary/AAR/consumer evidence when actually observed;
- Git state;
- deviations/blockers.

Never rewrite earlier task sections to hide a failed or stopped attempt. A resumed task appends a new clearly named section.

An executor report is never proof by itself. The coordinator/reviewer independently inspects actual source/configuration/diff/Git afterward.

## Verification Delegation

When the coordinator/reviewer lacks a direct tool needed to execute a required build, package inspection, Android consumer check, or runtime verification, create a focused verification artifact rather than accepting a blind spot.

Recommended shape:

```text
.artifacts/verification/<work-slug>/
├── VERIFICATION_TASK.md
├── VERIFICATION_REPORT.md
└── COORDINATOR_PROMPT.md
```

The verification task is read-only unless the maintainer explicitly authorizes otherwise. It must state exact commands/actions, required observations, environment assumptions, report format, and Git-mutation prohibitions.

The delegated agent writes the report from actual execution. The coordinator/reviewer then checks that report plus every repository fact available through its own tools. Delegated evidence fills an execution-capability gap; it does not replace independent source/Git review.

## Final Milestone Conformance Review

When a roadmap/task milestone is being closed, after implementation, corrections, and required validation pass, create one final milestone review under `.artifacts/reviews/` before stable task/roadmap state marks it complete.

Use a different strong reviewer model/session from the implementation executor and, where practical, from the primary coordinator. Review the **entire delivered milestone** against current roadmap and stable owners, including runtime provenance, packaging mechanics, compatibility boundaries, and deferred scope.

A blocker becomes a new focused correction wave. Do not bury correction work inside the review prompt.

## Correction Waves

After independent audit, do not send a giant correction prompt containing every defect.

Instead:

1. group findings into the smallest coherent correction behaviors;
2. create numbered files under `.artifacts/corrections/<work-slug>/`;
3. define exact allowlists and validation for each;
4. create/reset an append-only correction `EXECUTION_REPORT.md` for that wave;
5. give the executor one short coordinator prompt pointing to those files;
6. let the executor run them sequentially and automatically;
7. independently audit the final repository state again.

If another materially distinct issue appears, create another focused correction wave rather than growing the old coordinator prompt.

## `COORDINATOR_PROMPT.md`

This file is intentionally compact and model/vendor independent.

It contains orchestration only, not implementation detail already present in numbered tasks.

Minimum responsibilities:

```text
repository/context
baseline Git expectations
list of numbered task files
execute numerically
read one task immediately before work
append report after each task
continue automatically after PASS
stop on blocker
Git mutation prohibitions
compact final report shape
```

If `COORDINATOR_PROMPT.md` starts restating detailed requirements from every task, the decomposition has failed and must be corrected before execution.

## `NEW_CHAT.md` Purpose

`.artifacts/NEW_CHAT.md` is transient continuation context for the **next coordinator/reviewer conversation**, not stable governance.

Keep enough current context to continue without replaying a long conversation or reopening accepted decisions. Update it after continuity-critical transitions such as:

- branch/HEAD or phase changes;
- accepted audit/correction verdicts;
- dependency/toolchain prerequisite completion;
- new active planning/implementation/correction/review artifact sets;
- important blocker state;
- exact next intended action.

Do not turn it into an ever-growing transcript. Replace stale continuation instructions with a current snapshot while preserving only rationale that still matters.

## Recreating `.artifacts` on Another Machine or After Deletion

If `.artifacts/` or `NEW_CHAT.md` is missing:

1. read root `AGENTS.md` and the minimum stable `.agent/**` governance required for the task;
2. inspect current Git branch/HEAD/status directly;
3. inspect `TASKS.md`, `OPEN_DECISIONS.md`, `PROJECT_MEMORY.md`, `SOURCE_MAP.md`, and relevant architecture owners only as needed;
4. inspect actual changed source/build configuration and recent relevant Git history rather than guessing unfinished work;
5. identify the current work phase from repository evidence and maintainer instruction;
6. create `.artifacts/` directories only as needed;
7. create a fresh `.artifacts/NEW_CHAT.md` from **verified current facts**;
8. if non-trivial work is continuing, recreate fresh research/plan/task artifacts instead of pretending deleted transient plans still exist;
9. never infer uncommitted/lost implementation evidence that is no longer present on disk.

A reconstructed `NEW_CHAT.md` should normally contain:

```text
repository identity/path used in this environment
current branch / HEAD / Git status
current roadmap/work phase
stable governance and architecture owners relevant to continuation
verified completed/accepted work that constrains the next step
current uncommitted changes and preservation rules
active runtime/toolchain/dependency facts needed by the work
current artifact index, if recreated
next intended action
orchestration rules required for continuation
```

Machine-local paths/tool context IDs are allowed in `NEW_CHAT.md` because it is transient. Stable `.agent/**` docs must remain portable.

## Promotion to Stable Documentation

At the end of an accepted implementation/correction cycle, decide what learned information is durable.

Promote only durable facts/rules into the correct stable owner:

- runtime/package architecture rule -> owning architecture document;
- high-level development flow -> `WORKFLOW.md`;
- delegation/review/gates -> `DEVELOPMENT_ORCHESTRATION.md`;
- artifact mechanics -> this file;
- Git/commit/publishing rule -> `COMMIT_RULES.md`;
- source navigation fact -> `SOURCE_MAP.md`;
- durable current-state fact -> `PROJECT_MEMORY.md`;
- unresolved decision -> `OPEN_DECISIONS.md`;
- active executable work -> `TASKS.md`.

Do not promote execution diaries, transient commit hashes, local tool IDs, temporary error logs, or large execution reports.

## Git Rule

`.artifacts/` must remain ignored by repository `.gitignore`.

Do not stage/commit artifacts merely because they were useful during development. They are intentionally local/transient unless the maintainer explicitly changes this repository policy.
