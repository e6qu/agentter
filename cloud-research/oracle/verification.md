# OCI SDK Cross-Language Verification — How OCI Keeps the 4 SDKs Consistent

> **Evidence basis.** OCI's SDK generator (`OracleSDKGenerator`) and **the bulk of
> its test infrastructure are closed-source / internal.** This document records
> only what is publicly visible in the published SDK repos, and marks the rest
> "not public". Claims are tagged **[EVIDENCE]** (verified against a pinned file)
> or **[INFERENCE]** (reasoned). `?? verify:` marks open gaps. No internal test
> framework is invented here — where we name one (`SDKTestingService`), it is
> because the *public* repos contain a client for it and quote its contract.

Commit pins (HEAD of `master`, verified via `gh api .../git/ref/heads/master` on
2026-05-30 — all four still current):
- `oci-go-sdk`         @ `ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368`
- `oci-python-sdk`     @ `b84a275083f27c6d56b635a7ad60f477d1a2849b`
- `oci-java-sdk`       @ `013bb11dca68f84ec10a8e48e99855dfbb3a8f13`
- `oci-typescript-sdk` @ `8c11d0c62800f284cc12d59cb9052518d1f9bea1`
- `oci-cli`            @ `385f594d3bab0e5a17d9f97f6980b1772af6022e`

---

## TL;DR

OCI's cross-language consistency is enforced **internally**, but the public repos
leak two concrete signals:

1. **A partially-public, cross-language test harness exists.** The Python SDK and
   the Python CLI both ship a client for an internal HTTP service literally named
   **`SDKTestingService`** (`localhost:8090/SDKTestingService`). The harness is
   *language-agnostic by design*: each language sends a `lang` parameter
   (`"Python"`, `"PythonCLI"`), pulls **shared request inputs** from the service,
   drives its own SDK, and POSTs the SDK's **response back to the service for
   validation** against a canonical (Java) type model. The Go, Java, and
   TypeScript repos do **not** expose this harness publicly. **[EVIDENCE]**
2. **Synchronized weekly releases with identical feature lists across all 4
   languages** — indirect evidence of one internal generation+validation pipeline
   that regenerates and ships every language from the same spec batch. **[EVIDENCE
   for the synchronization; INFERENCE for the single pipeline.]**

Public per-language test *files* are sparse and **only cover hand-written code**
(signing/auth/`common`, the Object Storage transfer manager). **No generated
service client has a checked-in unit test in any of the 4 public repos.** The
real per-API behavioral testing runs against the internal `SDKTestingService` and
is **not public**.

---

## Q1 — Is there a public shared / cross-language test corpus?

**Answer: There is a public *client* for a shared cross-language test *service*,
but no shared static test *corpus* (no checked-in fixtures). The per-API test
inputs and expected outputs are served at runtime by the internal
`SDKTestingService`, which is not public.**

### 1a. What test files actually exist per repo (verified from recursive git trees)

**Go (`oci-go-sdk`)** — 71 `_test.go` files total, and **every one is in
hand-written code**, none in a generated service client:
- `common/*_test.go` (21 files) — signing, retry, circuit breaker, client plumbing
- `example/*_test.go` (45 files) — runnable example/integration tests
- `objectstorage/transfer/*_test.go` (5 files) — the hand-written transfer manager
- **[EVIDENCE]** No generated service client (e.g. `objectstorage/objectstorage_client.go`,
  `queue/`, `ons/`, `functions/`) has a `_test.go`. No `testdata/` directory exists
  anywhere in the tree.
  Tree: https://github.com/oracle/oci-go-sdk/tree/ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368
  Transfer-manager tests (hand-written surface): https://github.com/oracle/oci-go-sdk/tree/ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368/objectstorage/transfer

**Java (`oci-java-sdk`)** — tests exist **only** in hand-written modules; **no
`src/test/` exists under any `*-generated` module**:
- `bmc-common` (113 test files), `bmc-common-httpclient*`, `bmc-encryption`,
  `bmc-enforcer-rules`, `bmc-addons/*`, and `bmc-objectstorage/bmc-objectstorage-extensions`
  (36 files — the hand-written Object Storage extension).
- **[EVIDENCE]** Filtering the recursive tree for `src/test/` AND `generated`
  returns **zero** results — the generated service clients carry no unit tests in
  the public repo.
  Tree: https://github.com/oracle/oci-java-sdk/tree/013bb11dca68f84ec10a8e48e99855dfbb3a8f13

**TypeScript (`oci-typescript-sdk`)** — `.spec.ts` tests live only in
hand-written cores:
- `lib/common/tests/*.spec.ts` (signing, config, region, serializer, circuit
  breaker, request/response generators) and `lib/objectstorage/tests/*.spec.ts`
  (chunker, blob handling).
- **[EVIDENCE]** No generated service client package (`lib/functions`, `lib/queue`,
  `lib/ons`, etc.) has any test; the only `resources/` under tests are config
  samples, a fake PEM, and binary blobs for the hand-written code — not
  spec-derived fixtures.
  `lib/common/tests`: https://github.com/oracle/oci-typescript-sdk/tree/8c11d0c62800f284cc12d59cb9052518d1f9bea1/lib/common/tests

**Python (`oci-python-sdk`)** — the **only** repo of the four that ships a `tests/`
directory wired to the cross-language harness:
- `tests/testing_service_client.py` — the `SDKTestingService` client (see Q1b).
- `tests/conftest.py` — pytest fixtures, `--test-mode service|mock`, VCR record mode.
- `tests/autogentest/test_model.py` — generic model round-trip tests (construct
  `oci.core.models.Instance`, assert equality / `to_dict` / subtype handling). This
  is **generic model-layer testing, hand-written, not per-service generated.**
  https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/autogentest/test_model.py
- `tests/unit/` — `test_basic_api_calls.py` (a handful of live `list_users` /
  `list_vcns` calls), `test_waiters.py`, `test_response.py`.
- `tests/integ/test_launch_instance_tutorial.py` — one integration tutorial test.
  Directory: https://github.com/oracle/oci-python-sdk/tree/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests

**[INFERENCE]** The published per-language tests are a thin, hand-written slice
(core plumbing + a few smoke/integration tests). The systematic per-API
correctness testing is delegated to the internal `SDKTestingService`, whose
inputs/expected-outputs are **not checked into the public repos**.

### 1b. The cross-language test harness (`SDKTestingService`) — partially public

**[EVIDENCE]** `oci-python-sdk/tests/testing_service_client.py` is a client for an
internal HTTP service. Verbatim:
```python
SERVICE_PORT = '8090'
SERVICE_ROOT_URL = 'http://{hostname}:{port}/SDKTestingService'.format(...)
SERVICE_LANGUAGE = "Python"

class TestingServiceClient:
    def get_test_config(self, service_name, client_name, api_name): ...
    def get_requests(self, service_name, api_name): ...
    def validate_result(self, service_name, api_name, container_id, request,
                        oci_responses, service_error, data_field_name,
                        is_delete_operation, is_paginated_call): ...
    def create_session(self): ...
    def is_api_enabled(self, service_name, api_name): ...
    def get_endpoint(self, service_name, client_name, api_name): ...
```
https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/testing_service_client.py#L13-L16

The protocol that makes this **cross-language** (not just a Python test):
- It passes a `lang` query param on every call (`"Python"` here) — the same
  service serves multiple languages.
- `get_requests()` pulls **shared request inputs** from the service, keyed by
  `(serviceName, apiName)`, so all languages exercise the **same input set**.
- `validate_result()` POSTs the SDK's response **back to the service** to be
  validated. The expected types are expressed in the **Java SDK namespace** — the
  docstring states the service builds the reference object via
  `String.format("com.oracle.bmc.%s.requests.%sRequest", serviceName, apiName)`
  and the code maps the Python response into Java request/response class names
  (`com.oracle.bmc.{pkg}.requests.{Api}Request` /
  `...responses.{Api}Response`).
  https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/testing_service_client.py#L54-L66
  https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/testing_service_client.py#L93-L131
- **[INFERENCE]** Java is the **canonical reference type model** in the harness:
  every other language's request/response is validated by converting it to the
  Java SDK's class/field shape. This is a strong cross-language consistency
  mechanism — one shared input corpus + one canonical schema, checked per API per
  language. But the corpus and the service itself are internal.

**[EVIDENCE]** The CLI ships the same harness client, parameterized for a
different `lang`:
```python
SERVICE_PATH = 'SDKTestingService'
SERVICE_LANGUAGE = "PythonCLI"
DEFAULT_TESTING_SERVICE_PORT = '8090'   # host/port overridable via OCI_CLI_TESTING_SERVICE_* env vars
class CLITestingServiceClient: ...
```
https://github.com/oracle/oci-cli/blob/385f594d3bab0e5a17d9f97f6980b1772af6022e/tests/cli_testing_service_client.py#L13-L28

**[EVIDENCE]** Org-wide code search (`SDKTestingService org:oracle`) returns only
**3** hits — all in `oci-python-sdk` and `oci-cli`
(`tests/testing_service_client.py`, `tests/cli_testing_service_client.py`,
`tests/test_config_container.py`). **`TestingServiceClient` (4 hits)** is confined
to the same two repos. The Go (`oci-go-sdk`), Java (`oci-java-sdk`), and
TypeScript (`oci-typescript-sdk`) repos contain **no** reference to
`SDKTestingService` — verified directly: searching `oci-go-sdk` for
`SDKTestingService` returns 0; the `8090` hits in `oci-go-sdk` are false positives
(port literals inside generated clients, e.g. `announcementsservice_*.go`), not
test harness references.

**[INFERENCE]** The same harness almost certainly drives Go / Java / TS internally
(they release in lockstep — see Q2), but **their harness clients are not public**.
We see the harness only because Python (and the Python-based CLI) happen to expose
their client.

**?? verify / not public:** the `SDKTestingService` server implementation, the
test corpus it serves (`get_requests` payloads), the per-language enablement
matrix (`is_api_enabled`), and whether Go/Java/TS keep their harness clients in a
private fork. None of these are in public repos.

---

## Q2 — Synchronized weekly releases as indirect evidence of one pipeline

**[EVIDENCE]** All four SDKs cut releases on the **same dates** with **identical
service feature lists**. Re-confirmed from the pinned CHANGELOGs (each repo's own
running semver, but matched dates and matched bullet content):

| Lang | Latest two entries (date) | CHANGELOG |
|------|---------------------------|-----------|
| Go | `65.116.0 - 2026-05-26`, `65.115.0 - 2026-05-19` | https://github.com/oracle/oci-go-sdk/blob/ae06daeddf367a7e56c35eb5a8b9bf2ceb8f9368/CHANGELOG.md |
| Python | `2.176.0 - 2026-05-26`, `2.175.0 - 2026-05-19` | https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/CHANGELOG.rst |
| Java | `3.88.0 - 2026-05-26`, `3.87.0 - 2026-05-19` | https://github.com/oracle/oci-java-sdk/blob/013bb11dca68f84ec10a8e48e99855dfbb3a8f13/CHANGELOG.md |
| TypeScript | `2.133.0 - 2026-05-26`, `2.132.0 - 2026-05-19` | https://github.com/oracle/oci-typescript-sdk/blob/8c11d0c62800f284cc12d59cb9052518d1f9bea1/CHANGELOG.md |

The 2026-05-26 entries are word-for-word the same across languages (e.g. the
`me-alrayyan-1` region support, GoldenGate ZeroETL bullets, the Data Science IDCS
breaking change).

**[INFERENCE]** Identical, simultaneous, cross-language feature drops imply: one
internal spec batch → one generation run → all four languages regenerated and
validated together (plausibly through the `SDKTestingService` harness from Q1) →
synchronized publish. The lockstep cadence is the **strongest public indirect
evidence of a single internal generation + validation pipeline**. The pipeline's
CI orchestration is not public (the legacy `wercker.yml` in `oci-python-sdk` hints
Wercker once ran build/test, but generation runs upstream of GitHub).
https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/wercker.yml

---

## Q3 — Do the SDKs share spec-derived test data (example req/resp from the spec)?

**Answer: Not in the public repos. There are no checked-in spec-derived
request/response fixtures, `testdata/` directories, or shared example payloads in
any of the 4 SDK repos. The per-API test data is served at runtime by
`SDKTestingService` (`get_requests` / `validate_result`), which is internal.**

- **[EVIDENCE]** Go: recursive tree has no `testdata/` and no fixture files; the
  only `golden`/`testdata`-substring hits are the **GoldenGate service** and
  unrelated source files (false positives).
- **[EVIDENCE]** TypeScript: no `testdata`/`fixture` directories; `lib/common/tests/resources`
  holds only config samples, a fake RSA key, region JSON, and binary blobs for
  unit tests — not spec-derived API fixtures.
  https://github.com/oracle/oci-typescript-sdk/tree/8c11d0c62800f284cc12d59cb9052518d1f9bea1/lib/common/tests/resources
- **[EVIDENCE]** Python: `tests/` contains only `.py` test code plus a
  `tests/configuration/config.sample`; no per-service JSON/YAML request-response
  fixtures. The request inputs come from `SDKTestingService.get_requests()` at
  runtime, not from a static file.
  https://github.com/oracle/oci-python-sdk/blob/b84a275083f27c6d56b635a7ad60f477d1a2849b/tests/testing_service_client.py#L54-L91
- **[EVIDENCE]** Java: no `src/test/` resources under generated modules (Q1a).
- **[INFERENCE]** The "shared test data" therefore exists, but **lives behind the
  `SDKTestingService` HTTP API**, served per `(service, api, lang)` — it is the
  cross-language shared corpus, just not materialized as files in Git. **?? verify
  / not public:** the actual payloads.

A separate note: the published clients **do not embed raw OpenAPI/Swagger spec
files** either (only the date-versioned `OpenAPI spec version: NNNN` string in
generated client headers — see `oracle/notes.md` §1). So there is no public
spec to derive fixtures from in the first place.

---

## Q4 — Evidence vs inference, and what is explicitly NOT public

**[EVIDENCE] (directly verified against pinned files):**
- Per-language public test files cover **only hand-written code** (signing/auth/
  `common`, transfer manager); **no generated service client has a checked-in
  unit test** in any of the 4 repos.
- A cross-language test harness client (`SDKTestingService`, port 8090) is present
  in `oci-python-sdk` and `oci-cli`, with a `lang`-parameterized protocol,
  shared request fetch (`get_requests`), and response validation against the
  **Java** canonical type model (`com.oracle.bmc.*`).
- The harness client appears in **no** Go/Java/TS public repo (search + direct
  grep both confirm absence).
- Synchronized, identical-content weekly releases across all 4 languages.

**[INFERENCE]:**
- A single internal generation + validation pipeline regenerates all 4 SDKs from
  one spec batch and validates them via `SDKTestingService` before the synchronized
  publish.
- Java's request/response types are the **canonical reference schema** for
  cross-language equivalence (because the harness expresses expectations in
  `com.oracle.bmc.*` namespaces).
- Go/Java/TS use the same harness internally (lockstep releases imply shared
  validation), with private harness clients.

**Explicitly NOT public (`?? verify`):**
- The `SDKTestingService` **server** and its served **test corpus** (request
  inputs + expected responses). Not in any public repo.
- Go/Java/TS harness clients (if they exist as separate code) — private.
- The CI/build orchestration that runs the harness and gates the release.
- Any per-service generator customization/override config (analogous to Smithy
  customizations / AutoRest directives) — see `oracle/notes.md` §4. Not visible.

**Not invented here:** the only test framework named in this document
(`SDKTestingService`) is named because the *public* Python SDK and CLI ship a
client that talks to it and quotes its endpoints/contract. We do **not** claim any
specifics about its internal implementation.
