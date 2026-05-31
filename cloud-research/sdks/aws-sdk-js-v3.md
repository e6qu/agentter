# AWS SDK for JavaScript v3 (`aws-sdk-js-v3`)

**Build model: codegen from a type-system IDL (Smithy).** Each `@aws-sdk/client-*`
package is generated from a Smithy model by a writer-based generator; the runtime
is hand-written `@smithy/*` + `@aws-sdk/*` middleware packages.

This is a per-SDK profile; the full AWS analysis (and the cross-language
verification story) is in [`../CODE_GENERATION.md`](../CODE_GENERATION.md) (AWS
section). A local reproduction of this exact pipeline — generating the SQS
TypeScript client — is in [`../aws/runs/sqs-typescript/`](../aws/runs/sqs-typescript/README.md).

## Source model
**Smithy 2.0 JSON AST.** Models are published wholesale in
[`aws/api-models-aws`](https://github.com/aws/api-models-aws/blob/fd819cad3147ee122087ef83ea092bd32309c5c8/README.md)
and vendored per-repo; the SQS model literally begins `{"smithy": "2.0", ...}`.
Generated from an AWS-internal source of truth `(unverified internal name)`.

## Generator + engine
The base generator is
[`smithy-lang/smithy-typescript`](https://github.com/smithy-lang/smithy-typescript/tree/ee5462855d3644663dd31fecfa308d3d4d6d6afb/smithy-typescript-codegen/src/main/java/software/amazon/smithy/typescript/codegen)
— a **Java** project using `TypeScriptWriter` / `DirectedCodegen`. It is
**writer/AST-based, not template-based** (no Mustache). The AWS-specific layer is
the `smithy-aws-typescript-codegen` Gradle module inside the SDK repo's
`codegen/` project; build tooling is **Gradle + the Smithy Gradle plugin**. Every
generated file carries `// smithy-typescript generated code`.

## Generated vs hand-written
- **Generated:** per-service `clients/client-*/src/` — `commands/`, `models/`,
  `protocols/`, `pagination/`, the `*Client.ts`/aggregated client.
- **Hand-written:** the runtime — `@smithy/*` packages and `@aws-sdk/middleware-*`
  (signing, retry, endpoint resolution, the HTTP handler) — wired in by codegen
  integrations rather than generated per service. Plus helper packages like
  `@aws-sdk/s3-request-presigner`.

## Customization
**Smithy "integrations" registered via Java SPI** (`TypeScriptIntegration` in
`META-INF/services/...`). AWS integrations include
[`AddSqsDependency`](https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/codegen/smithy-aws-typescript-codegen/src/main/java/software/amazon/smithy/aws/typescript/codegen/AddSqsDependency.java),
`AddS3Config`, `AddS3ControlDependency`. Integrations apply model transforms and
inject runtime client plugins/middleware.

## Multi-language relationship
One of AWS's per-language Smithy generators (alongside smithy-go, smithy-rs,
smithy-python). They share the **Smithy core library + trait model**, but each
language has its own codegen project — there is no single binary emitting all
languages. Monorepo of npm packages (`clients/client-*` + shared `packages/*`),
per-package versioning.

## Cross-language verification
The generated `private/aws-protocoltests-*` Jest suites are compiled from the
same `httpRequestTests`/`httpResponseTests` Smithy traits as the Go/other-language
suites, preserving test-case IDs — see the AWS verification section of
`../CODE_GENERATION.md`.
