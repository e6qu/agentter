# Rebuilding & verifying `_work/`

`_work/` is **scratch** — the throwaway workspace where the local generator
reproductions actually execute (venvs, shallow clones, `node_modules`, Go bins,
generated trees). It is **deliberately excluded from git** (~400 MB, fully
regenerable). This doc explains how to rebuild it and verify a rebuild matches
what's documented.

Nothing in the deliverables depends on `_work/` existing: every reproduction's
**pinned inputs** (`<run>/input/`), **captured outputs** (`<run>/output/`),
**exact command** (`<run>/cmd.sh`), and **evidence** (`<run>/README.md`) are
committed. `_work/` is only needed if you want to *re-run* a generator yourself.

## What lives in `_work/`

One scratch subdir per reproduction (created by that run's `cmd.sh`):

| `_work/` subdir | Belongs to | Created by |
|---|---|---|
| `gcp-venv/`, `googleapis/` | `gcp/runs/cloudfunctions-python` | `uv venv` + sparse clone of `googleapis` |
| `aws-smithy/` | `aws/runs/sqs-typescript` | `smithy init` / Gradle Smithy build |
| `azure-autorest/` | `azure/runs/widget-autorest-python` | AutoRest (npm) over the Swagger input |
| `azure-typespec/` | `azure/runs/widget-typespec-ts` | TypeSpec compiler + emitter |
| `darabonba/` | `alicloud/runs/darabonba-multilang` | `@darabonba/cli` (`dara codegen`) |
| `jsii-demo/` | `iac/runs/jsii` | jsii + jsii-pacmak |
| `pulumi-demo/` | `iac/runs/pulumi` | `pulumi package gen-sdk` |
| `bicep-demo/` | `iac/runs/bicep` | Bicep CLI |
| `tf-schema/` | `iac/runs/terraform-schema` | `terraform providers schema -json` |
| `tfcodegen/` | `iac/runs/terraform-plugin-codegen` | `tfplugingen-framework` |
| `bin/`, `gobin/` | shared | downloaded CLIs / `go install` targets |

## Prerequisites (pinned toolchains)

The versions the runs were captured against (newer usually works; the **pinned
input SHAs/versions are what guarantee byte-level reproducibility**, not the tool
version):

- **Python** via [`uv`](https://docs.astral.sh/uv/) (3.13) — GCP, Azure-AutoRest
- **Node** 26 + npm — Azure (AutoRest/TypeSpec), Alibaba (Darabonba), jsii
- **Go** 1.26 — Pulumi Go SDK, terraform-plugin-codegen
- **Java + Gradle** — AWS Smithy build
- **pandoc** (`brew install pandoc`) — **hard dependency** of
  `gapic-generator-python` (proto-comment → docstring conversion; without it the
  plugin exits 1)
- **Terraform** 1.13.5, **Pulumi** 3.244.0, **Bicep CLI** 0.43.8, **jsii** 5.9.43
- macOS/Homebrew assumed for `brew`-installed tools

Each run's `README.md` lists the exact toolchain versions it used.

## Rebuild a single reproduction

Every `cmd.sh` creates its own workspace in the current directory, so run it from
inside `_work/`:

```bash
mkdir -p _work && cd _work
# example — regenerate the GCP GAPIC Python client:
bash ../gcp/runs/cloudfunctions-python/cmd.sh
```

`cmd.sh` is the **documented command sequence** (pinned SHAs, exact flags), not a
turnkey installer — read it first; you may need to (a) install the prerequisite
listed at its top, and (b) point `--out`/`OUTPUT_DIR`-style placeholders at a
scratch path. The script clones pinned sources (e.g. `googleapis` @
`0054cdcb…`) and runs the generator exactly as the run's README describes.

To rebuild **all** of them, run each `cmd.sh` listed above from `_work/`.
(`oracle/runs/` has **no** `cmd.sh` — OCI's generator is closed-source; that run
is documented as an intentional non-reproduction.)

## Verify a rebuild matches the committed result

A reproduction is "good" if the freshly generated tree matches the committed
`<run>/output/` and the README's evidence still holds:

1. **File/line counts.** Each README states what was produced (e.g. GCP: "63
   files, ~22,190 LOC"; AWS SQS: "46 files"). Compare:
   ```bash
   # regenerated output vs committed output
   diff -rq _work/<scratch>/<generated> ../<provider>/runs/<run>/output
   find _work/<scratch>/<generated> -type f | wc -l   # vs the README's count
   ```
2. **Evidence lines.** Each README cites specific generated artifacts that prove
   the documented mechanism — e.g. GCP `client.py` has the flattened
   `name: Optional[str] = None` overload (the `method_signature` annotation at
   work); jsii's Python `greet()` body is `return jsii.invoke(self, "greet", [])`
   (the proxy-over-Node-kernel model). Re-check those lines exist in the rebuild.
3. **Generator headers.** Generated files carry `DO NOT EDIT`-style banners
   (`// smithy-typescript generated code`, `# This file is auto-generated`, etc.)
   — their presence confirms the file came from the generator, not by hand.

Minor diffs (timestamps, absolute paths, tool patch versions, formatting) are
expected and benign. A *structural* divergence (missing services, different
file set, absent evidence lines) means something in the toolchain drifted —
check the README's pinned versions first.

## Reclaiming the space

`_work/` is safe to delete at any time:

```bash
rm -rf _work
```

Everything in it is reproducible from the committed `cmd.sh` + `input/`. This is
why `_work/` is git-ignored and was not included in this repository.
