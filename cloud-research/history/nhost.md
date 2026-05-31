# Nhost — A Sourced History

A chronological, sourced history of Nhost, the Stockholm-based, open-source
"Firebase alternative" that built a backend-as-a-service (BaaS) around
**PostgreSQL + Hasura (GraphQL) + an open-source auth service + S3-backed storage
+ serverless functions** — positioning itself as the GraphQL-first counterpart to
the REST/PostgREST-first Supabase. Every non-trivial claim links to a working
source. Primary sources (Nhost's own blog and GitHub, the founders' posts, the
lead investor's announcement) are preferred, with reputable outlets (VentureBeat,
FinSMEs) as corroboration. This is a smaller company than most others in this
corpus, so the record is proportionately thinner; items that could not be
confirmed are marked **"Could not verify."**

---

## Timeline

### Origins: a Hasura side project and the Antler accelerator (2019–2020)

- **Late 2019 — solo start.** Nhost began in **Stockholm, Sweden**, originally with
  **Johan Eliasson** as the sole founder, building what amounted to an open-source
  alternative to Google's Firebase. VentureBeat's account describes the company as
  "created in late 2019" with Eliasson as the only founder, who "soon realized that
  building what is effectively an open source alternative to Google's Firebase would
  be a tall order."
  Source: [VentureBeat, "Nhost is an open source Firebase rival backed by GitHub's founders" (Apr 22, 2021)](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders).
  *(VentureBeat returned HTTP 429 to automated fetching during this research; the
  "late 2019, sole founder" framing is taken from the indexed article snippet and is
  consistent with the founders' own accounts below. Various databases also list the
  founding year as **2019** or **2020** — see the "Could not verify" note on the
  exact founding date.)*

- **The Hasura Backend Plus lineage.** Before Nhost was a company, Eliasson had
  open-sourced a project pairing **Hasura** (which generates an instant GraphQL API
  over PostgreSQL) with the two things Hasura did **not** provide out of the box —
  **authentication and file storage**. That project, **`hasura-backend-plus`** (HBP),
  is described on GitHub as "🔑Auth and 📦Storage for Hasura. The quickest way to get
  Auth and Storage working for your next app based on Hasura," and it lives under the
  **`nhost`** GitHub organization. HBP was later deprecated in favor of two successor
  services — **`hasura-auth`** and **`hasura-storage`** — both of which were
  "integrated into Nhost."
  Sources: [GitHub, nhost/hasura-backend-plus](https://github.com/nhost/hasura-backend-plus);
  [GitHub, nhost/hasura-auth](https://github.com/nhost/hasura-auth);
  [GitHub, nhost/hasura-storage](https://github.com/nhost/hasura-storage).

- **March 2020 — Antler pre-seed (~$110k), and a co-founder.** Eliasson met software
  engineer **Nuno Pato** through the **Antler** startup-generator program in **early
  2020**, and the two became co-founders (Eliasson as **CEO**, Pato as **CTO**). In
  **March 2020**, Nhost raised **$110,000 in a pre-seed round from the accelerator
  Antler**, which the founders later said bought them roughly **12 months of runway**.
  Sources: [Nhost Blog, "How we Raised $3M without Leaving the House" (Jun 11, 2021)](https://nhost.io/blog/how-we-raised-3m-dollars-without-leaving-the-house);
  [Nauta Capital, "Nhost raises $3 million in a round led by Nauta Capital, and also backed by Antler and BA" (Apr 23, 2021)](https://www.nautacapital.com/news-insights/nhost-raises-3million-in-a-round-led-by-nauta-capital-and-also-backed-by-antler-and-ba);
  [VentureBeat (Apr 22, 2021)](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders).
  *(Nhost's accelerator was **Antler**, not Y Combinator — see the "Could not verify"
  note; no evidence was found that Nhost went through YC.)*

- **The motivating problem (founder's words).** Eliasson framed the product around a
  recurring developer pain point: "It's always the same generic problem for me and
  for other developers: How to set-up the backend infrastructure, security,
  scalability without repeating the process every single time?"
  Source: [Nauta Capital (Apr 23, 2021)](https://www.nautacapital.com/news-insights/nhost-raises-3million-in-a-round-led-by-nauta-capital-and-also-backed-by-antler-and-ba).

### Fundraising through a pandemic (2020)

- **A fully-remote raise.** The founders later wrote a detailed account of raising
  their seed round entirely over Zoom — Eliasson in **Stockholm** and Pato having
  returned to the **Azores** after COVID-19 was declared a pandemic. Their post
  recounts a timeline of: ~**5 cold investor emails per week** through summer/fall
  2020; talking to about **75 potential investors** by **December 2020**; and, that
  same December, **SCNE** agreeing to invest while **Nauta Capital** became
  interested — converging on the **$3M** seed round (with about **$600k** earmarked
  for angel investors).
  Source: [Nhost Blog, "How we Raised $3M without Leaving the House" (Jun 11, 2021)](https://nhost.io/blog/how-we-raised-3m-dollars-without-leaving-the-house).

### The $3M seed round (April 2021)

- **April 2021 — $3M seed.** Nhost announced a **$3 million seed round led by Nauta
  Capital**, with participation from **SCNE** and previous investor **Antler**. The
  round was notable for its **angel investors**, several of them developer-tools
  luminaries: **Tom Preston-Werner** and **Scott Chacon** (co-founders of GitHub),
  **Mathias Biilmann Christensen** and **Christian Bach** (co-founders of Netlify),
  **Michael Grinich** (founder of WorkOS), and **Markus Boström** (founder of
  Vården.se).
  Sources: [Nhost Blog, "Nhost Raises $3M in Seed Funding" (Apr 6, 2021)](https://nhost.io/blog/nhost-raises-3m-dollar-in-seed-funding);
  [Nauta Capital (Apr 23, 2021)](https://www.nautacapital.com/news-insights/nhost-raises-3million-in-a-round-led-by-nauta-capital-and-also-backed-by-antler-and-ba);
  [FinSMEs, "Nhost Raises $3M in Seed Funding" (Apr 2021)](https://www.finsmes.com/2021/04/nhost-raises-3m-in-seed-funding.html);
  [VentureBeat (Apr 22, 2021)](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders).
  *(The two Nhost-authored funding posts and the Nauta announcement agree on Preston-
  Werner, Biilmann, and Bach; the inclusion of **Scott Chacon** (GitHub) and **Markus
  Boström** appears in the Nauta announcement and Nhost's own posts respectively. The
  exact angel roster varies slightly across retellings — treat the precise per-name
  list as **lightly sourced** beyond the three names common to all sources.)*

- **The pitch: open-source Firebase, with GraphQL.** Press and Nhost's own materials
  described the product as an **open-source Firebase alternative with GraphQL**,
  giving developers a Netlify/Vercel-like workflow from local development to
  production for the backend.
  Sources: [VentureBeat (Apr 22, 2021)](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders);
  [Nhost Blog, "Nhost Raises $3M in Seed Funding" (Apr 6, 2021)](https://nhost.io/blog/nhost-raises-3m-dollar-in-seed-funding).

### The stack: GraphQL-first, and 100% open source

- **What Nhost ships.** The `nhost/nhost` monorepo (MIT-licensed) describes Nhost as
  "The Open Source Firebase Alternative with GraphQL," composed of: a **PostgreSQL**
  database; an **instant GraphQL API via Hasura**; an **Authentication** service; a
  **Storage** service; **Serverless Functions** (Node.js, JavaScript/TypeScript); and
  the **Nhost CLI** for local development. The repo states that "Since Nhost is 100%
  open source, you can self-host the whole Nhost stack."
  Source: [GitHub, nhost/nhost](https://github.com/nhost/nhost).

- **The open-source auth and storage building blocks.** `hasura-auth` is described as
  "Authentication for Hasura," storing users in the database under its own `auth`
  schema (e.g. `auth.users`) and shipped as a Docker image (`nhost/hasura-auth`);
  `hasura-storage` "adds a storage service on top of Hasura and any S3-compatible
  storage service," exposing files through Hasura's GraphQL API and permissions.
  Sources: [GitHub, nhost/hasura-auth](https://github.com/nhost/hasura-auth);
  [GitHub, nhost/hasura-storage](https://github.com/nhost/hasura-storage).

- **The GraphQL-vs-REST contrast with Supabase.** Nhost and Supabase are the two
  most frequently paired open-source Firebase alternatives, and the distinction that
  recurs in coverage is the API layer: **Supabase is SQL/REST-first**, auto-generating
  REST APIs over Postgres via **PostgREST** (GraphQL is optional/add-on), whereas
  **Nhost is GraphQL-first**, shipping a unified **Hasura**-powered GraphQL endpoint
  (with subscriptions) by default.
  Source: [Leanware, "Supabase vs Nhost: Which Backend Platform Should You Use?"](https://www.leanware.co/insights/supabase-vs-nhost-which-backend-platform-should-you-use).
  *(This GraphQL-vs-REST framing is the consensus characterization across comparison
  write-ups; it is **reported analysis**, not a claim sourced to a single primary
  Nhost/Supabase document.)*

### AI "Graphite" and Postgres-as-vector-DB (December 2023)

- **December 22, 2023 — Graphite.** Nhost ran its first "AI Week," culminating in a
  release day that launched **Graphite**, described as Nhost's "very first AI
  product" (beta, Pro plan, usage-based pricing). Graphite bundled **Auto-Embeddings**
  (using **pgvector** + OpenAI to keep embeddings up to date in near real-time),
  **AI Assistants** (LLMs extensible with the user's own data and external tools), a
  **Dev Assistant** coding partner in the dashboard that knows the project's database
  and GraphQL schemas, **Postgres vector** support (turning Nhost Postgres into a
  vector database), and a redesigned **Docs v2**.
  Sources: [Nhost Blog, "AI Week Release Day and Recap" (Dec 22, 2023)](https://nhost.io/blog/ai-week-release-day);
  [Nhost Blog, "AI Superpowers with Nhost Postgres & Auto-Embeddings"](https://nhost.io/blog/auto-embeddings);
  [Nhost Documentation, "Auto-Embeddings"](https://docs.nhost.io/products/ai/auto-embeddings/).

---

## Key people & teams

- **Johan Eliasson** — Co-founder and **CEO**. Started Nhost (originally solo) in
  Stockholm, having previously open-sourced the Hasura-based `hasura-backend-plus`
  project that seeded the product. He has discussed Nhost's approach in developer
  podcasts (LogRocket's PodRocket; Heavybit's Jamstack Radio).
  Sources: [Nhost Blog, "Nhost Raises $3M in Seed Funding"](https://nhost.io/blog/nhost-raises-3m-dollar-in-seed-funding);
  [GitHub, elitan (Johan Eliasson)](https://github.com/elitan);
  [PodRocket (LogRocket), "Founder Friday: Johan Eliasson of Nhost"](https://podrocket.logrocket.com/nhost);
  [Heavybit, Jamstack Radio Ep. #75, "Accelerating Back End with Johan Eliasson of Nhost"](https://www.heavybit.com/library/podcasts/jamstack-radio/ep-75-accelerating-back-end-with-johan-eliasson-of-nhost).
  *(The `elitan` GitHub handle is associated with Johan Eliasson in the search index;
  treat the specific account attribution as **lightly sourced**.)*

- **Nuno Pato** — Co-founder and **CTO**. A software engineer who met Eliasson
  through the **Antler** program in early 2020 and became co-founder; during the
  pandemic he worked from the **Azores**.
  Sources: [Nauta Capital (Apr 23, 2021)](https://www.nautacapital.com/news-insights/nhost-raises-3million-in-a-round-led-by-nauta-capital-and-also-backed-by-antler-and-ba);
  [Nhost Blog, "How we Raised $3M without Leaving the House"](https://nhost.io/blog/how-we-raised-3m-dollars-without-leaving-the-house).

- **Notable angel backers** — **Tom Preston-Werner** and **Scott Chacon** (GitHub),
  **Mathias Biilmann Christensen** and **Christian Bach** (Netlify), **Michael
  Grinich** (WorkOS), and **Markus Boström** (Vården.se) participated in the 2021
  seed round — a developer-tools-heavy cap table that drew the "backed by GitHub's
  founders" framing.
  Sources: [Nhost Blog, "Nhost Raises $3M in Seed Funding"](https://nhost.io/blog/nhost-raises-3m-dollar-in-seed-funding);
  [VentureBeat (Apr 22, 2021)](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders).

---

## Company & corporate history

- **Late 2019** — Nhost begins in Stockholm with **Johan Eliasson** as sole founder,
  building on his open-source `hasura-backend-plus` work.
  [VentureBeat](https://venturebeat.com/business/nhost-is-an-open-source-firebase-rival-backed-by-githubs-founders) ·
  [GitHub, hasura-backend-plus](https://github.com/nhost/hasura-backend-plus)
- **Early/March 2020** — Eliasson meets **Nuno Pato** at **Antler**; Antler invests
  **~$110k** pre-seed. Pato becomes co-founder/CTO.
  [Nhost Blog](https://nhost.io/blog/how-we-raised-3m-dollars-without-leaving-the-house) ·
  [Nauta Capital](https://www.nautacapital.com/news-insights/nhost-raises-3million-in-a-round-led-by-nauta-capital-and-also-backed-by-antler-and-ba)
- **2020 (through December)** — Fully-remote fundraising during the pandemic;
  ~75 investors contacted; SCNE commits and Nauta engages in December.
  [Nhost Blog](https://nhost.io/blog/how-we-raised-3m-dollars-without-leaving-the-house)
- **April 2021** — **$3M seed round** led by **Nauta Capital** (with SCNE, Antler,
  and developer-tools angels) announced.
  [Nhost Blog](https://nhost.io/blog/nhost-raises-3m-dollar-in-seed-funding) ·
  [FinSMEs](https://www.finsmes.com/2021/04/nhost-raises-3m-in-seed-funding.html)
- **2021** — `hasura-backend-plus` deprecated in favor of `hasura-auth` and
  `hasura-storage`, both folded into the Nhost platform.
  [GitHub, hasura-backend-plus](https://github.com/nhost/hasura-backend-plus)
- **December 22, 2023** — Launches **Graphite** AI (Auto-Embeddings, Assistants, Dev
  Assistant, Postgres vector) during its first "AI Week."
  [Nhost Blog](https://nhost.io/blog/ai-week-release-day)

---

## Controversies

> Nhost is a small, developer-tools company; this research surfaced **no notable
> public controversy, breach, or scandal** of the kind documented for larger
> platforms in this corpus. The most "contested" topic is benign — the **GraphQL-
> first vs. REST-first positioning relative to Supabase** — which is a product/market
> distinction, not a dispute.

- **Reported claim/characterization:** Comparison write-ups frame Nhost as the
  GraphQL-first (Hasura) alternative and Supabase as the SQL/REST-first (PostgREST)
  alternative, with Supabase generally treated as the larger-community "safer
  default." This is third-party analysis, not a claim by either company.
  Source: [Leanware, "Supabase vs Nhost"](https://www.leanware.co/insights/supabase-vs-nhost-which-backend-platform-should-you-use).

*(If any funding difficulties, layoffs, or governance disputes occurred, they were
not located in this pass — see "Could not verify.")*

---

## Items marked "Could not verify"

- **Exact founding date / year.** Sources disagree: VentureBeat describes a "late
  2019" start with Eliasson solo, while some databases and Nhost's own funding posts
  variously imply **2019** or **2020** (the year Pato joined and Antler invested).
  Treated as "late 2019 origin, 2020 co-founding," with the precise legal founding
  date unconfirmed.
- **Y Combinator.** No evidence was found that Nhost was a **Y Combinator** company;
  its accelerator was **Antler**. The YC angle in the task brief appears **not** to
  apply.
- **Any funding after the April 2021 seed round.** No verified Series A (or later)
  was located; funding databases list the **$3M seed** as the most recent disclosed
  round as of this research. A later round could not be confirmed.
- **The exact full angel-investor roster.** Tom Preston-Werner, Mathias Biilmann, and
  Christian Bach appear in all sources; **Scott Chacon**, **Michael Grinich**, and
  **Markus Boström** appear in some but not all — the precise complete list is
  lightly sourced.
- **Direct read of the VentureBeat article** — returned HTTP 429 to automated
  fetching; the "late 2019 / sole founder / GitHub-founders-backed" details are taken
  from the search index snippet and corroborated by Nhost's own posts and the Nauta
  Capital announcement.
- **Current company status, headcount, and any 2024–2026 corporate developments
  beyond the Dec 2023 Graphite launch** — not established from primary sources in
  this pass.
- **The `elitan` GitHub account as definitively Johan Eliasson's** — associated in the
  search index but not confirmed against a primary cross-link.
