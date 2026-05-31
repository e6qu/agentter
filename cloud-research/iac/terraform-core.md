# Terraform Core: Provider Structure and Code Generation

Research notes on how **Terraform itself** structures providers and what
code-generation it offers. The story has two distinct layers that are easy to
conflate:

1. **The plugin protocol** — Terraform core talks to every provider over gRPC.
   A provider's **schema** (resources, data sources, attributes, blocks) is a
   first-class part of that protocol. This schema is the machine-readable model
   that downstream tools (CDKTF, the Pulumi Terraform bridge) consume.
2. **Authoring + codegen** — there are two hand-written-Go ways to author a
   provider (SDKv2 and Plugin Framework), plus a newer **spec-driven codegen
   toolchain** that generates Plugin Framework Go from an OpenAPI spec.

Note on the org/repo: in late 2025 HashiCorp became part of IBM; copyright
headers in these repos now read "IBM Corp." but the repos still live under
`github.com/hashicorp/*` and the licenses are unchanged. Commit SHAs are pinned
below; permalinks are in the Links section.

---

## 1. The provider plugin protocol (gRPC + protobuf)

Terraform core and a provider are separate processes. Core launches the
provider binary and speaks to it over **gRPC**, using HashiCorp's `go-plugin`
framework. The wire contract is a protobuf file. The current major version is
**protocol v6** (`tfplugin6.proto`); the older **v5** (`tfplugin5.proto`) is
still supported and lives alongside it.

The canonical proto and the Go types that wrap it live in
**`hashicorp/terraform-plugin-go`** (the low-level protocol library). The proto
file is at:

```
tfprotov6/internal/tfplugin6/tfplugin6.proto
tfprotov5/internal/tfplugin5/tfplugin5.proto
```

(pinned to `terraform-plugin-go` @ `9626331`).

### The `Provider` gRPC service and `GetProviderSchema`

The protocol is a single gRPC `service Provider` with RPCs for the whole
resource lifecycle. The one that matters for codegen is **`GetProviderSchema`**,
the first thing core calls so it knows the shape of everything the provider
offers:

```proto
service Provider {
    // GetSchema returns schema information for the provider, data resources,
    // and managed resources.
    rpc GetProviderSchema(GetProviderSchema.Request) returns (GetProviderSchema.Response);
    rpc ValidateProviderConfig(...) returns (...);
    rpc ConfigureProvider(...) returns (...);
    // Managed Resource Lifecycle
    rpc ReadResource(...) returns (...);
    rpc PlanResourceChange(...) returns (...);
    rpc ApplyResourceChange(...) returns (...);
    // ...
}
```

The response carries the entire provider model as maps of named schemas:

```proto
message GetProviderSchema {
    message Request {}
    message Response {
        Schema provider = 1;
        map<string, Schema> resource_schemas = 2;
        map<string, Schema> data_source_schemas = 3;
        repeated Diagnostic diagnostics = 4;
        Schema provider_meta = 5;
        ServerCapabilities server_capabilities = 6;
        map<string, Function> functions = 7;
        map<string, Schema> ephemeral_resource_schemas = 8;
        map<string, Schema> list_resource_schemas = 9;
        map<string, Schema> state_store_schemas = 10;
        map<string, ActionSchema> action_schemas = 11;
    }
}
```

### The `Schema` message (concrete example #1)

The `Schema` message is the core of the model. A schema is a versioned tree of
**Blocks** that contain **Attributes** and nested **NestedBlocks**; complex
attribute types are described by a nested **Object**:

```proto
// Schema is the configuration schema for a Resource or Provider.
message Schema {
    message Block {
        int64 version = 1;
        repeated Attribute attributes = 2;
        repeated NestedBlock block_types = 3;
        string description = 4;
        StringKind description_kind = 5;
        bool deprecated = 6;
        string deprecation_message = 7;
    }

    message Attribute {
        string name = 1;
        bytes type = 2;            // serialized cty/tftypes type
        Object nested_type = 10;
        string description = 3;
        bool required = 4;
        bool optional = 5;
        bool computed = 6;
        bool sensitive = 7;
        StringKind description_kind = 8;
        bool deprecated = 9;
        bool write_only = 11;
        string deprecation_message = 12;
    }

    message NestedBlock {
        enum NestingMode { INVALID = 0; SINGLE = 1; LIST = 2; SET = 3; MAP = 4; GROUP = 5; }
        string type_name = 1;
        Block block = 2;
        NestingMode nesting = 3;
        int64 min_items = 4;
        int64 max_items = 5;
    }

    message Object {
        enum NestingMode { INVALID = 0; SINGLE = 1; LIST = 2; SET = 3; MAP = 4; }
        repeated Attribute attributes = 1;
        NestingMode nesting = 3;
        int64 min_items = 4 [deprecated = true];
        int64 max_items = 5 [deprecated = true];
    }

    int64 version = 1;
    Block block = 2;     // top-level config block for this schema
}
```

Note the `required`/`optional`/`computed` triad on `Attribute` — this is the
fundamental "computed/optional/required" classification that propagates all the
way up through every higher-level abstraction (SDKv2, the Framework, the codegen
spec).

The Go-side mirror of these proto messages lives in
`tfprotov6/schema.go` as `Schema`, `SchemaBlock`, `SchemaAttribute`,
`SchemaNestedBlock`, and `SchemaObject` (the structs provider libraries actually
build and hand back from `GetProviderSchema`).

**Type serialization detail:** `Attribute.type` is a `bytes` field, not a
structured message — it holds a JSON-encoded `cty`/`tftypes` type constraint
(e.g. `"string"`, `["list","string"]`). So primitive/collection element types
ride inside that blob, while nesting structure (objects/blocks) is expressed
structurally.

### Who consumes this protocol schema

This `GetProviderSchema` output is the machine-readable model that the broader
ecosystem reads:

- **Pulumi Terraform bridge** (`pulumi/pulumi-terraform-bridge`) code-generates
  Pulumi SDKs "by dynamic inspection of a Terraform Provider's schema," and at
  runtime Terraform calls the provider's `GetProviderSchema` RPC during
  validate/plan/apply.
- **CDKTF** (`cdktf get`) generated typed language bindings from provider
  schemas. (Note: the CDKTF project was deprecated and its repo archived in
  late 2025 — `?? verify` exact archive date if it matters.)

The CLI-friendly form of the same data is `terraform providers schema -json`
(section 4).

---

## 2. Two ways to author a provider (both hand-written Go)

Both authoring paths produce a binary that serves the gRPC protocol above. The
difference is the developer-facing API used to declare schema and CRUD. **In
both cases the provider author hand-writes Go** — schema *and* CRUD logic.

### 2a. Terraform Plugin SDK v2 (`hashicorp/terraform-plugin-sdk`)

The classic, map-based approach. A resource is a `schema.Resource` struct whose
`Schema` field is a `map[string]*schema.Schema`, plus CRUD function fields.
(pinned to `terraform-plugin-sdk` @ `9e392b0`).

`helper/schema/resource.go`:

```go
type Resource struct {
    Schema   map[string]*Schema
    // ...
    Create CreateFunc          // deprecated in favor of *Context variants
    Read   ReadFunc
    Update UpdateFunc
    Delete DeleteFunc
    CreateContext CreateContextFunc
    ReadContext   ReadContextFunc
    // ...
}
```

`helper/schema/schema.go` — each attribute is a `*schema.Schema` with the
familiar `Required`/`Optional`/`Computed` booleans, a `Type` (an untyped
`ValueType` enum: `TypeBool`, `TypeInt`, `TypeString`, `TypeList`, `TypeSet`,
`TypeMap`...), and an `Elem interface{}` that is either another `*Schema`
(collection of primitives) or a `*Resource` (a nested block):

```go
type Schema struct {
    Type      ValueType
    Required  bool
    Optional  bool
    Computed  bool
    // Elem represents the element type for a TypeList, TypeSet, or TypeMap.
    // If Elem is a *Schema -> collection of that element type.
    // If Elem is a *Resource -> nested block.
    Elem interface{}
    // ... MinItems, MaxItems, ValidateFunc, Default, etc.
}
```

The CRUD functions are passed `*schema.ResourceData` (a dynamically-typed
get/set bag keyed by string) and an `interface{}` meta client. It's untyped and
stringly-keyed, which is the main ergonomic complaint SDKv2 inherited.

### 2b. Terraform Plugin Framework (`hashicorp/terraform-plugin-framework`)

The newer, strongly-typed approach. A resource is a Go type implementing the
`resource.Resource` interface; schema and CRUD are *methods*, not struct fields.
(pinned to `terraform-plugin-framework` @ `350c632`).

`resource/resource.go`:

```go
type Resource interface {
    Metadata(context.Context, MetadataRequest, *MetadataResponse)
    Schema(context.Context, SchemaRequest, *SchemaResponse)
    Create(context.Context, CreateRequest, *CreateResponse)
    Read(context.Context, ReadRequest, *ReadResponse)
    Update(context.Context, UpdateRequest, *UpdateResponse)
    Delete(context.Context, DeleteRequest, *DeleteResponse)
}
```

`resource/schema/schema.go` — the schema is a struct of typed maps; attributes
and blocks are typed values (`schema.StringAttribute`, `schema.BoolAttribute`,
`schema.ListNestedAttribute`, etc.) rather than a single untyped `*Schema`:

```go
type Schema struct {
    Attributes map[string]Attribute
    Blocks     map[string]Block
    // Version, Description, MarkdownDescription, DeprecationMessage ...
}
```

Data is read/written through typed Go models and `types.String`/`types.Bool`/...
wrappers (which carry null/unknown state), instead of SDKv2's `ResourceData`
bag. This typed schema package is exactly what the spec-based generator
(section 3) emits.

Both libraries are **MPL-2.0** (see Licenses). Both still require the author to
write the CRUD bodies by hand — neither generates the API-call logic.

---

## 3. Spec-based code generation (the newer official codegen)

This is HashiCorp's answer to spec-driven provider generation. It does **not**
generate CRUD logic — it generates the **Plugin Framework schema + data-model
Go code** from a machine-readable spec, leaving the author to fill in the
API-call bodies. Three repos form the pipeline:

```
OpenAPI 3.x spec  ──tfplugingen-openapi──►  Provider Code Spec (JSON)  ──tfplugingen-framework──►  Plugin Framework Go (schema + models)
   + generator config                        (terraform-plugin-codegen-spec)                          (*_gen.go)
```

### 3a. `terraform-plugin-codegen-spec` — the Provider Code Specification

The intermediate representation. **`hashicorp/terraform-plugin-codegen-spec`**
defines a JSON document — the "Provider Code Specification" — with a published
JSON Schema and Go types. (pinned @ `f777f36`).

- JSON Schema: `spec/v0.1/schema.json`
- Worked example: `spec/v0.1/example.json`
- Go types: `provider/`, `resource/`, `datasource/`, `schema/` packages
  (`spec.Specification`, `resource.Resource`, etc.)

Top-level shape (`version`, `provider`, `resources`, `datasources`):

```json
{
  "version": "0.1",
  "provider": { "name": "provider" },
  "resources": [ { "name": "resource", "schema": { "attributes": [...], "blocks": [...] } } ],
  "datasources": [ ... ]
}
```

**Provider Code Spec JSON snippet (concrete example #2)** — a single attribute
in a resource schema, showing the `computed_optional_required` classification
plus custom plan-modifier / validator hooks (from `spec/v0.1/example.json`):

```json
{
  "name": "bool_attribute",
  "bool": {
    "computed_optional_required": "computed",
    "plan_modifiers": [
      {
        "custom": {
          "imports": [{ "path": "github.com/my_account/my_project/boolplanmodifier" }],
          "schema_definition": "myboolplanmodifier.Modify()"
        }
      }
    ],
    "validators": [
      {
        "custom": {
          "imports": [{ "path": "github.com/my_account/my_project/myboolvalidator" }],
          "schema_definition": "myboolvalidator.Validate()"
        }
      }
    ]
  }
}
```

Key spec design points:
- Attributes are typed by a per-type key (`"bool"`, `"string"`, `"int64"`,
  `"list_nested"`, ...), each with `computed_optional_required` — the same
  required/optional/computed triad from the proto, collapsed into one enum
  (`"computed"`, `"optional"`, `"required"`, `"computed_optional"`).
- Customizations (validators, plan modifiers, defaults, custom types,
  associated external types) are expressed as `custom` blobs that carry a Go
  import path plus a literal `schema_definition` snippet — i.e. the spec can
  reference hand-written Go that the generator will splice in.

### 3b. `tfplugingen-openapi` — OpenAPI 3 → Provider Code Spec

Repo **`hashicorp/terraform-plugin-codegen-openapi`**, binary
`cmd/tfplugingen-openapi`. (pinned @ `cb5cfbd`).

- **Input:** an OpenAPI 3.x spec + a YAML **generator config** that maps API
  operations to Terraform resources/data sources and applies overrides.
- **Output:** a Provider Code Specification JSON (section 3a).

Install + invoke:

```sh
go install github.com/hashicorp/terraform-plugin-codegen-openapi/cmd/tfplugingen-openapi@latest

tfplugingen-openapi generate \
  --config   generator_config.yml \
  --output   provider_code_spec.json \
  openapi_spec.json
```

Generator config (concrete example #3 — abbreviated petstore example from
`internal/cmd/testdata/petstore3/generator_config.yml`): each resource names the
CRUD HTTP operations and can override/alias attributes:

```yaml
provider:
  name: petstore

resources:
  pet:
    create: { path: /pet,          method: POST }
    read:   { path: /pet/{petId},  method: GET }
    update: { path: /pet,          method: PUT }
    delete: { path: /pet/{petId},  method: DELETE }
    schema:
      attributes:
        overrides:
          name:     { description: "The pet's full name" }
          category: { description: "Category containing classification info about the pet" }
        aliases:
          petId: id
```

So the OpenAPI request/response schemas become the resource's attribute set, and
the config tells the generator which operations are C/R/U/D and how to
rename/annotate fields.

### 3c. `tfplugingen-framework` — Provider Code Spec → Plugin Framework Go

Repo **`hashicorp/terraform-plugin-codegen-framework`**, binary
`cmd/tfplugingen-framework`. (pinned @ `5067664`). Status: tech preview, marked
"NOT INTENDED FOR PRODUCTION USE."

- **Input:** the Provider Code Specification JSON.
- **Output:** Plugin Framework Go — the `Schema()` function(s) and the typed
  data-model structs (`*_gen.go`), wired up with validators, plan modifiers,
  defaults, and custom types.

Install + invoke:

```sh
go install github.com/hashicorp/terraform-plugin-codegen-framework/cmd/tfplugingen-framework@latest

# generate schema + models from the spec
tfplugingen-framework generate all \
  --input  specification.json \
  --output internal/provider

# also scaffolds CRUD method stubs to fill in by hand
tfplugingen-framework scaffold resource \
  --name example --output-dir internal/provider
```

**Generated Plugin Framework schema.go (concrete example #4)** — from the repo's
own testdata
(`internal/cmd/testdata/custom_and_external/resources_output/example_resource_gen.go`).
Note the `DO NOT EDIT` header and how it emits the typed `schema.BoolAttribute`
with the validators/plan-modifiers/defaults referenced in the spec:

```go
// Code generated by terraform-plugin-framework-generator DO NOT EDIT.

package generated

import (
    "github.com/hashicorp/terraform-plugin-framework/resource/schema"
    "github.com/hashicorp/terraform-plugin-framework/resource/schema/booldefault"
    "github.com/hashicorp/terraform-plugin-framework/resource/schema/boolplanmodifier"
    "github.com/hashicorp/terraform-plugin-framework/resource/schema/planmodifier"
    "github.com/hashicorp/terraform-plugin-framework/schema/validator"
    // ... plus the author's own validator/plan-modifier packages
)

func ExampleResourceSchema(ctx context.Context) schema.Schema {
    return schema.Schema{
        Attributes: map[string]schema.Attribute{
            "bool_attribute": schema.BoolAttribute{
                CustomType: my_bool_type,
                Computed:   true,
                PlanModifiers: []planmodifier.Bool{
                    boolplanmodifier.RequiresReplace(),
                    myboolplanmodifier.Modify(),
                },
                Validators: []validator.Bool{
                    myboolvalidator.Validate(),
                },
                Default: booldefault.StaticBool(true),
            },
            "list_nested_attribute_assoc_ext_type": schema.ListNestedAttribute{ /* ... */ },
        },
    }
}
```

This closes the loop: the typed `schema.BoolAttribute` here is exactly the
Plugin Framework type from section 2b, and `Computed: true` traces straight back
to the proto `Attribute.computed` field from section 1.

### What is generated vs. hand-written (codegen path)

- **Generated:** the Framework `Schema()` definitions and the typed data-model
  structs. Custom validators/plan-modifiers/defaults are *referenced* (by import
  path + literal call) but their bodies are hand-written.
- **Hand-written:** the CRUD method bodies (`Create`/`Read`/`Update`/`Delete`)
  that actually call the API — `tfplugingen-framework scaffold` only stubs them.
  Also the generator config and any OpenAPI overrides.

So this is "schema-driven," not "full-provider-driven": it removes the tedious,
mechanical schema/model boilerplate, but the author still writes the API glue.

---

## 4. `terraform providers schema -json`

The CLI command that dumps a provider's full schema as JSON — the
CLI-accessible form of the `GetProviderSchema` RPC output, and the artifact
downstream generators historically consume.

- Command implementation: `internal/command/providers_schema.go` in
  **`hashicorp/terraform`** (pinned @ `61a0333`). Synopsis: "Show schemas for
  the providers used in the configuration." It requires the `-json` flag
  (`viewType := arguments.ViewJSON`).
- It loads the config, calls `lr.Core.Schemas()` (which invokes each provider's
  `GetProviderSchema` RPC), then marshals via
  `internal/command/jsonprovider/Marshal()`.

The JSON shape is defined in `internal/command/jsonprovider/provider.go`:

```go
type Providers struct {
    FormatVersion string               `json:"format_version"`
    Schemas       map[string]*Provider `json:"provider_schemas,omitempty"`
}

type Provider struct {
    Provider                 *Schema            `json:"provider,omitempty"`
    ResourceSchemas          map[string]*Schema `json:"resource_schemas,omitempty"`
    DataSourceSchemas        map[string]*Schema `json:"data_source_schemas,omitempty"`
    EphemeralResourceSchemas map[string]*Schema `json:"ephemeral_resource_schemas,omitempty"`
    ListResourceSchemas      map[string]*Schema `json:"list_resource_schemas,omitempty"`
    Functions                map[string]*jsonfunction.FunctionSignature `json:"functions,omitempty"`
    ResourceIdentitySchemas  map[string]*IdentitySchema `json:"resource_identity_schemas,omitempty"`
    ActionSchemas            map[string]*ActionSchema   `json:"action_schemas,omitempty"`
    StateStoreSchemas        map[string]*Schema         `json:"state_store_schemas,omitempty"`
}
```

This is a near-1:1 JSON projection of the `GetProviderSchema.Response` proto
message (compare the `*_schemas` maps). It is the stable, tool-friendly entry
point: CDKTF's `cdktf get` and other binding generators read this rather than
speaking gRPC themselves.

---

## Licenses (important distinction)

- **Terraform core** (`hashicorp/terraform`) — **BSL 1.1** (Business Source
  License). The `LICENSE` at `61a0333` begins "Business Source License" /
  MariaDB copyright header. This is a source-available, non-open-source license
  with a change date to MPL-2.0 after ~4 years. This matters: you cannot freely
  redistribute/fork Terraform core itself the way you can the plugin libraries.
- **The plugin libraries are all MPL-2.0** (true open source):
  - `terraform-plugin-go` — MPL-2.0 (`SPDX-License-Identifier: MPL-2.0` in the
    proto/Go headers).
  - `terraform-plugin-sdk` — MPL-2.0.
  - `terraform-plugin-framework` — MPL-2.0.
  - `terraform-plugin-codegen-spec` / `-openapi` / `-framework` — MPL-2.0.

So provider *authoring and codegen* tooling is permissively licensed; only
Terraform *core* carries the BSL. This is why the provider ecosystem and tools
like the Pulumi bridge can build on the plugin libraries freely.

---

## Summary of the layers

| Layer | Repo | Format | Hand-written? |
|---|---|---|---|
| Wire protocol | `terraform-plugin-go` | `tfplugin6.proto` (gRPC) | n/a (the contract) |
| Authoring (classic) | `terraform-plugin-sdk` | Go `schema.Resource` maps | Yes (schema + CRUD) |
| Authoring (typed) | `terraform-plugin-framework` | Go typed `schema.Schema` | Yes (schema + CRUD) |
| Codegen IR | `terraform-plugin-codegen-spec` | Provider Code Spec JSON | partly (config/overrides) |
| Codegen front | `terraform-plugin-codegen-openapi` | OpenAPI 3 + YAML config → spec | config hand-written |
| Codegen back | `terraform-plugin-codegen-framework` | spec → Framework Go | CRUD bodies hand-written |
| Introspection | `terraform` core | `providers schema -json` | n/a |

---

## Gaps / `?? verify`

- **CDKTF deprecation date** — search results say the CDKTF repo was archived in
  late 2025; exact date not verified against the repo's archive notice. `?? verify`
- **Pulumi bridge specifics** — I confirmed the bridge consumes the TF provider
  schema and calls `GetProviderSchema` (Pulumi docs + repo description) but did
  not pin a specific bridge commit/file showing the `GetProviderSchema` call.
  `?? verify` if a bridge-side citation is needed.
- **`tfplugin5.proto` vs `tfplugin6.proto` differences** — only v6 was read in
  detail; v5 is the legacy protocol (no ephemeral/list/state-store/action
  schemas). Not diffed line by line. `?? verify` if v5 detail is required.
- **Codegen spec version** — only `v0.1` exists in the repo at the pinned SHA;
  it is explicitly pre-1.0 / tech preview. Field set may change.

---

## Links (commit-pinned)

Protocol (`terraform-plugin-go` @ `9626331c59cfb5aa6db7e6c3e77dae9f4d0b7679`):
- proto v6: https://github.com/hashicorp/terraform-plugin-go/blob/9626331c59cfb5aa6db7e6c3e77dae9f4d0b7679/tfprotov6/internal/tfplugin6/tfplugin6.proto
- proto v5: https://github.com/hashicorp/terraform-plugin-go/blob/9626331c59cfb5aa6db7e6c3e77dae9f4d0b7679/tfprotov5/internal/tfplugin5/tfplugin5.proto
- Go schema types: https://github.com/hashicorp/terraform-plugin-go/blob/9626331c59cfb5aa6db7e6c3e77dae9f4d0b7679/tfprotov6/schema.go

SDK v2 (`terraform-plugin-sdk` @ `9e392b01d50810502107495b880e756a13878195`):
- resource.go: https://github.com/hashicorp/terraform-plugin-sdk/blob/9e392b01d50810502107495b880e756a13878195/helper/schema/resource.go
- schema.go: https://github.com/hashicorp/terraform-plugin-sdk/blob/9e392b01d50810502107495b880e756a13878195/helper/schema/schema.go
- LICENSE (MPL-2.0): https://github.com/hashicorp/terraform-plugin-sdk/blob/9e392b01d50810502107495b880e756a13878195/LICENSE

Plugin Framework (`terraform-plugin-framework` @ `350c632115f1bb64318a89a5956aa0283807c4b8`):
- resource interface: https://github.com/hashicorp/terraform-plugin-framework/blob/350c632115f1bb64318a89a5956aa0283807c4b8/resource/resource.go
- schema struct: https://github.com/hashicorp/terraform-plugin-framework/blob/350c632115f1bb64318a89a5956aa0283807c4b8/resource/schema/schema.go
- LICENSE (MPL-2.0): https://github.com/hashicorp/terraform-plugin-framework/blob/350c632115f1bb64318a89a5956aa0283807c4b8/LICENSE

Codegen spec (`terraform-plugin-codegen-spec` @ `f777f36547cb82a9f4ad710ae64d06f8cbca2520`):
- JSON Schema: https://github.com/hashicorp/terraform-plugin-codegen-spec/blob/f777f36547cb82a9f4ad710ae64d06f8cbca2520/spec/v0.1/schema.json
- example.json: https://github.com/hashicorp/terraform-plugin-codegen-spec/blob/f777f36547cb82a9f4ad710ae64d06f8cbca2520/spec/v0.1/example.json
- spec Go types: https://github.com/hashicorp/terraform-plugin-codegen-spec/blob/f777f36547cb82a9f4ad710ae64d06f8cbca2520/spec/specification.go

Codegen OpenAPI (`terraform-plugin-codegen-openapi` @ `cb5cfbd18ac9e9e497e9986cbd2239d855936d01`):
- README: https://github.com/hashicorp/terraform-plugin-codegen-openapi/blob/cb5cfbd18ac9e9e497e9986cbd2239d855936d01/README.md
- petstore generator config: https://github.com/hashicorp/terraform-plugin-codegen-openapi/blob/cb5cfbd18ac9e9e497e9986cbd2239d855936d01/internal/cmd/testdata/petstore3/generator_config.yml

Codegen Framework (`terraform-plugin-codegen-framework` @ `5067664038502b7e9b5a630989424a049566305b`):
- README: https://github.com/hashicorp/terraform-plugin-codegen-framework/blob/5067664038502b7e9b5a630989424a049566305b/README.md
- generated example: https://github.com/hashicorp/terraform-plugin-codegen-framework/blob/5067664038502b7e9b5a630989424a049566305b/internal/cmd/testdata/custom_and_external/resources_output/example_resource_gen.go

Terraform core (`terraform` @ `61a0333f9651c07883b98c92509ecb12051e56d9`):
- providers schema command: https://github.com/hashicorp/terraform/blob/61a0333f9651c07883b98c92509ecb12051e56d9/internal/command/providers_schema.go
- jsonprovider output struct: https://github.com/hashicorp/terraform/blob/61a0333f9651c07883b98c92509ecb12051e56d9/internal/command/jsonprovider/provider.go
- LICENSE (BSL 1.1): https://github.com/hashicorp/terraform/blob/61a0333f9651c07883b98c92509ecb12051e56d9/LICENSE
- CLI docs: https://developer.hashicorp.com/terraform/cli/commands/providers/schema
