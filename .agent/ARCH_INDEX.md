# Architecture Index

Authoritative architecture ownership/router map for `core-libs`.

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

