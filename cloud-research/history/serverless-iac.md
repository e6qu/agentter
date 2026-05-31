# Serverless IaC: A Sourced History of the Serverless Framework and SST

A chronological, fully-sourced history of two serverless infrastructure-as-code
projects: the **Serverless Framework** (by Serverless, Inc.) and **SST**
(formerly "Serverless Stack", by Anomaly Innovations).

Every claim below links to a primary or reputable source. Items that could not
be confirmed are flagged inline as **Could not verify**.

---

## Timeline

### 2014 — Origins of the Serverless Framework (as "JAWS")
- AWS Lambda launched at AWS re:Invent in November 2014, creating the
  opening that the Serverless Framework was built to address. Austen Collins
  began work on the project as a personal side project shortly after.
  - Background and creator attribution: [Austen Collins | AWS Serverless Hero](https://aws.amazon.com/developer/community/heroes/austen-collins/)
  - **Could not verify (exact start date):** Some secondary sources say Collins
    "founded" the project in 2014; the project's *public* debut under the name
    JAWS is documented as October 2015 (below). The precise private start date
    is not confirmed by a primary source.

### October 2015 — Public debut as "JAWS", then renamed "Serverless Framework"
- The project was first introduced publicly in **October 2015** under the name
  **JAWS** (presented at the AWS re:Invent timeframe as "JAWS: The Monstrously
  Scalable Serverless Framework").
  - [Serverless Framework — Wikipedia](https://en.wikipedia.org/wiki/Serverless_Framework) ("It was first introduced in October 2015 under the name JAWS.")
- It was renamed to the **Serverless Framework** shortly after.
  - **Could not verify (specific rename rationale):** A commonly repeated claim
    is that the rename was driven by a trademark conflict with the "JAWS" screen
    reader software. This appears in secondary/AI-generated summaries
    (e.g., Grokipedia) but I did not find a primary statement from Collins or
    Serverless, Inc. confirming the trademark reason. Treat the *reason* as
    unverified; the *fact of the rename* is well-supported.

### October 12, 2016 — Serverless Framework V1 and a $3M seed round
- Serverless, Inc. brought **Serverless Framework V1 out of beta** and
  announced a **$3 million seed round led by Trinity Ventures**, on the same day.
  - Company blog: [Releasing Serverless Framework V.1 & Fundraising](https://www.serverless.com/blog/releasing-serverless-framework-v1-and-fundraising) (published Oct 12, 2016; "closed a seed round of funding worth $3 million, led by Trinity Ventures")
  - [Serverless raises $3M to help developers go serverless — TechCrunch (Oct 12, 2016)](https://techcrunch.com/2016/10/12/serverless-raises-3m-to-help-developers-go-serverless/)
  - [Serverless, Inc. Nets $3M — Business Wire (Oct 12, 2016)](https://www.businesswire.com/news/home/20161012005381/en/Serverless-Nets-3M-Radically-Simplify-Cloud-Infrastructure)

### July 30, 2018 — $10M Series A
- Serverless, Inc. raised a **$10 million Series A led by Lightspeed Venture
  Partners**, with participation from Trinity Ventures. Reported total raised to
  ~$13M. The company simultaneously launched its commercial "Serverless
  Platform." Named customers included EA, Nordstrom, Reuters, and Coca-Cola.
  - [Serverless, Inc. lands $10M Series A — TechCrunch (Jul 30, 2018)](https://techcrunch.com/2018/07/30/serverless-inc-lands-10-m-series-a-to-build-serverless-developers-platform/)
  - [Serverless Raises $10M in Series A Funding — FinSMEs (Jul 2018)](https://www.finsmes.com/2018/07/serverless-raises-10m-in-series-a-funding.html)
  - [Serverless, Inc. Launches Serverless Platform — Business Wire (Jul 30, 2018)](https://www.businesswire.com/news/home/20180730005129/en/Serverless-Launches-Serverless-Platform-Operating-Serverless-Applications)

### ~2020–2021 — The Serverless Framework as the de facto Lambda IaC tool
- Through this period the Serverless Framework was a dominant way to define and
  deploy AWS Lambda applications, using a YAML config file (`serverless.yml`)
  to declare functions, events, and resources.
  - Tool overview: [Serverless Framework — Wikipedia](https://en.wikipedia.org/wiki/Serverless_Framework)
  - (This is also the period SST emerged as a CDK-based alternative — see the SST timeline below.)

### October 26, 2023 — Announcement of "V4: A New Model" (the licensing change)
- Serverless, Inc. published **"Serverless Framework V4: A New Model"**,
  announcing that **V4 would introduce fees for organizations with more than
  $2M in annual revenue**, plus a revenue-sharing ecosystem for extension
  authors (80% to creators). Stated rationale: sustainability for a "small team"
  and funding further innovation.
  - Company blog: [Serverless Framework V4: A New Model](https://www.serverless.com/blog/serverless-framework-v4-a-new-model) (published Oct 26, 2023)
  - **Note on dates:** This Oct 2023 post *announced* the plan. V4 did not become
    generally available until June 2024 (below). Several secondary articles
    conflate the two dates.

### June 13, 2024 — Serverless Framework V4 general availability
- **Serverless Framework V4 became generally available on June 13, 2024.**
  This is the version that operationalized the paid model: organizations
  exceeding **$2M in annual revenue** must obtain a paid subscription/license
  to use the V4 CLI, and the V4 npm module includes some proprietary
  (non-open-source) licensed code. Individuals and orgs under the threshold may
  continue to use the CLI for free (on an honor system). New V4 technical
  features included built-in esbuild bundling for JS/TS and a new Dev Mode.
  - Company blog: [Serverless Framework V4 Generally Available](https://www.serverless.com/blog/serverless-framework-v4-general-availability) (published Jun 13, 2024)
  - Upgrade/licensing docs: [Serverless Framework — Upgrading to v4](https://www.serverless.com/framework/docs/guides/upgrading-v4)
  - Pricing: [Serverless Framework Pricing](https://www.serverless.com/pricing)
  - License discussion (community): [serverless/serverless Discussion #12506 — "LICENCE file for V4"](https://github.com/serverless/serverless/discussions/12506) and [Discussion #12884](https://github.com/serverless/serverless/discussions/12884)

### 2024 — Community backlash and forks
- The licensing change drew criticism in developer communities. A representative
  thread on Hacker News framed the change as part of a decline: *"Serverless
  Framework changed their license terms in v4 to a paid model. It's also not
  getting a lot of new development or community support anymore. It's slowly
  dying and time to move off of it."* Commenters pointed others toward an
  open-source fork. (Attributing the criticism to the commenters, not asserting
  it as fact.)
  - [Hacker News thread (item 43421598)](https://news.ycombinator.com/item?id=43421598)
  - Critical commentary (opinion pieces, attributed): [Open Source Worse Practices: Serverless Inc. — HackerNoon](https://hackernoon.com/open-source-worse-practices-serverless-inc-as-an-example-of-what-can-go-wrong-q0663yae); [Open-source worse practices? — Project A Insights](https://insights.project-a.com/open-source-worse-practices/)
- **`oss-serverless` / OSLS ("Open Serverless")** emerged as a community fork: a
  free, open-source, drop-in replacement for **Serverless Framework v3**, for
  users who do not want to move to the paid V4. It is **maintained by
  [Bref](https://bref.sh) maintainers and contributors** (Bref is the popular
  serverless-PHP project led by Matthieu Napoli), with a stated commitment to
  keep v3-style projects working for ~5 years.
  - Fork repo: [oss-serverless/serverless (GitHub)](https://github.com/oss-serverless/serverless) ("osls is short for Open Serverless"; "created and maintained by Bref maintainers and contributors")
  - **Could not verify (exact fork creation date):** I did not confirm the precise
    date the `oss-serverless` repo was created from a primary source; sources
    place it after the V4 announcement (late 2023 / 2024).

### May 2026 — Status
- The Serverless Framework continues active releases under Serverless, Inc.
  (Wikipedia lists stable release 4.37.0 dated 27 May 2026). The `oss-serverless`
  fork also continues releasing a v3-compatible line (latest noted release
  v3.73.0, dated 27 May 2026).
  - [Serverless Framework — Wikipedia](https://en.wikipedia.org/wiki/Serverless_Framework)
  - [oss-serverless/serverless — Releases](https://github.com/oss-serverless/serverless/releases)
  - **Could not verify:** Exact present-day revenue/headcount of Serverless, Inc.
    No reliable primary figure found.

---

## SST (Serverless Stack) Timeline

### 2017 — Anomaly Innovations founded
- Jay V (Jayair) and Frank Wang — who met in their first week at the University
  of Waterloo and had previously built a company together — founded their
  company. SST is operated under **Anomaly Innovations** (Jay V as CEO,
  Frank Wang as CTO). Secondary sources place the company's San Francisco
  founding around 2017.
  - YC profile: [SST — Y Combinator](https://www.ycombinator.com/companies/sst)
  - Background/profile: [OpenCode background story — TechFundingNews](https://techfundingnews.com/opencode-the-background-story-on-the-most-popular-open-source-coding-agent-in-the-world/)
  - **Could not verify (precise founding year/city):** "2017, San Francisco"
    comes from secondary aggregators; not confirmed by a primary Anomaly source.

### Late 2020 — SST emerges as a CDK-based tool
- SST (then "Serverless Stack Toolkit" / "Serverless Stack") began appearing in
  late 2020 as a tool to bridge the **Serverless Framework and AWS CDK**, and
  to let developers define infrastructure in real programming languages (initially
  JS/TS) on top of **AWS CDK**.
  - [SST Changelog / Guide](https://guide.sst.dev/chapters/changelog.html)
  - **Could not verify (exact first-release date):** Secondary sources reference
    SST activity starting around September–October 2020, but I did not pin a
    precise initial release date to a primary source.

### March 2, 2021 — Launch HN; YC Winter 2021 batch
- SST launched publicly on Hacker News, posted by "jayair" (Jay V), pitching
  **"a live development environment for AWS Lambda."** SST was part of **Y
  Combinator's Winter 2021 (W21) batch**. Its signature feature was **Live
  Lambda Development**, and it was **built on top of AWS CDK** (JS/TS).
  - [Launch HN: SST (YC W21) — A live development environment for AWS Lambda (Mar 2, 2021)](https://news.ycombinator.com/item?id=26315585)
  - [SST — Y Combinator](https://www.ycombinator.com/companies/sst)

### 2021 — ~$1M raised after Demo Day
- After YC Demo Day, SST raised **~$1 million** from notable angels/investors
  (secondary reporting cites founders of PayPal, LinkedIn, Yelp, and YouTube).
  - [OpenCode background story — TechFundingNews](https://techfundingnews.com/opencode-the-background-story-on-the-most-popular-open-source-coding-agent-in-the-world/)
  - [Serverless Stack raises $1M — Appedus](https://appedus.com/serverless-stack-raises-1m/)
  - Earlier ICUBE/Waterloo-linked $1M mention: [The Varsity (Sep 24, 2021)](https://thevarsity.ca/2021/09/24/ad-icube-graduate-team-anomaly-innovations-that-provides-application-development-platform-for-start-ups-raised-1m/)
  - **Could not verify:** Exact named investor list and round structure from a
    primary source (e.g., an SEC filing or company announcement).

### May 16, 2022 — SST v1
- SST released **v1** (post dated May 16, 2022), having been "released a little
  over a year ago" (i.e., ~mid-2021 for the original). v1 was still **built on
  AWS CDK**, focused on reducing CDK boilerplate, improving type safety, and
  API consistency. By then SST also had a web dashboard and dozens of constructs.
  - [SST v1 (sst.dev blog)](https://sst.dev/blog/sst-v1)

### 2024 — "SST Ion": rewrite off CDK onto Pulumi/Terraform
- SST announced and developed **"Ion,"** a new deployment engine that **replaces
  AWS CDK + CloudFormation with Pulumi and Terraform providers.** The motivation:
  after ~3 years on CDK/CloudFormation, the team hit underlying design flaws —
  CloudFormation's slow/opaque deploys, stack resource limits, and AWS lock-in.
  Pulumi/Terraform enabled faster deploys, better errors, no CloudFormation
  resource ceiling, and multi-cloud (AWS + Cloudflare + 150+ providers).
  - SST blog: [Moving away from CDK](https://sst.dev/blog/moving-away-from-cdk/)
  - Pulumi's account: [AWS CDK vs Pulumi: Why SST Switched — Pulumi Blog](https://www.pulumi.com/blog/aws-cdk-vs-pulumi-why-sst-switched/)

### August 20, 2024 — Ion released as SST v3
- **Ion shipped as SST v3** (post dated Aug 20, 2024). v3 uses
  **Pulumi + Terraform** under the hood, config in `sst.config.ts` with the
  `sst.aws.*` namespace, and reported adoption near parity with v2 at release.
  - SST blog: [SST v3](https://sst.dev/blog/sst-v3/)
  - Migration docs: [Migrate From v2 — SST](https://sst.dev/docs/migrate-from-v2/)

### 2025–2026 — Pivot toward AI tooling (OpenCode); SST profitable
- The same team (Anomaly Innovations / SST), with Dax Raad (an early SST user
  who became a co-founder) and others, launched **OpenCode**, an open-source
  terminal AI coding agent, which grew explosively. Secondary reporting says SST
  itself turned profitable around 2025 (≈25,000 GitHub stars).
  - [OpenCode background story — TechFundingNews](https://techfundingnews.com/opencode-the-background-story-on-the-most-popular-open-source-coding-agent-in-the-world/)
  - [About — SST](https://sst.dev/about/) ; [Anomaly Innovations](https://anoma.ly/)
  - **Could not verify (precisely):** OpenCode's exact launch date and star/usage
    figures, and SST's 2025 profitability, come from secondary tech press /
    aggregators, not audited or primary company statements. The OpenCode pivot
    is well-attested in tech press but specific metrics should be treated as
    reported-not-verified.

---

## Key people & teams

**Serverless Framework / Serverless, Inc.**
- **Austen Collins** — Creator of the project (JAWS → Serverless Framework) and
  founder of Serverless, Inc. An AWS Serverless Hero.
  - [Austen Collins | AWS Serverless Hero](https://aws.amazon.com/developer/community/heroes/austen-collins/)
- The framework is now maintained by a full-time team at Serverless, Inc.
  ([Wikipedia](https://en.wikipedia.org/wiki/Serverless_Framework)).
- **Matthieu Napoli** — Maintainer of Bref (serverless PHP) and a driving force
  behind the `oss-serverless`/OSLS v3 fork. (Also a past contributor/PM
  associated with Serverless Framework.)
  - [mnapoli.fr](https://mnapoli.fr/) ; [oss-serverless/serverless](https://github.com/oss-serverless/serverless)

**SST / Anomaly Innovations**
- **Jay V ("Jayair")** — Co-founder and CEO; posted SST's Launch HN.
- **Frank Wang** — Co-founder and CTO.
  - [SST — Y Combinator](https://www.ycombinator.com/companies/sst) ; [Launch HN](https://news.ycombinator.com/item?id=26315585)
- **Dax Raad** — Early SST user (joined ~2021) who became a co-founder; central
  to the OpenCode effort.
  - [OpenCode background story — TechFundingNews](https://techfundingnews.com/opencode-the-background-story-on-the-most-popular-open-source-coding-agent-in-the-world/)

---

## Company & corporate history

**Serverless, Inc.**
- Founded by Austen Collins around the time of the framework's public launch
  (project public debut Oct 2015).
- Funding: **$3M seed (Trinity Ventures), Oct 12, 2016**; **$10M Series A
  (Lightspeed Venture Partners, w/ Trinity), Jul 30, 2018** (~$13M total
  reported). Built a commercial "Serverless Platform"/Dashboard product layer
  around the OSS CLI.
  - [Releasing V1 & Fundraising](https://www.serverless.com/blog/releasing-serverless-framework-v1-and-fundraising) ; [TechCrunch Series A](https://techcrunch.com/2018/07/30/serverless-inc-lands-10-m-series-a-to-build-serverless-developers-platform/)
- 2023–2024: Shifted to a **commercial license for V4** (paid for orgs over
  **$2M revenue**; proprietary code in the V4 npm module), monetizing the
  previously fully-open CLI — the central controversy in the project's history.
  Community responses included the `oss-serverless` v3 fork.
  - [V4: A New Model (Oct 26, 2023)](https://www.serverless.com/blog/serverless-framework-v4-a-new-model) ; [V4 GA (Jun 13, 2024)](https://www.serverless.com/blog/serverless-framework-v4-general-availability)
  - **Could not verify:** Current ownership, revenue, or headcount of Serverless, Inc.

**Anomaly Innovations (SST)**
- Founded by Jay V (CEO) and Frank Wang (CTO), who met at the University of
  Waterloo and had previously co-founded a company. SST went through YC's W21
  batch and raised ~$1M post-Demo-Day.
  - [SST — Y Combinator](https://www.ycombinator.com/companies/sst) ; [TechFundingNews](https://techfundingnews.com/opencode-the-background-story-on-the-most-popular-open-source-coding-agent-in-the-world/)
- Product arc: CDK-based SST (2020/2021) → SST v1 on CDK (2022) → **SST v3
  "Ion" on Pulumi/Terraform** (2024, off CDK) → pivot toward AI dev tooling
  (**OpenCode**, 2025–2026), with SST reported profitable ~2025.
  - [SST v3](https://sst.dev/blog/sst-v3/) ; [Moving away from CDK](https://sst.dev/blog/moving-away-from-cdk/)
  - **Could not verify (primary):** OpenCode metrics and 2025 profitability claims
    (secondary tech-press only).

---

## Note on sources and method
- Research conducted via web search + direct page fetches (company blogs,
  GitHub, TechCrunch/Business Wire/FinSMEs, Y Combinator, Hacker News,
  Wikipedia, Pulumi/SST blogs).
- Dates were cross-checked against primary posts where possible. Where only
  secondary or AI-generated summaries (e.g., Grokipedia) supported a claim, the
  claim is flagged **Could not verify**.
- Controversy (the V4 licensing backlash, "open-source worse practices"
  framing) is **attributed to its sources** (Hacker News commenters, opinion
  blogs) rather than asserted as neutral fact.
