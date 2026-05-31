# Azure SDK Code Generation — Raw Research Notes

Research date: 2026-05-30. All permalinks pinned to the commit SHAs captured below.

**Pinned SHAs (HEAD at research time):**
- `Azure/azure-rest-api-specs` @ `0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96`
- `Azure/autorest` @ `69fa4acb21d0c9275df3a09c398bb2ca2191a12c`
- `Azure/autorest.python` @ `28a5851a2a370d70b5661278f4b7a7d22d236919`
- `Azure/autorest.go` @ `cedbfc541d4af3af0fed5fbbfb04b07be6adc9d9`
- `Azure/autorest.java` @ `38268ebd8043657e91e43e94d01a5d5df97824e0`
- `Azure/autorest.typescript` @ `ffd258b12699f9996917596299e319092876a4ef`
- `microsoft/typespec` @ `8d9f7f7f3e4679bcf60f121df5582f3f162d4298`
- `Azure/typespec-azure` @ `d0d2d7c83897ad72314d55ebae0dcbc28e62ee61`
- `Azure/azure-sdk-for-python` @ `ff6370fda6d53389c143a781ffe8b7c3221d3580`
- `Azure/azure-sdk-for-go` @ `e542d7a5b3b684f928a04ae23ee2cd45f8f57260`
- `Azure/azure-sdk-for-java` @ `309bcdbc7a62b949efbb16331280b28fd9eb7d63`
- `Azure/azure-sdk-for-js` @ `39edf9562a7adbd1383a124cb55ed9ada844b0e2`

All twelve repos are **MIT-licensed** (verified via `gh api repos/<repo> --jq .license.spdx_id`).

**Headline finding — the platform is mid-migration:** AutoRest is *deprecated* and slated to retire **July 1, 2026**; TypeSpec is the official successor. As of this snapshot the Azure SDK pipeline runs **two parallel codegen stacks**: legacy AutoRest (OpenAPI 2.0/Swagger → per-language plugin) and the new TypeSpec stack (`.tsp` → emitter). Many flagship services already have TypeSpec specs *in the repo* but still **ship AutoRest-generated code** because the per-language emitter has not been switched on for them yet (see case studies). This dual state is the single most important thing to capture.

---

## 1. Service description / IDL

### Legacy: OpenAPI 2.0 (Swagger) in `Azure/azure-rest-api-specs`
- The canonical spec repo is `Azure/azure-rest-api-specs`. Specs live under `specification/<service>/{resource-manager,data-plane}/...`. Top-level layout confirmed via the repo tree (`specification/`, `eng/`, `documentation/`, `profile(s)/`, `specificationRepositoryConfiguration.json`).
- Historically these were **hand-authored Swagger JSON** (`*.json`) organized by API version under `stable/<version>/` and `preview/<version>/`, with an AutoRest config `readme.md` per spec folder.
- Example (Blob, legacy): `specification/storage/data-plane/Microsoft.BlobStorage/{stable,preview}/<version>/blob.json` + `readme.md`.
  - Permalink: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/data-plane/Microsoft.BlobStorage/readme.md

### New: TypeSpec (`microsoft/typespec` language; `Azure/typespec-azure` libraries)
- TypeSpec is a DSL (`.tsp`) from which OpenAPI is generated. Per the spec repo's own docs, **"the TypeSpec specification serves as the source to generate corresponding OpenAPI 2.0 (swagger) API documentation"** — unidirectional TypeSpec → OpenAPI.
  - Source: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Getting-started-with-TypeSpec-specifications.md
- A TypeSpec service folder contains: `main.tsp` (the service definition), `models.tsp`, `routes.tsp`, `client.tsp` (client/SDK customizations), `tspconfig.yaml` (emitter config), `examples/`. Verified on Blob: https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage
- **OpenAPI is emitted from TypeSpec** by `@azure-tools/typespec-autorest` (one of the configured emitters). E.g. Blob's `tspconfig.yaml` emits `data-plane/Microsoft.BlobStorage/{version-status}/{version}/generated_blob.json`.
  - https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/tspconfig.yaml

### Public / consumable
- The repo is public, MIT. There is a published inventory dashboard of all specs (both TypeSpec and OpenAPI): https://azure.github.io/azure-sdk/releases/latest/specs.html (last updated May 2026 per search).

### Migration state (current)
- **Policy:** TypeSpec is **required for all new ARM (management-plane) services**, and brownfield services are being driven to convert. The wiki page now redirects to an internal `aka.ms/convert-to-typespec` → `eng.ms/...` doc (auth-gated, HTTP 403 — could not read content).
  - Wiki redirect confirmed: https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Conversion ("Content has been moved to https://aka.ms/convert-to-typespec").
- **Evidence of breadth:** All three case-study services already have TypeSpec folders in-repo (Blob data-plane, Service Bus mgmt, App Service/Functions mgmt — see §5). Live data-plane packages already generate from TypeSpec via `tsp-location.yaml` (e.g. `azure-data-tables`).
- `?? verify`: exact **percentage / count** of services converted. The wiki points at an auth-gated internal page; the public number was not obtainable. The public per-spec status is browsable at the dashboard above. Add to DO_NEXT.

---

## 2. Generator tool(s)

### AutoRest (legacy, deprecated)
- Repo `Azure/autorest`. The repo `readme.md` opens with: **"⚠️ Deprecation Notice — AutoRest is deprecated and will be retired on July 1, 2026."** and names TypeSpec as the recommended replacement. Tracking issue: https://github.com/Azure/autorest/issues/5175
  - https://github.com/Azure/autorest/blob/69fa4acb21d0c9275df3a09c398bb2ca2191a12c/readme.md
- **Architecture:** a TypeScript core (`@autorest/core`, `@autorest/modelerfour`) plus per-language **plugins**. `@autorest/core`'s `package.json` confirms TypeScript (`"main": "./dist/exports.js"`, `typescript: ~5.8.3`).
  - https://github.com/Azure/autorest/blob/69fa4acb21d0c9275df3a09c398bb2ca2191a12c/packages/extensions/core/package.json
- Per-language plugins (npm `@autorest/<lang>`), each in its own repo:
  - `@autorest/python` — `Azure/autorest.python` (TS/Python). **README now says the repo is deprecated** and that the emitter moved to `@azure-tools/typespec-python`: https://github.com/Azure/autorest.python/blob/28a5851a2a370d70b5661278f4b7a7d22d236919/README.md
  - `@autorest/go` — `Azure/autorest.go` ("AutoRest Go Generator"): https://github.com/Azure/autorest.go/blob/cedbfc541d4af3af0fed5fbbfb04b07be6adc9d9/README.md
  - `@autorest/java` — `Azure/autorest.java`
  - `@autorest/typescript` — `Azure/autorest.typescript`

### TypeSpec emitters (new)
- TypeSpec core language: `microsoft/typespec` (MIT). Azure libraries/emitters: `Azure/typespec-azure` (MIT).
- The Azure client-generation rules and core helper live in `Azure/typespec-azure/packages/`: `typespec-autorest` (TypeSpec→Swagger), `typespec-client-generator-core` (the `@azure-tools/typespec-client-generator-core` library that defines client customization decorators), `typespec-azure-rulesets`.
  - https://github.com/Azure/typespec-azure/tree/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages
- **Per-language TypeSpec emitters** — note they are co-located with the legacy plugins in the *same* repos:
  - `@azure-tools/typespec-python` → moved INTO `Azure/typespec-azure/packages/typespec-python`: https://github.com/Azure/typespec-azure/tree/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/typespec-python
  - `@azure-tools/typespec-ts` → `Azure/autorest.typescript/packages/typespec-ts` (alongside `packages/autorest.typescript`): https://github.com/Azure/autorest.typescript/tree/ffd258b12699f9996917596299e319092876a4ef/packages
  - `@azure-tools/typespec-go` → `Azure/autorest.go/packages/typespec-go` (alongside `packages/autorest.go`): https://github.com/Azure/autorest.go/tree/cedbfc541d4af3af0fed5fbbfb04b07be6adc9d9/packages
  - `@azure-tools/typespec-java` → `Azure/autorest.java` (referenced as emitter in tspconfigs; `?? verify` exact package path).
  - C#: `@azure-typespec/http-client-csharp` / `-mgmt` (seen in tspconfigs).
- Languages the generators are written in: **AutoRest core + emitters are TypeScript/Node**. The Java and Go generators have native-language backends but are driven as Node emitter plugins. All open source, all MIT.

---

## 3. Pipeline / orchestration

### Spec → SDK automation ("swagger-to-sdk" / "azure-sdk" automation)
- `azure-rest-api-specs` drives SDK generation via a config file `specificationRepositoryConfiguration.json` (pipeline name `"automation - sdk"`). It maps each target SDK repo to an **integration fork** (`azure-sdk/azure-sdk-for-*`), a **main repo** (`Azure/azure-sdk-for-*`), and a per-language `configFilePath` (e.g. Go/Net: `eng/swagger_to_sdk_config.json`, Java: `eng/automation/swagger_to_sdk_config.json`).
  - https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specificationRepositoryConfiguration.json
- Each SDK repo's `eng/swagger_to_sdk_config.json` defines the generate/init scripts the automation calls. Verified for Go (`generator automation-v2`, init via `eng/scripts/automation_init.sh`):
  - https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/eng/swagger_to_sdk_config.json
- A spec PR in `azure-rest-api-specs` triggers automation that opens **generated PRs** into the `azure-sdk/*-pr` integration forks per language (overrides block in the config handles `azure-rest-api-specs-pr`).

### TypeSpec generation path: `tsp-client`
- New tool: **`tsp-client`** = npm `@azure-tools/typespec-client-generator-cli`, in `Azure/azure-sdk-tools/tools/tsp-client`.
- Each SDK package carries a **`tsp-location.yaml`** pointing back at the spec: fields `directory` (spec path), `commit`, `repo: Azure/azure-rest-api-specs`, `additionalDirectories`. Verified example (`azure-data-tables`):
  ```
  directory: specification/cosmos-db/data-plane/Tables
  commit: 623ace17cc16f11c09e2b5264e5e2d8c066c0ae9
  repo: Azure/azure-rest-api-specs
  additionalDirectories: []
  ```
  - https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/tables/azure-data-tables/tsp-location.yaml
- `tsp-client` workflow: `init` → writes `tsp-location.yaml`; `sync` → pulls the pinned spec commit into a temp `TempTypeSpecFiles/` dir; `generate` → runs the configured emitter (needs `emitter-package.json`); `update` = sync + generate. Source: https://github.com/Azure/azure-sdk-tools/blob/main/tools/tsp-client/README.md

### Monorepo per language + engineering system (`eng/`)
- One mono-repo per language: `azure-sdk-for-python`, `-go`, `-java`, `-js` (and `-net`). Each holds packages under `sdk/<service>/<package>/` and a shared `eng/` engineering system (scripts, pipelines, codegen config).
- CI runs in Azure DevOps pipelines defined in `eng/`. Codegen is bot-driven (PRs from the `azure-sdk` bot into the integration forks).

---

## 4. Per-language customization mechanisms

### AutoRest directives (Swagger world)
- Customizations are expressed as **YAML `directive:` blocks** inside the per-spec/per-package `readme.md` (or per-language `readme.<lang>.md`), using `from`/`where` (JSONPath) + `transform` (JS expression) to mutate the Swagger before generation.
- Live example — Go Blob protocol layer config (`autorest.md` checked into the SDK repo) contains AutoRest settings *and* directives, e.g. "Add a Properties field to the BlobPrefix definition":
  ```yaml
  directive:
  - from: swagger-document
    where: $.definitions
    transform: >
      $.BlobPrefix.properties["Properties"] = { "type": "object", "$ref": "#/definitions/BlobPropertiesInternal" };
  ```
  - https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob/internal/generated/autorest.md
- JS Blob `swagger/README.md` ("Azure Storage TypeScript **Protocol Layer**") has heavy `directive` transforms (e.g. stripping `{containerName}/{blob}` path params because the SDK uses direct URIs):
  - https://github.com/Azure/azure-sdk-for-js/blob/39edf9562a7adbd1383a124cb55ed9ada844b0e2/sdk/storage/storage-blob/swagger/README.md

### TypeSpec customization (`client.tsp` + decorators)
- Client-shape customizations live in **`client.tsp`** using decorators from `@azure-tools/typespec-client-generator-core`. Verified on Blob (`client.tsp`):
  - `@@clientName(FilteredBlobResponse, "FilterBlobSegment", "python,csharp,javascript,go")` — per-language rename
  - `@@alternateType(KeyInfo.start, string, "python,csharp,javascript,go")` — per-language type override
  - `@@Azure.ClientGenerator.Core.Legacy.disablePageable(Service.listContainers, "...")` — opt out of pageable shape to preserve back-compat
  - `@client({ service: Storage.Blob }, "rust,go") interface BlobServiceClient ...` — per-language client surface
  - All scoped with a **language list string** (`"python,csharp,javascript,go"`) so one spec drives divergent per-language clients.
  - https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/client.tsp
- Emitter knobs live in `tspconfig.yaml` `options.<emitter>` (namespace, output dir, `generation-subdir`, `file-prefix`, `rename-model`, Java `customization-class`, etc.). Service Bus `tspconfig.yaml` shows a Java `customization-class: customization/src/main/java/ServiceBusCustomization.java` and `rename-model: { EncryptionKeySource: KeySource }`:
  - https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/tspconfig.yaml

### `_generated` vs hand-authored convention
- **Python** (`azure-sdk-for-python`): generated protocol code lives in a `_generated/` subpackage; everything else in the package is **hand-authored convenience layer**. Blob package shows hand-written `_blob_client.py`, `_container_client.py`, `_models.py`, `_upload_helpers.py`, `_download.py`, `_encryption.py`, `aio/`, alongside `_generated/`.
  - https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob
  - The generated subpackage carries a header **"Code generated by Microsoft (R) AutoRest Code Generator. ... Changes may cause incorrect behavior and will be lost if the code is regenerated."**
    https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob/_generated/_azure_blob_storage.py
  - Escape hatch: **`_generated/_patch.py`** with `patch_sdk()` — a "last resort escape hatch" for customizations that survive regeneration. Verified:
    https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob/_generated/_patch.py
- **Go** (`azure-sdk-for-go`): generated code under `internal/generated/` with **`zz_` file prefix** (matches `file-prefix: "zz_"`), and non-`zz_` files in the same dir are hand-written patches; the public convenience layer (`client.go`, `blob/`, `container/`, `service/`, `sas/`, `lease/`) sits at package root. Verified for azblob:
  - https://github.com/Azure/azure-sdk-for-go/tree/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob/internal/generated
- **JS** (`azure-sdk-for-js`): generated code under `src/generated/`; hand-authored `BlobClient`, `ContainerClient`, `BlobServiceClient`, `Pipeline.ts`, `sas/`, `models.ts` at `src/` root. Verified:
  - https://github.com/Azure/azure-sdk-for-js/tree/39edf9562a7adbd1383a124cb55ed9ada844b0e2/sdk/storage/storage-blob/src
- **Java** (`azure-sdk-for-java`): customization is a Java class referenced from `tspconfig.yaml` (`customization-class`) plus hand-written convenience layer in the package (`?? verify` exact storage-blob file split).

---

## 5. Manual vs generated — case studies

### Azure Blob Storage (object storage) — heavily hand-customized over a generated protocol layer ✅ CONFIRMED
- **Spec:** dual state.
  - Legacy Swagger (still the source the *shipped* SDKs regenerate from): `specification/storage/data-plane/Microsoft.BlobStorage/{stable,preview}/<version>/blob.json` + `readme.md`.
  - New TypeSpec (in-repo, partially wired): `specification/storage/Microsoft.BlobStorage/{main,models,routes,client}.tsp` + `tspconfig.yaml`. tspconfig configures emitters for python/csharp/ts/go/rust; **Java emitter is commented out** ("uncomment when ready to use").
    https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/tspconfig.yaml
- **Generator (what actually ships now):** still **AutoRest** from `blob.json`.
  - Go: `internal/generated/autorest.md` pins `input-file: .../Microsoft.BlobStorage/stable/2026-06-06/blob.json`, `use: @autorest/go@4.0.0-preview.80`, `file-prefix: zz_`, plus several `directive`/`transform` blocks. Output = `zz_*.go` in `internal/generated/`.
  - JS: `swagger/README.md` ("TypeScript Protocol Layer") uses `@autorest/typescript: 6.0.42` against `blob.json`, output `../src/generated`, many directives.
  - Python `_generated/` header = AutoRest.
- **Hand-authored convenience layer** (the bulk of each SDK's public surface): clients, models, upload/download helpers, encryption, SAS, leasing, async variants — all hand-written on top of the thin generated protocol layer. This is the textbook "generated protocol + large hand-written convenience layer" pattern, confirmed across Python/Go/JS.
- Output pointers:
  - Python: https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob
  - Go: https://github.com/Azure/azure-sdk-for-go/tree/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob
  - JS: https://github.com/Azure/azure-sdk-for-js/tree/39edf9562a7adbd1383a124cb55ed9ada844b0e2/sdk/storage/storage-blob

### Azure Service Bus (messaging) — management plane
- **Spec:** Service Bus **mgmt plane is already TypeSpec source-of-truth.** `specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/` has `main.tsp`, `models.tsp`, `routes.tsp`, `client.tsp`, `back-compatible.tsp`, per-resource `.tsp` (SBQueue, SBTopic, SBNamespace, ...), `tspconfig.yaml`, **and** a full set of legacy AutoRest configs (`readme.md`, `readme.python.md`, `readme.java.md`, `readme.go.md`, `readme.typescript.md`, `readme.nodejs.md`, ...).
  - `tspconfig.yaml` emits Swagger via `@azure-tools/typespec-autorest` → `{version-status}/{version}/servicebus.json`, and also configures python/java/ts/go/csharp emitters (Java has `customization-class`, `rename-model`).
    https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/tspconfig.yaml
  - The legacy `readme.md` still declares AutoRest config (`openapi-type: arm`, tags → `servicebus.json`).
    https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/readme.md
- **Generator (what ships now):** **AutoRest**, confirmed by the Python mgmt package's `_metadata.json`:
  ```
  "autorest": "3.10.2",
  "use": ["@autorest/python@6.35.0", "@autorest/modelerfour@4.27.0"],
  "autorest_command": "autorest specification/servicebus/resource-manager/readme.md ... --tag=package-2022-10-preview ...",
  "readme": "specification/servicebus/resource-manager/readme.md"
  ```
  https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/servicebus/azure-mgmt-servicebus/_metadata.json
  So even though the spec authoring moved to TypeSpec (TypeSpec → `servicebus.json` Swagger → AutoRest → `azure-mgmt-servicebus`), the shipped mgmt SDK is fully AutoRest-generated with little hand customization (typical for ARM/mgmt-plane).
- **Output pointers:**
  - Python (mgmt): `sdk/servicebus/azure-mgmt-servicebus` — https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/servicebus/azure-mgmt-servicebus
  - Go (mgmt, per tspconfig): `sdk/resourcemanager/servicebus/armservicebus`
  - Java (mgmt, per tspconfig): `sdk/servicebus/azure-resourcemanager-servicebus`
  - JS (mgmt, per tspconfig): `sdk/servicebus/arm-servicebus`
- **Note on data plane:** the *data-plane* Service Bus client (`azure-servicebus` in Python, `azservicebus` in Go) is an **AMQP** client and is largely **hand-authored** (it is not a REST/Swagger SDK). Data-plane spec dir `specification/servicebus/data-plane/ServiceBus` exists but the messaging client itself is hand-written over an AMQP stack. `?? verify` exact hand-vs-gen split of `azure-servicebus` data-plane.

### Azure Functions (FaaS) — management plane vs programming model
- **Distinction (important):** the Functions **programming model** (the functions host/runtime + language worker, e.g. `Azure/azure-functions-host`, `Azure/azure-functions-python-worker`) is a separate runtime product and is **not** generated from REST specs. The **management-plane SDK** is generated.
- **Mgmt spec:** Functions mgmt is part of **App Service / `Microsoft.Web`**, already migrated to TypeSpec: `specification/web/resource-manager/Microsoft.Web/AppService/` has `main.tsp`, `client.tsp`, `tspconfig.yaml`, per-resource `.tsp` including `FunctionEnvelope.tsp` (the Functions resource), plus legacy `readme.md`/`readme.<lang>.md`.
  - https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/web/resource-manager/Microsoft.Web/AppService
- **Generator (what ships now):** AutoRest from the emitted `Microsoft.Web` Swagger (same hybrid as Service Bus mgmt; `?? verify` the exact `_metadata.json` for `azure-mgmt-web`).
- **Output pointers:**
  - Python (mgmt): `sdk/appservice/azure-mgmt-web` — https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/appservice/azure-mgmt-web
  - Go/Java/JS: the App Service mgmt packages (`armappservice` / `azure-resourcemanager-appservice` / `arm-appservice`) — `?? verify` exact paths.
- Functions mgmt operations (create/update Function apps, function keys, etc.) are surfaced through these App Service mgmt SDKs; they are essentially **all generated** with minimal hand customization (mgmt-plane norm).

---

## 6. Release & versioning

- **Per-package independent semver.** Each `sdk/<service>/<package>/` ships and versions independently (the spec/SDK config carries `package-version`, e.g. JS Blob `package-version: 12.32.0` in the swagger config; Python Blob has `_version.py`).
- **Changelog automation:** each package keeps a `CHANGELOG.md` (verified present in Go azblob root). The engineering system in `eng/` includes changelog verification and release tooling shared across the mono-repo. The `azure-sdk` bot opens generated PRs; release pipelines live under `eng/`.
- Go additionally tracks breaking changes during automation (`"breakingChangeTracking": true` in `eng/swagger_to_sdk_config.json`).
  https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/eng/swagger_to_sdk_config.json
- `?? verify`: exact changelog-generation tool name and the release pipeline path under `eng/` (the `azure-sdk-tools` repo hosts these; e.g. `Update-Changelog`/`Verify-ChangeLog` PowerShell in `eng/common/scripts`). Add to DO_NEXT.

---

## Open gaps (→ DO_NEXT)
1. Precise **% / count** of services converted to TypeSpec (public number; wiki points to auth-gated `eng.ms`).
2. `azure-servicebus` (data-plane AMQP) hand-vs-generated split.
3. `azure-mgmt-web` (Functions/App Service mgmt) `_metadata.json` to confirm generator + tag.
4. Exact `@azure-tools/typespec-java` package path inside `Azure/autorest.java`.
5. Java storage-blob hand-vs-generated file split + the `customization-class` pattern in a shipped package.
6. Exact changelog/release tool names + `eng/common` script paths.
