# AWS — Cross-Language SDK Verification

How AWS proves its multi-language SDKs behave identically from a single,
language-neutral spec. The headline mechanism is the **Smithy protocol test
suite**: declarative test cases authored once (as Smithy traits / `.smithy`
files), shipped as spec-adjacent artifacts, and compiled by each language's
code generator into a runnable, idiomatic test suite. Endpoint-resolution
tests follow the same "one spec, many generated runners" pattern.

Commit pins used throughout:
- `smithy-lang/smithy` @ `b697438e20bd209b28edf767a9795e6f35634b7b`
- `aws/smithy-go` @ `6857390fd160b416d0e369dc9dc5c2b3736178fc`
- `smithy-lang/smithy-typescript` @ `ee5462855d3644663dd31fecfa308d3d4d6d6afb`
- `aws/aws-sdk-go-v2` @ `13bee3c72e77d68d6180fb633a7ce1c8714d53c0`
- `aws/aws-sdk-js-v3` @ `bae4bc0f1bafc951f6593c94c223e63c47f24692`
- `aws/aws-sdk-java-v2` @ `3189683fa6ac17cb7d317581d7e975cd0d1108e6`

---

## 1. Where the protocol tests are defined

### The trait vocabulary (`smithy.test#httpRequestTests` / `httpResponseTests`)

The traits are defined in the **`smithy-protocol-test-traits`** package of the
core Smithy repo (Java validators + a Smithy IDL definition). The IDL lives at:

- [`smithy-protocol-test-traits/src/main/resources/META-INF/smithy/smithy.test.smithy`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-protocol-test-traits/src/main/resources/META-INF/smithy/smithy.test.smithy)
- Java model/validators: [`smithy-protocol-test-traits/.../protocoltests/traits/`](https://github.com/smithy-lang/smithy/tree/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-protocol-test-traits/src/main/java/software/amazon/smithy/protocoltests/traits)
  (`HttpRequestTestsTrait.java`, `HttpResponseTestsTrait.java`,
  `HttpRequestTestCase.java`, `HttpResponseTestCase.java`,
  `HttpMalformedRequestTestsTrait.java`, etc.)

The trait shapes themselves (from `smithy.test.smithy`):

```smithy
$version: "2.0"
namespace smithy.test

/// Define how an HTTP request is serialized given a specific protocol,
/// authentication scheme, and set of input parameters.
@trait(selector: "operation")
@length(min: 1)
list httpRequestTests {
    member: HttpRequestTestCase
}

/// Define how an HTTP response is serialized given a specific protocol,
/// authentication scheme, and set of output or error parameters.
@trait(selector: ":test(operation, structure[trait|error])")
@length(min: 1)
list httpResponseTests {
    member: HttpResponseTestCase
}
```

Note the response-test selector: it applies to operations **and** to any
structure carrying the `@error` trait, which is how error-shape wire formats
get covered. A test case carries `params` (a `Document` of typed input/output
values) plus the expected on-the-wire `method`/`uri`/`headers`/`body`/`code`,
so the same case can be asserted in any language. The spec also pins
non-determinism: idempotency-token members must use the constant
`00000000-0000-4000-8000-000000000000`, and timestamps are Unix integers, so
generated assertions match byte-for-byte across languages.

### The canonical AWS-protocol suite (`smithy-aws-protocol-tests`)

The actual test corpus for AWS's wire protocols is a separate package,
**`smithy-aws-protocol-tests`**, with one subdirectory per protocol:
`restJson1`, `awsJson1_0`, `awsJson1_1`, `awsQuery`, `ec2Query`, `restXml`,
`restXmlWithNamespace`, `rpcv2Cbor`.

- [`smithy-aws-protocol-tests/model/`](https://github.com/smithy-lang/smithy/tree/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-aws-protocol-tests/model)

**Example A — request serialization / `httpChecksumRequired`.** From
[`smithy-aws-protocol-tests/model/restJson1/http-checksums.smithy`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-aws-protocol-tests/model/restJson1/http-checksums.smithy):

```smithy
apply HttpChecksumRequired @httpRequestTests([
    {
        id: "RestJsonHttpChecksumRequired",
        documentation: "Adds Content-MD5 header",
        protocol: restJson1,
        method: "POST",
        uri: "/HttpChecksumRequired",
        body: "{\n    \"foo\":\"base64 encoded md5 checksum\"\n}\n",
        bodyMediaType: "application/json",
        headers: {
            "Content-Type": "application/json",
            "Content-MD5": "iB0/3YSo7maijL0IGOgA9g=="
        },
        params: { foo: "base64 encoded md5 checksum" }
    }
])
```

This single case asserts that, for the `@httpChecksumRequired` operation, every
SDK emits the `Content-MD5` header with that exact base64 value and the JSON
body.

**Example B — error-response deserialization.** From
[`smithy-aws-protocol-tests/model/restJson1/errors.smithy`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-aws-protocol-tests/model/restJson1/errors.smithy):

```smithy
apply InvalidGreeting @httpResponseTests([
    {
        id: "RestJsonInvalidGreetingError",
        documentation: "Parses simple JSON errors",
        protocol: restJson1,
        params: { Message: "Hi" },
        code: 400,
        headers: {
            "Content-Type": "application/json",
            "X-Amzn-Errortype": "InvalidGreeting",
        },
        body: "{\n    \"Message\": \"Hi\"\n}",
        bodyMediaType: "application/json",
    },
])
```

The same file also exercises the several ways `restJson1` signals the error
shape ID — `X-Amzn-Errortype` header bare, with a URI suffix, with a namespace,
and in the body `code`/`__type` (`RestJsonFooErrorUsingXAmznErrorType`,
`...WithUri`, `...WithUriAndNamespace`, `...UsingCode`) — so every SDK's error
disambiguation logic is held to one definition. `ComplexError` additionally
covers HTTP-header-bound members on an error (`@httpHeader("X-Header")`).

---

## 2. How each language SDK consumes the tests and emits a runnable suite

Each language's Smithy code generator depends on the **same**
`smithy.protocoltests.traits` Java package, reads `HttpRequestTestsTrait` /
`HttpResponseTestsTrait` off the model, and writes idiomatic test code. The
test-case `id` is preserved as the test name in every language, which makes
cross-language drift directly diffable.

### Go (`aws/smithy-go` generator → `aws-sdk-go-v2/internal/protocoltest`)

Generator:
[`HttpProtocolTestGenerator.java`](https://github.com/aws/smithy-go/blob/6857390fd160b416d0e369dc9dc5c2b3736178fc/codegen/smithy-go-codegen/src/main/java/software/amazon/smithy/go/codegen/integration/HttpProtocolTestGenerator.java)
(with request/response sub-generators
`HttpProtocolUnitTestRequestGenerator`,
`HttpProtocolUnitTestResponseGenerator`,
`HttpProtocolUnitTestResponseErrorGenerator`, and
`EventStreamProtocolTestGenerator`). It pulls cases via
`operation.getTrait(HttpRequestTestsTrait.class)` / `...ResponseTestsTrait...`
and `error.getTrait(HttpResponseTestsTrait.class)`.

Pipeline: the dedicated Gradle module
[`codegen/protocol-test-codegen/`](https://github.com/aws/aws-sdk-go-v2/tree/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/protocol-test-codegen)
loads the `smithy-aws-protocol-tests` / `smithy-protocol-tests` model JARs,
runs Smithy Build to generate a client per protocol, copies the output into
`internal/protocoltest/<protocol>/`, then overlays hand-written supplements
from `manual/` (cases that can't be expressed as traits). This is documented in
[`codegen/protocol-test-codegen/manual/README.md`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/codegen/protocol-test-codegen/manual/README.md)
(the same blob is also checked in at `internal/protocoltest/README.md`).

Generated output for Example A —
[`internal/protocoltest/awsrestjson/api_op_HttpChecksumRequired_test.go`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/internal/protocoltest/awsrestjson/api_op_HttpChecksumRequired_test.go):

```go
// Code generated by smithy-go-codegen DO NOT EDIT.
func TestClient_HttpChecksumRequired_Serialize(t *testing.T) {
    cases := map[string]struct { ... }{
        // Adds Content-MD5 header
        "RestJsonHttpChecksumRequired": {
            Params: &HttpChecksumRequiredInput{ Foo: ptr.String("base64 encoded md5 checksum") },
            ExpectMethod:  "POST",
            ExpectURIPath: "/HttpChecksumRequired",
            ExpectHeader: http.Header{
                "Content-MD5":  []string{"iB0/3YSo7maijL0IGOgA9g=="},
                "Content-Type": []string{"application/json"},
            },
            BodyMediaType: "application/json",
            BodyAssert: func(actual io.Reader) error {
                return smithytesting.CompareJSONReaderBytes(actual, []byte(`{...}`))
            },
        },
    }
    ...
}
```

The test spins up the real client against a stub HTTP transport, runs the
operation, and asserts method/URI/query/headers/body via helpers in the shared
[`smithy-go/testing`](https://github.com/aws/smithy-go/tree/6857390fd160b416d0e369dc9dc5c2b3736178fc/testing)
package (`CompareJSONReaderBytes`, `CompareValues`, query/header asserts). The
idempotency-token provider is seeded deterministically
(`smithyrand.NewUUIDIdempotencyToken(&smithytesting.ByteLoop{})`), matching the
spec's constant-token requirement.

### TypeScript (`smithy-typescript` generator → `aws-sdk-js-v3/private/aws-protocoltests-*`)

Generator:
[`HttpProtocolTestGenerator.java`](https://github.com/smithy-lang/smithy-typescript/blob/ee5462855d3644663dd31fecfa308d3d4d6d6afb/smithy-typescript-codegen/src/main/java/software/amazon/smithy/typescript/codegen/HttpProtocolTestGenerator.java).
It writes one Jest spec per protocol via
`TEST_CASE_FILE_TEMPLATE = "test/functional/%s.spec.ts"`, reading the same
`HttpRequestTestsTrait` / `HttpResponseTestsTrait` and
`HttpMalformedRequestTestsTrait`. Per-media-type assertion scaffolding lives in
stub resources (`protocol-test-json-stub.ts`, `protocol-test-xml-stub.ts`,
`protocol-test-cbor-stub.ts`, etc.).

Generated output —
[`private/aws-protocoltests-restjson/test/functional/restjson1.spec.ts`](https://github.com/aws/aws-sdk-js-v3/blob/bae4bc0f1bafc951f6593c94c223e63c47f24692/private/aws-protocoltests-restjson/test/functional/restjson1.spec.ts).
The test IDs match the Go ones one-for-one (e.g. `RestJsonAllQueryStringTypes:Request`):

```ts
it("RestJsonAllQueryStringTypes:Request", async () => {
  const client = new RestJsonProtocolClient({
    ...clientParams,
    requestHandler: new RequestSerializationTestHandler(),
  });
  const command = new AllQueryStringTypesCommand({
    queryString: "Hello there",
    queryStringList: ["a", "b", "c"],
    queryTimestamp: new Date(1000),
    queryEnum: "Foo",
    ...
  });
  // ...sends command against the serialization-capturing handler and
  // asserts method / path / query / headers / body
});
```

That the JS suite and the Go suite share the case IDs `RestJsonAllQueryStringTypes`,
`RestJsonHttpChecksumRequired`, `RestJsonInvalidGreetingError`, etc. is the
concrete demonstration of "one spec drives all languages": both are projections
of the same `.smithy` source.

### Java (`aws-sdk-java-v2`) — a parallel, mostly hand-authored suite `?? verify`

Java v2 is the legacy C2J pipeline, and its primary protocol-test mechanism is
**not** the Smithy `httpRequestTests` trait. It uses its own
`test/protocol-tests-core` framework:

- Loader: [`ProtocolTestSuiteLoader.java`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests-core/src/main/java/software/amazon/awssdk/protocol/ProtocolTestSuiteLoader.java)
  (resource prefix `/software/amazon/awssdk/protocol/suites/`).
- Hand-written JSON suites: [`test/protocol-tests-core/.../protocol/suites/`](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests-core/src/main/java/software/amazon/awssdk/protocol/suites)
  (`json-rpc-input.json`, `query-core-input.json`, `ec2-output.json`, …) with
  marshalling/unmarshalling assertions under
  [`asserts/marshalling/`](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests-core/src/main/java/software/amazon/awssdk/protocol/asserts/marshalling)
  (`JsonBodyAssertion`, `QueryBodyAssertion`, `HeadersAssertion`,
  `ResolvedHostAssertion`, `CborBodyAssertion`, …).
- These run against synthetic services generated from C2J `service-2.json`
  models in [`test/protocol-tests/src/main/resources/codegen-resources/`](https://github.com/aws/aws-sdk-java-v2/tree/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests/src/main/resources/codegen-resources).

So Java v2's protocol conformance is a *separate* corpus from the Smithy
suite, covering the same wire concerns (method, URI, headers, resolved host,
JSON/Query/XML/CBOR bodies) but authored independently. Java v2 *does* now ship
a Smithy-derived path for newer protocols — there is a
[`SmithyRpcV2CborProtocolProcessor.java`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/codegen/src/main/java/software/amazon/awssdk/codegen/customization/processors/SmithyRpcV2CborProtocolProcessor.java)
in codegen — but I did **not** find a generator in java-v2 that compiles
`smithy.test#httpRequestTests` cases into JUnit tests the way Go/JS do.
`?? verify` whether any java-v2 module consumes the Smithy protocol-test traits
directly (vs. the independent `protocol-tests-core` JSON suites).

---

## 3. Shared conformance suites beyond protocol tests

### Endpoint-resolution tests (`smithy.rules#endpointTests` / `endpoint-tests.json`)

Endpoint rule sets and their tests are a second "single spec, generated per
language" suite. The trait/test model lives in **`smithy-rules-engine`**:

- [`smithy-rules-engine/.../rulesengine/traits/EndpointTestsTrait.java`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-rules-engine/src/main/java/software/amazon/smithy/rulesengine/traits/EndpointTestsTrait.java),
  [`EndpointTestCase.java`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-rules-engine/src/main/java/software/amazon/smithy/rulesengine/traits/EndpointTestCase.java),
  [`EndpointTestsTraitValidator.java`](https://github.com/smithy-lang/smithy/blob/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-rules-engine/src/main/java/software/amazon/smithy/rulesengine/validators/EndpointTestsTraitValidator.java).

In the C2J SDKs these ship as the spec-adjacent JSON file `endpoint-tests.json`
alongside `endpoint-rule-set.json` per service — e.g.
[`test/protocol-tests/.../codegen-resources/awsjson/endpoint-tests.json`](https://github.com/aws/aws-sdk-java-v2/blob/3189683fa6ac17cb7d317581d7e975cd0d1108e6/test/protocol-tests/src/main/resources/codegen-resources/awsjson/endpoint-tests.json)
(`{ "testCases": [...], "version": "1.0" }`).

The generated Go runner —
[`service/s3/endpoints_test.go`](https://github.com/aws/aws-sdk-go-v2/blob/13bee3c72e77d68d6180fb633a7ce1c8714d53c0/service/s3/endpoints_test.go)
(`// Code generated by smithy-go-codegen DO NOT EDIT.`) — emits one
`TestEndpointCaseN` per test case, feeding `EndpointParameters` into
`NewDefaultEndpointResolverV2().ResolveEndpoint(...)` and asserting the resolved
URL or the expected error string, e.g.:

```go
// region is not a valid DNS-suffix
func TestEndpointCase0(t *testing.T) {
    var params = EndpointParameters{ Region: ptr.String("a b"), UseFIPS: ..., UseDualStack: ..., Accelerate: ... }
    result, err := NewDefaultEndpointResolverV2().ResolveEndpoint(context.Background(), params)
    if err == nil { t.Fatalf("expect error, got none") }
    if e, a := "Invalid region: region was not a valid DNS name.", err.Error(); !strings.Contains(a, e) { ... }
}
```

Same JSON cases → per-language generated endpoint tests, exactly mirroring the
protocol-test pattern.

### Waiters and paginators

- **Waiters** are spec-defined in **`smithy-waiters`**
  ([`smithy-waiters/.../waiters/`](https://github.com/smithy-lang/smithy/tree/b697438e20bd209b28edf767a9795e6f35634b7b/smithy-waiters/src/main/java/software/amazon/smithy/waiters))
  and ship in C2J SDKs as `waiters-2.json`. Smithy defines waiter *acceptors*
  but I did not find a dedicated cross-language waiter **test** trait equivalent
  to `httpRequestTests`. `?? verify` whether waiter behavior has a shared
  conformance corpus or is only unit-tested per SDK.
- **Paginators** ship as `paginators-1.json` and are consumed by codegen, but
  likewise there does not appear to be a shared paginator conformance suite of
  the protocol-test kind. `?? verify`.

---

## 4. What is actually validated

Per protocol-test case, across all languages that consume the Smithy suite:

- **Request serialization (the wire):** HTTP method, URI path with label
  substitution, query string (presence/absence/ordering-insensitive compares),
  request headers, and request body — with media-type-aware body comparison
  (JSON via `CompareJSONReaderBytes`, plus XML / form-urlencoded / CBOR /
  octet-stream / text stubs on the TS side).
- **Response deserialization:** mapping status `code` + headers + body back
  into typed output `params`.
- **Error shapes:** which concrete error type a response deserializes to, and
  how the type is signalled (`X-Amzn-Errortype` header, with/without URI suffix
  and namespace, body `__type`/`code`), plus error members bound to HTTP
  headers (`ComplexError`).
- **Host prefix / `@endpoint` host labels:** `endpoint`/`host-label` test files
  per protocol (e.g. `restJson1/endpoints.smithy`, `endpoint-paths.smithy`).
- **Checksums:** `http-checksums.smithy` (`@httpChecksumRequired` → Content-MD5).
- **Content negotiation:** `content-type.smithy`, `http-accept.smithy`,
  `http-content-type.smithy`.
- **Malformed-request handling (server-side):** the `malformedRequests/` tree
  and `HttpMalformedRequestTestsTrait` assert 4xx behavior for bad inputs
  (consumed by smithy-typescript's generator; primarily a server-SDK concern).
- **Timestamp/number edge cases:** `datetime-offsets.smithy`,
  `fractional-seconds.smithy`, NaN/Infinity float query values, default values.
- **Endpoint resolution:** `endpoint-tests.json` → resolved URL / auth scheme /
  expected error.

---

## Summary

- The "single spec drives all languages" claim is real and concrete: AWS
  authors declarative `httpRequestTests` / `httpResponseTests` cases (defined by
  the `smithy.test` traits in **`smithy-protocol-test-traits`**, corpus in
  **`smithy-aws-protocol-tests`**), and each Smithy code generator
  (`smithy-go`, `smithy-typescript`) compiles the *same* cases — preserving the
  case `id` as the test name — into idiomatic, runnable suites
  (`aws-sdk-go-v2/internal/protocoltest/*`, `aws-sdk-js-v3/private/aws-protocoltests-*`).
- Verified matching examples: `RestJsonHttpChecksumRequired` (Content-MD5),
  `RestJsonInvalidGreetingError` (error parsing), and
  `RestJsonAllQueryStringTypes` appearing identically in the `.smithy` source,
  the generated Go test, and the generated JS Jest spec.
- A second shared suite — endpoint-resolution tests (`smithy.rules#endpointTests`
  / `endpoint-tests.json`) — uses the identical pattern, generating
  `TestEndpointCaseN` runners per language.
- Validation scope: on-the-wire request/response (method/URI/query/headers/body
  with media-type-aware compares), error shapes and their signalling,
  host-prefix labels, checksums, content negotiation, timestamp/number edge
  cases, and malformed-request handling.

### Gaps / to verify

- `?? verify` whether **aws-sdk-java-v2** consumes the Smithy `httpRequestTests`
  traits at all, or only its independent hand-authored `protocol-tests-core`
  JSON suites (it clearly has the latter; a Smithy-derived RpcV2Cbor codegen
  path exists but I found no JUnit generator over `smithy.test` cases).
- `?? verify` whether **waiters** and **paginators** have any shared
  cross-language conformance corpus (Smithy defines the *behavior* traits
  `smithy-waiters` / paginator traits, but I found no protocol-test-style shared
  test suite for them).
- Not yet inspected: `smithy-rs` and `smithy-python` protocol-test generators
  (both repos are in `links.md`); presumably the same trait-consumption pattern.
