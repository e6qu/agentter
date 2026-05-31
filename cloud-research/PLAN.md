# Research plan: How cloud providers generate SDKs at scale

## Goal

Produce `CODE_GENERATION.md`: a precise, source-cited comparison of how
AWS, GCP, Azure, OCI, and Alibaba Cloud generate multi-language SDKs.

## Methodology

For each provider, answer the same questionnaire so the final document
can be a true side-by-side comparison.

### Per-provider questionnaire

1. **Service description / IDL**
   - What format describes APIs? (OpenAPI 2/3, Smithy, Protobuf, TypeSpec,
     Discovery Document, Darabonba TeaDSL, custom JSON, etc.)
   - Where do the spec files live? (single monorepo? per-service?)
   - Are specs human-authored or generated from an internal source-of-truth?
   - Is the spec format public and consumable by third parties?

2. **Generator tool(s)**
   - What program(s) read the spec and emit code?
   - Language(s) the generator is written in
   - Single generator with language plugins, or one generator per target language?
   - Open source? License? Repo links.

3. **Pipeline / orchestration**
   - How is generation triggered? (commit hook? CI? manual? scheduled?)
   - Build tooling: Gradle, Bazel, Make, Bash, GitHub Actions, etc.
   - How are generated outputs reviewed / merged?
   - Is the SDK repo monorepo (all services in one) or polyrepo (per-service)?

4. **Per-language customization mechanisms**
   - Template engines used (Mustache, Jinja, Velocity, Handlebars, etc.)
   - "Customization" / "directive" / "trait" systems for overriding defaults
   - Where in the repo do hand-written shims live alongside generated code?
   - Conventional file/dir patterns that distinguish generated from manual

5. **Manual vs generated, by surface area**
   - Pick a sample service per provider and identify which files are
     generated vs hand-authored. (Authentication / pagination / retry
     middleware is the most likely manual part everywhere.)

6. **Release & versioning**
   - Per-service or per-monorepo versioning?
   - How are breaking spec changes surfaced to SDK consumers?

### Initial provider hypothesis (to be verified, not asserted)

These are starting points for research, **not** facts to state:

- **AWS**: Smithy IDL (`smithy-lang/smithy`), per-language generators
  (`smithy-rs`, `aws-sdk-js-v3` codegen via `smithy-typescript`,
  `aws-sdk-go-v2`, etc.). Migration from older JSON service models is
  largely complete.
- **GCP**: Mostly Protocol Buffers in `googleapis/googleapis`, with
  per-language GAPIC generators (`gapic-generator-python`,
  `gapic-generator-java`, `gapic-generator-go`, etc.). Legacy
  Discovery-Document SDKs (`google-api-python-client`,
  `google-api-go-client`) coexist.
- **Azure**: Historically OpenAPI 2.0 in `Azure/azure-rest-api-specs`,
  consumed by AutoRest with per-language plugins. Moving to TypeSpec
  (`microsoft/typespec`) as the primary authoring format.
- **Oracle (OCI)**: Less publicly documented. Some kind of spec, with
  parallel SDKs `oci-python-sdk`, `oci-go-sdk`, `oci-java-sdk`, etc.
  Need to investigate from the source repos.
- **Alibaba Cloud**: Darabonba / TeaDSL as IDL, with `darabonba-*`
  generators per language. Repos under `aliyun/` and
  `alibabacloud-sdk/`.

Verify each of these before writing them into `CODE_GENERATION.md`.

## Phases

### Phase 0 — Setup (this commit)

- Create directory layout
- Continuity docs
- Initial PLAN.md
- Get scope confirmation from user

### Phase 1 — Reconnaissance, per cloud (parallelizable)

For each cloud, in its directory, produce `notes.md` covering the
questionnaire above with source citations. Delegate to research
subagents — one per cloud — since the work is independent and
breadth-heavy.

Output of each sub-investigation should include:
- A `notes.md` (narrative) with permalinks
- A `links.md` (flat list of every repo / file / doc URL referenced) so
  later cross-checking is cheap
- Optionally a `samples/` directory if interesting snippets were copied

### Phase 2 — Cross-checking & filling gaps

Read all five `notes.md` files. Identify:
- Inconsistencies in the questionnaire answers (one cloud well-covered,
  another shallow)
- Claims that need a second-pass verification
- A common "case study" — does an API across all 5 clouds let us show
  the same workflow side-by-side? (Probably object storage: S3,
  Cloud Storage, Blob Storage, OCI Object Storage, OSS.)

### Phase 3 — Synthesis

Write `CODE_GENERATION.md`:
- Executive summary table (one row per provider, columns: IDL, generator,
  pipeline, customization mechanism, monorepo vs polyrepo)
- One section per provider with depth
- Side-by-side comparison sections on:
  - Authoring model (write spec → generate)
  - Customization mechanism
  - Trust boundary between generated and hand-written code
  - Open-source posture (can a third party reuse the generator?)
- Concluding observations

### Phase 4 — Polish

- Verify every URL still resolves
- Check every cited line number is on a commit-pinned permalink
- Final read-through

## Scope (confirmed 2026-05-30)

- **Languages**: Python, Go, Java, TypeScript — the common subset across
  all five providers. Other languages (Rust, C#, Ruby, PHP, Kotlin, C++)
  may be mentioned in passing where they illustrate a unique design
  choice, but are not part of the core matrix.
- **Case study services** — three, compared across all 5 clouds:
  1. **Object storage**: S3 / Cloud Storage / Blob Storage / OCI Object
     Storage / Alibaba OSS
  2. **Messaging (SNS/SQS-equivalents)**: SNS+SQS / Pub/Sub /
     Service Bus / OCI Notifications+Queue / Alibaba MNS (and/or RocketMQ)
  3. **Functions / FaaS**: Lambda / Cloud Functions / Azure Functions /
     OCI Functions / Alibaba Function Compute
- **Run generators**: yes, for the case-study services. At minimum we
  attempt to invoke each provider's generator against one of the three
  case-study specs in one of the four target languages, to confirm
  pipeline behavior. Document failures in `WHAT_WE_DID.md`.
- **Depth**: Architectural + concrete examples. For each provider's
  customization mechanism, cite 2–3 real examples by permalink.
  No line-by-line template walkthroughs (out of scope).

## Concrete deliverables per case-study cell

For each (provider × service × language) cell, we want to know:
- Where the API spec lives (file, repo, commit)
- Which generator (and which invocation) produces the SDK module
- Pointer to the generated output file(s) in the published SDK repo
- Pointer to any hand-written customization for that service
- For at least one cell per provider: a local generator run we
  executed, and the captured output (in `<provider>/runs/`).

## Tools we'll use

- `gh` CLI for GitHub navigation / file fetching
- `WebFetch` / `WebSearch` for docs
- Research subagents (`Explore`, `general-purpose`) for parallel breadth
- Local Python venv (via `uv`) if we end up parsing specs / counting
  generated lines / clustering customization directives

---

# Execution plan v2 — local generator runs + cross-language verification

> Added 2026-05-30. Phases 0–1 of the original plan are DONE; the Phase-3
> synthesis (`CODE_GENERATION.md`) is drafted. This v2 plan reorganizes the
> *remaining* work into explicit, resumable phases. Two new goals were added by
> the user:
> 1. **Run every cloud's codegen locally** (all five; OCI is impossible by
>    construction and is handled as a documented non-run).
> 2. Expand the deliverable to cover **cross-language / multi-language
>    verification & spec support** — i.e. how each provider proves that one spec
>    yields *consistent behavior across languages* (protocol test suites,
>    conformance servers, recorded scenarios, generated test cases).

## Local toolchain inventory (verified 2026-05-30)

| Tool | Version | Used for |
|---|---|---|
| Java (Temurin) | 25.0.3 | AWS Smithy codegen, Azure java emitter (if needed) |
| Node / npm | 26.0.0 / 11.12.1 | Azure AutoRest + TypeSpec, Alibaba Darabonba |
| Python | 3.14.5 | GCP gapic-generator-python |
| uv | 0.11.14 | Python env mgmt (pin 3.12/3.13 for wheel compat if 3.14 fails) |
| Go | 1.26.3 | optional Go targets (gapic-generator-go, smithy-go) |
| git, gh | present | clone spec/proto repos shallowly |
| **protoc** | **absent** | get via `grpcio-tools` (`python -m grpc_tools.protoc`) — no system install |
| **gradle** | **absent** | use repo `./gradlew` wrappers, or the standalone **Smithy CLI** |

Rule (from CLAUDE.md): **no silent fallbacks.** If a run is blocked, capture the
exact failing command + error in `<provider>/runs/<...>/` and in
`WHAT_WE_DID.md`; do not substitute a fake/trivial success without labeling it.

## Output convention for every run

```
<provider>/runs/<service>-<language>/
├── README.md        # what was run, exact commands, toolchain versions, outcome
├── cmd.sh           # the reproducible invocation(s)
├── input/           # the spec/proto/model the run consumed (or a pin to it)
└── output/          # generated code (or the captured failure log)
```

Each run's README states: input spec (repo@sha + path), generator + version,
invocation, result (SUCCESS / PARTIAL / BLOCKED), and a 1-line takeaway for the
deliverable.

---

## Phase R — Local generator runs (the new core work)

Ordered lightest-first so early wins de-risk the toolchain. Each is independent;
they can be parallelized across sessions. **Case-study service in parens.**

### R1. GCP — `gapic-generator-python` → Python  (Cloud Functions v2)  [tractable]
- Toolchain: `uv venv` (try 3.14; fall back to 3.13/3.12 for wheels) →
  `uv pip install gapic-generator grpcio-tools googleapis-common-protos`.
- Input: shallow-clone `googleapis/googleapis` for
  `google/cloud/functions/v2/functions.proto` + `google/api/*` common protos.
- Invoke: `python -m grpc_tools.protoc -I googleapis
  --plugin=protoc-gen-python_gapic=$(which protoc-gen-python_gapic)
  --python_gapic_out=output google/cloud/functions/v2/functions.proto`
  (with `service-yaml`/`grpc-service-config` opts if needed).
- Target: Python (the easiest GAPIC engine). Stretch: also `gapic-generator-go`.
- Risk: Python 3.14 wheels for the generator may lag → pin older Python.

### R2. Alibaba — `@darabonba/cli` → Python + Go  (Function Compute / a small module)  [tractable]
- Toolchain: `npm install @darabonba/cli @darabonba/python-generator
  @darabonba/go-generator` (local, not -g).
- Input: a `.tea`/`.dara` module. Prefer a *small* real one (e.g. a trimmed
  `darabonba-openapi` `main.tea`, or a minimal hand-written Darabonba module that
  `extends OpenApi`). FC's full `main.tea` may be large; start minimal to prove
  the dispatch, then try the real FC module.
- Invoke: `npx dara codegen --lang py --pkg-dir output ... main.tea` (and
  `--lang go`).
- Target: Python and Go (shows one DSL → two languages = the cross-language story
  in miniature).
- Risk: Darabonba module may need `dara install` of dependency modules (Util,
  OpenApi) from the Darabonba registry.

### R3. Azure — AutoRest → Python  AND  TypeSpec emitter → TypeScript  (a small data-plane spec)  [moderate]
- Captures Azure's **dual stack** deliberately:
  - **Legacy path:** `npm install -g autorest`; `autorest --python
    --input-file=<swagger.json> --output-folder=output-autorest`. Input: a small
    Swagger 2.0 (e.g. a trimmed Tables/Blob data-plane spec from
    `azure-rest-api-specs`).
  - **New path:** `npm install @typespec/compiler @azure-tools/typespec-ts
    @azure-tools/typespec-client-generator-core`; `tsp compile <main.tsp>
    --emit @azure-tools/typespec-ts`. Input: a minimal `.tsp` (or a real small
    service `.tsp` from the specs repo).
- Target: Python (AutoRest) + TypeScript (TypeSpec).
- Risk: AutoRest self-downloads its core at runtime (network); TypeSpec emitter
  versions must be mutually compatible.

### R4. AWS — Smithy codegen → TypeScript (and/or Go)  (SQS or Lambda)  [heaviest]
- Toolchain: Smithy CLI (install standalone, JDK 25 present) + a `smithy-build.json`.
- Input: the Smithy 2.0 JSON AST model from `aws/api-models-aws` (e.g.
  `models/sqs/service/2012-11-05/sqs-2012-11-05.json`).
- Primary invoke: `smithy build` with plugin `typescript-client-codegen` and a
  Maven dependency on `software.amazon.smithy.typescript:smithy-typescript-codegen`
  (+ `software.amazon.smithy:smithy-aws-traits` for AWS protocols).
- **Known risk / likely blocker:** AWS service protocols (awsJson, awsQuery,
  restXml) need the **AWS-specific codegen integrations** (`smithy-aws-*-codegen`)
  which may not be on Maven Central. Mitigation ladder, each documented:
  1. Try the real SQS model with the base codegen + smithy-aws-traits.
  2. If protocol support is missing, run the *actual SDK repo's* codegen:
     shallow-clone `aws/aws-sdk-js-v3`, `cd codegen`, `./gradlew :sdk-codegen:build`
     scoped to one service (gradlew bootstraps Gradle — no system gradle needed).
  3. If both blocked, generate from a *generic* Smithy model with `restJson1`
     (still smithy-typescript-codegen, but a non-AWS service) and LABEL it clearly
     as a pipeline demonstration, not an AWS service run.
- Target: TypeScript (stretch: smithy-go).

### R5. OCI — documented impossible run
- `OracleSDKGenerator` is closed-source and unpublished. The "run" deliverable is
  a written record in `oracle/runs/README.md`: show the absence of any public
  generator (org search + 404s for plausible repo names), quote the generation
  headers that name the internal tool, and conclude no local run is possible.
  This is the faithful outcome, not a gap to paper over.

## Phase V — Cross-language / multi-language verification & spec support

New research + synthesis dimension. For each provider, answer:
- **Shared test artifacts:** does one spec/IDL drive a *single* suite of tests
  that all language SDKs must pass? Where does it live?
- **Conformance / protocol tests:** HTTP-wire protocol compliance, serialization,
  pagination, retry — validated identically across languages.
- **Mock-service / scenario testing:** a reference server every language client
  is tested against.
- **Spec→test generation:** are test cases *generated from the spec* (like the
  SDK code itself)?

Starting leads to verify (not assert):
- **AWS:** Smithy **protocol tests** (`httpRequestTests`/`httpResponseTests`
  traits in the model) — the canonical "one spec, all languages" compliance
  suite; each SDK's codegen emits protocol-test runners. Find the trait defs in
  `smithy-lang/smithy` and the generated test runners in the SDK repos.
- **GCP:** `gapic-showcase` (a conformance/showcase gRPC+REST server every GAPIC
  client is tested against) + generator **baseline/golden** tests; product-level
  conformance suites (e.g. Storage `conformance-tests`).
- **Azure:** **`cadl-ranch` / `@azure-tools/azure-http-specs`** (spec-driven mock
  scenarios every language emitter must pass) + the **test-proxy** record/replay
  framework shared across language SDKs.
- **OCI:** likely internal only; document what little is public.
- **Alibaba:** Darabonba can **generate test cases** from `.tea` (the DSL targets
  "SDK, Code Sample, Test Case"); Tea runtime test suites. Verify the test-gen
  path.

Delegate the breadth to per-provider research subagents (as in Phase 1), then
verify key claims against source before writing them up.

## Phase S — Synthesis update + polish

1. Fold Phase-R run results into `CODE_GENERATION.md` (replace the "no local run
   executed yet" note; add per-cell run pointers into `<provider>/runs/`).
2. Add a new top-level section to `CODE_GENERATION.md`:
   **"Cross-language verification & spec support"** — a comparison table
   (shared test suite? conformance server? spec→test generation? record/replay?)
   plus prose per provider, from Phase V.
3. Re-run the citation-verification pass (all URLs 200, all SHA-pinned) including
   the new citations.
4. Final read-through.

## Phase sequencing note (for resuming)

R1→R5 and V are independent and can interleave. Suggested order: R1 (GCP) and R2
(Alibaba) first (lightest, build confidence), then R3 (Azure dual-stack), then R4
(AWS, allow for the protocol-trait blocker), R5 (OCI doc) anytime. Phase V can run
in parallel via subagents while local runs proceed. Phase S is last.

---

# Execution plan v3 — Infrastructure-as-Code codegen layer

> Added 2026-05-30. User extended scope to the IaC layer: compare how **CDKs
> (AWS CDK, CDKTF, cdk8s), Pulumi, Bicep, Terraform itself, and the per-cloud
> Terraform providers** generate their multi-language bindings / type systems /
> provider code. Decisions: **companion deliverable `IAC_CODEGEN.md`** (cross-
> linked from `CODE_GENERATION.md`), and **include local reproductions**.

## The connecting insight (the generation chain)

These tools sit one layer above the API-client SDKs and form a chain:

```
API spec (OpenAPI/Smithy/proto/CloudFormation)
   → API-client SDK            (generated — the CODE_GENERATION.md story)
   → Terraform provider        (hand-written OR generated from the API/CFN spec)
   → provider schema (gRPC)    (machine-readable resource/attribute model)
   → CDKTF / Pulumi bindings   (generated per-language from that schema)
```

Comparison axes mirror the SDK ones: **source model → generator → multi-language
strategy → relationship to the underlying API specs.** The key strategic split:
- **jsii** (AWS CDK / CDKTF / cdk8s): author once in TypeScript, *transpile* to
  Python/Java/.NET/Go. One source language, N targets by cross-compilation.
- **Pulumi**: *generate* a separate idiomatic SDK per language from a JSON
  **Package Schema**. N targets by per-language codegen (like the cloud SDKs).
- **Bicep**: a single DSL transpiled to ARM JSON; its *type system* is generated
  from Azure specs, but it is not multi-language.
- **Terraform providers**: a spectrum from hand-written to fully generated.

## Tools / topics (one research file each under `iac/`)

1. `iac/cdk-jsii.md` — **jsii** + **AWS CDK** (L1 `Cfn*` from the CloudFormation
   Resource Specification; `aws-cdk-lib` authored in TS; jsii + jsii-pacmak emit
   Python/Java/.NET/Go) + **CDKTF** (constructs from Terraform provider schemas)
   + **cdk8s** (from k8s/CRD OpenAPI). How jsii's type model + `.jsii` assembly work.
2. `iac/pulumi.md` — **Pulumi Package Schema**, `pkg/codegen` per-language
   generators, `pulumi package gen-sdk`, and **pulumi-terraform-bridge** (emits a
   schema from a Terraform provider). Per-language SDK output.
3. `iac/bicep.md` — **Bicep** DSL → ARM JSON; **`Azure/bicep-types`** +
   **`Azure/bicep-types-az`** type generation from `azure-rest-api-specs`
   (Swagger/TypeSpec). Relationship to ARM + to `azapi`.
4. `iac/terraform-core.md` — Terraform's **provider plugin protocol** (gRPC,
   `terraform-plugin-go`/`tfplugin*.proto`), **Plugin SDK v2** vs **Plugin
   Framework**, provider **schema**, and the spec-based **`terraform-plugin-codegen`**
   tools (`tfplugingen-openapi`, `tfplugingen-framework`, the provider-code-spec).
5. `iac/terraform-aws.md` — **`terraform-provider-aws`** (hand-written + the
   `internal/generate` codegen; AWS SDK for Go v2 underneath) AND
   **`terraform-provider-awscc`** (fully generated from the CloudFormation/Cloud
   Control schema).
6. `iac/terraform-google.md` — **Magic Modules** (`GoogleCloudPlatform/magic-modules`,
   MMv1 YAML resource defs → `terraform-provider-google` + `-google-beta`, and
   other downstreams). The most thoroughly generated provider.
7. `iac/terraform-azure.md` — **`terraform-provider-azurerm`** (mostly hand-written
   over **`hashicorp/go-azure-sdk`**, which is generated by **`pandora`** from
   swagger) AND **`terraform-provider-azapi`** (schema-driven from Azure types).

Each file: commit-pinned permalinks, 2–3 concrete examples, `?? verify` for gaps,
plus a links section. Delegate to background research subagents (one per file).

## Phase IaC-Runs — local reproductions (tractability order)

Capture under `iac/runs/<tool>/` (same README/cmd.sh/input/output convention).
- **jsii** — author a tiny TS construct, `jsii` compile → `.jsii` assembly, then
  `jsii-pacmak` → Python (+ another target). Node toolchain. [tractable]
- **Terraform schema** — `terraform providers schema -json` against a small
  provider to dump the machine-readable schema that CDKTF/Pulumi consume. [tractable]
- **CDKTF** — `cdktf get` to generate constructs (jsii) from a provider schema. [moderate]
- **Pulumi** — `pulumi package gen-sdk` from a small Package Schema → per-language
  SDK; or generate from a bridged provider. [moderate]
- **Bicep** — `bicep build main.bicep` → ARM JSON (DSL transpile); stretch: run the
  `bicep-types-az` generator on a small swagger to show type generation. [tractable/heavy]
- **terraform-plugin-codegen** — `tfplugingen-openapi generate` + `tfplugingen-framework`
  to generate provider schema/code from an OpenAPI spec. [moderate]
- **Magic Modules** — run MMv1 on one resource YAML → Terraform provider Go
  (Ruby/Go toolchain). [heavy — attempt; document if blocked]
- **pandora** — Azure go-azure-sdk generation is a large pipeline; likely
  document rather than run. [heavy/document]

## Phase IaC-S — synthesis

Write `IAC_CODEGEN.md`: exec-summary matrix (tool | source model | generator |
multi-language strategy | relationship to API spec | OSS), per-tool sections,
the "generation chain" cross-layer analysis tying back to `CODE_GENERATION.md`,
a reproductions section, and concluding observations. Add a bridging paragraph +
link in `CODE_GENERATION.md`. Re-verify all URLs (SHA-pinned, 200).

---

# Execution plan v4 — per-SDK "how it's built" docs

> Added 2026-05-30. User asked for (1) a doc specific to **boto** comparing it
> with the official next-gen generated AWS Python SDK, and (2) per-SDK build
> docs for famous/most-used SDKs "like boto" — cloud + non-cloud.

Output: a `sdks/` directory, one doc per SDK + an index with a cross-SDK
"build model" matrix. Cross-linked from root `README.md` and `CODE_GENERATION.md`.

## Build-model taxonomy (the comparison axis)
- **Data-driven / runtime-interpreted** — JSON models loaded at runtime, client
  classes built dynamically (boto3/botocore; google-api-python-client).
- **Codegen from a type-system IDL** — Smithy/Protobuf → emitted source
  (aws-sdk-go-v2/js-v3, aws-sdk-python v3).
- **Codegen from OpenAPI** — OpenAPI spec → OpenAPI-Generator-style emit
  (Stripe, Twilio, GitHub Octokit types, Kubernetes non-Go clients).
- **Codegen from hand-written Go types via gengo** — Kubernetes `client-gen`.
- **Bespoke generator from C2J + JavaPoet** — aws-sdk-java-v2.

## Docs
- `sdks/README.md` — index + cross-SDK matrix.
- `sdks/boto3.md` — **the boto doc**: data-driven build model + comparison with
  the generated `aws-sdk-python v3` / `smithy-python`.
- `sdks/aws-sdk-python-v3.md` — the Smithy-generated next-gen Python SDK (profile).
- `sdks/aws-sdk-js-v3.md`, `sdks/aws-sdk-go-v2.md`, `sdks/aws-sdk-java-v2.md` —
  AWS flagship profiles (cross-link the AWS section of CODE_GENERATION.md).
- `sdks/stripe.md` — stripe-* SDKs generated from Stripe's OpenAPI (`stripe/openapi`).
- `sdks/twilio.md` — twilio-* generated from `twilio/twilio-oai` via `twilio-oai-generator`.
- `sdks/github-octokit.md` — Octokit generated from `github/rest-api-description`
  (`@octokit/openapi` → `@octokit/types`); hand-written core.
- `sdks/kubernetes-client-go.md` — `client-gen`/`k8s.io/code-generator` (gengo)
  for Go; OpenAPI-Generator for other languages.
- `sdks/google-apis-client.md` — the Discovery-document family
  (`google-api-python-client` [runtime-dynamic, boto-like], `google-api-go-client`
  via `google-api-go-generator`, `googleapis` node).

## Method
Research subagents for the non-cloud + v3 SDKs (Stripe, Twilio, Octokit,
Kubernetes, Google APIs, aws-sdk-python v3). AWS Smithy profiles written from
existing `aws/notes.md` + `aws/verification.md`. All commit-pinned; verify URLs.

---

# Execution plan v5 — major Terraform provider docs

> Added 2026-05-30. User asked for docs for the major Terraform providers,
> mirroring the per-SDK profiles in `sdks/`. Output: a `terraform-providers/`
> directory, one profile per provider + index/matrix, cross-linked from
> `IAC_CODEGEN.md` and root `README.md`.

To match the project's five-cloud scope:
- `terraform-providers/aws.md` — `terraform-provider-aws` (hand-written + scaffolding
  gen) + `terraform-provider-awscc` (fully generated from CloudFormation). Synthesize
  from `iac/terraform-aws.md`.
- `terraform-providers/google.md` — Magic Modules → `terraform-provider-google(-beta)`.
  From `iac/terraform-google.md`.
- `terraform-providers/azure.md` — `azurerm` (hand-written over pandora-generated
  `go-azure-sdk`) + `azapi`. From `iac/terraform-azure.md`.
- `terraform-providers/oci.md` — `oracle/terraform-provider-oci` (NEW research).
- `terraform-providers/alibaba.md` — `aliyun/terraform-provider-alicloud` (NEW research).
- `terraform-providers/README.md` — index + the hand-written↔generated matrix.

The first three reuse existing IaC research; OCI + Alibaba need new subagents.
Non-cloud majors (Kubernetes, Helm, Cloudflare, Datadog) are a possible later
extension — offer, don't assume.

---

# Execution plan v6 — history of cloud APIs & IaC/config-mgmt tools

> Added 2026-05-30. User asked for a `history/` directory, one doc per software
> "family" (Terraform, Ansible, Chef, Puppet, SaltStack, CloudFormation/CDK,
> Pulumi, + a cloud-APIs origins overview), covering the history of cloud APIs
> and their integration into these tools — INCLUDING controversies, spats,
> partnerships, shenanigans, rumors/gossip.

## HARD constraint: strictly factual, fully sourced
- Chronological structure (dated timeline).
- EVERY claim — especially every controversy/rumor — must carry a real URL
  (official blog/announcement, primary docs, reputable press, GitHub issue/PR/commit,
  SEC filing, HN/mailing-list thread). Attribute gossip to its source
  ("X reported…", "in a HN thread…") and separate established fact from reported
  claim/opinion.
- DO NOT fabricate or assume. If a claimed event can't be verified (e.g. the
  user's "HashiCorp threatening to deprecate the AWS provider"), state
  "could not verify" explicitly rather than asserting it.

## Docs (one per family) + index
- `history/terraform.md` — HashiCorp/Terraform/OpenTofu (BSL relicense, OpenTofu
  fork, C&D, IBM acquisition; verify the AWS-provider-deprecation claim).
- `history/ansible.md`, `history/chef.md` (ICE/Seth Vargo), `history/puppet.md`
  (Perforce → source-available controversy), `history/saltstack.md` (CVE mass-
  exploitation; VMware/Broadcom).
- `history/cloudformation-cdk.md` — AWS native IaC (verify "AWS promoting CFN/CDK
  vs Terraform"; note CDKTF collaboration).
- `history/pulumi.md`.
- `history/cloud-apis.md` — origins overview (S3/EC2 APIs 2006, boto, config-mgmt
  adding cloud, shift to declarative IaC).
- `history/README.md` — cross-family chronological timeline + index (I write).

Delegate to web-enabled research subagents (one per family); strict sourcing.

---

# Execution plan v7 — additional config-as-code / IaC systems (user: "all these")

> Added 2026-05-31. User picked ALL systems from the menu. Each gets a
> chronological, fully-sourced `history/<name>.md` (timeline + people + company/
> licensing + controversies), same strict-sourcing rules. Natural pairs combined.

Docs to produce:
1. cfengine.md            — CFEngine (Mark Burgess, 1993, promise theory)
2. vagrant-packer.md      — HashiCorp Vagrant + Packer
3. helm.md                — Helm (Deis→Microsoft, CNCF; Tiller controversy)
4. kustomize.md           — Kustomize (Google, kubectl -k)
5. argocd-flux.md         — Argo CD + Flux (GitOps; Weaveworks shutdown)
6. crossplane.md          — Crossplane (Upbound, CNCF)
7. jsonnet-tanka.md       — Jsonnet (Google) + Tanka (Grafana)
8. nix.md                 — Nix/NixOS (Dolstra; 2024 governance drama)
9. winglang-system-initiative.md — Wing + System Initiative (next-gen)
10. serverless-iac.md     — Serverless Framework + SST
11. gcp-deployment-manager.md — GCP Deployment Manager + Config Connector
12. openstack-heat.md     — OpenStack Heat
13. aws-opsworks.md       — AWS OpsWorks (managed Chef/Puppet; deprecating)
14. juju.md               — Juju (Canonical)
15. bosh.md               — BOSH (Cloud Foundry)
16. spinnaker.md          — Spinnaker (Netflix/Google)

After all land: add to history/README.md index + master timeline; full URL verify;
+ finish the pending dead-link cleanup from v6.
