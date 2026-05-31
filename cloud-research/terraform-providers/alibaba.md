# Alibaba Cloud Terraform Provider — How It's Built

Research date: 2026-05-30. Repo: **`aliyun/terraform-provider-alicloud`**.
All permalinks pinned to commit **`69f22ea780e942e0b728942a14f94ac78a8343bb`**
(default branch `master`, HEAD at capture). License: **MPL-2.0** (verified:
`LICENSE` begins "Mozilla Public License Version 2.0"; GitHub repo metadata
`spdx_id: MPL-2.0`).

---

## TL;DR

The Alibaba Cloud provider is a **single hand-maintained Go module** built on the
**legacy Terraform Plugin SDK v1** (`github.com/hashicorp/terraform-plugin-sdk`
v1.17.2 — *not* v2, *not* the Plugin Framework). Unlike Google's Magic Modules,
there is **no in-repo code generator** (no `gen/` dir, no `go:generate`
directives, no codegen Go source). However, the provider is **not purely
hand-written either**: a large fraction of resource/service files were
**scaffolded by an external (internal Alibaba) generator** and carry a marker
comment on line 1:

```go
// Package alicloud. This file is generated automatically. Please do not modify it manually, thank you!
```

The workflow treats generated files as a *starting point*: the moment a human
edits one, they **delete the marker** and the file becomes hand-maintained Go
(documented explicitly in the repo's own dev skill, see below). So the picture is
a spectrum:

- **Generated-and-untouched** (still carry the marker): ~508 resource files +
  ~65 data-source files at this SHA.
- **Generated-then-hand-edited** (marker removed) and **classic hand-written**
  (predate the generator): the remaining majority of the ~2248 `resource_*.go`
  and ~1459 `data_source_*.go` files.
- **Always hand-written core**: provider config, auth, the `connectivity/` HTTP
  client layer, helpers — never carry the marker, have unit tests alongside.

The provider sits on a **mix of Go SDK families** (see "SDKs" below): the older
monolithic `aliyun/alibaba-cloud-sdk-go`, the Darabonba-generated
`alibabacloud-go/*` per-service SDKs + `darabonba-openapi` runtime, plus several
bespoke service SDKs (OSS, Log/SLS, Tablestore, MNS, DataHub, FC). Newer
resources increasingly bypass typed service SDKs entirely and call the
**darabonba-openapi** gateway client directly with `jsonpath` over raw maps.

---

## 1. Generated or hand-written?

### No in-repo generator
The root tree has dirs `alicloud/`, `ci/`, `examples/`, `scripts/`, `website/`,
`.github/`, `.aoneci/`, `.opencode/` — **no `gen/`, no `magic-modules`-style
DSL/templates, no scaffolding generator source**. `GNUmakefile` has **no
generate target** and the repo has **zero `go:generate` directives** (GitHub code
search for `"go:generate"` in the repo → `total_count: 0`). The generator that
emits the "generated automatically" files is therefore an **external / internal
Alibaba tool**, not committed here.
- Root tree: `https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/`
- `GNUmakefile`: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/GNUmakefile`

### Evidence of generation (the marker)
The repo ships a helper script `scripts/count_generated_resources.sh` that counts
"auto-generated resource files" by grepping for `This file is generated
automatically` — direct evidence the maintainers themselves track a generated
subset:
```bash
# scripts/count_generated_resources.sh
for file in alicloud/resource*.go; do
    if grep -q "This file is generated automatically" "$file"; then
        ((count++)); echo "✓ $file"
    fi
done
```
Source: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/scripts/count_generated_resources.sh`

A confirmed generated resource (`resource_alicloud_milvus_instance.go`) begins:
```go
// Package alicloud. This file is generated automatically. Please do not modify it manually, thank you!
package alicloud
...
func resourceAliCloudMilvusInstance() *schema.Resource {
	return &schema.Resource{
		Create: resourceAliCloudMilvusInstanceCreate, ...
```
Source: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_milvus_instance.go`

Generated **service** files exist too (the `Describe*`/Read helper layer), e.g.
`service_alicloud_dms_v2.go` carries the same marker and a
`type DmsServiceV2 struct { client *connectivity.AliyunClient }`.
Source: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/service_alicloud_dms_v2.go`

### The "edit it and it stops being generated" rule (key nuance)
The repo's own developer skill `provider-add-attribute` (under `.opencode/skills/`,
used by an agentic dev workflow) states as **Step 3, Rule 1**:
> **Remove the auto-generated comment on line 1** once you modify a resource
> file: `// Package alicloud. This file is generated automatically...`

So the marker means "scaffolded and *not yet* hand-edited." Files lose the marker
as soon as a human touches them. Generated output is a **seed**, after which the
file is hand-maintained Go — *not* a continuously-regenerated artifact like Magic
Modules' `mmv1`. There is no round-trip regeneration of edited files.
Source: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/.opencode/skills/provider-add-attribute/SKILL.md`

### Counts (at this SHA)
- `alicloud/` directory: 3970 entries; `resource_*` files: 2248,
  `data_source_*`: 1459, `service_*`: 230 (file-prefix counts, including
  `_test.go`).
- Files still carrying the generated marker (GitHub code search, scoped to
  `path:alicloud`): **508** `resource*` files, **65** `data_source*` files.
- Total marker hits repo-wide: 574 (includes the script + a `SKILL.md`).
Source (search): `gh api search/code q='"This file is generated automatically" repo:aliyun/terraform-provider-alicloud path:alicloud filename:resource'` → `total_count: 508`.

### Classic hand-written resources (no marker, older SDK)
Older flagship resources predate the generator and use the **legacy typed SDK**.
`resource_alicloud_instance.go` (ECS) has **no marker** and imports
`github.com/aliyun/alibaba-cloud-sdk-go/services/ecs` + `denverdino/aliyungo`.
By contrast the newer `resource_alicloud_vpc.go` (also no marker — VPC was
migrated to the new style) imports only `PaesslerAG/jsonpath` + `connectivity`
and calls the gateway directly. This is the **old-SDK vs new-gateway split**
inside the same provider.
- ECS (classic): `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_instance.go`
- VPC (new style): `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_vpc.go`

---

## 2. What SDKs does it sit on?

`go.mod` (module `github.com/aliyun/terraform-provider-alicloud`, `go 1.24.0`)
pulls in **several Go SDK families simultaneously**:
Source: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/go.mod`

**A. Darabonba-generated / Tea runtime (the modern path)**
- `github.com/alibabacloud-go/darabonba-openapi/v2 v2.1.14` — the Tea OpenApi
  gateway client (itself Darabonba-authored; see `alicloud/notes.md` Q2/Q4).
  This is the request/response pipeline most **new** resources call directly.
- `github.com/alibabacloud-go/tea v1.3.13`, `tea-roa v1.3.4`, `tea-rpc v1.2.0`,
  `tea-utils v1.4.5` (+ `/v2`) — the hand-written Tea/Darabonba Go runtime.
- Per-service Darabonba-generated SDKs imported as needed, e.g.
  `github.com/alibabacloud-go/cs-20151215/v7 v7.6.0` (Container Service / ACK),
  `github.com/alibabacloud-go/sts-20150401/v2`,
  `github.com/alibabacloud-go/fc-open-20210406/v2`.
- Gateway SPI plugins: `alibabacloud-gateway-oss`, `alibabacloud-gateway-sls`,
  `alibabacloud-gateway-spi` — pluggable backend protocols.

**B. Legacy monolithic SDK (the classic path)**
- `github.com/aliyun/alibaba-cloud-sdk-go v1.62.590` — the older single-repo
  multi-product Go SDK (used by ECS, etc.).

**C. Bespoke per-service hand-written SDKs**
- `github.com/aliyun/aliyun-oss-go-sdk v2.2.9+incompatible` (classic OSS v2 line)
  and `github.com/aliyun/alibabacloud-oss-go-sdk-v2 v1.5.0` (newer OSS line) —
  both hand-written, NOT Darabonba (confirms `alicloud/notes.md` Q5).
- `github.com/aliyun/aliyun-log-go-sdk` (SLS/Log), `aliyun-tablestore-go-sdk`
  (OTS), `aliyun-mns-go-sdk` (MNS data-plane), `aliyun-datahub-sdk-go`,
  `aliyun/fc-go-sdk` (Function Compute), `denverdino/aliyungo` (very old
  community SDK still used by some resources).

**D. Auth / credentials**
- `github.com/aliyun/credentials-go v1.4.10` (`alibabacloud-credentials` Go
  flavor) — the credential-provider chain, hand-written, shared.

**The chain, end to end:**
```
Darabonba/.dara specs (aliyun/alibabacloud-sdk monorepo)
   │  dara codegen --lang go
   ▼
alibabacloud-go/<service>-<ver>  (GENERATED, "auto-generated, don't edit")
   +  darabonba-openapi/v2 + tea + credentials-go  (HAND-WRITTEN runtime)
   ▼
terraform-provider-alicloud  (resource/service .go files: GENERATED SEED,
   then HAND-MAINTAINED; provider core HAND-WRITTEN)
   ▼
Terraform Plugin SDK v1 schema  →  Terraform CLI / registry
```
Many **new** resources skip step "alibabacloud-go/<service>" entirely and call
`darabonba-openapi/v2` directly with raw maps + `jsonpath`, so the typed
per-service SDK is optional.

---

## 3. Plugin SDK v2 vs Plugin Framework?

**Neither — it uses Terraform Plugin SDK *v1*.**
- `go.mod`: `github.com/hashicorp/terraform-plugin-sdk v1.17.2` (note: the module
  path has **no `/v2`** suffix → SDK v1; v2 would be `terraform-plugin-sdk/v2`).
- `main.go` serves via the v1 path:
  ```go
  import "github.com/hashicorp/terraform-plugin-sdk/plugin"
  func main() { plugin.Serve(&plugin.ServeOpts{ ProviderFunc: alicloud.Provider }) }
  ```
- `alicloud/provider.go`: `func Provider() terraform.ResourceProvider` returning a
  `*schema.Provider` with a giant static `ResourcesMap map[string]*schema.Resource{...}`
  (begins line ~926), importing `helper/schema`, `helper/validation`,
  `terraform` from the **v1** module. No `terraform-plugin-framework` /
  `providerserver` imports anywhere.
- main.go: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/main.go`
- provider.go: `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/provider.go`

This is notable: AWS/Google have largely moved to muxed Plugin Framework +
SDKv2; alicloud is still on the **oldest** generation of the SDK, which is part of
why the provider leans on its own `connectivity` layer and raw-map plumbing.

---

## 4. Generated vs hand-written split (core vs resources)

**Hand-written core — never carries the marker:**
- `alicloud/connectivity/` — the HTTP/client layer: `client.go`, `config.go`,
  `endpoint.go`, `regions.go`, `helper.go` (each with a `*_test.go` sibling →
  hand-maintained). `connectivity/client.go` wires up the gateway/openapi/roa/rpc
  clients (imports `darabonba-openapi/v2/client`, `cs-20151215/v7/client`,
  `alibabacloud-gateway-oss/client`, `tea-roa`, etc.). Marker count in
  `client.go`: 0.
  - `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/connectivity/client.go`
  - `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/connectivity/config.go`
- `alicloud/provider.go` — provider schema, the resource/data-source registry,
  and `providerConfigure(...)`. Hand-written.
- Auth: `provider.go` + `connectivity/config.go` build credentials via
  `github.com/aliyun/credentials-go/credentials` (and its `providers`
  sub-package) — the `alibabacloud-credentials` chain. Hand-written glue around a
  hand-written credentials SDK.
- `alicloud/helper/` — shared helpers (hand-written).

**Resource / service / data-source files — generated SEED, then hand-maintained:**
- ~508 `resource_*` and ~65 `data_source_*` files still pristine-generated;
  the rest hand-edited or classic. The generator emits the full Schema + CRUD
  skeleton + a `service_<product>_v2.go` Describe helper, all in the **new gateway
  style** (`jsonpath` + `connectivity.AliyunClient` + `darabonba-openapi`).

So: **core = hand-written; the long tail of resources = generator-scaffolded Go
that is then owned and edited by humans.** This is a *weaker* form of codegen than
Google Magic Modules (where the Go is a build artifact and edits go into the YAML
DSL) — here the Go *is* the source of truth post-scaffold.

---

## 5. Magic-Modules-style effort? / scaffolding generator in-repo?

- **In-repo scaffolding generator: NO** (`?? verify` resolved → not present).
  No `gen/`, no `go:generate`, no DSL/template tree. The "generated automatically"
  marker proves an *external* generator exists, but its source is **not in this
  repo** (it is an internal Alibaba tool, plausibly driven from the same
  API-meta / OpenAPI-portal feed that powers Darabonba — `?? verify` exact tool;
  add to gaps).
- **Magic-Modules equivalent: NO** continuously-regenerated DSL→Go system. The
  closest analogue is the one-shot scaffold + the `count_generated_resources.sh`
  bookkeeping + the agentic `.opencode/skills/` that script the "add attribute /
  add resource / review" workflows. These skills are *operator playbooks*, not a
  generator.
  - `https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.opencode/skills`

---

## Pipeline / orchestration (supporting detail)

- **CI**: dual-mirrored. `.github/workflows/` (acctest basic / integration /
  lint, document-check, release, testing-coverage-rate) and `.aoneci/` (the same
  jobs for Alibaba's internal **Aone** CI). The `.aoneci` presence shows the
  canonical CI is Alibaba-internal, mirrored to GitHub Actions.
  - `https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.github/workflows`
  - `https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.aoneci`
- **Release**: standard Terraform-registry publishing via **GoReleaser**
  (`.goreleaser.yml`: multi-OS/arch builds, `-trimpath`, ldflags inject
  `main.version`/`main.commit`) plus `release.yml`. An `alpha` Makefile target
  also pushes alpha builds to an internal OSS bucket
  (`oss://iac-service-terraform/...`).
  - `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/.goreleaser.yml`
- **Quality scripts**: `scripts/` holds consistency/document/example/import/
  field checks, a breaking-change checker, and a minimal-test-set calculator —
  the substitute for generator-enforced invariants.
  - `https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/scripts`

---

## Concrete examples (anchors)

1. **Generated resource header/structure** — `resource_alicloud_milvus_instance.go`
   (marker on line 1; new gateway style with `jsonpath` + `connectivity`):
   `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_milvus_instance.go`
2. **go.mod SDK dependency mix** (Plugin SDK v1, darabonba-openapi/v2,
   alibaba-cloud-sdk-go, OSS v2, credentials-go):
   `https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/go.mod`
3. **Hand-written provider core** — `provider.go` (`func Provider()
   terraform.ResourceProvider`, static `ResourcesMap`) and `connectivity/client.go`
   (client wiring): see links in §3/§4.

---

## Summary

The Alibaba Terraform provider is a **single hand-maintained Go module on
Terraform Plugin SDK v1** (no v2, no Plugin Framework, MPL-2.0). It is **partly
generated**: an *external* (internal Alibaba) scaffolding tool seeds resource,
data-source, and `service_*_v2` files — ~508 resource + ~65 data-source files at
HEAD still carry the `// ... generated automatically ...` marker — but the repo's
own workflow strips that marker on first human edit, so generated Go is a
**starting seed, not a round-tripped artifact** (unlike Google Magic Modules).
The provider core (provider schema, `connectivity/` HTTP client, auth via
`credentials-go`, helpers) is always hand-written. It sits on a **mix of Go SDK
families**: the Darabonba-generated `alibabacloud-go/*` + `darabonba-openapi/v2`
runtime (the modern path, often called directly with raw maps + jsonpath), the
legacy monolithic `alibaba-cloud-sdk-go`, and bespoke hand-written service SDKs
(OSS, Log/SLS, OTS, MNS, FC). CI is Alibaba-internal (Aone) mirrored to GitHub
Actions; release is GoReleaser to the Terraform registry.

## Gaps (`?? verify`)
1. The **external generator's source/identity** is not in-repo. The marker proves
   it exists; the tool itself (and whether it reads the same OpenAPI-meta feed as
   Darabonba, or `next.api.aliyun.com`) is unconfirmed. → DO_NEXT.
2. Exact **count of generated-then-edited** files (marker removed) vs
   classic-hand-written cannot be derived from the marker alone; only the
   still-pristine count (508/65) is measurable here.
3. Whether any **data-source/service files are continuously regenerated** vs
   one-shot — evidence (the "remove marker on edit" rule) points to one-shot, but
   the generator's re-run policy is unconfirmed.

---

## Links

- Repo (pinned): https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/
- LICENSE (MPL-2.0): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/LICENSE
- go.mod: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/go.mod
- main.go: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/main.go
- alicloud/provider.go: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/provider.go
- connectivity/client.go: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/connectivity/client.go
- connectivity/config.go: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/connectivity/config.go
- Generated resource (Milvus): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_milvus_instance.go
- Generated service (DMS v2): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/service_alicloud_dms_v2.go
- Classic hand-written resource (ECS instance): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_instance.go
- New-style resource (VPC): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/alicloud/resource_alicloud_vpc.go
- count_generated_resources.sh: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/scripts/count_generated_resources.sh
- provider-add-attribute skill (the "remove marker on edit" rule): https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/.opencode/skills/provider-add-attribute/SKILL.md
- .opencode/skills (operator playbooks): https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.opencode/skills
- GNUmakefile: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/GNUmakefile
- .goreleaser.yml: https://github.com/aliyun/terraform-provider-alicloud/blob/69f22ea780e942e0b728942a14f94ac78a8343bb/.goreleaser.yml
- .github/workflows: https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.github/workflows
- .aoneci (internal Aone CI mirror): https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/.aoneci
- scripts/: https://github.com/aliyun/terraform-provider-alicloud/tree/69f22ea780e942e0b728942a14f94ac78a8343bb/scripts
