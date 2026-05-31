# Crossplane: A Fully-Sourced History

Crossplane is an open source, Kubernetes-native **control plane** framework for
composing and managing cloud infrastructure (and, as of v2, applications) as
Kubernetes resources. It was created and open-sourced by **Upbound**, the company
founded by **Bassam Tabbara**, and is now a **graduated** CNCF project.

This document is a chronological, sourced history. Every non-trivial claim links
to a working source. Items that could not be independently verified are marked
**"Could not verify."**

---

## Dated timeline

### 2018 — Pre-history (Rook, Upbound) and the Crossplane announcement

- **January 29, 2018** — **Rook**, the cloud-native storage operator created by
  Bassam Tabbara and developed at Upbound, is accepted into the CNCF (as a
  Sandbox/inception-level project). Rook used the Kubernetes operator pattern to
  extend Kubernetes to manage storage systems — the conceptual seed of the
  later Crossplane "extend the Kubernetes API to non-container resources" thesis.
  Source: [CNCF blog, "CNCF to host the Rook project," Jan 29 2018](https://www.cncf.io/blog/2018/01/29/cncf-host-rook-project-cloud-native-storage-capabilities/);
  background also in [GeekWire, Jan 2018](https://www.geekwire.com/2018/rook-open-source-project-adding-storage-kubernetes-joins-cloud-native-computing-foundation/).

- **May 2, 2018** — **Upbound announces a $9M Series A led by GV (Google
  Ventures).** Note: this round *predates the Crossplane announcement* and was
  framed around Upbound's multi-cloud platform / Rook; the announcement does not
  mention Crossplane.
  Source: [Upbound/Bassam Tabbara, "Upbound Announces $9 Million Series A Led by GV" (Medium)](https://medium.com/upbound/upbound-announces-9-million-series-a-led-by-gv-1dc52a2f42a4);
  press release: [Business Wire, May 2 2018](https://www.businesswire.com/news/home/20180502005465/en/Upbound-Announces-9-Million-Series-Led-GV);
  contemporaneous coverage: [eWeek, "Rook Cloud Storage Project Backer Upbound Raises $9M"](https://www.eweek.com/cloud/rook-cloud-storage-project-backer-upbound-raises-9m-for-multi-cloud/).

- **December 4, 2018** — **Crossplane is announced and open-sourced by Upbound**
  as "an open source multi-cloud control plane." The announcement was authored
  by **Bassam Tabbara, Illya Chekrygin, and Jared Watts**. It positioned
  Crossplane on the Kubernetes declarative resource model, supporting AWS,
  Azure, and GCP, with the thesis of orchestrating cloud workloads and managed
  services across providers. The first open-source tag was **v0.1.0** (Dec 4,
  2018). The original GitHub org was `crossplaneio`.
  Sources: [Crossplane blog, "Introducing Crossplane"](https://blog.crossplane.io/introducing-crossplane/);
  [Upbound newsroom press release](https://web.archive.org/web/2id_/https://www.upbound.io/newsroom/upbound-makes-multicloud-a-reality-with-crossplane-an-open-source-multicloud-control-plane);
  [GitLab blog, Dec 4 2018 (with GitLab CEO endorsement)](https://about.gitlab.com/blog/2018/12/04/opensource-multi-cloud-crossplane/);
  v0.1.0 date corroborated in [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

### 2019 — Foundations

- **Through 2019** — Roughly seven releases established Crossplane's
  foundational elements and APIs (the early Managed Resources model). The
  "at 5 years" retrospective references a milestone around **December 23, 2019**.
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).
  (Exact per-release details for 2019 not independently re-verified beyond the
  retrospective — see "Could not verify.")

### 2020 — Compositions, CNCF Sandbox, v1.0

- **April 29, 2020** — **Compositions introduced in v0.10.0**, enabling users to
  define custom infrastructure abstractions (the basis for Composite Resource
  Definitions / XRDs and Compositions). This is the foundation of Crossplane's
  "compose cloud infrastructure as Kubernetes resources" model.
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

- **May 2020** — First **Crossplane Community Day** held.
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

- **June 25, 2020** — **Crossplane accepted into the CNCF at the Sandbox level.**
  (Note: CNCF's official project page lists **June 25, 2020**; the Crossplane
  "at 5 years" retrospective phrases it as **July 2, 2020**. Minor discrepancy —
  the CNCF page is the authoritative source.)
  Sources: [CNCF Crossplane project page](https://www.cncf.io/projects/crossplane/)
  (sandbox: June 25, 2020); [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/)
  (states July 2, 2020).

- **December 14, 2020** — **Crossplane v1.0 released** ("the Cloud Native Control
  Plane"), declared stable and production-ready — described as the first major
  milestone in the project's history. A second Community Day followed on
  **December 15, 2020**.
  Sources: [Crossplane blog, "Announcing Crossplane v1.0"](https://blog.crossplane.io/announcing-crossplane-v1-0/);
  [Crossplane blog, "Crossplane turns 2 years old just ahead of v1.0"](https://blog.crossplane.io/crossplane-turns-2-years-old-just-ahead-of-v1-release/);
  dates corroborated in [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

### 2021 — Commercial platform, CNCF Incubation, Series B

- **May 18, 2021** — Upbound launches **Universal Crossplane (UXP)** — its
  enterprise-grade, downstream distribution of Crossplane — alongside general
  availability of **Upbound Cloud** and the **Upbound Registry** (the commercial
  platform). Positioned as moving "beyond infrastructure as code" to a universal
  control plane.
  Sources: [Upbound blog, "Universal Crossplane and Upbound General Availability"](https://web.archive.org/web/2id_/https://blog.upbound.io/universal-crossplane-and-general-availability);
  [Business Wire, May 18 2021](https://www.businesswire.com/news/home/20210518005942/en/Industrys-First-Enterprise-Grade-Distribution-of-the-Popular-CNCF-Project-Crossplane-Arrives-Bringing-the-Kubernetes-Powered-Universal-Control-Plane-Approach-to-Platform-Teams-Everywhere).

- **September 14, 2021** — **Crossplane moves from CNCF Sandbox to Incubating.**
  At incubation the project cited growth: GitHub stars ~2,000 → 3,680+,
  container downloads up ~13x, Slack membership up ~4x, contributors tripled,
  100+ companies contributing code.
  Sources: [Crossplane blog, "Crossplane is now a CNCF Incubating project"](https://blog.crossplane.io/crossplane-cncf-incubation/);
  [CNCF blog, "Crossplane moves from Sandbox to CNCF Incubator," Sep 14 2021](https://www.cncf.io/blog/2021/09/14/crossplane-moves-from-sandbox-to-cncf-incubator/);
  [CNCF Crossplane project page](https://www.cncf.io/projects/crossplane/).

- **November 29, 2021** — **Upbound raises a $60M Series B, led by Altimeter
  Capital**, with participation from **GV, Intel Capital, and Telstra Ventures**.
  (Reporting at the time put Upbound's total raised at roughly $69M across
  rounds.) Major vendors including AWS, Azure, Equinix, and IBM were noted as
  building Crossplane integrations.
  Sources: [TechCrunch, Nov 29 2021](https://techcrunch.com/2021/11/29/upbound-grabs-60m-series-b-to-grow-open-source-crossplane-cloud-management-project/);
  [Business Wire, Nov 29 2021](https://www.businesswire.com/news/home/20211129005138/en/Upbound-Raises-$60M-in-Funding-from-Altimeter-Capital-GV-Intel-Capital-and-Others-To-Advance-its-Universal-Cloud-Management-Platform);
  [Upbound blog, "Upbound Raises $60M…"](https://web.archive.org/web/2id_/https://blog.upbound.io/upbound-raises-60m-in-funding-to-advance-its-universal-cloud-platform).

### 2022 — Provider-generation tooling (Terrajet → Upjet) and Marketplace

- **January 24, 2022** — **Terrajet announced** — a code-generation framework to
  generate Crossplane providers *from Terraform providers*. It reads a Terraform
  provider's schema and generates CRDs + a generic Terraform-backed controller,
  rapidly expanding API coverage. (Early generated coverage cited: 763 AWS CRDs,
  647 Azure CRDs, 438 GCP CRDs.) Terrajet was later renamed/evolved into
  **Upjet**.
  Sources: [Crossplane blog, "Announcing Terrajet"](https://blog.crossplane.io/announcing-terrajet/);
  [Upjet GitHub repo (crossplane/upjet)](https://github.com/crossplane/upjet).

- **October 2022** — Crossplane **Marketplace** unveiled for discovering
  providers and configurations.
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

  > **Provider-ecosystem / IaC cross-reference:** This is the key link to the
  > broader "IaC code-generation" theme. The official AWS, Azure, and GCP
  > Crossplane providers — and 50+ community providers — are **generated by
  > Upjet from upstream Terraform providers** (Go types, CRDs, reconciliation
  > controllers). Upjet-generated providers run Terraform's resource logic
  > internally but expose a pure Kubernetes API, and removing the Terraform CLI
  > dependency also sidesteps HashiCorp's BSL relicensing and yielded large
  > efficiency gains (Upbound benchmarked up to ~4x cost savings).
  > Sources: [Upjet GitHub repo](https://github.com/crossplane/upjet);
  > [Crossplane blog, "New Providers… up to 4x cost-savings"](https://blog.crossplane.io/new-providers-for-crossplane-donated-by-upbound-bring-up-to-4x-cost-savings/);
  > [Upbound blog, "The First Official Providers"](https://blog.upbound.io/first-official-providers).

### 2023 — Composition Functions, security audits, Upjet donation, 5 years

- **January 31, 2023** — **v1.11 released with Composition Functions** (pipeline-
  based composition logic).
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

- **2023 (multiple)** — Per the project's 5-year retrospective: a fuzzing
  security audit (Mar 24), v1.12 (Apr 25), **Provider Families** launched
  (Jun 13), v1.13 + an independent third-party security audit (Jul 27),
  **Upjet acceptance** announced (Sep 19), and v1.14 (Nov 1).
  Source: [Crossplane "at 5 years" retrospective](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

- **December 4, 2023** — **Crossplane's 5-year anniversary**, marked by the
  "Crossplane at 5: Past, Present, and Future of Control Planes" retrospective
  (the primary source for much of the 2019–2023 timeline above).
  Source: [Crossplane blog, "Crossplane at 5 years"](https://blog.crossplane.io/crossplane-at-5-years-past-present-and-future-of-building-control-planes/).

### 2025 — Crossplane v2 and CNCF Graduation

- **August 12, 2025** — **Crossplane 2.0 released.** A major evolution: a
  **namespace-first architecture** (composite and managed resources are
  namespaced by default, departing from the cluster-scoped model and the
  claim/XR duality); **compositions can now include *any* Kubernetes resource**
  (not just Crossplane-managed infrastructure), enabling full-stack abstractions
  that span infrastructure *and* applications; new **Operations** (declarative
  day-two operational tasks via function pipelines); and **Managed Resource
  Definitions** for selectively activating only the provider resources you need.
  v2 maintains backward compatibility with most v1.x configurations.
  Sources: [Crossplane blog, "Announcing Crossplane 2.0"](https://blog.crossplane.io/announcing-crossplane-2-0/);
  [InfoQ, "Crossplane Tackles Applications alongside Cloud Infrastructure with v2.0"](https://www.infoq.com/news/2025/08/crossplane-applications-v2/);
  earlier proposal: [Crossplane blog, "Crossplane v2: A More Intuitive Way to Manage Applications"](https://blog.crossplane.io/announcing-crossplane-v2-proposal/).

- **October 28, 2025** — **Crossplane officially reaches CNCF Graduated status**
  (the date CNCF records as the maturity-level change; this reflects the TOC
  graduation decision).
  Sources: [CNCF Crossplane project page](https://www.cncf.io/projects/crossplane/)
  (graduated: October 28, 2025); CNCF TOC graduation tracking issue/PR:
  [cncf/toc PR #1254](https://github.com/cncf/toc/pull/1254).

- **November 6, 2025** — **CNCF publicly announces Crossplane's graduation.**
  Stats cited: 3,000+ contributors from 450+ organizations, 100+ releases,
  1,000+ PR authors (5x since incubation), top-10% of CNCF projects by
  contributor engagement; adopters including Nike, Autodesk, NASA Science Cloud,
  Elastic, SAP, IBM, Akamai, Grafana, Nokia, and VMware Tanzu. CNCF CTO Chris
  Aniszczyk called it "a major milestone for cloud native and multi-cloud
  platform engineering."
  Sources: [CNCF announcement, Nov 6 2025](https://www.cncf.io/announcements/2025/11/06/cloud-native-computing-foundation-announces-graduation-of-crossplane/);
  [Crossplane blog, "Announcing Crossplane's CNCF Graduation"](https://blog.crossplane.io/crossplane-cncf-graduation/);
  [PR Newswire, Nov 6 2025](https://www.prnewswire.com/news-releases/cloud-native-computing-foundation-announces-graduation-of-crossplane-302606365.html);
  [InfoQ, "Crossplane Reaches Production Maturity by Graduating CNCF"](https://www.infoq.com/news/2025/11/crossplane-grad/).

  > **Date note:** The graduation has two associated dates — **October 28, 2025**
  > (the maturity-level change recorded by CNCF) and **November 6, 2025** (the
  > public announcement). Both are correct; they refer to different events.

---

## How Crossplane differs from Terraform / Pulumi (the thesis)

Crossplane's core differentiator is that it is a **control plane**, not a
client-side, one-shot IaC tool:

- **Terraform** (and similarly Pulumi's apply model) is a short-lived CLI
  process that reconciles desired vs. actual state **only when invoked**
  (`plan`/`apply`); drift is detected/corrected on demand, driven by a human or
  pipeline run.
- **Crossplane** runs as **long-lived Kubernetes control loops** (provider
  controllers) that **continuously observe and reconcile** managed resources
  toward their desired state — so out-of-band drift is detected and corrected
  automatically, within the reconciliation cycle, without a human invoking a run.

Building blocks: **Managed Resources** (cloud resources represented as
Kubernetes CRs), and **Compositions** + **Composite Resource Definitions (XRDs)**
that let platform teams define higher-level, self-service infrastructure
abstractions ("compose cloud infrastructure as Kubernetes resources").

Sources: [Crossplane blog, "Crossplane vs Terraform"](https://blog.crossplane.io/crossplane-vs-terraform/);
[Pulumi docs, "Pulumi vs. Crossplane"](https://www.pulumi.com/docs/iac/comparisons/crossplane/).
(The reconciliation/control-loop framing is also discussed broadly in
third-party comparisons such as [Spacelift](https://spacelift.io/blog/crossplane-vs-terraform).)

---

## Key people & teams

- **Bassam Tabbara** — Founder and CEO of **Upbound**; creator of both **Rook**
  (the cloud-native storage operator) and **Crossplane**, and a maintainer of
  both. Prior background: CTO of Quantum, and CTO/co-founder of **Symform** (a
  P2P storage startup acquired by Quantum); earlier a Partner Software Architect
  at Microsoft. He is the central figure behind the "democratize the cloud
  control plane" thesis.
  Sources: [Crossplane blog author page (Bassam)](https://blog.crossplane.io/author/bassam/);
  [SiliconANGLE profile, Aug 2022](https://siliconangle.com/2022/08/23/dream-of-entrepreneurship-drives-bassam-tabbaras-quest-to-democratize-the-cloud-control-plane-kubecon/);
  background corroborated via [eWeek (Rook/Symform/Quantum)](https://www.eweek.com/cloud/rook-cloud-storage-project-backer-upbound-raises-9m-for-multi-cloud/).

- **Jared Watts** — Founding Engineer at Upbound and a **co-creator of
  Crossplane** (and Rook); core maintainer. Co-author of the original Dec 2018
  Crossplane announcement. Quoted at graduation: "With Crossplane v2, we've
  delivered on years of community feedback and made control plane development
  accessible to every platform team."
  Sources: [Crossplane blog, "Introducing Crossplane"](https://blog.crossplane.io/introducing-crossplane/);
  [CNCF graduation announcement](https://www.cncf.io/announcements/2025/11/06/cloud-native-computing-foundation-announces-graduation-of-crossplane/);
  [Crossplane blog, "Announcing Crossplane's CNCF Graduation"](https://blog.crossplane.io/crossplane-cncf-graduation/).

- **Illya Chekrygin** — Co-author of the original December 2018 Crossplane
  announcement; cited in some sources as an Upbound co-founder.
  Source: [Crossplane blog, "Introducing Crossplane" (authorship)](https://blog.crossplane.io/introducing-crossplane/).
  (Co-founder status: reported by Crunchbase-derived summaries — see
  "Could not verify.")

- **Nic Cope** — Long-time Crossplane maintainer/engineer at Upbound; credited
  among the authors/voices of the Crossplane 2.0 announcement.
  Source: [Crossplane blog, "Announcing Crossplane 2.0"](https://blog.crossplane.io/announcing-crossplane-2-0/).

- **The Crossplane community / CNCF** — At graduation: 3,000+ contributors from
  450+ organizations, 1,000+ PR authors, 100+ releases. Governance is
  vendor-neutral under CNCF, with a community registry (xpkg.crossplane.io) and
  Community Extension Projects governance.
  Source: [Crossplane blog, "Announcing Crossplane's CNCF Graduation"](https://blog.crossplane.io/crossplane-cncf-graduation/).

---

## Company & corporate history (Upbound)

- **Founded by Bassam Tabbara** (with Illya Chekrygin frequently named as
  co-founder). Upbound's mission is described as "democratizing the cloud
  control plane." Before Crossplane, Upbound was the commercial sponsor behind
  the **Rook** storage operator (donated to CNCF January 2018).
  Sources: [SiliconANGLE](https://siliconangle.com/2022/08/23/dream-of-entrepreneurship-drives-bassam-tabbaras-quest-to-democratize-the-cloud-control-plane-kubecon/);
  [CNCF Rook blog](https://www.cncf.io/blog/2018/01/29/cncf-host-rook-project-cloud-native-storage-capabilities/).

- **Funding:**
  - **Series A — $9M, May 2, 2018**, led by **GV (Google Ventures)**. (Predates
    the Crossplane announcement.)
    Sources: [Medium announcement](https://medium.com/upbound/upbound-announces-9-million-series-a-led-by-gv-1dc52a2f42a4);
    [Business Wire](https://www.businesswire.com/news/home/20180502005465/en/Upbound-Announces-9-Million-Series-Led-GV).
  - **Series B — $60M, November 29, 2021**, led by **Altimeter Capital**, with
    **GV, Intel Capital, Telstra Ventures**. Total raised reported around ~$69M.
    Sources: [TechCrunch](https://techcrunch.com/2021/11/29/upbound-grabs-60m-series-b-to-grow-open-source-crossplane-cloud-management-project/);
    [Business Wire](https://www.businesswire.com/news/home/20211129005138/en/Upbound-Raises-$60M-in-Funding-from-Altimeter-Capital-GV-Intel-Capital-and-Others-To-Advance-its-Universal-Cloud-Management-Platform).

- **Commercial products:** **Upbound Universal Crossplane (UXP)** — an
  enterprise-grade downstream distribution of Crossplane — plus **Upbound Cloud**
  and the **Upbound Registry/Marketplace**, all reaching GA in **May 2021**.
  Upbound also drives the official **Upjet-generated provider** ecosystem
  (AWS/Azure/GCP and more), which it has contributed to the Crossplane project /
  CNCF over time.
  Sources: [Upbound blog, "Universal Crossplane and General Availability"](https://web.archive.org/web/2id_/https://blog.upbound.io/universal-crossplane-and-general-availability);
  [Business Wire, May 18 2021](https://www.businesswire.com/news/home/20210518005942/en/Industrys-First-Enterprise-Grade-Distribution-of-the-Popular-CNCF-Project-Crossplane-Arrives-Bringing-the-Kubernetes-Powered-Universal-Control-Plane-Approach-to-Platform-Teams-Everywhere);
  [Upbound newsroom, "Upbound Contributes Control Plane Provider Technology to the Crossplane Project"](https://web.archive.org/web/2id_/https://www.upbound.io/newsroom/upbound-contributes-control-plane-provider-technology-to-the-crossplane-project-governed-by-the-cloud-native-computing-foundation).

- **2025 repositioning:** Around Crossplane's graduation, Upbound publicly
  repositioned toward **"AI-native infrastructure."**
  Source: [Upbound newsroom, "Crossplane Graduates From CNCF as Upbound Redefines the Future of AI-Native Infrastructure"](https://www.upbound.io/newsroom/crossplane-graduates-from-cncf-as-upbound-redefines-the-future-of-ai-native-infrastructure);
  [PRWeb release](https://www.prweb.com/releases/crossplane-graduates-from-cncf-as-upbound-redefines-the-future-of-ai-native-infrastructure-302607394.html).

---

## Could not verify

- **Exact Upbound founding date/year.** Sources consistently name Tabbara as
  founder and tie Upbound to Rook (2018) and the Series A (May 2018), but a
  primary source stating the precise incorporation date was not located.
  (Crunchbase-style summaries suggested a 2017 founding but were not
  independently confirmed from a primary source.)
- **Illya Chekrygin as official Upbound "co-founder."** He is verified as a
  co-author of the original Crossplane announcement; "co-founder" appears in
  aggregated/Crunchbase-derived summaries but was not confirmed from a primary
  Upbound source.
- **Total funding "$69M."** Reported by contemporaneous third-party coverage
  (Crunchbase/Tracxn-style); only the two named rounds ($9M + $60M = $69M) are
  primary-sourced. Any additional/undisclosed rounds were not verified.
- **Precise 2019 per-release dates** beyond the Dec 23, 2019 marker rely solely
  on the Crossplane "at 5 years" retrospective; not cross-checked against
  individual GitHub release tags.
- **2023 sub-milestone dates** (fuzzing audit Mar 24, v1.12 Apr 25, Provider
  Families Jun 13, v1.13 Jul 27, Upjet acceptance Sep 19, v1.14 Nov 1) are taken
  from the "at 5 years" retrospective and were not each independently
  re-verified against separate primary sources.
- **CNCF Sandbox date discrepancy:** CNCF's project page says **June 25, 2020**;
  the Crossplane retrospective says **July 2, 2020**. Treated as the CNCF date
  being authoritative, but the two sources disagree.
