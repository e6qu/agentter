# Azure: Cross-Language SDK Behavioral Verification

How Microsoft Azure verifies that the SDKs it generates from a single spec
behave **consistently across languages** (Python, TypeScript/JS, Go, Java,
.NET, …). Research date: 2026-05-30.

**Pinned SHAs used for permalinks below:**
- `microsoft/typespec` @ `8d9f7f7f3e4679bcf60f121df5582f3f162d4298`
- `Azure/typespec-azure` @ `d0d2d7c83897ad72314d55ebae0dcbc28e62ee61`
- `Azure/cadl-ranch` @ `5d668a3386950a71640df1e620ffd5668ad973e5`
- `Azure/autorest.testserver` @ `c04d3fe530c00a8095cfc6288d5f7bf1c7f61f38`
- `Azure/azure-sdk-tools` @ `249712c6c20bd30210c44b7f666b2c54dfed16c7`
- `Azure/azure-sdk-for-python` (file paths via `contents` API; package shown is
  `sdk/tables/azure-data-tables/assets.json`)

---

## Headline finding

Azure verifies cross-language consistency with **two complementary, independent
systems**:

1. **Spec-driven scenario testing (`spector` / http-specs).** A central,
   language-agnostic suite of TypeSpec scenarios + JS mock APIs. *Every*
   language emitter generates a client from these `.tsp` scenarios, then runs
   that generated client against a single shared **mock server** spun up from
   the very same specs. If a Python, Go, JS, or Java client can't satisfy the
   same mock server from the same spec, the emitter's CI fails. This is the
   "generate-and-knock" loop and is the primary cross-language consistency gate
   at the *generator* level.

2. **Record/replay testing (`test-proxy`).** A single shared HTTP record/replay
   binary used by every language SDK repo, with recordings stored centrally and
   out-of-band in `Azure/azure-sdk-assets` and referenced by an `assets.json`
   per package. This validates that hand-finished SDKs replay identical HTTP
   traffic, and gives every language the *same* sanitization/matching semantics.

The first proves that *generated clients* speak the protocol the spec describes;
the second proves that *shipped SDKs* produce/consume identical wire traffic.
Together they cover generator output and library behavior.

---

## 1. Spec-driven scenario suite: `spector` (formerly `cadl-ranch`)

### What it is

A repository of **scenarios**, each a directory containing:
- a `main.tsp` — a small, self-contained TypeSpec service annotated with
  `@scenario` / `@scenarioDoc` decorators describing a single behavior to test;
- a `mockapi.ts` — a JS object describing the exact request the mock server
  expects and the exact response it returns for that scenario.

A tool (now `tsp-spector`, formerly `cadl-ranch`) can:
- **serve** the scenarios as a live mock HTTP server (`tsp-spector serve`);
- **knock** — drive the server itself to validate the mock APIs
  (`tsp-spector knock`);
- compute **coverage** per generator and upload manifests so each language's
  pass-rate against the scenario set is tracked centrally.

`spector` README (commands `serve`, `server start`/`server stop`, `knock`):
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/spector/README.md

### Where it lives now (the migration)

`cadl-ranch` has been **retired and split**. Its own README now states:
> **Please do not create issues or pull requests in this repository.** … please
> use our active repository https://github.com/microsoft/typespec

https://github.com/Azure/cadl-ranch/blob/5d668a3386950a71640df1e620ffd5668ad973e5/README.md

The migration (tracked in `microsoft/typespec` issue #4015) moved the four
cadl-ranch packages (runtime, expect/decorator library, mock-api helpers, and
the specs) into the TypeSpec stack and renamed the tooling to **`tsp-spector`**.
Non-Azure specs went to the core repo; Azure-specific specs went to
`typespec-azure`. Key checklist items: *"Migrate specs from cadl-ranch-specs to
the new raw typespec package"* and *"Work with emitters to make sure they call
the new 'tsp-spector' instead"*.
https://github.com/microsoft/typespec/issues/4015

The result is **two spec packages**:

| Package | Repo / path | Scope |
|---|---|---|
| `@typespec/http-specs` | `microsoft/typespec` `packages/http-specs` | Language/protocol-neutral ("unbranded") scenarios |
| `@azure-tools/azure-http-specs` | `Azure/typespec-azure` `packages/azure-http-specs` | Azure-specific scenarios (Azure.Core, ARM, client-generator-core, LRO, paging, …) |

- `@typespec/http-specs` package.json (name + `tsp-spector` scripts):
  https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/package.json
- `@azure-tools/azure-http-specs` package.json:
  https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/package.json

Both run the identical validation pipeline via `tsp-spector`, e.g.
`validate-scenarios`, `validate-mock-apis`, and `validate-client-server`
(which does `concurrently "tsp-spector server start ./specs" "pnpm knock"; …;
tsp-spector server stop`).

### Concrete example A — neutral scenario (`authentication/api-key`)

`main.tsp` (in `@typespec/http-specs`) — note `@scenario` / `@scenarioDoc`:

```tsp
@scenarioService("/authentication/api-key")
@doc("Illustrates clients generated with ApiKey authentication.")
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "x-ms-api-key">)
namespace Authentication.ApiKey;

@scenario
@scenarioDoc("Expects header 'x-ms-api-key': 'valid-key'")
@doc("Check whether client is authenticated")
@get
@route("/valid")
op valid(): NoContentResponse;
```
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/specs/authentication/api-key/main.tsp

Paired `mockapi.ts` — the mock server demands the exact header `valid-key` and
returns 204; the `invalid` scenario expects `invalid-key` and returns 403:

```ts
Scenarios.Authentication_ApiKey_valid = passOnSuccess({
  uri: `/authentication/api-key/valid`,
  method: `get`,
  request: { headers: { "x-ms-api-key": "valid-key" } },
  response: { status: 204 },
  kind: "MockApiDefinition",
});
```
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/specs/authentication/api-key/mockapi.ts

Every language emitter must generate an api-key-auth client from that `main.tsp`
and have it send `x-ms-api-key: valid-key` to pass.

### Concrete example B — Azure scenario (`azure/core/basic`)

`main.tsp` in `@azure-tools/azure-http-specs` — a versioned `Azure.Core`
resource service:

```tsp
@scenarioService(
  "/azure/core/basic",
  { versioned: Versions }
)
namespace _Specs_.Azure.Core.Basic;
```
https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/specs/azure/core/basic/main.tsp

Its `mockapi.ts` pins exact Azure-Core conventions across languages — the
merge-patch content type, the `api-version` query param, and the response body:

```ts
Scenarios.Azure_Core_Basic_createOrUpdate = passOnSuccess({
  uri: "/azure/core/basic/users/:id",
  method: "patch",
  request: {
    pathParams: { id: "1" },
    query: { "api-version": "2022-12-01-preview" },
    headers: { "Content-Type": "application/merge-patch+json" },
    body: json({ name: "Madge" }),
  },
  response: { status: 200, body: json(validUser) },
  kind: "MockApiDefinition",
});
```
https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/specs/azure/core/basic/mockapi.ts

This is exactly the kind of behavior that drifts between languages (does the Go
client send `merge-patch+json`? does Python pass `api-version`?). The shared
scenario forces all of them to agree.

### How an emitter's CI runs against the mock server

The emitters now live in `microsoft/typespec` under `packages/http-client-*`
(`http-client-python`, `http-client-js`, `http-client-java`,
`http-client-csharp`). The Python emitter is a clean, fully-readable example.

**Step 1 — regenerate.** The emitter regenerates client code directly from the
two installed spec packages (resolved out of `node_modules`):

```ts
const AZURE_HTTP_SPECS = resolve(PLUGIN_DIR, "node_modules/@azure-tools/azure-http-specs/specs");
const HTTP_SPECS = resolve(PLUGIN_DIR, "node_modules/@typespec/http-specs/specs");
```
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/eng/scripts/ci/regenerate.ts

**Step 2 — spin up the shared mock server and run pytest against it.** The
pytest session fixture launches one `tsp-spector serve` process bound to
`localhost:3000`, serving **both** spec packages so azure and unbranded tests
run together:

```python
SERVER_PORT = 3000
...
azure_http_path = ROOT / "node_modules/@azure-tools/azure-http-specs"
http_path = ROOT / "node_modules/@typespec/http-specs"
...
cmd = f"npx tsp-spector serve {azure_specs} {http_specs}"
```
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/tests/conftest.py

The session-scoped, `autouse=True` `testserver` fixture (same file) starts that
process, waits for readiness by polling the URL, and the generated clients then
issue real HTTP calls to it. CI wiring: `run-tests.ts` builds the wheels and
runs the tox envs in parallel, noting *"The mock server serves both azure and
unbranded specs, so all tests can run together."*
https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/eng/scripts/ci/run-tests.ts

Each language emitter has its own analogous `http-client-<lang>` package that
does the same generate → serve → exercise loop against the identical spec set,
which is what makes the consistency check *cross-language*. Coverage from each
generator is uploaded centrally (`upload-coverage --generatorName … --generatorMode
{standard|azure}` in each spec package's package.json — see §links).

`?? verify`: the exact per-language CI YAML that invokes each non-Python
`http-client-*` test loop (only the Python conftest server-start was read
end-to-end here). Added to DO_NEXT.

---

## 2. `test-proxy` — shared record/replay across all language repos

### What it is

`Azure/azure-sdk-tools/tools/test-proxy` is a single .NET HTTP record/replay
server shared by **every** language SDK repo. Its README explicitly enumerates
the per-language test docs that consume it (Java, JavaScript, .NET, Python, C++,
Go, Rust):
https://github.com/Azure/azure-sdk-tools/blob/249712c6c20bd30210c44b7f666b2c54dfed16c7/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md

A test runs in two modes: **Record** (the proxy sits in front of the live
service, captures requests/responses, applies sanitizers) and **Playback** (the
proxy serves the saved recording, applying matchers). Because all languages use
the *same* proxy binary, they share identical sanitization and request-matching
semantics — a key consistency property, since otherwise each language's
home-grown recorder would diverge.

### How recordings are stored: `azure-sdk-assets` + `assets.json`

Recordings are **not** committed next to the tests. Instead each package carries
an `assets.json` that *targets* a tag in the external `Azure/azure-sdk-assets`
repo, and the proxy restores the recordings on demand.

The `assets.json` format and semantics are documented in the asset-sync README:
https://github.com/Azure/azure-sdk-tools/blob/249712c6c20bd30210c44b7f666b2c54dfed16c7/tools/test-proxy/documentation/asset-sync/README.md

```jsonc
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "python",
  "TagPrefix": "python/core",
  "Tag": "python/core_<10-character-commit-SHA>"
}
```

A **real** example from the Python repo (`sdk/tables/azure-data-tables`):

```json
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "python",
  "TagPrefix": "python/tables/azure-data-tables",
  "Tag": "python/tables/azure-data-tables_97970da74f"
}
```
(fetched via `gh api repos/Azure/azure-sdk-for-python/contents/sdk/tables/azure-data-tables/assets.json`;
`Azure/azure-sdk-assets` confirmed present and MIT-licensed via
`gh api repos/Azure/azure-sdk-assets`.)

Mechanics, per the README:
- A test's `Record/Start` or `Playback/Start` POST sends header
  `x-recording-assets-file` with the relative path to the package's
  `assets.json` (e.g. `sdk/tables/assets.json`).
- The proxy combines the `assets.json` targeting info with the requested
  recording path to **predictably compute** the path inside `azure-sdk-assets`,
  restores that tag into a local `.assets` folder, and serves the recording.
- Updating recordings is a `test-proxy push`, which creates a new tag; only the
  one-line `Tag` SHA changes in the code repo. This keeps the monorepos small
  (*"we store FAR less data per feature"*).

### How this enforces consistency

- One binary → identical sanitizers and matchers in every language.
- One external assets repo with a uniform tag scheme
  (`<lang>/<service>/<package>_<sha>`) → identical storage/retrieval contract.
- Playbacks are byte-for-byte HTTP comparisons, so a behavioral regression in
  any language's request shaping fails that language's playback against a
  recording captured under the agreed contract.

---

## 3. AutoRest-era equivalent: `autorest.testserver`

Yes — `spector`/`cadl-ranch` had a direct legacy predecessor:
**`Azure/autorest.testserver`**, npm `@microsoft.azure/autorest.testserver`,
described as *"Local server offering a variety of APIs that can be used to test
code generated by AutoRest."*
- Repo: https://github.com/Azure/autorest.testserver
- README ("Test server V2"; `autorest-testserver run [--port] [--appendCoverage]
  [--coverageDirectory]`, plus `autorest-testserver-coverage publish`):
  https://github.com/Azure/autorest.testserver/blob/c04d3fe530c00a8095cfc6288d5f7bf1c7f61f38/README.md
- npm package: https://www.npmjs.com/package/@microsoft.azure/autorest.testserver

It is the same idea applied to the AutoRest/Swagger world: a mock server defined
from Swagger JSON (e.g. `swagger/paging.json`) plus mock-api definitions, against
which each AutoRest per-language plugin (autorest.python, autorest.go,
autorest.java, autorest.typescript) generated a client and ran for **coverage**.
The coverage-publish workflow (results pushed back per repo/ref/token) is the
ancestor of spector's `upload-coverage`/`upload-manifest` flow. The newer
markdown-based mock-api authoring style that spector uses was even prototyped
here (PR #245 "New mock server using markdown"), confirming lineage.
- writing-mock-apis doc:
  https://github.com/Azure/autorest.testserver/blob/main/docs/writing-mock-apis.md
- example swagger: https://github.com/Azure/autorest.testserver/blob/main/swagger/paging.json

So the mapping is:

| Era | Spec format | Mock-server suite | Tool CLI | Coverage |
|---|---|---|---|---|
| AutoRest (legacy) | Swagger/OpenAPI 2.0 | `autorest.testserver` (`@microsoft.azure/autorest.testserver`) | `autorest-testserver run` | `autorest-testserver-coverage publish` |
| TypeSpec (current) | `.tsp` scenarios | `@typespec/http-specs` + `@azure-tools/azure-http-specs` | `tsp-spector serve/knock` | `tsp-spector upload-coverage` |
| (intermediate) | `.tsp`/`.cadl` | `@azure-tools/cadl-ranch` (now archived) | `cadl-ranch` | (migrated into spector) |

`?? verify`: the precise commit at which AutoRest plugins switched their CI from
`autorest.testserver` to cadl-ranch/spector (lineage is confirmed, but the exact
cutover SHA per plugin was not pinned). Added to DO_NEXT.

---

## 4. How the two systems together validate cross-language consistency

They operate at different layers and are complementary:

- **`spector` / http-specs validates the generator.** Source of truth = a
  `.tsp` scenario. Each language **regenerates a client from the same spec** and
  must satisfy the **same mock server** (`tsp-spector serve` on :3000). This
  catches *generation* drift: wrong serialization, wrong auth header, missing
  `api-version`, wrong polling/LRO shape, etc. It is run in the **generator**
  repos (`microsoft/typespec/packages/http-client-*`), and the spec packages are
  shared verbatim across languages, so passing means all emitters agree on
  protocol behavior. Coverage manifests make any language's gaps visible
  centrally.

- **`test-proxy` validates the shipped SDK.** Source of truth = a recorded HTTP
  exchange (a tag in `azure-sdk-assets`). Each language SDK replays its real
  (often hand-finished) client against the recording through the **same proxy**,
  with the **same** sanitizer/matcher semantics. This catches *library*
  drift in the published packages, including hand-written shims and convenience
  layers that the generator never sees.

Put differently: spec-scenario testing guarantees **"the same spec produces
clients that behave the same way"**; record/replay guarantees **"the shipped
libraries produce the same wire traffic under a shared, uniform test
contract."** The first is upstream (generator output), the second is downstream
(release artifact), and the shared, centralized assets/spec packages are what
make both checks genuinely cross-language rather than per-repo.

---

## Gaps / `?? verify`

1. Per-language CI YAML for the non-Python `http-client-*` emitters that invokes
   the spector generate→serve→exercise loop (only `http-client-python`'s
   `conftest.py` server-start was read end-to-end).
2. Exact commit/version where each AutoRest plugin moved its CI off
   `autorest.testserver` onto cadl-ranch/spector.
3. Whether `test-proxy` recordings are themselves cross-checked across languages
   (i.e. do multiple languages share/replay the *same* recording tag, or does
   each language own separate tags? The `TagPrefix` is per-language
   `python/…`, `net/…` — suggesting per-language recordings, so test-proxy's
   cross-language guarantee is "same framework/contract," not "same recording").
4. The central coverage dashboard URL that aggregates each generator's
   spector pass-rate (the `upload-manifest`/`upload-coverage` targets a
   `typespec` storage account `coverages` container; the public dashboard render
   URL not yet pinned).
