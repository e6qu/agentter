# Activity log

Format: date heading, then a bulleted list of attempts, outcomes, and
reasoning. Include things that **didn't** work alongside things that did,
so future sessions don't re-tread the same dead ends.

## 2026-05-30

- Created project at `/Users/zardoz/projects/sdk-codegen-research/`.
- Scaffolded directory layout (one dir per cloud) and continuity docs.
- Drafted `AGENTS.md` (purpose + rules + how-to-resume).
- Created `CLAUDE.md` symlink → `AGENTS.md`.
- Drafted `PLAN.md` with a per-provider questionnaire so the final
  comparison is truly apples-to-apples.
- Made an explicit list of starting *hypotheses* per provider in PLAN.md,
  framed as "to verify, not assert", so future sessions don't accidentally
  parrot them as facts.
- Paused to ask user about scope before launching expensive parallel
  research subagents.
- User scope decisions:
  - Languages: Python + Go + Java + TypeScript (common subset).
  - Case studies: object storage **and** SNS/SQS-equivalents **and**
    FaaS — i.e. three services, compared across all 5 clouds.
  - Run generators locally for case-study services (at least one per
    cloud).
  - Depth: architectural + 2–3 concrete customization examples per
    provider.
- Updated PLAN.md, STATUS.md, DO_NEXT.md with confirmed scope.
- Launched 5 parallel research subagents (one per provider) to populate
  `<provider>/notes.md` and `<provider>/links.md`.
- NOTE for future sessions: that first launch did not survive the session
  boundary — subagent output is not persisted, so a later session found the
  per-cloud dirs still empty. Re-ran the 5 parallel agents this session and
  they DID write their files. Lesson: verify agent output landed on disk
  before declaring a phase done in STATUS.md.

## 2026-05-30 (session 2 — Phase 1 actually completed)

- Re-ran the 5 per-provider research agents (general-purpose, web + `gh`
  access). All five wrote `notes.md` + `links.md`. Sizes: alicloud 388L,
  aws 340L, oracle 340L, gcp 309L, azure 214L. Link counts 41–71 each.
- Spot-read all five notes end to end. Quality is high: every cell of the
  questionnaire covered, claims carry commit-pinned permalinks, gaps marked
  `?? verify`. Headline cross-cloud findings already visible:
  - AWS: Smithy 2.0 JSON AST (modern: Go/JS/Rust/py-v3) vs legacy C2J
    `service-2.json` (botocore/boto3 + java-v2). Writer-based codegen, not
    templates; customization via Java SPI "integrations" + JSON config.
  - GCP: protobuf + annotations in `googleapis/googleapis`; one GAPIC
    generator per language with *different* engines (Jinja2/Nunjucks/AST/Go-
    templates). Pipeline mid-migration OwlBot → `librarian` hermetic build.
    Storage/PubSub are handwritten/GAPIC_COMBO.
  - Azure: dual stack mid-migration — AutoRest (deprecated, retires
    2026-07-01) + TypeSpec emitters. Customization via AutoRest `directive:`
    YAML and TypeSpec `client.tsp` decorators. `_generated` + `_patch.py`.
  - Oracle: closed-source `OracleSDKGenerator` (named in headers), OpenAPI
    2.0 specs (internal), monorepo-per-language, synchronized weekly multi-
    language releases. Customization seam = generated-vs-extensions module
    split. Evidence tagged [EVIDENCE]/[INFERENCE].
  - Alibaba: Darabonba (`.tea`/`.dara`) imperative DSL in
    `aliyun/alibabacloud-sdk` (~800 modules); per-language JS generators via
    `@darabonba/cli`. Go published per-service in a separate org. OSS
    data-plane is a hand-written exception (`oss2`).
- Updated STATUS.md / DO_NEXT.md. Decision pending from user on local
  generator runs (heavy, OCI impossible) vs. going straight to drafting
  `CODE_GENERATION.md`.
- User decisions: (1) **draft now, runs after**; (2) **draft with gaps noted
  inline** (don't block on chasing every `?? verify`).
- Wrote `CODE_GENERATION.md` (the deliverable) synthesizing all five notes:
  executive-summary matrix, one section per provider (spec → generator →
  pipeline → customization → case studies → release), four side-by-side
  comparison tables (authoring model / customization mechanism / trust
  boundary / open-source posture), six concluding observations, and a
  "Known gaps" section that carries every `?? verify` item inline +
  `(unverified)` tags in-text. Permalinks reused from the verified notes.
- NEXT: local generator runs, starting with GCP gapic-generator-python vs
  Cloud Functions v2 (cleanest GAPIC_AUTO case) via `uv`; then fold any
  results back into CODE_GENERATION.md and the per-provider `runs/` dirs.

- Proposed (and user asked "what do you propose?") a value-ordered finish
  rather than all-five local runs: (1) citation-verification pass, (2) only
  TWO representative local runs (GCP + Alibaba — lightest + most architecturally
  distinctive), (3) quick-close the googleapis-gen gap. Rationale: literal
  "one run per cloud" is already impossible (OCI closed-source) and AWS/Azure
  full toolchains are heavy for architecture already well-evidenced from source.

- **Citation-verification pass DONE** (`CODE_GENERATION.md`):
  - 43 unique URLs; zero leaked `/blob/main/` (all SHA-pinned). 
  - All 43 return HTTP 200 (curl status check, /tmp/cg_urls.txt).
  - googleapis-gen gap closed: `api.github.com/repos/googleapis/googleapis-gen`
    and the web URL both 404; `github.com/googleapis/librarian` = 200. The
    doc's "googleapis-gen now 404s, replaced by librarian" claim is accurate.

## 2026-05-30 (session 2 cont. — all five local generator runs + Phase V)

User decision: **run all codegens for all clouds**; planned it as multi-phase in
PLAN.md (new "Execution plan v2" with Phase R / V / S). User also expanded the
deliverable goal to cover **cross-language verification & spec support**.

- Probed local toolchains: Java 25, Node 26/npm 11, Python 3.14+uv, Go 1.26.
  Got protoc via grpcio-tools; Smithy CLI 1.71.0 via brew tap; pandoc via brew.
- **Phase V (cross-language verification): 5 background research agents**, one per
  cloud, all completed. Wrote `<provider>/verification.md`. Headline findings:
  - AWS: **Smithy protocol tests** (`httpRequestTests`/`httpResponseTests` traits
    in `smithy-protocol-test-traits`; AWS corpus `smithy-aws-protocol-tests`).
    Each lang codegen compiles the SAME cases into runnable suites preserving
    case `id`. Caveat: **java-v2 does NOT consume them** (separate hand-authored
    JSON suite) — the one asymmetry. Endpoint tests (`endpointTests`) same pattern.
  - GCP: **gapic-showcase** conformance server + shared `compliance_suite.json`
    (Go `TestComplianceSuite`, Java `ITHttpAnnotation`, Python/TS sessions) +
    per-generator goldens + product `googleapis/conformance-tests` (Storage v4
    signature cases).
  - Azure: **spector** (formerly cadl-ranch) spec-driven mock scenarios every
    `http-client-<lang>` emitter runs against (`@typespec/http-specs` +
    `@azure-tools/azure-http-specs`); **test-proxy** record/replay with
    `azure-sdk-assets`; AutoRest-era ancestor `autorest.testserver`.
  - OCI: **`SDKTestingService`** — a cross-language harness; a CLIENT for it is
    public (`oci-python-sdk/tests/testing_service_client.py`) but the server +
    corpus are internal. No generated-client unit tests in public repos.
  - Alibaba: Darabonba can **generate test cases** from a `*_test.tea` (via
    `darabonba-assert`); opt-in per generator (Py/TS/PHP yes; Go/Java no). No
    single executed cross-language conformance matrix — "consistent by
    construction" + per-lang hand-written runtime tests.
- **Phase R (local runs): all five done.** Captured under `<provider>/runs/`:
  - **GCP R1 SUCCESS** — `gapic-generator-python` vs Cloud Functions v2: 63 files,
    ~22k LOC; verified `method_signature` flattening + grpc+rest transports.
    (Real dep gotcha: needs `pandoc`.)
  - **Alibaba R2 SUCCESS** — `dara codegen` one `.dara` → Python AND Go; Go output
    imports `alibabacloud-go/tea` runtime. (Gotchas: go block must not have string
    `package`; python clientName must be snake_case.)
  - **Azure R3 SUCCESS (dual stack)** — AutoRest (Swagger→Python, emitted its own
    retirement notice + `_patch.py` seams) AND TypeSpec (`.tsp`→TypeScript modular
    client over `@typespec/ts-http-runtime`).
  - **AWS R4 SUCCESS** — Smithy CLI + Maven-published `smithy-aws-typescript-codegen`
    0.31.1 vs real SQS model: 46 TS files, 24 commands, `Aws_json1_0.ts` protocol;
    feared "AWS-protocol-not-on-Maven" blocker did NOT occur. Benign partial
    auth-plugin wiring warning documented.
  - **OCI R5 IMPOSSIBLE** — generator closed-source; documented in
    `oracle/runs/README.md` with 404 probes + header evidence. Faithful
    non-run per the no-silent-fallback rule.
- `_work/` holds the scratch venvs/clones/node_modules (reproducible via each
  run's `cmd.sh`; safe to delete).
- NEXT (Phase S): fold runs + verification.md into CODE_GENERATION.md (add a
  "Cross-language verification & spec support" section + run pointers), then
  re-verify URLs.

- **Phase S (synthesis update) DONE.** Read all 5 `verification.md` files for
  citations and added to `CODE_GENERATION.md`:
  - New "Cross-language verification & spec support" section: a comparison table
    + per-provider prose (AWS Smithy protocol tests w/ preserved case IDs; GCP
    gapic-showcase + compliance_suite.json + conformance-tests; Azure spector +
    test-proxy + autorest.testserver ancestor; OCI SDKTestingService w/ Java as
    canonical schema; Alibaba darabonba-assert test-gen, uneven) + a synthesis.
  - New "Reproductions: local generator runs" section: results table + per-run
    highlights tying each run to a documented claim.
  - 7th concluding observation (verification as a differentiator); expanded
    Known-gaps with the verification `?? verify` items; replaced the "no run yet"
    closer with the runs summary.
  - Re-ran citation verification: now **63 unique URLs, all SHA-pinned, all 200**.
- Updated STATUS.md / DO_NEXT.md. Deliverable is complete; remaining work is
  optional (gap-chasing, more runs, final human read, `_work/` cleanup).

## 2026-05-30 (session 2 cont. — IaC layer: CDK/Pulumi/Bicep/Terraform)

User extended scope to the IaC layer (CDKs + Pulumi + Bicep), then added
"Terraform itself" + "Terraform providers for various clouds". Decisions:
companion deliverable `IAC_CODEGEN.md` (cross-linked) + local reproductions.

- Planned as "Execution plan v3" in PLAN.md (the generation chain: API spec →
  SDK → TF provider → schema → CDKTF/Pulumi bindings).
- **7 background research agents** → `iac/{cdk-jsii,pulumi,bicep,terraform-core,
  terraform-aws,terraform-google,terraform-azure}.md`, all done, commit-pinned.
  Headlines: jsii = transpile-to-proxies (TS→Node kernel); Pulumi = 5 Go
  generators from a Package Schema (most providers bridged from TF); Bicep =
  DSL→ARM, types generated from azure-rest-api-specs; Terraform = gRPC schema +
  Plugin SDK/Framework + spec codegen (tfplugingen-*); TF providers span
  hand-written↔generated (awscc & Magic Modules fully generated; aws & azurerm
  hand-written over generated scaffolding/SDK; pandora generates go-azure-sdk).
- **5 IaC local runs** under `iac/runs/`: jsii (TS→Python proxy), pulumi (schema
  →Py+Go), bicep (DSL→ARM), terraform-schema (provider schema dump),
  terraform-plugin-codegen (spec→Framework Go). Toolchain added: Smithy CLI,
  pandoc, Pulumi 3.244, Bicep 0.43.8, tfplugingen-framework.
- **README task (user request)**: every build dir now has its own `README.md`
  (added 5 iac + 2 azure subdirs; renamed OCI `IMPOSSIBLE.md`→`README.md` and
  fixed 4 refs). Created root **`README.md`** linking all builds + both
  deliverables + research notes + project docs.
- **`IAC_CODEGEN.md`** synthesized: exec-summary matrix, per-tool sections, the
  generation-chain cross-layer analysis, multi-language-strategy comparison,
  reproductions, 5 conclusions, known gaps. Cross-linked from CODE_GENERATION.md.
- Verified: IAC_CODEGEN.md = 53 unique GitHub URLs all HTTP 200 (only 3
  non-pinned links are bare repo roots); all relative doc links resolve.

## 2026-05-30 (session 2 cont. — per-SDK build profiles)

User: a doc specific to **boto** comparing it with the official next-gen SDK, +
per-SDK docs for famous/most-used SDKs "like boto" (cloud + non-cloud).
Decisions: broad set (AWS flagship + Stripe/Twilio/Octokit/Kubernetes/Google
Discovery); boto compared vs the generated `aws-sdk-python v3` / smithy-python.

- Planned as "Execution plan v4" in PLAN.md; created `sdks/`.
- **6 background research agents** → `sdks/{aws-sdk-python-v3, stripe, twilio,
  github-octokit, kubernetes-client-go, google-apis-client}.md`, all done,
  commit-pinned. Findings: Stripe = closed internal generator off `stripe/openapi`;
  Twilio = **extends OpenAPI Generator** (`TwilioPythonGenerator extends
  PythonClientCodegen`); Octokit = generated TS types from `github/rest-api-
  description` over a hand-written core (+ newer Kiota `octokit/source-generator`
  for go/.NET); Kubernetes = **dual model** (client-go via gengo from Go types;
  python/java/js via OpenAPI Generator off swagger.json); Google Discovery =
  Python runtime-dynamic (**boto-like**) vs Go/Node/Java static codegen.
- **Wrote myself**: the 3 AWS Smithy profiles (`aws-sdk-{js-v3,go-v2,java-v2}.md`)
  from existing aws/notes.md; **`sdks/boto3.md`** (the boto doc: data-driven build
  model verified from source + a side-by-side comparison table vs aws-sdk-python
  v3); `sdks/README.md` (index + cross-SDK build-model matrix).
- Cross-linked from root `README.md` (new "Per-SDK build profiles" section +
  Deliverables row) and `CODE_GENERATION.md` (companion-docs note).
- Verified: **198 unique GitHub URLs across sdks/*.md all resolve, all SHA-pinned**
  (one "404" was a backtick artifact — the repo is 200/archived); all relative
  links resolve (the one flag was a regex inside a JSON snippet, not a link).
- Build-model taxonomy now spans clouds + IaC + famous SDKs: data-driven/runtime
  (boto3, google-api-python-client) · codegen-from-IDL (Smithy SDKs) · bespoke
  C2J+JavaPoet (java-v2) · codegen-from-OpenAPI (Stripe/Twilio/Octokit/k8s-others)
  · gengo-from-Go-types (client-go) · Discovery static (Go/Node/Java).

## 2026-05-30 (session 2 cont. — major Terraform provider docs)

User asked for docs for the major Terraform providers. Created
`terraform-providers/` covering all five project clouds (consistency).
- Wrote `aws.md` (aws + awscc), `google.md` (Magic Modules), `azure.md`
  (azurerm + pandora/go-azure-sdk + azapi) from existing `iac/terraform-*.md`.
- **2 background agents** → `oci.md`, `alibaba.md` (new research):
  - OCI: provider ships UNMARKED resources (no `OracleSDKGenerator` header, unlike
    the SDKs) but structural signals + weekly lockstep-1-day-behind suggest
    internal scaffolding; SDK v2 (tiny Framework); on `oci-go-sdk/v65`. MPL-2.0.
  - Alibaba: external tool seeds files with a "generated automatically" marker but
    devs DELETE the marker on first edit (one-shot seed → hand-owned, NOT
    regenerated like Google); still on **Plugin SDK v1** (oldest of the majors);
    mix of Darabonba + legacy + bespoke SDKs. MPL-2.0.
- Wrote `terraform-providers/README.md` — index + the hand-written↔generated
  matrix + cross-cutting findings ("generated" spans regenerated-artifact →
  disposable-seed; generation often happens one layer down in the SDK;
  plugin-framework adoption as a maturity tell; uniform MPL-2.0).
- Cross-linked from `IAC_CODEGEN.md` + root `README.md`. Verified: all URLs in
  the 2 agent docs + index resolve (HTTP 200, SHA-pinned); relative links resolve.
- Possible extension offered: non-cloud majors (Kubernetes, Helm, Cloudflare,
  Datadog).

## 2026-05-30/31 (session 2 cont. — history/ : cloud APIs + IaC/config-mgmt)

User asked for a `history/` dir, one doc per software "family," chronological,
fully sourced, INCLUDING controversies/spats/gossip but strictly factual (no
guessing; attribute rumors; flag unverifiable). Planned as PLAN.md "v6".
- **8 web-enabled research agents** → `history/{cloud-apis,puppet,chef,saltstack,
  ansible,cloudformation-cdk,terraform,pulumi}.md`. Then **8 more append-only
  agents** added a `## Key people & teams (chronological)` section to each.
- Strict-sourcing held up well: agents flagged "could not verify" items, declined
  to cite guessed URLs (e.g. a 404'd Register link), and separated fact from rumor.
- **Both of the user's headline example claims did NOT verify:**
  - "HashiCorp threatening to deprecate the AWS provider over lack of Amazon
    cooperation" — no source; evidence is the opposite (active joint maintenance,
    v6.0 in 2025, "AWS+AWSCC better together"). Checked the most recent Hashimoto
    interview (Pragmatic Engineer, Feb 25 2026) directly — no such statement in the
    readable content (a cloud-providers audio segment wasn't fetchable). Likely a
    conflation of the AWS-driven "[Service Deprecation] (Maintenance Mode)" issues.
    Hashimoto also left HashiCorp in Dec 2023.
  - "Amazon promoting CFN/CDK against Terraform" — adversarial framing unverified;
    sources show coopetition weighted to cooperation (CDKTF co-build, Cloud Control
    launch partner, AWS Prescriptive Guidance recommends Terraform).
  Both recorded explicitly in `history/README.md` "Claims we could NOT verify".
- Genuinely-documented juicy bits captured & sourced: BSL/OpenTofu fork + C&D;
  Chef ICE/Seth Vargo (Vargo was at Google, not Chef, at the time); Puppet
  source-available revolt → OpenVox; Salt 2020 CVE mass-exploitation; founder
  arcs (Hashimoto→Ghostty, Dadgar stepped down ~2026, Adam Jacob→System Initiative,
  Hatch→ContextOS, Elad Ben-Israel: CDK/jsii creator→Wing→shut down 2025).
- Wrote `history/README.md` (index + cross-family master timeline + people thread
  + the could-not-verify record). Cross-linked from root README.
- Ran full URL verification across all `history/*.md` (376 unique URLs) — see
  result line below once the background check finishes; expect some 403s
  (bot-blocked but live: The Register, GeekWire, allthingsdistributed, LinkedIn)
  which agents already flagged, vs any real 404s to fix.

## 2026-05-31 (session 2 cont. — MASSIVE history-corpus expansion)

User iteratively requested ~34 more history docs across many turns. The `history/`
corpus grew to **42 topic docs (~17k lines)** spanning cloud APIs & storage, VCS &
git hosting, config-mgmt, declarative IaC, containers/orchestration, K8s-config/
GitOps, CD/release, build/CI-as-code, dev-tooling/LSP, developer cloud platforms,
and emerging/AI-native. New docs (each chronological + people + company +
controversies, strict-sourced, via web-enabled subagents):
- Storage: s3-object-storage, ceph. VCS/hosting: bitkeeper, github, gitlab,
  bitbucket, gerrit. Containers: docker, kubernetes. K8s/GitOps: helm, kustomize,
  jsonnet-tanka, crossplane, argocd-flux, argocd. CD/release: juju, bosh,
  spinnaker. Config langs/CaC: cfengine, vagrant-packer, nix, lsp. Build/CI:
  dagger, earthly. Vendor IaC: gcp-deployment-manager, openstack-heat,
  aws-opsworks. Next-gen: winglang-system-initiative, serverless-iac,
  emerging-iac. Dev platforms: fly-io, ngrok, replit.
- **`WASM_DOCKER_alternate_history.md`** — the Solomon Hykes "if WASM existed, no
  Docker" tweet; built in 3 passes (base → WASM/Firecracker "leverage today"
  landscape → more threads + per-claim attribution + "who's building on it");
  ~1,255 lines. Includes Microsoft Hyperlight, the WASIX schism, named HN voices.
- Agents repeatedly corrected my floated leads (no guessing): Gerrit≠anagram of
  Git (named after architect Rietveld); Applatix CEO was Wadher not Wang; Nix
  "SnowflakeOS" unfounded; ngrok Series A was Lightspeed+Coatue not a16z; Fly.io
  funding is Intel/a16z/EQT not a $1B a16z round; Replit's Masad is Jordanian-
  American; Bytecode Alliance MS joined 2021 not founded 2019; etc.
- Juicy/sourced highlights captured: BitKeeper→Git origin; GitLab 2017 & Replit
  2025 DB-deletion incidents; Chef ICE/Vargo; Puppet OpenVox; Salt CVEs; Docker
  Moby/licensing; Weaveworks shutdown; Nix governance fork (Lix); Armory collapse;
  the cross-corpus AI-native pivot.
- **Finalization**: rewrote `history/README.md` (categorized index + cross-corpus
  master timeline + recurring themes + a "claims we could NOT verify" record);
  refreshed root `README.md` + STATUS. URL sweep over all 1,354 history URLs:
  ~1,116 live (200), ~163 are 403/429 bot-blocks/rate-limits (live), most 000s are
  businesswire/prnewswire/investor/academic pages that block automated fetchers
  (live for readers), ~19 "404"s were trailing-`)` Wikipedia extraction artifacts;
  ~19 genuine moved/dead links were **Wayback-wrapped** (verified sample resolves).
  Separate 259-URL check of the 4 newest docs (fly-io/ngrok/replit/WASM) in flight.

## 2026-05-31 (session 2 cont. — corpus expansion to 61 docs)

User kept requesting more history docs; the corpus grew to **61 topic docs
(~25.6k lines)**. Added (each chronological + people + company + controversies,
strict-sourced via web-enabled subagents): **Databases** — postgresql, mongodb,
redis, sqlite, duckdb, graph-databases. **Data-infra** — mapreduce-hadoop, airflow.
**Messaging/streaming** — kafka, rabbitmq, celery. **Web/app frameworks** — spring,
rails, fastapi, wordpress-php-ecommerce. **Business-workflow/automation** —
bpmn-camunda, n8n-lowcode. **Cloud/CDN/dev-platforms** — openstack, cloudflare-cdn,
fly-io, ngrok, replit. Plus the 3-pass **WASM_DOCKER_alternate_history.md**.
- Big relicensing-era additions: MongoDB SSPL, Redis→Valkey fork, Confluent
  Community License, n8n fair-code — with PostgreSQL's permissive license as the
  explicit counterpoint ("Postgres won"). Juicy stories: the WP Engine war, the
  Hadoop big-data wars, Replit's 2025 AI-agent DB deletion, the BitKeeper→Git
  origin, Cloudflare de-platforming, the Camunda fork lineage.
- Agents kept correcting my floated leads (no guessing): ngrok round = Lightspeed
  not a16z; Fly.io funding = Intel/a16z/EQT not $1B; n8n 2020 = seed not Series A;
  FastAPI = Dec 8 not Dec 5, FastAPI Labs $4.2M not $12.5M; Dgraph→Hypermode 2023
  not 2024; Applatix CEO = Wadher; Masad = Jordanian-American; etc.
- **Finalization**: rewrote `history/README.md` (61 docs in 15 categories + a
  1986→2026 master timeline + expanded themes incl. the relicensing era/Postgres
  counterpoint + the could-not-verify record); compacted the root README history
  section; updated STATUS. Launched a 753-URL verification sweep over the 19 newest
  docs (result + any Wayback-wraps to follow).
