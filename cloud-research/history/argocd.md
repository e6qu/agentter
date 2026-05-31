# Argo CD and the Argo Project: A Sourced Deep-Dive History

A chronological, fully-cited history of **Argo CD** and the broader **Argo
project** — from its origins as a container-native workflow engine at the
startup **Applatix**, through the **Intuit** acquisition where Argo CD was
born, to its **CNCF graduation** and the commercial ecosystem (**Akuity**,
**Codefresh/Octopus Deploy**, **Red Hat OpenShift GitOps**) built around it.

Every non-trivial claim links to a working source. Items that could not be
confirmed from a reputable source are marked **"Could not verify."** Opinions
are attributed to their source.

> **Scope note / cross-reference.** This document goes deep on Argo
> specifically. For the broader **GitOps movement**, the **origin of the term
> "GitOps"** (Alexis Richardson / Weaveworks), the **Flux** project, the
> **OpenGitOps** principles, and the **side-by-side Argo-vs-Flux comparison**,
> see the companion doc [`argocd-flux.md`](./argocd-flux.md). To avoid
> duplication, those topics are referenced here rather than repeated.

---

## Timeline

### 2015
- **2015** — **Applatix, Inc. is founded** in Sunnyvale, California, by
  ex-leaders from Data Domain, Nicira, Beebop, Tintri, and Apigee:
  **Pratik Wadher (CEO)**, **Saradhi Sreegiriraju (CPO)**, and **Ed Lee
  (CTO)**. The company raised **$15.7M** (2015) from **Lightspeed Venture
  Partners**.
  Source: [StorageNewsletter, "Intuit Absorbed Applatix Silently" (Jan 31,
  2018)](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/)
  ("established in 2015 ... Pratik Wadher, CEO, Saradhi Sreegiriraju, CPO and
  Ed Lee, CTO"; "$15.7 million in 2015 from Lightspeed Ventures Partner").
  - **Correction to a common assumption:** Hong Wang was **not** the Applatix
    CEO. The Applatix CEO was **Pratik Wadher**. Hong Wang, Jesse Suen, and
    Alexander Matyushentsev were **founding engineers** at Applatix (and later
    co-founded Akuity — see below).
    Sources: [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/);
    [Akuity company page](https://akuity.io/company)
    (describes the three as Applatix founding engineers, with Hong's later
    role as "Argo team manager at Intuit").
  - **Note on founding year:** Akuity co-founder Hong Wang's retrospective
    blog describes the team meeting at Applatix in **2016** ("the year of
    containers, microservices"); third-party company registries (Tracxn,
    StorageNewsletter) give the founding/funding year as **2015**. The
    discrepancy likely reflects funding/incorporation (2015) vs. when the
    Argo-relevant team coalesced (2016).
    Sources: [Akuity, "Why We Created the Argo Project" (Hong Wang, Dec 5,
    2023)](https://akuity.io/blog/why-we-created-the-argo-project);
    [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/).

### 2017 — Argo Workflows: the first Argo project
- **August 21, 2017** — The **`argoproj/argo-workflows` GitHub repository is
  created** (initially `argoproj/argo`), described as "Workflow Engine for
  Kubernetes."
  Source: [GitHub API for argoproj/argo-workflows](https://api.github.com/repos/argoproj/argo-workflows)
  (`"created_at":"2017-08-21T18:50:44Z"`); repo:
  [argoproj/argo-workflows](https://github.com/argoproj/argo-workflows).
- **August 31, 2017** — Applatix publicly announces Argo in
  **"Introducing Argo — A Container-Native Workflow Engine for Kubernetes,"**
  written by **Pratik Wadher**. This is the **first Argo project** (now called
  **Argo Workflows**) — a container-native engine for specifying, scheduling,
  and coordinating workflows on Kubernetes.
  Source: [Argo Project blog (Medium), "Introducing Argo" (Pratik
  Wadher)](https://blog.argoproj.io/introducing-argo-a-container-native-workflow-engine-for-kubernetes-55c0b4b76fac);
  date corroborated via search of the same post.
  - **Could not verify (live fetch):** the Medium post's TLS certificate
    failed verification on direct fetch in this research; the **Aug 31, 2017**
    date comes from search indexing of that same post and is consistent with
    the **Aug 21, 2017** repo-creation date.
- **2017** — The team rewrites the workflow engine to use **Kubernetes CRDs**,
  introducing "container-native jobs" as **Argo Workflows 2.0**.
  Source: [Akuity, "Why We Created the Argo Project"](https://akuity.io/blog/why-we-created-the-argo-project)
  ("decided to use Kubernetes CRDs to introduce a new type of container-native
  jobs ... Argo Workflows 2.0").
- **KubeCon (late 2017)** — After meeting Intuit executives around KubeCon,
  Applatix moved toward acquisition by Intuit.
  Source: [Akuity, "Why We Created the Argo Project"](https://akuity.io/blog/why-we-created-the-argo-project).
  - For more KubeCon-Austin-2017 context, see [`argocd-flux.md`](./argocd-flux.md).

### 2018 — Intuit acquisition; Argo CD is born
- **January 29, 2018** — **Intuit acquires Applatix.** Intuit's announcement
  describes Applatix as "a team at the forefront of building scalable
  production systems with containers and Kubernetes" and Argo as "a
  container-native workflow engine for Kubernetes that's gaining traction in
  the community," committing to continued open-source support.
  Source: [Intuit blog, "Intuit Acquires Applatix" / "Welcome Applatix to the
  Intuit Team" (Jan 29, 2018)](https://www.intuit.com/blog/technology/welcome-applatix-to-the-intuit-team/);
  acquisition date also in [Intuit's FY2018 10-K
  filing](https://www.sec.gov/Archives/edgar/data/0000896878/000089687818000171/fy18q4-ex2101.htm).
  - **Deal context:** Intuit acquired three companies in the quarter (Applatix,
    TSheets, Exactor) for ~$412M combined; the Applatix-specific price was not
    broken out publicly. **Could not verify** a standalone Applatix purchase
    price (the deal was described as "silent"/non-public).
    Source: [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/).
- **January 2018** — **Argo CD is open-sourced by Intuit.** Built **at Intuit**
  (not at Applatix), Argo CD is a Kubernetes-native declarative GitOps
  continuous-delivery tool. **Alexander Matyushentsev led the development of
  Argo CD**; **Jesse Suen** was technical lead/architect for the Argo team.
  Sources: [Red Hat / Intuit press release (Aug 17,
  2020)](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale)
  ("Argo CD ... was open sourced by Intuit in January 2018");
  [Akuity company page](https://akuity.io/company)
  (Alexander "led the development of Argo CD"; Jesse "technical lead for the
  Argo team at Intuit, leading the design and architecture for Workflows, CD,
  and Rollouts"); repo: [argoproj/argo-cd](https://github.com/argoproj/argo-cd).
  - **Why Argo CD was built (in the creators' words):** to "deploy and manage
    all Kubernetes objects that make up an 'application' as a single, atomic
    unit," because at Intuit they had "so many Kubernetes clusters and so many
    namespaces" and "no tools to do that."
    Source: [Akuity, "Why We Created the Argo Project"](https://akuity.io/blog/why-we-created-the-argo-project)
    (attributed to Hong Wang).

### 2020 — CNCF incubation; Red Hat joins
- **April 7, 2020** — The **CNCF Technical Oversight Committee accepts Argo into
  the CNCF Incubator.** At incubation, Argo comprised **four subprojects**:
  **Argo Workflows** (from Applatix), **Argo CD**, **Argo Rollouts**, and
  **Argo Events** (contributed by **BlackRock**).
  Source: [CNCF blog, "TOC welcomes Argo into the CNCF incubator" (Apr 7,
  2020)](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/);
  [Intuit blog, "CNCF Accepts Argo as an Incubator Project"](https://www.intuit.com/blog/news-social/cloud-native-computing-foundation-accepts-argo-as-an-incubator-project/).
- **August 17, 2020** — **Red Hat and Intuit announce they are joining forces
  on the Argo project** (announced at KubeCon Europe 2020). Red Hat joined the
  Argo bootstrap steering committee; OpenShift GitOps would be **built around
  Argo CD** as its core upstream project. The press release names Argo CD
  production adopters including **Electronic Arts, Major League Baseball,
  Tesla, and Ticketmaster.**
  Sources: [Red Hat press release (Aug 17,
  2020)](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale);
  [Red Hat Developer, "OpenShift joins the Argo CD community" (Aug 17,
  2020)](https://developers.redhat.com/blog/2020/08/17/openshift-joins-the-argo-cd-community-kubecon-europe-2020).

### 2021 — Akuity is founded; ArgoCon
- **2021** — The three Argo creators — **Hong Wang, Jesse Suen, and Alexander
  Matyushentsev** — **leave Intuit to found Akuity**, a company to commercialize
  Argo (especially Argo CD) without making it proprietary.
  Sources: [Akuity company page](https://akuity.io/company);
  [VentureBeat, "Akuity launches to be the Argo enterprise company"](https://venturebeat.com/business/akuity-launches-to-be-the-argo-enterprise-company-for-kubernetes-app-delivery/)
  (the founders "elected to leave Intuit ... to focus all their efforts on
  developing and commercializing Argo under a new, standalone company").
- **~late 2021** — Akuity completes a **$4.5M seed round** (about six months
  before its Series A).
  Source: [Akuity, "Announcing Akuity's $20M Series A Funding" (May 16,
  2022)](https://akuity.io/blog/announcing-series-a-funding)
  ("Seed funding of $4.5M was completed six months prior").

### 2022 — Series A; CNCF graduation
- **May 16, 2022** — **Akuity announces a $20M Series A**, led by **Lead Edge
  Capital** with participation from existing investor **Decibel Partners**,
  bringing total funding to roughly **$24.5M–$25M**.
  Sources: [Akuity, "Announcing Akuity's $20M Series A Funding"](https://akuity.io/blog/announcing-series-a-funding);
  [TechCrunch, "Kubernetes tooling provider Akuity raises $20M" (May 16,
  2022)](https://techcrunch.com/2022/05/16/akuity-raises-20m-to-simplify-kubernetes-container-management/);
  [SiliconANGLE](https://siliconangle.com/2022/05/16/kubernetes-startup-akuity-raises-20m-take-argo-project-next-level/);
  [DevOps.com](https://devops.com/akuity-announces-20-million-series-a-funding-round/).
- **December 6, 2022** — **Argo graduates from the CNCF.** CNCF cited ~**250%**
  growth in organizational adoption since entering the incubator, **350+**
  organizations running Argo in production, and contributions from ~**2,300
  companies and ~8,000 individuals**. Named adopters: **Adobe, BlackRock,
  Capital One, Google, Intuit, PagerDuty, Peloton, Snyk, Swisscom, Tesla, and
  Volvo.**
  Sources: [CNCF announcement (Dec 6,
  2022)](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/);
  [Red Hat blog, "The Argo Project Graduates at the CNCF"](https://www.redhat.com/en/blog/the-argo-project-graduates-at-the-cncf).

### 2024 — Codefresh acquired by Octopus Deploy
- **February 27, 2024** — **Octopus Deploy acquires Codefresh.** Codefresh
  (founded 2014 by **Oleg Verhovsky** and **Raziel Tabib**) is described as
  "an Argo maintainer and leader in Kubernetes CD, GitOps, and CI" — its hosted
  GitOps platform is built on Argo and its team members are Argo maintainers.
  The combined company reported >4,000 customers, 270+ employees, and >$60M
  annual revenue. Deal terms were not disclosed.
  Sources: [Octopus Deploy, "Octopus Deploy acquires Codefresh" (Feb 27,
  2024)](https://octopus.com/news/octopus-acquires-codefresh);
  [PR Newswire](https://www.prnewswire.com/news-releases/octopus-deploy-acquires-codefresh-to-bring-cd-ci-and-gitops-into-one-trusted-platform-302071690.html);
  [Codefresh blog](https://codefresh.io/blog/codefresh-is-joining-octopus-deploy-to-create-the-most-powerful-kubernetes-cd-gitops-ci-and-argo-platform/);
  [Help Net Security](https://www.helpnetsecurity.com/2024/02/27/octopus-deploy-codefresh-acquisition/).
  - **Note:** the task framed this as "Codefresh acquired by Octopus Deploy
    (2024)" — confirmed correct: **Octopus acquired Codefresh** on Feb 27, 2024.

### 2024–2025 — Scale and momentum (Akuity)
- **2024–2025** — Akuity reports business growth: ~**$5.3M** revenue (Dec 2023)
  rising to ~**$9M** (Oct 2024); **100+** enterprise customers in regulated
  sectors; platform processing tens of millions of releases in FY2025.
  Sources: [GetLatka, "How Akuity hit $9M revenue ... in 2024"](https://getlatka.com/companies/akuity);
  [Akuity blog](https://akuity.io/blog/announcing-series-a-funding).
  - **Could not verify:** an additional priced funding round (e.g., a Series B)
    or a post-2022 valuation for Akuity from a primary source. Revenue figures
    above are from GetLatka (a third-party aggregator), not Akuity's own
    disclosures; treat as approximate.

---

## The Argo project suite

The Argo project is an umbrella of **four** complementary, independently usable
Kubernetes-native tools that are commonly combined. (CNCF graduation
description, Dec 6, 2022.)

1. **Argo Workflows** — the **original** Argo project (Applatix, 2017). A
   container-native **workflow engine** for Kubernetes supporting DAG- and
   step-based workflows; used for CI/CD pipelines, data processing, and ML
   workflows. Defined as Kubernetes CRDs.
   Source: [CNCF incubator post](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/);
   [argoproj/argo-workflows](https://github.com/argoproj/argo-workflows).

2. **Argo CD** — **declarative GitOps continuous delivery** for Kubernetes,
   built at Intuit (2018). **Git is the source of truth**; desired state is
   declared in a Git repo and Argo CD continuously reconciles the live cluster
   toward it.
   - **Core architecture concepts:**
     - The **`Application` CRD** — a custom resource that pairs a Git source
       (repo/path/revision) with a destination (cluster/namespace) and a sync
       policy; it is the central unit Argo CD reconciles.
     - **Sync & health** — Argo CD computes whether live state matches Git
       (Synced/OutOfSync) and assesses resource **health**, optionally
       auto-syncing and self-healing drift.
     - **ApplicationSets** — the **`ApplicationSet` controller** templates and
       generates many `Application`s from generators (e.g., per-cluster,
       per-Git-directory, SCM provider), enabling fleet/monorepo management at
       scale.
   Sources: [Red Hat/Intuit press release](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale);
   [Argo CD ApplicationSet docs](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/);
   [argoproj/argo-cd](https://github.com/argoproj/argo-cd).
   For the GitOps-principles framing (declarative / versioned / pulled /
   reconciled) and the Argo-vs-Flux contrast, see
   [`argocd-flux.md`](./argocd-flux.md).

3. **Argo Rollouts** — **progressive delivery** controller providing advanced
   deployment strategies: **canary, blue-green**, and experimentation /
   analysis-driven promotion.
   Source: [CNCF incubator post](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/)
   ("declarative progressive delivery strategies such as canary, blue-green,
   and more general forms of experimentation").

4. **Argo Events** — **event-driven dependency manager** for Kubernetes;
   triggers workflows/resources from various event sources. **Contributed by
   BlackRock.**
   Source: [CNCF incubator post](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/)
   ("Argo Events – Contributed by BlackRock ... Events-based dependency manager
   for Kubernetes").

**How they fit together:** each tool stands alone, but per CNCF "there is great
benefit in using them together" — e.g., Argo CD deploying applications that
include Argo Workflows, Argo Events triggering those workflows, and Argo
Rollouts governing the progressive rollout of the deployed services.
Source: [CNCF graduation announcement](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/).

**Adjacent / newer:** Akuity also backs **Kargo** (multi-stage promotion/
environment orchestration built around Argo CD) as part of its platform.
Source: [GetLatka company profile](https://getlatka.com/companies/akuity)
(Akuity platform "built around the open-source Argo CD and Kargo projects").

---

## Key people & teams

- **Pratik Wadher** — **Co-founder and CEO of Applatix**; authored the original
  "Introducing Argo" announcement (Aug 31, 2017). After the acquisition he
  became a senior product leader at Intuit (VP/SVP, Product Development).
  Sources: [Intuit/Applatix "Introducing Argo" post](https://blog.argoproj.io/introducing-argo-a-container-native-workflow-engine-for-kubernetes-55c0b4b76fac);
  [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/);
  [Intuit EKS keynote PDF, "GitOps @ Enterprise Scale," Pratik Wadher, VP –
  Product Development](https://d1.awsstatic.com/product-marketing/EKS/2.%20Pratik%20Wadher%20-%20Intuit%20Keynote.pdf).

- **Ed Lee** — **Co-founder and CTO of Applatix.** Cited as instrumental in
  Argo's early development and its alignment with the Kubernetes ecosystem.
  Sources: [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/);
  third-party company profiles (Tracxn/Owler) — **the "instrumental in early
  Argo development" characterization could not be tied to a single primary
  source and should be treated as secondary.**

- **Saradhi Sreegiriraju** — **Co-founder and CPO of Applatix.**
  Source: [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/).

- **Hong Wang** — Applatix **founding engineer**; at Intuit, **Argo team
  manager**, building the control plane managing hundreds of Kubernetes
  clusters and thousands of namespaces; **co-founder and CEO of Akuity** (2021).
  M.S. in ECE, Carnegie Mellon; prior distributed-systems work at Springpath,
  Cisco, Yahoo. (He was **not** the Applatix CEO.)
  Sources: [Akuity company page](https://akuity.io/company);
  [Akuity, "Why We Created the Argo Project"](https://akuity.io/blog/why-we-created-the-argo-project).

- **Jesse Suen** — Applatix **founding engineer**; at Intuit, **Principal
  Software Engineer and technical lead for the Argo team**, leading design and
  architecture for **Workflows, CD, and Rollouts**; **co-founder and CTO of
  Akuity.** B.A. Computer Science & Cognitive Science, UC Berkeley.
  Source: [Akuity company page](https://akuity.io/company).

- **Alexander Matyushentsev** — Applatix **founding engineer**; at Intuit,
  **Principal Software Engineer who led the development of Argo CD**;
  **co-founder and Chief Architect of Akuity.**
  Source: [Akuity company page](https://akuity.io/company).

- **Michael Crenshaw** — **Staff Software Engineer and lead Argo CD maintainer
  at Intuit**; among the most active Argo CD contributors (security and
  performance focus), helping run Intuit's large Argo CD fleet (~50 instances /
  ~20k applications) and presenting Argo CD project updates at KubeCon.
  Sources: [KubeCon talk, "Project Updates: Argo CD — Michael Crenshaw,
  Intuit"](https://www.youtube.com/watch?v=bTVavLFH7XQ);
  [Intuit Engineering, "Hacktoberfest 2023 @ Intuit: Maintainer Spotlight"](https://medium.com/intuit-engineering/hacktoberfest-2023-intuit-maintainer-spotlight-7a2ae80ba9d0).
  - **Could not verify** the precise fleet numbers (~50 instances / ~20k apps)
    against a single primary Intuit source; they appear in talk descriptions
    and secondary write-ups.

- **The Intuit Argo team** — Intuit remained the primary corporate steward of
  Argo CD after the founders left for Akuity; Intuit engineers (e.g., Michael
  Crenshaw, Zach Aller, Henrik Blixt) continue as Argo CD maintainers and
  drove the project's "security-first" hardening.
  Sources: [KubeCon NA 2022 session, "How the Argo Project Transitioned From
  Security-Aware to Security-First — Henrik Blixt, Michael Crenshaw,
  Intuit"](https://kccncna2022.sched.com/event/182Gc/how-the-argo-project-transitioned-from-security-aware-to-security-first-henrik-blixt-michael-crenshaw-intuit);
  [CNCF colocated events listings (Crenshaw/Aller, Intuit)](https://colocatedeventsna2024.sched.com/event/1izrr/space-age-gitops-lifting-off-with-argo-promotions-live-demo-michael-crenshaw-zach-aller-intuit).

- **BlackRock** — contributed **Argo Events** and became a major co-maintainer
  of the Argo project.
  Source: [CNCF incubator post](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/).

---

## Company & corporate history

### Applatix (2015–2018) — the origin
- **Founded** 2015 in Sunnyvale, CA, by Pratik Wadher (CEO), Saradhi
  Sreegiriraju (CPO), and Ed Lee (CTO); raised **$15.7M** from Lightspeed.
- Built **Argo** (the container-native workflow engine, now Argo Workflows),
  open-sourced **Aug 2017**, plus a product ("Claudia") to analyze AWS costs.
- **Acquired by Intuit, Jan 29, 2018** (price not disclosed; part of a
  ~$412M three-company quarter).
  Sources: [StorageNewsletter](https://www.storagenewsletter.com/2018/01/31/intuit-absorbed-applatix-silently/);
  [Intuit blog](https://www.intuit.com/blog/technology/welcome-applatix-to-the-intuit-team/);
  [Intuit 10-K](https://www.sec.gov/Archives/edgar/data/0000896878/000089687818000171/fy18q4-ex2101.htm).

### Intuit (2018– ) — where Argo CD was created
- Intuit absorbed the Applatix team to accelerate its cloud-native / GitOps
  transformation and "fully automate CI/CD/CO pipelines."
- **Argo CD was built and open-sourced at Intuit (Jan 2018)**; under Intuit,
  Argo grew to four subprojects and was donated to the **CNCF (incubator Apr
  2020 → graduated Dec 2022)**.
- Intuit remains a central Argo CD maintainer organization even after the
  founders departed for Akuity.
  Sources: [Intuit blog](https://www.intuit.com/blog/technology/welcome-applatix-to-the-intuit-team/);
  [CNCF graduation](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/);
  [Intuit CNCF case study](https://www.cncf.io/case-studies/intuit/).

### Akuity (2021– ) — commercializing Argo CD
- **Founded 2021** by the three Argo co-creators (Hong Wang — CEO, Jesse Suen —
  CTO, Alexander Matyushentsev — Chief Architect) to build an enterprise Argo
  platform while keeping Argo open source.
- **Funding:** ~$4.5M seed (late 2021) + **$20M Series A** (May 16, 2022, led
  by Lead Edge Capital, with Decibel Partners) → ~$24.5–25M total disclosed.
- **Traction:** reported growth to ~$9M revenue (2024) and 100+ enterprise
  customers; platform built around Argo CD (and Kargo).
  Sources: [Akuity company page](https://akuity.io/company);
  [Akuity Series A blog](https://akuity.io/blog/announcing-series-a-funding);
  [TechCrunch](https://techcrunch.com/2022/05/16/akuity-raises-20m-to-simplify-kubernetes-container-management/);
  [VentureBeat](https://venturebeat.com/business/akuity-launches-to-be-the-argo-enterprise-company-for-kubernetes-app-delivery/);
  [GetLatka](https://getlatka.com/companies/akuity).

### Codefresh → Octopus Deploy
- **Codefresh** (founded 2014; Oleg Verhovsky, Raziel Tabib) became a major
  Argo contributor/maintainer with a hosted Argo (GitOps) platform.
- **Acquired by Octopus Deploy, Feb 27, 2024**, forming one of the larger
  privately held DevOps companies (>4,000 customers, >$60M ARR).
  Sources: [Octopus Deploy announcement](https://octopus.com/news/octopus-acquires-codefresh);
  [PR Newswire](https://www.prnewswire.com/news-releases/octopus-deploy-acquires-codefresh-to-bring-cd-ci-and-gitops-into-one-trusted-platform-302071690.html).

### Red Hat (OpenShift GitOps)
- Red Hat joined the Argo project (with Intuit) in **Aug 2020** and ships
  **OpenShift GitOps**, an OpenShift add-on **built around Argo CD** (available
  as a one-click operator), bringing enterprise-supported Argo CD to OpenShift.
  Sources: [Red Hat/Intuit press release](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale);
  [Red Hat, "Announcing OpenShift GitOps"](https://www.redhat.com/en/blog/announcing-openshift-gitops);
  [Red Hat OpenShift GitOps product page](https://www.redhat.com/en/technologies/cloud-computing/openshift/gitops).

### CNCF (steward)
- Argo is a **CNCF Graduated** project (since Dec 6, 2022) with broad
  multi-vendor governance — the reason Argo CD has remained healthy independent
  of any single vendor's commercial fortunes.
  Source: [CNCF Argo project page](https://www.cncf.io/projects/argo/);
  [CNCF graduation announcement](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/).

---

## Current status (as of 2026)

- **Argo CD** is one of the most widely used GitOps/CD tools, a **CNCF
  Graduated** project under multi-vendor governance (Intuit, Akuity, Red Hat,
  Codefresh/Octopus, BlackRock, and many others).
  Source: [CNCF Argo project page](https://www.cncf.io/projects/argo/).
- **Commercial ecosystem:** **Akuity** (Argo CD enterprise platform, founded by
  the creators), **Octopus Deploy/Codefresh** (hosted Argo/GitOps), and **Red
  Hat OpenShift GitOps** (Argo CD on OpenShift).
- **Adopters** (per CNCF graduation, Dec 2022): Adobe, BlackRock, Capital One,
  Google, Intuit, PagerDuty, Peloton, Snyk, Swisscom, Tesla, Volvo; the Red
  Hat/Intuit release additionally names EA, MLB, and Ticketmaster among Argo CD
  users.
  Sources: [CNCF graduation](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/);
  [Red Hat/Intuit press release](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale).

---

## "Could not verify" summary

1. **"Applatix CEO Hong Wang" (the task's premise) is incorrect.** Applatix's
   CEO was **Pratik Wadher**; Hong Wang was a **founding engineer** (later
   Akuity's CEO). Corrected and sourced above.
2. **Applatix founding year (2015 vs. 2016):** registries say 2015 (funding/
   incorporation); Hong Wang's retrospective says the team "met at Applatix" in
   2016. Both stated; discrepancy noted.
3. **Standalone Applatix acquisition price** — not disclosed; only the ~$412M
   combined three-company figure is public.
4. **Live fetch of the original "Introducing Argo" Medium post** failed on a
   TLS certificate error; the **Aug 31, 2017** date comes from search indexing
   and is consistent with the **Aug 21, 2017** repo-creation date (verified via
   GitHub API).
5. **Akuity post-Series-A funding/valuation** — no primary source for a Series B
   or valuation found. The ~$5.3M→$9M revenue figures are from GetLatka (a
   third-party aggregator), not Akuity's own disclosures.
6. **Michael Crenshaw's exact Intuit Argo CD fleet numbers** (~50 instances /
   ~20k apps) — appear in talk descriptions/secondary sources, not pinned to a
   single primary Intuit publication.
7. **Ed Lee's specific early-Argo technical role** — sourced to secondary
   profiles, not a primary Applatix/Argo document.
