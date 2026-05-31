# Northflank — A Sourced History

A chronological, sourced history of **Northflank**, the London-based "full-stack"
developer platform (PaaS) that lets teams build, deploy, and scale containers,
jobs, and managed databases — either on Northflank's own cloud or, via
**bring-your-own-cloud (BYOC) / self-hosting**, inside the customer's own AWS,
GCP, Azure, Oracle Cloud, Civo, or bare-metal infrastructure — and which in
2024–2025 leaned heavily into **GPU / AI workloads**.

This is a smaller, privately held company than the other entries in this corpus,
and public primary sourcing is correspondingly thin. Every non-trivial claim
below carries a working source link, with primary sources (Northflank's own
pages, the funding press release, investor posts) preferred and reputable
outlets used for corroboration. Where a detail could not be confirmed, it is
explicitly flagged **Could not verify:**. Opinions and characterizations are
attributed to their sources.

> **Note on the founder names in the research brief.** The task brief named the
> founders as "Will Stewart and Tom Lea." That is **incorrect** as far as every
> source located could confirm: Northflank's own About page and the November
> 2024 funding coverage consistently name the two co-founders as **Will Stewart
> (Co-founder & CEO)** and **Frederik Brix (Co-founder & CTO)**. No source
> associating a "Tom Lea" with Northflank was found. The corrected names are
> used throughout, and this discrepancy is logged under "Could not verify."

---

## Timeline

### 2019 — Founding (London)

- **Founded 2019, in London, by Will Stewart and Frederik Brix.** Northflank's
  GPU/product marketing repeatedly anchors the company's track record to 2019:
  "Since 2019, teams have used Northflank to run everything from enterprise
  products to high-scale AI infrastructure."
  - Source: [GPU workloads — Northflank (product page)](https://northflank.com/product/gpu-paas)
  - The company is London-based; its registered address is "20-22 Wenlock Road,
    London, England, N1 7GU."
    - Source: [About — Northflank](https://northflank.com/about)
  - Secondary company databases likewise give a 2019 founding in London by
    **Frederik Brix and Will Stewart**.
    - Source: [Northflank — company profile — Tracxn](https://tracxn.com/d/companies/northflank/__evAHwlxtCFdfVmkZVe470E8SpGCpgyNhN94GPbcB5Hw)
  - **Could not verify** an exact founding *date* (month/day) or the legal entity
    registration date against a first-party dated document; "2019" is the year
    Northflank itself uses and that secondary databases corroborate. (The legal
    entity name appears as **Northflank Ltd**.)

- **Founders' titles.** Northflank's About page lists **Will Stewart** as
  "Co-founder & CEO" and **Frederik Brix** as "Co-founder & CTO."
  - Source: [About — Northflank](https://northflank.com/about)

- **Origin story (how they met).** Per secondary reporting, the two co-founders
  met through a multiplayer game and began deploying game servers on Rancher and
  Mesos and, eventually, Kubernetes; realizing they could simplify workload
  deployment for all engineers, they created Northflank.
  - Source: [Northflank — company profile — Tracxn](https://tracxn.com/d/companies/northflank/__evAHwlxtCFdfVmkZVe470E8SpGCpgyNhN94GPbcB5Hw)
  - **Could not verify** this origin narrative against a first-party Northflank
    source; it is presented here as **reported**, attributed to Tracxn.

- **Will Stewart's background.** Before Northflank, Stewart was a software
  engineer at the UK digital agency **Clock**: "Before I started Northflank, I
  worked as a Software Engineer at Clock."
  - Source (his own words): [Will Stewart, LinkedIn post](https://www.linkedin.com/posts/william-j-stewart_before-i-started-northflank-i-worked-as-activity-7287853553744818181-1Yfu)

### The product thesis — a PaaS on top of Kubernetes, with BYOC

- **What Northflank is.** Northflank positions itself as a self-service platform
  to **build, deploy, and scale applications, databases, and jobs** on any cloud,
  abstracting Kubernetes behind a PaaS-style experience while preserving
  infrastructure control for platform/SRE teams. It self-describes as "the first
  batteries-included developer platform."
  - Source: [About — Northflank](https://northflank.com/about)
  - Source (product breakdown, founder quote): [Northflank Raises $22M… — CIO Influence (reprint of the press release, Nov 12, 2024)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)
  - In the funding announcement, CEO Will Stewart framed the abstraction pitch:
    "Too often, infrastructure complexity gets in the way — customers don't pay
    you to write YAML. Northflank gives DevOps and platform teams a better
    abstraction to manage their infrastructure and automate deployment for their
    developers."
    - Source: [CIO Influence (Nov 12, 2024)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)

- **Bring-your-own-cloud / self-hosted.** Northflank can run on its own managed
  cloud or be deployed into the customer's own cloud accounts and Kubernetes
  clusters. Vertex Ventures US (a lead investor) describes it as letting SRE
  teams "bring their own Cloud or even Kubernetes clusters," with support across
  **AWS, Google Cloud, Azure, and Civo**.
  - Source: [Backing Northflank — Sandeep Bhadra, Vertex Ventures US (Medium, Nov 11, 2024)](https://medium.com/vvus/backing-northflank-empowering-developers-and-sre-teams-with-a-modern-paas-built-for-flexibility-67fd4c0aa802)
  - Northflank's own GPU product materials extend the BYOC list to **AWS, Azure,
    GCP, Oracle, CoreWeave**, and bare-metal.
    - Source: [GPU workloads — Northflank](https://northflank.com/gpu)

### July 2022 — Seed round ($6.3M, Vertex Ventures US)

- **Northflank raised a $6.3M seed round led by Vertex Ventures US**, with
  Kindred Ventures, Tapestry VC, Pebblebed, and Uncorrelated Ventures
  participating. The seed was raised in **July 2022** but was not publicly
  *announced* until it was disclosed alongside the Series A in November 2024.
  - Source (seed amount, lead, July 2022 timing): [Northflank adds $6.3M seed from American investors led by Vertex Ventures US — Nordic 9](https://nordic9.com/news/northflank-to-add-more-capital-funding-from-american-investors/)
  - Source (seed lead Vertex, simultaneous disclosure with Series A): [Backing Northflank — Vertex Ventures US (Medium, Nov 11, 2024)](https://medium.com/vvus/backing-northflank-empowering-developers-and-sre-teams-with-a-modern-paas-built-for-flexibility-67fd4c0aa802)
  - **Could not verify** the exact seed *close* date against a first-party
    Northflank statement (the company disclosed both rounds together in November
    2024); Nordic 9 dates the seed to July 2022. Note that some startup databases
    additionally list a small **2020** seed/pre-seed entry for Northflank; that
    earlier round could **not** be independently verified here and is **not**
    asserted.

### November 11–12, 2024 — Series A ($16M, Bain Capital Ventures) and $22.3M total

- **Northflank announced $22.3M in total financing on November 11, 2024**,
  comprising a **$16M Series A led by Bain Capital Ventures** and the previously
  unannounced **$6.3M seed led by Vertex Ventures US**, with Kindred Ventures,
  Tapestry VC, Pebblebed, and Uncorrelated Ventures also participating.
  - Source (primary press release, reprinted): [Northflank Raises $22M… — CIO Influence (Nov 12, 2024)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)
  - Source (the press release on the wire): [Northflank Raises $22M to Simplify App and Database Deployment in Your Cloud — Business Wire (Nov 11, 2024)](https://www.businesswire.com/news/home/20241111904885/en/Northflank-Raises-$22M-to-Simplify-App-and-Database-Deployment-in-Your-Cloud)
    - **Note:** automated fetching of the Business Wire and VentureBeat pages
      returned transient HTTP 403/429/timeout errors; the figures, investors,
      and quotes are corroborated by the CIO Influence and Technologies.org
      reprints and by the venture-press coverage cited below.
  - Source (reprint corroborating $16M/$6.3M split, investors, customers): [Northflank Secures $22.3M to Revolutionize Developer Workflows — Technologies.org (Nov 12, 2024)](https://technologies.org/northflank-secures-22-3m-to-revolutionize-developer-workflows/)
  - Source (tech-press coverage of the same round): [Exclusive: Northflank scores $22.3 million… — VentureBeat (Nov 11, 2024)](https://venturebeat.com/ai/exclusive-northflank-scores-22-3-million-to-make-cloud-infrastructure-less-of-a-nightmare-for-developers)

- **Same round, reported in GBP.** UK/VC coverage reported the round as roughly
  **£18m** total (a ~£13m Series A plus the ~£5m seed) — the sterling equivalent
  of the $22.3M headline.
  - Source: [Bain Capital Ventures leads £18m Series A in Northflank — Soapbox](https://www.soapbox.vc/feed/northflank-18m-series-a)

- **Investor framing (attributed).** Bain Capital Ventures' **Slater Stich**
  cast the differentiation as combining a PaaS experience with full
  infrastructure control: "By building on top of K8s with the right
  abstractions, Northflank gives developers a PaaS-like deployment experience
  while giving platform engineers full control of the underlying
  infrastructure."
  - Source: [CIO Influence (Nov 12, 2024)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)

- **Customers named at the round.** Press materials named **Sentry**, **Writer**,
  and **Chai Discovery** among Northflank's customers (plus unnamed "leading
  sports leagues").
  - Source: [Technologies.org (Nov 12, 2024)](https://technologies.org/northflank-secures-22-3m-to-revolutionize-developer-workflows/)
  - Source: [CIO Influence (Nov 12, 2024)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)

### 2024–2025 — GPU / AI workloads

- **GPU and AI workloads as a headline use case.** Northflank's product now
  centers heavily on GPU-backed AI: deploying and scaling containers and
  open-source models, with NVIDIA **H100, H200, B200, A100, L4, L40S**, TPUs,
  and AMD hardware listed, across managed and BYOC clouds (including CoreWeave
  and bare-metal). Use cases advertised include **LLM training and fine-tuning,
  real-time inference APIs, computer vision/image generation, video processing,
  code generation / autonomous agents, and GPU-backed Jupyter notebooks**.
  - Source: [GPU workloads — Northflank (product page)](https://northflank.com/product/gpu-paas)
  - Source: [GPU Workloads on Northflank](https://northflank.com/gpu)
  - **Could not verify** a single dated "GPU launch" announcement; the GPU
    capability is documented via the current product/marketing pages rather than
    a dated launch post. The 2024–2025 AI emphasis is consistent with the
    Series A coverage and the company's current site, but specific feature
    launch dates were not pinned down.

- **Self-reported scale (current marketing, undated).** Northflank's GPU product
  page cites: **130B+** requests processed, **millions** of containers,
  **80k+** developers in production, **330+** availability zones, and **$24M+**
  raised.
  - Source: [GPU workloads — Northflank (product page)](https://northflank.com/product/gpu-paas)
  - **Caveat:** these are **self-reported marketing metrics** on an undated page,
    not independently audited figures. The "$24M+ raised" figure is slightly
    above the $22.3M announced in November 2024 and is **not** separately
    corroborated; treat all of these numbers as company-stated, point-in-time
    claims. **Could not verify** independently.

---

## Key people & teams

- **Will Stewart** — **Co-founder & CEO**. Previously a software engineer at the
  UK digital agency **Clock**. Writes much of Northflank's technical/marketing
  content (author handle "@NorthflankWill").
  - Sources: [About — Northflank](https://northflank.com/about);
    [Will Stewart — author profile — Northflank](https://northflank.com/author/will-stewart);
    [Stewart's LinkedIn post on his Clock background](https://www.linkedin.com/posts/william-j-stewart_before-i-started-northflank-i-worked-as-activity-7287853553744818181-1Yfu)

- **Frederik Brix** — **Co-founder & CTO**.
  - Source: [About — Northflank](https://northflank.com/about)
  - Secondary corroboration: [Frederik Brix — Co-Founder & CTO — The Org](https://theorg.com/org/northflank/org-chart/frederik-brix)

- **Could not verify** any other named executives/leaders (e.g., a VP/board
  roster) against strong primary sources; the only consistently sourced
  individuals are the two co-founders.

---

## Company & corporate history

- **2019** — Founded in **London** by **Will Stewart (CEO)** and **Frederik Brix
  (CTO)** as a Kubernetes-based, PaaS-style developer platform.
  - [About — Northflank](https://northflank.com/about) ·
    [GPU workloads — Northflank ("Since 2019")](https://northflank.com/product/gpu-paas)

- **Funding (verified figures):**
  | Round | Date raised | Date announced | Amount | Lead | Notes |
  |---|---|---|---|---|---|
  | Seed | ~Jul 2022 | Nov 11, 2024 (with Series A) | $6.3M | Vertex Ventures US | co: Kindred, Tapestry VC, Pebblebed, Uncorrelated ([Nordic 9](https://nordic9.com/news/northflank-to-add-more-capital-funding-from-american-investors/), [Vertex/Medium](https://medium.com/vvus/backing-northflank-empowering-developers-and-sre-teams-with-a-modern-paas-built-for-flexibility-67fd4c0aa802)) |
  | Series A | — | Nov 11, 2024 | $16M | Bain Capital Ventures | total disclosed $22.3M (~£18m); same co-investors ([CIO Influence](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/), [Soapbox](https://www.soapbox.vc/feed/northflank-18m-series-a)) |

  - **Total publicly disclosed: $22.3M** (Nov 2024). The "$24M+" on Northflank's
    site is company-stated and not independently corroborated (see caveat above).

- **Product (multi-cloud / BYOC):** build, deploy, scale **containers, jobs, and
  managed databases**, plus **GPU/AI workloads**, on Northflank's cloud or in the
  customer's own **AWS / GCP / Azure / Oracle / Civo / CoreWeave / bare-metal**.
  - [Vertex Ventures US (Medium)](https://medium.com/vvus/backing-northflank-empowering-developers-and-sre-teams-with-a-modern-paas-built-for-flexibility-67fd4c0aa802) ·
    [GPU workloads — Northflank](https://northflank.com/gpu)

- **Customers (named in 2024 coverage):** Sentry, Writer, Chai Discovery.
  - [Technologies.org](https://technologies.org/northflank-secures-22-3m-to-revolutionize-developer-workflows/)

---

## Controversies & culture

- **No notable controversies were located.** Unlike larger peers in this corpus
  (e.g., Heroku's free-tier removal and OAuth breach, or Fly.io's public
  reliability postmortems), no significant public controversy, outage
  postmortem, security incident, or pricing backlash specific to Northflank was
  found in this research pass. This is an **absence of evidence**, not evidence
  of absence — the company is younger, smaller, and less written-about.
  - **Could not verify:** any controversy either way; none is asserted.

- **Positioning vs. Heroku/Fly.io (context, attributed).** Northflank is
  routinely framed as a modern PaaS alternative that, unlike a fully managed
  black box, keeps platform/SRE teams in control of the underlying
  infrastructure via BYOC. This framing comes from the company and its investors
  (Vertex Ventures US, Bain Capital Ventures), i.e., it is **marketing /
  investor positioning**, not a neutral third-party assessment.
  - Sources: [Vertex Ventures US (Medium)](https://medium.com/vvus/backing-northflank-empowering-developers-and-sre-teams-with-a-modern-paas-built-for-flexibility-67fd4c0aa802);
    [CIO Influence (press release)](https://cioinfluence.com/it-and-devops/northflank-raises-22m-to-simplify-app-and-database-deployment-in-your-cloud/)

---

## Items marked "Could not verify"

- **The brief's founder name "Tom Lea"** — not supported by any source; the
  confirmed co-founders are **Will Stewart** and **Frederik Brix**.
- **Exact founding date** (month/day) and the legal-entity registration date —
  "2019" is sourced (Northflank's own pages + secondary databases); a precise
  date was not located.
- **The founders' origin story** (met through a multiplayer game; game servers on
  Rancher/Mesos/Kubernetes) — reported by Tracxn, not first-party-confirmed.
- **Exact seed close date** — Nordic 9 dates it to July 2022; both rounds were
  publicly disclosed together in November 2024. A separately reported **2020**
  seed/pre-seed entry in some databases could not be verified and is not
  asserted.
- **Direct machine-read of the Business Wire press release and the VentureBeat
  article** — returned HTTP 403/429/timeout to automated fetching; the figures,
  investors, and quotes are corroborated via the CIO Influence and
  Technologies.org reprints and other coverage.
- **Self-reported scale metrics** ("130B+ requests," "80k+ developers," "$24M+
  raised," "330+ availability zones") — company-stated marketing figures on an
  undated page; not independently audited. The "$24M+" exceeds the $22.3M
  publicly disclosed and is not separately corroborated.
- **A dated GPU/AI feature-launch announcement** — the GPU capability is
  documented via current product pages; no single dated launch post was located.
- **Any executives beyond the two co-founders** — not confirmed against strong
  primary sources.
- **Any controversy / incident** — none located in either direction.
