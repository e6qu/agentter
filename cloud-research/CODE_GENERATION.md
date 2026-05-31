# How major cloud providers generate their SDKs

A source-cited comparison of the multi-language SDK code-generation pipelines of
**AWS, Google Cloud, Microsoft Azure, Oracle Cloud Infrastructure (OCI), and
Alibaba Cloud**.

Scope: the four languages common to all five providers — **Python, Go, Java,
TypeScript** — and three case-study service families — **object storage**,
**messaging (SNS/SQS-equivalents)**, and **functions / FaaS**.

> Companion documents:
> [`IAC_CODEGEN.md`](IAC_CODEGEN.md) extends this analysis one layer up to the
> **infrastructure-as-code** tools (AWS CDK / CDKTF / cdk8s via jsii, Pulumi,
> Bicep, and the per-cloud Terraform providers); many are downstream of the *same*
> specs and SDKs described here — see its "generation chain."
> [`sdks/`](sdks/README.md) profiles individual famous SDKs (incl.
> [boto3 vs the generated AWS Python v3](sdks/boto3.md), Stripe, Twilio, Octokit,
> Kubernetes, Google Discovery) on the same build-model spectrum.

> Method and provenance. Every non-trivial claim is backed by a commit-pinned
> permalink into the provider's actual generator or SDK repository. The raw,
> per-provider research (with the full citation trails) lives in
> `aws/notes.md`, `gcp/notes.md`, `azure/notes.md`, `oracle/notes.md`,
> `alicloud/notes.md`. SHAs were pinned on 2026-05-30; where a fact could not
> be verified from public source it is marked **(unverified)** inline and
> tracked in `DO_NEXT.md`. OCI is a special case: its generator is
> closed-source, so OCI claims rest on *indirect* evidence (generation headers,
> repo structure, release cadence) and are labelled accordingly.

---

## Executive summary

| Provider | IDL / spec format | Generator(s) | Codegen engine | Customization mechanism | Generated SDK layout | Generator open source? |
|---|---|---|---|---|---|---|
| **AWS** | Smithy 2.0 JSON AST (modern); legacy C2J `service-2.json` (botocore + Java v2) | `smithy-go`, `smithy-typescript`, `smithy-rs`, `smithy-python` (modern); bespoke Java v2 + botocore runtime (legacy) — one per language | Writer/AST-based (`AbstractCodeWriter`); Java v2 uses JavaPoet. **No template engine.** | Smithy "integrations"/"customizations" registered via Java SPI + model transforms; Java v2 uses JSON `customization.config` | Monorepo per language, per-service module/package | **Yes**, Apache-2.0 |
| **GCP** | Protocol Buffers + `google/api/*` annotations in `googleapis/googleapis`; legacy Discovery Docs for `google-api-*-client` | One **GAPIC generator per language**, each a `protoc` plugin | **Different per language**: Jinja2 (Py), Nunjucks (TS), Java AST visitor, Go templates | Proto annotations (`method_signature`, `resource`, `ClientLibrarySettings`) + OwlBot copy/transform config + `owlbot.py` | Monorepo per language; pipeline mid-migration OwlBot → `librarian` | **Yes**, Apache-2.0 |
| **Azure** | OpenAPI 2.0 (Swagger) in `azure-rest-api-specs`, migrating to **TypeSpec** (`.tsp`) | **AutoRest** (deprecated, retires 2026-07-01) + per-language plugins; new **TypeSpec emitters** | TS/Node core; per-language emitter backends | AutoRest `directive:` YAML transforms; TypeSpec `client.tsp` decorators (scoped per-language) | Monorepo per language, `sdk/<service>/<pkg>/` | **Yes**, MIT |
| **OCI** | OpenAPI/Swagger 2.0, date-versioned, **internal** (not in public repos) | **`OracleSDKGenerator`** — single internal tool, all languages | Unknown (closed source) | Generated-vs-handwritten **module/dir split** is the only public seam | Monorepo per language; synchronized weekly releases | **No** — closed source |
| **Alibaba** | **Darabonba** (`.tea`/`.dara`) imperative DSL in `aliyun/alibabacloud-sdk` | `@darabonba/cli` → per-language generators (mostly JS) | DSL→AST→per-language emitter | Logic written directly in `.tea`; per-language knobs in `Teafile` | Monorepo of `.tea` sources; Java/Py/TS monorepos, **Go per-service in a separate org** | **Yes**, Apache-2.0 |

Three structural patterns separate the five:

1. **Spec lineage.** AWS and GCP author in a *type-system IDL* (Smithy, Protobuf)
   designed for codegen. Azure is mid-migration from a *documentation format*
   (OpenAPI/Swagger) to a *type-system IDL* (TypeSpec). OCI uses OpenAPI
   internally. Alibaba is the outlier: its IDL (**Darabonba**) is a real
   *imperative programming language*, so per-service behaviour can be coded in
   the spec itself rather than patched afterward.

2. **Customization seam.** Everyone separates generated from hand-written code,
   but expresses overrides differently: AWS via *compiled Java integrations*,
   GCP via *proto annotations + a copy bot*, Azure via *YAML directives or
   TypeSpec decorators*, OCI via a *directory/module split* (the only thing
   visible from outside), Alibaba via *code in the DSL + Teafile knobs*.

3. **Openness.** Four of five ship their generator as open source and usable by
   third parties; **OCI does not** — `OracleSDKGenerator` exists only as a name
   stamped into generated file headers.

---

## AWS — Smithy

### Spec / IDL

AWS models all public APIs in **Smithy** internally; two model lineages reach
public repos:

- **Smithy 2.0 JSON AST** — the modern source of truth, published wholesale in
  [`aws/api-models-aws`](https://github.com/aws/api-models-aws/blob/fd819cad3147ee122087ef83ea092bd32309c5c8/README.md),
  consumed by the modern SDKs (**aws-sdk-go-v2, aws-sdk-js-v3, smithy-rs /
  aws-sdk-rust**, and the experimental **aws-sdk-python v3**). The repo README
  states it holds "Smithy models in JSON AST form for all public AWS API
  services," and warns the files are *generated from other sources* (no PRs
  accepted). Verified the SQS model literally begins `{"smithy": "2.0", ...}`
  ([sqs model](https://github.com/aws/api-models-aws/blob/fd819cad3147ee122087ef83ea092bd32309c5c8/models/sqs/service/2012-11-05/sqs-2012-11-05.json)).
- **Legacy C2J `service-2.json`** ("Coral-to-JSON") — still used by
  **botocore/boto3 (Python)** and **aws-sdk-java-v2**. This is a different,
  older normalized format (`metadata`/`operations`/`shapes`), *not* Smithy AST;
  the Java container class is literally named
  [`C2jModels`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/C2jModels.java).

Each modern SDK also vendors its own copy of the models in-repo (e.g.
[`aws-sdk-go-v2/codegen/sdk-codegen/aws-models`](https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/sdk-codegen/aws-models)).
The on-disk models in all repos are generated from an AWS-internal source of
truth; the exact internal name and the Smithy-AST↔C2J conversion direction are
**not disclosed publicly (unverified)**.

### Generator(s) and engine

One **shared Smithy core** plus **one language codegen project per language**,
all written in **Java**, all Apache-2.0:

- [`smithy-lang/smithy`](https://github.com/smithy-lang/smithy/tree/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-codegen-core/src/main/java/software/amazon/smithy/codegen/core) — IDL, model loader, traits, and `smithy-codegen-core` (`SymbolProvider`, `SymbolWriter`, `DirectedCodegen`).
- [`smithy-lang/smithy-typescript`](https://github.com/smithy-lang/smithy-typescript/tree/ee5462855d3644663dd31fecfa308d3d4d6d6afb/smithy-typescript-codegen/src/main/java/software/amazon/smithy/typescript/codegen) (`TypeScriptWriter`), [`aws/smithy-go`](https://github.com/aws/smithy-go/tree/6857390fd160b416d0e369dc9dc5c2b3736178fc/codegen/smithy-go-codegen/src/main/java/software/amazon/smithy/go/codegen) (`GoWriter`), [`smithy-lang/smithy-rs`](https://github.com/smithy-lang/smithy-rs/tree/adfb210311670392727bccb54a54fcbf046eb23a) (Kotlin codegen), and the experimental [`smithy-lang/smithy-python`](https://github.com/smithy-lang/smithy-python/blob/d0e3206841482c980f71260c32c6ce68eb2d2346/README.md) ("should not be used in production yet").

A defining trait: the Smithy generators are **writer/AST-based, not
template-based** — code is emitted imperatively via `AbstractCodeWriter`
subclasses driven by `DirectedCodegen`. There is no Mustache/Velocity layer.
The legacy [aws-sdk-java-v2 codegen](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/poet)
is also programmatic but uses **JavaPoet** builders. botocore is different
again: it *interprets* the `service-2.json` models at runtime rather than
emitting per-service classes (so boto3 is a generic runtime over shared JSON
models, not a static codegen pipeline — worth re-confirming by reading client
construction, **partially unverified**).

There is **no single binary** that emits all four languages; each language has
its own codegen project that shares only the Smithy core library and trait
model.

### Pipeline

Build tooling is **Gradle + the Smithy Gradle plugin** in every modern SDK
repo, each carrying a self-contained `codegen/` Gradle project (e.g.
[aws-sdk-go-v2/codegen](https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen)).
Generation is driven from a [Makefile](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/Makefile)
(`make generate`, single-service `SMITHY_GO_BUILD_API=... make generate-dev`),
with the codegen commit pinned in
[`SMITHY_GO_CODEGEN_VERSION`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/SMITHY_GO_CODEGEN_VERSION).
Generated `.go`/`.ts`/`.java` files are committed to the SDK repo and reviewed
as normal PRs; AWS ships daily SDK/CLI releases off the model updates. The
internal CI that runs generation and opens release PRs is **not public
(unverified)**. Published SDKs are **monorepos** (go-v2: one Go module per
service under `service/`; js-v3: per-service npm packages under `clients/`;
java-v2: Maven modules under `services/`).

### Customization

Two mechanisms, by lineage:

- **Smithy "integrations" via Java SPI** (modern). Each AWS codegen module
  registers extension classes in `META-INF/services/<Integration interface>`
  — e.g. Go's
  [GoIntegration SPI file](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/resources/META-INF/services/software.amazon.smithy.go.codegen.integration.GoIntegration).
  Integrations either apply **model transforms** (backfilling missing traits) or
  inject **runtime client plugins/middleware**. Per-service customizations live
  under
  [`customization/service/{s3,sqs,...}`](https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service).
- **JSON `customization.config`** (legacy Java v2). Per-service config declares
  `renameShapes`, `shapeModifiers`, etc. — e.g. S3's
  [customization.config](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources/customization.config)
  renames `Error`→`S3Error` and `Object`→`S3Object`. botocore's analogue is the
  `*.sdk-extras.json` overlay merged onto the base model.

Hand-written shims sit beside generated files in the same package, distinguished
by the generation header (`// Code generated by smithy-go-codegen DO NOT EDIT.`)
vs. ordinary file names (e.g.
[`handwritten_paginators.go`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service/s3/handwritten_paginators.go)).

### Case studies

- **S3.** Model `s3-2006-03-01.json`. A large, S3-specific customization set
  (`S3UpdateEndpoint`, `S3ContentSHA256Header`, `S3ErrorWith200Status`, …) lives
  in the Go [s3 customization dir](https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service/s3);
  hand-written `presign_post.go`, `express*.go`, `handwritten_paginators.go`
  round it out. Java adds hand-written `S3Utilities`, `multipart/`, `presigner/`.
- **SNS + SQS.** SQS client-side MD5 message-checksum validation is a *codegen
  customization*, not part of the wire model:
  [`SQSValidateMessageChecksum.java`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service/sqs/SQSValidateMessageChecksum.java)
  (Go) and [`AddSqsDependency.java`](https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen/smithy-aws-typescript-codegen/src/main/java/software/amazon/smithy/aws/typescript/codegen/AddSqsDependency.java)
  (TS). Otherwise SNS/SQS are almost entirely generated.
- **Lambda.** [`LambdaRecursionDetection.java`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/LambdaRecursionDetection.java)
  adds middleware propagating the X-Ray trace ID to avoid recursive-invocation
  loops. Otherwise a straightforward generated client.

### Release & versioning

Per-service independent versioning in go-v2 (each `service/<svc>` has its own
`go.mod`/`CHANGELOG.md`); per-package npm versions in js-v3; BOM-coordinated
Maven in java-v2; a single package version for botocore. Breaking spec changes
are rare by policy (additive modeling) and surface through the affected module's
changelog.

---

## Google Cloud — Protobuf + GAPIC

### Spec / IDL

The primary IDL is **Protocol Buffers in
[`googleapis/googleapis`](https://github.com/googleapis/googleapis/tree/0054cdcbd8ea44298f329d916d8173dd736fbaaa)**,
one API per `google/<area>/<version>/`, decorated with annotation protos under
`google/api/` (`client.proto`, `field_behavior.proto`, `resource.proto`,
`http.proto`). Each API also ships a **service config YAML** (`type:
google.api.Service`) and a **gRPC service config JSON** (retry/timeout
defaults). These are human-authored and public (Apache-2.0).

A separate, older track exists: the `google-api-*-client` libraries are
generated from **Discovery Documents** (JSON), managed via
`googleapis/discovery-artifact-manager` — not from these protos.

### Generator(s) and engine

**One GAPIC generator per language**, each its own Apache-2.0 repo, each a
`protoc` plugin written *in its target language*, and — notably — each using a
**different codegen engine**:

| Language | Repo | Engine |
|---|---|---|
| Python | `googleapis/gapic-generator-python` | **Jinja2** (115 `.j2` templates) |
| TypeScript | `googleapis/gapic-generator-typescript` | **Nunjucks** (86 `.njk`) |
| Java | `googleapis/gapic-generator-java` (in `sdk-platform-java`) | **AST/visitor** (`JavaWriterVisitor`), *not* templates |
| Go | `googleapis/gapic-generator-go` | Go-native `protoc` plugin, `text/template` |

The spec→generator binding is declared in **Bazel `BUILD.bazel`** files in
`googleapis`: e.g. `google/pubsub/v1/BUILD.bazel` declares `java_gapic_library`,
`py_gapic_library`, `go_gapic_library`, `nodejs_gapic_library` targets, each
passing the `grpc_service_config`, `service_yaml`, and `transport = "grpc+rest"`.
Below GAPIC, standard `protoc` plugins emit the proto/gRPC stubs.

### Pipeline

`bazel build //google/<svc>:<lang>_gapic` runs the right generator over the
proto + configs; `*_gapic_assembly_pkg` targets bundle publishable artifacts.
Historically the raw output was committed to a flat mirror repo
**`googleapis/googleapis-gen`** and synced into per-language repos by **OwlBot**
(a Docker post-processor keyed on `.OwlBot.yaml`) plus **synthtool**
(`owlbot.py`).

**Currency note — the pipeline is mid-migration.** OwlBot's README now reads
"⛔️ DEPRECATED … planned for shutdown," replaced by a new Go CLI
**`googleapis/librarian`** driving a **hermetic (Docker-based) build**. Evidence:
`google-cloud-python` now carries a `librarian.yaml`, and `google-cloud-java`
packages carry `.OwlBot-hermetic.yaml`. **`googleapis-gen` itself now returns 404
over the public API/git** — made private, removed, or superseded by the hermetic
build; current contents could not be verified **(unverified)**. The trend is
toward **per-language monorepos** (`google-cloud-python/packages/*`,
`google-cloud-go/<module>`, `google-cloud-java/java-*`,
`google-cloud-node/packages/*`); older per-API polyrepos (`java-pubsub`,
`nodejs-storage`) are archived.

### Customization

The **primary, language-agnostic knob is proto annotations**:
`google.api.method_signature` (flattened convenience overloads),
`google.api.default_host` / `oauth_scopes`, `google.api.field_behavior`,
`google.api.resource`, and — crucially — `ClientLibrarySettings` in
`client.proto`, which carries *per-language* fields (`java_settings`,
`python_settings`, `node_settings`, `go_settings`). So per-language behaviour
lives in the spec. On top of that:

- **OwlBot copy/transform config** (`.OwlBot.yaml` / `.OwlBot-hermetic.yaml`)
  with `deep-copy-regex` / `deep-remove-regex` / `deep-preserve-regex`. The
  `deep-preserve-regex` rule protects hand-edited files (e.g. `Version.java`)
  from being overwritten on regeneration.
- **`owlbot.py`** synthtool post-processors apply arbitrary per-library Python
  transforms after the copy.

The handwritten-vs-generated split is recorded in each package's
`.repo-metadata.json` `library_type`: `GAPIC_AUTO` (pure generated),
`GAPIC_MANUAL` (hand-written, no GAPIC shipped), `GAPIC_COMBO` (both).

### Case studies

- **Cloud Storage** — the handwritten exemplar. A real gRPC proto exists
  (`google/storage/v2/storage.proto`), but public clients are largely
  hand-written JSON/HTTP: **GAPIC_MANUAL** in Python/Go/Node
  (`google-cloud-storage`'s `.repo-metadata.json` → `"library_type":
  "GAPIC_MANUAL"`), **GAPIC_COMBO** in Java (hand-written `google-cloud-storage`
  + generated `gapic-google-cloud-storage-v2`).
- **Pub/Sub** — **GAPIC_COMBO** everywhere. The raw admin/data RPC stubs are
  generated; the ergonomic `Topic`/`Subscription` types, flow control, batching,
  and lease management are hand-authored (e.g. Python
  `google/cloud/pubsub_v1/publisher/` wrappers over generated `google/pubsub_v1/`).
- **Cloud Functions** — **GAPIC_AUTO**: the generated client *is* the public
  client (Python `functions_v1`/`functions_v2`, Go `apiv1`/`apiv2`, etc.), no
  hand-written wrapper. (This is the cleanest candidate for a local generator
  run.)

### Release & versioning

Per-package/per-module versioning; API surface versions are encoded in the proto
path (`v1`, `v2`, `v2beta`) and surface as parallel client packages.
**`release-please`** (Conventional Commits → SemVer bump + release PR) is the
cross-language release driver; its role is being folded into `librarian` in the
hermetic pipeline (**extent unverified**).

---

## Microsoft Azure — AutoRest → TypeSpec

### The headline: a platform mid-migration

Azure runs **two parallel codegen stacks** today. The legacy stack is
**AutoRest** consuming OpenAPI 2.0 (Swagger); the successor is **TypeSpec**
(`.tsp`) with per-language emitters. AutoRest is **deprecated and scheduled to
retire 2026-07-01** (stated in the
[`Azure/autorest` readme](https://github.com/Azure/autorest/blob/69fa4acb21d0c9275df3a09c398bb2ca2191a12c/readme.md),
tracking [issue #5175](https://github.com/Azure/autorest/issues/5175)). Many
flagship services already have TypeSpec specs *in the repo* but still **ship
AutoRest-generated code** because the per-language emitter hasn't been switched
on for them. Capturing this dual state is the single most important thing about
Azure.

### Spec / IDL

Specs live in
[`Azure/azure-rest-api-specs`](https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96)
under `specification/<service>/{resource-manager,data-plane}/`. Legacy: hand-authored
Swagger JSON under `stable/`/`preview/` + an AutoRest `readme.md`. New: TypeSpec
folders (`main.tsp`, `models.tsp`, `routes.tsp`, `client.tsp`, `tspconfig.yaml`),
from which OpenAPI is emitted unidirectionally by `@azure-tools/typespec-autorest`.
TypeSpec is **required for all new ARM (management-plane) services**; the exact
**public percentage of converted services** could not be obtained — the wiki
redirects to an auth-gated internal page **(unverified)**.

### Generator(s) and engine

- **AutoRest** ([`Azure/autorest`](https://github.com/Azure/autorest)) — a
  TypeScript core (`@autorest/core`, `@autorest/modelerfour`) plus per-language
  plugins `@autorest/{python,go,java,typescript}`, each in its own repo.
- **TypeSpec emitters** — co-located in the *same* repos as the legacy plugins:
  `@azure-tools/typespec-python` (moved into `Azure/typespec-azure/packages`),
  `@azure-tools/typespec-ts` (`Azure/autorest.typescript/packages`),
  `@azure-tools/typespec-go` (`Azure/autorest.go/packages`), `typespec-java`.
  The Azure client-generation rules and decorators live in
  [`Azure/typespec-azure/packages`](https://github.com/Azure/typespec-azure/tree/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages)
  (`typespec-autorest`, `typespec-client-generator-core`). All twelve relevant
  repos are **MIT**.

### Pipeline

`azure-rest-api-specs` drives generation via
[`specificationRepositoryConfiguration.json`](https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specificationRepositoryConfiguration.json),
which maps each target SDK repo to an integration fork (`azure-sdk/*-pr`) and a
per-language `eng/swagger_to_sdk_config.json`. A spec PR triggers automation that
opens generated PRs into the integration forks. The new TypeSpec path uses
**`tsp-client`** (`@azure-tools/typespec-client-generator-cli`); each SDK package
carries a [`tsp-location.yaml`](https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/tables/azure-data-tables/tsp-location.yaml)
pinning the spec `directory` + `commit`. One **monorepo per language**
(`azure-sdk-for-{python,go,java,js,net}`), each with a shared `eng/` engineering
system; CI runs in Azure DevOps pipelines.

### Customization

- **AutoRest directives** — YAML `directive:` blocks (`from`/`where` JSONPath +
  `transform` JS) inside the per-package `readme.md`/`autorest.md`, mutating the
  Swagger before generation. Live example in Go azblob's
  [`internal/generated/autorest.md`](https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob/internal/generated/autorest.md)
  ("Add a Properties field to the BlobPrefix definition").
- **TypeSpec `client.tsp` decorators** from `typespec-client-generator-core`,
  each scoped with a **per-language list string** so one spec drives divergent
  clients. Verified on Blob's
  [`client.tsp`](https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/client.tsp):
  `@@clientName(FilteredBlobResponse, "FilterBlobSegment", "python,csharp,javascript,go")`,
  `@@alternateType(...)`, `@client({...}, "rust,go")`.

The generated/hand-written convention is explicit: **Python** `_generated/`
subpackage + a [`_patch.py`](https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob/_generated/_patch.py)
"last resort escape hatch" (`patch_sdk()`); **Go** `internal/generated/` with a
`zz_` file prefix; **JS** `src/generated/`. Everything outside those dirs is the
hand-written convenience layer.

### Case studies

- **Azure Blob Storage** — textbook "thin generated protocol layer + large
  hand-written convenience layer." Both Swagger (`blob.json`) and TypeSpec specs
  exist in-repo, but the shipped SDKs still regenerate the protocol layer via
  AutoRest (Go pins `@autorest/go@4.0.0-preview.80`, output `zz_*.go`; JS labels
  it "Protocol Layer"); the clients, models, upload/download, encryption, SAS,
  and leasing are hand-written. (Blob's `tspconfig.yaml` has the **Java emitter
  commented out** — "uncomment when ready.")
- **Azure Service Bus** — mgmt plane is already **TypeSpec source-of-truth**, but
  the shipped `azure-mgmt-servicebus` is still **AutoRest-generated**, proven by
  its [`_metadata.json`](https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/servicebus/azure-mgmt-servicebus/_metadata.json)
  (`"use": ["@autorest/python@6.35.0", ...]`). The *data-plane* `azure-servicebus`
  is a separate hand-written **AMQP** client (not a REST/Swagger SDK).
- **Azure Functions** — the mgmt-plane SDK is part of **App Service /
  `Microsoft.Web`** (TypeSpec'd, includes `FunctionEnvelope.tsp`); essentially
  all generated. Distinct from the Functions *programming model* (host/worker
  runtime), which is not generated from specs.

### Release & versioning

Per-package independent SemVer; each package keeps a `CHANGELOG.md`; the
`azure-sdk` bot opens generated PRs and release pipelines live under `eng/`. Go
additionally tracks breaking changes during automation
(`"breakingChangeTracking": true`).

---

## Oracle Cloud Infrastructure — closed-source `OracleSDKGenerator`

> OCI's generator is **not open source**. Almost all evidence below is *indirect*
> — generation headers, version stamps, and repo structure in the *published*
> SDK repos. Inferences are labelled.

### Spec / IDL

OCI describes each service with a **date-versioned OpenAPI/Swagger 2.0 spec**;
the spec is the codegen input but is **not published** as raw files in the public
SDK repos. The TypeScript generated headers state it directly — Object Storage's
[`client.ts`](https://github.com/oracle/oci-typescript-sdk/blob/8c11d0c62800f284cc12d59cb9052518d1f9bea1/lib/objectstorage/lib/client.ts#L1-L14)
reads `* OpenAPI spec version: 20160918 ... auto generated by OracleSDKGenerator`.
The same per-service date appears identically in every language's client
(Object Storage `20160918`, Functions/ONS `20181201`, Queue `20210201`),
strongly implying one shared per-service spec drives all generators (inference).
The public form is the rendered API reference at
`docs.oracle.com/en-us/iaas/api/`; whether a downloadable raw spec is served is
**unverified** (the portal is a JS SPA). There is **no `oracle/oci-api-spec`
repo** (404) — the source of truth is internal.

### Generator and engine

A **single internal tool, `OracleSDKGenerator`**, produces every language SDK and
the CLI. It names itself in headers across Python, TypeScript, and Java
(`@jakarta.annotation.Generated(value = "OracleSDKGenerator", comments = "API
Version: 20160918")` in
[`ObjectStorageClient.java`](https://github.com/oracle/oci-java-sdk/blob/013bb11dca68f84ec10a8e48e99855dfbb3a8f13/bmc-objectstorage/bmc-objectstorage-generated/src/main/java/com/oracle/bmc/objectstorage/ObjectStorageClient.java#L15));
Go uses a terser `// Code generated. DO NOT EDIT.` marker. An org-wide code
search for `OracleSDKGenerator` returns ~1900 hits across the SDK family. **No
public artifact of the generator exists**; the engine is unknown. The
[`oci-cli`](https://github.com/oracle/oci-cli/blob/385f594d3bab0e5a17d9f97f6980b1772af6022e/services/object_storage/src/oci_cli_object_storage/generated/objectstorage_cli.py#L1-L4)
is *also* generated by the same tool (same header, same `20160918`), importing
the Python SDK as its runtime.

### Pipeline

**One monorepo per language** (Go flat per-service dirs; Python `src/oci/`; Java
multi-module Maven with the legacy `bmc-` "Bare Metal Cloud" prefix; TS `lib/`).
The Go
[Makefile](https://github.com/oracle/oci-go-sdk/blob/ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368/Makefile#L3-L4)
exposes the generation contract: `GEN_TARGETS = ... ##SPECNAME##` (a literal
codegen template placeholder) vs. `NON_GEN_TARGETS = common common/auth
objectstorage/transfer example`. **Synchronized weekly releases** carry
word-for-word-identical feature lists on the same dates across all four SDKs
(Go `65.116.0`, Python `2.176.0`, Java `3.88.0`, TS `2.133.0`, all `2026-05-26`)
— the strongest indicator of one centralized, batch-driven generation run
(inference). Internal CI specifics are **unverified** (a legacy `wercker.yml`
persists as a hint).

### Customization

OCI's customization config is internal and not visible. The only public
"customization seam" is the **module/directory split** between generated and
hand-written code, enforced by build files (the Go Makefile's `GEN_TARGETS` vs.
`NON_GEN_TARGETS`; Java's `bmc-objectstorage-generated` vs.
`bmc-objectstorage-extensions` Maven modules). Whether per-service generator
overrides exist (analogous to Smithy customizations) is **unverified**.

### Case studies

For all three services the pattern is identical: **generated** service client +
models + waiters (composite-operations), on top of a **hand-written**
`common`/`auth` core. The canonical hand-written piece is **request signing** —
HTTP Signatures draft-cavage-08, `Signature version="1"`, `rsa-sha256` — present
header-less (non-generated) in all four languages (Go
[`common/http_signer.go`](https://github.com/oracle/oci-go-sdk/blob/ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368/common/http_signer.go#L37-L38)).

- **Object Storage** (`20160918`) adds a hand-written **transfer/upload manager**
  in every SDK (Go `objectstorage/transfer/` is a `NON_GEN_TARGET`; Java isolates
  it as `bmc-objectstorage-extensions`).
- **Notifications (ONS, `20181201`) + Queue (`20210201`)** — control- and
  data-plane clients are generated; no per-service hand-written extension beyond
  the shared signing/auth core.
- **Functions (`20181201`)** — splits into a generated *management* client and a
  generated *invoke* client; same shared signing core.

### Release & versioning

Independent per-language SemVer (Go's major `65` is the Go-modules `/v65` import
path), but **whole-SDK (monorepo) versioning** — one version bump for the entire
monorepo per release, published the same week across languages.

---

## Alibaba Cloud — Darabonba

### Spec / IDL

Alibaba's modern ("V2.0") SDKs are generated by **Darabonba** (formerly
"TeaDSL"; `.tea`/`.dara`). Unlike every other provider here, **Darabonba is a
real, imperative programming language** — "a DSL for OpenAPI" used to generate
multi-language SDKs, code samples, and test cases. A service module (`main.tea`)
mixes `model` declarations with `function`/`api` blocks containing control flow,
`import`, `extends`, `init`/`super`. So per-service behaviour (endpoint logic,
request shaping, pagination) can be *written in the spec* rather than patched
afterward.

The canonical monorepo of `.tea` sources for *all* products is
[`aliyun/alibabacloud-sdk`](https://github.com/aliyun/alibabacloud-sdk/tree/49ec5c1f34021f92d616724b62b26ba01c5f665b)
(~804 `<service>-<apiversion>` dirs, each with `Teafile` + `main.tea` +
`api-info.json`). The Darabonba module is the curated layer over Alibaba's
internal per-product API metadata; the authoritative *public* machine-readable
meta feed is likely the `next.api.aliyun.com` portal (the public
[`aliyun-openapi-meta`](https://github.com/aliyun/aliyun-openapi-meta/blob/2563691c22229a0b493606e11166b95896707095/README.md)
repo's README explicitly scopes it to **aliyun-cli only**, not SDK generation) —
the exact feed is **unverified**.

### Generator(s) and engine

Entry point **`@darabonba/cli`** (Apache-2.0; `bin: { dara }`) dispatches to
per-language generators via a literal map in
[`commands/codegen.js`](https://github.com/aliyun/darabonba-cli/blob/f08154d89ab1f72f8d67aeb71043aa97423b643d/commands/codegen.js):
`cs`, `ts`, `go`, `java`, `java-async`, `php`, `py`, `cpp`, `swift`. Each
generator is its own `aliyun/` repo; **most are written in JavaScript/Node**
(they consume the `@darabonba/parser` AST), with the Python generator repo's
primary language being Python. `dara codegen --lang <go|java|py|ts>` parses
`.tea` → AST → runs the language generator, merging per-language options from the
`Teafile`. The hand-written runtime is separate: **Tea/Darabonba core**
(`tea-python` published as `darabonba-core`, `tea-java`, `tea-typescript`,
`alibabacloud-go/tea`), the **Tea OpenApi** client (`darabonba-openapi`, itself
authored in Darabonba), and `credentials-*` — all provide HTTP/retry/signing/
credential-chain and are not generated.

### Pipeline

Monorepo of sources, **mixed publishing model** by language:

- Sources: `aliyun/alibabacloud-sdk` (one dir per `<service>-<version>`).
- Java → `aliyun/alibabacloud-java-sdk` (monorepo); Python →
  [`aliyun/alibabacloud-python-sdk`](https://github.com/aliyun/alibabacloud-python-sdk/tree/9dba772458bd790bfb589a81a835d3fe6037cd49)
  (monorepo, per-service pip package); TS →
  `aliyun/alibabacloud-typescript-sdk` (monorepo).
- **Go is the structural divergence**: a *separate GitHub org*
  `alibabacloud-go`, **one repo per service-version** (e.g.
  [`alibabacloud-go/fc-20230330`](https://github.com/alibabacloud-go/fc-20230330/tree/4c395081e7f071cce90a0e37978a52926de86247/client)),
  to satisfy Go module versioning (the `/v4` major-version path).

Generated files carry `This file is auto-generated, don't edit it. Thanks.`
headers (verified in Python and Go). The CI that actually runs `dara codegen`
across ~800 services and publishes per-language is **unverified** (the Teafile
`releases` map is the source of truth for published versions; `dara
pack`/`publish` push modules to the Darabonba registry).

### Customization

Because Darabonba is an imperative DSL, **customization is primarily writing
logic directly in the `.tea` module** (contrast AWS integrations / AutoRest
directives) — e.g. FC's `getEndpoint(...)` endpoint-resolution function. Per-
language knobs live in the **`Teafile`** (`java.enableMinimizeModelName`,
`go.mapAndSliceWithoutOmitempty`, package coordinates, etc.). Newer services
route through a pluggable **Gateway SPI** (`GatewaySPI` + `GatewayPOP`), letting
one generated client support multiple backend protocols without per-service
hand-code.

### Case studies

- **OSS (Object Storage)** — the important divergence. The *control-plane* API is
  Darabonba-generated (`oss-20190517/` module), but the **data-plane object SDK
  is bespoke hand-written and predates Darabonba**: `aliyun-oss-python-sdk`
  (package `oss2`, MIT — hand-written `api.py`, `auth.py`, `crypto.py`,
  `resumable.py`, no auto-gen header) and `aliyun-oss-go-sdk` (MIT). A newer
  hand-written `*-sdk-v2` family exists too — also not Darabonba output. OSS
  keeps a dedicated family because streaming/multipart/crypto/resumable-upload
  semantics don't fit the generic POP/Darabonba model.
- **MNS / RocketMQ (messaging)** — the *control* APIs are Darabonba-generated
  (`mns-open-20220119`, `rocketmq-20220801`); the actual message produce/consume
  data-plane is separate (historically hand-written, e.g. `mns-nodejs-sdk`; Apache
  RocketMQ clients for RocketMQ). Whether current Python/Go MNS data-plane
  clients are hand-written is **unverified**.
- **Function Compute (FaaS)** — fully Darabonba-generated (`fc-20230330` module →
  `alibabacloud_fc20230330` (Py 4.7.5), `alibabacloud-go/fc-20230330/v4` (Go),
  `com.aliyun:fc20230330`, `@alicloud/fc20230330`), over the shared Tea OpenApi +
  credentials runtime. (The separate `fc-runtime-go-sdk` is the in-function
  programming model, a distinct concern.)

### Release & versioning

Package identity is `<product><apiversion>` — a new API version yields a new
package (`fc-open-20200310` vs. `fc-20230330` coexist). The Teafile carries both a
Darabonba *module* version and a `releases` map of *published* package versions
per language, which can drift across languages (FC: most languages `4.7.5`,
csharp `4.6.12`).

---

## Side-by-side comparisons

### 1. Authoring model (write spec → generate)

| | Authoring artifact | Nature |
|---|---|---|
| AWS | Smithy model (internal) → JSON AST / C2J | Declarative type-system IDL purpose-built for codegen |
| GCP | `.proto` + `google/api` annotations + service YAML | Declarative IDL (Protobuf) + annotation overlay |
| Azure | Swagger (legacy) → **TypeSpec** (`.tsp`) | Migrating from a *documentation* format to a *type-system* IDL |
| OCI | OpenAPI 2.0 (internal) | Declarative; not public |
| Alibaba | **Darabonba** `.tea` | **Imperative DSL** — behaviour coded in the spec |

The spectrum runs from purely declarative (Smithy, Protobuf, OpenAPI) to fully
imperative (Darabonba). Azure is the only provider in the middle of a *format
migration*; the others have a single stable authoring format (AWS's two lineages
are the same Smithy source rendered two ways, not a live migration).

### 2. Customization mechanism

| | Override expressed as | Where it lives |
|---|---|---|
| AWS | Compiled Java **integrations** (SPI) + model transforms; JSON `customization.config` (Java v2) | In the codegen repos |
| GCP | **Proto annotations** (incl. per-language `ClientLibrarySettings`) + OwlBot copy config + `owlbot.py` | In the spec + the language repos |
| Azure | AutoRest **`directive:` YAML** / TypeSpec **`client.tsp` decorators** (per-language scoped) | In the spec config / SDK package |
| OCI | **Directory/module split** only (generated vs. extensions) — config internal | The only public seam is repo structure |
| Alibaba | **Code in the `.tea` DSL** + `Teafile` knobs | In the spec |

A clean three-way split: AWS pushes overrides into *compiled generator
extensions*; GCP and Alibaba push them into *the spec itself* (annotations vs.
imperative code); Azure offers *declarative transforms beside the spec*; OCI
keeps it internal and exposes only a directory convention.

### 3. Trust boundary between generated and hand-written code

Everyone separates the two and protects hand-written code from regeneration, but
the boundary marker differs:

- **AWS**: `// Code generated ... DO NOT EDIT.` header vs. ordinary filenames in
  the same package (`handwritten_paginators.go`).
- **GCP**: `library_type` in `.repo-metadata.json` (`GAPIC_AUTO/MANUAL/COMBO`) +
  OwlBot `deep-preserve-regex` shielding hand-edited files.
- **Azure**: dedicated `_generated/` (Py), `internal/generated/` + `zz_` prefix
  (Go), `src/generated/` (JS) dirs; `_patch.py` escape hatch.
- **OCI**: `GEN_TARGETS` vs. `NON_GEN_TARGETS` in the build (Go); `-generated`
  vs. `-extensions` Maven modules (Java).
- **Alibaba**: separate hand-written runtime libraries (Tea/credentials), plus
  entirely separate bespoke SDKs where the model doesn't fit (OSS `oss2`).

A near-universal invariant: **auth/signing, retry, and pagination/transfer
helpers are the most likely hand-written surfaces** everywhere — OCI request
signing, Azure AMQP Service Bus, GCP Storage/Pub/Sub wrappers, AWS presigners,
Alibaba's Tea runtime + OSS.

### 4. Open-source posture (can a third party reuse the generator?)

| | Generator OSS? | License | Practical third-party reuse |
|---|---|---|---|
| AWS | Yes | Apache-2.0 | High — Smithy + models published for building custom SDKs |
| GCP | Yes | Apache-2.0 | High — GAPIC generators + `googleapis` protos public (though pipeline glue is in flux) |
| Azure | Yes | MIT | High — AutoRest/TypeSpec emitters are general-purpose tools |
| OCI | **No** | — | **None** — generator unpublished; only generated output is public |
| Alibaba | Yes | Apache-2.0 | High — Darabonba toolchain + `.tea` sources public |

Four of five could, in principle, let an outside party regenerate or extend the
SDKs. OCI is the sole closed shop: `OracleSDKGenerator` is a name in a header and
nothing more.

---

## Cross-language verification & spec support

Generating N language SDKs from one spec is only half the problem; the other half
is *proving* those N SDKs behave identically. Every provider has a mechanism for
this, and — like the generators themselves — the mechanisms differ sharply in
shape and openness.

| Provider | Shared cross-language test artifact | Spec→test generation? | Where the consistency gate runs | Public? |
|---|---|---|---|---|
| **AWS** | Smithy **protocol tests** (`httpRequestTests`/`httpResponseTests` traits) + endpoint tests | **Yes** — each generator compiles the same cases into runnable suites | In each language's generated test suite | **Yes** (OSS) |
| **GCP** | **`gapic-showcase`** conformance server + `compliance_suite.json`; `googleapis/conformance-tests` | Partly — generator goldens are generated; the corpus is shared JSON/proto | Generator CI runs each client against one shared server | **Yes** (OSS) |
| **Azure** | **`spector`** spec-driven mock scenarios (`@typespec/http-specs` + `@azure-tools/azure-http-specs`) + **`test-proxy`** record/replay | Indirect — every emitter regenerates a client from the same `.tsp` scenarios | Emitter CI: generate → serve mock → exercise; plus shared record/replay | **Yes** (OSS) |
| **OCI** | **`SDKTestingService`** harness (Java types as canonical schema) | No (runtime-served corpus) | Internal harness validates each language per-API | **Mostly no** — only a Python/CLI *client* is public |
| **Alibaba** | Darabonba **test-case generation** (`*_test.tea` → per-language via `darabonba-assert`) | **Yes** (opt-in per generator) — but unevenly adopted | Mostly "consistent by construction" + per-lang hand tests | **Yes** (OSS) but no executed conformance matrix found |

### AWS — protocol tests as a shared, compiled conformance suite

AWS's headline mechanism is the **Smithy protocol test suite**: declarative test
cases authored once (as traits) and compiled by *each* language generator into a
runnable, idiomatic suite. The traits are defined in
[`smithy-protocol-test-traits`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-protocol-test-traits/src/main/resources/META-INF/smithy/smithy.test.smithy)
(`httpRequestTests`, `httpResponseTests` — the response selector deliberately
covers operations *and* any `@error` structure); the AWS-protocol corpus is the
separate `smithy-aws-protocol-tests` package, one dir per protocol. A case like
[`RestJsonHttpChecksumRequired`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-aws-protocol-tests/model/restJson1/http-checksums.smithy)
pins the exact `Content-MD5` header and JSON body. Each generator then emits it:
the Go generator's
[`HttpProtocolTestGenerator.java`](https://github.com/aws/smithy-go/blob/6857390fd160b416d0e369dc9dc5c2b3736178fc/codegen/smithy-go-codegen/src/main/java/software/amazon/smithy/go/codegen/integration/HttpProtocolTestGenerator.java)
produces [`internal/protocoltest/awsrestjson/api_op_HttpChecksumRequired_test.go`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/internal/protocoltest/awsrestjson/api_op_HttpChecksumRequired_test.go),
and the TypeScript generator produces
[`restjson1.spec.ts`](https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/private/aws-protocoltests-restjson/test/functional/restjson1.spec.ts).
**Crucially, the test-case `id` is preserved as the test name in every language**,
so cross-language drift is directly diffable — `RestJsonAllQueryStringTypes`
appears identically in the `.smithy` source, the generated Go test, and the
generated Jest spec. Endpoint-resolution tests (`smithy.rules#endpointTests` →
`endpoint-tests.json`) use the same pattern, emitting `TestEndpointCaseN` runners
per language.
*Asymmetry:* the legacy **aws-sdk-java-v2** does **not** consume these traits — it
keeps a separate, independently hand-authored
[`protocol-tests-core`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests-core/src/main/java/software/amazon/awssdk/protocol/ProtocolTestSuiteLoader.java)
JSON suite, mirroring the C2J-vs-Smithy split in the generators.

### GCP — a shared conformance server plus shared JSON corpora

GCP runs every generated client against one reference server,
[`gapic-showcase`](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/README.md)
(gRPC + HTTP/JSON), whose
[`compliance.proto`](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/compliance.proto)
exists explicitly "to test that GAPICs implement various REST-related features
correctly." The language-neutral corpus is
[`compliance_suite.json`](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/compliance_suite.json):
Go's [`TestComplianceSuite`](https://github.com/googleapis/gapic-generator-go/blob/df09eaf023d80438e826f304e4d03d86519c6d04/showcase/compliance_test.go)
and Java's [`ITHttpAnnotation.java`](https://github.com/googleapis/sdk-platform-java/blob/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/java-showcase/gapic-showcase/src/test/java/com/google/showcase/v1beta1/it/ITHttpAnnotation.java)
both load the byte-identical file and drive the same `Compliance.RepeatData*`
RPCs against the same server binary — a direct two-language proof. Two supporting
layers: per-generator **golden/baseline tests** (Python `tests/integration/goldens/`,
Go `.want`, Java `.golden`, TS `.baseline`) pin each generator's *emitted* code,
and the product-level [`googleapis/conformance-tests`](https://github.com/googleapis/conformance-tests/blob/998891a8dae00df121e460420cceb0abfc4e2ea1/README.md)
corpora extend shared JSON cases to behavior the generator can't cover — e.g. the
Storage [`v4_signatures.json`](https://github.com/googleapis/conformance-tests/blob/998891a8dae00df121e460420cceb0abfc4e2ea1/storage/v1/v4_signatures.json)
"Simple GET" case pins the exact `expectedUrl`/`expectedStringToSign`, so every
language's Storage client is held to byte-identical V4 signing.

### Azure — spec-driven mock scenarios + shared record/replay

Azure uses two complementary systems. **`spector`** (formerly `cadl-ranch`) is a
suite of scenarios, each a `main.tsp` annotated with `@scenario` plus a `mockapi.ts`
pinning the exact expected request/response; the scenarios live in
[`@typespec/http-specs`](https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/specs/authentication/api-key/main.tsp)
(neutral) and
[`@azure-tools/azure-http-specs`](https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/specs/azure/core/basic/main.tsp)
(Azure-specific). *Every* language emitter regenerates a client from the same
`.tsp` scenarios and must satisfy the same mock server — verified end-to-end for
the Python emitter, whose [`conftest.py`](https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/tests/conftest.py)
launches `npx tsp-spector serve` on `localhost:3000` and runs generated clients
against it. This catches *generation* drift (wrong serialization, missing
`api-version`, wrong auth header). The second system, **`test-proxy`**, is one
shared .NET record/replay binary used by every language repo, with recordings
stored out-of-band in `Azure/azure-sdk-assets` and referenced by a per-package
[`assets.json`](https://github.com/Azure/azure-sdk-tools/blob/249712c6c20bd30210c44b7f666b2c54dfed16c7/tools/test-proxy/documentation/asset-sync/README.md);
it catches *library* drift in shipped packages (including hand-written convenience
layers the generator never sees). Both have an AutoRest-era ancestor,
[`autorest.testserver`](https://github.com/Azure/autorest.testserver/blob/c04d3fe530c00a8095cfc6288d5f7bf1c7f61f38/README.md),
confirming continuity across the migration. (One nuance: `test-proxy` tag prefixes
are per-language, so its guarantee is "same framework/contract," not "same
recording replayed by every language.")

### OCI — an internal harness, glimpsed through a public client

OCI's cross-language consistency is enforced **internally**, but the public repos
leak the mechanism: both the Python SDK and the Python CLI ship a client for an
internal HTTP service literally named
[`SDKTestingService`](https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/testing_service_client.py#L13-L16).
It is language-agnostic by design: each SDK sends a `lang` parameter, pulls
**shared request inputs** via `get_requests(service, api)`, drives its own client,
and POSTs the response back via `validate_result(...)` to be checked — and the
expected types are expressed in the **Java SDK namespace**
(`com.oracle.bmc.{pkg}.requests.{Api}Request`), making **Java the canonical
reference type model** for cross-language equivalence. Tellingly, **no generated
service client has a checked-in unit test in any of the four public repos** — the
only public tests cover hand-written code (signing, transfer manager); the
systematic per-API testing runs against the internal harness. The Go/Java/TS
harness clients are not public, but the lockstep synchronized releases imply they
exist. This is the same "one shared corpus, one canonical schema" idea as AWS/GCP —
run entirely behind closed doors.

### Alibaba — test generation as a capability, consistency by construction

Darabonba's DSL can generate **test cases**, not just SDKs: a Darafile may declare
a `test` key pointing at a `*_test.tea` module, and
[`commands/codegen.js`](https://github.com/aliyun/darabonba-cli/blob/f08154d89ab1f72f8d67aeb71043aa97423b643d/commands/codegen.js)
runs a second codegen pass for generators that opt in via `supportGenerateTest`.
The shared assertion primitive is itself a generated Darabonba library,
[`darabonba-assert`](https://github.com/aliyun/darabonba-assert/blob/240d74281a974f93337161157841de494d180eba/Teafile)
(`Assert.equal`/`mapEql`/…), published to every language — so one `*_test.tea`
module compiles to per-language suites that call the per-language `Assert` build,
mirroring the SDK model exactly. **But the capability is unevenly adopted**: only
the Python, TypeScript, and PHP generators define `supportGenerateTest` (Go, Java,
C#, C++ do not at the pinned SHAs), and even repos with a `test` Darafile entry
ship a mix of generated and hand-written per-language tests. There is **no executed
cross-language conformance matrix** in the public toolchain; `dara check` is
single-file syntax only and `dara score` is a docs/release-completeness linter.
Alibaba's cross-language guarantee therefore rests mostly on the **deterministic
codegen pipeline** ("consistent by construction") plus per-language hand-written
runtime tests.

### Synthesis

The same split seen in the generators recurs in verification:
- **AWS and GCP** have the most rigorous, fully-public, *executed* cross-language
  conformance — AWS by compiling one trait-defined suite into every language, GCP
  by running every client against one shared server + shared JSON corpora.
- **Azure** matches them on rigor and openness, uniquely splitting the check into
  *generator-level* (spector spec scenarios) and *library-level* (test-proxy
  record/replay) — necessary because so much of an Azure SDK is hand-written over
  the generated layer.
- **OCI** runs the same kind of centralized, canonical-schema harness, but keeps
  it internal — only a client for `SDKTestingService` is public.
- **Alibaba** leans on determinism ("one DSL → all languages, so they can't
  diverge") with test generation as an available-but-uneven capability rather than
  an enforced matrix.

A recurring design choice: **Java/JVM types as the canonical reference** (OCI's
harness validates against `com.oracle.bmc.*`; GCP's Java showcase suite vendors the
same `compliance_suite.json`), and **case IDs / shared corpora as the diff anchor**
(AWS preserves test `id` across languages; GCP/Azure share byte-identical
corpora/scenarios).

---

## Reproductions: local generator runs

To confirm the pipelines are real and reproducible, each provider's generator was
run locally against a case-study (or minimal) spec. Captured inputs, commands, and
outputs live under `<provider>/runs/`. Toolchain: Java 25, Node 26, Python 3.13
(`uv`), Go 1.26, Smithy CLI 1.71.0, protoc via `grpcio-tools`.

| Provider | Run | Spec → target | Result |
|---|---|---|---|
| **GCP** | `gcp/runs/cloudfunctions-python/` | Cloud Functions v2 proto → Python (`gapic-generator-python`) | **SUCCESS** — 63 files, ~22k LOC; verified `method_signature` flattening + grpc+rest transports |
| **Alibaba** | `alicloud/runs/darabonba-multilang/` | one `.dara` module → Python **and** Go (`dara codegen`) | **SUCCESS** — one DSL → two SDKs; Go output binds to `alibabacloud-go/tea` runtime |
| **Azure** | `azure/runs/widget-autorest-python/` | Swagger 2.0 → Python (**AutoRest**, legacy) | **SUCCESS** — emitted its own retirement notice + `_patch.py` seams |
| **Azure** | `azure/runs/widget-typespec-ts/` | `.tsp` → TypeScript (**TypeSpec** emitter, new) | **SUCCESS** — modular client over `@typespec/ts-http-runtime` |
| **AWS** | `aws/runs/sqs-typescript/` | real **SQS** Smithy model → TypeScript (`smithy build`) | **SUCCESS** — 46 files, 24 commands, `Aws_json1_0.ts` protocol; AWS TS codegen pulled from Maven Central |
| **OCI** | `oracle/runs/README.md` | — | **CANNOT RUN** — generator closed-source; documented with 404 probes + header evidence |

Highlights that validated specific claims in this document:
- **GCP**: the proto annotation `(google.api.method_signature) = "name"` produced the
  flattened `get_function(name=...)` overload in the generated `client.py` — the
  annotation→ergonomic-overload mechanism, observed directly.
- **AWS**: the SQS service's `aws.protocols#awsJson1_0` trait selected the
  `Aws_json1_0.ts` protocol generator; the build log shows the
  `TypeScriptIntegration` SPI system wiring plugins — confirming the writer-based,
  SPI-integration Smithy pipeline with no AWS-internal tooling.
- **Azure**: the *same* trivial API expressed as Swagger and as TypeSpec drove two
  different generators into two languages, both producing a thin generated surface
  over a hand-written runtime — the "dual stack" made concrete, including AutoRest
  printing its own July 2026 retirement warning at runtime.
- **Alibaba**: one imperative `.dara` source deterministically emitted idiomatic
  Python and Go that bind to the shared hand-written Tea runtime.
- **OCI**: every plausible public generator repo 404s; the generator survives only
  as the `OracleSDKGenerator` string in generated headers — the closed-source
  finding, reconfirmed.

A genuine dependency surfaced and is documented: `gapic-generator-python` requires
**pandoc** (it converts proto-comment docs to docstrings via `pypandoc`) and exits
non-zero without it.

---

## Concluding observations

1. **One generator per language is the norm, not one generator with plugins.**
   Only Azure's AutoRest/TypeSpec approximates a single core with language
   plugins; AWS, GCP, and Alibaba all ship a distinct generator project per
   language (GCP even uses a different *template engine* per language). The
   shared asset is the *spec format and its type model*, not the code emitter.

2. **Template engines are receding.** The most mature pipelines (AWS Smithy, GCP
   Java) have moved to **programmatic writer/AST codegen** rather than text
   templates, which gives type-safe, composable emission. Templates persist where
   they're convenient (GCP Python/Jinja2, TS/Nunjucks).

3. **The spec is increasingly the place to express divergence.** GCP's
   per-language `ClientLibrarySettings`, Azure's per-language-scoped `client.tsp`
   decorators, and Alibaba's imperative `.tea` all push customization *into the
   authoring artifact* so one spec deterministically drives N divergent clients.
   AWS is the counterexample, keeping overrides in compiled generator code.

4. **"Generated" rarely means "all of it."** For the highest-traffic services —
   object storage especially — the ergonomic surface is hand-written on top of a
   thin generated protocol layer (Azure Blob, GCP Storage, OCI transfer manager,
   Alibaba OSS). The generator handles the long tail of services uniformly; the
   flagship services get bespoke attention.

5. **Two providers are mid-migration right now.** Azure (AutoRest → TypeSpec,
   hard deadline 2026-07-01) and GCP (OwlBot → `librarian` hermetic build) are
   both visibly transitioning their pipelines. Any snapshot of their generation
   stack is dual-state by nature.

6. **Openness is a deliberate product choice.** AWS, GCP, Azure, and Alibaba
   treat the generator (and often the spec) as a reusable, publicly licensed
   asset; OCI treats it as internal infrastructure. The difference is visible to
   any third party who wants to build their own client or tooling.

7. **Cross-language *verification* is as much a differentiator as generation.**
   Producing N SDKs is only credible if they provably behave the same. AWS, GCP,
   and Azure invest in fully-public, executed cross-language conformance (compiled
   protocol tests; a shared conformance server; spec-driven mock scenarios +
   record/replay). OCI runs an equivalent canonical-schema harness but keeps it
   internal. Alibaba leans on codegen determinism with test generation as an
   uneven capability. Two patterns recur across providers: a **JVM type model as
   the canonical reference**, and **shared corpora / preserved case IDs as the
   cross-language diff anchor**.

---

## Known gaps and caveats

Items below are unverified from public source and tracked in `DO_NEXT.md`:

- **AWS**: internal source-of-truth name and Smithy-AST↔C2J conversion direction;
  whether botocore does literally zero static codegen; maturity of aws-sdk-python
  v3 / smithy-python (both pre-1.0 at research date — boto3 remains production).
- **GCP**: `googleapis/googleapis-gen` now 404s publicly — current state
  (private/removed/superseded) unconfirmed; `librarian`/hermetic-build internals;
  Node monorepo migration state; Java per-file SHAs read at `main`, not pinned.
- **Azure**: public percentage/count of services migrated to TypeSpec;
  `azure-servicebus` data-plane hand-vs-generated split; `azure-mgmt-web`
  generator metadata; exact `typespec-java` package path.
- **OCI**: whether a downloadable raw spec endpoint exists; internal CI/build
  system; existence of per-service generator override config.
- **Alibaba**: the authoritative public API-meta feed behind `.tea` authoring;
  the CI that runs `dara codegen` across ~800 services; whether current Python/Go
  MNS data-plane clients are hand-written.

Cross-language-verification gaps (from the `<provider>/verification.md` notes):
- **AWS**: confirm whether aws-sdk-java-v2 consumes the Smithy protocol-test
  traits at all (it appears to use only its own JSON suite); whether waiters /
  paginators have any shared conformance corpus.
- **GCP**: pin the per-product consumers of `googleapis/conformance-tests` (the
  submodule path + runner in python-storage, google-cloud-go, etc.); the Node
  live-server showcase suite.
- **Azure**: per-language CI YAML for the non-Python `http-client-*` emitters;
  whether `test-proxy` recordings are ever shared across languages (tag prefixes
  are per-language, suggesting not).
- **OCI**: the `SDKTestingService` server + served corpus, and the Go/Java/TS
  harness clients — all internal.
- **Alibaba**: whether any executed cross-language conformance matrix exists in
  (likely internal) CI; whether `credentials-*` share golden test vectors.

All five local generator runs have now been executed and captured under
`<provider>/runs/` (see "Reproductions" above): GCP, Alibaba, Azure (both
stacks), and AWS reproduced successfully; OCI documented as an impossible run
because its generator is closed-source.
