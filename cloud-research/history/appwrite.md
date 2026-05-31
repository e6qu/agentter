# Appwrite — A Sourced History

A chronological, sourced history of Appwrite, the open-source, self-hostable
Backend-as-a-Service (BaaS) created by **Eldad Fux** in Tel Aviv as a developer-first,
Docker-packaged alternative to Google's Firebase — its origin as a 2019 open-source
side project, its 1.0 "goes stable" release in 2022, its venture funding ($10M seed,
$27M Series A), and the launch and eventual general availability of the hosted
**Appwrite Cloud**. Every non-trivial claim links to a working source. Primary
sources (Appwrite's blog/GitHub, the founder's own posts, funding press releases) are
preferred, with reputable outlets (VentureBeat, SiliconANGLE, FinSMEs, Seedcamp) as
corroboration. Items that could not be confirmed are marked **"Could not verify."**

---

## Timeline

### Origins as an open-source side project (2019)

- **April 8, 2019** — The `appwrite/appwrite` GitHub repository was created.
  Source: [GitHub API metadata for appwrite/appwrite](https://api.github.com/repos/appwrite/appwrite)
  (field `created_at`: `2019-04-08T16:36:25Z`).

- **2019 (first public releases)** — Appwrite was built by **Eldad Fux** as an
  open-source side project and released publicly on GitHub during 2019. The earliest
  tagged releases on GitHub are **0.1.13 (September 3, 2019)** and **0.1.15 (September
  10, 2019)**, followed by **0.2.0 (October 1, 2019)** and **0.3.0 (October 21,
  2019)**. Appwrite itself describes the project as having been **open-sourced in
  October 2019**, and Fux later marked "exactly 3 years since we first released
  Appwrite as an OSS" in a **September 2022** LinkedIn post — consistent with an
  autumn-2019 public debut.
  Sources: [GitHub releases for appwrite/appwrite (oldest tags via API)](https://github.com/appwrite/appwrite/releases);
  [Eldad A. Fux, LinkedIn — "Celebrating exactly 3 years since we first released Appwrite as an OSS"](https://www.linkedin.com/posts/eldadfux_celebrating-exactly-3-years-since-we-first-activity-6971439358914494464-SAoy).
  *(The earliest **0.1.x** tags predate October 2019; Appwrite's own "open-sourced in
  October 2019" framing likely refers to the first widely-announced release rather
  than the very first commit/tag. The exact "first public release" day is therefore
  best treated as **autumn 2019**, with September 2019 0.1.x tags as the earliest
  on-record artifacts — see "Could not verify" below.)*

- **What it was.** From the start, Appwrite was a **self-hosted Backend-as-a-Service**
  packaged as a set of **Docker microservices**, exposing REST APIs for the core
  backend primitives developers repeatedly rebuild: **user authentication, databases,
  file storage, and (later) cloud functions**, with real-time capabilities and
  client SDKs. It is written primarily in **PHP** and orchestrated via **Docker
  Compose**, and historically used **MariaDB** as its underlying datastore (exposed
  through a document-oriented API abstraction rather than raw SQL) plus **Redis** and
  an **Nginx** reverse proxy.
  Sources: [Appwrite Cloud public-beta announcement (lists Node, Python, PHP, Ruby, Dart function runtimes)](https://appwrite.io/blog/post/public-beta);
  [Appwrite self-hosting database configuration docs (MariaDB as the default prior to 1.9.0)](https://appwrite.io/docs/advanced/self-hosting/configuration/databases).
  *(The "MariaDB-backed, Docker-microservices, PHP" architecture is documented by
  Appwrite's own docs and corroborated by third-party guides; the precise version at
  which any database default changed is noted in Appwrite's docs.)*

### Funding I — the $10M seed round (September 2021)

- **September 28, 2021 (announced)** — Appwrite, then a **Tel Aviv, Israel-based**
  open-source BaaS for web, mobile, and Flutter developers, raised a **$10 million
  seed round**. The round was **led by Bessemer Venture Partners and Flybridge**, with
  participation from **Ibex Investors** and **Seedcamp**, plus individual angels
  including **Uri Boness (a founder of Elastic)** and **James Lindenbaum (a co-founder
  of Heroku)**. At the time Appwrite cited **10,000+ GitHub stars**, **30,000+
  developers** who had joined in the preceding four months, and **250+ code
  contributors**. Founder **Eldad Fux**: "I started Appwrite to scratch my own itch,
  but it has quickly become something so much bigger than me."
  Sources: [Seedcamp, "An open-source alternative to Google's firebase – Our investment in Appwrite's $10M seed round"](https://seedcamp.com/views/an-open-source-alternative-to-googles-firebase-our-investment-in-appwrites-10m-seed-round/);
  [FinSMEs, "Appwrite Raises $10M in Seed Funding" (Sept 2021)](https://www.finsmes.com/2021/09/appwrite-raises-10m-in-seed-funding.html);
  [VentureBeat, "Open source backend-as-a-service provider Appwrite raises $10M"](https://venturebeat.com/business/open-source-backend-as-a-service-provider-appwrite-raises-10m/).
  *(The Seedcamp post directly confirms the lead investors, participants, date,
  founder, and community metrics. The individual angels — Uri Boness and James
  Lindenbaum — are reported by FinSMEs' summary of the round; the Seedcamp post fetch
  did not surface the angels, so treat the **angel list** as **secondary-sourced**.)*

### The 1.0 release — "open-source Firebase goes stable" (September 2022)

- **September 14, 2022** — **Appwrite 1.0.0** was published on GitHub (release tag
  `1.0.0`, `published_at` `2022-09-14T12:47:41Z`). Appwrite framed it as the project's
  **first stable, production-ready release**, and a Hacker News submission titled
  **"Appwrite – open-source Firebase goes stable with 1.0"** appeared on **September
  15, 2022**. By this milestone Appwrite reported contributions from **600+
  developers**, **4,600+ pull requests**, and **13,000+ commits**. The 1.0 cycle
  introduced upgraded permissions and database query syntax, improved function
  logging, and guest-user document/file creation.
  Sources: [GitHub release tag 1.0.0 metadata (via API)](https://api.github.com/repos/appwrite/appwrite/releases/tags/1.0.0);
  [Hacker News, "Appwrite – open-source Firebase goes stable with 1.0"](https://news.ycombinator.com/item?id=32851256).

- **2022 positioning.** Around the 1.0 era Appwrite leaned hard into the **"100% open
  source alternative to Firebase"** framing — the same positioning the company and the
  press had used since the seed round.
  Source: [Appwrite blog, "Appwrite vs Firebase: An open source alternative for Firebase"](https://appwrite.io/blog/post/open-source-firebase-alternative).

### Funding II — the $27M Series A (April 2022)

- **April 5, 2022 (announced)** — Appwrite raised a **$27 million Series A** **led by
  Tiger Global Management**, with participation from prior seed backers **Bessemer
  Venture Partners, Flybridge Capital Partners, Ibex Investors, and Seedcamp**. This
  brought Appwrite's **total funding to $37 million**. The company reported its
  open-source community had grown to **over 150,000 developers** (roughly tripled from
  ~40,000 the prior fall) with **550 maintainers**. **John Curtius**, a Partner at
  Tiger Global, said BaaS solutions were "capturing the attention of developers and
  Appwrite clearly stands out for its simplicity and security." Fux: "Our vision is to
  expand the Appwrite ecosystem of APIs to allow developers to build any kind of
  secure, innovative application fast."
  Sources: [Appwrite/PR Newswire, "Appwrite Raises $27M to Support Massive Open Source Adoption…"](https://www.prnewswire.com/il/news-releases/appwrite-raises-27m-to-support-massive-open-source-adoption-of-backend-as-a-service-platform-for-developers-301517781.html);
  [SiliconANGLE, "Backend API development platform Appwrite raises $27M in Series A round" (Apr 5, 2022)](https://siliconangle.com/2022/04/05/backend-api-development-platform-appwrite-raises-27m-series-round/);
  [VentureBeat, "Appwrite, an open source backend-as-a-service provider, raises $27M"](https://venturebeat.com/business/appwrite-an-open-source-backend-as-a-service-provider-raises-27m).
  *(Chronologically the Series A (April 2022) precedes the 1.0 release (September
  2022); the sections are ordered topically — funding grouped, product milestones
  grouped — but the absolute dates are as stated.)*

### Appwrite Cloud — private beta → public beta (2023)

- **May 2, 2023 (announced)** — **Appwrite Cloud**, the company's **hosted** offering,
  moved from private beta to **public beta** ("Cloud is now available for everyone to
  sign up"), in a post by **Christy Jacob, Head of Engineering**. The public beta
  launched in a single region — **Frankfurt** — and supported **five serverless
  function runtimes (Node, Python, PHP, Ruby, and Dart)**, with planned expansion to
  San Francisco, New York, and Singapore. The post reaffirmed that "Appwrite will
  forever remain open source" and that major features would ship to the self-hosted
  version before Cloud.
  Sources: [Appwrite blog, "Appwrite Cloud is now in public beta" (May 2, 2023)](https://appwrite.io/blog/post/public-beta);
  [Hacker News, "Show HN: Appwrite Cloud Beta"](https://news.ycombinator.com/item?id=35802849).

### Appwrite Cloud reaches General Availability (August 2025)

- **August 6, 2025** — **Appwrite Cloud became Generally Available**, removing the
  beta tag after the hosted platform had been running for roughly two years; Appwrite
  said Cloud was then powering **over 300,000 projects**. The GA also accompanied the
  introduction of the **Appwrite Network** (a network of cloud regions and edge
  locations) and updated pricing plans.
  Sources: [Appwrite changelog, "Appwrite Cloud is now Generally Available" (Aug 6, 2025)](https://appwrite.io/changelog/entry/2025-08-06);
  [Appwrite blog, "Announcing the Appwrite Network: Appwrite's vision for a global cloud infrastructure"](https://appwrite.io/blog/post/the-appwrite-network);
  [Appwrite blog, "Announcing Appwrite's new pricing plans"](https://appwrite.io/blog/post/appwrite-pricing-update).

### Continued open-source growth (through 2026)

- Appwrite remained a **prominent open-source project on GitHub**: as of this writing
  the `appwrite/appwrite` repository shows roughly **56,000 stars**. The project has
  continued shipping self-hosted releases (e.g., the **1.8.x** line) alongside Cloud.
  Sources: [GitHub repository appwrite/appwrite](https://github.com/appwrite/appwrite)
  ([star count via GitHub API](https://api.github.com/repos/appwrite/appwrite));
  [Appwrite blog, "Appwrite 1.8.0: The most powerful self-hosted release yet"](https://appwrite.io/blog/post/appwrite-1-8-0-self-hosted-release).
  *(Star counts are a moving target; ~56,000 is the figure observed via the GitHub
  API at the time of writing.)*

---

## Appwrite vs. Supabase — a deliberate architectural contrast

Appwrite and **Supabase** are the two best-known open-source "Firebase alternatives,"
and they made opposite foundational bets:

- **Supabase** is **PostgreSQL-centric** — it wraps a real Postgres database and
  exposes it (with PostgREST, GoTrue auth, Realtime, storage) so that you ultimately
  work with **SQL and Postgres**.
  Source (Supabase's own positioning): [Supabase, "Supabase vs Firebase"](https://supabase.com/alternatives/supabase-vs-firebase).

- **Appwrite** originally took a **MariaDB-backed, document-oriented** approach —
  developers work with **collections and documents** through Appwrite's API
  abstraction rather than writing SQL — and emphasized **multi-language serverless
  functions** (Node, Python, PHP, Ruby, Dart, and more) running as Docker containers.
  Sources: [Appwrite self-hosting database configuration docs](https://appwrite.io/docs/advanced/self-hosting/configuration/databases);
  [Appwrite Cloud public-beta post (function runtimes list)](https://appwrite.io/blog/post/public-beta).
  *(The Postgres-vs-MariaDB and "document API vs SQL" contrast is well-documented for
  each project; the precise current default datastore in the latest Appwrite versions
  is governed by Appwrite's docs, which note MariaDB as the default prior to 1.9.0 —
  treat any "current default" claim as **version-dependent**.)*

---

## Key people & teams

- **Eldad Fux** — **Creator, Founder, and CEO** of Appwrite, and the project's first
  open-source contributor. He is based in **Tel Aviv, Israel**, and built Appwrite as
  an open-source side project before formally founding the company and hiring the
  project's core maintainers from the community. Public profiles describe a long
  open-source background and prior engineering roles.
  Sources: [Appwrite blog author page, "Eldad Fux"](https://appwrite.io/blog/author/eldad-fux);
  [Eldad A. Fux on LinkedIn](https://www.linkedin.com/in/eldadfux/);
  [Crunchbase, "Eldad Fux — Founder & CEO @ Appwrite"](https://www.crunchbase.com/person/eldad-fux).
  *(The "Tel Aviv / Israel" location is corroborated by the seed-round coverage
  describing Appwrite as a Tel Aviv-based company. Biographical specifics such as
  "self-taught," "started coding at 12," or prior CTO roles appear in secondary
  profiles and were **not** all confirmed against a primary source — see "Could not
  verify.")*

- **Early team from the open-source community.** Appwrite's first hires were drawn
  largely from its open-source contributors. Per Appwrite's own retrospective, early
  team members included **Christy Jacob** (later Head of Engineering), **Damodar
  Lohani**, **Jake Barnby**, **Bradley Schofield**, **Torsten Dittmann**, **Steven
  Nguyen**, **Khushboo Verma**, **Wess Cope**, and **Matej Bačo**, with **Sara
  Kaandorp** as an early design lead.
  Source: [Appwrite blog, "The evolution of team Appwrite" (Jan 23, 2024)](https://appwrite.io/blog/post/the-evolution-of-team-appwrite).

- **Christy Jacob** — **Head of Engineering**; authored the Appwrite Cloud public-beta
  announcement.
  Source: [Appwrite blog, "Appwrite Cloud is now in public beta"](https://appwrite.io/blog/post/public-beta).

- **Investor-side figures.** **John Curtius** (Partner, Tiger Global Management) led
  the Series A on the investor side; the seed round's individual angels included **Uri
  Boness** (a founder of Elastic) and **James Lindenbaum** (a Heroku co-founder).
  Sources: [SiliconANGLE (Series A)](https://siliconangle.com/2022/04/05/backend-api-development-platform-appwrite-raises-27m-series-round/);
  [FinSMEs, "Appwrite Raises $10M in Seed Funding"](https://www.finsmes.com/2021/09/appwrite-raises-10m-in-seed-funding.html).

---

## Company & corporate history

- **April 8, 2019** — `appwrite/appwrite` GitHub repository created.
  [GitHub API](https://api.github.com/repos/appwrite/appwrite)
- **September–October 2019** — First public open-source releases (earliest tags 0.1.x
  in Sept 2019; Appwrite cites "open-sourced in October 2019").
  [GitHub releases](https://github.com/appwrite/appwrite/releases) ·
  [Fux LinkedIn (3-year anniversary, Sept 2022)](https://www.linkedin.com/posts/eldadfux_celebrating-exactly-3-years-since-we-first-activity-6971439358914494464-SAoy)
- **~2020** — Company formally founded; core maintainers hired from the open-source
  community (per Appwrite's team retrospective).
  [Appwrite, "The evolution of team Appwrite"](https://appwrite.io/blog/post/the-evolution-of-team-appwrite)
- **September 28, 2021** — **$10M seed** led by Bessemer + Flybridge (Ibex, Seedcamp;
  angels incl. Uri Boness, James Lindenbaum).
  [Seedcamp](https://seedcamp.com/views/an-open-source-alternative-to-googles-firebase-our-investment-in-appwrites-10m-seed-round/) ·
  [FinSMEs](https://www.finsmes.com/2021/09/appwrite-raises-10m-in-seed-funding.html)
- **April 5, 2022** — **$27M Series A** led by **Tiger Global** (total raised $37M).
  [SiliconANGLE](https://siliconangle.com/2022/04/05/backend-api-development-platform-appwrite-raises-27m-series-round/) ·
  [VentureBeat](https://venturebeat.com/business/appwrite-an-open-source-backend-as-a-service-provider-raises-27m)
- **September 14–15, 2022** — **Appwrite 1.0** ("open-source Firebase goes stable").
  [GitHub 1.0.0](https://api.github.com/repos/appwrite/appwrite/releases/tags/1.0.0) ·
  [Hacker News](https://news.ycombinator.com/item?id=32851256)
- **May 2, 2023** — **Appwrite Cloud** public beta (single Frankfurt region).
  [Appwrite, "Appwrite Cloud is now in public beta"](https://appwrite.io/blog/post/public-beta)
- **August 6, 2025** — **Appwrite Cloud GA** (300,000+ projects); Appwrite Network +
  new pricing.
  [Appwrite changelog (Aug 6, 2025)](https://appwrite.io/changelog/entry/2025-08-06)
- **Ongoing** — Continued self-hosted releases (1.8.x line) and ~56,000 GitHub stars.
  [GitHub repo](https://github.com/appwrite/appwrite)

---

## Controversies / contested framings

> Appwrite's history is comparatively low on public controversy; the notable points
> are positioning/expectation debates rather than incidents. Each item separates
> **established fact** from **reported characterization**.

### 1. "Open-source Firebase" — marketing framing vs. architecture

- **Fact:** Appwrite consistently markets itself as a **"100% open source" Firebase
  alternative**, and the press adopted that framing from the seed round onward.
  [Appwrite blog, "Appwrite vs Firebase"](https://appwrite.io/blog/post/open-source-firebase-alternative) ·
  [Seedcamp](https://seedcamp.com/views/an-open-source-alternative-to-googles-firebase-our-investment-in-appwrites-10m-seed-round/)
- **Reported characterization:** Whether Appwrite (document-API over MariaDB,
  multi-language Docker functions) is the "right" Firebase analog — versus Supabase's
  Postgres-native model — is a recurring developer debate, not a factual dispute.
  Comparative analyses weigh the trade-offs.
  [Leanware, "Appwrite vs Supabase"](https://www.leanware.co/insights/appwrite-vs-supabase)

### 2. Open-source company funded by Tiger Global

- **Fact:** A self-described open-source, developer-first project took a **$27M Series
  A led by Tiger Global Management**, a crossover hedge fund — a pairing that drew the
  usual scrutiny applied to VC-backed open-source companies (sustainability,
  open-core/Cloud monetization).
  [SiliconANGLE](https://siliconangle.com/2022/04/05/backend-api-development-platform-appwrite-raises-27m-series-round/)
- **Reported characterization:** The "can a VC-backed BaaS stay open source?" question
  is a general industry concern; Appwrite repeatedly pledged that the project "will
  forever remain open source" and that features ship to self-hosted before Cloud.
  [Appwrite, "Appwrite Cloud is now in public beta"](https://appwrite.io/blog/post/public-beta)
  *(This is framed as a reasonable open-source-business tension, not an accusation of
  wrongdoing.)*

---

## Items marked "Could not verify"

- **The exact "first public release" date in 2019** — Appwrite says it was
  "open-sourced in October 2019," and Fux's September 2022 LinkedIn post claims
  "exactly 3 years since we first released Appwrite as an OSS," yet the earliest GitHub
  **0.1.x** tags are dated **September 2019**. The precise first-release day is
  therefore **not pinned to a single consistent primary source**; treat it as
  **autumn 2019**.
- **The exact company incorporation date / legal founding** — Appwrite's own
  retrospective says the company was formed and the first engineers were hired "after
  the first funding round," implying roughly **2020–2021**, but no dated primary
  incorporation record was located.
- **The seed-round individual angels (Uri Boness, James Lindenbaum)** — reported by
  FinSMEs' round-up; the Seedcamp post fetched here did not surface the angel list, so
  the angels are **secondary-sourced**.
- **Eldad Fux biographical specifics** — claims such as "self-taught," "started writing
  open-source code at 12," and prior CTO roles (e.g., careerpage, Walla! NEWS) appear
  in secondary profiles/aggregators and were **not** confirmed against a primary
  source. His Tel Aviv / Israel base is corroborated by the seed-round coverage.
- **Whether any funding round occurred after the April 2022 Series A** — funding
  databases (Crunchbase, PitchBook, Tracxn, CB Insights) reviewed here show **two
  rounds totaling ~$37M (seed + Series A)** and **no Series B**; absence of a later
  round is "not found," not a positive confirmation that none will ever exist.
- **The PR Newswire Series A release** returned HTTP 429 to automated fetching; its
  date ($27M, April 5, 2022, Tiger Global lead) is independently confirmed by
  SiliconANGLE and VentureBeat. The VentureBeat $10M seed article also returned HTTP
  429; the seed details are confirmed via Seedcamp and FinSMEs.
- **The precise current default datastore in the latest Appwrite versions** —
  Appwrite's docs note **MariaDB** as the default prior to 1.9.0 and reference
  additional database options; the exact default in the newest release is
  **version-dependent** and governed by Appwrite's docs rather than asserted here.
