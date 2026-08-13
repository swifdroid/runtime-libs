# Architecture Index

Authoritative architecture ownership/router map for `core-libs`.

## Operational Routing

Use this index to select technical architecture owners. Non-trivial iterative LLM-assisted development is model-independent and routed separately through `DEVELOPMENT_ORCHESTRATION.md` + `ARTIFACTS_WORKFLOW.md`.

Supporting authorities:

- `WORKFLOW.md` - PLAN -> IMPLEMENT -> AUDIT
- `DEVELOPMENT_ORCHESTRATION.md` - coordinator/reviewer vs implementation-executor roles
- `ARTIFACTS_WORKFLOW.md` - transient research/plan/task/report/handoff mechanics
- `COMMIT_RULES.md` - Git/staging/commit/publishing safety
- `CONTEXT_LOADING_RULES.md` - progressive context budget

These operational owners have no architecture IDs and do not consume architecture-owner slots.

## Owners

| ID | Owner | Responsibility |
|---|---|---|
| `RPK` | `architecture/RUNTIME_PACKAGING.md` | Swift runtime binary provenance, module contents, ABI/library layout, ingestion rules |
| `BAP` | `architecture/BUILD_AND_PUBLICATION.md` | Gradle/AAR/JitPack build and publication boundary, consumer compatibility evidence |

## Routing

- Runtime `.so` version, provenance, module membership, ABI path, or copy mechanics -> `RPK` primary.
- Gradle configuration, AAR production, JitPack, consumer rules, publication, or representative downstream build -> `BAP` primary.
- A runtime upgrade that changes both binary set and packaging configuration -> choose the owner matching the main mutation and load the other as supporting.

Each rule family has one owner. Overview docs link here instead of becoming competing architecture authority.

