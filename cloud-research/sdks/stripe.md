# Stripe SDK Code Generation

Research snapshot date: 2026-05-30. All permalinks below are pinned to the
commit SHAs captured at this date.

Pinned commits used:

| Repo | Branch | Pinned SHA |
|------|--------|------------|
| `stripe/openapi` | `master` | `6166e29964f2c1418e2594e89eae75b3f2c0114b` |
| `stripe/stripe-python` | `master` | `6c0388fcdde34eb928f69d48f9895c43b75091da` |
| `stripe/stripe-node` | `master` | `22c7136dd1ac5ad63e905b9a560a37fb00993fc8` |
| `stripe/stripe-go` | `master` | `009c0ac13c6636153153bc636ebf23d9d16e1944` |
| `stripe/stripe-java` | `master` | `288720f7b525ab52c6e67ad0e1c0805f8e103cc5` |
| `stripe/stripe-ruby` | `master` | `c40f8c1ad25affd4d20afff5f47bde28844afe32` |
| `stripe/stripe-php` | `master` | `38b784dd45b447609032c151c40712d9b3feecb0` |
| `stripe/stripe-dotnet` | `master` | `c9c04ba45867d5d8d122ed72794b1f48ba878442` |

## Summary

Stripe runs a textbook "one spec → one internal generator → N per-language
SDKs" pipeline, structurally identical to the cloud SDK model (AWS Smithy,
GCP gapic, Azure AutoRest):

1. The **source of truth is an OpenAPI 3.0 spec**, published publicly at
   `stripe/openapi`. The SDK-flavored variant `spec3.sdk.json` carries extra
   vendor extensions specifically for library generation.
2. That spec is itself **generated from Stripe's internal API definitions**;
   the README states it is "generated via a custom closed-source generator."
3. The seven official SDKs are **code-generated from the OpenAPI spec**. Every
   generated file carries the banner `File generated from our OpenAPI spec`.
4. The **generator is internal/closed-source** ("our private code generator").
   Only the OpenAPI spec is public; the codegen tool is not.
5. The **request/client core is hand-written** per SDK (HTTP, retries, auth,
   pagination, errors); **resource classes + request-param types are
   generated**.

Licenses: `stripe/openapi` and six of the seven SDKs are **MIT**;
`stripe-dotnet` is **Apache-2.0** (verified via the GitHub API license field).

---

## 1. Source of truth: the OpenAPI spec (`stripe/openapi`)

Stripe publishes its API as an OpenAPI 3.0 spec in the public repo
[`stripe/openapi`](https://github.com/stripe/openapi/tree/6166e29964f2c1418e2594e89eae75b3f2c0114b).
The legacy `openapi/` directory holds the per-file spec set, including the two
files that matter for codegen:

- [`openapi/spec3.json`](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/spec3.json)
  — the public OpenAPI 3.0 spec matching the v1 API.
- [`openapi/spec3.sdk.json`](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/spec3.sdk.json)
  — the **SDK** spec (≈10 MB at this commit), an expanded variant with extra
  annotations intended for Stripe-internal library generation.

The repo [README](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/README.md)
draws the distinction explicitly:

> **Public specs** (`spec3.{json,yaml}`) — Use these for most purposes
> **SDK specs** (`spec3.sdk.{json,yaml}`) — Contains special annotations,
> deprecated endpoints, and pre-release features specifically intended to
> support generating Stripe API libraries. Users should typically use the
> public variant instead.

The same README confirms the spec itself is generated from Stripe's own
internal source, not hand-edited OpenAPI:

> The specs provided in this repository do not explicitly target
> [openapi-generator]. They are instead **generated via a custom closed-source
> generator.**

The legacy directory's
[`openapi/README.md`](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/README.md)
reiterates: `spec3.sdk.{json,yaml}` is an "Expanded OpenAPI 3.0 spec intended
for Stripe-internal use" containing "additional OpenAPI extensions for
Stripe-internal use."

Vendor extensions present in the spec (also documented in the README) include
`x-expandableFields`, `x-expansionResources`, and `x-resourceId` — these feed
SDK features like object expansion and fixtures.

> Note: newer GA/preview specs unifying v1+v2 endpoints live under
> [`/latest/`](https://github.com/stripe/openapi/tree/6166e29964f2c1418e2594e89eae75b3f2c0114b/latest)
> and `/preview/`, but the SDK pipeline historically consumes the
> `openapi/spec3.sdk.*` files.

### Example 1 — head of `spec3.sdk.json` (raw, pinned)

```json
{
  "components": {
    "schemas": {
      "account": {
        "description": "For new integrations, we recommend using the [Accounts v2 API] ...
```
(from
[`openapi/spec3.sdk.json`](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/spec3.sdk.json),
fetched via the pinned raw URL.)

---

## 2. The SDKs are code-generated from the spec

All seven official SDKs mark generated files with the banner
`File generated from our OpenAPI spec` at the very top of the file. Verified
per language at the pinned SHAs (the `Account` resource is shown for each):

| SDK | Generated file | Banner |
|-----|----------------|--------|
| Python | [`stripe/_account.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_account.py) | `# File generated from our OpenAPI spec` |
| Node | [`src/resources/Accounts.ts`](https://github.com/stripe/stripe-node/blob/22c7136dd1ac5ad63e905b9a560a37fb00993fc8/src/resources/Accounts.ts) | `// File generated from our OpenAPI spec` |
| Go | [`account.go`](https://github.com/stripe/stripe-go/blob/009c0ac13c6636153153bc636ebf23d9d16e1944/account.go) | `// File generated from our OpenAPI spec` |
| Java | [`src/main/java/com/stripe/model/Account.java`](https://github.com/stripe/stripe-java/blob/288720f7b525ab52c6e67ad0e1c0805f8e103cc5/src/main/java/com/stripe/model/Account.java) | `// File generated from our OpenAPI spec` |
| Ruby | [`lib/stripe/resources/account.rb`](https://github.com/stripe/stripe-ruby/blob/c40f8c1ad25affd4d20afff5f47bde28844afe32/lib/stripe/resources/account.rb) | `# File generated from our OpenAPI spec` |
| PHP | [`lib/Account.php`](https://github.com/stripe/stripe-php/blob/38b784dd45b447609032c151c40712d9b3feecb0/lib/Account.php) | `// File generated from our OpenAPI spec` |
| .NET | [`src/Stripe.net/Entities/Accounts/Account.cs`](https://github.com/stripe/stripe-dotnet/blob/c9c04ba45867d5d8d122ed72794b1f48ba878442/src/Stripe.net/Entities/Accounts/Account.cs) | `// File generated from our OpenAPI spec` |

### Example 2 — generated resource header (stripe-go `account.go`)

```go
//
//
// File generated from our OpenAPI spec
//
//
```

The Python repo's
[`CONTRIBUTING.md`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/CONTRIBUTING.md)
spells out the generated/hand-written split and the two marker styles:

> This project has a combination of manually maintained code and code
> generated from **our private code generator**. [...] To identify files with
> purely generated code, look for the comment `File generated from our OpenAPI
> spec.` at the start of the file. Generated blocks of code **within
> hand-written files** will be between comments that say `The beginning of the
> section generated from our OpenAPI spec` and `The end of the section
> generated from our OpenAPI spec`.

This confirms two generation granularities: whole-file (resources/params) and
inline blocks inside otherwise hand-written files. The inline-block markers are
present in, e.g.,
[`stripe/_error.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_error.py)
(generated error-class section) and
[`stripe/v2/__init__.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/v2/__init__.py).

---

## 3. The generator (internal / closed-source)

Stripe's SDK generator is **not public**. The only public artifact is the
OpenAPI spec; the tool that consumes `spec3.sdk.json` and emits per-language
code is internal:

- `stripe-python` CONTRIBUTING.md: "code generated from **our private code
  generator**" and "we will likely need to make a change to **our code
  generator** before accepting the contribution"
  ([source](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/CONTRIBUTING.md)).
- `stripe/openapi` README: the spec is "generated via a **custom closed-source
  generator**"
  ([source](https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/README.md)).

**Public trace of how it works.** Brandur Leach (a longtime Stripe engineer)
describes the system in a public fragment, ["The state of Stripe API library
codegen"](https://brandur.org/fragments/stripe-codegen):

> A JavaScript program reads OpenAPI and uses it to codegen API library code in
> all support[ed] languages.

and that there are multiple variants:

> There are a few variants of it – one very complete version for internal use,
> one version for the Dashboard, and a public version.

This matches the prompt's premise (an internal `sdk-codegen`-style generator
consuming the SDK spec). The specific repository/tool name `sdk-codegen` is
**not visible in any public Stripe repo** — `?? verify` the exact internal name;
what is firmly established publicly is (a) it is a single internal generator,
(b) it is closed-source, and (c) it consumes the OpenAPI spec to emit all
languages.

---

## 4. Generated vs hand-written

The division of labor, confirmed from the Python repo's own
[`.claude/CLAUDE.md`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da)
guidance file (surfaced via `gh search code`) and from file headers:

**Generated (carry the banner):**
- Resource model classes — e.g.
  [`stripe/_account.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_account.py),
  `stripe/_customer.py`, everything under `stripe/resources/`.
- Service classes — e.g.
  [`stripe/entitlements/_feature_service.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/entitlements/_feature_service.py).
- Request param TypedDicts — the entire
  [`stripe/params/`](https://github.com/stripe/stripe-python/tree/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/params)
  tree (e.g. `_promotion_code_create_params.py`).

**Hand-written (NO banner) — the transport/client core:**
- [`stripe/_api_requestor.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_api_requestor.py)
  — request construction, auth headers, response/error decoding (verified: no
  generation banner; `grep` for "File generated" returns 0).
- [`stripe/_http_client.py`](https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_http_client.py)
  — HTTP client abstraction, retries, backoff (`time`, `random`, `RequestMetrics`).
- `stripe/_stripe_client.py`, `stripe/_client_options.py` — client wiring/config.

The Python repo's internal `.claude/CLAUDE.md` states it directly:

> The HTTP client layer (`_http_client.py`, `_stripe_client.py`,
> `_api_requestor.py`, `_client_options.py`) is NOT generated.

The same hand-written-core pattern holds in other SDKs, e.g. stripe-node's
[`src/StripeResource.ts`](https://github.com/stripe/stripe-node/blob/22c7136dd1ac5ad63e905b9a560a37fb00993fc8/src/StripeResource.ts)
(no banner) and stripe-go's package entrypoint
[`stripe.go`](https://github.com/stripe/stripe-go/blob/009c0ac13c6636153153bc636ebf23d9d16e1944/stripe.go)
(no banner), versus the banner-marked `account.go`.

### Example 3 — hand-written core (stripe-python `_http_client.py`, head)

```python
from io import BytesIO
import textwrap
import email
import time
import random
...
from stripe._request_metrics import RequestMetrics
```
No generation banner — this is the manually maintained transport layer.

---

## 5. Multi-language strategy

```
Stripe internal API definitions
        │  (custom closed-source generator)
        ▼
stripe/openapi : spec3.json  +  spec3.sdk.json   ← public OpenAPI 3.0
        │
        ▼  (internal "sdk-codegen"-style generator, NOT public,
        │   consumes spec3.sdk.json + vendor extensions)
        ▼
 ┌───────────┬───────────┬──────────┬───────────┬──────────┬─────────┬───────────┐
 │ python    │ node      │ go       │ java      │ ruby     │ php     │ dotnet    │
 │ resources │ resources │ resources│ resources │ resources│ resources│ entities │
 │ + params  │ + params  │ + params │ + params  │ + params │ + params│ + params  │
 └───────────┴───────────┴──────────┴───────────┴──────────┴─────────┴───────────┘
   each SDK's HTTP/retry/auth/pagination/error CORE is hand-written per language
```

This is the **per-language-codegen model** — one IDL (OpenAPI), one internal
generator emitting all languages, with a hand-authored runtime/core per SDK.
It mirrors the cloud-provider approach documented in `CODE_GENERATION.md`
(AWS Smithy → smithy codegen; GCP protobuf → gapic-generator; Azure
TypeSpec/OpenAPI → AutoRest), the key difference being that **Stripe's
generator is closed-source** whereas AWS/GCP/Azure publish theirs.

---

## Gaps / `?? verify`

- **Exact internal generator name/repo.** The prompt names it `sdk-codegen`.
  No public Stripe repo or doc surfaces that exact name; what is public is only
  that it is a single internal, closed-source JS generator (Brandur fragment +
  CONTRIBUTING.md "our private code generator"). `?? verify` the precise name.
- **Which spec file the generator actually reads** (`openapi/spec3.sdk.json`
  vs the newer unified `latest/`/`preview/` SDK specs) is not stated in any
  public file; inferred from the "intended to support generating Stripe API
  libraries" wording on the `.sdk.*` files. `?? verify`.
- **Per-language template/post-processor mechanics** (how overrides are
  expressed, analogous to AutoRest directives or Smithy customizations) are not
  observable because the generator is closed-source. Only the
  generated-vs-handwritten boundary is publicly visible (file banners + inline
  section markers).

---

## Links

OpenAPI spec repo (`stripe/openapi`, MIT):
- Repo (pinned): https://github.com/stripe/openapi/tree/6166e29964f2c1418e2594e89eae75b3f2c0114b
- README: https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/README.md
- `openapi/README.md`: https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/README.md
- `spec3.json`: https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/spec3.json
- `spec3.sdk.json`: https://github.com/stripe/openapi/blob/6166e29964f2c1418e2594e89eae75b3f2c0114b/openapi/spec3.sdk.json

SDK repos (pinned), MIT unless noted:
- Python: https://github.com/stripe/stripe-python/tree/6c0388fcdde34eb928f69d48f9895c43b75091da
  - generated resource `stripe/_account.py`: https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_account.py
  - hand-written `stripe/_api_requestor.py`: https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_api_requestor.py
  - hand-written `stripe/_http_client.py`: https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/stripe/_http_client.py
  - `CONTRIBUTING.md` ("our private code generator"): https://github.com/stripe/stripe-python/blob/6c0388fcdde34eb928f69d48f9895c43b75091da/CONTRIBUTING.md
- Node: https://github.com/stripe/stripe-node/tree/22c7136dd1ac5ad63e905b9a560a37fb00993fc8
  - `src/resources/Accounts.ts`: https://github.com/stripe/stripe-node/blob/22c7136dd1ac5ad63e905b9a560a37fb00993fc8/src/resources/Accounts.ts
  - `src/StripeResource.ts` (core): https://github.com/stripe/stripe-node/blob/22c7136dd1ac5ad63e905b9a560a37fb00993fc8/src/StripeResource.ts
- Go: https://github.com/stripe/stripe-go/tree/009c0ac13c6636153153bc636ebf23d9d16e1944
  - `account.go`: https://github.com/stripe/stripe-go/blob/009c0ac13c6636153153bc636ebf23d9d16e1944/account.go
  - `stripe.go` (core): https://github.com/stripe/stripe-go/blob/009c0ac13c6636153153bc636ebf23d9d16e1944/stripe.go
- Java: https://github.com/stripe/stripe-java/tree/288720f7b525ab52c6e67ad0e1c0805f8e103cc5
  - `Account.java`: https://github.com/stripe/stripe-java/blob/288720f7b525ab52c6e67ad0e1c0805f8e103cc5/src/main/java/com/stripe/model/Account.java
- Ruby: https://github.com/stripe/stripe-ruby/tree/c40f8c1ad25affd4d20afff5f47bde28844afe32
  - `lib/stripe/resources/account.rb`: https://github.com/stripe/stripe-ruby/blob/c40f8c1ad25affd4d20afff5f47bde28844afe32/lib/stripe/resources/account.rb
- PHP: https://github.com/stripe/stripe-php/tree/38b784dd45b447609032c151c40712d9b3feecb0
  - `lib/Account.php`: https://github.com/stripe/stripe-php/blob/38b784dd45b447609032c151c40712d9b3feecb0/lib/Account.php
- .NET (**Apache-2.0**): https://github.com/stripe/stripe-dotnet/tree/c9c04ba45867d5d8d122ed72794b1f48ba878442
  - `src/Stripe.net/Entities/Accounts/Account.cs`: https://github.com/stripe/stripe-dotnet/blob/c9c04ba45867d5d8d122ed72794b1f48ba878442/src/Stripe.net/Entities/Accounts/Account.cs

Background / public trace of the generator:
- Brandur Leach, "The state of Stripe API library codegen": https://brandur.org/fragments/stripe-codegen
