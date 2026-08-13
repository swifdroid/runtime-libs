# Build and Publication Architecture

Architecture ID: `BAP`

## Ownership

This document owns Gradle/AAR build structure, publication configuration, consumer rules, JitPack integration, and the evidence required before claiming a packaging change is consumable.

## Invariants

- The repository's Gradle/module configuration is source authority for produced AARs.
- Preserve published coordinates/module identity unless a reviewed release change explicitly modifies them.
- Consumer ProGuard/rules and packaging configuration must remain aligned with module behavior.
- Generated build output and caches are evidence, not source authority.
- A successful local AAR build proves packaging/build coherence only. It does not by itself prove a generated SwifDroid application can consume and run the result.

## Compatibility Evidence

Escalate to a representative consumer check when a change affects runtime versions, binary names, module dependencies, ABI paths, Gradle coordinates, consumer rules, or publication mechanics.

The consumer environment must be resolved from current configuration at task time. Do not persist machine-specific checkout or SDK assumptions here.

## Publishing

Build success never authorizes publication. Tags, releases, JitPack/repository publishing, or other distribution actions require separate explicit maintainer authorization.

