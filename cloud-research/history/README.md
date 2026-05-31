# A history of cloud, infrastructure, data & developer tooling

A large, chronological, **fully-sourced** history corpus (**92 docs, ~37,800 lines**)
covering the technologies and companies behind modern cloud infrastructure,
databases, data & messaging systems, version control, containers, IaC/config
management, web frameworks, and developer tooling — including the controversies,
relicensing schisms, acquisitions, and the people who built it all.

Companion to the build-mechanics deliverables: [`../CODE_GENERATION.md`](../CODE_GENERATION.md)
(SDK codegen), [`../IAC_CODEGEN.md`](../IAC_CODEGEN.md), [`../terraform-providers/`](../terraform-providers/README.md),
[`../sdks/`](../sdks/README.md).

> **Sourcing standard.** Every claim carries a real URL; controversies/gossip are
> attributed to the outlet/person that reported them; anything unconfirmed is marked
> **"Could not verify"** rather than asserted. Each doc ends with "Key people & teams"
> and (where applicable) "Company & corporate history" threads.

## The docs, by category

### Foundations — cloud APIs & storage
- [cloud-providers-timeline.md](cloud-providers-timeline.md) — the five clouds side by side: launch dates, founding teams, where those people went next, and strategic acquisitions (AWS/Azure/GCP/OCI/Alibaba) + a cross-cloud master timeline
- [cloud-apis.md](cloud-apis.md) — origins overview (S3/EC2 2006, boto, config-mgmt → IaC, Swagger→OpenAPI)
- [s3-object-storage.md](s3-object-storage.md) — Amazon S3 & the object-storage paradigm; the S3 API as a de facto standard
- [ceph.md](ceph.md) — Ceph (Sage Weil); RADOS/CRUSH; Inktank → Red Hat → IBM

### Databases
- [postgresql.md](postgresql.md) — Ingres → POSTGRES → PostgreSQL; the permissive-license superpower; the "Postgres won" wave
- [mongodb.md](mongodb.md) — 10gen/NoSQL; the **SSPL relicense** → AWS DocumentDB
- [redis.md](redis.md) — antirez; the 2024 relicense → **the Valkey fork**; the AGPL re-addition
- [sqlite.md](sqlite.md) — D.R. Hipp; public-domain; most-deployed DB on earth; the no-PRs/Fossil/TH3 model
- [duckdb.md](duckdb.md) — CWI; "SQLite for analytics"; Foundation/Labs/MotherDuck; "Big Data is Dead"
- [graph-databases.md](graph-databases.md) — graph DBs & RDF triple stores (Neo4j, Titan/JanusGraph, the GQL standard)

### Data infrastructure & orchestration
- [mapreduce-hadoop.md](mapreduce-hadoop.md) — the Google papers, Hadoop, the Cloudera/Hortonworks/MapR wars, the decline
- [airflow.md](airflow.md) — Apache Airflow & the orchestration landscape (Prefect, Dagster, Temporal)

### Messaging, streaming & task queues
- [kafka.md](kafka.md) — Kafka/Confluent; "The Log"; the Confluent Community License; Kafka-on-S3
- [rabbitmq.md](rabbitmq.md) — AMQP/JPMorgan origins; Erlang; the SpringSource→VMware→Broadcom chain
- [celery.md](celery.md) — Ask Solem; the Python distributed task queue (rides on RabbitMQ/Redis)

### Version control & code hosting
- [bitkeeper.md](bitkeeper.md) — BitKeeper & the 2005 crisis that **created Git and Mercurial**
- [github.md](github.md) — GitHub (2008 → Microsoft $7.5B → Copilot)
- [gitlab.md](gitlab.md) — GitLab (the 2017 database incident; IPO)
- [bitbucket.md](bitbucket.md) — Bitbucket (Mercurial-only → Atlassian → the 2020 Hg sunset)
- [gerrit.md](gerrit.md) — Gerrit (Rietveld lineage; Shawn Pearce; JGit)

### Configuration management
- [cfengine.md](cfengine.md) — CFEngine (1993, Burgess, Promise Theory) — the original
- [puppet.md](puppet.md) — Puppet (2005 → Perforce → OpenVox fork)
- [chef.md](chef.md) — Chef (Opscode → the ICE/Seth Vargo episode → Progress)
- [saltstack.md](saltstack.md) — Salt (2011 → 2020 CVE mass-exploitation → VMware → Broadcom)
- [ansible.md](ansible.md) — Ansible (2012 → Red Hat → IBM; the collections split)

### Declarative IaC & cloud platforms
- [cloudformation-cdk.md](cloudformation-cdk.md) — AWS CloudFormation (2011) & CDK
- [terraform.md](terraform.md) — Terraform/HashiCorp (BSL → OpenTofu fork → IBM)
- [pulumi.md](pulumi.md) — Pulumi (2017; Microsoft-alumni founders)
- [gcp-deployment-manager.md](gcp-deployment-manager.md) — GCP Deployment Manager & Config Connector
- [openstack.md](openstack.md) — OpenStack (Rackspace+NASA; the vendor wars; resurgence)
- [openstack-heat.md](openstack-heat.md) — OpenStack Heat (the CFN-compatible orchestrator)
- [aws-opsworks.md](aws-opsworks.md) — AWS OpsWorks (managed Chef/Puppet; retired 2024)

### Containers & orchestration
- [docker.md](docker.md) — Docker (dotCloud → OCI/Moby → Mirantis split → licensing fights)
- [kubernetes.md](kubernetes.md) — Kubernetes (Borg lineage; the orchestration wars; CNCF)

### Kubernetes config & GitOps
- [helm.md](helm.md) — Helm (Deis→Microsoft; the Tiller saga)
- [kustomize.md](kustomize.md) — Kustomize (Google; the kubectl-integration fight)
- [jsonnet-tanka.md](jsonnet-tanka.md) — Jsonnet & Tanka (+ the abandoned Ksonnet)
- [crossplane.md](crossplane.md) — Crossplane (Upbound; control-plane IaC)
- [argocd-flux.md](argocd-flux.md) — GitOps: Argo CD + Flux (the Weaveworks shutdown)
- [argocd.md](argocd.md) — Argo CD deep-dive (Applatix → Intuit → Akuity)

### CD, build & dev environments
- [juju.md](juju.md) — Juju (Canonical; "Ensemble"; charms)
- [bosh.md](bosh.md) — BOSH (Cloud Foundry's deploy tool)
- [spinnaker.md](spinnaker.md) — Spinnaker (Netflix CD; the Armory collapse)
- [vagrant-packer.md](vagrant-packer.md) — Vagrant & Packer (HashiCorp's first tools)
- [dagger.md](dagger.md) — Dagger (Solomon Hykes; CI-as-code → AI agents)
- [earthly.md](earthly.md) — Earthly (Earthfile; the 2025 wind-down → Lunar)

### Web & application frameworks
- [spring.md](spring.md) — Spring (Rod Johnson; Interface21→SpringSource→VMware→Broadcom; Spring Boot)
- [rails.md](rails.md) — Ruby on Rails (DHH/Basecamp; the 2021 exodus; the cloud exit)
- [fastapi.md](fastapi.md) — FastAPI (tiangolo; Starlette/Pydantic; the OpenAPI tie-in)
- [wordpress-php-ecommerce.md](wordpress-php-ecommerce.md) — WordPress/WooCommerce + PHP e-commerce; the **WP Engine war**

### Business workflow & automation
- [bpmn-camunda.md](bpmn-camunda.md) — BPMN/BPEL standards & Camunda (the jBPM→Activiti→Flowable lineage)
- [n8n-lowcode.md](n8n-lowcode.md) — n8n (fair-code) & the low-code/no-code/iPaaS landscape

### Reproducible systems & language tooling
- [nix.md](nix.md) — Nix/NixOS (Dolstra; the 2024 governance blowup; the Lix fork)
- [lsp.md](lsp.md) — Language Server Protocol & the parser infrastructure beneath it

### Application hosting: PaaS, edge, serverless & BaaS

**Managed application PaaS (the Heroku lineage):**
- [heroku.md](heroku.md) — Heroku (`git push` PaaS; Twelve-Factor; Salesforce; the 2022 breach + free-tier removal; "Fir")
- [render.md](render.md) — Render (the "Heroku successor"; spin-down free tier; the $1.5B 2026 valuation)
- [railway.md](railway.md) — Railway (DX-first PaaS; Nixpacks→Railpack; the 2023 free-tier removal; Railway Metal)
- [fly-io.md](fly-io.md) — Fly.io (the developer cloud on Firecracker microVMs)
- [digitalocean.md](digitalocean.md) — DigitalOcean (the $5 Droplet; the tutorials engine; 2021 IPO; the Paperspace AI pivot)
- [koyeb.md](koyeb.md) — Koyeb (Paris; Firecracker-on-bare-metal serverless; acquired by Mistral AI, Feb 2026)
- [northflank.md](northflank.md) — Northflank (full-stack PaaS-on-Kubernetes; bring-your-own-cloud; GPU/AI)
- [platform-sh.md](platform-sh.md) — Platform.sh (out of Commerce Guys; immutable per-branch envs; the Upsun rebrand)
- [porter.md](porter.md) — Porter (YC S20; Heroku-style deploys into *your own* AWS/GCP/Azure on Kubernetes)
- [qovery.md](qovery.md) — Qovery (Paris; self-service PaaS on your own cloud; the open-source Rust Engine)
- [scalingo.md](scalingo.md) — Scalingo (Strasbourg; the European sovereignty-focused Heroku alternative; SecNumCloud)
- [clever-cloud.md](clever-cloud.md) — Clever Cloud (Nantes; bootstrapped EU PaaS; digital sovereignty; the Materia DBs)
- [aptible.md](aptible.md) — Aptible (YC S14; the HIPAA/SOC 2 compliance PaaS "Enclave"; → Opti9 2025)

**Frontend / Jamstack / edge platforms:**
- [vercel.md](vercel.md) — Vercel (ZEIT→Vercel; Next.js; the frontend cloud; the funding ladder to $9.3B)
- [netlify.md](netlify.md) — Netlify (BitBalloon→Netlify; coined "Jamstack"; the Gatsby buy; the Vercel rivalry)
- [cloudflare-cdn.md](cloudflare-cdn.md) — Cloudflare & the CDN/edge landscape (Akamai, Fastly, the edge-compute wave)
- [deno-deploy.md](deno-deploy.md) — Deno & Deno Deploy (Ryan Dahl post-Node; V8-isolate edge; the Oracle "JavaScript" fight)
- [surge.md](surge.md) — Surge.sh (Brock Whitten; one of the earliest CLI static-site publishers; a Netlify precursor)
- [val-town.md](val-town.md) — Val Town (Steve Krouse; "runnable GitHub Gists"; the Townie AI pivot)

**Serverless & AI-agent compute / sandboxes:**
- [modal.md](modal.md) — Modal (Erik Bernhardsson; serverless Python compute for AI/ML on gVisor; $4.65B by 2026)
- [e2b.md](e2b.md) — E2B (Firecracker sandboxes as "the runtime for AI agents"; the Code Interpreter SDK)
- [daytona.md](daytona.md) — Daytona (Ivan Burazin; self-hosted dev-envs → AI-agent sandbox infrastructure)

**Self-hosted & open-source PaaS:**
- [dokku.md](dokku.md) — Dokku (Jeff Lindsay; "the smallest PaaS" — the canonical self-hosted Heroku, in Bash)
- [caprover.md](caprover.md) — CapRover (Kasra Bigdeli; self-hosted PaaS on Docker Swarm; the 2023 relicense dispute)
- [coolify.md](coolify.md) — Coolify (Andras Bacsai; the breakout open-source self-hostable Heroku/Vercel alternative)
- [kamal.md](kamal.md) — Kamal (37signals/DHH; MRSK→Kamal; deploy to your own metal; the "cloud exit"; a Rails 8 default)
- [cloud-foundry.md](cloud-foundry.md) — Cloud Foundry (VMware 2011; the original open-source PaaS; Pivotal→Broadcom; Korifi on k8s)
- [openshift.md](openshift.md) — Red Hat OpenShift (2011; gears/cartridges → the Kubernetes rewrite (v3); OpenShift 4 on CoreOS; IBM)

**Backend-as-a-Service (BaaS):**
- [firebase.md](firebase.md) — Firebase (Envolve→realtime DB; Google's 2014 acquisition; Firestore; the app-dev platform)
- [supabase.md](supabase.md) — Supabase (YC S20; "open-source Firebase on Postgres"; the funding ladder to a $5B 2025 round)
- [appwrite.md](appwrite.md) — Appwrite (Eldad Fux; self-hostable open-source BaaS; the Supabase foil)
- [nhost.md](nhost.md) — Nhost (open-source Firebase alternative on Postgres + Hasura/GraphQL)

**Tunnels & browser IDEs:**
- [ngrok.md](ngrok.md) — ngrok (secure tunnels → unified ingress)
- [replit.md](replit.md) — Replit (browser IDE → AI app-builder; the 2025 agent-deleted-a-DB incident)

### Next-gen & emerging
- [winglang-system-initiative.md](winglang-system-initiative.md) — Wing & System Initiative (ex-CDK/ex-Chef founders)
- [serverless-iac.md](serverless-iac.md) — Serverless Framework & SST
- [emerging-iac.md](emerging-iac.md) — the 2021–2026 IaC landscape (new config languages, TACOS, IDPs, AI-native)
- [WASM_DOCKER_alternate_history.md](WASM_DOCKER_alternate_history.md) — the Hykes "if WASM existed, no Docker" thesis; the server-WASM/Firecracker movement; who's building on it

## Master timeline (selected milestones; full citations in each doc)

| Year | Milestone |
|---|---|
| 1986 / 1993 | **POSTGRES** (Stonebraker, Berkeley) · **CFEngine** (Burgess) |
| 1995–1998 | PHP · MySQL · **Akamai** (the first CDN, MIT) |
| 1999–2002 | **BitKeeper**; the kernel adopts it (2002); BPEL4WS |
| 2003–2004 | Google's **GFS & MapReduce** papers; **Ruby on Rails**; **WordPress**; BPMN 1.0 |
| 2005 | **Puppet**; the BitKeeper crisis → **Git** & **Mercurial**; **Spring 1.0** |
| 2006 | **S3** & **EC2** & **boto**; the Ceph & Bigtable papers; **Hadoop** |
| 2007 | **iPhone**; **Heroku**; **Magento**; RabbitMQ; **MongoDB/10gen** |
| 2008 | **Opscode/Chef**; **GitHub**; **Gerrit**; **Bitbucket**; CloudFront; Azure announced |
| 2009 | **Redis**; **Cloudera**; Chef released; **NoSQL** era |
| 2010 | Azure & GCS GA; **OpenStack** (Rackspace+NASA); **Vagrant**; Cloudflare; Juju; BOSH |
| 2011 | **CloudFormation**; **Kafka** (LinkedIn); **Salt**; OpenStack Heat; **Fastly**; GitLab; WooCommerce |
| 2012 | **HashiCorp**; **Ansible**; Inktank; Airtable; the big-data wars peak |
| 2013 | **Docker** revealed; **Camunda**; **Spark**→**Databricks**; Pivotal/Cloud Foundry; **Confluent**; Magento→eBay |
| 2014 | **Terraform**; **Kubernetes announced**; **Airflow** (Airbnb); Hortonworks IPO; jsonnet |
| 2015 | **k8s 1.0 + CNCF**; **Helm**; **Spinnaker** OSS; OpenAPI Initiative; Magento→Permira; WooThemes→Automattic |
| 2016 | **LSP**; Pulumi/Heptio founded; WordPress Gutenberg work; Power Automate |
| 2017 | Terraform Registry; **Pulumi**; **Argo Workflows**; Docker adds k8s (Swarm loses); the "Moby" affair; **GitLab DB incident**; Cloudflare drops Daily Stormer |
| 2018 | **AWS CDK**; **GitHub→Microsoft ($7.5B)**; k8s graduates; Heptio→VMware; **Tree-sitter**; n8n; **Magento→Adobe ($1.68B)**; **MongoDB SSPL**; **Confluent Community License** |
| 2019 | CDK GA; **Chef ICE / Seth Vargo**; Mirantis/Docker Enterprise; **Crossplane**; Cloudera+Hortonworks merge; **HashiCorp/GitLab/Fastly/Cloudflare IPOs**; FastAPI |
| 2020 | Ansible collections; **Salt CVE mass-exploitation**; **Bitbucket Mercurial sunset**; S3 strong consistency; Docker Hub limits; Airflow 2.0; Redis Commons-Clause→RSAL |
| 2021 | Cloud Control API; **HashiCorp/GitLab IPOs**; **Docker Desktop licensing**; Akuity; pgvector; Confluent IPO |
| 2022 | Perforce/Puppet; CDKTF GA; Ben-Israel→**Wing**; Argo/Flux graduate; **dockershim removed**; the Basecamp/Rails exodus |
| 2023 | **HashiCorp BSL → OpenTofu**; **System Initiative**; Broadcom/VMware; "Big Data is Dead"; KCL/Radius; Pkl(2024) |
| 2024 | **OpenTofu C&D**; IBM→HashiCorp announced; **Puppet source-available**; **Weaveworks shutdown**; Apple opens **Pkl**; **WP Engine war**; **Redis relicense → Valkey fork**; GQL ISO standard |
| 2025 | **IBM closes HashiCorp**; **OpenVox**; Wing shuts down; **Earthly Lunar**; **Dagger/Replit AI agents** (& Replit's agent deletes a prod DB); **Databricks→Neon / Snowflake→Crunchy** ("Postgres won"); **Fermyon→Akamai**; Redis 8 re-adds AGPL; n8n $180M @ $2.5B |

## Recurring themes across the corpus
- **The relicensing era**: MongoDB (SSPL), Redis (→ Valkey fork), Elastic, HashiCorp (BSL → OpenTofu), Confluent (Community License), Puppet (source-available → OpenVox), Serverless V4, n8n (fair-code), Chef (Cinc). The 2018–2025 open-source-business-model reckoning — usually a cloud-vendor-vs-vendor fight. **PostgreSQL is the counterpoint**: a permissive, un-relicensable license is exactly why its ecosystem (and the 2025 "Postgres won" acquisitions) could thrive.
- **The acquisition treadmill**: Red Hat→IBM (Ansible); SaltStack/SpringSource/RabbitMQ/Cloud Foundry → VMware → Broadcom; Puppet→Perforce; Chef→Progress; Docker Enterprise→Mirantis; HashiCorp→IBM; Citus/Fermyon/Crunchy/Neon→(Microsoft/Akamai/Snowflake/Databricks); Magento→eBay→Adobe.
- **Founders who left to reinvent**: Hykes (Docker→Dagger), Adam Jacob (Chef→System Initiative), Elad Ben-Israel (CDK→Wing), Hatch (Salt→ContextOS), McLuckie/Beda (k8s→Heptio), Beauchemin (Airflow→Superset/Preset), Bernhardsson (Luigi→Modal).
- **The AI-native pivot (2024–2026)**: Dagger, System Initiative, Pulumi (Neo), Earthly (Lunar), Crossplane, n8n, Zapier, GitHub/GitLab Copilot/Duo, Replit/Cursor — nearly every survivor repositioned around AI agents.
- **Standardization truces**: OCI (containers), OpenAPI, CNCF, WASI/Component-Model, LSP, **GQL** (the first new ISO DB language since SQL), AMQP — the "M×N → M+N" pattern.
- **The database-deletion lineage & AI-agent safety**: GitLab's 2017 human-caused production-DB deletion → Replit's 2025 *AI-agent*-caused deletion — driving the rise of ephemeral microVM/WASM sandboxes (Fly.io, e2b, Modal, Microsoft Hyperlight) to contain untrusted agent code. See [`WASM_DOCKER_alternate_history.md`](WASM_DOCKER_alternate_history.md), [`replit.md`](replit.md), [`fly-io.md`](fly-io.md).
- **"Big data" → "small/local data"**: Hadoop/MapReduce → Spark/cloud-warehouses → DuckDB/"Big Data is Dead." See [`mapreduce-hadoop.md`](mapreduce-hadoop.md), [`duckdb.md`](duckdb.md).

## Claims investigated and NOT verified (the record, kept straight)
Per the strict-factual rule, several widely-repeated claims did **not** hold up:
1. **"HashiCorp was preparing to deprecate the AWS provider over lack of Amazon cooperation"** — unverified; evidence is the opposite. → `terraform.md`
2. **"Amazon promoting CloudFormation/CDK *against* Terraform"** — adversarial framing unverified; sources show coopetition. → `cloudformation-cdk.md`
3. **"Gerrit" as an anagram of "Git"** — folklore; named after architect Gerrit Rietveld. → `gerrit.md`
4. **"Applatix CEO Hong Wang"** — its CEO was Pratik Wadher; Wang was a founding engineer. → `argocd.md`
5. **"SnowflakeOS" tied to the Nix/Anduril controversy** — no source; the dispute was over NixCon sponsorship. → `nix.md`

Per-doc "Could not verify" sections hold the smaller flagged items (exact dates, funding figures, paywalled/403 pages corroborated via secondary sources, etc.).
