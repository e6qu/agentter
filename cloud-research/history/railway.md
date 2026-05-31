# Railway: A Sourced History

A chronological, fully-sourced history of **Railway** (railway.com, originally
railway.app) — the developer-focused deployment platform founded in 2020 that
positioned itself as a modern, high-DX successor to Heroku, built its own build
system (**Nixpacks**, later **Railpack**), abandoned a perpetual free tier in
2023, walked away from Google Cloud to **build its own bare-metal data centers**,
and reframed itself in 2026 as an "AI-native"/"agent-native" cloud.

Every non-trivial claim below carries a working source link. Primary sources
(Railway's own blog/changelog, funding press releases, the founder's posts) are
preferred, with reputable outlets (TechCrunch, VentureBeat, Axios, SiliconANGLE)
as corroboration. Where a detail could not be confirmed against a primary or
reputable secondary source, it is flagged with **Could not verify:**.
Controversies and opinions are attributed to their sources, with fact separated
from reported claim.

---

## Timeline

### 2020 — Founding

- **2020 — Railway founded by Jake Cooper.** Railway's own Series A announcement
  and its press materials date the company's founding to **2020**, with **Jake
  Cooper** as founder and CEO. Multiple independent profiles concur on the 2020
  date and on Cooper as the founder.
  - Source (Railway's own Series A post): [Railway raises $20M to radically simplify building software — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)
  - Source: [Railway snags $20M to streamline the process of deploying apps and services — TechCrunch (May 31, 2022)](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/)
  - Source: [Railway Business Breakdown & Founding Story — Contrary Research](https://research.contrary.com/company/railway)
  - **Could not verify** an exact founding *month/day*. Contrary Research records
    it as "Jun 2020," but a first-party Railway document pinning the precise date
    was not located — treat the month as **secondary-sourced**.

- **The "Y Combinator Winter 2020" claim — not supported.** The research brief
  asserted Railway went through **Y Combinator's Winter 2020 (W20)** batch. This
  could **not** be verified and appears to be incorrect. Railway's own funding
  history names its early backers as **pre-seed lead Lachy Groom (LGF)** and
  **seed lead Unusual Ventures** — not Y Combinator — and neither TechCrunch's
  coverage, Railway's Series A post, nor the Contrary Research profile mentions YC.
  A direct fetch of `ycombinator.com/companies/railway` returned **HTTP 404** (no
  YC company profile for Railway). **Could not verify: Railway as a Y Combinator
  W20 company** — the available evidence indicates it was **not** YC-backed.
  - Source (early backers were Lachy Groom + Unusual Ventures, not YC): [Railway raises $20M ... — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)
  - Source (no YC profile resolves): `https://www.ycombinator.com/companies/railway` returned 404 on fetch (May 2026).

- **Jake Cooper's background.** Per the Contrary Research profile, Cooper learned
  to code at 13 (C++, then Visual Basic and jQuery), studied engineering at the
  **University of Victoria**, "worked remotely for **Wolfram** for two years"
  improving developer experience (linting, Docker, CI), and later worked at
  **Uber** "on scaling the app's infrastructure for Jump bikes and scooters"
  before that division was sold to **Lime**. TechCrunch and other profiles also
  list **Bloomberg** among his prior employers.
  - Source: [Railway Business Breakdown & Founding Story — Contrary Research](https://research.contrary.com/company/railway)
  - Source (Bloomberg/Uber background): [TechCrunch (May 31, 2022)](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/)
  - **Could not verify** a complete list of **co-founders**. Railway's public
    materials and press consistently foreground Jake Cooper as founder/CEO and
    reference a "founding team," but no source located names additional
    co-founders. Treat Railway as effectively **Cooper-founded** absent a
    first-party co-founder list.

### 2020–2022 — The "Heroku heir" positioning and product

- **The product thesis: deployment without infrastructure expertise.** Railway's
  founding pitch was that "building software should feel like magic" but had
  become buried under "layers of abstractions and configuration files," requiring
  Kubernetes/Terraform expertise just to ship. Railway aimed to let developers
  deploy code and manage infrastructure "without writing YAML or managing
  servers," with a visual **canvas** for services and automated infrastructure
  reconciliation.
  - Source: [Railway raises $20M ... — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)

- **Explicit Heroku positioning.** Railway framed itself against Heroku from the
  start: in its Series A post it described its target as combining Heroku's
  simplicity with Kubernetes' power and Terraform's reproducibility — "simple and
  intuitive to use like Heroku" but more flexible. Contrary Research's profile
  describes Heroku as having "not made much progress" since Salesforce's 2010
  acquisition, with "many customers [having] switched to other platforms, like
  Railway."
  - Source: [Railway raises $20M ... — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)
  - Source: [Railway Business Breakdown & Founding Story — Contrary Research](https://research.contrary.com/company/railway)
  - **Attribution:** the "Heroku is stagnating / Railway is the heir" framing is
    **positioning and analysis** (Railway's own and Contrary's), not a neutral
    fact. (For Heroku's own trajectory and free-tier removal, see
    `history/heroku.md`.)

- **Early hand-built traction.** Railway is widely reported to have grown its
  first users by hand — the founder personally greeting Discord signups — and to
  have reached scale with minimal marketing spend. At the Series A, Railway cited
  **50,000+ developers** and **900,000+ projects launched**, with rapid month-
  over-month growth.
  - Source: [Railway raises $20M ... — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)
  - **Could not verify** the specific "Jake greeted every Discord signup on a
    second monitor" anecdote against a primary source; it appears in secondary
    retellings and is flagged as **reported color**, not first-party-confirmed.

### April 2022 — Nixpacks, Railway's own build system

- **April 1, 2022 — Nixpacks announced.** In **Changelog #0075**, Railway
  introduced **Nixpacks**, "a new reproducible build system for Railway with Rust
  and Nix." Railway's own framing: "Nixpacks is the start to have a build system
  that is predictable, reliable, and buzzword compliant." Railway also announced
  it on X the same day ("Introducing a new build system built with Rust and
  Nix"). Nixpacks takes a source directory and produces an OCI-compliant Docker
  image, pulling system/language dependencies from the **Nix** ecosystem — pitched
  as an alternative to Heroku-style **Buildpacks**.
  - Source: [Changelog #0075 — Introducing Nixpacks (April 1, 2022) — Railway](https://railway.com/changelog/2022-04-01)
  - Source (announcement tweet, dated Mar 31/Apr 1, 2022): [Railway on X — "Introducing a new build system built with Rust and Nix. Changelog #0075"](https://x.com/railway/status/1510061849403875330)
  - Source (project): [railwayapp/nixpacks — GitHub](https://github.com/railwayapp/nixpacks)
  - Nixpacks became Railway's default builder. By 2025 Railway said Nixpacks had
    built "**over 14 million apps**."
    - Source: [Why We're Moving on From Nix — Railway Blog (Mar 4, 2025)](https://blog.railway.com/p/introducing-railpack)

### May 2022 — Series A ($20M, Redpoint)

- **May 31, 2022 — Series A: $20M, led by Redpoint Ventures.** Railway announced a
  **$20 million Series A led by Redpoint Ventures** (Erica Brescia and Jordan
  Segall), bringing total raised to roughly **$24–25 million**. The round
  included **seed lead Unusual Ventures** and **pre-seed lead Lachy Groom (LGF)**,
  plus angels including **Guillermo Rauch** (Vercel CEO), **Tom Preston-Werner**
  (GitHub co-founder), **Calvin French-Owen** (Segment), and **Olivier Pomel**
  (Datadog). TechCrunch reported the team was about **8 people** at the time, with
  plans to grow to 12–15 by year-end.
  - Source (primary): [Railway raises $20M ... — Railway Blog (May 31, 2022)](https://blog.railway.com/p/series-a)
  - Source: [TechCrunch (May 31, 2022)](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/)
  - **Could not verify** a disclosed **valuation** for the Series A; none was
    reported. The "~$24M total / ~$25M total" figures vary slightly between
    TechCrunch ($24M) and the Railway post ("nearly $25M") — both are cited.

### June–August 2023 — End of the perpetual free tier

This is an important inflection point and drew significant Hacker News / community
discussion, echoing Heroku's own 2022 free-tier removal.

- **June 2, 2023 (announced) — Railway removes no-strings free compute,
  introduces the "$5 Plan."** In a post by **Jacob (Jake) Cooper**, Railway
  announced it would discontinue perpetual free compute: "**We're just not gonna
  do no-strings-attached-free compute anymore.**" Under the new model, "by
  default, Railway will cost **$5 per month**," with a **one-time $5 free credit**
  for initial trials, **$0.10/GB network egress**, and usage-based pricing above a
  baseline ("a generous baseline amount of usage, and above that, you just pay for
  what you use").
  - Source (primary): [Introducing the $5 Plan — Railway Blog (Jun 2, 2023)](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)

- **Effective dates.** The new pricing **launched July 3, 2023**, with **existing
  users migrated on August 1, 2023** — i.e., the perpetual free tier effectively
  ended for existing accounts in **August 2023**. The plan structure was
  restructured into **Trial / Hobby ($5/mo) / Pro ($20/mo)** (formerly
  Starter/Developer/Teams), and Railway began **requiring a credit card** to sign
  up.
  - Source (primary, dates): [Introducing the $5 Plan — Railway Blog (Jun 2, 2023)](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)
  - Source (plan rename / current structure): [Pricing Plans — Railway Docs](https://docs.railway.com/reference/pricing/plans)
  - Source (free-trial / $5-credit model today): [Free Trial — Railway Docs](https://docs.railway.com/reference/pricing/free-trial)

- **Stated reason: abuse.** Railway attributed the change largely to abuse of free
  compute — citing **cryptocurrency miners** and **torrent aggregators** straining
  infrastructure, and "a deluge of 'why no verify?!?'" support load from bad
  actors on freshly created GitHub accounts.
  - Source: [Introducing the $5 Plan — Railway Blog (Jun 2, 2023)](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)
  - **Attribution / context:** This closely parallels Heroku's August 2022
    free-plan removal, which also cited "fraud and abuse" (see `history/heroku.md`).
    The Railway change drew community/HN discussion at the time; the specific
    threads are **reported** rather than catalogued here.

### 2024–2025 — Leaving Google Cloud for its own metal

- **January 2024 — the "Railway Metal" project begins.** Railway began building
  its **own bare-metal data centers**, abandoning **Google Cloud Platform**.
  Railway's engineering write-up (by **Charith Amarasinghe**, Jan 17, 2025) is
  blunt about why: GCP "caused a multitude of problems that have posed an
  **existential risk to our business**," it "directly affected the pricing we
  could offer (**egress fees** anyone?)," and — despite "multi-million dollar
  annual spend" — "we get about as much support from them as you would spending
  $100."
  - Source (primary): [So You Want to Build Your Own Data Center — Railway Blog (Jan 17, 2025)](https://blog.railway.com/p/data-center-build-part-one)
  - Reported build timeline: project kickoff **January 2024**; first servers
    plugged in ~**May 2024** (≈5 months later); comfortable putting users on the
    hardware by ~**August 2024** (≈3 more months); public disclosure January 2025.
    - Source: [So You Want to Build Your Own Data Center — Railway Blog (Jan 17, 2025)](https://blog.railway.com/p/data-center-build-part-one)

- **September 20, 2024 — Railway Metal beta.** Railway opened its own hardware to
  users in beta (Changelog #0204), with "Railway Metal" documented as hardware
  Railway "owns and operates in datacenters around the world," enabling lower
  prices and features such as Static Inbound IPs, an Anycast Edge Network, and
  High-Availability Volumes.
  - Source: [Changelog #0204 — Railway Metal beta (Sep 20, 2024) — Railway](https://railway.com/changelog/2024-09-20-railway-metal-beta)
  - Source: [Railway Metal — Railway Docs](https://docs.railway.com/platform/railway-metal)

- **March 21, 2025 — "Zero-Touch Bare Metal at Scale."** A follow-up engineering
  post (Charith Amarasinghe) detailed Railway's in-house provisioning tooling —
  **MetalCP** and **Railyard** — using Redfish BMC APIs, PXE netbooting
  (Pixiecore), BGP-unnumbered L3 fabric (FRR), and even Claude's vision API to
  read server-console screenshots and drive OS installs autonomously ("less than a
  dollar to provision 50 servers").
  - Source: [Zero-Touch Bare Metal at Scale — Railway Blog (Mar 21, 2025)](https://blog.railway.com/p/data-center-build-part-two)

### March 2025 — Railpack succeeds Nixpacks

- **March 4, 2025 — Railpack announced (moving on from Nix).** In "Why We're
  Moving on From Nix" (by **Jake Runzer**), Railway introduced **Railpack**, a new
  builder written in **Go** atop **BuildKit (LLB/Frontend)**, to replace Nixpacks.
  Railway cited Nix's **commit-based versioning** (only the latest major version
  of a package available; version bumps forced unrelated packages to move, breaking
  builds) and Nix's monolithic `/nix/store` layer (poor caching, large images) as
  motivations. Railpack targets granular major.minor.patch versioning, smaller
  images, and better caching — framed around scaling Railway's user base "**from
  1M to 100M**."
  - Source (primary): [Why We're Moving on From Nix — Railway Blog (Mar 4, 2025)](https://blog.railway.com/p/introducing-railpack)
  - Source (docs): [Railpack — Railway Docs](https://docs.railway.com/reference/nixpacks)
  - **Could not verify** the exact general-availability date of Railpack beyond
    the March 4, 2025 announcement; secondary sources reference a later "beta"
    framing, but the primary GA date was not pinned here.

### January 2026 — Series B ($100M) and the "AI-native cloud" reframe

- **January 22, 2026 — Series B: $100M, led by TQ Ventures.** Railway announced a
  **$100 million Series B led by TQ Ventures**, with participation from **FPV
  Ventures**, **Redpoint**, and **Unusual Ventures**. The press release cited
  **2 million+ users** (growing ~**200,000 developers/month**), **31% of the
  Fortune 500**, and "**176x revenue growth**." Funds were earmarked for
  **expanding its global data-center footprint**, growing the team, and building
  AI/developer tooling. Founder/CEO Jake Cooper framed the moment around AI-driven
  code generation: "As AI models get better at writing code, more and more people
  are asking the age-old question; where, and how, do I run my applications?"
  - Source (primary press release): [Railway Raises $100 Million Series B ... — PR Newswire (Jan 22, 2026)](https://www.prnewswire.com/news-releases/railway-raises-100-million-series-b-as-ai-pushes-todays-cloud-infrastructure-past-its-limits-302667768.html)
  - Source: [Railway secures $100 million to challenge AWS with AI-native cloud infrastructure — VentureBeat (Jan 22, 2026)](https://venturebeat.com/infrastructure/railway-secures-usd100-million-to-challenge-aws-with-ai-native-cloud)
  - Source: [Software deployment platform Railway raises $100M — Axios (Jan 22, 2026)](https://www.axios.com/pro/enterprise-software-deals/2026/01/22/software-deployment-railway-100-million)
  - Source: [Intelligent cloud infrastructure startup Railway gets $100M ... — SiliconANGLE (Jan 22, 2026)](https://siliconangle.com/2026/01/22/intelligent-cloud-infrastructure-startup-railway-gets-100m-simplify-application-deployment/)
  - **Could not verify** a disclosed **post-money valuation** for the Series B;
    none was reported in the primary sources. VentureBeat-adjacent coverage cited
    ARR "exceeds $10 million" as a founder remark — treat that ARR figure as
    **reported**, not press-release-confirmed.
  - **Note on framing:** the "AI-native / agent-native cloud" and "challenge AWS"
    framing is **positioning** (Railway's and the outlets'), not a neutral
    capability claim.

---

## Technology (Nixpacks / Railpack / Railway Metal)

Sourced to Railway's own changelog, blog, and docs.

- **Build system: Nixpacks → Railpack.** Railway's differentiator on the build
  side was **Nixpacks** (Rust + Nix, 2022), which turned source directories into
  OCI images with minimal config, as an alternative to Buildpacks; it built 14M+
  apps before Railway replaced it with **Railpack** (Go + BuildKit, 2025) to fix
  Nix's versioning and caching limits.
  - Sources: [Changelog #0075 (Apr 1, 2022)](https://railway.com/changelog/2022-04-01);
    [Why We're Moving on From Nix (Mar 4, 2025)](https://blog.railway.com/p/introducing-railpack)

- **Infrastructure: GCP → Railway Metal.** Railway began on **Google Cloud** and,
  from January 2024, built and migrated onto **its own bare-metal data centers**
  ("Railway Metal"), citing GCP egress fees, pricing constraints, and weak support
  as existential risks. Its in-house tooling (MetalCP, Railyard) automates
  zero-touch bare-metal provisioning.
  - Sources: [Build Your Own Data Center, Part One (Jan 17, 2025)](https://blog.railway.com/p/data-center-build-part-one);
    [Zero-Touch Bare Metal at Scale (Mar 21, 2025)](https://blog.railway.com/p/data-center-build-part-two);
    [Railway Metal — Docs](https://docs.railway.com/platform/railway-metal)

---

## Key people & teams

- **Jake Cooper** (a.k.a. "Jacob Cooper," @JustJake) — **founder and CEO**.
  Prior background includes **Wolfram**, **Bloomberg**, and **Uber** (Jump
  bikes/scooters infrastructure). Authored the 2023 "$5 Plan" free-tier-removal
  post and is the public face of Railway's product and fundraising.
  - Sources: [Railway raises $20M ... (May 31, 2022)](https://blog.railway.com/p/series-a);
    [TechCrunch (May 31, 2022)](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/);
    [Contrary Research](https://research.contrary.com/company/railway);
    [Introducing the $5 Plan (Jun 2, 2023)](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)
  - **Could not verify** any **co-founders**; no source located names additional
    founders.

- **Charith Amarasinghe** — Railway engineer; author of the two-part "Build Your
  Own Data Center" engineering write-ups documenting the Railway Metal buildout.
  - Sources: [Part One (Jan 17, 2025)](https://blog.railway.com/p/data-center-build-part-one);
    [Part Two (Mar 21, 2025)](https://blog.railway.com/p/data-center-build-part-two)

- **Jake Runzer** — Railway engineer; author of the Railpack ("Why We're Moving on
  From Nix") announcement.
  - Source: [Why We're Moving on From Nix (Mar 4, 2025)](https://blog.railway.com/p/introducing-railpack)

- **Notable investors / backers** (not employees): **Redpoint Ventures** (Erica
  Brescia, Jordan Segall — Series A lead), **Unusual Ventures** (seed lead),
  **Lachy Groom / LGF** (pre-seed lead), **TQ Ventures** (Series B lead), **FPV
  Ventures**; angels **Guillermo Rauch** (Vercel), **Tom Preston-Werner**
  (GitHub), **Calvin French-Owen** (Segment), **Olivier Pomel** (Datadog).
  - Sources: [Railway raises $20M ... (May 31, 2022)](https://blog.railway.com/p/series-a);
    [PR Newswire (Jan 22, 2026)](https://www.prnewswire.com/news-releases/railway-raises-100-million-series-b-as-ai-pushes-todays-cloud-infrastructure-past-its-limits-302667768.html)

---

## Company & corporate history

- **2020** — Founded by **Jake Cooper** as a high-DX deployment platform; explicit
  "modern Heroku" positioning.
  [Series A post](https://blog.railway.com/p/series-a) ·
  [TechCrunch](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/)
- **April 1, 2022** — **Nixpacks** (Rust + Nix build system) announced.
  [Changelog #0075](https://railway.com/changelog/2022-04-01)
- **May 31, 2022** — **Series A: $20M led by Redpoint** (seed: Unusual; pre-seed:
  Lachy Groom); ~$24–25M total raised; ~8 staff.
  [Series A post](https://blog.railway.com/p/series-a) ·
  [TechCrunch](https://techcrunch.com/2022/05/31/railway-snags-20m-to-streamline-the-process-of-deploying-apps-and-services/)
- **June–August 2023** — **Perpetual free tier removed**; "$5 Plan" / usage-based
  pricing introduced (announced Jun 2, 2023; launched Jul 3; existing users
  migrated Aug 1, 2023); credit card required; cited abuse (crypto miners,
  torrents).
  [Introducing the $5 Plan](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)
- **January 2024 → 2025** — **Railway Metal**: abandons Google Cloud to build its
  own bare-metal data centers (beta Sep 20, 2024; engineering posts Jan & Mar 2025).
  [Part One](https://blog.railway.com/p/data-center-build-part-one) ·
  [Metal beta changelog](https://railway.com/changelog/2024-09-20-railway-metal-beta)
- **March 4, 2025** — **Railpack** (Go + BuildKit) announced to replace Nixpacks.
  [Why We're Moving on From Nix](https://blog.railway.com/p/introducing-railpack)
- **January 22, 2026** — **Series B: $100M led by TQ Ventures**; reframed as an
  "AI-native cloud"; cited 2M+ users, 31% of the Fortune 500, 176x revenue growth.
  [PR Newswire](https://www.prnewswire.com/news-releases/railway-raises-100-million-series-b-as-ai-pushes-todays-cloud-infrastructure-past-its-limits-302667768.html) ·
  [VentureBeat](https://venturebeat.com/infrastructure/railway-secures-usd100-million-to-challenge-aws-with-ai-native-cloud)

---

## Controversies & context

> Each item separates **established/admitted fact** from **reported claim /
> characterization**, with attribution.

### 1. Removal of the perpetual free tier (2023)

- **Fact (per Railway):** Railway ended no-strings free compute, introducing a
  $5/month baseline plan and usage-based pricing (announced Jun 2, 2023; launched
  Jul 3; existing users migrated Aug 1, 2023), and began requiring a credit card,
  citing abuse (crypto miners, torrent aggregators).
  [Introducing the $5 Plan](https://blog.railway.com/p/introducing-trial-hobby-pro-plans)
- **Reported context/characterization:** The move mirrored Heroku's own 2022
  free-plan removal (also blamed on "fraud and abuse") and was a notable moment
  for free-PaaS expectations; the change drew community discussion. The parallel
  is an observation (cross-ref `history/heroku.md`), and the community reaction is
  **reported**, not catalogued from a single primary thread here.

### 2. Leaving Google Cloud (2024–2025)

- **Fact (per Railway):** Railway publicly stated GCP posed an "existential risk,"
  forced higher prices via egress fees, and provided poor support despite
  multi-million-dollar spend — and that it therefore built its own data centers.
  [Build Your Own Data Center, Part One (Jan 17, 2025)](https://blog.railway.com/p/data-center-build-part-one)
- **Reported claim/characterization:** Railway's hyperscaler critique is its own
  framing; the broader "upstart cloud beating the hyperscalers on speed/price"
  narrative is carried by trade press and is **opinion/positioning**, not
  independently audited fact.

### 3. The "AI-native cloud / challenge to AWS" framing (2026)

- **Fact:** Railway raised a **$100M Series B (TQ Ventures-led, Jan 22, 2026)** and
  publicly repositioned around AI-driven deployment.
  [PR Newswire](https://www.prnewswire.com/news-releases/railway-raises-100-million-series-b-as-ai-pushes-todays-cloud-infrastructure-past-its-limits-302667768.html)
- **Reported claim/characterization:** "AI-native," "agent-native," and
  "challenge AWS" are **marketing/positioning** language (Railway's and headline
  writers'), not neutral capability assessments.

---

## Items marked "Could not verify"

- **Y Combinator Winter 2020 (W20) participation** — **not supported**. Railway's
  early backers were pre-seed lead **Lachy Groom** and seed lead **Unusual
  Ventures** (not YC); no YC company profile resolves for Railway
  (`ycombinator.com/companies/railway` → HTTP 404). The brief's "YC W2020" claim
  appears to be **incorrect**.
- **Exact founding month/day in 2020** — the year 2020 is well-sourced; "Jun 2020"
  comes from a secondary profile (Contrary Research), not a first-party document.
- **Co-founder names** — no source located names co-founders beyond Jake Cooper;
  Railway is treated as effectively Cooper-founded.
- **Series A and Series B valuations** — not disclosed in primary sources; the
  "~$10M ARR" remark around the Series B is **reported**, not press-release-
  confirmed.
- **The "greeted every Discord signup on a second monitor" anecdote** — secondary
  color, not first-party-confirmed.
- **Railpack general-availability date** — only the Mar 4, 2025 announcement is
  pinned; a separate GA date was not confirmed.
- **The "$24M vs ~$25M total raised" discrepancy** at Series A — TechCrunch says
  $24M, Railway says "nearly $25M"; both are cited rather than reconciled.
