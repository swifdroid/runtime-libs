# System Rules

Global invariants for `core-libs` development.

## Planning and Evidence

- Every non-trivial change requires a reviewed plan before implementation.
- Stable documentation describes verified repository state or reviewed architecture, not temporary implementation history.
- Planned runtime/module changes must never be described as already published or consumer-compatible.
- Temporary command output, binary inventories, migration notes, and investigation evidence belong in `.artifacts/**`.

## Packaging Authority

- Source build configuration and the local architecture owners define packaging behavior.
- Imported Swift runtime `.so` files are versioned release inputs. Do not edit their contents as source.
- Do not infer binary provenance or Swift toolchain version from filenames alone when exact provenance matters.
- Packaging output is not proof of downstream runtime compatibility.

## Non-Speculative Changes

- Prefer the smallest packaging/build change that solves the verified problem.
- Do not invent new module hierarchies, publication mechanisms, or version-selection systems for hypothetical future needs.
- If runtime/toolchain evidence contradicts the reviewed plan, stop and re-plan the affected path.

## Repository Independence

- `core-libs` is independently governed and independently versioned in Git.
- Sibling repositories may be inspected for compatibility evidence but do not become local authority.
- Cross-repository impact does not authorize sibling mutations.

## Documentation Self-Maintenance

- When architecture ownership, durable source locations, release invariants, decisions, or work state change, update only the affected stable docs.
- Avoid duplicated authority. `ARCH_INDEX.md` routes to one owning architecture document per rule family.

