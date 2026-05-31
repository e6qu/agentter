# The jsii-based CDK family: multi-language binding generation

Research date: 2026-05-30. All SHAs pinned at time of research. Every
non-trivial claim links to a commit-pinned permalink (`/blob/<sha>/...`)
verified against actual file contents with `gh api` / WebFetch.

Pinned commit SHAs used below:

- `aws/jsii` @ `e14cd30cbf62a271d7dfc97154e77d84071e7024` (Apache-2.0)
- `aws/aws-cdk` @ `32009391675de97b2394435b687f33b97b914cc3` (Apache-2.0)
- `cdklabs/awscdk-service-spec` @ `a99a3d0c98d9b2f13311f09eb102d7b38bb21be3` (Apache-2.0)
- `hashicorp/terraform-cdk` @ `a0c56138e2b4c7b6c128bd7ba08a8e317df852af` (MPL-2.0)
- `cdk8s-team/cdk8s` @ `44a1917416985a569af996f575e57f97d57f5dd4` (Apache-2.0)
- `cdk8s-team/cdk8s-cli` @ `76e5409f3a772268980c69774f8a9895c9cd52a7` (Apache-2.0)

---

## TL;DR

The "CDK family" (AWS CDK, CDK for Terraform, cdk8s) shares a single
multi-language engine: **jsii**. The pattern is always the same:

1. **Author the library once in TypeScript** using a jsii-compatible subset of
   the language.
2. The **jsii compiler** type-checks the TS and emits a language-agnostic type
   model — the **`.jsii` assembly** (a JSON document describing only the public
   API surface, no implementation).
3. **`jsii-pacmak`** ("package maker") reads the `.jsii` assembly and emits
   idiomatic packages for **Python, Java, .NET, and Go** (plus the JS package
   itself).
4. At runtime, the generated bindings are thin **proxies**: they do not
   reimplement the logic. They spawn a Node.js child process (the jsii
   **kernel / runtime**) that hosts the original JavaScript, and marshal
   method calls / property accesses over a STDIN/STDOUT protocol.

The three CDKs differ only in **where the TypeScript constructs come from**:

| Tool | Spec source | TS generator | jsii role |
|---|---|---|---|
| AWS CDK (`aws-cdk-lib` L1s) | CloudFormation resource schemas, normalized in `cdklabs/awscdk-service-spec` | `@aws-cdk/spec2cdk` (`gen-cdk` bin) | `aws-cdk-lib` is authored in TS, published to all langs via jsii/pacmak |
| CDK for Terraform | Terraform **provider schemas** (`terraform providers schema -json`) | `@cdktf/provider-generator` (`cdktf get`) | runs `jsii` + `jsii-pacmak --code-only` on generated TS |
| cdk8s | Kubernetes **OpenAPI** + **CRD `openAPIV3Schema`** | `cdk8s-cli` `import` command | runs `jsii-srcmak` (jsii + pacmak wrapper) on generated TS |

---

## 1. jsii itself (`aws/jsii`)

### 1.1 The core idea: write TS once, the assembly carries the type model

The jsii spec's own introduction states the mechanism plainly: the `jsii`
compiler processes TypeScript and produces both JavaScript output and a *jsii
Assembly* document — "a specific representation of the API exported by the
TypeScript module" containing **only API signatures, not implementation**.
`jsii-pacmak` then generates language-specific bindings from the Assembly for
C#, Java, Python, and Go.

- Introduction / architecture:
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/gh-pages/content/specification/1-introduction.md

### 1.2 The `.jsii` assembly format

The assembly schema is defined in the **`@jsii/spec`** package. Its README
describes it as "the JSON specification for `.jsii` metadata files."

- README:
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/README.md

The TypeScript definitions of the format live in `src/assembly.ts`. Verified
line numbers:

- `export interface Assembly` — line 18:
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/assembly.ts#L18
- `SchemaVersion.LATEST = 'jsii/0.10.0'` — line 247–248 (with a comment that the
  value can never change for back-compat):
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/assembly.ts#L247-L248
- `Type = TypeBase & (ClassType | EnumType | InterfaceType)` — line 864; the
  three type kinds are defined at `ClassType` L928, `InterfaceType` L979,
  `EnumType` L1033:
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/assembly.ts#L864

Key top-level `Assembly` fields (verified against `assembly.ts` /
`configuration.ts`):

- `schema` — always `"jsii/0.10.0"`.
- `name`, `version`, `description`, `license` (SPDX), `author`, `repository`,
  `homepage`.
- `fingerprint` (L95) — a hash used to detect whether the API spec changed.
- `jsiiVersion` (L107) — the compiler version that produced the assembly.
- `dependencies` / `dependencyClosure` — other assemblies this one depends on.
- `types` — every exported type, indexed by **fully-qualified name** (FQN). Each
  type is a `class`, `interface`, or `enum`, carrying `properties`, `methods`,
  `base`/`interfaces`, `docs`, `locationInModule`, `symbolId`.
- `targets` — a map of target-language → packaging coordinates "used when
  generating packages for various languages."

The per-language `targets` coordinates are defined in `configuration.ts`
(`AssemblyTargets` at L300):

- Java: `package`, `maven.groupId`, `maven.artifactId`.
- Python: `module` ("name of generated Python module ... used by users in import
  directives") and `distName` ("the PyPI distribution name").
- .NET: `namespace` ("root namespace under which types will be declared") and
  `packageId` ("identifier of the package in the NuGet registry").
- (Go and JS/npm targets also exist; `??` verify exact field names for Go's
  `moduleName`/`packageName` in `configuration.ts` — not directly read.)

Source:
https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/configuration.ts#L300

#### Illustrative `.jsii` assembly shape

`.jsii` files are produced at build time and are gitignored (e.g. AWS CDK
ignores `*.generated.*` and `*.d.ts`, and likewise emits `.jsii` only at
build), so a committed sample is not in these repos. Based on the verified
schema, an assembly looks like:

```jsonc
{
  "schema": "jsii/0.10.0",
  "name": "my-lib",
  "version": "1.2.3",
  "license": "Apache-2.0",
  "jsiiVersion": "5.x.x (build ...)",
  "fingerprint": "…base64 hash…",
  "targets": {
    "python": { "distName": "my-lib", "module": "my_lib" },
    "java":   { "package": "com.example.mylib",
                "maven": { "groupId": "com.example", "artifactId": "my-lib" } },
    "dotnet": { "namespace": "Example.MyLib", "packageId": "Example.MyLib" }
  },
  "dependencies": { "constructs": "^10.0.0" },
  "types": {
    "my-lib.Greeter": {
      "kind": "class",
      "fqn": "my-lib.Greeter",
      "assembly": "my-lib",
      "name": "Greeter",
      "initializer": { "parameters": [ /* … */ ] },
      "methods": [ { "name": "greet", "returns": { "type": { "primitive": "string" } } } ]
    }
  }
}
```

### 1.3 The runtime (kernel) bridge model

Generated non-JS bindings do not reimplement logic; they are proxies that talk
to the original JavaScript hosted in a Node process.

- The **kernel** (`@jsii/kernel`) "provides the basic interaction API that allows
  language-specific proxy objects to interact with the javascript objects they
  represent."
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/kernel/README.md
- The **runtime** (`@jsii/runtime`) is "the JavaScript runtime host." Its README
  is explicit about the bridge: "the jsii client spawns the `@jsii/runtime` as a
  **child process** and instructs it to load the javascript module into a node.js
  VM. Then, any interaction with proxy classes, such as getting/setting
  properties or invoking methods is transmitted via a simple **STDIN/STDOUT
  protocol** to the actual object hosted within the VM."
  https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/runtime/README.md

So a Python/Java/.NET/Go CDK app is, at runtime, a host process that drives a
hidden Node.js process running the real construct code. This is why the Node.js
runtime is a hard dependency of every CDK app regardless of language.

### 1.4 `jsii-pacmak`: the package maker

`jsii-pacmak` consumes the assembly and emits one package per target language.
The target registry (`TargetName` enum and `ALL_BUILDERS`) enumerates exactly
five targets — `dotnet`, `go`, `java`, `js`, `python`:

https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/jsii-pacmak/lib/targets/index.ts#L16-L37

Each target is a file under `lib/targets/` (`python.ts`, `java.ts`,
`dotnet.ts`, `go.ts`, `js.ts`):
https://github.com/aws/jsii/tree/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/jsii-pacmak/lib/targets

### 1.5 Constraints: the "jsii-compatible subset" of TypeScript

Because the type model must map cleanly onto Java/C#/Python/Go, jsii accepts
only a subset of TypeScript. From the type-system spec
(`2-type-system.md`):
https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/gh-pages/content/specification/2-type-system.md

- **Primitives only**: `boolean`, `number`, `string`, `Date`, `enum`, `void`,
  and `any`/`unknown` (collapsed to a single `Any`). **Not supported**: tuples,
  `bigint`, `symbol`, `never`. Arrays and maps are allowed.
- **Two flavors of interface**:
  - **Behavioral interfaces**, named with an `I` prefix (`ISomething`) — classic
    OO interfaces that classes implement and that may extend other behavioral
    interfaces.
  - **Structs** (data interfaces), named *without* the prefix (`SomethingProps`)
    — they "cannot declare any method: they must be kept behavior-free," and "all
    properties declared by a struct must be `readonly`." Structs are the
    idiomatic "options object" passed as the final constructor/method parameter
    (this is what becomes keyword args in Python, a builder in Java, etc.).
- **No method overloads.** Overridden methods/properties "must retain the exact
  same type signature."
- **Type unions** are discouraged (most statically typed targets have no
  equivalent); **type intersections** are restricted (only between behavioral
  interfaces, input position only).
- **No generics** (only the built-in collection generics), no dynamic
  properties; `Promise` is allowed only as an async method return type, not as a
  parameter/property type.

These constraints are why every CDK API looks the way it does (e.g.
`new s3.Bucket(this, 'B', { versioned: true })` — a positional `scope`/`id`
plus a trailing `*Props` struct).

---

## 2. AWS CDK (`aws/aws-cdk`) — generated L1 vs hand-written L2/L3

### 2.1 The L1 / L2 / L3 layering

- **L1 (`Cfn*`) constructs** are a 1:1 mechanical mapping of CloudFormation
  resource types (e.g. `CfnBucket` ⇄ `AWS::S3::Bucket`). They are **generated**.
- **L2 constructs** (e.g. `s3.Bucket`) are **hand-written** higher-level
  abstractions with sane defaults, grants, helper methods, etc. They wrap the
  L1s.
- **L3 constructs / patterns** are hand-written compositions of multiple L2s.

You can see the split inside a single module: `aws-cdk-lib/aws-s3/lib/` ships
hand-authored `bucket.ts`, `bucket-policy.ts`, `bucket-grants.ts`, etc., while
the L1 `CfnBucket` lands in a generated `*.generated.ts` file that is **not
committed** (gitignored):
- module source:
  https://github.com/aws/aws-cdk/tree/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/aws-s3/lib
- `.gitignore` ignoring `*.generated.*` (and `*.d.ts`):
  https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/.gitignore

### 2.2 The L1 generator: `@aws-cdk/spec2cdk` (modern) replacing `cfn2ts`

The current generator is **`@aws-cdk/spec2cdk`**, living in the aws-cdk
monorepo at `tools/@aws-cdk/spec2cdk`. Its README says it "Generates AWS CDK
L1s in TypeScript from `@aws-cdk/aws-service-spec`," and it explicitly provides
a **drop-in replacement for the legacy `@aws-cdk/cfn2ts`** (you can import
`@aws-cdk/spec2cdk/lib/cfn2ts`):
https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/README.md

The old `@aws-cdk/cfnspec` package is now a tombstone README pointing at the
new spec:
> "This package has been replaced by a more modern version. Please use
> `@aws-cdk/aws-service-spec` (source: cdklabs/awscdk-service-spec) instead."

https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/%40aws-cdk/cfnspec/README.md

**Generation entrypoint.** `aws-cdk-lib`'s `package.json` defines
`"gen": "gen-cdk"`, i.e. the L1s are produced by the `gen-cdk` binary from
spec2cdk:
https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/package.json#L14

`gen-cdk.ts` calls `generateAll(...)`:
https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/bin/gen-cdk.ts#L1-L33

`generate.ts` loads the spec database via `loadAwsServiceSpec()` from
`@aws-cdk/aws-service-spec` and renders TypeScript with `@cdklabs/typewriter`
(a code-emitting AST library — note this is **not** a string-template engine):
https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/lib/generate.ts#L1-L11

**What the generated `CfnBucket` looks like.** The class that emits each L1 is
`ResourceClass` in `lib/cdk/resource-class.ts`. Verified facts: it produces a
class that `extends CDK_CORE.CfnResource` (L105), and emits the static
type-guard helper (the file even documents the `CfnBucket` example):

```ts
// from resource-class.ts (paraphrasing the documented example):
// public static isCfnBucket(x: any): x is CfnBucket {
//   return CfnResource.isCfnResource(x)
//     && x.cfnResourceType === CfnBucket.CFN_RESOURCE_TYPE_NAME;
// }
```

https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/lib/cdk/resource-class.ts#L105

The generated `CfnBucket` therefore carries `CFN_RESOURCE_TYPE_NAME =
"AWS::S3::Bucket"`, a `CfnBucketProps` struct, CFN property
producers/parsers (`makeCfnProducer`/`makeCfnParser`, L255–256), and
`isCfnBucket`.

### 2.3 Where the CloudFormation spec comes from

The spec source of truth is the **`cdklabs/awscdk-service-spec`** repo (the
`@aws-cdk/aws-service-spec` package), described as "the source of truth for CDK
code generation" — a typed database built by importing and normalizing several
upstream sources:
https://github.com/cdklabs/awscdk-service-spec/blob/a99a3d0c98d9b2f13311f09eb102d7b38bb21be3/README.md

Verified inputs (from that README), in import order: the legacy **CloudFormation
Resource Specification** (frozen at 144.0.0), the **SAM** spec (GoFormation),
hand-written patches, the newer **CloudFormation Registry resource-provider
schemas**, the SAM JSON schema, coded patches, and the weekly **CloudFormation
documentation** JSON, plus stateful-resource classifications, canned metrics,
and augmentations. The repo's two relevant packages:

- `@aws-cdk/service-spec-importers` — "import spec from data sources, transform
  into the db format."
- `@aws-cdk/aws-service-spec` — ships "the actual db file" that spec2cdk loads.

So the modern flow is: upstream CFN registry/spec/docs → importers →
`aws-service-spec` db → `spec2cdk`/`gen-cdk` → `*.generated.ts` L1s.

### 2.4 `aws-cdk-lib` authored in TS, published to all languages via jsii

`aws-cdk-lib` is itself a jsii library. Each service submodule carries a
`.jsiirc.json` that supplies the per-language package coordinates jsii needs —
e.g. `aws-s3/.jsiirc.json`:

```json
{ "targets": {
    "java":   { "package":   "software.amazon.awscdk.services.s3" },
    "dotnet": { "namespace": "Amazon.CDK.AWS.S3" },
    "python": { "module":    "aws_cdk.aws_s3" } } }
```

https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/aws-s3/.jsiirc.json

Both the generated L1s and the hand-written L2/L3s are plain (jsii-compatible)
TypeScript; jsii + pacmak then publish the whole of `aws-cdk-lib` to PyPI
(`aws-cdk-lib`), Maven (`software.amazon.awscdk`), NuGet (`Amazon.CDK.Lib`),
and Go. The author writes TS; the four other languages are generated.

---

## 3. CDK for Terraform (`hashicorp/terraform-cdk`) and cdk8s

Both reuse jsii at *binding-generation* time: they generate TypeScript
constructs from a non-AWS schema, then hand that TS to jsii + pacmak to produce
the user's chosen language.

### 3.1 CDKTF: `cdktf get` from Terraform provider schemas

The CLI command is `cdktf get`, described as "Generate CDK Constructs for
Terraform providers and modules." Note the help text for `--parallel`: it only
applies "for languages that are not Typescript (**translated by JSII**)":
https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/cdktf-cli/src/bin/cmds/get.ts#L13-L40

**Schema acquisition.** `@cdktf/provider-schema` obtains the schema by writing a
minimal `main.tf.json`, then shelling out to the real Terraform CLI:
`terraform init` followed by `terraform providers schema -json` (and
`terraform version -json`), parsing the JSON result:
https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-schema/src/provider-schema.ts#L176-L215

**TS construct generation.** `TerraformProviderGenerator` takes that
`ProviderSchema` and, via a `ResourceParser` + `ResourceEmitter`/`StructEmitter`,
emits TypeScript construct classes (each resource → a construct extending
`TerraformResource`, each nested block → a `*Config`/`*OutputReference` struct):
https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-generator/lib/get/generator/provider-generator.ts#L85-L96

**jsii hand-off.** `constructs-maker.ts` is where jsii enters. It resolves the
`jsii` and `jsii-pacmak` binaries, runs `jsii` to compile the generated TS and
extract the `.jsii` assembly, then runs `jsii-pacmak --code-only` to emit
Python/Java/.NET/Go bindings:
https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-generator/lib/get/constructs-maker.ts#L24-L25

Verified key lines:
- `const pacmakModule = require.resolve("jsii-pacmak/bin/jsii-pacmak");` /
  `const jsiiModule = require.resolve("jsii/bin/jsii");` (L24–25)
- runs jsii: `await exec(jsiiModule, jsiiArgs, ...)` (L181)
- copies the assembly: `await fs.copy(path.join(staging, ".jsii"), ...)` (L188)
- runs pacmak: `await exec(pacmakModule, ["--code-only"], { cwd: staging });`
  (L193)

So for a TypeScript project `cdktf get` only generates TS; for any other
language it additionally runs jsii + pacmak.

### 3.2 cdk8s: `cdk8s import` from Kubernetes/CRD OpenAPI

The construct-import logic lives in the **`cdk8s-team/cdk8s-cli`** repo (the
`cdk8s` CLI), separate from the core `cdk8s` library repo. The command is
`cdk8s import [SPEC]`, "Imports API objects to your app by generating
constructs," accepting `k8s`, a `crd.yaml`, a URL, or `github:org/repo`:
https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/cli/cmds/import.ts#L13-L21

**Input schemas.**
- *Kubernetes core API* (`import/k8s.ts`): reads the Kubernetes **OpenAPI/swagger
  `_definitions.json`** (`schema.definitions`, fed to a `TypeGenerator` via
  `$ref: #/definitions/...`). The schema is fetched from the cdk8s repo's
  versioned `kubernetes-schemas/` directory:
  https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/k8s.ts#L64-L93
  (schemas live at e.g.
  https://github.com/cdk8s-team/cdk8s/tree/44a1917416985a569af996f575e57f97d57f5dd4/kubernetes-schemas )
- *CRDs* (`import/crd.ts`): reads each CRD's
  `spec.versions[].schema.openAPIV3Schema` (or the legacy
  `spec.validation.openAPIV3Schema`) and feeds it to `json2jsii`'s
  `TypeGenerator`:
  https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/crd.ts#L27-L69

**jsii hand-off.** The shared `ImportBase` abstract class declares
`generateTypeScript(...)` (implemented by `k8s.ts`/`crd.ts`) and then runs
**`jsii-srcmak`** — a thin wrapper that compiles the generated TS with jsii and
runs pacmak — to emit Python/Java/Go from the same TS:
https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/base.ts#L40-L135

Verified: `import * as srcmak from 'jsii-srcmak'` (L4); for non-TS targets it
builds `srcmak.Options` with `python`/`java`/`go` blocks and an optional `jsii`
output path (L102–135). For TypeScript it just emits the generated TS directly.

**Core cdk8s library.** Like `aws-cdk-lib`, the core `cdk8s` construct library
is authored in TypeScript and published to multiple languages via jsii (the
published `cdk8s` npm package ships to PyPI/Maven/Go). The repo is managed by
projen (`Cdk8sTeamTypeScriptProject` in `.projenrc.ts`), which synthesizes the
jsii `package.json` stanza at build time — so the committed `package.json` has
no `jsii` block:
https://github.com/cdk8s-team/cdk8s/blob/44a1917416985a569af996f575e57f97d57f5dd4/.projenrc.ts#L13
(`?? verify` the exact projen construct that injects the jsii multi-language
publish targets — `Cdk8sTeamTypeScriptProject` is defined in the external
`@cdk8s/projen-common` package, not read here.)

---

## Summary

- jsii is one engine reused by all three CDKs: **author in a TypeScript subset
  → emit the `.jsii` assembly (type model, no impl) → `jsii-pacmak` generates
  Python/Java/.NET/Go → at runtime the bindings proxy into a Node.js kernel
  child process over STDIN/STDOUT.**
- The CDKs differ only in the **upstream spec** feeding the TypeScript:
  - AWS CDK L1s ← CloudFormation registry/spec/docs (normalized in
    `cdklabs/awscdk-service-spec`), generated by `@aws-cdk/spec2cdk`
    (`gen-cdk`), with L2/L3 hand-written; the whole `aws-cdk-lib` is jsii-built.
  - CDKTF ← Terraform `providers schema -json`, generated by
    `@cdktf/provider-generator` and run through `jsii` + `jsii-pacmak
    --code-only` by `constructs-maker.ts`.
  - cdk8s ← Kubernetes OpenAPI `_definitions.json` and CRD `openAPIV3Schema`,
    generated by `cdk8s-cli`'s `import` command and run through `jsii-srcmak`.
- Licenses: jsii, aws-cdk, awscdk-service-spec, cdk8s, cdk8s-cli are all
  **Apache-2.0**; terraform-cdk is **MPL-2.0**.

### Gaps / `?? verify`

- Exact Go (`moduleName`/`packageName`) and JS/npm field names in jsii's
  `configuration.ts` `AssemblyTargets` were not directly read (only Java,
  Python, .NET fields verified).
- No committed `.jsii` assembly or committed generated `CfnBucket.generated.ts`
  exists in these repos (both are build artifacts / gitignored); the snippets
  above are reconstructed from the verified schema and generator source rather
  than copied from a checked-in file.
- The precise projen construct/workflow that configures cdk8s's multi-language
  jsii publish targets lives in an external `@cdk8s/projen-common` package, not
  inspected here.

---

## Links

### jsii (`aws/jsii` @ `e14cd30…`, Apache-2.0)
- Introduction / architecture spec: https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/gh-pages/content/specification/1-introduction.md
- Type-system spec (jsii-compatible subset): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/gh-pages/content/specification/2-type-system.md
- `@jsii/spec` README: https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/README.md
- Assembly schema (`assembly.ts`): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/assembly.ts#L18
- `SchemaVersion = jsii/0.10.0`: https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/assembly.ts#L247-L248
- Target config (`configuration.ts`, `AssemblyTargets`): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/spec/src/configuration.ts#L300
- Kernel README (proxy interaction API): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/kernel/README.md
- Runtime README (child process + STDIN/STDOUT): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/%40jsii/runtime/README.md
- pacmak targets (`TargetName`, `ALL_BUILDERS`): https://github.com/aws/jsii/blob/e14cd30cbf62a271d7dfc97154e77d84071e7024/packages/jsii-pacmak/lib/targets/index.ts#L16-L37

### AWS CDK (`aws/aws-cdk` @ `3200939…`, Apache-2.0)
- spec2cdk README (cfn2ts replacement): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/README.md
- `gen-cdk` entrypoint (`generateAll`): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/bin/gen-cdk.ts#L1-L33
- `generate.ts` (`loadAwsServiceSpec` + typewriter): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/lib/generate.ts#L1-L11
- `ResourceClass` (emits `CfnResource` subclasses, `isCfnBucket`): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/tools/%40aws-cdk/spec2cdk/lib/cdk/resource-class.ts#L105
- `aws-cdk-lib` `gen` script: https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/package.json#L14
- `aws-cdk-lib` `.gitignore` (`*.generated.*`): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/.gitignore
- `aws-s3/.jsiirc.json` (per-module jsii targets): https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/aws-cdk-lib/aws-s3/.jsiirc.json
- `@aws-cdk/cfnspec` tombstone README: https://github.com/aws/aws-cdk/blob/32009391675de97b2394435b687f33b97b914cc3/packages/%40aws-cdk/cfnspec/README.md

### awscdk-service-spec (`cdklabs/awscdk-service-spec` @ `a99a3d0…`, Apache-2.0)
- README (source of truth + upstream inputs): https://github.com/cdklabs/awscdk-service-spec/blob/a99a3d0c98d9b2f13311f09eb102d7b38bb21be3/README.md

### CDK for Terraform (`hashicorp/terraform-cdk` @ `a0c5613…`, MPL-2.0)
- `cdktf get` CLI command: https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/cdktf-cli/src/bin/cmds/get.ts#L13-L40
- provider schema via `terraform providers schema -json`: https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-schema/src/provider-schema.ts#L176-L215
- `TerraformProviderGenerator` (schema → TS constructs): https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-generator/lib/get/generator/provider-generator.ts#L85-L96
- `constructs-maker.ts` (runs `jsii` + `jsii-pacmak --code-only`): https://github.com/hashicorp/terraform-cdk/blob/a0c56138e2b4c7b6c128bd7ba08a8e317df852af/packages/%40cdktf/provider-generator/lib/get/constructs-maker.ts#L24-L25

### cdk8s (`cdk8s-team/cdk8s` @ `44a1917…` and `cdk8s-team/cdk8s-cli` @ `76e5409…`, Apache-2.0)
- `cdk8s import` CLI command: https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/cli/cmds/import.ts#L13-L21
- `ImportBase` (runs `jsii-srcmak`): https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/base.ts#L40-L135
- k8s OpenAPI import (`schema.definitions`): https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/k8s.ts#L64-L93
- CRD import (`openAPIV3Schema`): https://github.com/cdk8s-team/cdk8s-cli/blob/76e5409f3a772268980c69774f8a9895c9cd52a7/src/import/crd.ts#L27-L69
- versioned Kubernetes schemas dir: https://github.com/cdk8s-team/cdk8s/tree/44a1917416985a569af996f575e57f97d57f5dd4/kubernetes-schemas
- core cdk8s projen config: https://github.com/cdk8s-team/cdk8s/blob/44a1917416985a569af996f575e57f97d57f5dd4/.projenrc.ts#L13
