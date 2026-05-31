# boto3 / botocore — how it's built, vs the generated AWS SDK for Python (v3)

**Build model: data-driven / runtime-interpreted.** boto3 (and its engine
botocore) ship JSON models and *interpret them at runtime* — there is **no
per-service generated Python source**. Client classes are synthesized in memory
with `type()` when you create a client. This makes boto the canonical example of
the runtime-interpreted build model, and the opposite of the Smithy-code-generated
next-gen SDK (`aws-sdk-python` v3), which this doc compares it against.

> Verified directly from source. botocore @ `43619d226cd0ef35e2a2452a54f2db81d4edec79`,
> boto3 @ `9af784941c6d706c670ca32625406955b60610a9`, smithy-python @
> `2472785bbb35ca6a462522791a1e21a0c8ba2acd`, aws-sdk-python @
> `bc78957aa97bf324dab6eefd202edfcf09e1d460`.

---

## Part 1 — How boto is built (the data-driven model)

### botocore: the API is JSON data, the client is built at runtime
Each service ships JSON models under `botocore/data/<service>/<version>/`:
`service-2.json` (the API model), plus `paginators-1.json`, `waiters-2.json`,
`endpoint-rule-set-1.json`, and `*.sdk-extras.json` overlays. This is the legacy
**C2J** model format — the *same* lineage as `aws-sdk-java-v2`, not Smithy.

When you call `session.create_client('s3')`, botocore builds the client **class**
dynamically:
- [`ClientCreator._create_client_class`](https://github.com/boto/botocore/blob/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/client.py#L208)
  ends with `cls = type(str(class_name), tuple(bases), class_attributes)` — the
  class is manufactured at runtime, not written in a file.
- [`_create_methods`](https://github.com/boto/botocore/blob/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/client.py#L576)
  iterates the model's operations and makes one method each; every method body is
  just [`return self._make_api_call(operation_name, kwargs)`](https://github.com/boto/botocore/blob/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/client.py#L606).
- [`_make_api_call`](https://github.com/boto/botocore/blob/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/client.py#L999)
  is fully generic: look up the operation model → serialize per the model's
  protocol → resolve endpoint rules → sign → send → parse the response.

So `s3.list_buckets()` **does not exist as written source anywhere** — it is
generated in memory from `service-2.json` at client-creation time. botocore is a
generic *runtime over shared JSON models*, not a static codegen pipeline.

### boto3: resources, built the same way
boto3 wraps botocore and adds `Session` plus the higher-level **resource** objects
(`boto3.resource('s3')`). Those are *also* built dynamically from JSON:
[`ResourceFactory.load_from_definition`](https://github.com/boto/boto3/blob/9af784941c6d706c670ca32625406955b60610a9/boto3/resources/factory.py#L158)
reads `boto3/data/<svc>/.../resources-1.json` and again does
`type(str(cls_name), tuple(base_classes), attrs)`.

### Customization: an event system, not codegen
Because nothing is generated ahead of time, per-service behaviour can't be injected
by a generator. Instead botocore/boto3 use a **handler/event system**:
`_create_client_class` emits
[`creating-client-class.<service-id>`](https://github.com/boto/botocore/blob/43619d226cd0ef35e2a2452a54f2db81d4edec79/botocore/client.py#L202),
and handlers (in `botocore/handlers.py` and boto3 customizations) register on
events like `before-call`, `before-sign`, `provide-client-params.*` to tweak
behaviour. This is the runtime analogue of the Smithy SDKs' compiled "integrations."

### Where the JSON comes from, and what "building boto" means
The `service-2.json` models are generated from AWS's **internal API models** (the
same internal source feeding every AWS SDK) and committed into `botocore/data`.
Shipping a new API or field is mostly **dropping in updated JSON** (plus any
handler) — not regenerating Python. botocore is a pip package with the JSON bundled
in the wheel; boto3 depends on it. (AWS publishes near-daily model updates.)

---

## Part 2 — The official next-gen SDK: `aws-sdk-python` (v3) + smithy-python

The successor inverts every choice above: **Smithy models → generated, static,
typed Python source**, like `aws-sdk-go-v2` / `aws-sdk-js-v3`. (Profile:
[`aws-sdk-python-v3.md`](aws-sdk-python-v3.md).)

- **Generator + runtime** live in
  [`smithy-lang/smithy-python`](https://github.com/smithy-lang/smithy-python/blob/2472785bbb35ca6a462522791a1e21a0c8ba2acd/README.md):
  a **Java/Gradle** codegen project (`PythonClientCodegenPlugin`,
  `getName() → "python-client-codegen"`, orchestrated by Smithy's
  `DirectedCodegen`; **writer-based** via `PythonWriter extends SymbolWriter`, not
  templates), plus a **hand-written runtime** in `packages/` (`smithy_core`,
  `smithy_http`, `smithy_aws_core`, `aws_sdk_signers`).
- **The published SDK** is
  [`awslabs/aws-sdk-python`](https://github.com/awslabs/aws-sdk-python/blob/bc78957aa97bf324dab6eefd202edfcf09e1d460/README.md):
  **per-service distributed packages** under `clients/` (one pip package per
  service), not one mega-package. Generated files carry
  `# Code generated by smithy-python-codegen DO NOT EDIT.`, and the API model is
  materialized as static `Schema` objects in `_private/schemas.py`.
- **Maturity:** explicitly pre-1.0 — `Development Status :: 2 - Pre-Alpha`; the
  README warns it "should not be used in production systems yet." **boto3 remains
  the production AWS Python SDK.**

---

## Part 3 — Side by side

| | **boto3 / botocore** | **aws-sdk-python (v3) / smithy-python** |
|---|---|---|
| Build model | data-driven, **runtime-interpreted** | **code-generated** from Smithy |
| Source model | C2J `service-2.json` (JSON) | Smithy 2.0 models |
| Per-service source? | **No** — classes built with `type()` at runtime | **Yes** — static generated `client.py`/`models.py` |
| Generator | none (a runtime engine) | Java/Gradle writer-based `smithy-python-codegen` |
| Typing | dynamic (no static method signatures) | **statically typed**, type-checkable |
| Async | sync only (botocore); aiobotocore is third-party | **async-native** |
| Packaging | one botocore mega-package (all services' JSON) | **one pip package per service** |
| Customization | runtime **event/handler** system | compile-time **Smithy integrations** |
| Maturity | **production** (the de-facto AWS Python SDK) | **pre-1.0 / pre-alpha** |
| Same lineage as | `aws-sdk-java-v2` (C2J) | `aws-sdk-go-v2`, `aws-sdk-js-v3` (Smithy) |

The trade-off boto made: **interpreting JSON at runtime** means tiny, uniform code
and trivial "add a service" (drop in JSON) — at the cost of no static types, no
async, and a slower import/first-call (the class is built on demand). The v3 SDK
pays generation/packaging complexity to get typed, async, tree-shakeable
per-service clients.

---

## Why two SDKs, and the broader pattern
boto predates AWS's modern Smithy pipeline; botocore's runtime-interpretation was
the pragmatic way to cover hundreds of services from one shared model format. AWS
has since standardized on **Smithy code generation** for new SDKs (Go v2, JS v3,
Rust, and now Python v3), but migrating the enormous boto3 user base is a long
road — hence the two coexist, with v3 still experimental.

The data-driven approach isn't unique to AWS: **`google-api-python-client`** builds
its service objects at runtime from Discovery Documents the same way (see
[`google-apis-client.md`](google-apis-client.md)). Both are the "interpret a model
at runtime" answer to the same problem the code-generated SDKs solve by emitting
source. See [`README.md`](README.md) for where every SDK in this folder falls on
that spectrum.
