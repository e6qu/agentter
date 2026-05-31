# Supabase — A Sourced History

A chronological, sourced history of **Supabase** — the company founded in
**2020** by **Paul Copplestone** (CEO) and **Ant Wilson** (CTO) that built
"**the open-source Firebase alternative**" by composing existing open-source
projects around **PostgreSQL**: Postgres itself, **PostgREST** (auto-generated
REST API), **GoTrue** (auth), **Realtime**, **Storage**, and later **Edge
Functions** and **pgvector**. Every non-trivial claim links to a working
source. Primary sources (Supabase's own blog/press, the founders' posts,
funding announcements) are preferred, with reputable outlets (TechCrunch,
PR Newswire, etc.) as corroboration. Items that could not be confirmed are
marked **"Could not verify."**

> **Cross-references (not duplicated here):**
> - PostgreSQL's own lineage (Berkeley → POSTGRES → PostgreSQL), the permissive
>   license that made Supabase's "compose existing OSS" strategy possible, and
>   the broader **pgvector / AI** surge are covered in
>   [`postgresql.md`](./postgresql.md). This doc covers only the *Supabase*
>   product and company.
> - Vercel — whose founder **Guillermo Rauch** is an early Supabase angel
>   investor, and which competes in the same developer-platform / AI-app space —
>   has its own history in [`vercel.md`](./vercel.md).

---

## Timeline

### 2020-01 — Founding; Ant Wilson joins as co-founder/CTO

Supabase was started in **early 2020** by **Paul Copplestone** (CEO) and
**Ant Wilson** (CTO). The two had met earlier in Singapore through the
**Entrepreneur First** program. The seed of the idea came from Copplestone's
prior startup, **Nimbus for Work**: building a WhatsApp-style chat feature on
**Google Firebase**, his team hit Cloud Firestore's write-rate limits, and
worked around them by attaching serverless functions to Firestore that
replicated data into a **Postgres** database — which inspired the idea of an
open-source, Postgres-based Firebase alternative. Copplestone pitched Wilson,
who joined as co-founder and CTO in **January 2020**.
- Frederick AI, "Founder Story: Paul Copplestone of Supabase":
  https://www.frederick.ai/blog/paul-copplestone-supabase
- Frederick AI, "Founder Story: Ant Wilson of Supabase":
  https://www.frederick.ai/blog/ant-wilson-supabase
- **Could not verify** the exact founding day against a primary
  incorporation/SEC document in this pass; the "early 2020 / January 2020"
  framing and the Nimbus-for-Work origin are sourced via the founder profiles
  above and corroborated by Supabase's own retrospectives. Copplestone is from
  **New Zealand**; Wilson holds an **MSc in Software Engineering from Imperial
  College London** — both per the Frederick AI profiles, **not** a primary
  Supabase bio in this pass.

### 2020 (spring) — The rebrand from "realtime Postgres" to "open-source Firebase alternative"

Supabase's pivotal moment was a repositioning, not a product change. The
project began as an open-source "**realtime Postgres**" effort that drew some
attention but little traction (reportedly only single-digit hosted databases by
late April 2020). Re-describing the project as "**an open-source alternative to
Firebase**" — roughly three months in, during the YC period — hit the front
page of Hacker News and drove a step-change in sign-ups. The "open-source
Firebase alternative" framing has been the company's positioning ever since.
- Stacksync, "One Word Changed Everything: The Origin Story of Supabase":
  https://www.stacksync.com/blog/one-word-changed-everything-the-origin-story-of-supabase
- Y Combinator company profile, "Supabase: Build in a weekend. Scale to
  millions.": https://www.ycombinator.com/companies/supabase
- **Could not verify** the precise sign-up numbers (e.g., "80 to 800
  overnight," "8 hosted databases") against a primary Supabase post in this
  pass; the rebrand narrative and approximate figures are **reported** by the
  secondary accounts above and echoed in Supabase's own telling.

### 2020 (Summer) — Y Combinator (S20)

Supabase participated in **Y Combinator's Summer 2020** batch (YC S20). The
company's own funding posts and YC profile place it in that cohort.
- Y Combinator company profile: https://www.ycombinator.com/companies/supabase
- Supabase, "Supabase $30m Series A" (recounts YC and Mozilla as early backers):
  https://supabase.com/blog/supabase-series-a

### 2020-12-15 — $6M seed round (Coatue, YC, Mozilla)

On **December 15, 2020**, Supabase announced a **$6 million** seed round **led
by Coatue**, with participation from **Y Combinator**, **Mozilla**, and roughly
20 angel investors. The round closed after YC's **August 2020** demo day.
Copplestone stressed Supabase was "not meant to be a 1-to-1 replacement" for
Firebase — built on **PostgreSQL** rather than Firebase's NoSQL model — and
noted the philosophy of standing on "well-trusted, scalable enterprise
open-source products" rather than building a new system. At the time the
platform offered Postgres plus auth, with **storage** and a **serverless**
solution in development. (Attribution: Supabase / Copplestone.)
- TechCrunch, "Supabase raises $6M for its open-source Firebase alternative"
  (Dec 15, 2020):
  https://techcrunch.com/2020/12/15/supabase-raises-6m-for-its-open-source-firebase-alternative/

### 2021-09 — $30M Series A (Coatue), at ~$36M total raised

Supabase announced a **$30 million Series A** **led by Coatue** (which
"doubled down" from the seed), bringing total funding to **~$36 million**.
TechCrunch reported the round on **September 9, 2021**; Supabase's own blog
post is dated around **October 28, 2021**. The angel/investor list reads like a
who's-who of developer-tools founders: **Tom Preston-Werner** (GitHub
co-founder), **Solomon Hykes** (Docker co-founder), **Alex Solomon** (PagerDuty
co-founder), **Guillermo Rauch** (Vercel founder), **Kurt Mackey** (Fly.io
co-founder), **Elad Gill**, and others; **Caryn Marooney** of Coatue joined the
board. Supabase reported 50,000+ databases launched and 40,000+ developers
signed up, and a team of **24** distributed worldwide ("we were born remote").
- Supabase, "Supabase $30m Series A": https://supabase.com/blog/supabase-series-a
- TechCrunch, "Open source backend-as-a-service startup Supabase raises $30M"
  (Sept 9, 2021):
  https://techcrunch.com/2021/09/09/supabase-raises-30m-for-its-open-source-insta-backend/
- **Could not verify** a single canonical announcement date — TechCrunch dates
  the report **Sept 9, 2021** while Supabase's blog post is dated **late
  October 2021**; both are cited. No valuation was disclosed for this round.

### 2022-05-10 — $80M Series B (Felicis)

On **May 10, 2022**, Supabase announced an **$80 million Series B** **led by
Felicis**, with existing investors **Coatue** and **Lightspeed** participating.
The company described Copplestone and Wilson as repeat founders running a
globally remote team, and cited 80,000+ community developers, 100,000+ databases
created, and hosted-database growth of ~1,900% year-over-year. The platform by
then spanned database, authentication, storage, and **edge functions**.
- PR Newswire, "Supabase Announces $80 Million Series B Led by Felicis"
  (May 10, 2022):
  https://www.prnewswire.com/news-releases/supabase-announces-80-million-series-b-led-by-felicis-301544453.html
- Supabase, "Supabase Series B": https://supabase.com/blog/supabase-series-b
- **Could not verify** a disclosed valuation for the Series B in this pass; the
  press release did not state one.

### 2023-02-06 — pgvector: Postgres embeddings for the AI era

On **February 6, 2023**, Supabase announced support for **`pgvector`**, the
open-source PostgreSQL extension for storing embeddings and running vector
similarity search, with a guide on storing **OpenAI** embeddings (e.g.,
`text-embedding-ada-002`) directly in Postgres. This positioned Supabase early
as a vector store for AI/RAG applications — later marketed as **Supabase
Vector** — well before the 2024–2025 "AI app builder" wave. (Postgres's broader
pgvector story is in [`postgresql.md`](./postgresql.md).)
- Supabase, "Storing OpenAI embeddings in Postgres with pgvector" (Feb 6, 2023):
  https://supabase.com/blog/openai-embeddings-postgres-vector
- Supabase Docs, "pgvector: Embeddings and vector similarity":
  https://supabase.com/docs/guides/database/extensions/pgvector

### 2024-09-25 — $80M Series C (Peak XV, Craft Ventures); AI tailwind

On **September 25, 2024**, Supabase announced an **$80 million Series C**
**co-led by Peak XV** (the Sequoia India/SEA spinoff) **and Craft Ventures**,
with **Avra Capital** and returning investors **Coatue**, **Felicis**, and
**Y Combinator**. This brought total funding to **~$196 million**. CEO
Copplestone declined to disclose a valuation but said it was an **up round**.
Supabase reported **~900,000 sign-ups** over four years, ~40% adoption among the
latest YC class, and that roughly **10% of active databases** were powering AI
use cases (via pgvector). Named users included developers at Meta, Netflix,
Microsoft, and GitHub Next.
- TechCrunch, "Supabase, a Postgres-centric developer platform, raises $80M
  Series C" (Sept 25, 2024):
  https://techcrunch.com/2024/09/25/supabase-a-postgres-centric-developer-platform-raises-80m-series-c/
- **Could not verify** an official valuation; PitchBook's post-money estimate of
  **~$765 million** for this round is **reported** by secondary coverage (cited
  in the April 2025 TechCrunch piece below), not disclosed by Supabase.

### 2025-04-22 — $200M Series D at a $2B valuation (Accel); "vibe coding" backend

On **April 22, 2025**, Supabase announced a **$200 million Series D** at a
**$2 billion** post-money valuation, **led by Accel**, with **Coatue**,
**Y Combinator**, **Craft Ventures**, and **Felicis** participating — just
**seven months** after the Series C. TechCrunch framed Supabase as "sitting in
the sweet spot for 2025's biggest trend: **vibe coding**," having become a
popular backend for AI app-builder tools such as **Lovable**, and "becoming the
default back end for AI apps," aided by its vector toolkit. Reported total
raised at this point was **~$398 million**; the community was cited at over
**1.7 million developers**.
- TechCrunch, "Vibe coding helps Supabase nab $200M at $2B valuation just seven
  months after its last raise" (Apr 22, 2025):
  https://techcrunch.com/2025/04/22/vibe-coding-helps-supabase-nab-200m-at-2b-valuation-just-seven-months-after-its-last-raise/

### 2025-05 — RLS-misconfiguration disclosures in AI-generated Supabase apps (CVE-2025-48757)

In **2025**, security researchers disclosed that large numbers of applications
built on Supabase — particularly those generated by AI app-builders like
**Lovable** — were exposing data because **Row-Level Security (RLS)** had not
been enabled. Tracked as **CVE-2025-48757**, one analysis found ~**303
endpoints across 170+ Lovable projects** (~10% of those analyzed) had Supabase
tables readable by unauthenticated requests using the public `anon` key.
**Crucially, this is a misconfiguration in apps built on Supabase, not a
vulnerability in the Supabase platform itself**: Supabase auto-generates REST
APIs from the Postgres schema, and RLS is **opt-in**, so a developer who skips
it (or whose code generator skips it) leaves the public anon key acting as a
master key. Supabase has long documented RLS as the required protection and has
published hardening guidance.
- byteiota, "Supabase Security Flaw: 170+ Apps Exposed by Missing RLS":
  https://byteiota.com/supabase-security-flaw-170-apps-exposed-by-missing-rls/
- DeepStrike, "Hacking Thousands of Misconfigured Supabase Instances at Scale":
  https://deepstrike.io/blog/hacking-thousands-of-misconfigured-supabase-instances-at-scale
- Supabase, "Supabase Security Suite / Hardening" (RLS guidance):
  https://supabase.com/blog/hardening-supabase
- **Could not verify** an exact disclosure date or the full CVE-2025-48757 detail
  against the official CVE record / a primary Lovable or Supabase advisory in
  this pass; the "170+ apps / 303 endpoints" figures are **reported** by the
  security-research write-ups above. The framing as an app-developer
  misconfiguration (not a Supabase-platform CVE) is consistent across those
  sources.

### 2025-10-03 — $100M Series E at a $5B valuation (Accel + Peak XV); Multigres

On **October 3, 2025**, Supabase announced a **$100 million Series E** at a
**$5 billion** valuation, **co-led by Accel and Peak XV**, with **Figma
Ventures** and other returning investors — roughly **four months** after the
$2B Series D, bringing total funding to **over $500 million**. Supabase cited
more than **100,000 customers** (including PwC, McDonald's, and GitHub Next) and
~**4 million developers**, and reiterated its role as a default backend for AI
tools (Lovable, Bolt, Figma, Replit, Cursor, and Claude Code per reporting).
The company said proceeds would fund **Multigres**, an enterprise-scale,
horizontally-scalable evolution of the platform, to be led by **Sugu
Sougoumarane**, co-creator of **Vitess**, whom Supabase had hired. As with
prior rounds, Supabase reserved an allocation for its **community** to co-invest.
- PR Newswire, "Supabase Raises $100M at $5B Valuation, Co-Led by Accel and
  Peak XV" (Oct 3, 2025):
  https://www.prnewswire.com/news-releases/supabase-raises-100m-at-5b-valuation-co-led-by-accel-and-peak-xv-302573153.html
- TechCrunch, "Supabase nabs $5B valuation, four months after hitting $2B"
  (Oct 3, 2025):
  https://techcrunch.com/2025/10/03/supabase-nabs-5b-valuation-four-months-after-hitting-2b/
- Supabase, "Supabase Series E": https://supabase.com/blog/supabase-series-e

---

## The architecture: composing existing open source

Supabase's distinctive strategy is **composition of existing open-source
projects** around a single Postgres instance, fronted by the **Kong** API
gateway. The core services, per Supabase's own architecture docs, include:

- **PostgreSQL** — the single database every other service talks to.
- **PostgREST** — auto-generates a REST API directly from the Postgres schema.
- **GoTrue** — JWT-based authentication / user management API.
- **Realtime** — listens to the Postgres write-ahead log (WAL) and broadcasts
  changes to subscribed clients over WebSockets.
- **Storage** — RESTful file storage (S3-backed) with permissions in Postgres.
- **Edge Functions**, **pg_meta**, and **pg_graphql** — serverless functions,
  metadata, and a GraphQL layer.

The company's stated open-source philosophy: if a suitable MIT/Apache-2-licensed
tool exists, Supabase uses and supports it (often **hiring its maintainer** and
sponsoring the project); if it doesn't exist, Supabase builds and open-sources
it. A frequently cited example is hiring the maintainer of **PostgREST** in
2020.
- Supabase Docs, "Architecture":
  https://supabase.com/docs/guides/getting-started/architecture
- Supabase, "Open Source" (community-of-communities / hiring maintainers):
  https://supabase.com/open-source
- **Could not verify** every individual maintainer-hire detail against a primary
  Supabase post in this pass (e.g., specific names/dates); the
  "hire-the-maintainer" pattern and the PostgREST example are sourced to
  Supabase's own open-source page and corroborated by secondary write-ups.

---

## Key people & teams

- **Paul Copplestone** — **Co-founder and CEO**. From **New Zealand**; began
  coding at 18; earlier worked at a hedge fund and Accenture, then co-founded
  **ServisHero** (2015, Malaysia) and **Nimbus for Work** — the latter being
  where the Firebase-limitation experience that seeded Supabase occurred.
  Remains CEO through the AI era.
  - Frederick AI, "Founder Story: Paul Copplestone":
    https://www.frederick.ai/blog/paul-copplestone-supabase
- **Ant Wilson** — **Co-founder and CTO**. Holds an **MSc in Software
  Engineering from Imperial College London**; a repeat (venture-backed) founder
  before Supabase; drives the platform's technical direction (instant Postgres,
  auth, RLS, realtime, auto-generated APIs).
  - Frederick AI, "Founder Story: Ant Wilson":
    https://www.frederick.ai/blog/ant-wilson-supabase
- **Sugu Sougoumarane** — co-creator of **Vitess** (the horizontal-scaling
  layer that grew out of YouTube/PlanetScale), **hired by Supabase** to lead
  **Multigres** (announced with the Oct 2025 Series E).
  - PR Newswire (Series E):
    https://www.prnewswire.com/news-releases/supabase-raises-100m-at-5b-valuation-co-led-by-accel-and-peak-xv-302573153.html

---

## Company & corporate history

- **Jan 2020** — **Supabase founded** by **Paul Copplestone** (CEO) and **Ant
  Wilson** (CTO); origin in Firebase/Firestore limits at Nimbus for Work.
  [Frederick AI](https://www.frederick.ai/blog/paul-copplestone-supabase)
- **Spring 2020** — rebrand from "realtime Postgres" to **"open-source Firebase
  alternative"**; Hacker News breakout.
  [Stacksync](https://www.stacksync.com/blog/one-word-changed-everything-the-origin-story-of-supabase)
- **Summer 2020** — **Y Combinator (S20)**.
  [YC](https://www.ycombinator.com/companies/supabase)
- **Dec 15, 2020** — **$6M seed** (Coatue, YC, Mozilla).
  [TechCrunch](https://techcrunch.com/2020/12/15/supabase-raises-6m-for-its-open-source-firebase-alternative/)
- **Sept 2021** — **$30M Series A** (Coatue); ~$36M total.
  [Supabase](https://supabase.com/blog/supabase-series-a) ·
  [TechCrunch](https://techcrunch.com/2021/09/09/supabase-raises-30m-for-its-open-source-insta-backend/)
- **May 10, 2022** — **$80M Series B** (Felicis).
  [PR Newswire](https://www.prnewswire.com/news-releases/supabase-announces-80-million-series-b-led-by-felicis-301544453.html)
- **Feb 6, 2023** — **pgvector** support (AI/embeddings).
  [Supabase](https://supabase.com/blog/openai-embeddings-postgres-vector)
- **Sept 25, 2024** — **$80M Series C** (Peak XV + Craft); ~$196M total; up round.
  [TechCrunch](https://techcrunch.com/2024/09/25/supabase-a-postgres-centric-developer-platform-raises-80m-series-c/)
- **Apr 22, 2025** — **$200M Series D** at **$2B** (Accel); "vibe coding" backend.
  [TechCrunch](https://techcrunch.com/2025/04/22/vibe-coding-helps-supabase-nab-200m-at-2b-valuation-just-seven-months-after-its-last-raise/)
- **2025** — RLS-misconfiguration disclosures (CVE-2025-48757) in AI-generated
  Supabase/Lovable apps (an app-config issue, not a platform CVE).
  [byteiota](https://byteiota.com/supabase-security-flaw-170-apps-exposed-by-missing-rls/)
- **Oct 3, 2025** — **$100M Series E** at **$5B** (Accel + Peak XV); >$500M total;
  **Multigres** announced.
  [PR Newswire](https://www.prnewswire.com/news-releases/supabase-raises-100m-at-5b-valuation-co-led-by-accel-and-peak-xv-302573153.html) ·
  [TechCrunch](https://techcrunch.com/2025/10/03/supabase-nabs-5b-valuation-four-months-after-hitting-2b/)

**Funding ladder (verified):** Seed $6M (Dec 2020) → Series A $30M (Sept 2021)
→ Series B $80M (May 2022) → Series C $80M (Sept 2024) → Series D $200M @ $2B
(Apr 2025) → Series E $100M @ $5B (Oct 2025). Disclosed valuations begin only at
the Series D; the Series C valuation (PitchBook ~$765M) is **reported**, not
disclosed.

---

## Controversies & tensions

> Each item separates **established fact** from **reported claim /
> characterization**, with attribution.

### 1. "Firebase alternative" positioning vs. "not a 1-to-1 replacement"

- **Fact:** Supabase's breakout came from explicitly branding itself "an
  open-source alternative to Firebase," yet Copplestone simultaneously cautioned
  it was "**not meant to be a 1-to-1 replacement**" (Postgres/SQL vs. Firebase's
  NoSQL). The tension between an aggressive comparative tagline and a different
  underlying data model is woven through its history.
  - [TechCrunch (seed)](https://techcrunch.com/2020/12/15/supabase-raises-6m-for-its-open-source-firebase-alternative/) ·
    [Stacksync origin story](https://www.stacksync.com/blog/one-word-changed-everything-the-origin-story-of-supabase)

### 2. Opt-in Row-Level Security and the AI-codegen exposure wave

- **Fact / reported:** Because Supabase auto-exposes a REST API from the schema
  with a **public anon key**, and **RLS is opt-in**, many apps — especially
  those generated by AI app-builders like **Lovable** — shipped with tables
  readable by anyone (tracked as **CVE-2025-48757**; ~170+ apps / ~303 endpoints
  per researchers). This is consistently characterized as an **app-developer /
  code-generator misconfiguration**, not a flaw in the Supabase platform.
  - [byteiota](https://byteiota.com/supabase-security-flaw-170-apps-exposed-by-missing-rls/) ·
    [DeepStrike](https://deepstrike.io/blog/hacking-thousands-of-misconfigured-supabase-instances-at-scale) ·
    [Supabase hardening](https://supabase.com/blog/hardening-supabase)
- **Could not verify** exact figures / disclosure dates against the primary CVE
  record in this pass — treat the counts as **reported**.

### 3. Rapid, compressed up-rounds during the AI hype cycle

- **Fact:** Supabase raised Series D ($2B) and Series E ($5B) only **~4 months
  apart** in 2025 — a **150% valuation jump** — explicitly riding the
  AI-app-builder / "vibe coding" wave. Whether such valuations are durable is an
  open question raised by observers, not a settled fact.
  - [TechCrunch (Series E)](https://techcrunch.com/2025/10/03/supabase-nabs-5b-valuation-four-months-after-hitting-2b/)

---

## Items marked "Could not verify"

- **Exact founding date / incorporation** — "early 2020 / January 2020" is
  sourced via founder profiles and retrospectives, not a primary incorporation
  document. Copplestone (New Zealand) and Wilson (Imperial College MSc)
  biographical details are from the Frederick AI profiles, not a primary
  Supabase bio.
- **Early sign-up / hosted-database numbers** around the 2020 rebrand
  ("80→800," "8 databases") — **reported** by secondary origin-story accounts.
- **Series A announcement date** — TechCrunch (Sept 9, 2021) and Supabase's blog
  (late Oct 2021) differ; both cited.
- **Series B and Series C valuations** — not disclosed by Supabase; the Series C
  ~$765M figure is a **PitchBook estimate** reported by TechCrunch.
- **CVE-2025-48757 details** (count of affected apps/endpoints, exact disclosure
  date) — **reported** by security-research write-ups; the official CVE record /
  a primary Supabase or Lovable advisory was not fetched in this pass. The
  characterization as an app-misconfiguration (not a platform CVE) is consistent
  across sources.
- **Maintainer-hire specifics** (individual names/dates beyond the PostgREST
  example) — the general pattern is sourced to Supabase's open-source page;
  individual details were not each pinned to a primary post.
