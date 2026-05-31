# How Google Cloud verifies cross-language GAPIC consistency

This note documents how Google verifies that its GAPIC client libraries
behave consistently across languages (Python, Java, Go, TypeScript/Node)
given the same source protos. Three mechanisms work together:

1. **`gapic-showcase`** — a shared conformance server + protos that every
   GAPIC generator runs integration tests against, including a
   language-agnostic JSON corpus (`compliance_suite.json`).
2. **Per-generator golden/baseline tests** — each generator pins its
   emitted output for fixed input protos.
3. **Product-level cross-language conformance corpora**
   (`googleapis/conformance-tests`) — shared JSON/proto test cases that
   Storage / Firestore / Bigtable clients in every language run.

Pinned SHAs used below:

- `googleapis/gapic-showcase` `b748cc09e35086c2bcbcd82ecc39dfcbed417221`
- `googleapis/gapic-generator-python` `5f2ad19546814408feeab2bd8a62218276f3432f`
- `googleapis/sdk-platform-java` (gapic-generator-java) `febe86f1ea4f0b5e6d8454024ed499adb7dc9328`
- `googleapis/gapic-generator-go` `df09eaf023d80438e826f304e4d03d86519c6d04`
- `googleapis/gapic-generator-typescript` `ed34a7351630e0c9003c6f68a2725d744055066f`
- `googleapis/conformance-tests` `998891a8dae00df121e460420cceb0abfc4e2ea1`

---

## 1. `gapic-showcase`: the shared conformance server

`gapic-showcase` is "an API that demonstrates Generated API Client (GAPIC)
features and common API patterns used by Google… This project provides a
server and client implementation of the API that can be run locally over
both gRPC and HTTP/JSON." (README, lines 1-11)
[README](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/README.md)

### What it defines (the showcase protos)

The canonical service definitions live under
[`schema/google/showcase/v1beta1/`](https://github.com/googleapis/gapic-showcase/tree/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1):

- `echo.proto` — `Echo` service: the four RPC shapes (unary, server-/
  client-side streaming, bidi), plus delay and pagination. It carries the
  same `google.api.*` annotations real Google APIs use (`google.api.http`,
  `google.api.routing`, `google.api.api_version`).
  [echo.proto](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/echo.proto)
- `identity.proto` — `Identity` service: a simple CRUD resource service
  (`User`), exercising resource-name patterns / pagination.
  [identity.proto](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/identity.proto)
- `messaging.proto` — `Messaging` service: chat rooms/blurbs, LROs and
  streaming.
  [messaging.proto](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/messaging.proto)
- `compliance.proto` — the cross-language workhorse. Its own doc comment
  states the intent (lines 26-29):

  > This service is used to test that GAPICs implement various REST-related
  > features correctly. This mostly means transcoding proto3 requests to
  > REST format correctly for various types of HTTP annotations, but it
  > also includes verifying that unknown (numeric) enums received by
  > clients can be round-tripped correctly.

  It defines `RepeatDataBody`, `RepeatDataBodyInfo`, `RepeatDataQuery`,
  `RepeatDataSimplePath`, etc., each exercising a different
  `google.api.http` annotation shape.
  [compliance.proto](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/compliance.proto)
- `sequence.proto`, `testing.proto`, `rest_error.proto` — retry sequences,
  test orchestration, and REST error-mapping fixtures.

The shared, language-agnostic test corpus is
[`compliance_suite.json`](https://github.com/googleapis/gapic-showcase/blob/b748cc09e35086c2bcbcd82ecc39dfcbed417221/schema/google/showcase/v1beta1/compliance_suite.json):
groups of `RepeatRequest` payloads run against each `Compliance.RepeatData*`
RPC. The first group, "Fully working conversions, no resources", lists all
six RPCs and a "Basic data types" request that round-trips every proto
scalar type (`fInt32`, `fSint32`, `fSfixed32`, `fFixed64`, `fDouble`,
`fKingdom` enum, plus `optional`/`proto3` `p*` fields). The *same JSON file*
is what each language's test harness loads, so all languages assert
identical transcoding/round-trip behavior.

### How per-language SDKs run integration tests against it

Generators don't ship the showcase server; they download a pinned release
(descriptor set + retry config + prebuilt server binary), generate a client
from the showcase protos with the **locally built** generator, start the
server on port 7469, and run a per-language test suite against it.

- **Go** — [`showcase/`](https://github.com/googleapis/gapic-generator-go/tree/df09eaf023d80438e826f304e4d03d86519c6d04/showcase)
  submodule. Its README (lines 1-32) spells out the flow: download showcase
  artifacts, regenerate the Go GAPIC with the locally installed generator,
  swap the `go.mod` dep to the local artifacts, start the server, run tests,
  stop the server.
  [showcase/README.md](https://github.com/googleapis/gapic-generator-go/blob/df09eaf023d80438e826f304e4d03d86519c6d04/showcase/README.md).
  `TestComplianceSuite` reads `compliance_suite.json` (via
  `getComplianceSuite()`) and drives each `Compliance.RepeatData*` RPC over
  the REST transport.
  [compliance_test.go](https://github.com/googleapis/gapic-generator-go/blob/df09eaf023d80438e826f304e4d03d86519c6d04/showcase/compliance_test.go)
- **Python** — the `showcase` nox session downloads the
  `gapic-showcase-<version>.desc` descriptor and `showcase_v1beta1.yaml`
  from the showcase GitHub release, runs `grpc_tools.protoc` with the local
  `--python_gapic_out` plugin to emit a `google.showcase` client
  (`transport=grpc+rest`), installs it, then runs `tests/system` against the
  server.
  [noxfile.py](https://github.com/googleapis/gapic-generator-python/blob/5f2ad19546814408feeab2bd8a62218276f3432f/noxfile.py)
  (see `showcase_version`, `showcase_library()`, `showcase()`). The system
  tests import `google.showcase` clients over an insecure channel.
  [tests/system/conftest.py](https://github.com/googleapis/gapic-generator-python/blob/5f2ad19546814408feeab2bd8a62218276f3432f/tests/system/conftest.py),
  [tests/system/](https://github.com/googleapis/gapic-generator-python/tree/5f2ad19546814408feeab2bd8a62218276f3432f/tests/system)
  (e.g. `test_unary.py`, `test_streams.py`, `test_pagination.py`,
  `test_mixins.py`).
- **Java** — `.kokoro/presubmit/showcase-native.sh` downloads the showcase
  server release (`gapic-showcase-<version>-linux-amd64.tar.gz`) and runs
  the `java-showcase` module's integration tests.
  [showcase-native.sh](https://github.com/googleapis/sdk-platform-java/blob/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/.kokoro/presubmit/showcase-native.sh).
  The IT suite lives at
  [`java-showcase/gapic-showcase/src/test/.../it/`](https://github.com/googleapis/sdk-platform-java/tree/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/java-showcase/gapic-showcase/src/test/java/com/google/showcase/v1beta1/it)
  (`ITUnaryCallable`, `ITPagination`, `ITServerSideStreaming`,
  `ITHttpAnnotation`, …). Crucially, `ITHttpAnnotation.java` loads the
  **same** `compliance_suite.json` and runs the same RepeatData* RPCs as the
  Go test (comment at line 50: "This test runs from the parameters in the
  compliance_suite.json file"; lines 70-103 build a `ComplianceSuite` from
  the resource and iterate `Compliance.RepeatDataBody` /
  `RepeatDataBodyInfo` / `RepeatDataQuery` / `RepeatDataSimplePath`).
  [ITHttpAnnotation.java](https://github.com/googleapis/sdk-platform-java/blob/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/java-showcase/gapic-showcase/src/test/java/com/google/showcase/v1beta1/it/ITHttpAnnotation.java),
  [compliance_suite.json (Java copy)](https://github.com/googleapis/sdk-platform-java/blob/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/java-showcase/gapic-showcase/src/test/resources/compliance_suite.json)
- **TypeScript/Node** — the showcase protos are consumed as generator input
  fixtures (e.g.
  [`baselines/disable-packing-test/protos/google/showcase/v1beta1/*.proto.baseline`](https://github.com/googleapis/gapic-generator-typescript/tree/ed34a7351630e0c9003c6f68a2725d744055066f/baselines/disable-packing-test/protos/google/showcase/v1beta1)).
  ?? verify — locate the Node end-to-end showcase *server* integration suite
  (it historically lives in `gapic-generator-typescript` `showcase`/
  `test-application` or in `google-cloud-node`); the in-repo evidence here
  is generator-input baselines, not a live-server run.

**Concrete cross-language example.** Go's `showcase/compliance_test.go`
`TestComplianceSuite` and Java's `it/ITHttpAnnotation.java` both load the
byte-identical `compliance_suite.json` and invoke the identical RPC set
(`Compliance.RepeatDataBody`, `RepeatDataBodyInfo`, `RepeatDataQuery`,
`RepeatDataSimplePath`) against the same showcase server binary. Same input
corpus + same server + per-language generated client = a direct proof that
the two languages transcode and round-trip identically.

---

## 2. Generator golden / baseline tests

Each generator pins its emitted source for fixed input protos, so a code
change that alters output is caught in review.

- **Python** — `tests/integration/` runs the generator over real API protos
  (asset, redis, logging, eventarc, credentials, …) and byte-compares the
  output tree against checked-in goldens under
  [`tests/integration/goldens/`](https://github.com/googleapis/gapic-generator-python/tree/5f2ad19546814408feeab2bd8a62218276f3432f/tests/integration/goldens).
  The comparison is Bazel-driven: `integration_test` rules diff against
  goldens and `golden_update` rules regenerate them ("Run tests:
  `bazel test tests/integration:asset`; Update goldens:
  `bazel run tests/integration:asset_update`").
  [tests/integration/BUILD.bazel](https://github.com/googleapis/gapic-generator-python/blob/5f2ad19546814408feeab2bd8a62218276f3432f/tests/integration/BUILD.bazel)
- **Go** — golden `.want` files under
  [`internal/gengapic/testdata/`](https://github.com/googleapis/gapic-generator-go/tree/df09eaf023d80438e826f304e4d03d86519c6d04/internal/gengapic/testdata)
  (e.g. `api_versions_section_list.want`, `custom_op_example.want`) and
  [`internal/gencli/testdata/`](https://github.com/googleapis/gapic-generator-go/tree/df09eaf023d80438e826f304e4d03d86519c6d04/internal/gencli/testdata).
  Note Go uses `.want` fixtures (not files literally named "baseline").
- **Java** — `.golden` fixtures under
  [`gapic-generator-java/src/test/.../goldens/`](https://github.com/googleapis/sdk-platform-java/tree/febe86f1ea4f0b5e6d8454024ed499adb7dc9328/gapic-generator-java/src/test/java/com/google/api/generator/gapic/composer/grpc/goldens)
  (e.g. `EchoClient.golden`, `EchoStubSettings.golden`,
  `DeprecatedServiceClient.golden`), plus engine/composer golden dirs.
- **TypeScript** — `.baseline` golden trees under
  [`baselines/`](https://github.com/googleapis/gapic-generator-typescript/tree/ed34a7351630e0c9003c6f68a2725d744055066f/baselines)
  (e.g. `baselines/asset-esm/esm/src/v1/asset_service_client.ts.baseline`).
  Whole generated package trees (clients, protos, package.json, system-test
  fixtures) are pinned per fixture API.

---

## 3. Product-level cross-language conformance: `googleapis/conformance-tests`

[`googleapis/conformance-tests`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1)
hosts shared, language-neutral conformance corpora consumed by the
per-language product client libraries. Its README states it is "used to
host a collection of conformance tests for Google API client libraries…
mainly used by Google APIs Github Organization repositories for language
client libraries", with the convention that "A `.proto` file specifies the
format of the test cases" and "Test cases are specified as a set of inputs
and expected outputs… defined in `.json` files."
[README](https://github.com/googleapis/conformance-tests/blob/998891a8dae00df121e460420cceb0abfc4e2ea1/README.md)

Present corpora at this SHA:
[`storage/`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1/storage),
[`firestore/`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1/firestore),
[`bigtable/`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1/bigtable).

- **Storage** —
  [`storage/v1/`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1/storage/v1)
  contains `proto/.../tests.proto` (the schema), `retry_tests.json`, and
  `v4_signatures.json`. The Storage Python/Go/Java/Node clients all run
  these same cases.
- **Firestore** —
  [`firestore/v1/`](https://github.com/googleapis/conformance-tests/tree/998891a8dae00df121e460420cceb0abfc4e2ea1/firestore)
  has a `tests.proto` plus dozens of `create-*.json` cases (array
  transforms, sentinel values, etc.).

### Quoted case (Storage V4 signed URLs)

From
[`storage/v1/v4_signatures.json`](https://github.com/googleapis/conformance-tests/blob/998891a8dae00df121e460420cceb0abfc4e2ea1/storage/v1/v4_signatures.json),
the "Simple GET" case fixes the bucket/object/method/timestamp and pins the
exact expected canonical request, string-to-sign, and signed URL:

```json
{
  "description": "Simple GET",
  "bucket": "test-bucket",
  "object": "test-object",
  "method": "GET",
  "expiration": 10,
  "timestamp": "2019-02-01T09:00:00Z",
  "expectedUrl": "https://storage.googleapis.com/test-bucket/test-object?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=...goog4_request&X-Goog-Date=20190201T090000Z&X-Goog-Expires=10&X-Goog-SignedHeaders=host&X-Goog-Signature=95e6a13d...",
  "scheme": "https",
  "expectedCanonicalRequest": "GET\n/test-bucket/test-object\n...host\nUNSIGNED-PAYLOAD",
  "expectedStringToSign": "GOOG4-RSA-SHA256\n20190201T090000Z\n20190201/auto/storage/goog4_request\n00e2fb79...320"
}
```

Because every language's Storage client computes signed URLs from this same
input and asserts byte-identical `expectedUrl` / `expectedStringToSign`, the
clients are proven to implement V4 signing identically.

?? verify — pin a specific consumer commit in each product repo
(`python-storage`, `google-cloud-go/storage`, `google-cloud-java`
storage, `nodejs-storage`) that vendors this corpus (typically as a git
submodule under a `conformance-test-data` / `conformance` path) and runs it.
Added to DO_NEXT.

---

## 4. How protoc-level + showcase testing proves cross-language consistency

The argument chains together:

1. **Single source of truth.** All clients are generated from the same
   `.proto` + service-config inputs; the showcase protos
   (`echo`/`identity`/`messaging`/`compliance`) and product protos are
   identical bytes for every language.
2. **Generator golden tests** (Section 2) pin each language's *emitted*
   code, so output drift is caught at generator-PR time — the generated
   surface stays stable.
3. **Showcase integration tests** (Section 1) run the *generated* client of
   each language against one shared reference server. Where they consume the
   shared `compliance_suite.json` corpus (Go `TestComplianceSuite`, Java
   `ITHttpAnnotation`), they assert the same RPCs produce the same
   transcoded HTTP and the same round-tripped responses — including
   unknown/numeric enum round-tripping — across languages.
4. **Product conformance corpora** (Section 3) extend the same "shared JSON
   inputs → identical expected outputs" pattern to behavior the generator
   can't cover (Storage V4 signing, retry policy, Firestore value
   conversions).

Together: protoc/generator goldens guarantee *generation* is consistent,
and showcase + conformance corpora guarantee *runtime behavior* is
consistent, both off byte-identical shared inputs.

---

## Gaps / `?? verify`

- TypeScript/Node live-server showcase integration suite: in-repo evidence
  at this SHA is generator-input baselines only; the live-server run likely
  lives elsewhere (`gapic-generator-typescript` test app or
  `google-cloud-node`). Needs a pinned permalink.
- Per-product consumers of `conformance-tests`: confirm and pin the
  submodule path + a test runner in `python-storage`, `google-cloud-go`,
  `google-cloud-java`, `nodejs-storage`.
- Whether `compliance_suite.json` is vendored identically (byte-for-byte) in
  every generator, or fetched from the showcase release — Java vendors a
  copy under `src/test/resources`; Go reads it from the downloaded
  artifacts. Worth confirming they don't drift.
