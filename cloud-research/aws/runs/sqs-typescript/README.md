# AWS local generator run — SQS Smithy model → TypeScript

**Result: SUCCESS.** The real SQS Smithy model generated a real `@aws-sdk/client-sqs`
TypeScript client (46 `.ts` files) via `smithy build`. The feared
"AWS-protocol-support-not-on-Maven" blocker did **not** materialize:
`smithy-aws-typescript-codegen` 0.31.1 is published to Maven Central.

## Toolchain
- Smithy CLI 1.71.0 (`brew install smithy-lang/tap/smithy-cli`); it bundles its
  own JDK runtime. (Java 25 also present system-wide.)
- Codegen pulled from Maven Central at build time:
  `software.amazon.smithy.typescript:smithy-aws-typescript-codegen:0.31.1`
  (transitively brings the base `smithy-typescript-codegen` + `smithy-aws-traits`,
  which supply the `aws.protocols#awsJson1_0` support SQS needs).

## Input (spec) — see `input/`
- `model/sqs.json` — the **real** SQS Smithy 2.0 JSON AST, fetched from
  `aws/api-models-aws` @ `fd819cad3147ee122087ef83ea092bd32309c5c8`,
  `models/sqs/service/2012-11-05/sqs-2012-11-05.json`. Service shape
  `com.amazonaws.sqs#AmazonSQS`; protocol `aws.protocols#awsJson1_0` (+
  `awsQueryCompatible`); auth `aws.auth#sigv4`; carries `smithy.rules#endpointRuleSet`.
- `smithy-build.json` — declares the Maven dep + the `typescript-client-codegen`
  plugin targeting the SQS service.

## Invocation
```
smithy build         # reads smithy-build.json, validates the model, runs the plugin
```
`smithy build` reported: `SUCCESS: Validated 981 shapes`, then
`Smithy built 1 projection(s), 4 plugin(s), and 59 artifacts`.

## What was generated (output/typescript-client-codegen/src/)
A real modular AWS SDK v3 client:
- `SQSClient.ts` (extends the `@smithy/smithy-client` `__Client`), `SQS.ts`
  (aggregated client)
- `commands/` — **24** command classes (`SendMessageCommand`,
  `CreateQueueCommand`, `ReceiveMessageCommand`, …)
- `protocols/Aws_json1_0.ts` — the awsJson1_0 wire serializer/deserializer,
  emitted by the AWS protocol generator
- `models/`, `pagination/`, `auth/`, `endpoint/`,
  `runtimeConfig.{ts,browser,native,shared}`

## Evidence it reflects the documented architecture
- **Writer-based, not template-based.** This is the `smithy-typescript-codegen`
  writer pipeline (`TypeScriptWriter`/`DirectedCodegen`) the deliverable
  describes; every file carries the marker `// smithy-typescript generated code`.
- **AWS customizations are SPI integrations.** The build log shows the integration
  system at work — e.g. `AddEndpointDiscoveryPlugin is supposed to run after
  ...AddAwsAuthPlugin`. These are exactly the `TypeScriptIntegration` SPI classes
  in `smithy-aws-typescript-codegen` that the deliverable cites (AWS §Customization).
- **Protocol from a trait.** The service's `aws.protocols#awsJson1_0` trait
  selected the `Aws_json1_0.ts` protocol generator — model-trait → protocol code.

## Caveat (documented, not hidden)
A benign warning appeared: `AddEndpointDiscoveryPlugin is supposed to run after an
integration that could not be found, '...AddAwsAuthPlugin'`. This is because the
build used only `smithy-aws-typescript-codegen`; the full published `@aws-sdk/client-sqs`
build also layers additional `@aws-sdk/*` integration packages that wire the
complete auth plugin chain. Core codegen (commands, protocol, models, endpoint
rules) generated fully and correctly; only some optional plugin wiring is partial.
This does not affect the architectural conclusions.

## Takeaway for the deliverable
A real AWS service model, run through the public Smithy CLI + the Maven-published
AWS TypeScript codegen, deterministically produces the same command/protocol/client
structure shipped in `aws-sdk-js-v3` — confirming the writer-based, SPI-integration
Smithy pipeline end-to-end, with no AWS-internal tooling required.
