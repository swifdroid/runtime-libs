# Project Memory

Durable current-state facts useful to future `core-libs` agents.

- This is an independent Git repository inside the broader SwifDroid workspace.
- Its product responsibility is packaging precompiled Swift runtime libraries into Android AAR modules.
- Runtime `.so` files are imported release inputs with provenance/version requirements.
- `copy-so-files.sh` is an ingestion helper and must be audited before/after execution.
- Downstream SwifDroid consumers include JNIKit/Droid-generated Android workflows, but sibling repositories do not define local packaging semantics.
- Parent `../SwifDroid` governance is optional cross-repository coordination context, not mandatory local context.

Do not record transient Git status, local SDK paths, one-off command output, or debugging diaries here.

