# Coolify — A Sourced History

A chronological, sourced history of **Coolify** — the **open-source, self-hostable
PaaS** ("an open-source & self-hostable Heroku / Netlify / Vercel alternative")
created by **Andras Bacsai** in Hungary. It traces the project from a curiosity
side-project begun in early 2021, through the PHP/Laravel ground-up rewrite to
"v4," its breakout popularity during the 2023–2024 self-hosting / anti-cloud-bill
movement, and the sponsorship-plus-"Coolify Cloud" sustainability model that let a
solo developer turn it into a small, deliberately unfunded company (**coolLabs
Solutions Kft.**). Every non-trivial claim links to a working source. Primary
sources (the Coolify GitHub repo / releases / docs, the creator's own posts and
podcast appearances, the GitHub API) are preferred, with reputable secondary
coverage as corroboration. Items that could not be confirmed are marked
**"Could not verify."**

> **Cross-references (not duplicated here):**
> - The end of Heroku's free tier (Nov 2022) and Heroku's Feb 2026 move to a
>   "sustaining engineering model," repeatedly cited as tailwinds for self-hosted
>   PaaS adoption, are documented in [`heroku.md`](./heroku.md).
> - Vercel's usage-based "bill shock" episodes, also cited as a driver of the
>   self-hosting movement, are documented in [`vercel.md`](./vercel.md).

---

## Timeline

### January 2021 — the repository is created; v1 as a curiosity

- **January 25, 2021** — the `coollabsio/coolify` GitHub repository was created.
  The repo's own creation timestamp (`created_at`) is **2021-01-25T20:54:01Z**.
  Sources: [GitHub REST API, `repos/coollabsio/coolify`](https://api.github.com/repos/coollabsio/coolify)
  (field `created_at`);
  [GitHub, coollabsio/coolify](https://github.com/coollabsio/coolify).

- **Origin: a three-day experiment.** Bacsai has said the first working version of
  Coolify came together quickly — "the first version was created around three days,
  and that was working" — and that he started it mainly out of curiosity to see if
  he could build it for himself, only realizing people wanted it after it went a bit
  viral on Hacker News.
  Source: [Behind the Source, "Coolify with András Bácsai" (S02E06)](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/).
  *(The "three days," "curiosity," and "went viral on Hacker News" framing are from
  Bacsai's own podcast retelling and secondary write-ups summarizing it; an exact
  dated Hacker News thread for the v1 launch was **not** located in this pass —
  **Could not verify** that precise date.)*

- **Background.** Bacsai is a Hungarian software developer; secondary profiles
  describe a path from system administrator to infrastructure architect before he
  went independent.
  Sources: [Behind the Source (S02E06)](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/);
  [Andras Bacsai, GitHub profile](https://github.com/andrasbacsai).

### March 30, 2022 — Product Hunt launch

- **March 30, 2022** — Coolify was launched on **Product Hunt** with the tagline
  **"An open-source & self-hostable Heroku / Netlify alternative."** The maker is
  listed as **Andras Bacsai**, and the listing was hunted by **Csaba Kissi**.
  Sources: [Product Hunt, "Coolify"](https://www.producthunt.com/products/coolify).
  Bacsai marked the launch on X as introducing "my side-project that made me [to]
  leave a stable job at a multinational company in the middle of the pandemic."
  Source (X post; see note): [Andras Bacsai on X, Mar 30, 2022](https://x.com/heyandras/status/1509066653912363008).
  *(The X/Twitter post returned HTTP 402 to automated fetching; the wording and the
  March 30, 2022 timing are visible in the search-indexed tweet and consistent with
  the Product Hunt listing. **Could not verify** the exact post body by direct
  fetch.)*

### July 2022 — Bacsai goes full-time / independent

- **July 2022** — Coolify's own sponsorship page describes Bacsai as "a software
  developer based in Hungary who shifted to being an independent entrepreneur in
  **July 2022**," having left employment to focus on open-source work.
  Source: [Coolify, "Sponsorship" (coolLabs)](https://coolify.io/sponsorships).
  In his contemporaneous podcast appearance, Bacsai described the decision in his own
  words — "I decided to quit my job again and focus on my own projects full time and
  do open source stuff" — and was candid that the model was, at that point, "not
  sustainable yet," supported by GitHub Sponsors, Open Collective, freelance work,
  and early corporate sponsorships.
  Source: [Behind the Source (S02E06)](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/).

### April 2, 2023 — the "Version 4" announcement (PHP/Laravel rewrite)

- **April 2, 2023** — Bacsai opened GitHub Discussion **#1027, "Version 4,"**
  announcing that **v4 would be a complete rewrite from scratch** intended to make
  Coolify "more robust" and "a no-brainer switch from other hosting platforms." The
  defining decision was a language/framework switch: despite being "a Javascript
  guy," Bacsai chose **Laravel / PHP**, writing "I 💜 JS, but I realized that I love
  DX even more," and pre-emptively asking readers "do not try to convince me about
  that I should use JS, Python, Rust or anything else instead of PHP." He also said
  v3 would get bug fixes but no new features after v4, and that he planned an import
  path from v3 to v4.
  Source: [coollabsio/coolify Discussion #1027, "Version 4"](https://github.com/coollabsio/coolify/discussions/1027).

- **The v4 stack.** Coolify's control panel (v4) is built on **Laravel** with
  **Livewire** and **Alpine.js** for the UI, orchestrating **Docker** on remote
  servers reached over SSH. The repository's v4 branch documents this stack.
  Sources: [coollabsio/coolify, `CLAUDE.md` (v4.x branch)](https://github.com/coollabsio/coolify/blob/v4.x/CLAUDE.md);
  [GitHub, coollabsio/coolify (repo description and README)](https://github.com/coollabsio/coolify).

### 2023–2024 — breakout popularity and the self-hosting movement

- **The macro tailwinds.** Coolify's surge in popularity is consistently tied to two
  industry shifts that pushed developers toward self-hosting: **Heroku ending its
  free tier** (announced Aug 2022, effective Nov 28, 2022 — see
  [`heroku.md`](./heroku.md)) and recurring **Vercel "bill shock"** episodes (see
  [`vercel.md`](./vercel.md)). Secondary coverage frames Coolify as the clear leader
  of the open-source self-hosted-PaaS segment that grew out of this moment.
  Sources: [LogRocket, "How to implement Coolify, the self-hosted alternative to Heroku"](https://blog.logrocket.com/implement-coolify-self-hosted-alternative-heroku/);
  [XDA Developers, "I stopped paying Heroku for my app deployments after discovering this self-hosted alternative"](https://www.xda-developers.com/i-stopped-paying-heroku-after-discovering-this-alternative/).
  *(The causal link between Heroku/Vercel pricing changes and Coolify's growth is
  **reported characterization** by these outlets, not a metric from a single primary
  source.)*

- **GitHub stars.** Coolify grew into one of the more visibly starred infrastructure
  projects on GitHub; as of the most recent check the repository carried roughly
  **56,000+ stars** (GitHub API field `stargazers_count` = **56,246**), under an
  **Apache-2.0** license.
  Sources: [GitHub REST API, `repos/coollabsio/coolify`](https://api.github.com/repos/coollabsio/coolify)
  (`stargazers_count`, `license`); [GitHub, coollabsio/coolify](https://github.com/coollabsio/coolify).
  *(The star count is a point-in-time snapshot and changes continuously; the
  ~56k/Apache-2.0 figures are as returned by the GitHub API during this research
  pass.)*

### Mid-2024 — first hires; sponsorship sustainability

- **Mid-2024 — Bacsai is no longer working alone.** Coolify's sponsorship page
  states: "Since the middle of 2024, I'm not the only one working on these projects.
  Thanks to the sponsors and paid users, I hired a developer and a few community
  support members." The same page describes Coolify as "a self-funded company"
  dependent on sponsorship, with donation channels via **GitHub Sponsors**,
  **Open Collective**, and **Stripe**.
  Source: [Coolify, "Sponsorship" (coolLabs)](https://coolify.io/sponsorships).

- **The team.** Coolify's docs list an international team led by **Andras Bacsai**
  (Founder, Lead Developer), alongside core/contributor roles including **Peaklabs
  Dev** (Core Developer), **ShadowArcanist** (Community Lead, Docs Maintainer),
  **Aditya Tripathi** (Developer, Community Moderator), and **Oren Aksakal**
  (Developer).
  Source: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team).
  *(The team docs do **not** list hiring dates; mapping specific people to the
  "mid-2024" hires is **not** established by a primary source — **Could not verify**
  which named individuals correspond to the first hires.)*

### Coolify Cloud — the hosted, "paid option without paywall"

- **Coolify Cloud** is the company's **managed, paid service** that runs Coolify on
  coolLabs' own infrastructure (so the user need not allocate CPU/RAM/disk to
  Coolify itself), while the user connects their own servers over SSH. Coolify's docs
  state it is "maintained by Andras, Coolify's Founder," and frame it as a
  **"paid option without paywall"** — "a model where the open-source project stays
  completely free, but those who prefer a managed experience can contribute
  financially," using "the same open-source codebase, so there are no
  locked-behind-paywall features." The docs cite a base fee of **$5/month** (up to
  two connected servers) plus **$3/month** per additional server, and say the service,
  "initially launched as an experiment," had attracted "**over 2,100 active users**."
  Source: [Coolify Docs, "Coolify Cloud"](https://coolify.io/docs/get-started/cloud).
  *(The "2,100 active users" figure is a point-in-time number from Coolify's own
  docs. A precise launch date for Coolify Cloud was **not** located — **Could not
  verify** when Coolify Cloud first opened.)*

- **Reported profitability (Feb 2025 figures).** In a March 2025 X post, Bacsai
  reported February 2025 figures: gross income ~**$15,700** ("Cloud ~$10.5k +
  donations ~$5.2k"), expenses ~**$2,800**, and net income before tax ~**$12,900**,
  contrasting it with a prior salaried job ("my last 9-5 job paid $1,700/m") and
  stating he never took money out of the business.
  Source (X post; see note): [Andras Bacsai on X, Mar 18, 2025](https://x.com/heyandras/status/1901894087604916396).
  *(The X post returned HTTP 402 to automated fetching; the figures and wording are
  visible in the search-indexed tweet but were **not** confirmed by direct fetch and
  are self-reported by Bacsai — treat the dollar figures as **reported, not
  independently verified**.)*

### April 27, 2026 — v4.0.0 stable

- **April 27, 2026** — after roughly two years in beta and hundreds of beta
  releases, **Coolify v4.0.0** was published as the stable release. The GitHub API
  records the v4.0.0 tag as published **2026-04-27T08:55:25Z**. In the release notes,
  Bacsai wrote: "It was long overdue because we have been in beta for a long time.
  Thousands of companies and people have been using Coolify in production for 1-2
  years." He previewed **v5** — "The biggest feature will be full scalability in the
  core, so you will have cloud infrastructure, but with your own servers" — and
  stressed it would not abandon v4: "doing v5 does not mean we won't continue to
  support v4."
  Sources: [coollabsio/coolify, Release v4.0.0](https://github.com/coollabsio/coolify/releases/tag/v4.0.0);
  [GitHub REST API, `releases/tags/v4.0.0`](https://api.github.com/repos/coollabsio/coolify/releases/tags/v4.0.0)
  (`published_at` = 2026-04-27).
  *(Some automated page reads of the GitHub releases list mis-rendered the year as
  "2024"; the authoritative `published_at` timestamp from the GitHub API is
  **2026-04-27**. Secondary coverage also dates the stable release to late April
  2026 — e.g. [wz-it, "Coolify v4.0.0 Is Here"](https://wz-it.com/en/blog/coolify-v4-0-0-self-hosted-paas-heroku-alternative/).)*

---

## Key people & teams

- **Andras Bacsai** (**András Bácsai**) — **Founder and Lead Developer** of Coolify;
  Hungarian software developer who went independent in **July 2022** to work on
  open-source full-time. He runs **coolLabs** and is also behind other projects
  (the company lists coollabs.io, coolify.io, and others under his name). He is
  active on GitHub, X, and Bluesky.
  Sources: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team);
  [Coolify, "Sponsorship"](https://coolify.io/sponsorships);
  [Andras Bacsai, GitHub profile](https://github.com/andrasbacsai);
  [Behind the Source (S02E06)](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/).

- **Peaklabs Dev** — **Core Developer**, per Coolify's team docs (associated with the
  `peaklabs-dev` GitHub identity referenced in the repository).
  Sources: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team);
  [GitHub, coollabsio/coolify](https://github.com/coollabsio/coolify).

- **ShadowArcanist** — **Community Lead, Docs Maintainer**.
  Source: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team).

- **Aditya Tripathi** — **Developer, Community Moderator**.
  Source: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team).

- **Oren Aksakal** — **Developer**.
  Source: [Coolify Docs, "coolLabs Team"](https://coolify.io/docs/get-started/team).

- **Csaba Kissi** — hunted the Coolify Product Hunt launch (Mar 30, 2022); not a team
  member.
  Source: [Product Hunt, "Coolify"](https://www.producthunt.com/products/coolify).

---

## Company & corporate history

- **January 25, 2021** — `coollabsio/coolify` GitHub repository created; v1 begins
  as a curiosity side-project.
  [GitHub API, `created_at`](https://api.github.com/repos/coollabsio/coolify) ·
  [GitHub, coollabsio/coolify](https://github.com/coollabsio/coolify)
- **March 30, 2022** — Product Hunt launch as "an open-source & self-hostable
  Heroku / Netlify alternative."
  [Product Hunt](https://www.producthunt.com/products/coolify)
- **July 2022** — Bacsai leaves employment to work on open source full-time.
  [Coolify "Sponsorship"](https://coolify.io/sponsorships) ·
  [Behind the Source](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/)
- **April 2, 2023** — "Version 4" announced: a from-scratch rewrite on **Laravel/PHP**.
  [coollabsio/coolify Discussion #1027](https://github.com/coollabsio/coolify/discussions/1027)
- **2023–2024** — breakout growth amid the self-hosting / anti-cloud-bill movement;
  positioned as a Heroku/Vercel/Netlify alternative.
  [LogRocket](https://blog.logrocket.com/implement-coolify-self-hosted-alternative-heroku/) ·
  [XDA](https://www.xda-developers.com/i-stopped-paying-heroku-after-discovering-this-alternative/)
- **Mid-2024** — first hires (a developer plus community support), funded by
  sponsors and paid users; **coolLabs** operates as a self-funded, **unfunded**
  company in Hungary.
  [Coolify "Sponsorship"](https://coolify.io/sponsorships) ·
  [Coolify Docs, Team](https://coolify.io/docs/get-started/team)
- **Coolify Cloud** — managed paid service ("paid option without paywall"; $5/month
  base), reportedly 2,100+ active users; profitability self-reported by Bacsai
  (Feb 2025 figures).
  [Coolify Docs, "Coolify Cloud"](https://coolify.io/docs/get-started/cloud) ·
  [Andras Bacsai on X (Mar 18, 2025)](https://x.com/heyandras/status/1901894087604916396)
- **April 27, 2026** — **v4.0.0 stable** released after ~2 years in beta; v5 (core
  scalability) previewed with v4 support to continue.
  [Release v4.0.0](https://github.com/coollabsio/coolify/releases/tag/v4.0.0) ·
  [GitHub API, `published_at`](https://api.github.com/repos/coollabsio/coolify/releases/tags/v4.0.0)

**Corporate entity (reported).** Secondary profiles identify the operating company
as **coolLabs Solutions Kft.**, a Hungarian company with no outside investors, based
in Székesfehérvár, founded 2021 by Bacsai.
Sources: [Tracxn, "Coolify — Company Profile"](https://tracxn.com/d/companies/coolify/__C69uwPGHBvDZUBDqHLs6F1o9i3aIKj1XBefGptrgzgI);
[LinkedIn, "András Bácsai — coolLabs Solutions Kft."](https://www.linkedin.com/in/andrasbacsai/).
*(The exact legal entity name "coolLabs Solutions Kft.," the Székesfehérvár
location, and the "unfunded" classification are **secondary-sourced** — see
"Could not verify" below.)*

---

## Funding, sustainability, and tensions

> Each item separates **established fact** (sourced to Coolify's own pages / repo)
> from **reported claim / characterization**, with attribution.

### 1. Deliberately unfunded / self-funded

- **Fact (per Coolify):** Coolify is "a self-funded company" sustained by donations
  (GitHub Sponsors, Open Collective, Stripe) and Coolify Cloud, and it hired its
  first non-founder staff in **mid-2024** on that basis.
  [Coolify "Sponsorship"](https://coolify.io/sponsorships)
- **Reported / founder-stated:** Bacsai has said he prefers not to take venture
  capital, wanting "software that doesn't move with the money" and to prioritize
  users over investors.
  [Behind the Source](https://www.behindthesource.co.uk/podcasts/s02e06-coolify-with-andras-bacsai/)
  *(Claims that specific VCs approached Bacsai and were declined appear in secondary
  summaries and his own remarks; the specific VC identities are **not** named in a
  primary source here — treated as **reported**.)*

### 2. "Paid option without paywall" (Coolify Cloud)

- **Fact (per Coolify docs):** Coolify Cloud uses the same open-source codebase with
  no paywalled features; pricing starts at **$5/month**; it reported **2,100+** active
  users.
  [Coolify Docs, "Coolify Cloud"](https://coolify.io/docs/get-started/cloud)
- **Reported / self-reported:** Bacsai's February 2025 income figures (gross
  ~$15.7k, net ~$12.9k) are **self-reported** via X and were not independently
  verified.
  [Andras Bacsai on X (Mar 18, 2025)](https://x.com/heyandras/status/1901894087604916396)

### 3. The PHP/Laravel rewrite decision

- **Fact (per repo):** v4 was a from-scratch rewrite on Laravel/PHP, a deliberate
  switch from Bacsai's JavaScript background, justified by developer experience.
  [Discussion #1027](https://github.com/coollabsio/coolify/discussions/1027)
- **Reported characterization:** The long (~2-year) v4 beta — used "in production"
  by "thousands of companies and people" before the stable tag — is a recurring point
  in community commentary about Coolify's maturity.
  [Release v4.0.0](https://github.com/coollabsio/coolify/releases/tag/v4.0.0)

---

## Items marked "Could not verify"

- **Exact v1 launch / Hacker News virality date (~2021)** — the "three-day" build,
  the curiosity origin, and "went viral on Hacker News" are from Bacsai's own podcast
  retelling and secondary summaries; the repo creation date (Jan 25, 2021) is
  primary, but a dated HN thread for the v1 launch was **not** located.
- **Direct reads of the X/Twitter posts** for the Product Hunt launch (Mar 30, 2022)
  and the February-2025 income figures (posted ~Mar 18, 2025) — both returned HTTP
  402 to automated fetching; their content is visible via search-indexing but was not
  confirmed by direct fetch, and the income figures are **self-reported**.
- **Coolify Cloud launch date** and whether the "2,100+ active users" figure is
  current — the user count is a point-in-time number from Coolify's docs; no dated
  launch announcement was located.
- **Mapping of specific named team members to the "mid-2024" first hires** — the team
  docs list people and roles but **no hire dates**.
- **The legal entity name "coolLabs Solutions Kft.," the Székesfehérvár location, and
  the "unfunded" classification** — **secondary-sourced** (Tracxn, LinkedIn); the
  "self-funded company" wording is primary (Coolify's own sponsorship page), but the
  registered-entity details are not confirmed against a primary corporate filing.
- **The GitHub star count (~56,246) and Apache-2.0 license** — accurate per the
  GitHub API at the time of this research, but the star count is a continuously
  changing snapshot.
- **Specific VC firms said to have approached Bacsai** — referenced in secondary
  summaries / his remarks but not named in a primary source here.
