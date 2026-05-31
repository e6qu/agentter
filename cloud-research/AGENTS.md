# Cloud SDK Code Generation Research

## Purpose

Investigate how major cloud providers (AWS, GCP, Azure, OCI, Alibaba Cloud)
generate their multi-language SDKs at "industrial" scale. Produce a precise,
well-cited comparison in `CODE_GENERATION.md`.

The output should let a reader understand, per provider:
1. What IDL / spec format describes their APIs (OpenAPI, Smithy, Protobuf,
   TypeSpec, custom, etc.)
2. Which code generator(s) consume that spec
3. How the generation pipeline is orchestrated (build tools, CI, packaging)
4. Per-language customization: templates, post-processors, hand-written shims
5. What is **actually generated** vs **manually authored** for each SDK
6. How customizations / overrides are expressed (Smithy customizations,
   AutoRest directives, gapic-generator handwritten layers, etc.)

## Rules

- **Cite source.** Every non-trivial claim must link to a specific
  commit / file / line in the actual generator repos. Prefer permalinks
  (`/blob/<sha>/`) over `/blob/main/`.
- **No guessing.** If uncertain, mark with `?? verify` and add to `DO_NEXT.md`.
- Per-cloud directories (`aws/`, `gcp/`, `azure/`, `oracle/`, `alicloud/`)
  hold raw research notes. `CODE_GENERATION.md` is the polished summary
  that synthesizes them.
- Use Python with `uv` + venv if local spec / schema processing is needed.
- Use research subagents for breadth (fetching across many repos), but
  always verify claims against actual file contents before committing
  them to `CODE_GENERATION.md`.

## File layout

```
sdk-codegen-research/
├── AGENTS.md           # This file
├── CLAUDE.md           # Symlink -> AGENTS.md
├── PLAN.md             # Research plan and methodology
├── STATUS.md           # Current snapshot of progress
├── DO_NEXT.md          # Concrete next steps
├── WHAT_WE_DID.md      # Running log: what we tried, what worked, what didn't
├── CODE_GENERATION.md  # Final output (the deliverable)
├── aws/                # Raw research notes for AWS / Smithy
├── gcp/                # Raw research notes for GCP / googleapis / gapic
├── azure/              # Raw research notes for Azure / AutoRest / TypeSpec
├── oracle/             # Raw research notes for OCI SDKs
└── alicloud/           # Raw research notes for Alibaba Cloud / Darabonba
```

## How to resume across sessions

1. Read `STATUS.md` — where we are right now
2. Read `DO_NEXT.md` — what to do next
3. Read recent entries in `WHAT_WE_DID.md` for context on attempts
4. Do work. Update `WHAT_WE_DID.md` as you go.
5. Before stopping, refresh `STATUS.md` and `DO_NEXT.md`.

## User preferences in scope here

- Phase docs (PLAN.md and any BUGS.md) get updated in the same PR as the
  phase's code changes. (Inherited from user's standing guidance.)
- No phase numbers or BUGS-ID references in generated artifacts — those
  belong in commit messages, not in deliverables.
- No silent fallbacks in code/scripts: if a parse fails or a file is
  missing, fail loudly rather than continuing with a default.
