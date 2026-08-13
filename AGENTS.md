# core-libs - Agent Governance

## Repository Identity

`core-libs` is an independent Git repository that packages precompiled Swift runtime `.so` libraries into Android AAR modules for SwifDroid consumers.

It owns runtime-binary ingestion, AAR module topology, Gradle/JitPack packaging, consumer rules, and release compatibility evidence. It does not own JNIKit APIs, Droid framework APIs, or public documentation semantics.

This repository must be safe to open and work with directly. Parent `../SwifDroid` governance is optional cross-repository coordination context, not a prerequisite for normal work here.

## Authority Hierarchy

When local documents conflict, higher authority wins:

1. `.agent/SYSTEM_RULES.md` - repository invariants
2. `.agent/WORKFLOW.md`, `.agent/DEVELOPMENT_ORCHESTRATION.md`, `.agent/ARTIFACTS_WORKFLOW.md`, and `.agent/COMMIT_RULES.md` - development/orchestration/artifact/Git workflow
3. `.agent/ARCH_INDEX.md` and the owning `.agent/architecture/*.md` file - technical architecture authority
4. repository source/build configuration and task-specific evidence
5. `.agent/MASTER_PLAN.md` - repository roadmap
6. `.agent/OPEN_DECISIONS.md` - unresolved choices only
7. `.agent/PROJECT_MEMORY.md` and `.agent/SOURCE_MAP.md` - durable facts/navigation
8. `.agent/TASKS.md`, `.agent/TODO.md`, `.agent/TECH_DEBT.md`, `.agent/TASKS_ARCHIVE.md` - work state
9. `.agent/CONTEXT_LOADING_RULES.md` and `.agent/SKILL_INDEX.md` - routing/procedures

`.artifacts/**` is transient plans/evidence/working memory, never stable product authority.

## Mandatory Workflow

Use **PLAN -> IMPLEMENT -> AUDIT** for non-trivial work.

- Define exact module/path scope, runtime/toolchain inputs, expected outputs, and validation before mutation.
- Make the smallest coherent packaging/build change.
- Audit AAR/module configuration, binary layout/provenance, consumer impact, changelog/docs impact, and Git state.
- If the configured Swift Android toolchain or expected binary set contradicts the plan, stop that implementation path and re-plan instead of normalizing the discrepancy.

### Mandatory Iterative-Development Routing

For non-trivial iterative LLM-assisted work, load `.agent/DEVELOPMENT_ORCHESTRATION.md` and `.agent/ARTIFACTS_WORKFLOW.md`.

- Use `.artifacts/**` as disposable Git-ignored external working memory for research, plans, numbered surgical tasks, execution evidence, verification, reviews, corrections, and chat handoff.
- Large implementation/correction work is decomposed into numbered task files; the executor receives one short generic coordinator prompt and runs approved tasks autonomously in order.
- If `.artifacts/**` is missing, reconstruct current context from stable docs + Git + actual source/build configuration instead of guessing lost transient state.
- Executor reports are evidence, never proof; independently audit actual repository state afterward.

## Mandatory Context Routing

1. Start with this file.
2. Use `.agent/ARCH_INDEX.md` to select one primary architecture owner.
3. Load at most two supporting architecture owners only when genuinely needed.
4. Read `.agent/SOURCE_MAP.md` before broad discovery.
5. Inspect only the affected Gradle/module/script/binary metadata and smallest downstream evidence set required.
6. Load sibling repositories only for a concrete compatibility question. Sibling repositories are zero-context by default.

Full rules: `.agent/CONTEXT_LOADING_RULES.md`.

## Repository Boundaries

- `core-libs` owns packaging Swift runtime libraries into Android-consumable AAR modules.
- Imported `.so` files are release inputs with provenance/version requirements, not source to edit in place.
- `jni-kit` may consume runtime capabilities but owns JNI semantics independently.
- `droid` may consume `jni-kit` and runtime libraries but owns framework/wrapper semantics independently.
- `docs` explains verified public behavior but does not define runtime packaging behavior.

Cross-repository changes require separate repository-local work and Git operations. A request affecting `core-libs` does not authorize mutation in a sibling repository.

## Build and Release Invariants

- Keep each AAR's runtime library set aligned with the intended Swift Android SDK/toolchain release.
- Preserve ABI paths, library names, Gradle coordinates, consumer rules, and publication compatibility unless a reviewed change explicitly modifies them.
- Do not silently mix runtime binaries from different Swift toolchain releases.
- Review `copy-so-files.sh` inputs and targets before executing it.
- Packaging success alone does not prove downstream compatibility. Integration-sensitive changes require representative consumer evidence.
- Binary/version changes require a targeted changelog and downstream compatibility/documentation audit.

Architecture ownership lives in `.agent/architecture/RUNTIME_PACKAGING.md` and `.agent/architecture/BUILD_AND_PUBLICATION.md`.

## Verification

Start with the smallest relevant Gradle/configuration check, then build affected AAR modules. Expand to representative downstream consumer verification when binary names, versions, module dependencies, or packaging structure change.

Report exact commands/evidence and distinguish host packaging success from downstream Android consumption.

## Documentation Self-Maintenance

Update stable `.agent/**` docs only when durable repository facts, architecture, routing, decisions, source locations, or work state change. Temporary command output and release investigation notes belong in `.artifacts/**`.

`CHANGELOG.md` is public release history, not an architecture owner.

## Git Safety

Follow `.agent/COMMIT_RULES.md`. Preserve unrelated staged, unstaged, and untracked work. Never stage, commit, amend, reset, clean, stash, restore, rebase, squash, tag, push, or publish unless explicitly authorized for this repository and exact scope.

## Cross-Repository Coordination

If a task genuinely spans SwifDroid repositories, the parent workspace may be used as a coordination layer, but return here for all `core-libs` mutations, validation, commit decisions, and final Git-state reporting.