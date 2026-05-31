# Status

Last updated: 2026-05-30 (session 2)

## Phase
SDK layer complete: 0 (setup), 1 (recon), R (runs), V (verification), S
(synthesis) → `CODE_GENERATION.md`. IaC layer complete: research (7 topics),
runs (5), synthesis → `IAC_CODEGEN.md`. Every build directory has a `README.md`;
root `README.md` links them all. Both deliverables citation-verified. Remaining =
optional gap-chasing + a final human read.

## Deliverables
- [README.md](README.md) — entry point / index linking everything
- [CODE_GENERATION.md](CODE_GENERATION.md) — SDK layer (5 clouds)
- [IAC_CODEGEN.md](IAC_CODEGEN.md) — IaC layer (CDK/Pulumi/Bicep/Terraform)
- [sdks/](sdks/README.md) — per-SDK build profiles (boto3 vs AWS Python v3, AWS
  flagship SDKs, Stripe, Twilio, Octokit, Kubernetes client-go, Google Discovery)
  + cross-SDK build-model matrix. All 198 citations verified (HTTP 200, SHA-pinned).
- [CLOUD_API_COMPARISON.md](CLOUD_API_COMPARISON.md) — CTO/senior-engineer-grade
  side-by-side comparison of the five clouds' APIs, styles & protocols (REST/gRPC/
  GraphQL/query-RPC, HTTP/1.1 vs HTTP/2, JSON/Protobuf/XML/CBOR, auth/LRO/pagination/
  errors/streaming) + decision takeaways. Synthesizes the SDK-layer research.
  Every non-obvious claim verified against actual specs/code (Smithy protocols,
  GAPIC default transport=gRPC, ARM async headers, OCI opc-* headers, etc.).
- [FREE_COMPUTE.md](FREE_COMPUTE.md) — sourced/dated survey of ultra-cheap & free
  compute from reputable providers (hyperscaler always-free tiers, free CI/CD, free
  GPU/notebooks, free PaaS/dev-envs) + the 2022–2025 free-tier retreat. All figures
  as-of May 2026, official-source-linked.
- [history/cloud-providers-timeline.md](history/cloud-providers-timeline.md) — the
  five clouds' launch/people/acquisitions timeline + a corroboration pass with
  Hacker News threads and major outages per cloud. Fully URL-sourced.
- [terraform-providers/](terraform-providers/README.md) — major Terraform provider
  profiles for all five clouds (AWS `aws`+`awscc`, Google Magic Modules, Azure
  `azurerm`+`azapi`, OCI, Alibaba) + hand-written↔generated matrix. URLs verified.
- [history/](history/README.md) — a large (**92 topic docs, ~37.8k lines**)
  chronological, fully-sourced history corpus. Now includes a **24-doc application-hosting
  cluster** — managed PaaS (Heroku/Render/Railway/Fly.io/Koyeb/Northflank/Platform.sh/
  Porter/Qovery/Scalingo/Clever Cloud/Aptible), frontend/edge (Vercel/Netlify/Deno
  Deploy/Surge/Val Town), AI-sandbox compute (Modal/E2B/Daytona), self-hosted PaaS
  (Dokku/CapRover/Coolify/Kamal/Cloud Foundry/OpenShift), and BaaS (Firebase/Supabase/
  Appwrite/Nhost) — plus DigitalOcean and the cloud-providers timeline. Categories: cloud-APIs/storage,
  **databases** (Postgres/Mongo/Redis/SQLite/DuckDB/graph), **data-infra** (Hadoop/
  Airflow), **messaging/streaming** (Kafka/RabbitMQ/Celery), VCS/hosting, config-mgmt,
  declarative-IaC + cloud platforms (incl. OpenStack), containers/orchestration,
  K8s-config/GitOps, CD/build/dev-env, **web/app frameworks** (Spring/Rails/FastAPI/
  WordPress+PHP-ecommerce), **business-workflow/automation** (BPMN-Camunda/n8n-lowcode),
  reproducible/tooling (Nix/LSP), dev-cloud-platforms/CDN (Fly/ngrok/Replit/Cloudflare),
  and next-gen/emerging (Wing/SI, serverless, emerging-IaC, WASM/Docker thesis). Each
  doc has "key people & teams" + "company & corporate history" threads; the index has
  a cross-corpus master timeline (1986→2026) + recurring themes (the relicensing era +
  PostgreSQL counterpoint, the acquisition treadmill, the AI-native pivot, the
  database-deletion lineage) + a "claims we could NOT verify" record. URL verification:
  earlier sweeps done + dead links Wayback-wrapped; 753-URL check of the 19 newest docs
  in flight.

## Scope (confirmed + delivered)
- Languages: Python, Go, Java, TypeScript ✓
- Case studies: object storage, messaging, FaaS ✓
- Run generators locally (≥1 per cloud) ✓ — 4 reproduced, OCI documented impossible
- Cross-language verification & spec support ✓ (added mid-project by user)
- Depth: architectural + concrete examples ✓

## Done
- `<provider>/notes.md` + `links.md` — Phase 1 recon (all 5).
- `<provider>/verification.md` — Phase V cross-language verification (all 5).
- `<provider>/runs/...` — local generator runs:
  - GCP `runs/cloudfunctions-python/` — SUCCESS (gapic-generator-python, 63 files)
  - Alibaba `runs/darabonba-multilang/` — SUCCESS (one .dara → Py + Go)
  - Azure `runs/widget-autorest-python/` + `runs/widget-typespec-ts/` — SUCCESS (dual stack)
  - AWS `runs/sqs-typescript/` — SUCCESS (smithy build, real SQS model, 46 files)
  - OCI `runs/README.md` — documented non-run (closed-source generator)
- `CODE_GENERATION.md` — exec-summary matrix, per-provider depth, 4 side-by-side
  comparison tables, **Cross-language verification & spec support** section,
  **Reproductions** section, 7 concluding observations, Known-gaps section.
- Citation verification: 63 unique URLs, all SHA-pinned, all HTTP 200.

## In progress / blocked
- Nothing running; nothing blocked.

## Optional remaining (see DO_NEXT.md)
- Chase the `?? verify` gaps if desired (codegen gaps + verification gaps; all
  noted inline in CODE_GENERATION.md and in each provider's notes).
- Final human read-through.
- `_work/` holds scratch venvs/clones/node_modules — reproducible via each run's
  `cmd.sh`; safe to delete to reclaim disk.
