# Cloud APIs, styles & protocols — a side-by-side comparison

A decision-oriented comparison of how the major clouds expose their APIs, and of
the underlying API **styles** (REST, RPC, query, GraphQL) and **protocols/transports**
(HTTP/1.1, HTTP/2, gRPC, …). Written for a senior engineer or CTO who needs to
reason about integration cost, performance, tooling, portability, and lock-in —
not a tutorial.

Grounded in this repo's SDK-codegen research: see [`CODE_GENERATION.md`](CODE_GENERATION.md)
and the per-cloud notes (`aws/notes.md`, `gcp/notes.md`, `azure/notes.md`,
`oracle/notes.md`, `alicloud/notes.md`) for the source-cited details behind the
provider claims here.

> **The one-sentence version.** Of the five hyperscalers, only **GCP is gRPC-native**;
> **AWS** is a museum of per-service HTTP wire protocols unified only by *modeling*
> (Smithy) and *signing* (SigV4); **Azure, OCI, and Alibaba** are all REST/JSON over
> HTTPS with different auth. In practice you never touch these wire protocols
> directly — the generated SDKs and Terraform providers abstract them — so the API
> *style* matters far less than its **tooling, auth, and operational ergonomics**.

---

## 1. Shared vocabulary (so the comparison means something)

These four axes are independent and routinely conflated:

| Axis | Options (not exhaustive) | What it actually decides |
|---|---|---|
| **Architectural style** | REST (resource+verbs) · RPC (action) · Query-RPC (single endpoint + `Action=`) · GraphQL (client-shaped) · event/stream | URL/operation shape, cacheability, how "CRUD-ish" it feels |
| **Schema / IDL** | OpenAPI · Smithy · Protobuf · TypeSpec · WSDL · GraphQL SDL · none | Codegen, validation, contract testing, docs |
| **Wire format** | JSON · Protobuf · XML · CBOR · MessagePack · Avro | Payload size, parse speed, human-readability |
| **Transport** | HTTP/1.1 · HTTP/2 · HTTP/3(QUIC) · WebSocket · raw TCP | Multiplexing, streaming, head-of-line blocking, infra/LB support |

**gRPC is not a "style" — it's a bundle:** RPC style + Protobuf wire format + HTTP/2
transport + a streaming model + generated stubs. That bundling is exactly why it's
fast *and* why it's awkward in browsers and through legacy proxies.

---

## 2. The API-style decision: REST vs gRPC vs GraphQL vs Query-RPC

The comparison most teams actually face:

| | **REST + JSON** | **gRPC** | **GraphQL** | **Query/RPC (AWS-style)** | **Connect / gRPC-Web** |
|---|---|---|---|---|---|
| Style | Resource-oriented | Action/RPC | Client-shaped graph | Action (one endpoint) | Action/RPC |
| Wire format | JSON (text) | Protobuf (binary) | JSON | JSON/XML/CBOR | Protobuf or JSON |
| Transport | HTTP/1.1+ | **HTTP/2 only** | HTTP/1.1+ | HTTP/1.1+ | HTTP/1.1+ (browser-OK) |
| Schema/IDL | OpenAPI (optional) | **Protobuf (required)** | SDL (required) | Smithy/internal | Protobuf |
| Streaming | SSE/WebSocket bolt-on | **Native bidi streaming** | Subscriptions (bolt-on) | No | Server-streaming |
| Browser-native | ✅ | ❌ (needs gRPC-Web proxy) | ✅ | ✅ | ✅ |
| Human-debuggable | ✅ (curl) | ❌ (binary) | ⚠️ | ✅ | ⚠️/✅ |
| HTTP caching/CDN | ✅ (GETs) | ❌ | ❌ (POST) | ❌ (POST) | ❌ |
| Codegen quality | Good (OpenAPI gen) | **Excellent** (protoc) | Good | Excellent (internal) | Excellent (buf) |
| Perf (latency/size) | Baseline | **Best** (binary+mux) | Baseline–worse (over-fetch fixed, N+1 risk) | Baseline | Best |
| Typical home | Public/control-plane APIs, partners | Internal microservices, high-throughput data-plane | BFF / mobile / aggregation | AWS legacy services | Internal + browser |

**Rules of thumb:**
- **gRPC wins** when you control both ends, need streaming or high RPS, and have polyglot internal services. It loses at the public edge (browsers, firewalls, "just curl it").
- **REST/JSON wins** for public/partner APIs, debuggability, caching, and the broadest tooling. It's the default for *control planes*.
- **GraphQL wins** for client-driven aggregation (mobile/BFF). It is *not* a backend-service protocol; it shifts complexity to the server (auth, rate-limiting, N+1).
- **Connect/gRPC-Web** is the pragmatic middle: protobuf contracts + browser compatibility, increasingly popular for new internal+web APIs.

---

## 3. The five clouds, side by side

Control-plane (management) APIs, which is where the divergence lives:

| | **AWS** | **GCP** | **Azure** | **OCI (Oracle)** | **Alibaba Cloud** |
|---|---|---|---|---|---|
| IDL / model | **Smithy** (modern) + legacy C2J | **Protobuf** + service-config YAML | **OpenAPI 2.0** → **TypeSpec** | OpenAPI/Swagger 2.0 (internal) | **Darabonba** DSL over POP meta |
| Predominant style | **Mixed RPC/REST per service** | **gRPC** (REST transcoded) | **REST** (ARM resource model) | **REST** | **RPC + ROA** via POP gateway |
| Wire protocol(s) | awsJson1.0/1.1, awsQuery, ec2Query, restXml, restJson1, **rpcv2Cbor** | Protobuf (gRPC) / JSON (REST) | JSON | JSON | JSON (form/RPC + REST) |
| Transport | HTTP/1.1 (HTTP/2 for some data planes) | **HTTP/2** (gRPC) + HTTP/1.1 (REST) | HTTPS (HTTP/1.1/2) | HTTPS | HTTPS |
| Public gRPC? | **No** | **Yes** (the only one) | No | No | No |
| Auth / signing | **SigV4** (HMAC request signing) | **OAuth 2.0** bearer (Google identity) | **Entra ID OAuth 2.0** bearer | **HTTP Signatures** (draft-cavage; RSA-SHA256) | **POP signature** (HMAC) + credential chain |
| LRO (async) model | Per-service (poll/describe) | **`google.longrunning.Operations`** (standard) | **ARM async** (`Azure-AsyncOperation`/`Location` headers, provisioningState) | Work-Requests | Per-service polling |
| Pagination | `NextToken` (per-service var.) | `page_token`/`next_page_token` (standard) | `nextLink` (OData-ish) | `opc-next-page` header | `NextToken`/`PageNumber` (var.) |
| Error model | Smithy error shapes + `X-Amzn-Errortype` | `google.rpc.Status` + codes | ARM error envelope (`error.code`/`message`) | `code`/`message` + `opc-request-id` | `Code`/`Message` + `RequestId` |
| Versioning | Per-service `apiVersion` (date) | API surface version in path (`v1`,`v2`) | `api-version` query param (date) | Date-versioned per service | `<product><apiVersion>` |
| Generator openness | Open (Smithy, Apache-2.0) | Open (GAPIC, Apache-2.0) | Open (AutoRest/TypeSpec, MIT) | **Closed** (`OracleSDKGenerator`) | Open (Darabonba, Apache-2.0) |

(Generator/codegen column cross-refs [`CODE_GENERATION.md`](CODE_GENERATION.md).)

### One paragraph each
- **AWS** — There is no single "AWS API." Each service picks a Smithy *protocol trait*
  (`awsJson1_0`, `awsQuery`, `restXml`, `restJson1`, `ec2Query`, `rpcv2Cbor`); S3 is
  REST-XML, DynamoDB is JSON-RPC, EC2 is Query, newer services use CBOR-RPC. The
  unifying layer is **the model (Smithy) and the signature (SigV4)**, not the wire
  format. No public gRPC.
- **GCP** — The outlier: **protobuf-first, gRPC-native**, defined in `googleapis/googleapis`.
  Every API also gets a **REST/JSON transcoding** (`transport=grpc+rest`) via
  `google.api.http` annotations, so you can use either. Standardized LRO, pagination,
  and resource names (`google.api.*` annotations) make GCP the most *internally
  consistent* API surface.
- **Azure** — Uniform **REST over the ARM (Azure Resource Manager) model**: every
  resource is a typed `PUT/GET/DELETE` on a hierarchical path, modeled in OpenAPI
  (migrating to **TypeSpec**), authed with **Entra ID OAuth bearer tokens**. The most
  *RESTful* and uniform of the five — at the cost of ARM's verbosity.
- **OCI** — REST/JSON over HTTPS with the most distinctive auth: **HTTP Signatures**
  (the cavage draft, RSA-SHA256 over a canonical request) instead of HMAC or OAuth.
  Async via **Work-Requests**. Generator is **closed-source**.
- **Alibaba** — Most services go through the **POP gateway** in two styles (**RPC** —
  action+params, and **ROA** — RESTful), described in the **Darabonba** DSL. JSON
  payloads, HMAC POP signatures, per-product+version packaging.

---

## 4. Deep-dive comparison axes

### 4.1 Authentication & signing
| | Mechanism | Token type | Rotation/expiry | Notes |
|---|---|---|---|---|
| AWS | **SigV4** request signing | Access key + secret (HMAC) | STS for temp creds | No bearer token; every request signed. Painful to hand-roll → use SDK. |
| GCP | OAuth 2.0 bearer | Short-lived access token | ~1h, auto-refreshed | Service accounts + workload identity federation. |
| Azure | Entra ID OAuth 2.0 bearer | Short-lived JWT | ~1h | Managed identities; RBAC at ARM. |
| OCI | **HTTP Signatures** (draft-cavage) | API key (RSA keypair) | Key-managed | Instance/resource principals for workload auth. |
| Alibaba | **POP signature** (HMAC) | AccessKey + secret | STS for temp | Credential provider chain (`alibabacloud-credentials`). |

**CTO note:** the auth model, not the wire protocol, is the integration tax. SigV4
and OCI's cavage signing are the only ones you cannot fake with a static header — a
reason to never bypass the official SDKs/`credentials-*` libraries.

### 4.2 Long-running operations (async)
| | Pattern |
|---|---|
| AWS | No standard — per-service `Describe*`/`Wait*` polling (codegen "waiters"). |
| GCP | **One standard**: `google.longrunning.Operation` (poll `Operations.Get`, or LRO helpers). |
| Azure | **ARM standard**: 201/202 + `Azure-AsyncOperation`/`Location` headers, terminal `provisioningState` (Succeeded/Failed/Canceled). |
| OCI | **Work-Requests** service (poll `GetWorkRequest`). |
| Alibaba | Per-service polling. |

GCP and Azure have *uniform* async models; AWS and Alibaba make you learn it per
service (the SDK's waiters paper over this).

### 4.3 Errors
| | Shape | Correlation ID |
|---|---|---|
| AWS | Modeled error shapes; type via `X-Amzn-Errortype` (header/body variants — see `aws/verification.md`) | `x-amzn-RequestId` |
| GCP | `google.rpc.Status` (`code`,`message`,`details`) — canonical gRPC codes | — (in trace) |
| Azure | ARM envelope `{ error: { code, message, details } }` | `x-ms-request-id` |
| OCI | `{ code, message }` | `opc-request-id` |
| Alibaba | `{ Code, Message, RequestId }` | `RequestId` |

Always log the provider's request-id; it's the only thing support can act on.

### 4.4 Pagination, idempotency, retries
- **Pagination**: GCP/Azure are uniform (`page_token` / `nextLink`); AWS/Alibaba vary
  per service (`NextToken`/`PageNumber`); OCI uses an `opc-next-page` header. SDK
  paginators hide this.
- **Idempotency**: AWS uses client-token/idempotency-token members on mutating ops
  (codegen injects them); GCP uses `request_id` on many mutations; Azure PUTs are
  inherently idempotent (declarative resource state); OCI uses `opc-retry-token`.
- **Retries**: every SDK ships exponential-backoff-with-jitter + per-error retry
  classification (throttling vs transient). This is *generated/hand-written runtime*,
  not in the protocol — see `CODE_GENERATION.md`.

### 4.5 Streaming & real-time
| | Control plane | Data-plane streaming |
|---|---|---|
| AWS | request/response | Kinesis (HTTP/2 `SubscribeToShard`), DynamoDB Streams, EventBridge, AppSync (GraphQL+WebSocket subscriptions), IoT (MQTT) |
| GCP | request/response (or gRPC streaming) | **gRPC bidi streaming** native (Pub/Sub StreamingPull, Speech, Storage `ReadObject`/`WriteObject` streams) |
| Azure | request/response | Event Hubs/Service Bus (AMQP), SignalR (WebSocket), Web PubSub |
| OCI | request/response | Streaming service (Kafka-compatible) |
| Alibaba | request/response | MNS/RocketMQ, etc. |

GCP's gRPC heritage shows most in **data-plane streaming**; the others bolt on
AMQP/WebSocket/MQTT for streaming rather than using their control-plane protocol.

### 4.6 SDK & codegen maturity (the real developer-experience differentiator)
| | One generator or per-language? | Engine | Cross-language conformance |
|---|---|---|---|
| AWS | per-language (Smithy writers) | AST/writer-based | **Compiled protocol-test suite** (shared traits) |
| GCP | per-language GAPIC | Jinja2/Nunjucks/AST/Go-templates | **gapic-showcase** conformance server + shared corpora |
| Azure | AutoRest→TypeSpec emitters | TS core + per-lang | **spector** spec-scenarios + test-proxy |
| OCI | one closed generator | unknown | internal `SDKTestingService` (Java as canonical schema) |
| Alibaba | Darabonba per-language | DSL→AST | uneven (test-gen capability) |

Full detail and citations in [`CODE_GENERATION.md`](CODE_GENERATION.md). **Takeaway:**
all five produce solid, idiomatic multi-language SDKs; AWS/GCP/Azure additionally
*prove* cross-language behavioral consistency with public conformance suites.

---

## 5. HTTP vs gRPC: why the clouds chose differently

The question behind "AWS/Azure use HTTP, GCP uses gRPC":

| Dimension | HTTP/1.1 + JSON (AWS/Azure/OCI/Ali) | gRPC / HTTP/2 + Protobuf (GCP) |
|---|---|---|
| Public-internet friendliness | **High** — every proxy, WAF, CDN, browser, curl | Low — needs HTTP/2 end-to-end, gRPC-Web for browsers |
| Debuggability / "just look at it" | **High** | Low (binary; need `grpcurl`) |
| Payload size / parse cost | Larger / slower | **Smaller / faster** |
| Streaming | Bolt-on (SSE/WS) | **Native bidi** |
| Schema enforcement | Optional (OpenAPI) | **Mandatory (protobuf)** |
| Load balancing | L7 HTTP LBs everywhere | Needs gRPC-aware LB (sticky HTTP/2 conns) |
| Codegen | Good | **Excellent** |
| Backward-compat discipline | Convention | **Enforced by protobuf field rules** |

**Why GCP went gRPC**: Google runs gRPC internally (Stubby's successor); exposing the
same protobuf surface externally meant one IDL, free streaming, and strong codegen.
The `grpc+rest` transcoding bridge (declared as `transport = "grpc+rest"` in the
`googleapis` Bazel rules — see `gcp/notes.md`) was the concession to the public
internet: the same API is reachable over REST/JSON for environments where HTTP/2 or
gRPC is awkward (browsers, restrictive proxies). **GAPIC clients default to gRPC**,
not REST — REST is the opt-in alternate transport selected per client (e.g.
`transport="rest"` in the Python clients).

**Why AWS/Azure stayed HTTP/JSON**: control-plane calls are infrequent and
latency-insensitive; debuggability, edge-compatibility, and not forcing HTTP/2 on
every client outweigh gRPC's wire efficiency. AWS's *internal* services may use other
protocols, but the public contract is HTTP. (AWS's newest wire protocol, **rpcv2Cbor**,
keeps HTTP transport but swaps JSON for binary CBOR — a quieter efficiency win without
gRPC's operational cost.)

**The deciding factor is almost never raw protocol speed** for control-plane APIs —
you call them rarely. It matters for **data planes** (object reads, pub/sub, telemetry)
where GCP's gRPC streaming and AWS's HTTP/2 data-plane endpoints earn their keep.

---

## 6. CTO-level takeaways

1. **You will not consume these wire protocols directly.** The generated SDKs and
   Terraform/Pulumi providers abstract every difference in §3–§4. Budget for the
   *SDK/auth* integration, not the protocol. Hand-rolling SigV4 or cavage signing is
   a classic, avoidable mistake.
2. **API divergence ≠ portability cost — abstraction layers already exist.** If
   multi-cloud matters, you standardize at the **Terraform/Pulumi/Crossplane** layer
   (see [`IAC_CODEGEN.md`](IAC_CODEGEN.md)) or at your own service boundary, not by
   coding to five SDKs.
3. **Control plane vs data plane is the real split.** Control planes are uniformly
   "REST-ish request/response, who cares about the protocol." Data planes are where
   protocol choice bites: object storage (HTTP range GETs, multipart), messaging
   (AMQP/MQTT/gRPC streaming), telemetry (HTTP/2). Evaluate per workload.
4. **Auth is the integration tax, not the wire format.** SigV4 / cavage / Entra OAuth /
   POP each need their credential-provider library. This is also your blast-radius and
   rotation story — design it deliberately.
5. **For your *own* new APIs** (the implicit question): default to **REST/JSON +
   OpenAPI** for public/partner surfaces (tooling, caching, debuggability); use
   **gRPC or Connect** for internal/high-throughput/streaming services; reach for
   **GraphQL** only for client-aggregation (BFF/mobile), knowing it moves complexity
   server-side. Match the cloud-vendor reasoning in §5.
6. **Watch the trajectory**: protobuf/gRPC contracts are spreading (Connect, buf, gRPC-Web
   make them browser-viable); **TypeSpec** (Azure) and **Smithy** (AWS) are converging
   the industry on "one model, many emitters" (the theme of `CODE_GENERATION.md`); and
   **CBOR** (AWS rpcv2Cbor) shows binary-over-HTTP can capture most of gRPC's efficiency
   without its operational cost. The "REST vs gRPC" binary is dissolving into "rich IDL
   + pick-your-transport."

---

## Appendix — quick-reference cheat sheet

| If you need… | Reach for |
|---|---|
| A public/partner API anyone can curl | REST + JSON + OpenAPI |
| Max throughput between services you own | gRPC (Protobuf + HTTP/2) |
| The same contract in browser + backend | Connect / gRPC-Web |
| Mobile/BFF aggregation, client-shaped responses | GraphQL |
| Binary efficiency without gRPC's ops cost | CBOR/MessagePack over HTTP |
| Bidirectional streaming | gRPC streaming or WebSocket |
| Server→client push, simple | SSE |
| Async cloud provisioning | the provider's LRO model (§4.2) — via the SDK's waiters |
| Multi-cloud infra without 5 SDKs | Terraform/Pulumi/Crossplane (`IAC_CODEGEN.md`) |
