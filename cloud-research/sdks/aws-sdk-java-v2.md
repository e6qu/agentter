# AWS SDK for Java v2 (`aws-sdk-java-v2`)

**Build model: bespoke generator from the legacy C2J model + JavaPoet.** Unlike
the Smithy SDKs (Go/JS/Rust/Python-v3), Java v2 is the *other* AWS lineage: it
consumes the older **C2J `service-2.json`** models and emits code with its own
generator built on **JavaPoet**.

Per-SDK profile; full AWS analysis in
[`../CODE_GENERATION.md`](../CODE_GENERATION.md).

## Source model
**C2J `service-2.json`** ("Coral-to-JSON"), per service under
[`services/<svc>/src/main/resources/codegen-resources/`](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources)
(`service-2.json`, `customization.config`, `paginators-1.json`, `waiters-2.json`,
endpoint rules). This is the older normalized format (`metadata`/`operations`/
`shapes`), **not** Smithy JSON AST — the same lineage as botocore/boto3. The
container class is literally
[`C2jModels`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/C2jModels.java).

## Generator + engine
A **bespoke generator** in `software.amazon.awssdk.codegen`: it loads an
`IntermediateModel` from the C2J inputs and emits code with **JavaPoet**
(`ClassSpec`/`*Spec` builders) under
[`codegen/.../poet/`](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/poet).
Programmatic, not text templates. Build tooling: Maven.

## Generated vs hand-written
- **Generated:** per-service client/model/serde classes from the C2J model.
- **Hand-written, beside the generated classes:** e.g. S3's `S3Utilities`,
  `S3Uri`, `multipart/`, `presigner/`, `s3express/`, `crt/`; SQS's
  `SQSValidateMessageChecksum` (client-side MD5 validation). The `core/` modules
  (auth, retry, http) are hand-written runtime.

## Customization
**JSON `customization.config`** per service (not code) — declares
`renameShapes`, `shapeModifiers`, `shapeSubstitutions`, etc. S3's
[`customization.config`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/services/s3/src/main/resources/codegen-resources/customization.config)
renames `Error`→`S3Error`, `Object`→`S3Object`. This is the C2J analogue of the
Smithy SDKs' Java-SPI integrations.

## Multi-language relationship
Java v2 is *not* part of the Smithy generator family — it has its own model
format and generator. **Monorepo of Maven modules under `services/*`**,
coordinated by a BOM. AWS is gradually adding Smithy-derived codegen paths for
newer protocols (e.g. an `SmithyRpcV2CborProtocolProcessor` exists), but the
mainline remains C2J + JavaPoet.

## Cross-language verification
Notably, java-v2 does **not** consume the Smithy `httpRequestTests` traits the
way Go/JS do — it has a *separate*, independently hand-authored
`protocol-tests-core` JSON suite (`ProtocolTestSuiteLoader`). This is the one
asymmetry in AWS's otherwise-shared protocol-test story — see the AWS verification
section of `../CODE_GENERATION.md`.
