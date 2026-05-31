# Daytona — A Sourced History

A chronological, fully-sourced history of **Daytona** (operated by **Daytona
Platforms, Inc.**) — a company that began (~2023) as an **open-source,
self-hosted development-environment manager** (an enterprise-grade,
self-hostable alternative to GitHub Codespaces / Gitpod) and pivoted in
**2024–2025** to position itself as the **infrastructure / runtime for AI
agents**: secure, elastic **sandboxes** ("composable computers") for executing
AI-generated code.

Every non-trivial claim below carries a working source link. Primary sources
(Daytona's own blog/press releases, founder **Ivan Burazin's** posts, the
project's GitHub) are preferred, with reputable outlets (PR Newswire-distributed
releases, AlleyWatch, InfoQ, etc.) as corroboration. Where a detail could not be
confirmed against a primary or reputable secondary source, it is explicitly
flagged with **Could not verify:**. Opinions and characterizations are
attributed to their sources.

> **Cross-references (not duplicated here):**
> - For where Daytona sits in the broader AI-sandbox cohort — alongside **E2B**
>   (Firecracker microVMs), **Modal** (gVisor; see `history/modal.md`), and
>   Vercel Sandbox — and for how Firecracker / gVisor / Kata / Sysbox compare as
>   isolation primitives, see `history/modal.md`, `history/fly-io.md`, and
>   `history/WASM_DOCKER_alternate_history.md`. Daytona's default isolation is
>   **container-based** (with optional Kata/Sysbox), distinct from Modal's
>   gVisor and E2B's Firecracker (see Technology below).

---

## Timeline

### Pre-history (2009–2023) — Codeanywhere, Shift, Infobip

- **2009 — PHPanywhere → Codeanywhere.** Before Daytona, **Ivan Burazin**
  co-founded **PHPanywhere** in 2009 with **Vedran Jukic**; the project later
  evolved into **Codeanywhere**, a browser-based ("cloud") IDE. Daytona's own
  pre-seed announcement states Burazin "co-founded PHPanywhere in 2009 with
  Vedran Jukic, which later evolved into Codeanywhere."
  - Source: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - **Could not verify** the exact Codeanywhere launch date against a first-party
    source. Secondary profiles (Tracxn) state Codeanywhere "was launched on May
    22, 2013 in Palo Alto, California"; treat that specific date as
    secondary-sourced.
    - Source (secondary): [Codeanywhere — Tracxn](https://tracxn.com/d/companies/codeanywhere/__RZBuQ-13XoJNwD1S2jyyy0Un0lrbwQjPHAWL6xbCDPE)

- **The Shift developer conference.** Burazin is credited as the founder of
  **Shift**, described by Daytona as "a leading global event" / "a major global
  event."
  - Source: [Daytona Unveils Open Source Development Environment Manager — PR Newswire / Daytona (Mar 6, 2024)](https://www.prnewswire.com/news-releases/daytona-unveils-open-source-development-environment-manager-to-streamline-software-creation-302079943.html)
  - Source: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - **Could not verify** the exact founding year of Shift against a first-party
    source (a secondary Daytona profile says "Ivan founded Shift in 2012"); the
    fact that Burazin founded Shift is primary-sourced, the year is not.

- **Infobip.** Between Codeanywhere/Shift and Daytona, Burazin served as **Chief
  Developer Experience Officer at Infobip** (the Croatian communications-platform
  company). Daytona: he "subsequently served as Chief Developer Experience
  Officer at Infobip before establishing the Shift developer conference."
  - Source: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - **Note on ordering:** Daytona's own copy and secondary coverage are
    *inconsistent* about whether Shift predates or postdates Infobip. The
    pre-seed post phrases it as Infobip "before establishing the Shift
    conference," while other coverage implies Shift came earlier. **Could not
    verify** the precise chronological order of Shift vs. Infobip.

### 2023 — Founding as a development-environment manager

- **2023 — Daytona founded.** Daytona was founded in **2023** by **Ivan Burazin**
  (CEO), **Vedran Jukic** (CTO), and **Goran Draganić** (Chief Architect). The
  initial product was a **self-hosted "Development Environment Management"
  platform**, pitched as "an enterprise-grade alternative to GitHub Codespaces."
  - Source (co-founders + positioning): [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - Source (founding year + founders, secondary): [Daytona Raises $24M to Replace Cloud Infrastructure Built for Humans With One Built for Agents — AlleyWatch (Feb 2026)](https://www.alleywatch.com/2026/02/daytona-ai-agent-infrastructure-sandbox-computing-developer-tools-ivan-burazin/)
  - **Could not verify** an exact founding *month/day* or the precise legal
    entity name against a first-party incorporation document. "2023" is the year
    Daytona and its coverage use.

- **November 6, 2023 — $2M pre-seed.** Daytona announced **$2 million** in
  pre-seed funding, with venture support led by **500 Emerging Europe** (the
  500 Global regional fund), alongside **Tiny.vc**, **Silicon Gardens**,
  **Darkmode VC**, and **Firestreak Ventures**, plus a large roster of
  developer-founder angels — including **Abhinav Asthana** (Postman), **Charity
  Majors** (Honeycomb), **Christian Bach** (Netlify), **Paul Copplestone**
  (Supabase), **Prashanth Chandrasekar** (Stack Overflow), **Luke Kanies**
  (Puppet), **Milin Desai** (Sentry), **Zach Lloyd** (Warp), and **Shawn Wang
  (swyx)** (smol.ai), among 40+ others.
  - Source (primary): [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - Source (coverage): [Daytona Secures $2M to Fill the Enterprise Void Left by GitHub Codespaces — PR Newswire](https://www.prnewswire.com/news-releases/daytona-secures-2m-to-fill-the-enterprise-void-left-by-github-codespaces-301978663.html)
  - Source (coverage): [Daytona Raises $2M for its Development Environment Management Platform for the Cloud — AlleyWatch (Nov 2023)](https://www.alleywatch.com/2023/11/daytona-cloud-development-environment-management-platform-ivan-burazin/)

### 2024 — Open source; the $5M seed

- **March 5–6, 2024 — Daytona goes open source.** Daytona released its
  development-environment manager as **open-source software**, licensed under
  **Apache 2.0**, automating provisioning, configuration, prebuilds, a secure
  **VPN** connection, IDE wiring (VS Code, JetBrains, Web IDE), and domain
  assignment behind a single `daytona create` command. The launch was also
  announced as a "Show HN" on Hacker News, framed by Burazin as the product of
  "a 15-year journey."
  - Source (license = Apache 2.0; founder background): [Daytona Goes Open Source: Embarking on a Bold New Journey — Daytona (Mar 5, 2024)](https://www.daytona.io/dotfiles/daytona-goes-open-source)
  - Source (press release): [Daytona Unveils Open Source Development Environment Manager — PR Newswire / Daytona (Mar 6, 2024)](https://www.prnewswire.com/news-releases/daytona-unveils-open-source-development-environment-manager-to-streamline-software-creation-302079943.html)
  - Source (Show HN, "15-year journey"): [Show HN: Daytona – Open-source dev env manager from a 15-year journey — Hacker News](https://news.ycombinator.com/item?id=39616709)
  - Source (coverage): [Development Environment Manager Daytona Now Open Source — InfoQ (Mar 2024)](https://www.infoq.com/news/2024/03/daytona-open-source/)
  - **Note:** the Daytona blog post is dated **March 5, 2024** and the PR Newswire
    release **March 6, 2024**; both refer to the same open-source launch.

- **June 25, 2024 — $5M seed, led by Upfront Ventures.** Daytona announced a
  **$5 million** seed round led by **Upfront Ventures**, with existing investor
  **500 Global** and angels including founders of **Postman, Netlify, and
  Supabase**. At this point Daytona was still an **open-source development
  environment manager**; Burazin's framing: setting up a dev environment "can
  feel like starting a car in the 1900s ... Daytona makes it as simple as
  starting a modern car today where you can just push a button and go."
  - Source (primary press release): [Daytona Secures $5M to Simplify Development Environments — PR Newswire (Jun 25, 2024)](https://www.prnewswire.com/news-releases/daytona-secures-5m-to-simplify-development-environments-302181407.html)
  - Source (Daytona blog): [Daytona Secures $5M to Simplify Development Environments — Daytona](https://www.daytona.io/dotfiles/daytona-secures-5m-to-simplify-development-environments)
  - Source (coverage): [Daytona Raises $5M for its Open-Source Development Environment Management Platform — AlleyWatch (Jun 2024)](https://www.alleywatch.com/2024/06/daytona-open-source-development-environment-manager-platform-ivan-burazin/)
  - **Note on "total funding" at this date:** the $5M seed coverage describes
    total funding of **~$7M** (pre-seed $2M + seed $5M).

### 2025 — The pivot: from dev environments to AI-agent infrastructure

- **Early 2025 — sunset the old product, rebuild from scratch.** Daytona made a
  high-conviction pivot: it **sunset the original development-environment
  product, released its existing customer base, and rebuilt the platform** as a
  **runtime/infrastructure for AI agents**. The trigger, per Burazin, was inbound
  demand from agent-building teams whose needs the old product could not serve:
  "The biggest non-obvious decision was deciding not to 'adapt' the old product
  for agents... Agents are a different user. They need programmatic control over
  everything, no human-in-the-loop assumptions."
  - Source: [Daytona: Instant sandboxes for AI agents — Unicorner](https://read.unicorner.news/p/daytona)
  - **Attribution / caveat:** the "sunset old product / release existing
    customers / rebuilt in early 2025" narrative and the **late-April 2025**
    relaunch date below are sourced to **secondary coverage** (Unicorner, and
    comparison blogs) quoting Burazin, not to a single dated first-party Daytona
    press release located in this pass. Treat the exact relaunch date as
    reported, not first-party-confirmed.

- **Late April 2025 — relaunch as agent-focused infrastructure.** Multiple
  secondary sources date the relaunch of the new, agent-focused Daytona to
  **late April 2025**, after which the platform reportedly crossed **$1M ARR
  within two months**.
  - Source: [Daytona: Instant sandboxes for AI agents — Unicorner](https://read.unicorner.news/p/daytona)
  - Source (pivot timing): [E2B vs Daytona — ZenML Blog](https://www.zenml.io/blog/e2b-vs-daytona)
  - **Could not verify** the precise relaunch date or the ARR figure against a
    first-party Daytona announcement; both are secondary/company-relayed.

- **New positioning: "composable computers" / "a computer for every agent."**
  The repositioned Daytona describes itself (GitHub) as "a Secure and Elastic
  Infrastructure for Running AI-Generated Code," offering **sandboxes** that are
  "full composable computers with complete isolation, a dedicated kernel,
  filesystem, network stack, and allocated vCPU, RAM, and disk," spinning up "in
  under 90ms from code to execution."
  - Source (primary): [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)
  - Source (primary site): [Daytona — Secure Infrastructure for Running AI-Generated Code](https://www.daytona.io/)
  - **Note:** the open-source repository's license for the new product is
    **AGPL-3.0** (per the GitHub repo metadata), distinct from the **Apache 2.0**
    license of the 2024 dev-environment manager.
    - Source: [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)

### 2026 — $24M Series A; "give every agent a computer"

- **February 5, 2026 — $24M Series A, led by FirstMark Capital.** Daytona
  announced a **$24 million Series A** led by **FirstMark Capital**, with
  participation from **Pace Capital**, existing investors **Upfront Ventures**
  and **E2VC**, and **strategic** investments from **Datadog** and **Figma
  Ventures**. **Matt Turck** (FirstMark General Partner) joined the board.
  Coverage put **total funding raised at ~$31M**. Burazin framed the thesis:
  "Agents write code, run experiments, recover from errors, and branch execution
  paths. Existing primitives were built for serving software, not creating it."
  - Source (primary press release): [Daytona Raises $24M Series A to Give Every Agent a Computer — PR Newswire (Feb 5, 2026)](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html)
  - Source (coverage, total funding ~$31M + quotes): [Daytona Raises $24M to Replace Cloud Infrastructure Built for Humans With One Built for Agents — AlleyWatch (Feb 2026)](https://www.alleywatch.com/2026/02/daytona-ai-agent-infrastructure-sandbox-computing-developer-tools-ivan-burazin/)
  - Source (coverage): [Daytona Raises $24M for AI Agent Computing Infrastructure — AI-TechPark](https://ai-techpark.com/daytona-raises-24m-for-ai-agent-computing-infrastructure/)
  - **Note on "$31M total":** AlleyWatch states $31M total. Note this implies
    pre-seed $2M + seed $5M + Series A $24M = $31M — i.e., the rounds add up.
  - **Reported traction:** a **$1M forward revenue run rate within three
    months**, "doubled to $2M six weeks later," a **20-person team**, and
    customers spanning Y Combinator startups to Fortune 100 enterprises —
    named examples include **LangChain, Turing, Writer, and SambaNova**.
    - Source: [Daytona Raises $24M Series A — PR Newswire (Feb 5, 2026)](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html)
    - **Revenue caveat:** these are **company-stated growth claims relayed by
      the press**, not audited; "forward revenue run rate" and "ARR" are used
      loosely across coverage.

---

## Technology (sandboxes, isolation, cold starts)

Sourced to Daytona's own GitHub/site and to comparison coverage. The throughline
of the post-pivot product is **programmatic, elastic sandboxes** ("composable
computers") for running untrusted AI-generated code.

- **Sandboxes as "composable computers."** Daytona exposes programmatic
  sandboxes where CPU, memory, storage, GPU, networking, and the OS are
  configured on demand, then started, paused, or **snapshotted** at any point,
  with **fork/branch** of execution and persistence across failures.
  - Source: [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)
  - Source: [Daytona Raises $24M Series A — PR Newswire (Feb 5, 2026)](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html)

- **Cold-start claims: "under 90ms."** Daytona markets **sub-90-millisecond**
  sandbox creation ("under 90ms from code to execution"), positioned as the
  fastest cold start in the AI-sandbox category.
  - Source (primary): [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)
  - Source (comparative framing): [Daytona vs E2B vs Modal vs Vercel Sandbox: A 2026 Comparison — StartupHub.ai](https://www.startuphub.ai/ai-news/artificial-intelligence/2026/daytona-vs-e2b-vs-modal-vs-vercel-sandbox-2026)
  - **Could not verify** independently the "27ms optimized" / sub-90ms figures
    against a neutral benchmark; the headline numbers are Daytona's marketing
    figures relayed by comparison blogs.

- **Isolation = container-based by default (with optional Kata/Sysbox).**
  Comparison coverage describes Daytona's architecture as **container-based by
  default**, with optional **Kata** or **Sysbox** for stronger,
  closer-to-microVM isolation — distinct from **E2B** (Firecracker microVMs) and
  **Modal** (gVisor). Daytona's own copy stresses "complete isolation, a
  dedicated kernel, filesystem, network stack."
  - Source (Daytona self-description): [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)
  - Source (container/Kata/Sysbox framing): [Daytona vs E2B in 2026 — Northflank](https://northflank.com/blog/daytona-vs-e2b-ai-code-execution-sandboxes)
  - **Attribution:** the specific "container by default + optional Kata/Sysbox"
    characterization is from third-party comparison blogs, not a first-party
    Daytona architecture doc located here. Treat as **reported**.

- **Multi-language SDKs.** Daytona ships client SDKs for **Python**,
  **TypeScript/JavaScript**, **Ruby**, **Go**, and **Java**, installed via
  standard package managers, plus features like process execution, filesystem
  ops, Git integration, language-server support, and **Computer Use** sandboxes
  for desktop automation.
  - Source: [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)
  - Source: [Daytona Raises $24M to Replace Cloud Infrastructure Built for Humans... — AlleyWatch (Feb 2026)](https://www.alleywatch.com/2026/02/daytona-ai-agent-infrastructure-sandbox-computing-developer-tools-ivan-burazin/)

---

## Key people & teams

- **Ivan Burazin** — co-founder and **CEO**. Croatian serial entrepreneur in
  developer tools:
  - Co-founded **PHPanywhere** (2009, with Vedran Jukic), which evolved into the
    browser-based IDE **Codeanywhere**.
  - Founded the **Shift** developer conference.
  - Served as **Chief Developer Experience Officer at Infobip** before Daytona.
  - Sources: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed);
    [Daytona Goes Open Source — Daytona (Mar 5, 2024)](https://www.daytona.io/dotfiles/daytona-goes-open-source);
    [Meet Ivan Burazin, Our CEO — Daytona](https://www.daytona.io/dotfiles/meet-ivan-burazin-our-ceo-and-dev-empowerment-champion)

- **Vedran Jukic** — co-founder and **CTO**; co-founded PHPanywhere/Codeanywhere
  with Burazin in 2009.
  - Sources: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed);
    [Meet Vedran Jukic, Our Co-founder and CTO — Daytona](https://www.daytona.io/dotfiles/meet-vedran-jukic-our-co-founder-and-cto)

- **Goran Draganić** — co-founder and **Chief Architect**.
  - Source: [Daytona Raises $2M in Pre-Seed — Daytona (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)
  - **Could not verify** further first-party biographical detail on Draganić in
    this pass.

- **Matt Turck** — **FirstMark Capital** General Partner; joined Daytona's board
  with the Series A (Feb 2026).
  - Source: [Daytona Raises $24M Series A — PR Newswire (Feb 5, 2026)](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html)

---

## Company & corporate history

- **2009** — Burazin and Jukic found **PHPanywhere**, which becomes
  **Codeanywhere** (browser-based IDE) — the lineage Daytona later describes
  itself as "reigniting."
  - [Daytona Raises $2M in Pre-Seed (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)

- **2023** — **Daytona founded** by Burazin (CEO), Jukic (CTO), and Draganić
  (Chief Architect) as a self-hosted development-environment manager
  ("enterprise alternative to GitHub Codespaces").
  - [Daytona Raises $2M in Pre-Seed (Nov 6, 2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)

- **Funding (verified figures):**

  | Round | Date | Amount | Lead | Notes |
  |---|---|---|---|---|
  | Pre-seed | Nov 6, 2023 | $2M | 500 Emerging Europe | + Tiny.vc, Silicon Gardens, Darkmode VC, Firestreak; 40+ founder-angels ([Daytona](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed)) |
  | Seed | Jun 25, 2024 | $5M | Upfront Ventures | + 500 Global; Postman/Netlify/Supabase founders ([PR Newswire](https://www.prnewswire.com/news-releases/daytona-secures-5m-to-simplify-development-environments-302181407.html)) |
  | Series A | Feb 5, 2026 | $24M | FirstMark Capital | + Pace Capital, Upfront, E2VC; strategic Datadog & Figma Ventures; total ~$31M ([PR Newswire](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html), [AlleyWatch](https://www.alleywatch.com/2026/02/daytona-ai-agent-infrastructure-sandbox-computing-developer-tools-ivan-burazin/)) |

  - **On the task brief's "seed ~$5M, and any 2025 round":** the **$5M seed
    (Jun 2024)** is confirmed. **No 2025 funding round was located** — the round
    following the seed is the **Feb 2026 $24M Series A**. The 2025 event was the
    **product pivot/relaunch**, not a financing. Marked **Could not verify: any
    2025 Daytona funding round.**

- **Trajectory: self-hosted Codespaces alternative → AI-agent runtime.**
  Daytona's positioning shifted from a **self-hosted development-environment
  manager** for human engineers (2023–2024) to **secure, elastic sandboxes /
  "composable computers" for AI agents and AI-generated code** (2025–2026) — a
  genuine product **pivot** (sunset old product, rebuild), not merely a framing
  change.
  - Sources: [Daytona Raises $2M in Pre-Seed (2023)](https://www.daytona.io/dotfiles/daytona-raises-2m-in-pre-seed);
    [Daytona Goes Open Source (2024)](https://www.daytona.io/dotfiles/daytona-goes-open-source);
    [Daytona: Instant sandboxes for AI agents — Unicorner](https://read.unicorner.news/p/daytona);
    [Daytona Raises $24M Series A (2026)](https://www.prnewswire.com/news-releases/daytona-raises-24m-series-a-to-give-every-agent-a-computer-302680740.html)

---

## Positioning & notable characterizations

> Items here separate **fact** from **reported characterization**, with attribution.

- **Part of the "AI code sandbox" cohort (with E2B and Modal).** By 2026,
  third-party comparisons routinely group Daytona with **E2B**, **Modal**, and
  **Vercel Sandbox** as the contenders for AI-agent sandbox workloads, with
  Daytona's differentiator pitched as the **fastest cold start** and **E2B**
  (Firecracker) and **Modal** (gVisor, plus GPU-in-sandbox) occupying adjacent
  niches.
  - Source: [Daytona vs E2B vs Modal vs Vercel Sandbox: A 2026 Comparison — StartupHub.ai](https://www.startuphub.ai/ai-news/artificial-intelligence/2026/daytona-vs-e2b-vs-modal-vs-vercel-sandbox-2026)
  - Source: [AI Code Sandbox Benchmark 2026 — Modal vs E2B vs Daytona — Superagent](https://www.superagent.sh/blog/ai-code-sandbox-benchmark-2026)
  - That Daytona has the "fastest cold start" is a **marketing claim** relayed by
    comparison blogs; the **fact** is the cohort grouping and Daytona's own
    sub-90ms figure.

- **The pivot as a "high-conviction" bet.** Sunsetting a shipping product and
  releasing its customer base to rebuild for a new user (agents) is presented by
  Burazin as a deliberate, non-obvious decision. Whether this was bold or risky
  is opinion; the **fact** is the sunset-and-rebuild and the subsequent Series A.
  - Source: [Daytona: Instant sandboxes for AI agents — Unicorner](https://read.unicorner.news/p/daytona)

- **No major public controversy located.** No significant security incident,
  outage postmortem, or pricing/licensing controversy specific to Daytona
  surfaced in this research pass. (The 2024→2025 license change from **Apache
  2.0** to **AGPL-3.0** accompanied the product rebuild; no controversy around it
  was located.) **Could not verify** the existence of any such event; absence of
  a finding is **not** proof of absence.
  - Source (license change visible in repo metadata): [daytonaio/daytona — GitHub](https://github.com/daytonaio/daytona)

---

## Items marked "Could not verify"

- **Exact founding month/day of Daytona (2023)** and the precise legal entity
  name — "2023" is the year used by Daytona and coverage; no first-party
  incorporation document was located.
- **Exact Codeanywhere launch date** ("May 22, 2013" is secondary, from Tracxn)
  and the **founding year of the Shift conference** ("2012" is secondary).
- **Chronological order of Shift vs. Infobip** in Burazin's career — Daytona's
  own copy and secondary coverage are inconsistent.
- **Any 2025 Daytona funding round** — none located; the 2025 event was the
  **product pivot/relaunch**, and the next financing was the **Feb 2026 $24M
  Series A**.
- **The "late April 2025" relaunch date** and the **"$1M ARR within two months"**
  claim — secondary/company-relayed, not confirmed against a dated first-party
  Daytona announcement.
- **Cold-start figures (sub-90ms / "27ms optimized")** and the
  **container-by-default + optional Kata/Sysbox** isolation characterization —
  Daytona marketing and third-party comparison blogs; not independently
  benchmarked or confirmed against a first-party architecture doc here.
- **Revenue/traction figures** ($1M→$2M "forward revenue run rate") — company-
  stated, relayed by press; not audited.
- **Further biographical detail on Goran Draganić** — not located in a
  first-party source in this pass.
- **Any Daytona-specific controversy** — none located; could not be verified
  either way.
