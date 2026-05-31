# Porter (porter.run) — A Sourced History

A chronological, sourced history of **Porter**, the Y Combinator–backed
platform-as-a-service (PaaS) that pitches a **Heroku-like deployment experience
that runs inside the customer's own AWS, Google Cloud, or Azure account** —
provisioning and managing the underlying **Kubernetes** infrastructure on the
user's behalf so teams get Heroku-style convenience without the lock-in of a
single managed host.

This is a smaller, privately held company than some other entries in this
corpus, and public primary sourcing is correspondingly thinner. Every
non-trivial claim below carries a working source link, with primary sources
(Porter's own blog and the YC profile, the founders' posts, the lead investor's
announcement) preferred and reputable outlets (TechCrunch) used for
corroboration. Where a detail could not be confirmed it is explicitly flagged
**Could not verify:**. Opinions and characterizations are attributed to their
sources.

> **Note on the founders.** The research brief named "Justin Rhee and Trevor
> Shim." Both are confirmed co-founders, but the sources locate a **third**
> co-founder: **Alexander Belanger** (later co-founder & CTO; he subsequently
> left to found Hatchet). All three are documented below. The YC company page,
> however, lists only Justin Rhee and Trevor as the founders shown on the
> profile.

---

## Timeline

### 2020 — Founding and Y Combinator (Summer 2020)

- **Founded 2020; Y Combinator Summer 2020 (S20) batch.** Porter's Y Combinator
  company profile lists a **2020** founding year, the **Summer 2020** batch, a
  **New York** location, and the founders **Justin Rhee** and **Trevor**
  (Shim), both titled "Founder."
  - Source: [Porter — Y Combinator company profile](https://www.ycombinator.com/companies/porter)

- **Three co-founders, including Alexander Belanger.** TechCrunch's 2021 profile
  names the founding team as **Trevor Shim, Alexander Belanger, and Justin
  Rhee**, and notes the founders were "well versed in doing remote development
  on Kubernetes" before building the company.
  - Source: [Platform as a service startup Porter aims to become go-to for deploying, managing cloud-based apps — TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)
  - Belanger's role is independently confirmed by Hatchet's later YC profile,
    which describes him as "Co-founder & CEO at Hatchet (W24), previously
    co-founder & CTO at Porter (S20)."
    - Source: [Hatchet — Y Combinator company profile](https://www.ycombinator.com/companies/hatchet-run)

- **Founders' backgrounds (as reported).** Secondary profiles describe **Trevor
  Shim** as a Yale graduate (Intensive Physics & Computer Science) who had been
  a researcher at the **MIT Computer Science and Artificial Intelligence
  Laboratory**, and **Alexander Belanger** as holding a Master's in Physics from
  the University of Pennsylvania.
  - Sources: [Trevor Shim — Crunchbase person profile](https://www.crunchbase.com/person/trevor-shim-7203);
    [Alexander Belanger — No Cap Blog founder profile](https://nocap.blog/founder/alexander-belanger/)
  - **Could not verify** these biographical details against first-party
    (founder-authored) sources; they are presented as **reported**.

### The product thesis — Heroku-like, but in your own cloud, on Kubernetes

- **What Porter is.** Porter positions itself as "the easiest way to deploy and
  scale your applications on AWS, Azure, and GCP. Connect your own cloud
  account, and Porter will provision and manage the underlying infrastructure
  for you — simply point at your repository and Porter will handle the rest,
  from building your application to autoscaling it." It is, in effect, a PaaS
  operating inside customers' own cloud accounts, built on Kubernetes.
  - Source: [Porter — Y Combinator company profile](https://www.ycombinator.com/companies/porter)

- **Explicitly a "successor to Heroku."** TechCrunch quotes co-founder **Trevor
  Shim**: "So we see ourselves as a successor to Heroku." The same article
  describes Porter as delivering "the full flexibility of Kubernetes through a
  Heroku-like interface," with applications running in the user's own cloud
  account so customers "pay only via their existing cloud credits."
  - Source: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)
  - Venrock partner **Ethan Batraski** is quoted framing the opportunity against
    Heroku: "Heroku has 100,000 developers, but I believe it has stagnated.
    Porter already has 100 startups on its platform," adding that Porter "can
    turn every developer into an expert devops without them knowing it."
    - Source: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)

### 2020–2021 — Pivot from "Porter Dev," open-source launch

- **Original idea was remote development environments ("Porter Dev").** In a
  founder-authored retrospective ("Our Journey Building Porter," by Justin Rhee,
  dated **July 30, 2021**), Rhee writes that the team first built "Porter Dev,"
  letting "teams run development services on a remote cluster that would
  automatically sync to any local file changes." Finding enterprise sales cycles
  too slow, they pivoted to **production deployments** aimed at startups
  struggling with Kubernetes complexity — offering "the full flexibility of
  Kubernetes through a Heroku-like experience that anyone can use."
  - Source: [Our Journey Building Porter — Justin Rhee, Porter blog (Jul 30, 2021)](https://porter.run/blog/our-journey-building-porter/)

- **Open-source launch.** Per the same post, Porter launched as **open source on
  GitHub** (the `porter-dev/porter` repository), building an open-source
  community alongside a hosted dashboard, with a launch on **Product Hunt
  (March 2021)** and **Hacker News (April 2021)**. TechCrunch reported the
  platform "launched in February 2021" and became one of GitHub's fastest-growing
  open-source downloads within six months.
  - Sources: [Our Journey Building Porter — Porter blog (Jul 30, 2021)](https://porter.run/blog/our-journey-building-porter/);
    [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)
  - **Could not verify:** the original `porter-dev/porter` open-source
    repository no longer resolves at that path (GitHub returns **404** as of
    this research pass), and its license/history could not be re-read directly;
    the `porter-dev` GitHub organization still hosts many supporting repos
    (charts, CLI actions, getting-started examples). The exact "launched
    February 2021" vs. "Product Hunt March / Hacker News April 2021" dates come
    from TechCrunch and the founder retrospective respectively and are not
    further reconciled here.

### July 2021 — Seed round ($1.5M)

- **Porter raised a $1.5M seed round**, announced **July 30, 2021**, from
  **Venrock, Translink Capital, Soma Capital**, Y Combinator, and several angel
  investors.
  - Sources: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/);
    [Our Journey Building Porter — Porter blog (Jul 30, 2021)](https://porter.run/blog/our-journey-building-porter/)
  - **Could not verify** a precise seed *close* date (vs. the July 30, 2021
    announcement date) against a dated primary financing document.

### ~2024 — Belanger departs to found Hatchet

- **Co-founder Alexander Belanger left Porter** to co-found **Hatchet**, a
  background-task / durable-execution orchestration platform, which went through
  **Y Combinator's Winter 2024 (W24)** batch with Belanger as Co-founder & CEO.
  Hatchet's YC profile describes him as "previously co-founder & CTO at Porter
  (S20)."
  - Source: [Hatchet — Y Combinator company profile](https://www.ycombinator.com/companies/hatchet-run)
  - **Could not verify** the exact date of Belanger's departure from Porter; it
    is bounded by Hatchet's W24 batch (early 2024).

### January 27, 2026 — $20M Series A (FirstMark)

- **Porter announced a $20M Series A on January 27, 2026, led by FirstMark
  Capital**, with participation from **Y Combinator** and strategic angels
  **Dalton Caldwell** and **Ali Rowghani**. The announcement post on Porter's
  blog is authored by **Justin Rhee** and titled "Effortless App Infrastructure
  in Any Cloud: Our $20M Series A."
  - Sources: [Effortless App Infrastructure in Any Cloud: Our $20M Series A — Justin Rhee, Porter blog (Jan 27, 2026)](https://www.porter.run/blog/effortless-app-infrastructure-in-any-cloud-porters-20m-series-a);
    [Announcing our $20m Series A in Porter: Effortless App Infrastructure in the Age of AI — FirstMark (Jan 27, 2026)](https://firstmark.com/story/announcing-our-20m-series-a-in-porter-effortless-app-infrastructure-in-the-age-of-ai/)

- **AI-infrastructure positioning and customers.** Porter's post says "Hundreds
  of the fastest-growing AI companies use Porter to manage hyper-growth
  infrastructure across AWS, Google Cloud, and Microsoft Azure," with customers
  able to "scale individual clusters in each cloud provider to hundreds of
  machines and terabytes of RAM without DevOps overhead," and notes built-in
  **SOC 2** and **HIPAA** compliance and support for web apps, workers, jobs,
  and **GPU workloads**. The company lists offices in **New York and San
  Francisco**. FirstMark's post names customers including **Tennr, ModelML,
  Outtake, and Giga**, says Porter "ranks as a top-five all-time most popular
  dev tool within Y Combinator," and identifies **Justin Rhee** as CEO.
  - Sources: [Porter blog (Jan 27, 2026)](https://www.porter.run/blog/effortless-app-infrastructure-in-any-cloud-porters-20m-series-a);
    [FirstMark (Jan 27, 2026)](https://firstmark.com/story/announcing-our-20m-series-a-in-porter-effortless-app-infrastructure-in-the-age-of-ai/)
  - **Could not verify** the specific customer list and the "top-five all-time
    most popular dev tool within YC" claim against neutral third-party sources;
    these are **company/investor-stated** figures from the funding
    announcements.

---

## Key people & teams

- **Justin Rhee** — **Co-founder & CEO**. Author of both the 2021 founding
  retrospective and the 2026 Series A announcement; identified as CEO by
  FirstMark.
  - Sources: [Porter — YC profile](https://www.ycombinator.com/companies/porter);
    [Our Journey Building Porter (Jul 30, 2021)](https://porter.run/blog/our-journey-building-porter/);
    [FirstMark (Jan 27, 2026)](https://firstmark.com/story/announcing-our-20m-series-a-in-porter-effortless-app-infrastructure-in-the-age-of-ai/)

- **Trevor Shim** — **Co-founder**. Quoted positioning Porter as "a successor to
  Heroku." Reported background: Yale (Intensive Physics & CS); prior research at
  MIT CSAIL.
  - Sources: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/);
    [Trevor Shim — Crunchbase](https://www.crunchbase.com/person/trevor-shim-7203)
  - **Could not verify** Shim's specific title (e.g., CTO) or current
    role/tenure against a strong primary source; the YC profile lists him only
    as "Founder."

- **Alexander Belanger** — **Co-founder & (former) CTO**. Left Porter to
  co-found **Hatchet** (YC W24), where he is Co-founder & CEO.
  - Source: [Hatchet — YC company profile](https://www.ycombinator.com/companies/hatchet-run)

- **Ethan Batraski** (Venrock) — seed-round investor; quoted in the 2021
  TechCrunch coverage framing Porter against a "stagnated" Heroku.
  - Source: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)

- **Could not verify** any other named executives, board members, or headcount
  against strong primary sources.

---

## Company & corporate history

- **2020** — Founded; went through **Y Combinator Summer 2020 (S20)**. Founders:
  **Justin Rhee**, **Trevor Shim**, and **Alexander Belanger**. Location: New
  York.
  - [Porter — YC profile](https://www.ycombinator.com/companies/porter) ·
    [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)

- **2020–2021** — Pivot from "Porter Dev" (remote dev environments) to a
  Heroku-like production PaaS on Kubernetes; open-source launch (Product Hunt
  Mar 2021, Hacker News Apr 2021).
  - [Our Journey Building Porter (Jul 30, 2021)](https://porter.run/blog/our-journey-building-porter/)

- **Funding (verified figures):**
  | Round | Date announced | Amount | Lead | Notes |
  |---|---|---|---|---|
  | Seed | Jul 30, 2021 | $1.5M | Venrock | co: Translink Capital, Soma Capital, YC, angels ([TechCrunch](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)) |
  | Series A | Jan 27, 2026 | $20M | FirstMark Capital | co: YC, Dalton Caldwell, Ali Rowghani ([Porter blog](https://www.porter.run/blog/effortless-app-infrastructure-in-any-cloud-porters-20m-series-a), [FirstMark](https://firstmark.com/story/announcing-our-20m-series-a-in-porter-effortless-app-infrastructure-in-the-age-of-ai/)) |

  - **Total publicly disclosed: $21.5M** across the two announced rounds.
    Crunchbase's profile could not be machine-read (HTTP 403) to cross-check
    intermediate rounds. **Could not verify** any undisclosed bridge/extension
    financing between 2021 and 2026.

- **~2024** — Co-founder Alexander Belanger departs to found Hatchet (YC W24).
  - [Hatchet — YC profile](https://www.ycombinator.com/companies/hatchet-run)

- **Jan 27, 2026** — **$20M Series A** led by FirstMark; AI-infrastructure
  positioning; offices in New York and San Francisco.
  - [Porter blog](https://www.porter.run/blog/effortless-app-infrastructure-in-any-cloud-porters-20m-series-a) ·
    [FirstMark](https://firstmark.com/story/announcing-our-20m-series-a-in-porter-effortless-app-infrastructure-in-the-age-of-ai/)

---

## Controversies & culture

- **No notable controversies were located.** No significant public controversy,
  outage postmortem, security incident, or pricing backlash specific to Porter
  was found in this research pass. This is an **absence of evidence**, not
  evidence of absence — Porter is a smaller, less-written-about company.
  - **Could not verify:** any controversy in either direction; none is asserted.

- **Positioning vs. Heroku (context, attributed).** Porter's central marketing
  story is explicitly anti-lock-in: Heroku-style convenience but running in the
  customer's own cloud account, with the founders calling Porter "a successor to
  Heroku" and an investor characterizing Heroku as having "stagnated." This is
  **company/investor positioning**, not a neutral third-party assessment.
  - Source: [TechCrunch (Jul 30, 2021)](https://techcrunch.com/2021/07/30/platform-as-a-service-startup-porter-aims-to-become-go-to-platform-for-deploying-managing-cloud-based-apps/)

---

## Items marked "Could not verify"

- **A precise founding date (month/day)** and legal-entity registration — "2020"
  and the S20 batch are sourced (YC profile); a finer date was not located.
- **Trevor Shim's exact title** (e.g., CTO) and current role/tenure — the YC
  profile lists him only as "Founder."
- **Founders' biographical details** (Shim: Yale / MIT CSAIL; Belanger: UPenn
  Physics) — secondary profiles only, not founder-authored sources.
- **Exact date Alexander Belanger left Porter** — bounded by Hatchet's W24 batch
  (early 2024); not pinned to a dated statement.
- **The original `porter-dev/porter` open-source repo** — described in the 2021
  founder retrospective and TechCrunch, but the repository now returns **404**
  at that path; its license and current open-source status could not be
  re-verified directly.
- **The "launched February 2021" (TechCrunch) vs. Product Hunt March / Hacker
  News April 2021 (founder post)** launch dates — both sourced but not
  reconciled to a single canonical launch date.
- **2026 Series A customer list and metrics** ("hundreds of AI companies,"
  Tennr/ModelML/Outtake/Giga, "top-five all-time most popular dev tool within
  YC") — company/investor-stated in the funding announcements, not
  independently corroborated.
- **Crunchbase profile** (HTTP 403 to automated fetching) — could not be used to
  cross-check intermediate funding rounds or total raised; total disclosed
  ($21.5M) is the sum of the two announced rounds.
