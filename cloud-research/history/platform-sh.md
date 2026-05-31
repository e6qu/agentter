# Platform.sh (and Upsun): A Sourced History

A chronological, fully-sourced history of **Platform.sh** — the French/US,
git-driven, immutable-infrastructure Platform-as-a-Service that spun out of the
Drupal Commerce company **Commerce Guys** — and its newer flexible-PaaS brand
**Upsun**, which in September 2025 became the company's name outright.

Every non-trivial claim below carries a working source link. Primary sources
(Platform.sh / Upsun press and blog posts, founders' statements, investor and
partner announcements) are preferred, with reputable outlets (TechCrunch,
GlobeNewswire/PR Newswire, Tech.eu) as corroboration. Where a detail could not
be confirmed against a primary or reputable secondary source, it is explicitly
flagged with **Could not verify:**. Controversies/characterizations are
attributed to their sources, with fact separated from reported claim.

> **Note on the task brief's "~$140M Series C":** The $140M round was Platform.sh's
> **Series D** (announced June 2022), **not** a Series C. Platform.sh's **Series C**
> was a separate, earlier **$34M** round (May 2018). Both are documented below with
> primary/near-primary sources. See **Funding** and the "Could not verify" note.

> **Note on the brand:** Many Platform.sh URLs (`platform.sh/blog/...`,
> `platform.sh/company/press/...`) now **301-redirect to `upsun.com`** following the
> 2025 rebrand. Where that happened, the working (post-redirect) `upsun.com` URL is
> cited.

---

## Timeline

### Origins inside Commerce Guys (2009–2014)

- **Commerce Guys and Drupal Commerce.** Platform.sh's founders came out of
  **Commerce Guys**, the company behind **Drupal Commerce**, the open-source
  e-commerce framework for Drupal. Drupal Commerce was created under the
  leadership of **Ryan Szrama** and renamed "Drupal Commerce" on **January 14,
  2010**.
  - Source: [Drupal Commerce — Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce)

- **The three founders' Commerce Guys roles.** **Frédéric (Fred) Plais** and
  **Damien Tournoud** helped establish Commerce Guys (the Drupal-Commerce e-commerce
  business); **Ori Pekelman** served on its board. TechCrunch's later coverage
  states Plais and Tournoud "helped establish" the Drupal-powered e-commerce
  platform, and that "Pekelman served as a board member there."
  - Source: [Platform.sh secures $140M for web app development tools — TechCrunch (June 20, 2022)](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/)
  - Pekelman's own framing: he was a **Technology Board Member at Commerce Guys**
    and describes Platform.sh as a **"spin-off of Commerce Guys ... back in 2014."**
    - Source: [Platform.sh appoints Ori Pekelman and Fabien Potencier as CSO and CPO — PCR (Feb 1, 2022)](https://pcr-online.biz/2022/02/01/platform-sh-appoints-ori-pekelman-and-fabien-potencier-as-cso-and-cpo/)

- **June 2014 — Platform.sh launched as a Drupal-optimized PaaS by Commerce Guys.**
  Commerce Guys built a DevOps/hosting product for internal use, then launched it as
  **Platform.sh**.
  - Source (the original launch blog, now redirected to the Upsun dev center):
    [Cloud hosting for Drupal and Symfony / "Commerce Guys launches Platform" — Platform.sh blog](https://platform.sh/blog/commerce-guys-launches-platform/)
    *(This `platform.sh/blog/...` URL 301-redirects to
    `devcenter.upsun.com/posts/commerce-guys-launches-platform/`, which returned HTTP 403
    to automated fetching; the post's existence and title are confirmed via the
    redirect and search indexing.)*
  - Corroboration for the "June 2014" launch year: [Drupal Commerce — Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce)
    ("Commerce Guys launched a Drupal optimized Platform-as-a-Service in June 2014 called Platform.sh").
  - **Could not verify** an exact launch **day** in June 2014 from a dated primary
    announcement.

### Spin-out: Platform.sh becomes an independent company (February 2016)

- **February 9, 2016 — Platform.sh spun out from Commerce Guys.** In a post titled
  "Commerce Guys Refocusing on Drupal Commerce as Platform.sh Becomes an Independent
  Company," **Ryan Szrama** announced he had **acquired Commerce Guys' Drupal Commerce
  business** and become its President/CEO, while **Platform.sh** became an independent
  company "led by my two partners, **Frédéric Plais as CEO** and **Damien Tournoud as
  CTO**." (The same announcement notes Drupal Commerce was running on 60,000+ sites.)
  - Source: [Commerce Guys Refocusing on Drupal Commerce as Platform.sh Becomes an Independent Company — Centarro (Feb 9, 2016)](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company)
  - The Drupal Commerce side later rebranded to **Centarro** (2019).
    - Source: [Drupal Commerce — Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce);
      [Centarro — Drupal.org](https://www.drupal.org/centarro)
  - **Note on dates:** Secondary databases (e.g. Tracxn) often cite "founded 2015" for
    Platform.sh as a standalone company, and TechCrunch's Series D piece says "Founded:
    2015." The product launched in **2014** (inside Commerce Guys) and became an
    **independent company in February 2016**. Treat any single "founded year" as
    brand-dependent. See "Could not verify."

### The platform: git-driven, immutable, branch-cloned environments

Platform.sh's defining idea is that **infrastructure is part of the application and
lives in the git repository**, so pushing a branch can produce a full, isolated
environment that is a byte-level clone of production.

- **Git as the control plane; YAML-defined infrastructure.** Apps and services are
  described in YAML files committed alongside code — primarily **`.platform.app.yaml`**
  (one per app container), **`.platform/services.yaml`** (services such as databases
  and search), and **`.platform/routes.yaml`** (routing). The contents of the git
  repository deterministically orchestrate the running infrastructure (an immutable,
  container-based build).
  - Sources (Platform.sh docs/blog): [Git repository structure for Platform.sh — Platform.sh blog (archived)](https://web.archive.org/web/2id_/https://platform.sh/blog/file-structure-platform-application/);
    [`.platform/services.yaml` — Platform.sh Documentation (GitBook mirror)](https://pawpy.gitbooks.io/platformsh-docs/content/reference/services-yaml.html)

- **Per-branch environment cloning.** Pushing a branch can create a corresponding
  environment with code, data, and services — "a copy of your database, a copy of your
  search index, a copy of your user files," cloned from production to create ephemeral
  preview environments.
  - Source (Upsun Fixed docs, the post-rebrand home of the Platform.sh product docs):
    [Structure — Upsun Fixed Docs](https://fixed.docs.upsun.com/learn/overview/structure.html);
    [Manage Upsun Fixed environments — Upsun Fixed Docs](https://fixed.docs.upsun.com/environments.html)
  - **Attribution/caveat:** Some of the most vivid phrasings ("the full production
    cluster can be cloned in under a minute ... a byte-level copy of production") appear
    in Platform.sh marketing/community material as summarized by third parties; the
    core mechanics (git-push branch → cloned environment from YAML config) are
    documented in the first-party docs above. Treat the exact "under a minute /
    byte-level" performance claims as **company marketing claims**, not independently
    benchmarked facts.

### Series C: $34M (May 2018)

- **May 23, 2018 — Series C: $34M, led by Partech.** Platform.sh raised **$34 million**
  in **Series C** funding led by **Partech**, with **Idinvest Partners**, **Benhamou
  Global Ventures (BGV)**, **SNCF Digital Ventures**, and returning investor **Hi Inov**.
  CEO **Frédéric Plais**: "The productivity gains that our platform delivers are beyond
  anything offered by managed hosting solutions, or DIY approaches with cloud
  infrastructures."
  - Source: [Platform.sh Raises $34M to Bring Speed and Confidence to Enterprise Cloud Deployments — GlobeNewswire (May 23, 2018)](https://www.globenewswire.com/news-release/2018/05/23/1510616/0/en/Platform-sh-Raises-34M-to-Bring-Speed-and-Confidence-to-Enterprise-Cloud-Deployments.html)

### Acquisition of Blackfire.io (2021)

- **May 25, 2021 — intent to acquire Blackfire announced.** Platform.sh announced its
  **intent to acquire Blackfire SAS**, the Paris-based **PHP/Python application
  performance profiling and monitoring** company, to build an observability suite.
  Blackfire's team — led by founder/CEO **Fabien Potencier**, creator of the **Symfony**
  PHP framework — joined Platform.sh.
  - Source: [Platform.sh And Blackfire.io Join Forces To Accelerate Observability For Web App Fleets — PR Newswire (May 25, 2021)](https://www.prnewswire.com/news-releases/platformsh-and-blackfireio-join-forces-to-accelerate-observability-for-web-app-fleets-301298593.html)
  - Corroboration: [Paris-based application performance monitoring tool Blackfire acquired by Platform.sh — Tech.eu (May 27, 2021)](https://tech.eu/2021/05/27/paris-based-application-performance-monitoring-tool-blackfire-acquired-by-platform-sh/)

- **Closed July 2021.** The acquisition completed in **July 2021**; Potencier joined
  the Platform.sh executive team.
  - Source: [Platform.sh's Acquisition of Blackfire.io — Global Legal Chronicle](https://globallegalchronicle.com/platform-shs-acquisition-of-blackfire-io/)
  - **Could not verify** the exact closing **day** in July 2021 from a single first-party
    press release; the "July 2021" close is from the legal-deal write-up and secondary
    summaries.

- **The Sensio / SensioLabs lineage (verified carefully).** Blackfire originated inside
  **SensioLabs**, the company tied to **Sensio** — founded in Paris in **1998** by
  **Fabien Potencier** and **Grégory Pascal** — which created the **Symfony** framework
  (open-sourced 2005). **SensioLabs** was created in **2012**; per SensioLabs' own
  history, **"In 2018, Blackfire and Symfony took off becoming independent companies."**
  Platform.sh then acquired the independent Blackfire in 2021.
  - Source: [History — SensioLabs](https://sensiolabs.com/company/history)
  - **Clarification of the brief's "2018 merger/relationship with Commerce Guys / Sensio":**
    There was **no 2018 merger between Platform.sh/Commerce Guys and Sensio/SensioLabs.**
    The accurate, sourced facts are: (1) Platform.sh **spun out of Commerce Guys** (2016,
    above); and (2) the **Sensio/SensioLabs** link is via **Blackfire** — which became
    independent of SensioLabs in **2018** and was acquired by Platform.sh in **2021**.
    The "2018" date in the brief corresponds to **Blackfire/Symfony becoming independent
    of SensioLabs**, not to any Platform.sh transaction. **Could not verify** any direct
    2018 Platform.sh–Sensio merger (none is documented).

### February 2022 — executive appointments

- **February 1, 2022 — Ori Pekelman named CSO; Fabien Potencier named CPO.** Platform.sh
  appointed co-founder **Ori Pekelman** as **Chief Strategy Officer** (a newly created
  role) and **Fabien Potencier** (Symfony creator, ex-Blackfire) as **Chief Product
  Officer**.
  - Source: [Platform.sh appoints Ori Pekelman and Fabien Potencier as CSO and CPO — PCR (Feb 1, 2022)](https://pcr-online.biz/2022/02/01/platform-sh-appoints-ori-pekelman-and-fabien-potencier-as-cso-and-cpo/)
  - **Caveat on Pekelman's title:** Some profiles (Crunchbase, Apollo) list Pekelman as
    "Co-Founder & CPO" or "Co-Founder & Chief Strategy Officer." The dated Feb 2022
    appointment (Pekelman → CSO; Potencier → CPO) is the most specific sourced statement.
    - Sources: [Ori Pekelman — Crunchbase](https://www.crunchbase.com/person/ori-pekelman)

### Series D: $140M (June 2022) — the brief's "~$140M" round

- **June 20–21, 2022 — Series D: $140M.** Platform.sh raised **$140 million** in
  **Series D** funding, co-led by **Revaia** (Paris), **Digital+ Partners** (Munich),
  and **Morgan Stanley Expansion Capital** (San Francisco), with existing investors
  **BGV**, **Eurazeo**, **Hi Inov**, and **Partech** re-investing. The company reported
  **~$45M ARR** (up ~50% year-over-year per TechCrunch; "north of $40 million" per the
  company post), ~**340 employees across 36 countries**, ~5,000 customers, and **$187M
  total raised** to date.
  - Sources (primary/near-primary): [Platform.sh Secures $140 million in Series D Funding — Upsun (formerly platform.sh/company/press/...)](https://upsun.com/blog/securing-series-d-financing/);
    [Platform.sh secures $140M for web app development tools — TechCrunch (June 20, 2022)](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/);
    [Platform.sh Secures $140 million in Series D Funding to Support Enterprises in Scaling Fleets of Websites and Applications — PR Newswire](https://www.prnewswire.com/news-releases/platformsh-secures-140-million-in-series-d-funding-to-support-enterprises-in-scaling-fleets-of-websites-and-applications-301570032.html)
  - CEO **Fred Plais**: "Our approach has quickly inspired global corporations to manage
    thousands of websites and applications efficiently and securely."
    - Source: [Series D announcement — Upsun](https://upsun.com/blog/securing-series-d-financing/)
  - **Date nuance:** TechCrunch dates its coverage **June 20, 2022**; the company post is
    dated **June 21, 2022**. Both refer to the same $140M Series D.

### Upsun launched as a new offering (September 2023)

- **September 13, 2023 — Upsun revealed (beta).** Platform.sh introduced **Upsun**, a
  **new PaaS offering powered by Platform.sh** aimed at startups and developer teams:
  **usage-based (consumption) pricing**, environments individually configurable for CPU
  and RAM, horizontal and vertical scaling, **unlimited preview environments** with
  custom domains, and multicloud edge-caching — initially via a beta program (14-day
  trial, Discord community).
  - Source (Platform.sh's own dev.to announcement, dated Sep 13, 2023): [We have big news. Introducing Upsun, a new offer powered by Platform.sh — DEV Community](https://dev.to/platformsh/we-have-big-news-introducing-upsun-a-new-offer-powered-by-platformsh-mf6)
  - Corroboration (community/coverage): [Platform.sh Reveals Upsun, Its PaaS Offering Designed to Support the Growth of Startups — Startups Magazine](https://startupsmagazine.co.uk/article-platformsh-reveals-upsun-its-paas-offering-designed-support-growth-startups)
  - The official "Revealing Upsun" blog post (now at
    [upsun.com/blog/revealing-upsun-a-new-paas-offering/](https://upsun.com/blog/revealing-upsun-a-new-paas-offering/))
    carries a **3 April 2024** date on the migrated `upsun.com` site, which reflects the
    **general-availability** framing / re-publication rather than the original
    September 2023 reveal. **Could not verify** a single canonical first-party date that
    cleanly separates "reveal (Sep 2023)" from "GA (early 2024)"; the **Sep 13, 2023**
    reveal is anchored by the dev.to post above.

### Sustainability / greener hosting (2024)

- **February 28, 2024 — "Greener Region Discount."** Platform.sh announced what it
  called a cloud-industry first: a **3% discount** on resource usage for deploying to
  **greener data-center regions** — those drawing electricity at **under 100 gCO₂eq/kWh**
  — covering **six eligible regions across five countries** (France, Sweden, Switzerland,
  Canada, the U.S.) and four cloud providers (Azure, AWS, GCP, OVH), exposed via an open
  carbon-footprint API. The program is tied to the **Upsun** offering.
  - Source (now redirected to upsun.com): [A First for the Cloud Industry — Platform.sh announces a Greener Region Discount offering / "Announcing Greener Region Discount" — Upsun (Feb 28, 2024)](https://upsun.com/blog/announcing-greener-region-discount/)
  - Platform.sh also created a sustainability function and hired **Leah Goldfarb** as
    **Environmental Impact Officer** (described as a first-of-its-kind PaaS role).
    - Source: [Platform.sh's Environmental Impact Officer Leah Goldfarb on Spearheading Greener Hosting Initiatives within the Cloud Industry — HostingAdvice](https://www.hostingadvice.com/blog/platformsh-hires-environmental-impact-officer-to-spearhead-greener-hosting-initiatives/)
  - **On WebAssembly:** The task brief asks about "WebAssembly/sustainability
    initiatives." The **sustainability/greener-hosting** initiatives are well sourced
    (above). A specific **WebAssembly** initiative tied to that sustainability work was
    **not** found in the sources reviewed. **Could not verify: a Platform.sh/Upsun
    WebAssembly initiative.**

### Company-wide rebrand to Upsun (September 2025)

- **September 23, 2025 — Platform.sh rebrands as Upsun.** Platform.sh **evolved into
  Upsun** company-wide — positioned around **AI-assisted development** ("built for humans
  and robots"), including support for AI agents/coding assistants, an **MCP server and
  API** for AI agents to invoke platform tools, and integrations with LLM-enabled IDEs
  (e.g. Claude Code, GitHub Copilot). CEO **Fred Plais**: "As enterprises expand the use
  of AI in software development, Upsun will provide the AI support they need to increase
  productivity and deployment velocity." CPO **Nigel Kersten**: "Developers get speed,
  simplicity, and scalability. Enterprises get standardization, security, and
  sustainability."
  - Sources: [Platform.sh Rebrands as Upsun, Expands Cloud Platform with AI Capabilities — The Drop Times (Sep 23, 2025)](https://www.thedroptimes.com/54721/platformsh-rebrands-upsun-expands-cloud-platform-with-ai-capabilities);
    [Platform.sh evolves into Upsun, the cloud application platform built for humans and robots — DevPro Journal](https://www.devprojournal.com/software-development-trends/aiops/platform-sh-evolves-into-upsun-the-cloud-application-platform-built-for-humans-and-robots/)
  - The legacy Platform.sh product continues as **"Upsun Fixed"** (its docs now live at
    `fixed.docs.upsun.com`).
    - Source: [What is Upsun Fixed? — Upsun Fixed Docs](https://fixed.docs.upsun.com/learn/overview.html)

---

## Key people & teams

- **Frédéric (Fred) Plais** — **co-founder and CEO** of Platform.sh/Upsun; previously
  helped lead Commerce Guys (where he was CEO before Szrama). Public face of the funding
  rounds and the 2025 Upsun rebrand.
  - Sources: [Centarro (Feb 9, 2016)](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company);
    [TechCrunch (June 20, 2022)](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/);
    [The Drop Times (Sep 23, 2025)](https://www.thedroptimes.com/54721/platformsh-rebrands-upsun-expands-cloud-platform-with-ai-capabilities)

- **Damien Tournoud** — **co-founder and CTO**; came from the Commerce Guys / Drupal
  Commerce engineering side.
  - Sources: [Centarro (Feb 9, 2016)](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company);
    [TechCrunch (June 20, 2022)](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/)

- **Ori Pekelman** — **co-founder**; **Chief Strategy Officer** (appointed Feb 1, 2022;
  a newly created role). Polyglot developer/architect; was a Commerce Guys technology
  board member. (Some profiles list him as CPO/CSO inconsistently — see caveat above.)
  - Sources: [PCR (Feb 1, 2022)](https://pcr-online.biz/2022/02/01/platform-sh-appoints-ori-pekelman-and-fabien-potencier-as-cso-and-cpo/);
    [Ori Pekelman — Crunchbase](https://www.crunchbase.com/person/ori-pekelman)

- **Fabien Potencier** — creator of the **Symfony** PHP framework and founder/CEO of
  **Blackfire**; joined Platform.sh via the 2021 Blackfire acquisition and was named
  **Chief Product Officer** (Feb 1, 2022).
  - Sources: [PR Newswire (May 25, 2021)](https://www.prnewswire.com/news-releases/platformsh-and-blackfireio-join-forces-to-accelerate-observability-for-web-app-fleets-301298593.html);
    [PCR (Feb 1, 2022)](https://pcr-online.biz/2022/02/01/platform-sh-appoints-ori-pekelman-and-fabien-potencier-as-cso-and-cpo/);
    [History — SensioLabs](https://sensiolabs.com/company/history)

- **Nigel Kersten** — **Chief Product Officer** at the time of the 2025 Upsun rebrand
  (quoted in the rebrand coverage).
  - Source: [DevPro Journal](https://www.devprojournal.com/software-development-trends/aiops/platform-sh-evolves-into-upsun-the-cloud-application-platform-built-for-humans-and-robots/)

- **Leah Goldfarb** — **Environmental Impact Officer**, leading Platform.sh's
  greener-hosting / decarbonization work.
  - Source: [HostingAdvice](https://www.hostingadvice.com/blog/platformsh-hires-environmental-impact-officer-to-spearhead-greener-hosting-initiatives/)

- **Adjacent (not Platform.sh leadership):** **Ryan Szrama** — led Drupal Commerce; after
  the 2016 split he ran the Commerce Guys / Drupal Commerce business (rebranded
  **Centarro** in 2019).
  - Source: [Centarro (Feb 9, 2016)](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company)

---

## Company & corporate history

- **2009–2010** — **Commerce Guys** / **Drupal Commerce** founded (Drupal Commerce
  renamed Jan 14, 2010). Plais and Tournoud help build it; Pekelman is a board member.
  [Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce) ·
  [TechCrunch](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/)
- **June 2014** — **Platform.sh launched** as a Drupal-optimized PaaS by Commerce Guys.
  [Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce)
- **February 9, 2016** — **Platform.sh spun out as an independent company** (Plais CEO,
  Tournoud CTO); Szrama keeps the Drupal Commerce business.
  [Centarro](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company)
- **May 23, 2018** — **Series C: $34M**, led by Partech (Idinvest, BGV, SNCF Digital
  Ventures, Hi Inov).
  [GlobeNewswire](https://www.globenewswire.com/news-release/2018/05/23/1510616/0/en/Platform-sh-Raises-34M-to-Bring-Speed-and-Confidence-to-Enterprise-Cloud-Deployments.html)
- **May–July 2021** — **Acquires Blackfire.io** (PHP/Python profiling; Symfony creator
  Fabien Potencier joins). Intent May 25, 2021; closed July 2021.
  [PR Newswire](https://www.prnewswire.com/news-releases/platformsh-and-blackfireio-join-forces-to-accelerate-observability-for-web-app-fleets-301298593.html) ·
  [Tech.eu](https://tech.eu/2021/05/27/paris-based-application-performance-monitoring-tool-blackfire-acquired-by-platform-sh/)
- **February 1, 2022** — Pekelman named CSO; Potencier named CPO.
  [PCR](https://pcr-online.biz/2022/02/01/platform-sh-appoints-ori-pekelman-and-fabien-potencier-as-cso-and-cpo/)
- **June 2022** — **Series D: $140M** (Revaia, Digital+ Partners, Morgan Stanley
  Expansion Capital co-lead); ~$45M ARR, ~340 staff, $187M total raised.
  [TechCrunch](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/) ·
  [Upsun/press](https://upsun.com/blog/securing-series-d-financing/)
- **September 13, 2023** — **Upsun** revealed as a new, usage-based PaaS offering
  (beta). [DEV Community](https://dev.to/platformsh/we-have-big-news-introducing-upsun-a-new-offer-powered-by-platformsh-mf6)
- **February 28, 2024** — **Greener Region Discount** (3% for sub-100 gCO₂eq/kWh
  regions). [Upsun](https://upsun.com/blog/announcing-greener-region-discount/)
- **September 23, 2025** — **Platform.sh rebrands company-wide as Upsun** (AI-assisted
  development, MCP server/API); legacy product continues as **"Upsun Fixed."**
  [The Drop Times](https://www.thedroptimes.com/54721/platformsh-rebrands-upsun-expands-cloud-platform-with-ai-capabilities) ·
  [Upsun Fixed Docs](https://fixed.docs.upsun.com/learn/overview.html)

### Funding rounds (summary)

| Round | Date | Amount | Lead(s) | Sourcing |
|---|---|---|---|---|
| Series C | May 23, 2018 | $34M | Partech (Idinvest, BGV, SNCF Digital Ventures, Hi Inov) | [GlobeNewswire](https://www.globenewswire.com/news-release/2018/05/23/1510616/0/en/Platform-sh-Raises-34M-to-Bring-Speed-and-Confidence-to-Enterprise-Cloud-Deployments.html) (near-primary) |
| Series D | June 2022 | $140M | Revaia, Digital+ Partners, Morgan Stanley Expansion Capital (BGV, Eurazeo, Hi Inov, Partech re-invest) | [TechCrunch](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/) · [Upsun/press](https://upsun.com/blog/securing-series-d-financing/) (primary + reputable) |
| **Total raised** | (as of Series D) | **$187M** | — | [TechCrunch](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/) |

- **Earlier rounds (Seed / Series A / Series B)** are reported by secondary databases
  (e.g. a 2010 seed by ISAI; a 2012 ~$5M Series A involving OpenOcean; a 2014 ~$7.3M
  Series B) but these predate or straddle the Commerce Guys → Platform.sh split and were
  **not** confirmed against dated primary announcements here.
  - Source (secondary aggregator): [Platform.sh — Funding Rounds & Investors — Tracxn](https://tracxn.com/d/companies/platform.sh/__0nEmO7BQw095zi8PcZad65AJavT4wOk5a8QJB_QmdT4/funding-and-investors)
  - **Could not verify** the seed/Series A/Series B amounts and dates from primary
    sources; treat as **secondary-sourced**.

---

## Controversies & characterizations

> Platform.sh has had a comparatively low-controversy public profile (no major breach,
> free-tier-removal, or shutdown saga of the kind seen at Heroku). The items below are
> **clarifications/characterizations**, with fact separated from reported claim.

### 1. The "Series C vs Series D" and "founded year" confusion

- **Fact:** The widely-cited **$140M** round is the **Series D** (June 2022); the
  **Series C** was a distinct **$34M** round (May 2018).
  [TechCrunch](https://techcrunch.com/2022/06/20/platform-sh-secures-140m-for-web-app-development-tools/) ·
  [GlobeNewswire](https://www.globenewswire.com/news-release/2018/05/23/1510616/0/en/Platform-sh-Raises-34M-to-Bring-Speed-and-Confidence-to-Enterprise-Cloud-Deployments.html)
- **Reported/characterization:** Secondary profiles variously give Platform.sh's
  "founded" year as **2014** (product launch), **2015** (TechCrunch/Tracxn), or **2016**
  (independent company). This is a genuine ambiguity rooted in the Commerce Guys spin-out,
  not an error in any single source.
  [Wikipedia](https://en.wikipedia.org/wiki/Drupal_Commerce) ·
  [Centarro](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company)

### 2. The "Commerce Guys / Sensio 2018 merger" framing (in the task brief)

- **Fact:** Platform.sh spun **out of Commerce Guys** (2016). The **Sensio/SensioLabs**
  connection is solely via **Blackfire** (which became independent of SensioLabs in
  **2018** and was acquired by Platform.sh in **2021**).
  [Centarro](https://www.centarro.io/blog/commerce-guys-refocusing-drupal-commerce-platformsh-becomes-independent-company) ·
  [SensioLabs history](https://sensiolabs.com/company/history) ·
  [PR Newswire](https://www.prnewswire.com/news-releases/platformsh-and-blackfireio-join-forces-to-accelerate-observability-for-web-app-fleets-301298593.html)
- **Could not verify:** any **2018 merger between Platform.sh/Commerce Guys and
  Sensio/SensioLabs** — none is documented; the "2018" date belongs to Blackfire/Symfony
  becoming independent of SensioLabs.

### 3. Marketing performance claims

- **Characterization (company marketing):** Claims like cloning "the full production
  cluster in under a minute" / "byte-level copy of production" are Platform.sh's own
  positioning, surfaced through marketing and third-party summaries, not independently
  benchmarked here. The underlying mechanism (git-push branch → YAML-defined, cloned
  environment) is documented in first-party docs.
  [Upsun Fixed Docs — Structure](https://fixed.docs.upsun.com/learn/overview/structure.html)

---

## Open items / "Could not verify" summary

- **Exact day of the June 2014 Platform.sh launch** — year confirmed; no dated primary
  day located.
- **Single canonical "founded year"** — 2014 (product) vs 2015 (TechCrunch/Tracxn) vs
  2016 (independent company); inherently ambiguous.
- **Exact closing day of the Blackfire acquisition in July 2021** — "July 2021" from a
  legal-deal write-up; no first-party day-level press release confirmed.
- **A direct 2018 Platform.sh–Sensio/SensioLabs merger** — **not supported**; the 2018
  date is Blackfire/Symfony's independence from SensioLabs.
- **A Platform.sh/Upsun WebAssembly initiative** — not found; only the sustainability /
  greener-hosting initiatives are sourced.
- **Seed / Series A / Series B amounts and dates** — secondary-sourced (Tracxn);
  not confirmed against dated primary announcements.
- **Clean separation of Upsun "reveal" (Sep 13, 2023) vs "GA"** — the official
  "Revealing Upsun" post shows an April 3, 2024 date on the migrated upsun.com site; the
  Sep 13, 2023 reveal is anchored to Platform.sh's dated dev.to post.
- **Ori Pekelman's canonical title** — Feb 2022 appointment (CSO) is dated; other
  profiles list CPO/CSO inconsistently.
