# AWS SDK Code Generation — Research Notes

Research date: 2026-05-30. SHAs pinned at time of research.

Pinned commit SHAs used for permalinks below:
- `smithy-lang/smithy` @ `b697438e20bd209b28edf767a9795e6f35634b7b`
- `smithy-lang/smithy-typescript` @ `ee5462855d3644663dd31fecfa308d3d4d6d6afb`
- `aws/smithy-go` @ `6857390fd160b416d0e369dc9dc5c2b3736178fc`
- `smithy-lang/smithy-rs` @ `adfb210311670392727bccb54a54fcbf046eb23a`
- `aws/aws-sdk-go-v2` @ `13bee3c72e77d68d6180fb633a7ce1c8714d53c0`
- `aws/aws-sdk-js-v3` @ `bae4bc0f1bafc951f6593c94c223e63c47f24692`
- `aws/aws-sdk-java-v2` @ `3189683fa6ac17cb7d317581d7e975cd0d1108e6`
- `boto/botocore` @ `43619d226cd0ef35e2a2452a54f2db81d4edec79`
- `aws/api-models-aws` @ `fd819cad3147ee122087ef83ea092bd32309c5c8`
- `smithy-lang/smithy-python` @ `d0e3206841482c980f71260c32c6ce68eb2d2346`

---

## TL;DR architecture

AWS models all public APIs in **Smithy** internally. Two model lineages reach
public repos:

1. **Smithy 2.0 JSON AST** — the modern source of truth, published wholesale in
   `aws/api-models-aws`, and consumed by the *modern* SDKs: **aws-sdk-go-v2**,
   **aws-sdk-js-v3**, **smithy-rs / aws-sdk-rust**, and the experimental
   **aws-sdk-python (v3)**.
2. **Legacy C2J `service-2.json`** ("Coral-to-JSON") — the older normalized
   model format still used by **botocore/boto3 (Python)** and **aws-sdk-java-v2**.
   These two do NOT use Smithy codegen; they each have their own bespoke
   generator and JSON model + JSON customization-config format.

The Smithy code generators are **writer-based, not template-engine-based**: a
single core (`smithy-codegen-core`, `AbstractCodeWriter`/`SymbolWriter`,
`DirectedCodegen`) plus one Java codegen project per target language
(`smithy-typescript-codegen`, `smithy-go-codegen`, smithy-rs `codegen-client`).
Each SDK repo then layers an **`aws-*-codegen`** Gradle module of AWS-specific
"integrations"/"customizations" on top, registered via Java SPI.

---

## 1. Service description / IDL

### Modern: Smithy 2.0 JSON AST (Go, JS, Rust, Python-v3)

`aws/api-models-aws` README states plainly: this repo contains **Smithy models in
JSON AST form for all public AWS API services**, and "At AWS, we use Smithy
extensively to model our service APIs and provide the daily releases of the AWS
SDKs and CLIs." It also warns the files are *generated from other sources* (not
hand-edited here; no PRs accepted).
- https://github.com/aws/api-models-aws/blob/fd819cad3147ee122087ef83ea092bd32309c5c8/README.md

Layout: `models/<sdk-id>/service/<version>/<sdk-id>-<version>.json`. `<sdk-id>`
is the lowercased/hyphenated Smithy `sdkId`. Verified case-study paths:
- S3: `models/s3/service/2006-03-01/s3-2006-03-01.json`
- SNS: `models/sns/service/2010-03-31/sns-2010-03-31.json`
- SQS: `models/sqs/service/2012-11-05/sqs-2012-11-05.json`
- Lambda: `models/lambda/service/2015-03-31/lambda-2015-03-31.json`

Verified format by fetching the SQS model raw: it begins `{"smithy": "2.0", "metadata": {...}, "shapes": {"com.amazonaws.sqs#...": {...}}}` — i.e. genuine Smithy JSON AST.
- https://github.com/aws/api-models-aws/blob/fd819cad3147ee122087ef83ea092bd32309c5c8/models/sqs/service/2012-11-05/sqs-2012-11-05.json

**Each modern SDK vendors its own copy of the models** inside the repo (the
public `api-models-aws` is a convenience mirror). e.g. aws-sdk-go-v2 keeps
`codegen/sdk-codegen/aws-models/{s3,sns,sqs,lambda}.json`:
- https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/sdk-codegen/aws-models

**Public/consumable by third parties?** Yes — `api-models-aws` is Apache-2.0 and
explicitly pitched for "building custom SDKs/CLIs ... or implementing MCP servers."

### Legacy: C2J `service-2.json` (botocore/boto3, Java v2)

botocore stores per-service models under `botocore/data/<service>/<version>/`
with `service-2.json`, plus `paginators-1.json`, `waiters-2.json`,
`examples-1.json`, `endpoint-rule-set-1.json`, and `.sdk-extras.json` overlay
files:
- https://github.com/boto/botocore/tree/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/data/s3/2006-03-01

aws-sdk-java-v2 keeps a near-identical model format per service under
`services/<svc>/src/main/resources/codegen-resources/`: `service-2.json`,
`customization.config`, `paginators-1.json`, `waiters-2.json`,
`endpoint-rule-set.json`, `endpoint-tests.json`:
- https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources

Verified the Java S3 `service-2.json` starts `{"version":"2.0","metadata":{"apiVersion":"2006-03-01","protocol":"rest-xml", ... "uid":"s3-2006-03-01"}, "operations": {...}}` — this is the **C2J normalized JSON model, NOT Smithy JSON AST** (different top-level shape: `metadata`/`operations`/`shapes` vs Smithy's `smithy`/`shapes` with namespaced shape IDs).
- https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources/service-2.json

The class confirming Java's "C2J" lineage is `C2jModels` (container holding
`ServiceModel`, `Waiters`, `Paginators`, `CustomizationConfig`, endpoint rules):
- https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/C2jModels.java

**Human-authored or generated?** The on-disk models in all these repos are
*generated from an AWS-internal source of truth* (Coral / internal Smithy
models). `api-models-aws` README explicitly says "generated from other sources."
?? verify: the exact internal source-of-truth name and the Smithy-AST↔C2J
conversion direction is not disclosed publicly — do not assert specifics.

---

## 2. Generator tool(s)

One **shared Smithy core** + **one language codegen project per language**, all
written in **Java** (Smithy itself is Java). Each is open source, Apache-2.0.

- **Smithy core** (`smithy-lang/smithy`): the IDL, model loader, traits, and
  `smithy-codegen-core` providing `SymbolProvider`, `SymbolWriter`,
  `WriterDelegator`, `DirectedCodegen` plumbing. Writer/AST-based, not templated.
  - https://github.com/smithy-lang/smithy/tree/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-codegen-core/src/main/java/software/amazon/smithy/codegen/core
- **smithy-typescript** (`smithy-lang/smithy-typescript`): `TypeScriptWriter`,
  `DirectedTypeScriptCodegen`, `integration/` extension points. Apache-2.0.
  - https://github.com/smithy-lang/smithy-typescript/tree/ee5462855d3644663dd31fecfa308d3d4d6d6afb/smithy-typescript-codegen/src/main/java/software/amazon/smithy/typescript/codegen
- **smithy-go** (`aws/smithy-go`): `GoWriter`, `AbstractDirectedCodegen`,
  `GoCodegenPlugin`, `GoStackStepMiddlewareGenerator`, etc. Apache-2.0. (The
  runtime crate-equivalent — the Go middleware stack — also lives here.)
  - https://github.com/aws/smithy-go/tree/6857390fd160b416d0e369dc9dc5c2b3736178fc/codegen/smithy-go-codegen/src/main/java/software/amazon/smithy/go/codegen
- **smithy-rs** (`smithy-lang/smithy-rs`): `codegen-core`, `codegen-client`,
  `codegen-server`, plus `rust-runtime` (runtime crates) and `aws/` (AWS-specific
  codegen + SDK integration). Kotlin-based codegen. Apache-2.0.
  - https://github.com/smithy-lang/smithy-rs/tree/adfb210311670392727bccb54a54fcbf046eb23a
- **smithy-python** (`smithy-lang/smithy-python`): experimental Smithy→Python
  codegen + core runtime modules. Apache-2.0. README: "All interfaces are subject
  to change ... should not be used in production yet."
  - https://github.com/smithy-lang/smithy-python/blob/d0e3206841482c980f71260c32c6ce68eb2d2346/README.md

**Legacy generators (one per language, bespoke, NOT Smithy):**
- **aws-sdk-java-v2 codegen** (`software.amazon.awssdk.codegen`): consumes C2J
  models, builds an `IntermediateModel`, emits code with **JavaPoet**
  (`codegen/.../poet/` package — `ClassSpec`, `PoetExtension`, etc.). Apache-2.0.
  - https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen
  - https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/poet
- **botocore (Python boto3)**: data-driven — botocore *interprets* the
  `service-2.json` models at runtime rather than generating static per-service
  client classes. (boto3/botocore is effectively a generic runtime over the
  shared JSON models, not a codegen pipeline that emits service classes.)
  - https://github.com/boto/botocore/tree/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/data

**One generator with language plugins, or one per language?** Per language. There
is no single binary that emits all four languages. They *share the Smithy core
library and trait model*, but each language has its own codegen project
(TS/Go/Rust under Smithy; Java/Python-legacy bespoke).

---

## 3. Pipeline / orchestration

**Build tooling = Gradle + Smithy Gradle plugin** for every Smithy-based SDK.
Each modern SDK repo contains a self-contained `codegen/` Gradle project:
- aws-sdk-go-v2 `codegen/` has `build.gradle.kts`, `settings.gradle.kts`,
  `gradlew`, and the AWS codegen module `smithy-aws-go-codegen/`:
  - https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen
- aws-sdk-js-v3 `codegen/` has `smithy-aws-typescript-codegen`, `sdk-codegen`,
  `build.gradle.kts`:
  - https://github.com/aws/aws-sdk-js-v3/tree/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen

**Triggering generation** (Go example, from the Makefile): `make generate`
chains `smithy-generate`, protocol-test gen, module metadata, etc. Models are
synced from the public model source via `sync-api-models`. Single-service dev
regen: `SMITHY_GO_BUILD_API=com.amazonaws.sqs DEV_SERVICE=sqs make generate-dev`.
- https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/Makefile

**Codegen version pinning** (Go): the SDK pins the `smithy-go` codegen commit it
was built against in `SMITHY_GO_CODEGEN_VERSION`, and `ci-find-smithy-go.sh`
mod-replaces a matching smithy-go branch in CI for coordinated changes.
- https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/SMITHY_GO_CODEGEN_VERSION
- https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/ci-find-smithy-go.sh

**Outputs are committed** into the SDK repo (generated `.go`/`.ts`/`.java` files
live in git, reviewed via normal PRs). Generation is automated internally and
shipped as daily releases (per `api-models-aws` README). ?? verify: the
internal CI orchestration that runs generation and opens the release PRs is not
public; do not assert specifics of the internal pipeline.

**Monorepo vs polyrepo for published SDKs:**
- aws-sdk-go-v2 — *monorepo*, one Go module per service under `service/` (426
  service dirs at the pinned SHA).
  - https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service
- aws-sdk-js-v3 — *monorepo* of npm packages: per-service `clients/client-*`
  plus shared `packages/*`.
  - https://github.com/aws/aws-sdk-js-v3/tree/bae4bc0f1bafc951f6593c94c223e63c47f24692/clients
- aws-sdk-java-v2 — *monorepo* of Maven modules under `services/*`.
  - https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services
- botocore — *single package* shipping all service data files together.
- aws-sdk-python (v3) — deliberately *per-service polyrepo-style* packages
  ("distributed per-service") even though developed in one repo.
  - https://github.com/awslabs/aws-sdk-python/tree/main/clients

---

## 4. Per-language customization mechanisms

**Engine: writer-based, NOT a template engine** (no Mustache/Velocity for the
Smithy SDKs). Code is emitted imperatively via `AbstractCodeWriter` subclasses
(`GoWriter`, `TypeScriptWriter`) driven by `DirectedCodegen`. Java-v2 differs: it
uses **JavaPoet** (`ClassSpec`/`*Spec` builders) — also programmatic, not text
templates.

**Smithy "integrations" / "customizations" via Java SPI.** Each AWS codegen
module registers extension classes in
`META-INF/services/<Integration interface>`:
- Go: integrations implement `software.amazon.smithy.go.codegen.integration.GoIntegration`
  and are listed in
  `META-INF/services/software.amazon.smithy.go.codegen.integration.GoIntegration`.
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/resources/META-INF/services/software.amazon.smithy.go.codegen.integration.GoIntegration
  - Customizations dir (general + per-service):
    https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization
  - Per-service subdir (`customization/service/{s3,sqs,dynamodb,ec2,route53,glacier,...}`):
    https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service
- TS: integrations implement `TypeScriptIntegration`, registered in
  `META-INF/services/...TypeScriptIntegration`. AWS ones include `AddS3Config`,
  `AddS3ControlDependency`, `AddSqsDependency`, `AddRetryCustomizations`.
  - https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen/smithy-aws-typescript-codegen/src/main/resources/META-INF/services/software.amazon.smithy.typescript.codegen.integration.TypeScriptIntegration
  - https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen/smithy-aws-typescript-codegen/src/main/java/software/amazon/smithy/aws/typescript/codegen/AddSqsDependency.java

Integrations work by (a) **model transforms** (e.g. backfilling missing traits —
`BackfillRequiredTrait`, `BackfillBoxTrait`, `BackfillSigV4ATrait`,
`RemoveDefaults`, `ShapeBackwardsCompatabilityTransforms`) and (b) injecting
**runtime client plugins / middleware** (`RuntimeClientPlugin`,
`MiddlewareRegistrar`) into the generated client.

**Java-v2 customization = JSON config, not code.** Per-service
`customization.config` declares `shapeSubstitutions`, `renameShapes`,
`shapeModifiers`, `verifiedSimpleMethods`, `customSdkShapes`, etc. Example (S3):
renames `Error`→`S3Error`, `Object`→`S3Object`; emits `Size` as `long`; marks
`Expires` deprecated.
- https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources/customization.config

botocore's equivalent overlay = the `service-2.sdk-extras.json` /
`paginators-1.sdk-extras.json` files merged onto the base model.
- https://github.com/boto/botocore/tree/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/data/s3/2006-03-01

**Where hand-written shims live (conventional pattern):**
- Go: generated files are prefixed `api_*.go` / `types/`/`serializers.go`/
  `deserializers.go`/`validators.go` and carry the header
  `// Code generated by smithy-go-codegen DO NOT EDIT.` Hand-written files have
  ordinary names and live in the same package, e.g. `handwritten_paginators.go`,
  `express*.go`, `presign_post.go`, `bucketer.go`, `eventstream.go`.
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service/s3/api_client.go (header line 1)
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service/s3/handwritten_paginators.go
- JS: generated files start with `// smithy-typescript generated code`.
  - https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/clients/client-sqs/src/SQSClient.ts
- Java: hand-written customization classes sit beside generated ones in
  `services/<svc>/src/main/java/...`, e.g. S3 `S3Utilities.java`, `S3Uri.java`,
  `multipart/`, `presigner/`, `s3express/`, `crt/`.
  - https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/java/software/amazon/awssdk/services/s3

Auth/retry/pagination/checksum **middleware** is generally hand-written runtime
code (Go middleware stack in smithy-go; JS `@smithy/*` + `@aws-sdk/middleware-*`
packages; Java `core/` modules), *wired in* by the codegen integrations rather
than generated per service.

---

## 5. Manual vs generated — case studies

### S3 (object storage)
- Model: Smithy AST `models/s3/service/2006-03-01/s3-2006-03-01.json`
  (api-models-aws); legacy C2J copies in botocore + java-v2.
- Generator: smithy-go / smithy-typescript / smithy-rs / java-v2 codegen.
- Generated output (Go): `service/s3/api_*.go`, `types/`, `serializers.go`,
  `deserializers.go`, `validators.go` — header `DO NOT EDIT`.
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service/s3/api_client.go
- Hand-written (Go): `handwritten_paginators.go`, `presign_post.go`,
  `express*.go` (S3 Express One Zone), `serialize_immutable_hostname_bucket.go`,
  `bucketer.go`, `eventstream.go`.
- S3 codegen customizations (Go) — a large, S3-specific set registered via SPI:
  `S3UpdateEndpoint`, `S3ContentSHA256Header`, `S3ErrorWith200Status`,
  `S3ResponseErrorWrapper`, `S3MetadataRetriever`, `S3AcceptEncodingGzip`,
  `S3GetBucketLocation`, `S3100Continue`, `S3ExportInternalFeatures`,
  `S3PaginationExtensions`, `BackfillS3ObjectSizeMemberShapeType`, etc.
  - https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service/s3
- S3 customizations (TS): `AddS3Config`, `AddS3ControlDependency`; plus
  hand-written helper packages `@aws-sdk/s3-request-presigner` and
  `@aws-sdk/s3-presigned-post`.
  - https://github.com/aws/aws-sdk-js-v3/tree/bae4bc0f1bafc951f6593c94c223e63c47f24692/packages
- S3 customizations (Java): JSON `customization.config` (renames Error/Object,
  shape type fixes) + hand-written `S3Utilities`, `multipart/`, `presigner/`,
  `s3express/`, `crt/` classes.

### SNS + SQS (messaging)
- Models: `models/sns/service/2010-03-31/sns-2010-03-31.json`,
  `models/sqs/service/2012-11-05/sqs-2012-11-05.json`.
- SQS message-checksum validation is a *codegen customization* (client-side MD5
  of message bodies), not part of the wire model:
  - Go `SQSValidateMessageChecksum` — targets `com.amazonaws.sqs#AmazonSQS`
    operations `SendMessage`, `SendMessageBatch`, `ReceiveMessage`; adds option
    `DisableMessageChecksumValidation`:
    https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/service/sqs/SQSValidateMessageChecksum.java
  - TS `AddSqsDependency` integration injects the SQS client plugin/middleware:
    https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen/smithy-aws-typescript-codegen/src/main/java/software/amazon/smithy/aws/typescript/codegen/AddSqsDependency.java
- Otherwise SNS/SQS clients are almost entirely generated (per-operation files,
  types, serializers); no large hand-written shim layer like S3's.
- Generated output (JS SQS): `clients/client-sqs/src/SQSClient.ts` etc.
  (`// smithy-typescript generated code`).

### Lambda (FaaS)
- Model: `models/lambda/service/2015-03-31/lambda-2015-03-31.json`.
- Lambda-specific codegen customization: `LambdaRecursionDetection` (Go) — adds
  operation-build middleware that detects the Lambda execution environment and
  propagates the X-Ray trace ID to avoid recursive-invocation loops:
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/smithy-aws-go-codegen/src/main/java/software/amazon/smithy/aws/go/codegen/customization/LambdaRecursionDetection.java
- Otherwise Lambda is a straightforward generated client.

---

## 6. Release & versioning

- **aws-sdk-go-v2**: per-service Go modules (each `service/<svc>` has its own
  `go.mod`, `CHANGELOG.md`, `go_module_metadata.go`), versioned independently;
  modman/`modman.toml` coordinates. Breaking spec changes surface as a new minor
  in that service module's changelog.
  - https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/modman.toml
- **aws-sdk-js-v3**: per-package npm versions for `@aws-sdk/client-*`; lerna-style
  monorepo release.
- **aws-sdk-java-v2**: BOM-coordinated Maven modules; services share the SDK
  version line via the BOM.
- **botocore/boto3**: single package version; new service models ship in regular
  botocore releases (daily-ish model updates).
- **aws-sdk-python (v3)**: per-service packages, pre-1.0, explicitly warns
  breaking changes may occur between minor versions until 1.0.
  - https://github.com/awslabs/aws-sdk-python/blob/main/README.md

AWS publishes **daily SDK/CLI releases** driven off the model updates
(api-models-aws README). Breaking *spec* changes are rare by policy (additive
modeling); when they occur they surface through the per-service changelog of the
affected module/package.

---

## Open items / gaps (`?? verify`)

- `?? verify`: exact name/structure of the AWS-internal model source-of-truth and
  the Smithy-AST ↔ C2J conversion (not public).
- `?? verify`: the internal CI system that runs generation and cuts release PRs
  (only the in-repo Gradle/Make entry points are public).
- `?? verify`: current status/coverage of aws-sdk-python (v3) and smithy-python —
  both still labeled experimental/pre-1.0 at research date; boto3/botocore remain
  the production Python SDK on legacy C2J models.
- `?? verify`: whether botocore truly does zero static code generation (it appears
  to be a runtime model interpreter) vs. some build-time generation — confirm by
  reading botocore client construction, not just the data dir.
