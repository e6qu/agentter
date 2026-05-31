# Do next

## State
The deliverable `CODE_GENERATION.md` is complete: all 5 providers, cross-language
verification, local-run reproductions, citation-verified (63 URLs, all 200,
all SHA-pinned). Phases 0/1/R/V/S done. What remains is optional.

## Optional, value-ordered
1. **Final human read-through** of `CODE_GENERATION.md` for tone/flow.
2. **Gap-chasing** (all noted inline as `(unverified)` / `?? verify`; none block
   the deliverable). Highest value:
   - GCP: pin a per-product consumer of `googleapis/conformance-tests` (submodule
     path + runner in `python-storage` / `google-cloud-go/storage`).
   - Azure: a public number for TypeSpec adoption %; non-Python `http-client-*`
     CI YAML that runs the spector loop.
   - AWS: confirm aws-sdk-java-v2 does NOT consume Smithy protocol-test traits.
   - Alibaba: the real public API-meta feed (next.api.aliyun.com?); any executed
     cross-language conformance CI.
   - OCI: nothing more is publicly obtainable (harness server + corpus internal).
3. **More local runs** (only if wanted — current coverage already meets scope):
   - GCP in a second language (`gapic-generator-go`) to show engine divergence.
   - AWS `smithy-go` target (vs the TS one already done).
   - Run the real Cloud Functions client's generated unit tests (the GCP run
     produced a `tests/unit/` scaffold).
4. **Cleanup**: delete `_work/` to reclaim disk (everything is reproducible via
   each `<provider>/runs/*/cmd.sh`).

## IaC: Azure Terraform providers (`iac/terraform-azure.md`)
Drafted, commit-pinned, verified via `gh`/WebFetch. Open `?? verify` items:
- **azurerm generated vs hand-written ratio** — pandora `generator-terraform`
  scaffolds azurerm resources; quantify share that is generator-produced vs fully
  hand-written (look for `_gen.go` markers / generated-file headers in azurerm).
- **bicep-types-az pinned permalink** — the "generated from azure-rest-api-specs
  via src/autorest.bicep" claim came from the repo landing page (WebFetch), not a
  SHA-pinned raw file. Pin a commit + line in `Azure/bicep-types-az`.
- **azapi `types.json` schema** — confirmed embedded + loaded; have not pinned the
  concrete field structure (TypeFactory / resource-type defs) from a raw file.
- **pandora data-model schema** — `api-definitions/` exists and `data-api` serves
  it, but the concrete per-resource JSON/HCL definition format is not pinned.

## IaC: Pulumi (`iac/pulumi.md`)
Written, commit-pinned, verified via `gh`/WebFetch/raw fetch. Open `?? verify`:
- **Pulumi YAML codegen/convert entrypoint** in `pulumi/pulumi-yaml` not pinned
  (only repo HEAD `540ebfb339e14aa74cf8772d0ad66fd528a95f27` + Apache-2.0 license
  confirmed). Pin the program-gen / convert entrypoint file+line.
- **pulumi-gcp / pulumi-azure (classic)** bridging asserted by analogy to
  pulumi-aws (same `tfgen` Main); their individual `resources.go` + `GitHubOrg`
  not separately pinned.
- The binary `runPulumiPackageGenSDK` shells out to (`pulumi` on PATH vs embedded)
  was not traced past the `exec` of `package gen-sdk`.

## Carryover
- None. All scope + sequencing decisions made and executed.
