# How famous SDKs are built — per-SDK profiles

Build-model profiles for widely-used SDKs, cloud and non-cloud, each documenting
**what the SDK is generated from, by which generator, and what's generated vs
hand-written**. Companion to the cloud-provider analysis in
[`../CODE_GENERATION.md`](../CODE_GENERATION.md) and the IaC analysis in
[`../IAC_CODEGEN.md`](../IAC_CODEGEN.md).

The headline finding: these popular SDKs fall on the **same build-model spectrum**
as the cloud SDKs — from *interpret a model at runtime* to *generate static source
per language*.

## The build-model spectrum

1. **Data-driven / runtime-interpreted** — ship a model (JSON), build the client
   classes dynamically at runtime; no per-service source. → **boto3/botocore**,
   **google-api-python-client**.
2. **Codegen from a type-system IDL** (Smithy / Protobuf) — emit static, typed
   source. → **aws-sdk-python v3**, **aws-sdk-js-v3**, **aws-sdk-go-v2**.
3. **Bespoke generator from a legacy JSON model** — → **aws-sdk-java-v2** (C2J +
   JavaPoet).
4. **Codegen from OpenAPI** — an OpenAPI spec drives emission, either via a
   closed/internal generator (**Stripe**) or by extending the open-source
   **OpenAPI Generator** (**Twilio**, **Kubernetes** non-Go clients), or generating
   just the types (**GitHub Octokit**).
5. **Codegen from hand-written Go types via gengo** — markers on Go structs drive
   generation. → **Kubernetes client-go**.
6. **Codegen from Discovery Documents** — Google's older REST family;
   **statically** generated for Go/Node/Java, **dynamically** interpreted for
   Python.

## Cross-SDK matrix

| SDK | Source model | Generator | Build model | Multi-lang strategy | License |
|---|---|---|---|---|---|
| [boto3 / botocore](boto3.md) | C2J `service-2.json` | none (runtime engine) | **data-driven (runtime)** | one Python engine over JSON | Apache-2.0 |
| [aws-sdk-python v3](aws-sdk-python-v3.md) | Smithy | smithy-python (writer-based) | codegen (IDL) | per-language Smithy generators | Apache-2.0 |
| [aws-sdk-js-v3](aws-sdk-js-v3.md) | Smithy | smithy-typescript | codegen (IDL) | per-language Smithy generators | Apache-2.0 |
| [aws-sdk-go-v2](aws-sdk-go-v2.md) | Smithy | smithy-go | codegen (IDL) | per-language Smithy generators | Apache-2.0 |
| [aws-sdk-java-v2](aws-sdk-java-v2.md) | C2J `service-2.json` | bespoke + JavaPoet | codegen (legacy JSON) | own generator | Apache-2.0 |
| [Stripe](stripe.md) | OpenAPI (`stripe/openapi`) | **internal, closed-source** | codegen (OpenAPI) | one internal generator → 7 langs | MIT (dotnet Apache-2.0) |
| [Twilio](twilio.md) | OpenAPI (`twilio/twilio-oai`) | **extends OpenAPI Generator** | codegen (OpenAPI) | OpenAPI-Generator + Twilio templates → 7 langs | MIT |
| [GitHub Octokit](github-octokit.md) | GitHub OpenAPI description | `openapi-typescript` → types | codegen (OpenAPI **types only**) | shared TS types; hand-written cores | MIT |
| [Kubernetes client-go](kubernetes-client-go.md) | hand-written Go API types | `client-gen` (gengo) | codegen (Go types) | gengo (Go) **vs** OpenAPI Generator (others) | Apache-2.0 |
| [Google APIs (Discovery)](google-apis-client.md) | Discovery Documents | per-lang (Go/Node/Java) | static codegen **or** runtime (Python) | per-language generators / runtime | Apache-2.0 (Go: BSD-3) |

## Recurring patterns worth noting

- **The same vendor often ships both models.** AWS: boto3 (runtime) *and*
  aws-sdk-python v3 (Smithy codegen). Google: google-api-python-client (runtime)
  *and* google-api-go-client (static codegen) — from the *same* Discovery docs.
  Kubernetes: client-go (gengo) *and* python/java/js (OpenAPI Generator).
- **OpenAPI is the most common public source-of-truth** for non-cloud SDKs
  (Stripe, Twilio, Octokit, Kubernetes' non-Go clients) — but the *generator* is
  often closed (Stripe) or a customization of the open-source OpenAPI Generator
  (Twilio).
- **"Generated" almost always means resources/shapes, not the whole SDK.** The
  transport/auth/retry/pagination **core is hand-written** in nearly every SDK
  here (Stripe `_api_requestor.py`, Twilio `twilio/base`, Octokit `@octokit/core`,
  client-go `rest`/`transport`) — exactly the trust boundary seen in the cloud
  SDKs.
- **Runtime-interpretation is a real, lasting design** — boto3 and
  google-api-python-client both prove a model-at-runtime SDK can cover hundreds of
  services and stay in production for over a decade, trading static types/async for
  uniformity and trivial "add a service."

## See also
- [`../CODE_GENERATION.md`](../CODE_GENERATION.md) — the five cloud providers' SDK pipelines.
- [`../IAC_CODEGEN.md`](../IAC_CODEGEN.md) — the IaC layer (CDK/Pulumi/Bicep/Terraform).
