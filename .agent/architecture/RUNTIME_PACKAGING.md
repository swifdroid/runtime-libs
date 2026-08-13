# Runtime Packaging Architecture

Architecture ID: `RPK`

## Ownership

This document owns Swift runtime binary provenance, ingestion, module membership, ABI/library layout, and runtime-version consistency for `core-libs`.

## Invariants

- Runtime `.so` files are external release inputs, not editable source.
- All binaries intentionally shipped for one release must match the intended Swift Android SDK/toolchain unless an explicit reviewed exception documents otherwise.
- Preserve exact Android ABI directory layout and library names expected by consumers.
- Module membership is deliberate. Adding/removing a library requires review of transitive runtime needs and downstream consumers.
- Never infer a successful runtime upgrade solely from a copy script completing without error.

## Ingestion

Before executing `copy-so-files.sh` or equivalent bulk replacement:

1. establish the intended Swift Android toolchain/release;
2. inspect configured source and destination paths;
3. define the expected module/library delta;
4. execute only within approved scope;
5. audit the produced binary/file diff and affected Gradle metadata.

Machine-local SDK paths are transient environment facts and must not become stable architecture assumptions.

## Downstream Impact

Changes to runtime binaries, names, module membership, or ABI layout may require representative `jni-kit`/`droid` consumer verification. Inspection does not authorize sibling mutation.

