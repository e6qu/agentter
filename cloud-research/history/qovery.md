# Qovery — A Sourced History

A chronological, sourced history of **Qovery**, the Paris-based developer
self-service platform that set out to deliver a **Heroku-like experience on top
of the customer's own cloud account** (AWS, Google Cloud, Scaleway,
DigitalOcean) and Kubernetes — abstracting away infrastructure while keeping
teams on their own IaaS — and which from 2024–2025 repositioned around
**DevOps automation** and **AI agents** ("DevOps Copilot"). Its deployment core,
the **Qovery Engine**, is open source and written in **Rust**.

This is a smaller, privately held company than the largest entries in this
corpus, and public primary sourcing is correspondingly thin. Every non-trivial
claim below carries a working source link, with primary sources (Qovery's own
blog/press, the GitHub repo, investor posts) preferred and reputable outlets
(TechCrunch, InfoQ, DevOps.com) used for corroboration. Where a detail could not
be confirmed, or where sources conflict, it is explicitly flagged **Could not
verify:** / noted inline. Opinions and characterizations are attributed.

---

## Timeline

### 2019 — Founding (Paris) and Techstars

- **Founded in 2019, in Paris, by Romaric Philogène and Pierre Mavro.** Qovery
  itself states in its pre-seed announcement that "The Company has participated
  in the prestigious Techstars acceleration program in late 2019," and names
  **Romaric Philogène (CEO & Co-founder)** and **Pierre Mavro (Co-founder)**.
  - Source: [We raised $1M pre-seed round… — Qovery blog](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud)
  - Secondary corroboration of a 2019 founding and the Techstars 2019 cohort:
    [Qovery — company profile — Tracxn](https://tracxn.com/d/companies/qovery/__7d7x8lhoZy2gKblekwYRLbLbz5Q69SBYPdXiNGSHT0w);
    [Startup in spotlight: Qovery raises $13M — Tech Funding News](https://techfundingnews.com/paris-startup-qovery-raises-13m-to-simplify-cloud-app-deployment/)
  - **Note on the founding year.** Some later coverage gives a **2020** founding
    (e.g., the IRIS Series A post and the Pulse 2.0 write-up describe Qovery as
    "established in 2020 through the Techstars 2019 accelerator"). Qovery's own
    pre-seed post anchors participation in Techstars to "late 2019," and multiple
    databases give 2019. The discrepancy (2019 vs 2020) is logged under "Could
    not verify."
    - Source (the "2020" framing): [Qovery raises $13 million… — IRIS](https://www.iris.vc/articles/qovery-raises-13-million-to-redefine-devops-automation-and-accelerate-us-expansion)

- **A third co-founder: Morgan Perry.** By the 2021 seed announcement, Qovery
  listed three co-founders: **Romaric Philogène (CEO)**, **Pierre Mavro (CTO)**,
  and **Morgan Perry (CRO)**.
  - Source: [Qovery raises $4m to build the future of the Cloud — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud)

### The product thesis — "a sort of Heroku" on your own cloud, on Kubernetes

- **What Qovery is.** Qovery connects a Git repository (GitHub/GitLab) to the
  user's own cloud account and deploys applications without manual
  infrastructure setup — pitched as the simplicity of a PaaS like Heroku while
  the user keeps full access to, and control of, their underlying IaaS.
  TechCrunch's seed-round coverage summarized it as **"a sort of Heroku, but for
  micro-services and modern cloud infrastructure."**
  - Source: [Qovery raises $4 million for its cloud deployment service — TechCrunch (Sep 28, 2021)](https://techcrunch.com/2021/09/28/qovery-raises-4-million-for-its-cloud-deployment-service/)
  - InfoQ described Qovery as "similar to Heroku but more abstract, allowing you
    to work with your IaaS of choice," and quoted Philogène framing Qovery as
    "the glue layer between SREs and developers."
    - Source: [Qovery: a Heroku for Almost Any Cloud Provider? — InfoQ (Nov 22, 2021)](https://www.infoq.com/news/2021/11/qovery/)

- **Deploys into the customer's own cloud, on Kubernetes.** At the seed round,
  the supported providers were **AWS, DigitalOcean, and Scaleway**, with
  **Google Cloud Platform** promised by year-end 2021 (and **Microsoft Azure**
  flagged for 2022). An investor framing in Qovery's own announcement: developers
  "keep full access to the power and flexibility of building on top of IaaS, can
  deploy into their own cloud infra accounts and all of that is as easy as
  working with a PaaS platform."
  - Sources: [TechCrunch (Sep 28, 2021)](https://techcrunch.com/2021/09/28/qovery-raises-4-million-for-its-cloud-deployment-service/);
    [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud);
    [InfoQ (Nov 22, 2021)](https://www.infoq.com/news/2021/11/qovery/)

### The open-source Qovery Engine (Rust)

- **The Qovery Engine is the open-source deployment core, written in Rust.** The
  public GitHub repository `Qovery/engine` ("The Orchestration Engine To Deliver
  Self-Service Infrastructure") is **Rust**, licensed **GPL-3.0**, and was
  **created on 2020-10-21**; it remains actively maintained (last push
  2026-05-28; ~2,445 stars as observed).
  - Source (repo metadata via GitHub API, observed 2026-05-31): [github.com/Qovery/engine](https://github.com/Qovery/engine)
  - Philogène, to InfoQ: "we choose to write our open source engine in Rust, even
    though it's somehow counterintuitive in the cloud ecosystem." InfoQ also notes
    the broader stack used Go, Kotlin, React, and Angular.
    - Source: [InfoQ (Nov 22, 2021)](https://www.infoq.com/news/2021/11/qovery/)
  - The Engine orchestrates Kubernetes on cloud providers and managed services,
    leveraging Terraform, Helm, kubectl, and Docker (per the repository's own
    description and README materials).
    - Source: [github.com/Qovery/engine](https://github.com/Qovery/engine)
    - **Could not verify** an exact "Engine open-sourced" announcement date; the
      repo creation date (Oct 21, 2020) is used as the earliest dated primary
      anchor.

### September 2021 — Seed round ($4M, Crane + Speedinvest)

- **Qovery announced a $4 million seed round on September 28, 2021**, **led by
  Crane Venture Partners and Speedinvest**, with **Techstars** and angel
  investors participating — including **Alexis Lê-Quôc** (co-founder & CTO of
  Datadog) and **Ott Kaukver** (CTO of Checkout.com, formerly CTO of Twilio).
  Qovery said proceeds would expand engineering and build out sales/marketing.
  - Sources: [TechCrunch (Sep 28, 2021)](https://techcrunch.com/2021/09/28/qovery-raises-4-million-for-its-cloud-deployment-service/);
    [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud);
    [Crane leads $4m round into Qovery — Crane Venture Partners](https://crane.vc/crane-leads-4m-round-into-qovery-for-its-cloud-deployment-service/)
  - At the seed, Qovery cited **over 10,000 developers across 120+ countries**
    since launch (a company-stated figure).
    - Source: [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud)

- **A $1M pre-seed (Datadog and Docker founders).** Qovery also raised a **$1M
  pre-seed** round whose named backers include **Alexis Lê-Quôc** (Datadog
  co-founder/CTO) and **Sébastien Pahl** (a Docker co-founder).
  - Source: [We raised $1M pre-seed round… — Qovery blog (post dated Nov 11, 2021)](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud)
  - **Note on dating.** Qovery's pre-seed blog post is dated **November 11,
    2021** — *after* the seed announcement (Sept 28, 2021) — which indicates the
    pre-seed post is a later-published recap rather than a real-time announcement.
    The pre-seed logically preceded the seed in the company's life. **Could not
    verify** the exact pre-seed *close* date from a contemporaneous dated source.

### December 2021 — Preview (ephemeral) environments GA

- **December 5, 2021 — the Preview Environment feature reached general
  availability.** Qovery defined it as "an ephemeral environment associated with
  the life cycle of a pull request": environments are created automatically when
  a PR is opened (cloning full infrastructure — databases and services) and
  removed when the PR is merged/closed.
  - Source: [The Preview Environment feature is GA! — Qovery blog (Dec 5, 2021)](https://www.qovery.com/blog/the-preview-environment-feature-is-ga)
  - InfoQ had described preview environments as a planned feature in its November
    2021 piece.
    - Source: [InfoQ (Nov 22, 2021)](https://www.infoq.com/news/2021/11/qovery/)

### 2024–2025 — Repositioning toward DevOps automation and AI agents

- **Pivot from "PaaS" framing to "DevOps automation" / internal developer
  platform with AI.** By 2024–2025 Qovery's positioning centered on automating
  the DevOps lifecycle and abstracting Kubernetes for developers, increasingly
  via **AI agents** ("DevOps Copilot"). Qovery says it **started building its
  DevOps Copilot in February 2025**, with an **Agentic DevOps Copilot** live in
  alpha, and has described a set of AI agents (provisioning, FinOps,
  observability, DevSecOps) processing prompts through Anthropic's Claude while
  keeping private data/credentials out of the model.
  - Sources: [How we built an Agentic DevOps Copilot… — Qovery blog](https://www.qovery.com/blog/how-we-built-an-agentic-devops-copilot-to-automate-infrastructure-tasks-and-beyond);
    [AI DevOps Copilot — Qovery](https://web.archive.org/web/2id_/https://www.qovery.com/ai-devops-copilot);
    [Qovery Adds Multiple AI Agents to DevOps Automation Platform — DevOps.com](https://devops.com/qovery-adds-multiple-ai-agents-to-devops-automation-platform/)
  - **Could not verify** a single dated, primary "Copilot launch" press release;
    the "February 2025" start and the agent line-up are company-stated on Qovery's
    own blog/product pages (the DevOps.com page returned HTTP 403 to automated
    fetching and is cited as a known corroborating outlet, not machine-read here).

- **Migration tooling (Heroku → AWS).** Consistent with its origins, Qovery also
  marketed an open-source **DevOps AI Agent for migrating off PaaS lock-in**
  (e.g., Heroku to AWS), written up by CEO Romaric Philogène.
  - Source: [Open-Source DevOps AI Agent: Effortless Migration from Heroku to AWS — Romaric Philogène (Medium)](https://medium.com/@rphilogene/open-source-devops-ai-agent-effortless-migration-from-heroku-to-aws-baebd1c5c3a1)

### September 2025 — Series A ($13M, IRIS) and US expansion

- **Qovery announced a $13 million Series A in late September 2025**, **led by
  IRIS** (with Crane Venture Partners co-leading/participating per Qovery's own
  post), and participation from **Speedinvest**, **Techstars**, **Irregular
  Expressions**, and angels including **Datadog's Olivier Pomel and Alexis
  Lê-Quôc**, **Docker co-founder Sébastien Pahl**, and **Ott Kaukver**
  (Checkout.com CTO, joining the board). Reported at roughly **€11.3M**, the
  round funds AI-driven product work and **US expansion**.
  - Sources: [Qovery has raised $13M Series A… — Qovery blog](https://www.qovery.com/blog/13m-serie-a-funding);
    [Qovery raises $13 million… — IRIS (Sep 29, 2025 announcement)](https://www.iris.vc/articles/qovery-raises-13-million-to-redefine-devops-automation-and-accelerate-us-expansion);
    [Qovery: $13 Million Series A Secured… — Pulse 2.0 (Oct 3, 2025)](https://pulse2.com/qovery-13-million-series-a-secured-for-transforming-devops-automation/);
    [Startup in spotlight: Qovery raises $13M — Tech Funding News](https://techfundingnews.com/paris-startup-qovery-raises-13m-to-simplify-cloud-app-deployment/)
  - **Total raised ≈ $18M** across pre-seed, seed, and Series A (including
    non-dilutive financing), per the coverage of the Series A.
    - Source: [Tech Funding News](https://techfundingnews.com/paris-startup-qovery-raises-13m-to-simplify-cloud-app-deployment/)
  - **Reported, company-stated metrics at the Series A** (not independently
    audited): a majority of business from the US (figures of "~50%" and "~60%"
    appear across write-ups), **115% YoY growth**, "3× DevOps efficiency," and
    named customers such as **Talkspace** and **RxVantage**. The Tech Funding News
    headline/coverage also cites a **$45M valuation**.
    - Sources: [IRIS](https://www.iris.vc/articles/qovery-raises-13-million-to-redefine-devops-automation-and-accelerate-us-expansion);
      [Pulse 2.0](https://pulse2.com/qovery-13-million-series-a-secured-for-transforming-devops-automation/);
      [Tech Funding News](https://techfundingnews.com/paris-startup-qovery-raises-13m-to-simplify-cloud-app-deployment/)
    - **Could not verify** the US/EU revenue split (sources give differing
      ~50% vs ~60% US figures), the **$45M valuation** (reported by Tech Funding
      News; not stated in Qovery's own post), or the customer/growth metrics
      independently — treat all as **company-stated / reported**.
  - **Note on dating.** The IRIS article's machine-extracted body briefly reads
    "2024" in one place, but the Qovery blog post, the IRIS announcement framing,
    and the Pulse 2.0 piece (Oct 3, 2025) place the Series A in **late September
    2025**. The "2024" reference is treated as a stray inconsistency.

---

## Key people & teams

- **Romaric Philogène** — **Co-founder & CEO**. Qovery's own author page and the
  funding posts consistently list him as CEO/co-founder; his bio cites 10+ years
  in R&D across ad-tech and finance, with a focus on reliable, performant
  systems. He authors much of Qovery's technical/marketing content and the
  Heroku-to-AWS migration write-ups. (GitHub handle: `evoxmusic`.)
  - Sources: [Romaric Philogène — author profile — Qovery](https://web.archive.org/web/2id_/https://www.qovery.com/author/romaric-philogene);
    [evoxmusic (Romaric Philogène) — GitHub](https://github.com/evoxmusic);
    [Romaric Philogène — The Org](https://theorg.com/org/qovery/org-chart/romaric-philogene)
  - **Could not verify** the specific pre-Qovery employers from a strong primary
    source; the "ad-tech to finance / 10+ years R&D" background is as stated on
    Qovery's own bio page.

- **Pierre Mavro** — **Co-founder & CTO** (listed as "Co-founder" in the pre-seed
  post and "CTO & co-founder" in the seed post).
  - Sources: [We raised $1M pre-seed… — Qovery blog](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud);
    [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud)

- **Morgan Perry** — **Co-founder & CRO**, named in the 2021 seed announcement.
  - Source: [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud)

- **Notable angels / board.** **Alexis Lê-Quôc** (Datadog co-founder/CTO) and
  **Sébastien Pahl** (Docker co-founder) backed Qovery from the pre-seed; **Ott
  Kaukver** (Checkout.com CTO, ex-Twilio) is reported to have joined the board at
  the Series A; **Olivier Pomel** (Datadog CEO) is named among Series A angels.
  - Sources: [We raised $1M pre-seed… — Qovery blog](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud);
    [Qovery raises $4m… — Qovery blog](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud);
    [IRIS (Series A)](https://www.iris.vc/articles/qovery-raises-13-million-to-redefine-devops-automation-and-accelerate-us-expansion)

---

## Company & corporate history

- **2019** — Founded in **Paris** by **Romaric Philogène (CEO)** and **Pierre
  Mavro (CTO)**; participated in **Techstars (late 2019)**. (Some later coverage
  says 2020 — see "Could not verify.") A third co-founder, **Morgan Perry (CRO)**,
  is named by 2021.
  - [Qovery pre-seed post](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud) ·
    [Qovery seed post](https://www.qovery.com/blog/qovery-raises-4m-to-build-the-future-of-the-cloud)

- **Oct 21, 2020** — `Qovery/engine`, the open-source **Rust** deployment engine
  (GPL-3.0), created on GitHub.
  - [github.com/Qovery/engine](https://github.com/Qovery/engine)

- **Funding (verified figures):**
  | Round | Date announced | Amount | Lead(s) | Notes |
  |---|---|---|---|---|
  | Pre-seed | recap post Nov 11, 2021 (round earlier) | $1M | — | angels incl. A. Lê-Quôc (Datadog), S. Pahl (Docker) ([Qovery](https://www.qovery.com/blog/we-raised-1m-pre-seed-round-to-simplify-application-deployment-in-the-cloud)) |
  | Seed | Sep 28, 2021 | $4M | Crane Venture Partners + Speedinvest | Techstars + angels (Lê-Quôc, Kaukver) ([TechCrunch](https://techcrunch.com/2021/09/28/qovery-raises-4-million-for-its-cloud-deployment-service/), [Crane](https://crane.vc/crane-leads-4m-round-into-qovery-for-its-cloud-deployment-service/)) |
  | Series A | late Sep 2025 | $13M (~€11.3M) | IRIS (w/ Crane) | Speedinvest, Techstars, Irregular Expressions; ~$18M total to date ([Qovery](https://www.qovery.com/blog/13m-serie-a-funding), [IRIS](https://www.iris.vc/articles/qovery-raises-13-million-to-redefine-devops-automation-and-accelerate-us-expansion)) |

- **Product (multi-cloud / BYOC, on Kubernetes):** connect Git → deploy apps,
  databases, and ephemeral **preview environments** into the user's own
  **AWS / GCP / Azure / Scaleway / DigitalOcean** account, abstracting Kubernetes
  behind a PaaS-style UX; preview environments GA **Dec 5, 2021**.
  - [InfoQ](https://www.infoq.com/news/2021/11/qovery/) ·
    [Preview Environment GA — Qovery](https://www.qovery.com/blog/the-preview-environment-feature-is-ga)

- **2024–2025** — Repositioned around **DevOps automation** and **AI agents**
  ("DevOps Copilot," built from Feb 2025), using Anthropic's Claude.
  - [Agentic DevOps Copilot — Qovery](https://www.qovery.com/blog/how-we-built-an-agentic-devops-copilot-to-automate-infrastructure-tasks-and-beyond)

---

## Controversies & culture

- **No notable controversies were located.** As with other smaller, younger
  companies in this corpus, no significant public controversy, outage postmortem,
  security incident, or pricing backlash specific to Qovery was found in this
  research pass. This is an **absence of evidence**, not evidence of absence — the
  company is small and comparatively under-covered.
  - **Could not verify:** any controversy either way; none is asserted.

- **Positioning vs. Heroku (context, attributed).** Qovery is routinely framed —
  by itself, its investors, and press — as a "Heroku, but on your own cloud /
  for modern infrastructure," keeping teams on their own IaaS rather than a fully
  managed black box. This is **company/investor/press positioning**, not a neutral
  third-party benchmark.
  - Sources: [TechCrunch (Sep 28, 2021)](https://techcrunch.com/2021/09/28/qovery-raises-4-million-for-its-cloud-deployment-service/);
    [InfoQ (Nov 22, 2021)](https://www.infoq.com/news/2021/11/qovery/)

---

## Items marked "Could not verify"

- **Founding year 2019 vs 2020** — Qovery's own pre-seed post ties Techstars to
  "late 2019" and databases give 2019; some later coverage (IRIS, Pulse 2.0) says
  "established in 2020." The exact incorporation date was not located.
- **Exact pre-seed close date** — the pre-seed blog post is dated Nov 11, 2021
  (a later recap, after the Sept 2021 seed announcement); a contemporaneous dated
  pre-seed source was not found.
- **"Engine open-sourced" announcement date** — the `Qovery/engine` repo was
  created Oct 21, 2020 (used as the anchor); no dated open-sourcing press post
  was located.
- **Series A valuation ($45M)** — reported by Tech Funding News; not stated in
  Qovery's own announcement; not independently corroborated.
- **Series A US/EU revenue split** — sources give differing figures (~50% vs
  ~60% US); company-stated and not independently audited. Likewise the "115% YoY,"
  "3× DevOps efficiency," and customer names (Talkspace, RxVantage) are
  company-stated.
- **The "2024" date in the IRIS article body** — treated as a stray
  inconsistency; the Series A is placed in late September 2025 by the Qovery blog
  and Pulse 2.0 (Oct 3, 2025).
- **A single dated, primary "DevOps Copilot launch" press release** — the
  "February 2025" start and the AI-agent line-up are company-stated on Qovery's
  blog/product pages; the DevOps.com corroborating page returned HTTP 403 to
  automated fetching and was not machine-read in this pass.
- **Founders' specific pre-Qovery employers** — only the general "ad-tech to
  finance / R&D" background on Qovery's own bio page was confirmed; named prior
  employers were not verified against primary sources.
