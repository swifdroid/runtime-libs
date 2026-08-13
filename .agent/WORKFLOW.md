# Workflow

Mandatory development workflow for `core-libs`.

## PLAN -> IMPLEMENT -> AUDIT

Every non-trivial task follows:

1. **PLAN** - define exact module/path scope, runtime/toolchain inputs, expected mutations, downstream risk, and completion evidence.
2. **IMPLEMENT** - execute the reviewed plan without unrelated module, binary, build, or release expansion.
3. **AUDIT** - verify configuration, binary layout/provenance, build output, downstream compatibility when required, docs/changelog impact, and Git state.

Small typo/prose-only work may skip a formal plan but still requires scope/result verification.

## Binary and Toolchain Changes

For a runtime update, explicitly establish the intended Swift Android toolchain/version and expected module library set before copying/replacing binaries.

Do not treat `copy-so-files.sh` as authority. Inspect its configured inputs/targets and audit its produced diff.

## Verification Progression

Use the narrowest evidence first:

```text
configuration/source audit
-> affected Gradle/module build
-> AAR/binary layout inspection when relevant
-> representative consumer verification for integration-sensitive changes
```

## Documentation Synchronization

Update stable governance only for durable changes. Update `CHANGELOG.md` when the approved task changes releasable runtime/module behavior and the project convention requires a release note.

## Git Safety

Follow `COMMIT_RULES.md`. Never stage, commit, tag, push, publish, or rewrite history without explicit authorization.

