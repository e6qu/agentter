# Pulumi: Multi-language SDK Code Generation

Pulumi differs from both jsii and the traditional cloud-vendor SDK pipelines.
Where AWS CDK / jsii author SDKs **once** (in TypeScript) and *transpile* the
single source to every language, Pulumi defines a language-neutral **Package
Schema** (an IDL) and runs a **separate, hand-written code generator per target
language** that reads that schema and emits an *idiomatic*, native SDK. There is
no single "source SDK" that is transpiled; every language SDK is generated from
the schema. All five first-party language generators are themselves written in
**Go**.

The whole stack is collectively branded "Pulumi CrossCode," which covers three
output categories from the same schema + IR: SDKs (`sdkgen`), programs
(`programgen`, PCL/HCL2 conversion), and docs (`docsgen`).
([codegen README](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/README.md#L1-L23))

All repositories examined here are licensed **Apache-2.0** (verified via the
GitHub API for `pulumi/pulumi`, `pulumi-java`, `pulumi-terraform-bridge`,
`pulumi-aws`, `pulumi-dotnet`, `pulumi-azure-native`, `pulumi-google-native`,
`pulumi-yaml`).

Commit pins used throughout:

| Repo | Commit |
|------|--------|
| `pulumi/pulumi` | `979eed35363d9047e092a1e3c59bbfa28c7103a4` |
| `pulumi/pulumi-java` | `b4d6735000821b88134f90325e28d43a3415a5c1` |
| `pulumi/pulumi-dotnet` | `0ec9ac3f7b8c458e24b6dec1fefc2c64377314c3` |
| `pulumi/pulumi-terraform-bridge` | `15fe56807bdd30d0c03fc1d394ecb33445694718` |
| `pulumi/pulumi-aws` | `f0e90c4722b549b5e4a1a06438660f096f9e4e9f` |
| `pulumi/pulumi-azure-native` | `f0746b7101b9c07b4e354c8dfddf3f3ff74a2415` |
| `pulumi/pulumi-google-native` | `3000d16840aa1b22936f48beb16bec6afb05a6bf` |

---

## 1. The Pulumi Package Schema (the IDL analogue)

The IDL is the **Pulumi Package Schema**: a single JSON document
(`schema.json`) describing one provider's `config`, `types`, `resources`,
`functions`, and `provider`. It is *the* input to SDK code generation for every
language. The schema package's own README states this plainly:

> This package defines Pulumi Schema, a language-neutral specification for cloud
> resource models. Pulumi Schema is the interface definition language for all
> Pulumi Packages, and is used as the input to SDK code generation for each
> supported Pulumi language.
> ([schema README](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/README.md#L1-L9))

### Where it lives

- The **metaschema** (a JSON-Schema describing the schema format itself) is
  `pkg/codegen/schema/pulumi.json`, titled *"Pulumi Package Metaschema"*.
  ([pulumi.json L1-L6](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L1-L6))
- The Go binding layer (the in-memory model + loader + binder) is
  `pkg/codegen/schema/schema.go` (`type Package`, `type Resource`, the
  marshalled `type PackageSpec`) plus `bind.go` and `loader.go`.
  ([schema.go: `type Package` L607, `type Resource` L388, `type PackageSpec` L2282](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/schema.go#L607))

### Top-level structure

The package object's properties (from the metaschema):

- `name`, `displayName`, `version` (semver), `description`, `namespace`,
  `repository`, `license`, `pluginDownloadURL`, `publisher`
  ([L7-L65](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L7-L65))
- `config` — package configuration variables
  ([L82-L102](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L82-L102))
- `types` — map from *type token* → `complexTypeSpec` (object / enum types)
  ([L103-L112](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L103-L112))
- `resources` — map from token → `resourceSpec`
  ([L163-L172](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L163-L172))
- `functions` — map from token → `functionSpec`
  ([L173-L182](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L173-L182))
- `provider` — the provider resource itself
  ([L159-L162](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L159-L162))
- `language` — a free-form object holding **per-language overrides**
  (this is the customization hook surfaced to generators)
  ([L183-L186](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L183-L186))

Everything is addressed by a **type token** of the form
`pkg:module:Member` (e.g. `aws:acmpca/certificateAuthority:CertificateAuthority`).
The token pattern is defined in the metaschema's `$defs.token`.
([token L207-L212](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L207-L212))

### `resourceSpec`

A resource carries `inputProperties`, `requiredInputs`, `stateInputs`,
`properties` (outputs, inherited via `objectTypeSpec`), `aliases`,
`deprecationMessage`, `isComponent`, `methods`, and `isOverlay` (the marker
that says "implementation is hand-written out-of-band, do not generate it").
([resourceSpec L567-L637](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L567-L637))

### `typeSpec` — the type-reference grammar

Type references are a `oneOf` over: Primitive (`boolean`/`integer`/`number`/
`string`), Array (`type: array` + `items`), Map (`type: object` +
`additionalProperties`), Named (`$ref` to a token or built-in like
`pulumi.json#/Archive`, `pulumi.json#/Asset`, `pulumi.json#/Any`), and Union
(`oneOf` + optional `discriminator`). A `plain` flag marks inputs that do not
accept eventual/`Output` values.
([typeSpec L252-L381](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L252-L381))

### Concrete schema snippet

From the **generated** `pulumi-aws` schema (the resource we trace below), the
input property `permanentDeletionTimeInDays` of
`aws:acmpca/certificateAuthority:CertificateAuthority`:

```json
"permanentDeletionTimeInDays": {
  "type": "integer",
  "description": "Number of days to make a CA restorable after it has been deleted, must be between 7 to 30 days, with default to 30 days.\n"
}
```
(extracted from
[`provider/cmd/pulumi-resource-aws/schema.json`](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/cmd/pulumi-resource-aws/schema.json),
a ~large generated file; the resource token is
`aws:acmpca/certificateAuthority:CertificateAuthority`.)

---

## 2. Per-language code generators (one per language, all in Go)

Each target language has its own generator that consumes a bound
`schema.Package` and returns a `map[path][]byte` of files. The canonical
entrypoint is `func GeneratePackage(...)` in each language's `gen.go`:

| Language | Repo / path | Entrypoint |
|----------|-------------|-----------|
| Go | `pulumi/pulumi` `pkg/codegen/go/gen.go` | `func GeneratePackage` ([L4781](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/go/gen.go#L4781)) |
| Python | `pulumi/pulumi` `pkg/codegen/python/gen.go` | `func GeneratePackage` ([L3272](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/python/gen.go#L3272)) |
| Node.js | `pulumi/pulumi` `pkg/codegen/nodejs/gen.go` | `func GeneratePackage` ([L2898](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/nodejs/gen.go#L2898)) |
| .NET | `pulumi/pulumi-dotnet` `pulumi-language-dotnet/codegen/gen.go` | `func GeneratePackage` ([L2668](https://github.com/pulumi/pulumi-dotnet/blob/0ec9ac3f7b8c458e24b6dec1fefc2c64377314c3/pulumi-language-dotnet/codegen/gen.go#L2668)) |
| Java | `pulumi/pulumi-java` `pkg/codegen/java/gen.go` | `func GeneratePackage` ([L2237](https://github.com/pulumi/pulumi-java/blob/b4d6735000821b88134f90325e28d43a3415a5c1/pkg/codegen/java/gen.go#L2237)) |

Two important structural facts:

1. **.NET and Java codegen are written in Go**, even though they emit C#/Java.
   The `.go` files declare `package dotnet` / `package java`. .NET codegen was
   moved out of `pulumi/pulumi` into the `pulumi-dotnet` repo (there is no
   longer a `pkg/codegen/dotnet` in `pulumi/pulumi`); Java has always lived in
   the separate `pulumi-java` repo. Go/Python/Node.js codegen remain in
   `pulumi/pulumi` itself.
   ([java/gen.go `package java` L4](https://github.com/pulumi/pulumi-java/blob/b4d6735000821b88134f90325e28d43a3415a5c1/pkg/codegen/java/gen.go#L4),
   [dotnet/gen.go `package dotnet` L19](https://github.com/pulumi/pulumi-dotnet/blob/0ec9ac3f7b8c458e24b6dec1fefc2c64377314c3/pulumi-language-dotnet/codegen/gen.go#L19))

2. Each generator reads per-language overrides out of the schema's `language`
   bag. e.g. the Go generator pulls `GoPackageInfo` from
   `pkg.Language["go"]` (import base path, module paths, etc.) at the top of
   `GeneratePackage`.
   ([go/gen.go L4781-L4801](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/go/gen.go#L4781-L4801))

### Generated-SDK example (Go)

`pulumi-aws`'s generated Go SDK file for the resource above starts with the
canonical do-not-edit banner naming the generator (the *language host*, see
§3), then renders an idiomatic Go resource:

```go
// Code generated by pulumi-language-go DO NOT EDIT.
// *** WARNING: Do not edit by hand unless you're certain you know what you are doing! ***

package acmpca
...
func main() {
    pulumi.Run(func(ctx *pulumi.Context) error {
        _, err := acmpca.NewCertificateAuthority(ctx, "example", &acmpca.CertificateAuthorityArgs{
            ...
            PermanentDeletionTimeInDays: pulumi.Int(7),
        })
```
([sdk/go/aws/acmpca/certificateAuthority.go L1-L45](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/sdk/go/aws/acmpca/certificateAuthority.go#L1-L45))

Note `PermanentDeletionTimeInDays` is typed `pulumi.Int` — directly traceable to
the `"type": "integer"` in the schema snippet in §1. Parallel generated trees
exist under `sdk/{go,python,nodejs,dotnet,java}/` in the same repo.

### Contrast with jsii

jsii (used by AWS CDK / `constructs`) authors one TypeScript library and
*transpiles/binds* it into other languages via a runtime kernel and a `.jsii`
type manifest. Pulumi does the opposite: there is **no shared source library**;
the Package Schema is the only shared artifact, and five independent Go-written
generators each emit fully native, standalone SDKs. The output is not a thin
wrapper over a JS process — generated Go/Python/etc. code talks to the provider
plugin over Pulumi's own gRPC protocol, not to a transpiled core.

---

## 3. `pulumi package gen-sdk` and the `pulumi-language-*` hosts

The CLI command that turns a schema into published SDKs is
**`pulumi package gen-sdk <schema-source> [--language nodejs|python|go|dotnet|java|all]`**.
([package_gen_sdk.go: command def L40-L132](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packagecmd/package_gen_sdk.go#L40-L132))

Flow:

1. `<schema-source>` can be a registry package name, a plugin binary, or a
   folder; the command resolves it to a schema via `SchemaFromSchemaSource`,
   then binds it with `BindSpec` into a `schema.Package`.
   ([L54-L92](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packagecmd/package_gen_sdk.go#L54-L92))
2. For `--language all` it iterates `dotnet, go, java, nodejs, python`, calling
   `packages.GenSDK` for each.
   ([L95-L107](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packagecmd/package_gen_sdk.go#L95-L107))
3. `packages.GenSDK` marshals the bound package to JSON and dispatches over
   **gRPC to the language host plugin** for that language —
   `pCtx.Host.LanguageRuntime(language)` → `languagePlugin.GeneratePackage(...)`.
   ([packages.go: `GenSDK` L154, `LanguageRuntime` L191, RPC `GeneratePackage` L204](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packages/packages.go#L154-L210))

The **language host** is a separate binary per language
(`pulumi-language-go`, `pulumi-language-nodejs`, `pulumi-language-python`,
`pulumi-language-dotnet`, …). Its gRPC `GeneratePackage` handler simply calls
the in-process Go `codegen.GeneratePackage` from §2. Examples:

- `pulumi-language-go`: host `GeneratePackage` ([main.go L1492](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/go/pulumi-language-go/main.go#L1492)) → `codegen.GeneratePackage("pulumi-language-go", pkg, …)` ([L1523](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/go/pulumi-language-go/main.go#L1523))
- `pulumi-language-nodejs`: host `GeneratePackage` ([main.go L1845](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/nodejs/cmd/pulumi-language-nodejs/main.go#L1845)) → `codegen.GeneratePackage(...)` ([L1873](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/nodejs/cmd/pulumi-language-nodejs/main.go#L1873))

This is why the generated Go file's banner reads
`Code generated by pulumi-language-go` — the host binary, not the bare codegen
package, is the entity that ran. The `Code generated by … DO NOT EDIT` marker
is standard across languages.

### Pulumi YAML as a target

PCL (Pulumi Configuration Language, `pkg/codegen/pcl`) is the shared program IR;
the codegen stack also produces/consumes **programs**, not just SDKs
([codegen README L9-L12](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/README.md#L9-L12)).
Pulumi YAML is a first-class program language: its language host /
program-converter lives in its **own repo `pulumi/pulumi-yaml`** (Apache-2.0,
HEAD `540ebfb339e14aa74cf8772d0ad66fd528a95f27`). YAML programs consume the same
Package Schemas; there is no separately-generated "YAML SDK" — the schema is read
at runtime / convert time. `?? verify` — exact YAML codegen entrypoint file in
`pulumi-yaml` not pinned here; flagged in DO_NEXT.

---

## 4. pulumi-terraform-bridge: most cloud providers are bridged

The majority of Pulumi's cloud providers — **`pulumi-aws`, `pulumi-gcp`,
`pulumi-azure` (classic), and ~hundreds of others** — are **not hand-authored
schemas**. They are **bridged from the corresponding Terraform provider**: the
bridge dynamically introspects the upstream Terraform provider's schema and
**emits a standard Pulumi Package Schema**, after which the ordinary §2/§3
codegen produces the SDKs. The bridge README:

> At build-time, we code-generate packages by dynamic inspection of a Terraform
> Provider's schema. … the bridge connects the Pulumi engine to a given
> Terraform Provider using Pulumi's RPC interfaces.
> ([bridge README L33-L41](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/README.md#L33-L41))

### Bridge → Pulumi Package Schema

The bridge's schema emitter `genPulumiSchema` / `genPackageSpec` builds a
`pschema.PackageSpec` — importing the *exact same*
`github.com/pulumi/pulumi/pkg/v3/codegen/schema` package described in §1:

```go
pschema "github.com/pulumi/pulumi/pkg/v3/codegen/schema"
...
func genPulumiSchema(...) (pschema.PackageSpec, error) { ... }
func (g *schemaGenerator) genPackageSpec(pack *pkg, sink diag.Sink) (pschema.PackageSpec, error) {
    spec := pschema.PackageSpec{
        ...
        Resources: map[string]pschema.ResourceSpec{},
        Functions: map[string]pschema.FunctionSpec{},
```
([generate_schema.go: import L38, `genPulumiSchema` L231-L234, `genPackageSpec` L271-L283](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate_schema.go#L231-L283))

### tfgen entrypoint

The bridge code generator is **`tfgen`**, exposed as
`tfgen.Main(pkg, version, prov tfbridge.ProviderInfo)`. It validates the
upstream TF provider, builds a `Generator`, and runs `g.Generate()`.
([tfgen/main.go: `func Main` L34-L53](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/main.go#L34-L53))

Crucially, `tfgen`'s SDK step does **not** re-implement language codegen — for
each language it shells out to **`pulumi package gen-sdk --language <l>`**
(the §3 path) via `runPulumiPackageGenSDK`, writing the emitted schema to a
temp `schema.json` first:

```go
args := []string{"package", "gen-sdk", "--language", string(l), "--out", outDir}
```
([generate.go: `runPulumiPackageGenSDK` L163-…](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate.go#L163-L195),
per-language dispatch for Go/NodeJS/Python/CSharp/Java
[L222-L304](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate.go#L222-L304))

So the bridge's only special job is **TF schema → Pulumi Package Schema**;
everything downstream is the standard, shared pipeline.

### Concrete bridged provider: `pulumi-aws`

The bridge per-provider entrypoint binary is `pulumi-tfgen-<name>`. For AWS:

```go
import aws "github.com/pulumi/pulumi-aws/provider/v7"
func main() {
    info := aws.ProviderFromMeta(tfbridge.NewProviderMetadata(locateMetadata()))
    ...
    pftfgen.MainWithMuxer("aws", *info)
}
```
([pulumi-aws `provider/cmd/pulumi-tfgen-aws/main.go`](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/cmd/pulumi-tfgen-aws/main.go))

The `ProviderInfo` wires the upstream Terraform provider (the SDKv2 +
Plugin-Framework muxed `terraform-provider-aws` from `hashicorp`) and the
mappings:

```go
prov := tfbridge.ProviderInfo{
    P:          p,             // shim over terraform-provider-aws schema
    Name:       "aws",
    License:    "Apache-2.0",
    Repository: "https://github.com/pulumi/pulumi-aws",
    GitHubOrg:  "hashicorp",   // upstream TF provider org
    ...
}
```
([pulumi-aws `provider/resources.go` `ProviderFromMeta` L906-L935](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/resources.go#L906-L935);
`GitHubOrg: "hashicorp"` L930)

And a representative **resource mapping** (TF type → Pulumi token), including the
one we traced through schema and Go SDK:

```go
"aws_acmpca_certificate_authority": {Tok: awsResource(acmpcaMod, "CertificateAuthority")},
```
([pulumi-aws `provider/resources.go` L985](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/resources.go#L985))

So: TF resource `aws_acmpca_certificate_authority` → Pulumi token
`aws:acmpca/certificateAuthority:CertificateAuthority` → schema entry → generated
`acmpca.CertificateAuthority` in every language SDK. End to end.

### Native (non-bridged) providers

Some providers are **native**, generated from cloud vendor API specs directly
(no Terraform involved), but still producing the **same Pulumi Package Schema**:

- **`pulumi-azure-native`** — generated from the **Azure Resource Manager
  OpenAPI specs** (`Azure/azure-rest-api-specs`). The generator
  `provider/pkg/gen/schema.go` builds a `pschema.PackageSpec` via
  `func PulumiSchema(...)`.
  ([azure-native `provider/pkg/gen/schema.go` `PulumiSchema` L80, `pkg := pschema.PackageSpec{` L81](https://github.com/pulumi/pulumi-azure-native/blob/f0746b7101b9c07b4e354c8dfddf3f3ff74a2415/provider/pkg/gen/schema.go#L80-L81);
  README: "This provider uses the Azure Resource Manager REST API directly"
  [README L8-L11](https://github.com/pulumi/pulumi-azure-native/blob/f0746b7101b9c07b4e354c8dfddf3f3ff74a2415/README.md#L8-L11))

- **`pulumi-google-native`** — generated from **Google API Discovery
  documents** (`google.golang.org/api/discovery/v1`). Same pattern:
  `func PulumiSchema() (*schema.PackageSpec, ...)`.
  ([google-native `provider/pkg/gen/schema.go` `PulumiSchema` L44-L45, discovery import L38](https://github.com/pulumi/pulumi-google-native/blob/3000d16840aa1b22936f48beb16bec6afb05a6bf/provider/pkg/gen/schema.go#L38-L45);
  generator `provider/pkg/gen/discovery.go`)

In all cases (bridged or native) the **boundary is the Pulumi Package Schema**;
downstream SDK gen is identical.

---

## 5. How customization / overrides are expressed

### Bridge `ProviderInfo` mappings (`tfbridge`)

`tfbridge.ProviderInfo` is a type alias for `info.Provider`:

```go
type ProviderInfo = info.Provider
```
([pkg/tfbridge/info.go L73-L76](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfbridge/info.go#L73-L76))

`info.Provider` is the central override surface. Key fields:
- `P shim.Provider` — the upstream TF provider schema shim (introspection source)
- `Resources map[string]*Resource`, `DataSources map[string]*DataSource` — TF
  type → Pulumi mapping/overrides
- `ExtraResources`, `ExtraTypes`, `ExtraFunctions` — inject schema not present
  upstream (`pschema.ResourceSpec`/`ComplexTypeSpec`/`FunctionSpec`)
- per-language overlay structs `JavaScript`, `Python`, `Golang`, `CSharp`,
  `Java` — language-specific naming/overlay augmentation
- package metadata: `Name`, `GitHubOrg`, `License`, `Version`, etc.
  ([info.go `type Provider struct` L48-L135](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfbridge/info/info.go#L48-L135))

Per-resource override (`info.Resource`): `Tok` (rename the Pulumi token),
`Fields map[string]*Schema` (per-property overrides), `Docs`, `Aliases`,
`DeprecationMessage`, `CSharpName`, and transform hooks (`TransformOutputs`,
`TransformFromState`, `ComputeID`, …).
([info.go `type Resource struct` L378-L420](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfbridge/info/info.go#L378-L420))

Per-field override (`info.Schema`): `Name`/`CSharpName` (rename), `Type`
(retype to a token), `Elem`, `Default`, and the classic
**`MaxItemsOne *bool`** — the flag that flattens a TF "list-with-one-item" into a
single Pulumi value (one of the most common bridge corrections).
([info.go `type Schema struct` L484-L529, `MaxItemsOne` L529](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfbridge/info/info.go#L484-L529))

These mappings are authored by hand in each bridged provider's
`provider/resources.go` (see the `pulumi-aws` examples above), and `tfgen`
consumes them while emitting the Pulumi Package Schema. `tfgen` also exposes
`GenerateSchema(info, sink) (pschema.PackageSpec, error)` for callers that want
just the schema.
([generate.go `GenerateSchema` L885](https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate.go#L885))

### Schema-level customization (native providers and generally)

- The schema's `language` bag (top-level and per-property/type/resource)
  carries per-language generator hints; each `GeneratePackage` reads its own key
  (`pkg.Language["go"]` → `GoPackageInfo`, etc.).
- `isOverlay: true` on a resource/type tells codegen *not* to generate the
  implementation; the package author supplies a hand-written file out-of-band
  (Pulumi's equivalent of a hand-written shim).
  ([pulumi.json `isOverlay` L632-L635](https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json#L632-L635))
- Native providers additionally post-process the emitted schema (e.g.
  `pulumi-aws` sets a `SchemaPostProcessor` to rewrite WAFv2 recursive types
  even though it is itself bridged —
  [pulumi-tfgen-aws/main.go](https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/cmd/pulumi-tfgen-aws/main.go)).

---

## Summary

- **IDL:** the Pulumi **Package Schema** (`schema.json`), spec'd by the
  metaschema `pkg/codegen/schema/pulumi.json` and modeled in
  `pkg/codegen/schema/schema.go`. Tokens of the form `pkg:module:Member` address
  resources/types/functions.
- **Generators:** five independent, **Go-written** generators
  (`func GeneratePackage` in Go/Python/Node.js in `pulumi/pulumi`, .NET in
  `pulumi-dotnet`, Java in `pulumi-java`) each emit a fully idiomatic native SDK.
  Unlike jsii, **nothing is transpiled** — the schema is the only shared
  artifact.
- **Pipeline:** `pulumi package gen-sdk --language <l>` binds the schema and
  dispatches over gRPC to a per-language host (`pulumi-language-*`) whose
  `GeneratePackage` RPC calls the Go codegen. Pulumi YAML is a program target
  (own repo `pulumi/pulumi-yaml`) consuming the same schemas.
- **Bridge:** most cloud providers (`pulumi-aws`, `pulumi-gcp`, `pulumi-azure`)
  are **bridged from Terraform providers** via `pulumi-terraform-bridge`'s
  `tfgen`, which introspects the upstream TF schema, applies `ProviderInfo`
  mappings, and emits a standard Pulumi Package Schema — then calls the same
  `pulumi package gen-sdk` path. Native providers (`pulumi-azure-native` from
  Azure OpenAPI, `pulumi-google-native` from Google Discovery docs) emit the same
  schema by other means.
- **Overrides:** authored in `ProviderInfo`/`info.Provider`
  (`Resources`/`DataSources`/`Fields`/`MaxItemsOne`/`Tok`/`Extra*`/per-language
  overlays) for bridged providers; via the schema `language` bag and
  `isOverlay` for hand-written shims generally.
- **Licenses:** all repos Apache-2.0.

### Gaps / `?? verify`
- Exact YAML codegen/convert entrypoint file in `pulumi/pulumi-yaml` not pinned
  (only repo HEAD + license confirmed). Added to DO_NEXT.
- `pulumi-gcp` / `pulumi-azure` (classic) bridging asserted by analogy to
  `pulumi-aws` (same bridge, same `tfgen` Main); their individual
  `resources.go`/`GitHubOrg` not separately pinned here.
- The §3 claim that tfgen's per-language SDK step is *exactly* `gen-sdk` is
  verified via `runPulumiPackageGenSDK` shelling `package gen-sdk`; the binary it
  invokes (`pulumi` on PATH vs. embedded) was not traced further.

---

## Links

- Pulumi codegen README: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/README.md
- Pulumi schema README: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/README.md
- Package Metaschema (`pulumi.json`): https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/pulumi.json
- Schema Go model (`schema.go`): https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/schema/schema.go
- Go generator: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/go/gen.go#L4781
- Python generator: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/python/gen.go#L3272
- Node.js generator: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/codegen/nodejs/gen.go#L2898
- .NET generator (pulumi-dotnet): https://github.com/pulumi/pulumi-dotnet/blob/0ec9ac3f7b8c458e24b6dec1fefc2c64377314c3/pulumi-language-dotnet/codegen/gen.go#L2668
- Java generator (pulumi-java): https://github.com/pulumi/pulumi-java/blob/b4d6735000821b88134f90325e28d43a3415a5c1/pkg/codegen/java/gen.go#L2237
- `gen-sdk` command: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packagecmd/package_gen_sdk.go
- `packages.GenSDK` (gRPC dispatch): https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/pkg/cmd/pulumi/packages/packages.go#L154
- pulumi-language-go host: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/go/pulumi-language-go/main.go#L1492
- pulumi-language-nodejs host: https://github.com/pulumi/pulumi/blob/979eed35363d9047e092a1e3c59bbfa28c7103a4/sdk/nodejs/cmd/pulumi-language-nodejs/main.go#L1845
- Terraform bridge README: https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/README.md
- Bridge schema emitter (`generate_schema.go`): https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate_schema.go#L231
- Bridge tfgen Main: https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/main.go#L34
- Bridge `runPulumiPackageGenSDK`: https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfgen/generate.go#L163
- Bridge `ProviderInfo`/`info.Provider`: https://github.com/pulumi/pulumi-terraform-bridge/blob/15fe56807bdd30d0c03fc1d394ecb33445694718/pkg/tfbridge/info/info.go#L48
- pulumi-aws tfgen entrypoint: https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/cmd/pulumi-tfgen-aws/main.go
- pulumi-aws ProviderInfo / resource mappings: https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/resources.go#L906
- pulumi-aws generated Go resource: https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/sdk/go/aws/acmpca/certificateAuthority.go
- pulumi-aws generated schema.json: https://github.com/pulumi/pulumi-aws/blob/f0e90c4722b549b5e4a1a06438660f096f9e4e9f/provider/cmd/pulumi-resource-aws/schema.json
- pulumi-azure-native schema generator: https://github.com/pulumi/pulumi-azure-native/blob/f0746b7101b9c07b4e354c8dfddf3f3ff74a2415/provider/pkg/gen/schema.go#L80
- pulumi-google-native schema generator: https://github.com/pulumi/pulumi-google-native/blob/3000d16840aa1b22936f48beb16bec6afb05a6bf/provider/pkg/gen/schema.go#L44
