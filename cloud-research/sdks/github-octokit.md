# GitHub Octokit SDKs — How They Are Built

> Scope: how GitHub's official Octokit SDKs are generated and maintained.
> The center of gravity is **Octokit.js**: a *hand-written* HTTP core with
> *generated* TypeScript types and endpoint route definitions, both derived
> from GitHub's official OpenAPI description. Other-language clients
> (`octokit.rb`, `octokit.net`) are largely hand-written; the de-facto Go
> client (`google/go-github`) is hand-written and a useful contrast. A newer
> Kiota-based `octokit/source-generator` fully generates Go/.NET SDKs from the
> same OpenAPI spec.

All permalinks below are commit-pinned. License is **MIT** for every Octokit
repo cited (the umbrella `octokit`, core, plugins, types). `google/go-github`
is **BSD-3-Clause** (it is a Google project, not an Octokit repo).

---

## 1. Source of truth: GitHub's OpenAPI description (`github/rest-api-description`)

GitHub publishes a machine-readable OpenAPI description of its REST API as the
canonical contract. Pinned at commit
[`ad5a9d5`](https://github.com/github/rest-api-description/tree/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac):

- Repo description (GitHub API): *"An OpenAPI description for GitHub's REST API"*, license `MIT`.
- README ([blob](https://github.com/github/rest-api-description/blob/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac/README.md)):
  > "This repository contains [OpenAPI](https://www.openapis.org/) descriptions for [GitHub's REST API](https://docs.github.com/rest)."
  >
  > "The `descriptions` folder contains the 3.0 version of the description. The `descriptions-next` folder contains the 3.1 version."

GitHub's own docs state plainly that this description is what drives the SDKs
([GitHub Docs — About the OpenAPI description for the REST API](https://docs.github.com/en/rest/about-the-rest-api/about-the-openapi-description-for-the-rest-api)):

> "GitHub's OpenAPI description of the REST API is publicly available. You can find the description in the open source [github/rest-api-description](https://github.com/github/rest-api-description) repository."
>
> "For example, GitHub uses the OpenAPI description to generate the Octokit SDKs."

### The bundled spec (concrete example #1)

The per-plan bundled descriptions live under `descriptions/<plan>/`. For
api.github.com the bundled OpenAPI 3.0 file is
[`descriptions/api.github.com/api.github.com.json`](https://github.com/github/rest-api-description/blob/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac/descriptions/api.github.com/api.github.com.json)
(~12.5 MB). Its `info` block:

```json
{
  "openapi": "3.0.3",
  "info": {
    "version": "1.1.4",
    "title": "GitHub v3 REST API",
    "description": "GitHub's v3 REST API.",
    "license": { "name": "MIT", "url": "https://spdx.org/licenses/MIT" },
    "x-github-plan": "api.github.com"
  }
}
```

Each plan ships three flavors: a **bundled** file (reusable `$ref` components),
a **dereferenced** (`*.deref.json`, fully inlined) variant under
[`dereferenced/`](https://github.com/github/rest-api-description/tree/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac/descriptions/api.github.com/dereferenced),
plus dated apiVersion snapshots (e.g. `api.github.com.2022-11-28.json`). The
repo covers `api.github.com` (dotcom), `ghec` (Enterprise Cloud) and many
`ghes-*` (Enterprise Server) plans.

Historical note: the descriptions were reverse-engineered from the REST docs
with help from Octokit maintainer Gregor Martynus and Redocly, and are now used
to *create, validate, and test* the API as well as generate clients
([Introducing GitHub's OpenAPI Description](https://github.blog/news-insights/product-news/introducing-githubs-openapi-description/)).

---

## 2. The TypeScript generation chain (Octokit.js)

The generated artifact that flows through the entire JS ecosystem is a set of
**TypeScript types** plus **endpoint route definitions**, both derived from the
OpenAPI description. The chain has four hops:

```
github/rest-api-description   (canonical OpenAPI 3.0/3.1)
        │  download descriptions/<plan>/<plan>.json
        ▼
@octokit/openapi  (octokit/openapi)          ← adds x-octokit extension
        │  publishes JSON as GitHub Release assets
        ▼
@octokit/openapi-types  (octokit/openapi-types.ts)  ← GENERATED .d.ts via openapi-typescript
        │  npm dependency
        ▼
@octokit/types  (octokit/types.ts)           ← re-exports paths; generated Endpoints.ts
        │  npm dependency
        ▼
@octokit/plugin-rest-endpoint-methods.js     ← GENERATED endpoint routes + method types
        │
        ▼
octokit  (umbrella) / @octokit/core (hand-written core)
```

### Hop 1 — `octokit/openapi` re-publishes the spec with an `x-octokit` extension

Pinned at [`4c6354a`](https://github.com/octokit/openapi/tree/4c6354a6d46e02219056acf5662d0f4a81f8f74e).
README ([blob](https://github.com/octokit/openapi/blob/4c6354a6d46e02219056acf5662d0f4a81f8f74e/README.md)):

> "Amends operations from [GitHub's official OpenAPI specification](https://github.com/github/rest-api-description/) with an `x-octokit` extension..."

Its [`scripts/download.mjs`](https://github.com/octokit/openapi/blob/4c6354a6d46e02219056acf5662d0f4a81f8f74e/scripts/download.mjs)
fetches the descriptions directly from `github/rest-api-description`:

```js
const getDescriptionsOptions = {
  owner: "github",
  repo: "rest-api-description",
  path: "descriptions",
  ref: "main",
};
```

(It also follows the most recent open PR by `@github-openapi-bot` so it can
preview upcoming changes.) The amended JSON is committed under
[`generated/`](https://github.com/octokit/openapi/tree/4c6354a6d46e02219056acf5662d0f4a81f8f74e/generated)
and published as `@octokit/openapi` plus GitHub Release assets.

### Hop 2 — `octokit/openapi-types.ts` generates the `.d.ts` via `openapi-typescript`

This is the actual code-generation step. Pinned at
[`0517646`](https://github.com/octokit/openapi-types.ts/tree/0517646009e73570b30e7e75997a14c90253656a).
Repo description: *"Generated TypeScript definitions based on GitHub's OpenAPI spec"*, MIT.

[`package.json`](https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/package.json)
devDependency: **`"openapi-typescript": "^6.2.1"`** — the generator is the
community [`openapi-typescript`](https://github.com/openapi-ts/openapi-typescript) library.

[`scripts/download.js`](https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/scripts/download.js)
pulls the JSON from `@octokit/openapi` Release assets:

```js
const { data: { id: releaseId } } =
  await octokit.request("GET /repos/{owner}/{repo}/releases/tags/{tag}", {
    owner: "octokit", repo: "openapi", tag: `v${version}`,
  });
```

[`scripts/generate-types.js`](https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/scripts/generate-types.js)
runs the generator and writes one `types.d.ts` per plan:

```js
import openapiTS from "openapi-typescript";
// ...
const schemaTS = await openapiTS(`cache/${name}.json`, {
  transform(schemaObject, metadata) {
    // binary uploads -> string | File | Uint8Array | Blob; int64 -> number | bigint
  },
});
await writeFile(`packages/${packageName}/types.d.ts`,
  await prettier.format(schemaTS, { parser: "typescript" }));
```

The script also stamps the upstream spec version into the package as
`octokit["openapi-version"]`, tracing every generated types package back to a
specific `@octokit/openapi` release.

### Generated types file (concrete example #2)

The output [`packages/openapi-types/types.d.ts`](https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/packages/openapi-types/types.d.ts)
opens with the auto-generated banner and an `interface paths` mirroring the
OpenAPI `paths` object:

```ts
/**
 * This file was auto-generated by openapi-typescript.
 * Do not make direct changes to the file.
 */
// ...
export interface paths {
  "/": {
    /** GitHub API Root ... */
    get: operations["meta/root"];
  };
  "/advisories": { ... };
```

Its [generated `package.json`](https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/packages/openapi-types/package.json)
records the provenance: `"octokit": { "openapi-version": "22.0.0" }`.

### Hop 3 — `@octokit/types` consumes the generated types

Pinned at [`52c1c75`](https://github.com/octokit/types.ts/tree/52c1c756ef10e10bf5518f7a567075cf5efbd3bf).
[`package.json`](https://github.com/octokit/types.ts/blob/52c1c756ef10e10bf5518f7a567075cf5efbd3bf/package.json)
has the single runtime dependency `"@octokit/openapi-types": "^27.0.0"`.

The generated [`src/generated/Endpoints.ts`](https://github.com/octokit/types.ts/blob/52c1c756ef10e10bf5518f7a567075cf5efbd3bf/src/generated/Endpoints.ts)
imports the OpenAPI `paths` and derives request/response types from them:

```ts
// DO NOT EDIT THIS FILE
import type { paths } from "@octokit/openapi-types";
```

(The bulk of `src/*.ts` here — `RequestInterface`, `EndpointInterface`,
`OctokitResponse`, etc. — is hand-written TypeScript glue; only
`src/generated/Endpoints.ts` is machine-generated.)

### Hop 4 — `@octokit/plugin-rest-endpoint-methods.js` generates the route table

Pinned at [`197d78d`](https://github.com/octokit/plugin-rest-endpoint-methods.js/tree/197d78da82f2629c446006f128a35c0249661aa4).
This plugin adds one method per REST endpoint (e.g. `octokit.rest.actions.cancelWorkflowRun(...)`).
The route map is **generated**, marked
([generated README](https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/src/generated/README.md)):

> "DO NOT EDIT FILES IN THIS DIRECTORY — All files are generated automatically
> and will be overwritten next time [GitHub's OpenAPI spec] has a new release."

The `update-endpoints` scripts:

- [`scripts/update-endpoints/fetch-json.mjs`](https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/scripts/update-endpoints/fetch-json.mjs)
  uses `github-openapi-graphql-query` to query the OpenAPI description as
  structured endpoint metadata (scope, id, method, url, parameters, previews,
  renames).
- [`scripts/update-endpoints/code.mjs`](https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/scripts/update-endpoints/code.mjs)
  emits the route table into
  [`src/generated/endpoints.ts`](https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/src/generated/endpoints.ts):

```ts
const Endpoints: EndpointsDefaultsAndDecorations = {
  actions: {
    cancelWorkflowRun: ["POST /repos/{owner}/{repo}/actions/runs/{run_id}/cancel"],
    approveWorkflowRun: ["POST /repos/{owner}/{repo}/actions/runs/{run_id}/approve"],
    // ... one entry per endpoint
  },
```

The plugin's typed surface (`method-types.ts`, `parameters-and-response-types.ts`)
is likewise generated and is typed against `@octokit/types`
(dependency `"@octokit/types": "^16.0.0"`), closing the loop back to the
generated OpenAPI types.

The umbrella [`octokit`](https://github.com/octokit/octokit.js/blob/fd769731bee3bfdffbdc5869ec00e9cb525a0b37/package.json)
package then bundles `@octokit/core`, `@octokit/plugin-rest-endpoint-methods`,
`@octokit/plugin-paginate-rest`, `@octokit/plugin-throttling`,
`@octokit/plugin-retry`, `@octokit/types`, etc.

---

## 3. Hand-written core vs generated (the key split)

**Only two things are generated**: (a) the TypeScript types from the OpenAPI
description, and (b) the endpoint route definitions / per-method types in
`plugin-rest-endpoint-methods`. **Everything else in the Octokit core is
hand-written.**

### Hand-written core (concrete example #3)

`@octokit/core` ([`83550e2`](https://github.com/octokit/core.js/tree/83550e27f736c3ae1cd4ce1a15f56eca33a5e71e))
has only hand-authored sources and no `generated/` directory and no codegen
script in [`package.json`](https://github.com/octokit/core.js/blob/83550e27f736c3ae1cd4ce1a15f56eca33a5e71e/package.json):

```
src/index.ts   src/types.ts   src/version.ts
```

It wires together hand-written packages:
`@octokit/auth-token`, `@octokit/graphql`, `@octokit/request`,
`@octokit/request-error`, `before-after-hook` (the plugin/hook system), and
takes `@octokit/types` for typing. Note the dependency on `@octokit/types`:
that is the *only* place generated artifacts enter the core — as types, never
as runtime logic.

`@octokit/request` ([`25b0838`](https://github.com/octokit/request.js/tree/25b08387aaec7456262d3cee94eb0a857fe22761))
is similarly all hand-written
([`src/`](https://github.com/octokit/request.js/tree/25b08387aaec7456262d3cee94eb0a857fe22761/src):
`fetch-wrapper.ts`, `defaults.ts`, `with-defaults.ts`, `is-plain-object.ts`, …).

The behavioral plugins — `@octokit/plugin-paginate-rest`
([`4f219b8`](https://github.com/octokit/plugin-paginate-rest.js/tree/4f219b80a4d4604d443d53e85c39f1b8e680e705)),
`@octokit/plugin-throttling`, `@octokit/plugin-retry` — and the auth strategies
(`@octokit/auth-token`
[`fd39f2f`](https://github.com/octokit/auth-token.js/tree/fd39f2f02b38261bb9fbc98e75db01cf36a4bdae),
`@octokit/auth-app`, `@octokit/auth-oauth-app`, …) are all hand-written. They
encode HTTP transport, retry/backoff, pagination link-walking and credential
handling — logic that an OpenAPI description does not express, hence hand-authored.

| Layer | Generated? | From |
| --- | --- | --- |
| `@octokit/openapi-types` (TS types) | **Generated** | OpenAPI desc via `openapi-typescript` |
| `@octokit/types` → `src/generated/Endpoints.ts` | **Generated** | `@octokit/openapi-types` |
| `plugin-rest-endpoint-methods` route table + method types | **Generated** | OpenAPI desc via `github-openapi-graphql-query` |
| `@octokit/core`, `@octokit/request`, `@octokit/graphql` | Hand-written | — |
| auth strategies (`@octokit/auth-*`) | Hand-written | — |
| pagination / throttling / retry plugins | Hand-written | — |

---

## 4. Other languages

### Ruby — `octokit/octokit.rb` (hand-written)

Pinned at [`6d02a4b`](https://github.com/octokit/octokit.rb/tree/6d02a4b506aaf6a6b6b1a04e065dd23c697275ce), MIT.
Endpoint methods are hand-authored Ruby mixins, one file per API area under
[`lib/octokit/client/`](https://github.com/octokit/octokit.rb/tree/6d02a4b506aaf6a6b6b1a04e065dd23c697275ce/lib/octokit/client)
(e.g. `actions_workflows.rb`, `repository.rb`). Example
([blob](https://github.com/octokit/octokit.rb/blob/6d02a4b506aaf6a6b6b1a04e065dd23c697275ce/lib/octokit/client/actions_workflows.rb)):

```ruby
module Octokit
  class Client
    module ActionsWorkflows
      def workflows(repo, options = {})
        paginate "#{Repository.path repo}/actions/workflows", options do |data, last_response|
          data.workflows.concat last_response.data.workflows
        end
      end
      alias list_workflows workflows
```

No codegen in the tree — fully hand-written. (GitHub's docs historically called
out the Ruby client as one of the generated/spec-driven targets, but the current
repo is hand-maintained; the OpenAPI relationship is at most documentation-level.
`?? verify` whether any part of octokit.rb is still spec-generated.)

### .NET — `octokit/octokit.net` (hand-written; generator is experimental)

Pinned at [`7fa5b0f`](https://github.com/octokit/octokit.net/tree/7fa5b0fe4a18c9b981b21290c3ca9320b2d6415b), MIT.
API clients under
[`Octokit/Clients/`](https://github.com/octokit/octokit.net/tree/7fa5b0fe4a18c9b981b21290c3ca9320b2d6415b/Octokit/Clients)
(e.g. `ActionsClient.cs`) are hand-written C#. There is an `Octokit.Generators`
project, but its
[README](https://github.com/octokit/octokit.net/blob/7fa5b0fe4a18c9b981b21290c3ca9320b2d6415b/Octokit.Generators/README.md)
calls it *"iteration 0"* and says:

> "Currently no generation is automatically run as a build/release step."

So in practice octokit.net is hand-written; the generator only emits async
pagination extensions experimentally.

### Go — `google/go-github` (hand-written; the contrast)

Pinned at [`1c8844d`](https://github.com/google/go-github/tree/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6),
**BSD-3-Clause** (Google project, not Octokit). This is the de-facto Go client
and is a deliberately good contrast: it is **hand-written, not generated**.
Service files under
[`github/`](https://github.com/google/go-github/tree/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6/github)
(e.g. `actions.go`) carry hand-authored types:

```go
// ActionsService handles communication with the actions related
// methods of the GitHub API.
type ActionsService service
```

The OpenAPI description is used only as a **metadata/lint source**, not for
generation. The `tools/metadata` tool
([`openapi.go`](https://github.com/google/go-github/blob/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6/tools/metadata/openapi.go))
reads `github/rest-api-description` `descriptions/` to keep
[`openapi_operations.yaml`](https://github.com/google/go-github/blob/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6/openapi_operations.yaml)
(documentation URLs and operation coverage) in sync:

```go
const (
  descriptionsOwnerName = "github"
  descriptionsRepoName  = "rest-api-description"
  descriptionsPath      = "descriptions"
)
```

So: spec-aware for docs/coverage checks, but the client code itself is fully
hand-written.

### Newer: `octokit/source-generator` (Kiota — fully generated, separate track)

A separate, newer effort
([`fcf6805`](https://github.com/octokit/source-generator/tree/fcf6805c5ec569b2be847dc4585608f164bc8727))
*does* fully generate SDKs from the OpenAPI spec, built on Microsoft
[Kiota](https://github.com/microsoft/kiota). Per its
[README](https://github.com/octokit/source-generator/blob/fcf6805c5ec569b2be847dc4585608f164bc8727/README.md)
it produces the generated `octokit/go-sdk` and `octokit/dotnet-sdk` (plus GHEC/GHES
variants), explicitly distinguished from *"our classic non-generated,
hand-maintained Octokit.net project."* This is a distinct generation track from
the classic hand-written clients above and from the Octokit.js types pipeline.

---

## 5. Multi-language strategy

There is **no single cross-language generator** at the heart of Octokit. The
strategy is:

- **One canonical artifact**: GitHub's OpenAPI description
  (`github/rest-api-description`), used to create/validate/test the API itself.
- **Per-language projects** that mostly stand alone. The Octokit.js ecosystem is
  the only one where generation is load-bearing in production: it generates
  **TypeScript types** (`openapi-typescript`) and **endpoint route definitions**
  (`github-openapi-graphql-query`) over a **hand-written transport/auth/plugin
  core**.
- **Classic non-JS clients are hand-written** (`octokit.rb`, `octokit.net`;
  community `google/go-github`). They consume the OpenAPI description, if at all,
  only as a metadata/docs/coverage aid, not as a code generator.
- **A parallel, newer generated track** exists via `octokit/source-generator`
  (Kiota) producing Go/.NET SDKs from the same spec — but it is separate from
  both the JS pipeline and the classic hand-written clients.

Net: the only generated thing shared across the JS stack is the TypeScript
representation of the OpenAPI description; everything that does HTTP, auth,
pagination, retries and throttling is hand-authored per language.

---

## Links

### Canonical spec
- github/rest-api-description (`ad5a9d5`): https://github.com/github/rest-api-description/tree/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac
- Bundled OpenAPI (api.github.com): https://github.com/github/rest-api-description/blob/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac/descriptions/api.github.com/api.github.com.json
- README: https://github.com/github/rest-api-description/blob/ad5a9d52bd14ba99c9844087287d5cb240b8f0ac/README.md
- GitHub Docs (OpenAPI description usage): https://docs.github.com/en/rest/about-the-rest-api/about-the-openapi-description-for-the-rest-api
- Introducing GitHub's OpenAPI Description (blog): https://github.blog/news-insights/product-news/introducing-githubs-openapi-description/

### TS generation chain
- @octokit/openapi (`4c6354a`): https://github.com/octokit/openapi/tree/4c6354a6d46e02219056acf5662d0f4a81f8f74e
  - download.mjs: https://github.com/octokit/openapi/blob/4c6354a6d46e02219056acf5662d0f4a81f8f74e/scripts/download.mjs
- @octokit/openapi-types.ts (`0517646`): https://github.com/octokit/openapi-types.ts/tree/0517646009e73570b30e7e75997a14c90253656a
  - generate-types.js: https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/scripts/generate-types.js
  - generated types.d.ts: https://github.com/octokit/openapi-types.ts/blob/0517646009e73570b30e7e75997a14c90253656a/packages/openapi-types/types.d.ts
- @octokit/types.ts (`52c1c75`): https://github.com/octokit/types.ts/tree/52c1c756ef10e10bf5518f7a567075cf5efbd3bf
  - generated Endpoints.ts: https://github.com/octokit/types.ts/blob/52c1c756ef10e10bf5518f7a567075cf5efbd3bf/src/generated/Endpoints.ts
- @octokit/plugin-rest-endpoint-methods.js (`197d78d`): https://github.com/octokit/plugin-rest-endpoint-methods.js/tree/197d78da82f2629c446006f128a35c0249661aa4
  - generated endpoints.ts: https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/src/generated/endpoints.ts
  - fetch-json.mjs: https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/scripts/update-endpoints/fetch-json.mjs
  - code.mjs: https://github.com/octokit/plugin-rest-endpoint-methods.js/blob/197d78da82f2629c446006f128a35c0249661aa4/scripts/update-endpoints/code.mjs

### Hand-written core
- octokit (umbrella, `fd76973`): https://github.com/octokit/octokit.js/tree/fd769731bee3bfdffbdc5869ec00e9cb525a0b37
- @octokit/core (`83550e2`): https://github.com/octokit/core.js/tree/83550e27f736c3ae1cd4ce1a15f56eca33a5e71e
- @octokit/request (`25b0838`): https://github.com/octokit/request.js/tree/25b08387aaec7456262d3cee94eb0a857fe22761
- @octokit/plugin-paginate-rest (`4f219b8`): https://github.com/octokit/plugin-paginate-rest.js/tree/4f219b80a4d4604d443d53e85c39f1b8e680e705
- @octokit/auth-token (`fd39f2f`): https://github.com/octokit/auth-token.js/tree/fd39f2f02b38261bb9fbc98e75db01cf36a4bdae

### Other languages
- octokit/octokit.rb (`6d02a4b`, MIT): https://github.com/octokit/octokit.rb/tree/6d02a4b506aaf6a6b6b1a04e065dd23c697275ce
- octokit/octokit.net (`7fa5b0f`, MIT): https://github.com/octokit/octokit.net/tree/7fa5b0fe4a18c9b981b21290c3ca9320b2d6415b
  - Octokit.Generators README: https://github.com/octokit/octokit.net/blob/7fa5b0fe4a18c9b981b21290c3ca9320b2d6415b/Octokit.Generators/README.md
- google/go-github (`1c8844d`, BSD-3-Clause): https://github.com/google/go-github/tree/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6
  - tools/metadata/openapi.go: https://github.com/google/go-github/blob/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6/tools/metadata/openapi.go
  - openapi_operations.yaml: https://github.com/google/go-github/blob/1c8844d93c4ecfedfd0ef00d1fbbd4c99ad154b6/openapi_operations.yaml
- octokit/source-generator (Kiota, `fcf6805`): https://github.com/octokit/source-generator/tree/fcf6805c5ec569b2be847dc4585608f164bc8727

### Generators (third-party)
- openapi-typescript: https://github.com/openapi-ts/openapi-typescript
- Microsoft Kiota: https://github.com/microsoft/kiota
