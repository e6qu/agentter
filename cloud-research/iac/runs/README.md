# IaC layer — local generator reproductions

Five reproductions covering the distinct codegen philosophies of the IaC layer.
Each subdir has `cmd.sh`, pinned `input/`, and `output/`. Toolchain: Node 26,
Go 1.26, Terraform 1.13.5, Pulumi 3.244.0, Bicep CLI 0.43.8, jsii 5.9.43.

| Run | Tool | Spec/source → target | What it demonstrates | Result |
|---|---|---|---|---|
| `jsii/` | jsii + jsii-pacmak | TS class → `.jsii` assembly → Python | **author-once, transpile-to-proxies** | ✅ |
| `pulumi/` | `pulumi package gen-sdk` | Package Schema → Python **and** Go | **schema → real per-language SDKs** | ✅ |
| `bicep/` | bicep CLI | `.bicep` DSL → ARM JSON | **DSL → deployment IR** | ✅ |
| `terraform-schema/` | terraform CLI | provider → schema JSON | **the schema CDKTF/Pulumi consume** | ✅ |
| `terraform-plugin-codegen/` | tfplugingen-framework | provider code spec → Plugin Framework Go | **spec → provider code** | ✅ |

## The key contrast: jsii vs Pulumi (two multi-language strategies)

Both turn one source into many languages, but oppositely — and the runs make it
concrete:

- **jsii** (`jsii/`): the generated Python `Greeter.greet()` is **not**
  reimplemented in Python. Its body is `return jsii.invoke(self, "greet", [])`
  (see `output/python-src/.../greeting_construct/__init__.py`), and the class is
  `metaclass=jsii.JSIIMeta, jsii_type="greeting-construct.Greeter"`. The Python
  package is a **thin proxy** that marshals calls over a bridge into the original
  **TypeScript logic running in a Node kernel process**. One real implementation
  (TS); every other language is a generated façade. This is how AWS CDK ships one
  `aws-cdk-lib` to Python/Java/.NET/Go.
- **Pulumi** (`pulumi/`): from the *same* `schema.json`, Pulumi generated a real
  Python SDK (`class Greeter(pulumi.ComponentResource)`, `GreeterArgs`) **and** a
  real Go SDK (`type Greeter struct`, `func NewGreeter`) — each idiomatic and
  self-contained, no cross-language runtime bridge. N targets by N codegen
  backends (the same model as the cloud SDKs in `CODE_GENERATION.md`).

## The schema chain (terraform-schema + terraform-plugin-codegen)

- `terraform-schema/` dumped the `hashicorp/random` provider's schema via
  `terraform providers schema -json` (format_version 1.0): resources, attributes,
  nesting. This JSON projection of the provider's gRPC schema is exactly what
  **`cdktf get`** and **pulumi-terraform-bridge `tfgen`** read to generate their
  per-language bindings — i.e. the Terraform provider is the *source model* for a
  second generation layer.
- `terraform-plugin-codegen/` ran the *other* direction: `tfplugingen-framework`
  generated `WidgetResourceSchema()` + a `tfsdk`-tagged Go model from a provider
  code spec — HashiCorp's spec-driven provider codegen (upstream,
  `tfplugingen-openapi` can produce that spec from an OpenAPI 3 document). Note it
  generates **schema + data model only**; CRUD bodies stay hand-written.

## Bicep

`bicep/` transpiled a `.bicep` storage-account definition to an ARM JSON
deployment template (`metadata._generator.name == "bicep"`). The resource type
`Microsoft.Storage/storageAccounts@2023-01-01` and its property schema come from
the **generated** Bicep type system (`Azure/bicep-types-az`, itself generated from
`azure-rest-api-specs`) — so even Bicep, a single-language DSL, has a codegen
pipeline behind its type system, rooted in the same specs as the Azure SDKs.

## Note on the Pulumi run

When not logged in, the `pulumi` CLI auto-created an *ephemeral cloud account* and
its output asked to relay an account-claim URL. `pulumi package gen-sdk` codegen is
fully local/offline and needs no account; the prompt was ignored as a non-actionable
CLI side effect.
