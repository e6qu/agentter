# Azure Bicep — Build & Type-System Code Generation

How Azure Bicep is built, and — the codegen story — how its Azure resource
**type system** is generated from the *same* `azure-rest-api-specs` source that
feeds the Azure SDKs and AutoRest.

Commit-pinned SHAs used throughout (captured 2026-05-30):

| Repo | Branch | SHA | License |
| --- | --- | --- | --- |
| `Azure/bicep` | main | `0a05ee8a64870e7d929097bc51ece3c7f16d4ca2` | MIT |
| `Azure/bicep-types` | main | `f1de99c672dd23d7e14f2647e38e4f41ee421dee` | MIT |
| `Azure/bicep-types-az` | main | `94edabb1b9de78aa1adb4a8f8231375a73cd2016` | MIT |
| `Azure/terraform-provider-azapi` | main | `efeb3ca3c0dee7d75a1ebde92ae58a7be587715b` | MPL-2.0 |

---

## 1. Bicep the DSL: a single language that transpiles to ARM JSON

Bicep is a **domain-specific language** (its own grammar — `.bicep` files) that
**transpiles to ARM JSON deployment templates**. It is implemented in C#/.NET.
The repo's own language breakdown is ~57% Bicep (the standard library / test
corpus written in the language) and ~39% C# (the compiler), plus a small slice
of TypeScript (the VS Code extension).

### Compile model (Bicep → ARM JSON)

The compiler is a conventional front-end pipeline ending in an ARM-template
emitter, documented in
[`docs/codebase.md`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/docs/codebase.md):

1. **Lexer / Parser** — hand-written recursive-descent parser builds a Bicep
   syntax tree
   ([`Lexer.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Core/Parsing/Lexer.cs),
   [`Parser.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Core/Parsing/Parser.cs)).
2. **Binder** — builds a symbol table
   ([`Binder.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Core/Semantics/Binder.cs)).
3. **Semantic analysis / type checking** — `TypeManager` /
   `TypeAssignmentVisitor` answer type queries and validate assignments
   against the resource type system (described in §2).
4. **Emitter** — [`TemplateEmitter.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Core/Emit/TemplateEmitter.cs)
   "collects all of the information provided by the previous stages … and uses
   it to generate an ARM JSON Template, which can then be submitted to the Azure
   Deployments service."

`bicep build` is the CLI entry that drives this pipeline. From `codebase.md`:
"When `bicep build` is invoked, the compiler pipeline as described above is
invoked through the
[`BuildCommand`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Cli/Commands/BuildCommand.cs),
to parse, analyze, and generate an ARM JSON Template." The CLI entry point is
[`Bicep.Cli/Program.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Cli/Program.cs).
`az`/PowerShell embed Bicep and transpile transparently on deploy.

A reverse path exists too: a **decompiler**
([`TemplateDecompiler.cs`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Decompiler/TemplateDecompiler.cs))
turns an ARM JSON template back into Bicep heuristically.

### Contrast with CDK / Pulumi: NOT multi-language

This is the key architectural difference from AWS CDK, CDKTF, Pulumi, or
cdk8s. Those tools are **multi-language host-SDK projects**: you author
infrastructure in TypeScript / Python / Go / C# / Java, and a per-language
binding layer (jsii for CDK, Pulumi's language SDKs) lowers that to a common IR
(CloudFormation, a Pulumi deployment graph, etc.).

Bicep is the opposite: it is **one purpose-built DSL** with a single compiler.
There is no Python-Bicep or Go-Bicep — you write `.bicep`, full stop. The
"multi-language" surface in the Bicep ecosystem is *not* the authoring language;
it is the **type model serialization** (§2), which is consumed by multiple
host languages (the C# compiler, a Go reimplementation, the azapi Terraform
provider) but is never an authoring language.

### Example: `bicep build` input → ARM JSON

Input Bicep (from the official quickstart, storage account excerpt):

```bicep
@minLength(3)
@maxLength(24)
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
```

`bicep build main.bicep` lowers each `resource` block to an entry in the ARM
template's `resources` array, e.g.:

```json
{
  "type": "Microsoft.Storage/storageAccounts",
  "apiVersion": "2025-06-01",
  "name": "[parameters('storageAccountName')]",
  "location": "[parameters('location')]",
  "sku": { "name": "Standard_LRS" },
  "kind": "StorageV2"
}
```

(The `@minLength`/`@maxLength` decorators and `string` type come from the
generated type system in §2 — the same `{minLength: 3, maxLength: 24,
pattern: "^[a-z0-9]+$"}` constraints on `name` that appear in
`Microsoft.Storage`'s generated `types.md`.) Source for the input:
[quickstart-create-bicep-use-visual-studio-code](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code).
The ARM JSON shape above is the standard ARM resource representation;
`?? verify` an exact byte-for-byte `bicep build` output pair from a checked-in
fixture if a verbatim example is wanted.

---

## 2. The generated type system (the codegen story)

The Bicep compiler does **not** hard-code knowledge of Azure resources. It loads
a generated, serialized **type model**. Two repos produce it:

- **`Azure/bicep-types`** — the *language-agnostic type model* and its
  serialization format (`types.json` / `types.md` / `index.json`), plus loaders.
- **`Azure/bicep-types-az`** — the *Azure resource types*, **generated from
  `Azure/azure-rest-api-specs`** (the same Swagger/OpenAPI — now partly
  TypeSpec — specs that feed the Azure SDKs and AutoRest).

### 2a. `bicep-types`: the type model + serialization

`bicep-types` "exposes a set of tools for generating Bicep types and type
indices, for consumption by the Bicep compiler"
([README](https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/README.md)).

It ships **parallel implementations** of the same model:

- A **TypeScript** library
  ([`src/bicep-types/src/`](https://github.com/Azure/bicep-types/tree/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/bicep-types/src):
  `types.ts`, `indexer.ts`, `writers/`) used by the generator to **write**
  `types.json` / `types.md` / `index.json`.
- A **C#** library `Bicep.Types`
  ([`TypeLoader.cs`](https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/Bicep.Types/TypeLoader.cs))
  used by the Bicep compiler to **load** them — `LoadResourceType`,
  `LoadResourceFunctionType`, etc., reading an embedded `index.json`.
- A **Go** reimplementation
  ([`src/bicep-types-go`](https://github.com/Azure/bicep-types/tree/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/bicep-types-go)).

The model itself is a flat list of typed nodes referenced by index. From
[`types.ts`](https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/bicep-types/src/types.ts):
`BuiltInTypeKind` (Any/Null/Bool/Int/String/Object/Array/ResourceRef), a
`ScopeType` bitflag (Tenant/ManagementGroup/Subscription/ResourceGroup/
Extension), and `ObjectTypePropertyFlags`:

```ts
export enum ObjectTypePropertyFlags {
  None = 0,
  Required = 1 << 0,
  ReadOnly = 1 << 1,
  WriteOnly = 1 << 2,
  DeployTimeConstant = 1 << 3,
  Identifier = 1 << 4
}
```

These flags are exactly the `"flags"` integers seen in generated `types.json`
(e.g. `flags: 10` = `ReadOnly | DeployTimeConstant`; `flags: 9` =
`Required | DeployTimeConstant`).

### 2b. `bicep-types-az`: Azure types generated from `azure-rest-api-specs`

`bicep-types-az` holds "Bicep type definitions for ARM resources" and is
"responsible for ingesting Azure API swagger specifications, and generating the
`Azure.Bicep.Types.Az` package which is bundled with Bicep"
([bicep `docs/codebase.md`](https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/docs/codebase.md)).
It pulls in `bicep-types` as a **git submodule**
([`.gitmodules`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/.gitmodules)).

The README is explicit that the input is azure-rest-api-specs swagger:
"Ensure you have a copy of the
[azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) repo
checked out locally … `npm run generate -- --specs-dir {path to
azure-rest-api-specs}`"
([README](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/README.md)).
**This is the same spec corpus that feeds the Azure SDKs and AutoRest** —
Bicep's Azure type system and the multi-language Azure SDKs share one source of
truth.

#### The generator: a TypeScript tool driving AutoRest

There are two cooperating pieces in `src/`:

1. **`src/generator`** — the orchestrator. Entry point
   [`src/generator/src/cmd/generate.ts`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/generator/src/cmd/generate.ts).
   Its [`package.json`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/generator/package.json)
   names it `@autorest/bicep` and depends on `@autorest/core`,
   `@autorest/modelerfour`, `autorest`, and `bicep-types`. It:
   - walks the specs tree finding every `readme.md`
     (`findReadmePaths(specs/specification)`);
   - parses each readme's `yaml` code blocks to collect the `input-file:`
     swagger lists, bucketing them per **provider + api-version** tag (regex
     `<provider>/…/<yyyy-mm-dd>(-preview)/<file>.json`) — i.e. it reuses the
     **same per-version readme configuration the SDK generators use**;
   - writes a synthetic `readme.bicep.md` and invokes the `autorest` binary
     against the `src/autorest.bicep` extension (`runAutorest`);
   - copies results into `generated/<provider>/...` and finally calls
     `buildTypeIndex` to emit the top-level `index.json` / `index.md`.

2. **`src/autorest.bicep`** — the AutoRest **plugin** that consumes the
   modelerfour code model and emits the bicep types. Its
   [`README.md`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/README.md)
   defines the AutoRest pipeline step (`pipeline: bicep: input:
   modelerfour/identity`). Plugin entry point
   [`src/autorest.bicep/src/main.ts`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/main.ts):
   it starts an AutoRest session over the `CodeModel`, iterates
   `getProviderDefinitions(...)`, then calls `generateTypes` /
   `generateSchema` / `getSampleMarkdown` and `writeTypesJson` / `writeMarkdown`
   (the latter two imported from `bicep-types`). Supporting modules:
   [`type-generator.ts`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/type-generator.ts),
   [`resources.ts`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/resources.ts),
   [`schema-generator.ts`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/schema-generator.ts).

So the pipeline is: **swagger (azure-rest-api-specs) → AutoRest +
modelerfour → autorest.bicep plugin → bicep-types writers → `types.json` /
`types.md` / `samples.md`** per provider/version, then a global `index.json`.

The checked-in output lives in
[`generated/`](https://github.com/Azure/bicep-types-az/tree/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated),
one folder per provider, then per api-version, each with `types.json`,
`types.md`, `samples.md`. Regeneration runs as an "Update Types" GitHub Action
that opens a PR onto an `autogenerate` branch
([README](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/README.md)).

#### Generated type index for a provider — Microsoft.Storage

The global index
([`generated/index.json`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/index.json))
maps every `<type>@<apiVersion>` to a `$ref` into a per-provider `types.json`:

```json
{
  "resources": {
    "Microsoft.Addons/supportProviders/supportPlanTypes@2017-05-15": {
      "$ref": "addons/microsoft.addons/2017-05-15/types.json#/17"
    },
    ...
```

The generated `types.json` is the flat indexed node list. From
[`generated/storage/microsoft.storage/2024-01-01/types.json`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/storage/microsoft.storage/2024-01-01/types.json):

```json
[
  { "$type": "StringLiteralType", "value": "default" },
  { "$type": "StringLiteralType", "value": "Microsoft.Storage/storageAccounts/blobServices" },
  { "$type": "StringType" },
  { "$type": "StringLiteralType", "value": "2024-01-01" },
  {
    "$type": "ObjectType",
    "name": "Microsoft.Storage/storageAccounts/blobServices",
    "properties": {
      "id":         { "type": { "$ref": "#/2" }, "flags": 10, "description": "The resource id" },
      "name":       { "type": { "$ref": "#/0" }, "flags": 9,  "description": "The resource name" },
      "type":       { "type": { "$ref": "#/1" }, "flags": 10, "description": "The resource type" },
      "apiVersion": { "type": { "$ref": "#/3" }, "flags": 10, "description": "The resource api version" }
    }
  }
]
```

The human-readable companion
[`types.md`](https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/storage/microsoft.storage/2024-01-01/types.md)
("# Microsoft.Storage @ 2024-01-01") shows the storage account with its scopes
and the `name` constraint generated from the swagger
(`string {minLength: 3, maxLength: 24, pattern: "^[a-z0-9]+$"} (Required,
DeployTimeConstant)`) — i.e. exactly the type metadata the Bicep compiler uses
for IntelliSense and validation in §1's example.

The C# `TypeLoader` in `bicep-types` reads the embedded `index.json` and these
`types.json` files at compile time
([`TypeLoader.cs`](https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/Bicep.Types/TypeLoader.cs)),
and the whole `bicep-types-az` output is shipped to the compiler as the
[`Azure.Bicep.Types.Az`](https://www.nuget.org/packages/Azure.Bicep.Types.Az)
NuGet package, "bundled with Bicep."

---

## 3. azapi relationship (cross-reference)

`Azure/terraform-provider-azapi` is a Terraform provider that lets users declare
*any* Azure resource by its raw ARM `type@apiVersion` (rather than the curated
`azurerm` schema). To do that it needs the same Azure type knowledge — and it
**reuses the bicep type model and the bicep-types-az output**:

- It vendors generated type folders under
  [`internal/azure/generated/<provider>/...`](https://github.com/Azure/terraform-provider-azapi/tree/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/generated),
  structured identically to bicep-types-az's `generated/`.
- It has a Go reimplementation of the type model and loader:
  [`internal/azure/types/`](https://github.com/Azure/terraform-provider-azapi/tree/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/types),
  [`index.go`](https://github.com/Azure/terraform-provider-azapi/blob/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/index.go)
  (with `ResourceType` / `ResourceFunctionType` mirroring the bicep model),
  [`loader.go`](https://github.com/Azure/terraform-provider-azapi/blob/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/loader.go).
- Its CHANGELOG tracks "Update bicep types to
  `https://github.com/ms-henglu/bicep-types-az/commit/<sha>`" entries
  ([CHANGELOG.md](https://github.com/Azure/terraform-provider-azapi/blob/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/CHANGELOG.md)) —
  i.e. it syncs from a mirror of bicep-types-az.

So **azapi and Bicep consume the same generated Azure type definitions** (same
ultimate source: `azure-rest-api-specs` → bicep-types-az), just loaded by a Go
runtime instead of the C# Bicep compiler. azapi is MPL-2.0 (vs Bicep's MIT).

---

## 4. ARM as the substrate

ARM (Azure Resource Manager) JSON deployment templates are the **deployment IR**
that everything in this story targets:

- **Bicep** transpiles *to* ARM JSON (§1); the emitted template is what is sent
  to the Azure Deployments service.
- The **type system** that Bicep, and azapi, validate against is literally a
  serialized description of **ARM resource types** (provider /
  `type@apiVersion` / properties / scopes), generated from the ARM REST API
  swagger in `azure-rest-api-specs`.
- **Terraform `azurerm`** is a partial, hand-curated mapping onto the same ARM
  resource providers (it calls the ARM REST APIs), and **`azapi`** is the
  generic escape hatch that exposes ARM types directly — both ultimately drive
  ARM. `?? verify` the precise degree to which `azurerm` derives schema from
  ARM specs vs. hand-authored Go (azurerm is largely hand-written against the
  Azure SDK for Go; only azapi consumes the generated ARM type model directly).

Net: ARM templates are the common lowering target, and the ARM REST specs are
the common type source — Bicep is one front-end DSL over that substrate, azapi
is another consumer of the same generated types, and the Azure SDKs are
generated from the same specs by AutoRest/TypeSpec.

---

## Gaps / `?? verify`

- A verbatim, byte-for-byte `bicep build` input/output fixture pair from a
  checked-in test in `Azure/bicep` (the ARM JSON in §1 is the standard ARM
  resource shape, assembled from the docs' Bicep input, not copied from a single
  fixture file).
- Public adoption status of TypeSpec for the providers whose bicep types are
  generated (bicep-types-az still drives generation off swagger `readme.md`
  `input-file` lists; whether TypeSpec-origin providers are first emitted to
  swagger then consumed, or fed via a TypeSpec path, is not confirmed here).
- Exact extent of `azurerm` schema derivation from ARM specs vs hand-authored Go
  (noted inline in §4).

---

## Links

### Azure/bicep (DSL + compiler) @ `0a05ee8a64870e7d929097bc51ece3c7f16d4ca2` — MIT
- https://github.com/Azure/bicep
- docs/codebase.md: https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/docs/codebase.md
- TemplateEmitter.cs: https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Core/Emit/TemplateEmitter.cs
- BuildCommand.cs: https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Cli/Commands/BuildCommand.cs
- Bicep.Cli/Program.cs: https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Cli/Program.cs
- TemplateDecompiler.cs: https://github.com/Azure/bicep/blob/0a05ee8a64870e7d929097bc51ece3c7f16d4ca2/src/Bicep.Decompiler/TemplateDecompiler.cs

### Azure/bicep-types (type model + serialization) @ `f1de99c672dd23d7e14f2647e38e4f41ee421dee` — MIT
- https://github.com/Azure/bicep-types
- README.md: https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/README.md
- src/bicep-types/src/types.ts: https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/bicep-types/src/types.ts
- src/Bicep.Types/TypeLoader.cs: https://github.com/Azure/bicep-types/blob/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/Bicep.Types/TypeLoader.cs
- src/bicep-types-go: https://github.com/Azure/bicep-types/tree/f1de99c672dd23d7e14f2647e38e4f41ee421dee/src/bicep-types-go

### Azure/bicep-types-az (Azure types, generated) @ `94edabb1b9de78aa1adb4a8f8231375a73cd2016` — MIT
- https://github.com/Azure/bicep-types-az
- README.md: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/README.md
- .gitmodules (bicep-types submodule): https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/.gitmodules
- generator entry generate.ts: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/generator/src/cmd/generate.ts
- generator package.json: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/generator/package.json
- autorest.bicep README: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/README.md
- autorest.bicep main.ts: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/main.ts
- autorest.bicep type-generator.ts: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/src/autorest.bicep/src/type-generator.ts
- generated/index.json: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/index.json
- Microsoft.Storage types.json: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/storage/microsoft.storage/2024-01-01/types.json
- Microsoft.Storage types.md: https://github.com/Azure/bicep-types-az/blob/94edabb1b9de78aa1adb4a8f8231375a73cd2016/generated/storage/microsoft.storage/2024-01-01/types.md
- Azure.Bicep.Types.Az NuGet: https://www.nuget.org/packages/Azure.Bicep.Types.Az

### Azure/terraform-provider-azapi @ `efeb3ca3c0dee7d75a1ebde92ae58a7be587715b` — MPL-2.0
- https://github.com/Azure/terraform-provider-azapi
- internal/azure/generated: https://github.com/Azure/terraform-provider-azapi/tree/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/generated
- internal/azure/index.go: https://github.com/Azure/terraform-provider-azapi/blob/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/index.go
- internal/azure/types: https://github.com/Azure/terraform-provider-azapi/tree/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/internal/azure/types
- CHANGELOG.md: https://github.com/Azure/terraform-provider-azapi/blob/efeb3ca3c0dee7d75a1ebde92ae58a7be587715b/CHANGELOG.md

### Spec source (shared with SDKs)
- Azure/azure-rest-api-specs: https://github.com/Azure/azure-rest-api-specs

### Docs
- Bicep overview: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview
- bicep build quickstart (input example): https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/quickstart-create-bicep-use-visual-studio-code
