# Render (render.com): A Sourced History

A chronological, fully-sourced history of **Render** — the managed cloud
application platform widely positioned as a modern "Heroku successor," founded
by ex-Stripe engineer **Anurag Goel**. Render runs web services, background
workers, cron jobs, static sites, and managed datastores (Postgres,
Redis-compatible "Key Value") on a unified developer-experience layer over
underlying cloud infrastructure.

Every non-trivial claim below carries a working source link. Primary sources
(Render's own blog/press, funding announcements) are preferred, with reputable
outlets (TechCrunch, CNBC, Businesswire) as corroboration. Items that could not
be confirmed against a primary or reputable secondary source are explicitly
flagged with **Could not verify.** Controversies and opinions are attributed to
their sources, with fact separated from reported claim.

---

## Timeline

### Founding and origin story (2016–2018)

- **Founder background: Stripe's fifth engineer (2011).** Anurag Goel was "the
  fifth engineer at Stripe back in the day, 2011," joining **pre-launch**, and
  stayed for nearly five years. He has said that at Stripe "about 20% of our
  engineering team was dedicated to managing our AWS infrastructure"; rather than
  work on infrastructure directly, he built out Stripe's **financial risk
  operations and engineering teams** as the company scaled.
  - Source (Goel's own account): [The infrastructure behind a PaaS with Anurag Goel — Changelog "Ship It!" #108](https://changelog.com/shipit/108)

- **2016 — leaving Stripe; the GPU/Jupyter side-project.** Goel left Stripe in
  early 2016 and spent roughly two years experimenting with ideas. One was a
  product offering single-click, GPU-powered access to Jupyter Notebooks, which
  he later sold. Across these projects he kept rebuilding the same production
  infrastructure, which became the seed of Render's thesis: companies repeatedly
  rebuild the same Kubernetes-driven platform even though application needs are
  largely identical.
  - Source: [Changelog "Ship It!" #108](https://changelog.com/shipit/108)
  - **Could not verify** the product name "Crestle" against a primary source in
    this pass; the GPU/Jupyter side-project is described (unnamed) by Goel in the
    Changelog interview. Secondary profiles name it "Crestle"
    (e.g. [Modern CTO — Anurag Goel](https://moderncto.io/anurag-goel/)); treat the
    name as **reported, not first-party-confirmed here**.

- **2018 — Render founded.** By late 2017 the idea had crystallized, and Render
  was founded (commonly dated to **2018**) by Anurag Goel to abstract away
  infrastructure complexity while keeping flexibility — building commercially what
  most companies build internally.
  - Source (founding ~2018, secondary): [CanvasBusinessModel — Brief History of Render](https://canvasbusinessmodel.com/blogs/brief-history/render-brief-history)
  - **Note on the 2018 vs 2019 discrepancy:** Render's own Series A blog post says
    "since our **launch in 2019**," referring to the public product launch rather
    than incorporation. The company is generally described as **founded in 2018**
    and **publicly launched in 2019**.
    - Source (Render's "launch in 2019" wording): [Render's $20 Million Series A — Render Blog](https://render.com/blog/render-series-a)

### Public launch, product expansion, and the Battlefield win (2019)

- **April 2019 — first seed round ($2.25M).** Render raised an initial seed round
  of **$2.25 million** in April 2019.
  - Source: [Render raises $4.5M for its DevOps platform — TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)

- **October 2, 2019 — major feature expansion.** At TechCrunch Disrupt SF, Render
  announced platform additions including **Disks** (persistent storage),
  **Infrastructure-as-Code via `render.yaml`**, and a **"Deploy to Render"**
  button.
  - Sources: [Render challenges the cloud's biggest vendors with cheaper, managed infrastructure — TechCrunch (Oct 2, 2019)](https://techcrunch.com/2019/10/02/render-challenges-the-clouds-biggest-vendors-with-cheaper-managed-infrastructure/);
    [Render Releases Major New Features — GlobeNewswire (Oct 2, 2019)](https://www.globenewswire.com/news-release/2019/10/02/1924389/0/en/Render-Releases-Major-New-Features-Making-it-Possible-for-Developers-and-Startups-to-Run-the-Most-Complex-and-Demanding-Applications-in-the-Cloud.html)

- **October 4, 2019 — wins TechCrunch Disrupt SF 2019 Startup Battlefield.**
  Render won the **Startup Battlefield** competition, taking the **$100,000 prize
  and the Disrupt Cup**. TechCrunch described Render's developer experience as
  "reminiscent of Heroku." Render reported strong inbound interest after the win.
  - Sources: [And the winner of Startup Battlefield at Disrupt SF 2019 is… Render — TechCrunch (Oct 4, 2019)](https://techcrunch.com/2019/10/04/and-the-winner-of-startup-battlefield-at-disrupt-sf-2019-is-render/);
    [Render raises $4.5M — TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)

### Seed extension and the "Zero DevOps" positioning (October 2020)

- **October 22, 2020 — $4.5M added to the seed round, led by General Catalyst.**
  Render added **$4.5 million** to its existing seed, bringing total seed
  investment to **$6.75 million**. The round was **led by General Catalyst**, with
  participation from the **South Park Commons Fund** and angels including **Lee
  Fixel, Elad Gil, and Jason Warner** (then GitHub CTO and a former VP of
  Engineering at **Heroku**). Render positioned itself as a "Zero DevOps
  alternative to AWS, Azure and Google Cloud," challenging both the big-three
  hyperscalers and PaaS incumbents like Heroku and Google App Engine. Named users
  at the time included Cypress.io, Mux, Bloomscape, Zelos, 99designs, and Stripe.
  - Sources: [Render raises $4.5M for its DevOps platform — TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/);
    [General Catalyst leads $4.5m round for Render — Venture Capital Journal](https://www.venturecapitaljournal.com/general-catalyst-leads-4-5m-round-for-render/)
  - The angel-investor irony is notable and drawn from the cited sources: a
    former Heroku VP of Engineering (Jason Warner) backed the company most often
    framed as Heroku's successor.

### Series A: $20M, led by Addition (November 2021)

- **November 22–23, 2021 — Series A: $20M, led by Addition.** Render closed a
  **$20 million Series A led by Addition**, with participation from existing
  investors **General Catalyst** and the **South Park Commons Fund**. This brought
  total funding to **~$26.75 million** (some sources round to **$27M**). At the
  time Render had **35 employees** and planned to triple headcount by end of 2022,
  and to expand to **at least 10 new regions** (first launches in APAC and EMEA).
  Render reported "tens of thousands of developers" who had created **over 300,000
  services**, and said customers "migrate to Render from providers like Heroku and
  AWS every day."
  - Sources (date, lead, amounts): [Render secures $20M Series A — TechCrunch (Nov 22, 2021)](https://techcrunch.com/2021/11/22/render-secures-20m-series-a-to-compete-with-the-big-three-cloud-vendors/);
    [Render's $20 Million Series A — Render Blog](https://render.com/blog/render-series-a);
    [Render Raises $20M Series A — Businesswire (Nov 22, 2021)](https://www.businesswire.com/news/home/20211122005254/en/Render-Raises-%2420M-Series-A-to-Meet-Accelerating-Demand-for-Big-3-Cloud-Alternatives)
  - **Correction to a common framing:** The Series A was **led by Addition**, not
    General Catalyst. General Catalyst (which had led the 2020 seed) **participated**
    as an existing investor. **Could not verify** any claim that General Catalyst
    "led" the Series A.
  - **Planned free tier (fact).** At the Series A, Render said it planned to add a
    **free tier for web services and databases**, plus built-in DDoS protection.
    - Source: [TechCrunch (Nov 22, 2021)](https://techcrunch.com/2021/11/22/render-secures-20m-series-a-to-compete-with-the-big-three-cloud-vendors/)

### The Heroku free-tier exodus (November 2022)

- **November 28, 2022 (context, not a Render event) — Heroku ends its free tier.**
  Salesforce-owned Heroku discontinued its free dynos, Postgres, and Redis,
  effective **Nov 28, 2022**, triggering a large migration wave. **Render**
  (alongside Railway and Fly.io) became one of the most prominent destinations and
  is widely described as "one of the first major alternatives to Heroku."
  - Sources (alternatives framing): [Deciding Between Heroku Alternatives — Judoscale](https://judoscale.com/blog/heroku-alternatives);
    [Heroku-Like PaaS Alternatives: Render, Fly.io, and Railway Compared — Aptible](https://www.aptible.com/heroku-alternatives/heroku-like-paas)
  - For the Heroku free-tier shutdown itself, see `history/heroku.md` (announced
    Aug 25, 2022; effective Nov 28, 2022).

### Series B: $50M, led by Bessemer (June 2023)

- **June 20, 2023 — Series B: $50M, led by Bessemer Venture Partners.** Render
  raised **$50 million** led by **Bessemer Venture Partners**, with participation
  from existing investors **Addition**, **General Catalyst**, and the **South Park
  Commons Fund**. At the time Render reported **over 500,000 developers and teams**
  and **1 billion+ monthly visits** served by apps on the platform.
  - Sources: [Render's $50 Million Series B — Render Blog](https://render.com/blog/render-series-b);
    [Render Raises $50M in Series B Funding Led By Bessemer — Businesswire (Jun 20, 2023)](https://www.businesswire.com/news/home/20230620566248/en/Render-Raises-$50M-in-Series-B-Funding-Led-By-Bessemer-Venture-Partners-To-Expand-Its-Cloud-For-Application-Developers)
  - **Could not verify** a disclosed valuation for the Series B; the cited sources
    confirm the $50M amount and Bessemer lead but do not state a valuation.

### Series C and the AI-native pivot (January 2025)

- **January 21, 2025 — Series C: $80M, led by Georgian.** Render raised **$80
  million** led by **Georgian**, with participation from **01A** (01 Advisors),
  **avra**, and existing investors **Addition**, **Bessemer Venture Partners**,
  **General Catalyst**, and the **South Park Commons Fund** — bringing **total
  funding to $157 million**. Render reported surpassing **2 million developers**,
  with **100,000+ new developers joining monthly**. The round was explicitly framed
  around **AI-native software**: enterprise-grade security/scalability "by default,"
  streamlining inference operations, and leveraging Render's experience running
  **untrusted code** to let customers "execute their own AI-written code safely and
  securely."
  - Sources: [$80M to reimagine the cloud for the AI era — Render Blog](https://render.com/blog/series-c);
    [Render Secures $80M Series C Funding — Businesswire (Jan 21, 2025)](https://www.businesswire.com/news/home/20250121967005/en/Render-Secures-$80M-Series-C-Funding-to-Bring-The-Next-Billion-Applications-Online);
    [Render Scores $80 Million To Make Cloud Easier — Futuriom (Jan 2025)](https://www.futuriom.com/articles/news/render-scores-80-million-in-series-c-funding/2025/01)

### Series C extension: $100M at a $1.5B valuation (February 2026)

- **February 17, 2026 — Series C extension: $100M at a $1.5 billion valuation,
  led by Georgian.** Render raised a **$100 million Series C extension** at a
  **$1.5 billion valuation**, again **led by Georgian**, with participation from
  **Addition**, **Bessemer Venture Partners**, **General Catalyst**, and **01
  Advisors** — bringing **total funding to $258 million**. Render reported **4.5
  million+ developers**, with **250,000+ joining monthly**, and pitched itself
  squarely as the cloud for **AI-native / AI-assisted development**. CEO Anurag
  Goel: "Hyperscalers are no longer the default for teams that want to move fast.
  AI-assisted coding means developers can build faster than ever, and they need a
  cloud that can keep up." The company said it planned to launch **Render
  Workflows, object storage, code-execution sandboxes, and a consolidated AI
  gateway**.
  - Sources: [Cloud startup Render raises funding at $1.5 billion valuation — CNBC (Feb 17, 2026)](https://www.cnbc.com/2026/02/17/render-raises-100-million-at-1point5-billion-valuation.html);
    [Render Raises $100 Million Series C Extension at $1.5 Billion Valuation — Businesswire (Feb 17, 2026)](https://www.businesswire.com/news/home/20260217996046/en/Render-Raises-$100-Million-Series-C-Extension-at-$1.5-Billion-Valuation-to-Build-the-Cloud-for-AI-Native-Software);
    [Render Raises $100 Million Series C Extension — Yahoo Finance (Feb 17, 2026)](https://finance.yahoo.com/news/render-raises-100-million-series-153000615.html)

---

## Product (services, datastores, and the free tier)

Sourced primarily to Render's own documentation.

- **Service types.** Render runs **web services**, **static sites**, **background
  workers** (long-running services with no inbound traffic, typically polling a
  queue), **cron jobs** (scheduled commands; can run up to 12 hours, from ~$1/mo,
  with cron-expression support and failure notifications), and **private services**.
  - Sources: [Render Service Types — Render Docs](https://render.com/docs/service-types);
    [Background Workers — Render Docs](https://render.com/docs/background-workers)

- **Infrastructure-as-Code.** Render apps can be declared in a **`render.yaml`**
  blueprint (introduced at Disrupt SF 2019), and the platform supports auto-deploys
  from Git (GitHub/GitLab), preview environments, and free managed TLS/CDN.
  - Sources: [Blueprint YAML Reference — Render Docs](https://render.com/docs/blueprint-spec);
    [TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)

- **Managed datastores: Render Postgres and Render Key Value.** Render offers
  managed **PostgreSQL** ("Render Postgres") and a managed **Redis-compatible** store
  it has **rebranded from "Redis" to "Key Value"** — the service type is `keyvalue`
  (with `redis` as a deprecated alias), compatible with virtually all Redis clients.
  (The rebrand follows Redis's 2024 licensing change, though Render's docs frame it
  simply as the service's official name.)
  - Source: [Render Service Types — Render Docs](https://render.com/docs/service-types)
  - **Could not verify** an exact dated announcement of the Redis→Key Value rename
    in this pass; the docs reflect `keyvalue` as the current type with `redis`
    deprecated.

- **The free tier and "spin-down."** Render's free (Hobby) plan offers free **web
  services**, **static sites**, free **Render Postgres**, and free **Key Value**.
  Free **web services spin down after 15 minutes** without inbound traffic and
  take **about one minute to spin back up** (a cold-start "loading page" in the
  interim). Free workspaces get **750 free instance-hours/month**. Free **Postgres**
  is a single 1 GB instance that **expires 30 days after creation** (with a 14-day
  grace period); free **Key Value** is in-memory only with no persistence.
  - Source: [Render Free Tier — Render Docs](https://render.com/docs/free)
  - The 15-minute spin-down and ~1-minute cold start are the most-discussed free-tier
    behavior, spawning many "keep-alive ping" workarounds in the community.
    - Source (community discussion): [Do Web Services on a free tier go to sleep? — Render community](https://render.discourse.group/t/do-web-services-on-a-free-tier-go-to-sleep-after-some-time-inactive/3303)
  - **Note:** Render notably **retained a free tier** through and after Heroku's
    Nov 2022 free-tier shutdown, which was part of its appeal to migrating Heroku
    users.

---

## Competition framing (Heroku, Railway, Fly.io)

- **The "Heroku successor / easiest cloud" positioning.** From its public launch,
  Render was framed as a Heroku-like developer experience layered over modern cloud
  infrastructure — TechCrunch called it "reminiscent of Heroku," and Render's own
  messaging emphasized giving developers "Zero DevOps" simplicity versus AWS/Azure/GCP.
  - Sources: [TechCrunch (Oct 4, 2019)](https://techcrunch.com/2019/10/04/and-the-winner-of-startup-battlefield-at-disrupt-sf-2019-is-render/);
    [TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)

- **The Heroku-alternative cohort.** In the post-2022 Heroku exodus, Render, **Railway**,
  and **Fly.io** became the most-cited alternatives, each with a distinct philosophy:
  Railway (usage-based simplicity), Render (managed production infrastructure), and
  Fly.io (global edge/Docker control). One commonly cited contrast: **Railway shut
  down its free tier (Aug 1, 2023)** while **Render retained a free tier**.
  - Sources: [Heroku-Like PaaS Alternatives — Aptible](https://www.aptible.com/heroku-alternatives/heroku-like-paas);
    [Top five Heroku alternatives — Railway Blog](https://blog.railway.com/p/top-five-heroku-alternatives)
  - These are **comparative/opinion** framings carried by the cited outlets, not
    Render's own claims.
  - For Fly.io's own architecture and history, see `history/fly-io.md`; for Heroku,
    `history/heroku.md`.

---

## Key people & teams

- **Anurag Goel** — **Founder and CEO**. Stripe's **fifth engineer** (joined
  pre-launch in 2011), where he built the financial risk operations/engineering
  teams; left in early 2016, built and sold a GPU-powered Jupyter Notebook product,
  and founded Render (~2018). He authored/voiced Render's funding announcements and
  is the public face of its "successor to Heroku / cloud for the AI era" positioning.
  - Sources: [Changelog "Ship It!" #108](https://changelog.com/shipit/108);
    [Anurag Goel — Crunchbase](https://www.crunchbase.com/person/anurag-goel-098c);
    [CNBC (Feb 17, 2026)](https://www.cnbc.com/2026/02/17/render-raises-100-million-at-1point5-billion-valuation.html)

- **Jason Warner** — Not a Render employee, but a notable **early angel investor**
  (2020 seed). Then GitHub CTO and a **former VP of Engineering at Heroku** —
  underscoring the Heroku-lineage framing around Render.
  - Source: [TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)
  - **Could not verify** a public, named Render co-founder besides Anurag Goel; he
    is consistently described as the founder/CEO. TechCrunch at times uses
    "co-founder," but no second founder is named in the sources reviewed —
    **Could not verify** a second co-founder's identity.

---

## Company & corporate history

- **~2018** — Founded by Anurag Goel (ex-Stripe); public product launched 2019.
  [CanvasBusinessModel](https://canvasbusinessmodel.com/blogs/brief-history/render-brief-history) ·
  [Render Series A blog ("launch in 2019")](https://render.com/blog/render-series-a)
- **April 2019** — Initial **$2.25M** seed.
  [TechCrunch (Oct 22, 2020)](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)
- **October 2–4, 2019** — Disks / `render.yaml` IaC / "Deploy to Render"; **wins
  Disrupt SF 2019 Startup Battlefield** ($100K + Disrupt Cup).
  [TechCrunch (Oct 4, 2019)](https://techcrunch.com/2019/10/04/and-the-winner-of-startup-battlefield-at-disrupt-sf-2019-is-render/)
- **October 22, 2020** — **$4.5M** added to seed (total $6.75M), **led by General
  Catalyst**; angels incl. Lee Fixel, Elad Gil, Jason Warner.
  [TechCrunch](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)
- **November 22, 2021** — **Series A $20M**, **led by Addition** (GC + South Park
  Commons participating); total ~$26.75M; 35 staff; 300,000+ services.
  [TechCrunch](https://techcrunch.com/2021/11/22/render-secures-20m-series-a-to-compete-with-the-big-three-cloud-vendors/) ·
  [Render Blog](https://render.com/blog/render-series-a)
- **June 20, 2023** — **Series B $50M**, **led by Bessemer** (Addition, GC, SPC
  participating); 500,000+ developers/teams; 1B+ monthly visits.
  [Render Blog](https://render.com/blog/render-series-b) ·
  [Businesswire](https://www.businesswire.com/news/home/20230620566248/en/Render-Raises-$50M-in-Series-B-Funding-Led-By-Bessemer-Venture-Partners-To-Expand-Its-Cloud-For-Application-Developers)
- **January 21, 2025** — **Series C $80M**, **led by Georgian** (total $157M); 2M+
  developers; explicit AI-native framing.
  [Render Blog](https://render.com/blog/series-c) ·
  [Businesswire](https://www.businesswire.com/news/home/20250121967005/en/Render-Secures-$80M-Series-C-Funding-to-Bring-The-Next-Billion-Applications-Online)
- **February 17, 2026** — **Series C extension $100M at $1.5B valuation**, **led by
  Georgian** (total $258M); 4.5M+ developers; "cloud for AI-native software."
  [CNBC](https://www.cnbc.com/2026/02/17/render-raises-100-million-at-1point5-billion-valuation.html) ·
  [Businesswire](https://www.businesswire.com/news/home/20260217996046/en/Render-Raises-$100-Million-Series-C-Extension-at-$1.5-Billion-Valuation-to-Build-the-Cloud-for-AI-Native-Software)

### Funding ladder (verified figures)

| Round | Date | Amount | Lead | Total to date | Notes |
|---|---|---|---|---|---|
| Seed (initial) | Apr 2019 | $2.25M | — | $2.25M | [TechCrunch](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/) |
| Seed (extension) | Oct 22, 2020 | $4.5M | General Catalyst | $6.75M | angels: Fixel, Gil, Warner ([TechCrunch](https://techcrunch.com/2020/10/22/render-raises-4-5m-for-its-devops-platform/)) |
| Series A | Nov 22, 2021 | $20M | **Addition** | ~$26.75M | GC + SPC participating ([TechCrunch](https://techcrunch.com/2021/11/22/render-secures-20m-series-a-to-compete-with-the-big-three-cloud-vendors/)) |
| Series B | Jun 20, 2023 | $50M | Bessemer | (not disclosed) | Addition, GC, SPC ([Render Blog](https://render.com/blog/render-series-b)) |
| Series C | Jan 21, 2025 | $80M | Georgian | $157M | 01A, avra, Addition, Bessemer, GC, SPC ([Render Blog](https://render.com/blog/series-c)) |
| Series C ext. | Feb 17, 2026 | $100M | Georgian | $258M | $1.5B valuation; Addition, Bessemer, GC, 01A ([CNBC](https://www.cnbc.com/2026/02/17/render-raises-100-million-at-1point5-billion-valuation.html)) |

- **Note on the task brief's funding framing:** The brief's "Series A ~$20M led by
  **General Catalyst** 2021; Series B ~$50M 2022" needs two corrections supported by
  the sources: the **Series A was led by Addition** (GC led the **2020 seed**), and
  the **$50M Series B was announced June 2023**, not 2022.

---

## Controversies / criticism

> Render has not been the subject of a major public scandal in the sources
> reviewed. The items below are **reported product criticisms / user friction**,
> attributed to their sources, not company admissions.

### 1. Free-tier "spin-down" friction

- **Fact (per Render docs):** Free web services spin down after **15 minutes** of
  inactivity and take **~1 minute** to cold-start; free Postgres expires after 30
  days.
  - Source: [Render Free Tier — Render Docs](https://render.com/docs/free)
- **Reported friction:** The spin-down behavior is the most common free-tier
  complaint and has produced a cottage industry of "keep-alive ping" workarounds
  (Uptime Robot, self-pinging scripts) in community blogs and forums.
  - Source: [Render community thread](https://render.discourse.group/t/do-web-services-on-a-free-tier-go-to-sleep-after-some-time-inactive/3303)
  - This is **user-reported friction / opinion**, not a defect claim.

### 2. Reliability/maturity vs. incumbents (reported)

- Comparative articles in the Heroku-alternatives genre weigh Render against Railway
  and Fly.io on pricing, cold starts, and database limits; conclusions vary by
  author and are **opinion**, not established fact.
  - Source: [Heroku-Like PaaS Alternatives — Aptible](https://www.aptible.com/heroku-alternatives/heroku-like-paas)

---

## Items marked "Could not verify"

- **Exact founding date / legal entity name.** "~2018" founded and "2019" public
  launch are reconcilable but come from secondary sources plus Render's own "launch
  in 2019" wording; no single dated incorporation primary source was located.
- **The name "Crestle"** for Goel's pre-Render GPU/Jupyter product — described
  (unnamed) by Goel in the Changelog interview; the name appears only in secondary
  profiles here.
- **A second named co-founder.** Sources consistently name only Anurag Goel as
  founder/CEO (TechCrunch occasionally uses "co-founder"); no second founder is
  named in the reviewed sources.
- **Series B valuation** — not disclosed in the cited sources (only the $50M amount
  and Bessemer lead are confirmed).
- **Exact dated announcement of the Redis → "Key Value" rename** — the current docs
  reflect `keyvalue` (with `redis` deprecated), but a dated rename announcement was
  not located in this pass.
- **The task brief's "Series A led by General Catalyst" and "Series B in 2022"** —
  **not supported**: Addition led the Series A (Nov 2021); General Catalyst led the
  2020 seed; the $50M Series B was announced **June 2023**.
