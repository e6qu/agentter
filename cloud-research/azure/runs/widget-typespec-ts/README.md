# Build: Azure TypeSpec (new) — `.tsp` → TypeScript

**Result: SUCCESS.** The Azure TypeSpec emitter generated a modular TypeScript
SDK from a minimal `.tsp` service. This is Azure's **new** codegen stack (the
successor to AutoRest). See `../widget-autorest-python/` for the **legacy** stack
and `../README.md` for the dual-stack overview.

## Toolchain
- `@typespec/compiler` 1.12.0 + `@typespec/http` / `@typespec/rest`
- `@azure-tools/typespec-ts` (the emitter) + `@azure-tools/typespec-client-generator-core`

## Input (`input/`)
- `main.tsp` — a `@service` namespace `WidgetService`, a `Widget` model, and a
  `Widgets` interface with one `@get`. It imports `Azure.ClientGenerator.Core` —
  the same library whose `client.tsp` decorators the deliverable cites as Azure's
  customization seam.
- `tspconfig.yaml` — selects `emit: ["@azure-tools/typespec-ts"]`.

## Commands (`cmd.sh`)
```
npm install @typespec/compiler @typespec/http @typespec/rest \
            @azure-tools/typespec-ts @azure-tools/typespec-client-generator-core
npx tsp compile main.tsp
```

## Output (`output/out-ts/`)
A full modular TS SDK: `src/widgetServiceClient.ts`,
`src/models/{index,models}.ts` (a `Widget` interface + a `widgetDeserializer`),
`src/api/widgets/operations.ts`, a `classic/` convenience layer, plus
`package.json`, `tsconfig.json`, `api-extractor.json`, `rollup.config.js`.

## The key evidence
- The generated client binds to the runtime `@typespec/ts-http-runtime`
  (`import { Pipeline } from "@typespec/ts-http-runtime"`) — i.e. a generated
  surface over a hand-written pipeline, the same generated/hand-written split as
  the AutoRest path.
- The same trivial API, expressed as `.tsp` here and as Swagger in the sibling
  build, drives two different generators into two languages — Azure's "dual stack"
  in one repository.

## Takeaway
A faithful reproduction of the new TypeSpec emitter path — the other half of
Azure's migration, alongside the legacy AutoRest build.
