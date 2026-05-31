# Emerging IaC / Configuration-as-Code Landscape (≈2021–2026)

A current-and-emerging-landscape survey of up-and-coming infrastructure-as-code
(IaC) and configuration-as-code projects and companies, grouped by category.
Each entry carries founding year, funding (where verifiable), and current
status, with an inline source link per claim.

This is a deliberately **skeptical** doc: the 2024–2026 IaC/"platform
engineering"/"AI-native infra" space is saturated with marketing language
("world's first," "AI-native," "agentic"). Such claims are **attributed to the
company that made them**, not asserted as fact. Anything not confirmed against a
primary or reputable secondary source is flagged **"Could not verify"** inline
and collected in the [`## Could not verify`](#could-not-verify) section at the
end.

> **Cross-references — not duplicated here.** Several major players have their
> own dedicated histories in this directory and are only summarized / linked:
> - [`terraform.md`](./terraform.md) — Terraform / HashiCorp / the BSL relicense / **OpenTofu** fork (the substrate most "TACOS" tools orchestrate).
> - [`pulumi.md`](./pulumi.md) — Pulumi (incl. its AI products, summarized again below under the AI wave).
> - [`crossplane.md`](./crossplane.md) — Crossplane / Upbound (Kubernetes-native control plane).
> - [`winglang-system-initiative.md`](./winglang-system-initiative.md) — **Winglang** (shut down Apr 2025) and **System Initiative** (incl. its 2025 "AI-native" relaunch, summarized again below).
> - [`serverless-iac.md`](./serverless-iac.md) — Serverless Framework and SST.
> - [`dagger.md`](./dagger.md) — Dagger (incl. its AI-agent direction).
> - [`jsonnet-tanka.md`](./jsonnet-tanka.md) — Jsonnet and Tanka.

---

## 1. New configuration languages

The thesis behind this cluster: YAML/JSON/Helm-templating is error-prone, so a
typed/constraint-based configuration language should sit above it. Most of these
are open-source projects first; commercial wrappers are recent and small.

### CUE (cuelang)
- **Created by Marcel van Lohuizen**, who spent ~18+ years at Google where he
  co-created Borg and the GCL configuration language (the lineage CUE draws on).
  CUE merges types, values, and constraints into one concept.
  ([CUE Labs "About" page](https://cue.dev/about/);
  [Go Time #163 podcast with van Lohuizen, Jolly & Peppe](https://changelog.com/gotime/163);
  [DEVCLASS, Jan 12 2022](https://devclass.com/2022/01/12/cue-language/)).
- **Open-source project status:** independent, community-maintained, predates the
  company. Adopters cited include Microsoft, Fastly, Alibaba, Elastic
  ([CUE Labs PR, Oct 30 2025](https://www.prnewswire.com/news-releases/sequoia-backed-cue-labs-the-company-behind-widely-adopted-cue-open-source-project-emerges-from-stealth-to-tackle-multi-billion-dollar-configuration-challenge-302599632.html)).
- **2025 — CUE Labs (the company) emerges from stealth.** On **October 30, 2025**,
  CUE Labs (HQ Zug, Switzerland), founded by **Marcel van Lohuizen and Paul Jolly**,
  announced **over $10M in early funding led by Sequoia Capital and OSS Capital**,
  with Founders Fund, Dell Technologies Capital, and angels participating. Its
  commercial product is the "Configuration Control Plane" (with a Central
  Registry component).
  ([CUE Labs PR, Oct 30 2025](https://www.prnewswire.com/news-releases/sequoia-backed-cue-labs-the-company-behind-widely-adopted-cue-open-source-project-emerges-from-stealth-to-tackle-multi-billion-dollar-configuration-challenge-302599632.html)).
  - **Could not verify:** the exact founding *date/year* of CUE Labs the company
    (the PR gives the stealth-exit date, not an incorporation date).

### Pkl (Apple)
- **Open-sourced by Apple on February 1, 2024**, as version 0.25.0 under (per
  Apple's open-source page) Apache-2.0. Pronounced "Pickle." A configuration
  language blending declarative key/value structure with general-purpose
  features (classes, functions, loops); generates JSON/YAML/XML/plist.
  Attributed to "the Pkl Team" rather than named individuals.
  ([Pkl blog, "Introducing Pkl," Feb 1 2024](https://pkl-lang.org/blog/introducing-pkl.html);
  [Apple Open Source — Pkl](https://opensource.apple.com/projects/pkl/);
  [InfoQ, Feb 2024](https://www.infoq.com/news/2024/02/apple-pkl-configuration-lang/)).
- **Status:** used internally at Apple "for several years" before release; now an
  open-source project. No separate company.
  ([InfoQ, Feb 2024](https://www.infoq.com/news/2024/02/apple-pkl-configuration-lang/)).

### KCL (KusionStack / Ant Group → CNCF)
- **Initiated and open-sourced by Ant Group**; KusionStack (and KCL alongside it)
  was first incubated at Ant Group in 2020, with KCL **open-sourced in May 2022**.
  "K"=Kubernetes, "C"=Configuration, "L"=Language; a constraint-based record &
  functional language.
  ([KCL "Joining CNCF" blog, Sep 19 2023](https://www.kcl-lang.io/blog/2023-09-19-kcl-joining-cncf-sandbox);
  [GitHub kcl-lang/kcl](https://github.com/kcl-lang/kcl)).
- **CNCF Sandbox: accepted September 20, 2023** (TOC vote, via the App Delivery TAG).
  ([KCL blog, Sep 19 2023](https://www.kcl-lang.io/blog/2023-09-19-kcl-joining-cncf-sandbox);
  [cncf/sandbox issue #48](https://github.com/cncf/sandbox/issues/48)).
  - **Could not verify:** the claim (from a secondary search summary) that
    *KusionStack* separately joined the CNCF Sandbox in Q4 2024 — treat as
    unconfirmed; the *KCL* sandbox acceptance (Sep 2023) is solid.

### Nickel (Tweag)
- **Designed and maintained by Tweag** (now part of Modus Create). First public
  version (0.1) ≈ **May 2022**; **Nickel 1.0 released May 17, 2023**. A
  gradually-typed configuration language with contracts.
  ([Tweag blog, "Announcing Nickel 1.0," May 17 2023](https://www.tweag.io/blog/2023-05-17-nickel-1.0-release/);
  [GitHub nickel-lang/nickel](https://github.com/nickel-lang/nickel)).
  - **Could not verify:** the precise 0.1 release date (the 1.0 post says
    "a bit more than one year" earlier, implying ~early/mid-2022, not exact).

### Dhall
- **Created by Gabriel Gonzalez**, first introduced **December 2016** as a
  non-Turing-complete, typed configuration language ("JSON + functions + types +
  imports"). Earlier than the 2021–2026 window but still active as an
  open-source project; no commercial entity.
  ([Haskell for all, "Dhall — A non-Turing-complete configuration language," Dec 2016](https://haskellforall.com/2016/12/dhall-non-turing-complete-configuration);
  [dhall-lang.org](https://dhall-lang.org/)).

### Jsonnet (cross-ref)
- See [`jsonnet-tanka.md`](./jsonnet-tanka.md). Briefly: a JSON-templating
  language **originally created by Dave Cunningham at Google** and announced
  publicly **April 2015** — the conceptual predecessor much of this cluster
  reacts to. ([Google Open Source Blog, Apr 2015](https://opensource.googleblog.com/2015/04/jsonnet-more-elegant-language-for.html)).

---

## 2. IaC orchestration / management platforms ("TACOS")

"TACOS" = **T**erraform **A**utomation **and** **C**ollaboration **S**oftware:
managed CI/CD, state, policy, drift detection, and collaboration *around*
Terraform/OpenTofu (and increasingly Pulumi/CDK). Most arose after Terraform
Cloud as alternatives, and several positioned hard against HashiCorp's 2023 BSL
relicense (see [`terraform.md`](./terraform.md)).

### Spacelift
- **Founded 2019/2020** (sources disagree on the exact year); CEO/co-founder
  **Paweł Hytry**. ([Spacelift Series C PR, Jul 10 2025](https://www.prnewswire.com/news-releases/spacelift-raises-51m-series-c-to-redefine-enterprise-infrastructure-automation-302501578.html)).
- **Funding:** Series B **$15M** (Insight Partners, with Blossom Capital, Inovo,
  Hoxton participating) ([Spacelift blog, "Spacelift raises $15M"](https://spacelift.io/blog/spacelift-raises-15m)); then a **$51M Series C
  led by Five Elms Capital** announced **July 10, 2025**, with Endeavor Catalyst
  and Inovo participating — explicitly framed around "AI-powered automation."
  ([Spacelift Series C PR, Jul 10 2025](https://www.prnewswire.com/news-releases/spacelift-raises-51m-series-c-to-redefine-enterprise-infrastructure-automation-302501578.html);
  [SiliconANGLE, Jul 10 2025](https://siliconangle.com/2025/07/10/data-center-infrastructure-automation-startup-spacelift-gets-ready-takeoff-raising-51m/)).
  - **Could not verify:** total-raised figure (a secondary aggregator says "$74M
    total"; not confirmed against a primary source) and the exact founding year.

### env0
- **Founded 2018** by **Ohad Maislish (CEO) and Omry Hay (CTO)**; Tel Aviv-based.
  IaC governance/automation for Terraform, Terragrunt, OpenTofu.
  ([FinSMEs, Jun 2021](https://www.finsmes.com/2021/06/env0-raises-17m-in-series-a-funding.html)).
- **Funding:** **$17M Series A**, announced **June 2021** (with a prior ~$6.8M
  seed); the round was later extended to ~$35.1M total.
  ([env0 Series A PR, Jun 2021](https://www.prnewswire.com/news-releases/env0-raises-17-million-in-series-a-funding-to-advance-infrastructure-as-code-automation-for-devops-301319122.html);
  [FinSMEs, Aug 2023, on the $35M total](https://www.finsmes.com/2023/08/env0-raises-35m-in-series-a-funding-2.html)).
  - **Could not verify:** the precise structure/dates of the Series A extension to
    ~$35M (only secondary aggregators seen).

### Scalr
- **Founded 2011** (Sebastian Stadil; sources also cite an earlier 2007 origin)
  — older than this window; **repositioned** as a "drop-in Terraform Cloud
  alternative" and is a **co-founder of OpenTofu** (see [`terraform.md`](./terraform.md)).
  ([Scalr — Wikipedia](https://en.wikipedia.org/wiki/Scalr); [scalr.com/about](https://scalr.com/about)).
- **Funding:** a **$7.35M Series A** (OpenView Venture Partners) is the only
  institutional round consistently reported, dated to ~Jan 2016. Now described as
  profitable/venture-backed.
  ([Scalr — Crunchbase](https://www.crunchbase.com/organization/scalr)).
  - **Could not verify:** founding year (2007 vs 2011 conflict) and current
    revenue claims (only a getlatka secondary figure seen).

### Terramate (+ Terramate Cloud)
- **Founded 2023**, Berlin, by **Sören Martius and Marius Tolzmann**. Open-source
  Terramate CLI (IaC orchestration / codegen for Terraform & OpenTofu) plus
  Terramate Cloud (management/observability control plane).
  ([Terramate — Crunchbase](https://www.crunchbase.com/organization/terramate);
  [GitHub terramate-io/terramate](https://github.com/terramate-io/terramate)).
- **Funding:** a single **pre-seed round (≈Jun 2023, Fly Ventures)** is reported
  by aggregators; no amount confirmed by a primary source.
  ([Terramate — Crunchbase](https://www.crunchbase.com/organization/terramate)).
- **AI angle (2026):** "Terramate Catalyst" (self-service IaC) and a Terramate MCP
  server pitch AI agents provisioning/troubleshooting infra.
  ([Terramate blog, "Technical Introduction to Terramate Catalyst," Jan 2026](https://terramate.io/rethinking-iac/technical-introduction-to-terramate-catalyst/)).
  - **Could not verify:** the pre-seed amount; Catalyst maturity (described as
    beta).

### Digger → "OpenTaco" (rebrand, Nov 2025)
- Open-source IaC orchestration that runs Terraform/OpenTofu in your *existing*
  CI. Co-founder **Igor Zalutski**; San Francisco-based; appeared via "Show HN" in
  2023. ([Show HN, 2023](https://news.ycombinator.com/item?id=36653399);
  [GitHub diggerhq/digger](https://github.com/diggerhq/digger)).
- **Funding:** **$3.6M seed**, reported **June 2025**.
  ([FinSMEs, Jun 2025](https://www.finsmes.com/2025/06/digger-raises-3-6m-in-seed-funding.html)).
- **Status change:** **as of November 7, 2025 the Digger project was rebranded to
  "OpenTaco,"** launched as a proposed "open standard for Terraform automation"
  (the *company* remains Digger).
  ([OpenTaco, "Digger rebranded to OpenTaco"](https://web.archive.org/web/2id_/https://opentaco.dev/digger-rebranded-to-opentaco);
  [HN "Project OpenTaco," Sep 2025](https://news.ycombinator.com/item?id=45361874)).
  - **Could not verify:** Digger's exact founding year; the seed round's lead
    investor (FinSMEs is secondary, no lead named).

### Terrateam
- **Founded 2021** by **Malcolm Matalka and Josh Pollara**; Amsterdam-based.
  Open-source (MPL-2.0 engine) GitOps IaC orchestration via GitHub PRs for
  Terraform/OpenTofu/CDKTF/Terragrunt/Pulumi. Publicly pledged to the OpenTF
  manifesto (the OpenTofu precursor).
  ([Terrateam "About"](https://terrateam.io/about);
  [Terrateam, "Pledging to the OpenTF manifesto"](https://terrateam.io/blog/opentf-pledge);
  [GitHub terrateamio/terrateam](https://github.com/terrateamio/terrateam)).
  - **Could not verify:** any disclosed funding amount/round (Crunchbase lists it
    but with no confirmed figures); the exact month the engine was open-sourced
    ("December," year unstated in the source seen).

### Massdriver
- **Founded 2021** (YC W22) by **Cory O'Daniel, David Williams, and Christopher Hill**;
  Pasadena, CA. A platform-engineering/IaC self-service product over
  Terraform/OpenTofu/Helm.
  ([Massdriver — YC](https://www.ycombinator.com/companies/massdriver);
  [Massdriver seed blog, Aug 21 2023](https://www.massdriver.cloud/blogs/announcing-our-8m-series-seed)).
- **Funding:** **$8M Series Seed**, announced **August 21, 2023**, **led by
  Builders VC**, with 1984 VC, Y Combinator, Preston-Werner Ventures, Uncorrelated
  Ventures, Page One Ventures, Soma Capital, Hack VC participating.
  ([Massdriver seed blog, Aug 21 2023](https://www.massdriver.cloud/blogs/announcing-our-8m-series-seed)).
  - **Could not verify:** the "$12.5M total over 3 rounds" figure (Tracxn/secondary
    only).

### Atmos (Cloud Posse)
- **Open-source Terraform/OpenTofu orchestration framework** (stacks +
  components + hierarchical YAML inheritance) by **Cloud Posse**, a DevOps
  consultancy. A tool/framework, **not a VC-funded product**; "everything is open
  source and free."
  ([GitHub cloudposse/atmos](https://github.com/cloudposse/atmos);
  [Cloud Posse glossary — Atmos](https://cloudposse.com/glossary/atmos)).
  - **Could not verify:** Atmos's first-release date / Cloud Posse founding year
    (not located in a primary source within scope).

---

## 3. Control-plane / next-gen IaC (beyond "write HCL")

Projects rethinking the *model* of infra (control planes, app/workload specs,
"infrastructure from code"), not just automating Terraform.

### System Initiative (cross-ref) — AI-native relaunch
- Full history in [`winglang-system-initiative.md`](./winglang-system-initiative.md)
  (founded 2019 by Adam Jacob, ex-Chef; "digital twin"/reactive graph model).
- **2025 pivot to "AI native":** on **August 27, 2025**, System Initiative
  announced what it **calls** "the world's first AI Native infrastructure
  automation platform," pairing "digital twins" of live infra with AI agents that
  propose/execute changes from natural-language prompts. (Marketing claim;
  attributed.) ([BusinessWire, Aug 27 2025](https://www.businesswire.com/news/home/20250827291941/en/System-Initiative-Unveils-the-Worlds-First-AI-Native-Infrastructure-Automation-Platform);
  [InfoQ, Sep 2025](https://www.infoq.com/news/2025/09/system-initiative-ai-platform/)).

### Winglang / Wing (cross-ref) — SHUT DOWN
- Full history in [`winglang-system-initiative.md`](./winglang-system-initiative.md).
- **Status: Wing Cloud shut down, announced April 9, 2025**, less than two years
  after launch; the Winglang language was left open-source. Founder Elad
  Ben-Israel (AWS CDK creator) said they couldn't find a sustainable business
  fit. ([Wing blog, "Shutdown," Apr 9 2025](https://www.winglang.io/blog/2025/04/09/shutdown);
  [Calcalist, Apr 2025](https://www.calcalistech.com/ctechnews/article/bj90wnmrjl)).

### Crossplane / Upbound (cross-ref)
- Full history in [`crossplane.md`](./crossplane.md). Kubernetes-native control
  plane; CNCF **graduated**. Listed here only for category completeness.

### Radius (Microsoft → CNCF)
- **Launched October 18, 2023** by the **Microsoft Azure Incubations team**
  (the group behind Dapr/KEDA) as an open-source, app-centric cloud-native
  application platform; supports Kubernetes, Terraform, and Bicep.
  ([Azure blog, Oct 18 2023](https://azure.microsoft.com/en-us/blog/the-microsoft-azure-incubations-team-launches-radius-a-new-open-application-platform-for-the-cloud/);
  [TechCrunch, Oct 18 2023](https://techcrunch.com/2023/10/18/microsoft-launches-radius-an-open-source-application-platform-for-the-cloud/)).
- **CNCF Sandbox: accepted April 16, 2024.**
  ([Radius blog, Apr 16 2024](https://blog.radapp.io/posts/2024/04/16/radius-accepted-as-cloud-native-compute-foundation-cncf-sandbox-project/);
  [InfoQ, Apr 2024](https://www.infoq.com/news/2024/04/radius-cncf-sandbox-project/)).

### Score (Humanitec → CNCF)
- A **platform-agnostic, container-based workload specification** (a single file
  that maps to Docker Compose/Kubernetes/etc.), **started by a group around Susa
  Tünker at Humanitec**. ([Score docs](https://docs.score.dev/docs/);
  [GitHub score-spec](https://github.com/score-spec)).
- **CNCF Sandbox: accepted July 8, 2024.**
  ([CNCF blog, Aug 8 2024](https://www.cncf.io/blog/2024/08/08/score-accepted-as-a-cncf-sandbox-project/);
  [Humanitec blog](https://humanitec.com/blog/score-accepted-as-a-cncf-sandbox-project)).

### Acorn (Acorn Labs / Darren Shepherd) — PIVOTED to AI (now Obot AI)
- **Founded 2022** by ex-**Rancher Labs** founders **Sheng Liang (CEO), Darren
  Shepherd (Chief Architect), Shannon Williams, Will Chan**. The original product,
  Acorn, simplified app deployment on Kubernetes (an app-packaging/IaC-adjacent
  tool). ([The New Stack, "Why Rancher's Founders Pivoted From Kubernetes to
  Agentic AI"](https://thenewstack.io/why-ranchers-founders-pivoted-from-kubernetes-to-agentic-ai/)).
- **Status: pivoted to AI and rebranded to "Obot AI."** Acorn Labs now operates
  as Obot AI (MCP-server gateway/control plane for AI agents); the company's old
  acorn.io domain **redirects to obot.ai**.
  ([Obot AI, "Acorn Labs is Now Obot AI"](https://www.acorn.io/resources/author/darren-shepherd/);
  acorn.io/about-us 301-redirects to [obot.ai/about-us](https://obot.ai/about-us/), verified via fetch).
  - **Could not verify:** the exact date the original Acorn IaC product was
    discontinued, and whether it was formally "shut down" vs. simply deprioritized
    after the rebrand. The pivot/rebrand is confirmed; the IaC-product-EOL date is
    not.

### Encore
- **Founded ≈2020–2021**, Stockholm, by **André Eriksson (CEO) and Marcus
  Kohlberg** (ex-Spotify/Google background). Open-source Go (and TypeScript)
  backend framework with "infrastructure from code" — infra declared in app code.
  ([SiliconANGLE, Apr 19 2022](https://siliconangle.com/2022/04/19/encore-raises-3m-automate-backend-development-distributed-cloud-systems/);
  [Encore.go](https://encore.dev/go)).
- **Funding:** **$3M seed**, announced **April 19, 2022**, led by **Crane Venture
  Partners** (with Acequia Capital, Essence VC, Third Kind VC, and angels incl.
  Kleiner Perkins' Bucky Moore).
  ([SiliconANGLE, Apr 19 2022](https://siliconangle.com/2022/04/19/encore-raises-3m-automate-backend-development-distributed-cloud-systems/);
  [Tech.eu, Apr 19 2022](https://tech.eu/2022/04/19/enabling-developers-to-build-new-cloud-backends-in-minutes-lands-encore-with-3-million/)).
  - **Could not verify:** exact founding year (sources say "2020" and "early 2021").

### Nitric
- **Founded ≈2020**, Sydney, Australia, by **Jye Cusch and Tim Holm**. Open-source
  multi-language "infrastructure from code" framework (AWS/GCP/Azure); v1.0 of the
  framework released ~early 2024.
  ([Nitric v1.0 PR, ~2024](https://www.prweb.com/releases/nitric-releases-first-major-version-of-framework-for-highly-productive-portable-customizable-cloud-development-302063898.html);
  [GitHub nitrictech/nitric](https://github.com/nitrictech/nitric);
  [The New Stack — Nitric](https://thenewstack.io/nitric-a-cloud-portability-framework-for-code/)).
  - **Could not verify:** Nitric's funding (a Tracxn secondary lists "$4.88M /
    Series A, Jul 2025" but no primary announcement was located) and exact
    founding year.

---

## 4. Internal Developer Platforms / platform engineering (IDPs)

The "platform engineering" wave: portals/orchestrators that give developers
self-service while platform teams keep governance. Adjacent to IaC (they sit on
top of it) rather than IaC tools themselves.

### Backstage (Spotify → CNCF)
- **Open-sourced by Spotify March 2020** (used internally since ~2016); donated to
  the **CNCF Sandbox September 2020**, later promoted to **Incubating**. The
  de-facto open-source IDP framework.
  ([Spotify Engineering, Sep 2020](https://engineering.atspotify.com/2020/09/cloud-native-computing-foundation-accepts-backstage-as-a-sandbox-project/);
  [GitHub backstage/backstage](https://github.com/backstage/backstage)).
  - **Could not verify:** the current exact CNCF maturity level — one secondary
    source says "Incubation," and a March 2026 CNCF announcement calls it a
    "global open source standard"; the precise graduated/incubating status as of
    May 2026 was not pinned to a single authoritative CNCF page here.
    ([CNCF, Mar 25 2026](https://www.cncf.io/announcements/2026/03/25/cncf-backstage-documentary-highlights-project-evolution-from-development-to-global-open-source-standard-for-platform-engineering/)).

### Humanitec
- **Founded 2017**, Berlin. Commercial "Platform Orchestrator" for building IDPs;
  also originated the Score spec (above). A frequently-cited driver of the
  "platform engineering" narrative.
  ([Humanitec](https://humanitec.com/); [Humanitec — Crunchbase](https://www.crunchbase.com/organization/humanitec)).
  - **Could not verify:** Humanitec's specific funding rounds/amounts. Searches did
    not surface a primary funding announcement; do not assert any figure.

### Port
- **Founded 2021/2022**, Tel Aviv, by **Zohar Einy (CEO) and Yonatan Boguslavski
  (CTO)**. No-code internal developer portal.
  ([Port Series C, Calcalist, Dec 11 2025](https://www.calcalistech.com/ctechnews/article/r1oppgdzzg)).
- **Funding (well-documented):** seed (~$7M, 2022) → **Series A $18M** (Sep 2023)
  → **Series B $35M** (Oct 2024) → **Series C $100M at an ~$800M valuation, led
  by General Atlantic, announced December 11, 2025** ($158M total), explicitly
  reframed around "agentic engineering"/AI agents in the SDLC.
  ([Port Series A, $18M, PR, 2023](https://www.prnewswire.com/il/news-releases/port-raises-18m-to-grow-its-popular-open-internal-developer-portal-301926172.html);
  [Port Series B, $35M, PR, 2024](https://www.prnewswire.com/il/news-releases/port-raises-35m-for-its-end-to-end-internal-developer-portal-302276418.html);
  [Port Series C, Calcalist, Dec 11 2025](https://www.calcalistech.com/ctechnews/article/r1oppgdzzg)).
  - **Note:** founding given as "2021" (Nov 2021 per one source) and "2022" (per
    the Series C article) — minor conflict; both cited.

### Cortex
- **Founded 2019** by **Anish Dhar, Ganesh Datta, Nikhil Unni**; YC; public launch
  ~May 2021. Internal developer portal / service catalog with scorecards.
  ([Cortex Series A, TechCrunch, Nov 18 2021](https://techcrunch.com/2021/11/18/cortex-raises-15m-series-a-to-help-development-teams-wrangle-their-microservices/)).
- **Funding:** $2.5M seed (Sequoia) → **$15M Series A** (Nov 18 2021, Tiger Global
  + Sequoia) → **$35M Series B** (May 31 2023, **led by IVP**, with Craft, Sequoia,
  Tiger, YC) — ~$53M total.
  ([Cortex Series A, TechCrunch, Nov 18 2021](https://techcrunch.com/2021/11/18/cortex-raises-15m-series-a-to-help-development-teams-wrangle-their-microservices/);
  [Cortex Series B, TechCrunch, May 31 2023](https://techcrunch.com/2023/05/31/cortex-raises-35m-series-b-for-its-internal-developer-portal/)).

### OpsLevel
- **Founded 2018**; Canada-based. Internal developer portal / service maturity
  (scorecards). ([OpsLevel — Crunchbase](https://www.crunchbase.com/organization/opslevel)).
- **Funding:** **$5M seed** (announced Nov 18 2020, led by Vertex Ventures) →
  **$15M Series A** (announced March 1 2022) — ~$20M total reported.
  ([OpsLevel seed, TechCrunch, Nov 18 2020](https://techcrunch.com/2020/11/18/opslevel-raises-5m-to-fix-devops/);
  [OpsLevel Series A, TechCrunch, Mar 1 2022](https://techcrunch.com/2022/03/01/opslevel-raises-15m-to-help-developers-manage-their-microservices/)).

### Kratix (Syntasso)
- **Open-source platform-engineering framework** ("Promises") by **Syntasso**;
  **first released 2021**, Apache-2.0. Commercial Syntasso Kratix Enterprise (SKE)
  exists. ([GitHub syntasso/kratix](https://github.com/syntasso/kratix);
  [Kratix.io](https://www.kratix.io/); [Syntasso.io](https://www.syntasso.io/)).
  - **Could not verify:** Syntasso's founding year and any funding (no primary
    source located).

---

## 5. The AI-native infrastructure wave (2024–2026)

A documented *trend*: across 2024–2026, established IaC/platform vendors added
(or pivoted to) AI agents that read infra, propose changes, and act. The pattern
is real and broad; the **"world's first" / "agentic" framing is marketing** and
is attributed below, not endorsed. Several entries above already show this
(Spacelift "AI-powered," Port "agentic engineering," Terramate Catalyst/MCP,
System Initiative's "AI-native" relaunch).

### Pulumi — Copilot, Neo, "agentic infrastructure" (cross-ref [`pulumi.md`](./pulumi.md))
- **Pulumi Neo**, described by Pulumi as "the industry's first AI agent built…to
  execute, govern, and optimize complex cloud automation," launched in **public
  preview September 16, 2025**; later extended to CLI/GitHub/Slack surfaces.
  Pulumi also ships an MCP server for Copilot/Claude Code/Cursor.
  ([Pulumi product — Neo](https://www.pulumi.com/product/neo/);
  [SiliconANGLE, Sep 16 2025](https://siliconangle.com/2025/09/16/pulumi-debuts-first-ai-agents-take-cloud-platform-engineering/);
  [InfoQ, Sep 2025](https://www.infoq.com/news/2025/09/pulumi-neo/)).
- **May 2026:** Pulumi announced "agent-native infrastructure" and
  "superintelligence partnerships," continuing the push.
  ([Pulumi/PRNewswire, May 19 2026](https://www.prnewswire.com/news-releases/pulumi-closes-the-ai-deployment-gap-with-agent-native-infrastructure-and-superintelligence-partnerships-302776114.html)).

### System Initiative — "AI Native" (cross-ref, see §3)
- Aug 27 2025 relaunch as "AI-native infrastructure automation."
  ([BusinessWire, Aug 27 2025](https://www.businesswire.com/news/home/20250827291941/en/System-Initiative-Unveils-the-Worlds-First-AI-Native-Infrastructure-Automation-Platform)).

### Dagger — AI agents (cross-ref [`dagger.md`](./dagger.md))
- Dagger (Solomon Hykes, Docker co-founder) repositioned its container engine
  toward AI agents/agentic workflows in 2024–2025. See the dedicated doc for the
  sourced timeline.

### Terramate — AI / MCP (see §2)
- "Catalyst" + MCP server for AI-agent-driven self-service IaC (Jan 2026).
  ([Terramate, Jan 2026](https://terramate.io/rethinking-iac/technical-introduction-to-terramate-catalyst/)).

### Earthly → "Earthly Lunar" — pivot to the "AI era"
- Earthly (build tool, **founded 2020**) is **not primarily IaC**, but is a
  notable example of the *funding-driven AI pivot* shaping this whole space.
  On **April 16, 2025** Earthly announced it was **winding down its commercial
  build products** (Earthly Satellites/Cloud, by **July 16, 2025**) and **ending
  active maintenance of the Earthly open-source project**, pivoting to **Earthly
  Lunar** — "guardrails for the AI era" that enforce engineering standards across
  repos, PRs, and AI coding sessions. Earthly's CEO explicitly cited that
  "infrastructure investors have pivoted toward AI."
  ([Earthly blog, "A message about Earthly," Apr 16 2025](https://earthly.dev/blog/shutting-down-earthfiles-cloud/);
  [Earthly Lunar](https://earthly.dev/);
  see also [`earthly.md`](./earthly.md)).

### Trend caveat
- The breadth of "AI for IaC" announcements (and the recurring "world's first"
  claim from multiple vendors in the *same* months) is itself evidence of a hype
  cycle. Treat individual capability claims as **vendor marketing pending
  independent verification**. Funding is flowing toward this framing — e.g.
  Spacelift's and Port's 2025 rounds both foreground AI — which is a documented
  signal, not proof of product maturity.

---

## Could not verify

Collected list of claims I could **not** confirm against a primary/strong source
(do not treat as established fact):

1. **CUE Labs** — exact founding date/year of the *company* (only the Oct 30 2025
   stealth-exit date is sourced).
2. **KCL/KusionStack** — the claim that *KusionStack* (separately from KCL) joined
   the CNCF Sandbox in Q4 2024.
3. **Nickel** — exact date of the 0.1 release.
4. **Spacelift** — exact founding year (2019 vs 2020); "$74M total raised" figure.
5. **env0** — precise structure/dates of the Series-A extension to ~$35M.
6. **Scalr** — founding year (2007 vs 2011); current revenue claims.
7. **Terramate** — pre-seed amount; Catalyst (AI) maturity beyond "beta."
8. **Digger/OpenTaco** — Digger's founding year; the $3.6M seed's lead investor.
9. **Terrateam** — any disclosed funding amount; exact month/year the engine was
   open-sourced.
10. **Massdriver** — the "$12.5M total over 3 rounds" figure (only the $8M seed is
    primary-sourced).
11. **Atmos / Cloud Posse** — Atmos first-release date and Cloud Posse founding year.
12. **Acorn Labs** — exact date the original Acorn IaC product was discontinued and
    whether formally shut down vs. deprioritized (the Obot AI rebrand/pivot *is*
    confirmed).
13. **Encore** — exact founding year (2020 vs early-2021).
14. **Nitric** — funding (Tracxn "$4.88M/Series A Jul 2025" unconfirmed by a
    primary source); exact founding year.
15. **Humanitec** — any specific funding round/amount (no primary announcement found).
16. **Port** — founding year (Nov 2021 vs 2022 conflict across sources).
17. **Kratix / Syntasso** — Syntasso's founding year and any funding.
18. **Backstage** — exact current CNCF maturity level (Incubating vs other) as of
    May 2026.

---

*Last updated: 2026-05-31. Funding/status figures are point-in-time and will
drift; re-verify before citing externally.*
