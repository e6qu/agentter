# E2B (e2b.dev) — A Sourced History

A chronological, fully-sourced history of **E2B** (legal entity **FoundryLabs,
Inc.**) — the company behind **open-source, secure cloud sandboxes** (built on
AWS **Firecracker microVMs**) for **running AI-agent / LLM-generated code**,
positioning itself as "the runtime for AI agents." E2B was founded in **2023**
by Czech childhood friends **Vasek (Václav) Mlejnsky** (CEO) and **Tomas
(Tomáš) Valenta** (CTO).

Every non-trivial claim below carries a working source link. Primary sources
(E2B's blog/GitHub, the founders' own posts and interviews, funding
announcements) are preferred, with reputable outlets (TechCrunch-tier trade
press, SiliconANGLE, VentureBeat, regional tech outlets) as corroboration.
Where a detail could not be confirmed against a primary or reputable secondary
source, it is explicitly flagged with **Could not verify:**. Opinions and
characterizations are attributed to their sources.

> **Cross-references (not duplicated here):**
> - For how **Firecracker** compares to **gVisor**, Kata, and WASM as isolation
>   primitives, and where E2B sits in the broader microVM/sandbox landscape
>   (alongside Modal, Fly.io, CodeSandbox), see
>   `history/WASM_DOCKER_alternate_history.md`, `history/fly-io.md`, and
>   `history/modal.md`. E2B uses **Firecracker** (AWS's KVM-based microVM
>   monitor), like Fly.io; **Modal** uses **gVisor**. Among this cohort E2B is
>   the one most narrowly built around *AI-generated code execution* as the
>   product, rather than as one feature of a general compute platform.

---

## Timeline

### 2023 — Founding, out of a pivot from DevBook

- **Pre-E2B: DevBook.** Before E2B, Mlejnsky and Valenta spent years building
  developer tools. Their immediate predecessor product was **DevBook**, an
  interactive in-browser documentation/playground that let developers try tools
  without local setup (a notable user being Prisma's interactive playground).
  E2B's sandbox technology was repurposed directly from DevBook's playground
  infrastructure.
  - Source (founders' own account, interview): [Why Every Agent needs Open Source Cloud Sandboxes — Latent Space (interview with Mlejnsky & Valenta)](https://www.latent.space/p/e2b)

- **The childhood-friends backstory.** Mlejnsky and Valenta have known each
  other since around the sixth grade and worked together on projects from then;
  they studied at the **Faculty of Mathematics and Physics** (Charles
  University, Prague is the common reading) and earlier built iPhone games
  before moving through computer vision and developer tooling.
  - Source: [Czech Startup E2B Raises $11.5M to Build Cloud Infrastructure for AI Agents — The Recursive (Oct 2024)](https://therecursive.com/czech-startup-e2b-raises-11-5m-to-build-cloud-infrastructure-for-ai-agents/)
  - Source (iPhone-games + computer-vision background): [Czech Startup E2B Secures $11.5M — The AI Insider (Oct 21, 2024)](https://theaiinsider.tech/2024/10/21/czech-startup-e2b-secures-11-5m-to-develop-cloud-infrastructure-for-ai-agents/)
  - **Could not verify** the specific university ("Faculty of Mathematics and
    Physics") name against a first-party E2B source; it comes from secondary
    profiles. The "childhood friends / sixth grade" framing is repeated across
    secondary coverage, not a first-party E2B statement.

- **March 2023 — the GPT-3.5 pivot.** After burnout on DevBook's stalled
  growth, the founders took a roughly two-week break to experiment with the
  newly released **GPT-3.5**. They built a developer-automation agent that
  could pull GitHub repos, write code, start servers, run tests, and deploy
  (to Railway) — an early "Devin-like" agent built on DevBook's existing
  sandbox tech.
  - Source: [Latent Space interview](https://www.latent.space/p/e2b)

- **The viral demo + Greg Brockman.** Mlejnsky tweeted the agent demo; per his
  own account in the Latent Space interview, **Greg Brockman** (OpenAI) retweeted
  it and the post reached roughly **half a million views** within a few days,
  amid OpenAI co-founders broadly promoting GPT-3.5. Within about two days the
  founders pivoted from building the agent itself to focusing on the underlying
  **sandbox infrastructure**, and open-sourced it.
  - Source: [Latent Space interview](https://www.latent.space/p/e2b)
  - **Attribution:** the "Greg Brockman retweet" and "~500k views" are
    **Mlejnsky's own recollection** in the interview. **Could not verify** the
    specific tweet or view count against an archived primary tweet.

- **The name "E2B" = "English to Bits."** Per the founders' account, the
  organization started unnamed ("the AI company") and the name **E2B** derives
  from **"English to Bits."**
  - Source: [Latent Space interview](https://www.latent.space/p/e2b)

- **Founded 2023.** Multiple sources date the company's founding to **2023**;
  secondary coverage commonly gives **March 2023** as the month the founders
  began the pivot that became E2B.
  - Source (2023 founding): [The Recursive (Oct 2024)](https://therecursive.com/czech-startup-e2b-raises-11-5m-to-build-cloud-infrastructure-for-ai-agents/)
  - Source (founders' framing "back in 2023, when Tomas Valenta and I started"): [Vasek Mlejnsky — "E2B's Hypothesis" (LinkedIn)](https://www.linkedin.com/posts/mlejva_back-in-2023-when-tomas-valenta-and-i-started-activity-7414743704227241986-xJWu)
  - **Could not verify** an exact founding *month/day* or the incorporation date
    of the legal entity **FoundryLabs, Inc.** against a first-party document; the
    "March 2023" month is from the founders' interview narrative of the pivot,
    not a stated incorporation date.

### 2024 — The Code Interpreter SDK and the seed round

- **April 2024 — open-source Code Interpreter SDK (Show HN).** E2B publicly
  launched its **Code Interpreter SDK** — a Python & JS/TS SDK for running
  AI-generated code in a secure sandbox. In the Hacker News launch thread,
  Mlejnsky (as CEO) described E2B as building "secure environments for running
  untrusted AI-generated code and AI agents" using **Firecracker microVMs**
  "instead of containers," chosen "for their security and ability to do
  snapshots." The SDK works by "spawning an E2B sandbox with Jupyter Server" and
  communicating via the Jupyter kernel messaging protocol. He framed E2B as "a
  boring code execution layer" with no LLM wrapping or agent framework, and
  stated the long-term goal of building "an automated AWS for AI apps and agents
  where AI can build and deploy its own software" — all open source.
  - Source (primary, founder post): [Show HN: E2B – Open-source Code Interpreter SDK — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045)
  - The core repository is **Apache-2.0 licensed**; the Code Interpreter SDK ships
    as `@e2b/code-interpreter` (JS/TS) and `e2b-code-interpreter` (Python), with
    a `runCode()` / `run_code()` entry point.
    - Source: [e2b-dev/E2B — GitHub](https://github.com/e2b-dev/E2B)
  - **Could not verify** the exact Show HN *date* against the HN item's
    timestamp here; the SDK launch is documented by the thread itself (cited
    above). Marked: **Could not verify: exact Code Interpreter SDK launch date.**

- **October 18, 2024 — Seed round: $11.5M (€10.6M), led by Decibel.** E2B raised
  an **$11.5 million** seed round led by **Alessio Fanelli of Decibel
  Partners**, with **Kaya VC** (Czech fund) and (per some coverage) Sunflower
  Capital and angels participating. Coverage reported E2B sandboxes had been
  launched **over six million times since January 2024**, with users including
  **Perplexity** and the **PGA**.
  - Source (date + lead): [Seed Round — E2B — Crunchbase (2024-10-18)](https://www.crunchbase.com/funding_round/e2b-1c91-seed--6b20b90e)
  - Source (lead = Decibel/Fanelli, Kaya VC, 6M sandboxes, Perplexity/PGA): [The AI Insider (Oct 21, 2024)](https://theaiinsider.tech/2024/10/21/czech-startup-e2b-secures-11-5m-to-develop-cloud-infrastructure-for-ai-agents/)
  - Source (Kaya VC quote — Karel Zheng: "a pioneer in AI agent infrastructure"): [The Recursive (Oct 2024)](https://therecursive.com/czech-startup-e2b-raises-11-5m-to-build-cloud-infrastructure-for-ai-agents/)
  - Source (Czech outlet corroborating $11.5M seed from Decibel and Kaya): [Czech cloud startup E2B raises $11.5M in seed funding from Decibel and Kaya VC — AIN (Oct 18, 2024)](https://en.ain.ua/2024/10/18/e2b-raises-11m-in-seed-funding/)
    - **Note:** The AIN article body is subscriber-gated; only the headline/lede
      (which encode the $11.5M figure, Decibel, and Kaya VC) were retrievable.
  - **Could not verify** Sunflower Capital's participation in the *seed* round
    against a first-party E2B source; it is named consistently as a *Series A*
    co-investor (below) and appears in some seed coverage as well.

### 2025 — The AI-agent wave and the Series A

- **The Manus integration.** E2B became infrastructure for **Manus**, the
  autonomous multi-agent product: E2B's Firecracker microVMs serve as the
  "virtual computers" Manus agents operate, running Python, JavaScript, Bash and
  more, in persistent sessions that can last hours.
  - Source (primary, E2B blog): [How Manus Uses E2B to Provide Agents With Virtual Computers — E2B Blog](https://e2b.dev/blog/how-manus-uses-e2b-to-provide-agents-with-virtual-computers)

- **July 28, 2025 — Series A: $21M, led by Insight Partners.** E2B announced a
  **$21 million Series A** led by **Insight Partners**, with **Decibel**,
  **Sunflower Capital**, and **Kaya** participating, plus angels including
  **Scott Johnston** (former **Docker** CEO). E2B reported adoption by **88% of
  the Fortune 100** (signed up), use across "more than half of the Fortune 500,"
  and **hundreds of millions of sandboxes** launched. Named customers included
  **Hugging Face, Perplexity, Groq, Manus, LMArena, Genspark, and Lindy**.
  E2B's own post puts total funding to date at **$32M** and confirms the legal
  entity **FoundryLabs, Inc.** (San Francisco HQ).
  - Source (primary): [We Raised $21M to Give Fortune 100 Cloud for AI Agents — E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)
  - Source (coverage, customers, quotes): [E2B shares its vision of sandboxed, cloud environments for every AI agent after raising $21M — SiliconANGLE (Jul 28, 2025)](https://siliconangle.com/2025/07/28/e2b-shares-vision-sandboxed-cloud-environments-every-ai-agent-raising-21m-funding/)
  - Source (coverage / "essential to 88% of Fortune 100"): [How E2B became essential to 88% of Fortune 100 companies and raised $21 million — VentureBeat](https://venturebeat.com/ai/how-e2b-became-essential-to-88-of-fortune-100-companies-and-raised-21-million)
  - Mlejnsky's framing in coverage: *"How can we expect AI agents to do the same
    work as humans if we can't give them the same environment to use the tools we
    use?"*
    - Source: [SiliconANGLE (Jul 28, 2025)](https://siliconangle.com/2025/07/28/e2b-shares-vision-sandboxed-cloud-environments-every-ai-agent-raising-21m-funding/)
  - **The "iOS for AI Agents" framing** appears in regional coverage of the
    Series A; E2B's own post frames it as the **"cloud for AI agents"** and a
    universal **sandbox protocol/standard**.
    - Source (framing): [Czech-founded E2B Raises Series A to Become the "iOS for AI Agents" — The Recursive](https://therecursive.com/e2b-raises-21m-to-scale-ai-agent-infrastructure/)
    - **Note:** The Recursive article body is subscriber-gated; the "iOS for AI
      agents" framing is in its headline/lede.
  - **Reconciling totals:** E2B's blog states **$32M total** raised; some
    secondary profiles cite **$35M**. Treat **$32M** (E2B's own figure, July
    2025) as authoritative for that date; the $35M figure may reflect later or
    rounded reporting. Marked: **Could not verify: $35M total** (vs. E2B's
    stated $32M).
    - Source ($32M): [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)
    - Source ($35M, secondary): [E2B — Tracxn company profile](https://tracxn.com/d/companies/e2b/__U7C82j6Wk3VH-rgW0n4LFnUqqq-LuBw6rnIcnLGz2yU)

- **Planned enterprise direction (per the Series A post).** E2B described
  extending into a standardized interface for agents to control diverse
  environments — Linux interpreters, Windows VMs, Chrome browsers — runnable on
  Kubernetes, GCP, Azure, AWS, Cloudflare, or a customer VPC, plus enterprise
  modules: **Secrets Vault, Sandbox Observability, Shared Context**.
  - Source: [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)

### 2025–2026 — "Coding agents are the general agents"

- **The maturing thesis.** Mlejnsky later articulated E2B's core hypothesis from
  2023: *"Coding agents are the general agents because code is a general tool"* —
  i.e., building the best runtime for coding agents yields the best runtime for
  *all* AI agents, with sandboxing as the foundational building block (code being
  usable to generate "slides, videos, ads, and of course building close to any
  software you want").
  - Source: [Vasek Mlejnsky — "E2B's Hypothesis" (LinkedIn)](https://www.linkedin.com/posts/mlejva_back-in-2023-when-tomas-valenta-and-i-started-activity-7414743704227241986-xJWu)

- **Continued scale.** As of the Series A post (July 2025), E2B reported
  "hundreds of millions of sandboxes launched." The GitHub org's core repo
  (`e2b-dev/E2B`) shows continued active releases into 2026 (e.g., a Python SDK
  release dated **May 29, 2026**).
  - Source (sandbox scale): [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)
  - Source (active development): [e2b-dev/E2B — GitHub](https://github.com/e2b-dev/E2B)
  - **Could not verify** any **post-Series-A round, later valuation, or revenue
    figure** for E2B against a primary or reputable secondary source as of this
    research pass. Marked: **Could not verify: any E2B funding/valuation after
    the July 2025 Series A.**

---

## Technology (Firecracker microVMs, sandboxes, Code Interpreter)

Sourced primarily to E2B's GitHub, the founders' HN launch post and interview,
and the Manus integration write-up.

- **Sandboxes = Firecracker microVMs.** E2B runs AI-generated/untrusted code in
  **Firecracker microVMs** rather than containers, chosen (per Mlejnsky) for
  **security** and the ability to do **snapshots**. Each sandbox is an isolated,
  ephemeral virtual machine.
  - Source (founder, primary): [Show HN — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045)
  - Source (Manus use of Firecracker microVMs as "virtual computers"): [How Manus Uses E2B — E2B Blog](https://e2b.dev/blog/how-manus-uses-e2b-to-provide-agents-with-virtual-computers)
  - (Firecracker itself — AWS's KVM-based microVM monitor, open-sourced Nov 2018,
    also powering Lambda/Fargate and Fly.io — is covered in
    `history/fly-io.md` and `history/WASM_DOCKER_alternate_history.md`.)

- **Code Interpreter SDK.** A Python & JS/TS SDK that spins up an E2B sandbox
  running a **Jupyter Server**, letting an LLM execute code and communicate via
  the Jupyter kernel protocol. The broader E2B SDK can run "almost any language"
  via custom sandboxes (the founders cite R as an example).
  - Source (primary): [Show HN — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045)
  - Source (packages, API): [e2b-dev/E2B — GitHub](https://github.com/e2b-dev/E2B)

- **Open source.** The core E2B repository is **Apache-2.0 licensed** and
  self-hostable; E2B's stated strategy treats the sandbox layer as an open
  standard/protocol rather than a closed service.
  - Source (license/repo): [e2b-dev/E2B — GitHub](https://github.com/e2b-dev/E2B)
  - Source (open-standard framing): [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)

- **"A boring code execution layer."** E2B deliberately ships *only* the
  execution/sandbox layer — no bundled LLM, prompting, or agent framework —
  leaving those choices to the developer.
  - Source: [Show HN — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045)

---

## Position among the AI-sandbox cohort

E2B is consistently grouped with a cohort of "cloud sandbox / agent runtime"
providers — **Modal**, **Daytona**, **Fly.io**, **Cloudflare** — that emerged or
re-positioned around the 2024–2025 AI-agent wave. Within that group:

- **E2B** is the one built *natively and narrowly* around running
  AI-generated/untrusted code in **Firecracker** microVMs, with an open-source,
  self-hostable core and an explicit "sandbox protocol/standard" ambition.
  - Source: [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)
- **Modal** offers Sandboxes as one product among many on a custom **gVisor**
  container stack (see `history/modal.md`).
- **Fly.io** offers fast-booting **Firecracker** Machines usable as agent
  sandboxes, but as a general public-cloud primitive (see `history/fly-io.md`).
- **Daytona** and **Cloudflare** are named in comparative coverage of the
  same AI-sandbox market.
  - Source (comparative framing): [The New Era of Cloud Agent Infrastructure: E2B and Browserbase — Jimmy Song](https://jimmysong.io/blog/e2b-browserbase-report/)
  - **Attribution / caveat:** the head-to-head comparisons and rankings in
    third-party "best AI sandbox" round-ups are **secondary analysis/opinion**,
    not E2B claims. They are cited here only to document that E2B is consistently
    placed in this cohort, not to endorse any specific ranking. **Could not
    verify** any first-party E2B statement directly comparing itself to Daytona
    or Cloudflare by name.

---

## Key people & teams

- **Vasek (Václav) Mlejnsky** (@mlejva) — co-founder and **CEO**. Czech; built
  developer tools (incl. **DevBook**) with Valenta for years before E2B; author
  of the viral 2023 agent demo and E2B's public "hypothesis" writing.
  - Sources: [Latent Space interview](https://www.latent.space/p/e2b);
    [Vasek Mlejnsky — LinkedIn](https://www.linkedin.com/in/mlejva/);
    [Show HN — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045)

- **Tomas (Tomáš) Valenta** — co-founder and **CTO**. Czech; childhood friend
  and long-time collaborator of Mlejnsky (DevBook, earlier projects).
  - Sources: [Tomas Valenta — LinkedIn](https://www.linkedin.com/in/valentatomas/);
    [Latent Space interview](https://www.latent.space/p/e2b)

- **Notable angels / endorsers.** **Scott Johnston** (former **Docker** CEO)
  among Series A angels; **Alessio Fanelli** (Decibel) led the seed; **Karel
  Zheng** (Kaya VC) and others backed the company.
  - Sources: [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a);
    [The AI Insider (Oct 21, 2024)](https://theaiinsider.tech/2024/10/21/czech-startup-e2b-secures-11-5m-to-develop-cloud-infrastructure-for-ai-agents/);
    [The Recursive (Oct 2024)](https://therecursive.com/czech-startup-e2b-raises-11-5m-to-build-cloud-infrastructure-for-ai-agents/)

---

## Company & corporate history

- **Founded 2023** as an open-source AI-code-sandbox company, pivoting out of
  **DevBook**; legal entity **FoundryLabs, Inc.**, HQ **San Francisco**.
  Czech-founded by **Vasek Mlejnsky** (CEO) and **Tomas Valenta** (CTO).
  - Source (legal entity / HQ): [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a)
  - Source (2023, founders): [The Recursive (Oct 2024)](https://therecursive.com/czech-startup-e2b-raises-11-5m-to-build-cloud-infrastructure-for-ai-agents/)

- **Funding (verified figures):**

  | Round | Date | Amount | Lead | Notes |
  |---|---|---|---|---|
  | Seed | Oct 18, 2024 | $11.5M (€10.6M) | Decibel (Alessio Fanelli) | + Kaya VC, Sunflower/angels; ~6M sandboxes since Jan 2024; Perplexity, PGA cited ([Crunchbase](https://www.crunchbase.com/funding_round/e2b-1c91-seed--6b20b90e), [The AI Insider](https://theaiinsider.tech/2024/10/21/czech-startup-e2b-secures-11-5m-to-develop-cloud-infrastructure-for-ai-agents/)) |
  | Series A | Jul 28, 2025 | $21M | Insight Partners | + Decibel, Sunflower Capital, Kaya; angel Scott Johnston (ex-Docker CEO); total raised $32M; 88% of Fortune 100 signed up ([E2B Blog](https://e2b.dev/blog/series-a), [SiliconANGLE](https://siliconangle.com/2025/07/28/e2b-shares-vision-sandboxed-cloud-environments-every-ai-agent-raising-21m-funding/)) |

  - **Total raised:** **$32M** per E2B's own July 2025 post (some secondary
    profiles say $35M — see caveat above).
  - **No later round or valuation** is documented in the sources reviewed.
    E2B did **not** disclose a valuation for either round in the primary sources
    cited. Marked **Could not verify: any E2B valuation figure.**

- **Adoption (company-stated, as of Jul 2025):** 88% of the Fortune 100 signed
  up; use across >half the Fortune 500; "hundreds of millions of sandboxes"
  launched; customers including Hugging Face, Perplexity, Groq, Manus, LMArena,
  Genspark, Lindy.
  - Source: [E2B Blog (Jul 28, 2025)](https://e2b.dev/blog/series-a);
    [SiliconANGLE (Jul 28, 2025)](https://siliconangle.com/2025/07/28/e2b-shares-vision-sandboxed-cloud-environments-every-ai-agent-raising-21m-funding/)
  - **Attribution:** these are **company-stated traction claims** relayed by the
    press, not audited figures. "88% of the Fortune 100 signed up" measures
    sign-ups, not paid usage.

---

## Culture & notable characterizations

> Items here separate **fact** from **reported characterization**, with attribution.

- **Open-source-first, "boring execution layer" positioning.** E2B's deliberate
  choice to ship only the sandbox/execution layer (no LLM, no agent framework)
  and to keep the core Apache-2.0 and self-hostable is a stated strategy, not a
  third-party claim.
  - Source: [Show HN — Hacker News (item 40099045)](https://news.ycombinator.com/item?id=40099045);
    [e2b-dev/E2B — GitHub](https://github.com/e2b-dev/E2B)

- **The founder-narrative origin story.** E2B's public origin — DevBook burnout
  → GPT-3.5 weekend hack → viral Brockman-retweeted demo → two-day pivot to
  sandboxes — is told primarily by **Mlejnsky himself** (Latent Space, LinkedIn).
  That it is a compelling, well-told story is **observation**; the **fact** is
  that the founders relate this sequence in the cited primary interview.
  - Source: [Latent Space interview](https://www.latent.space/p/e2b)

- **No major public controversy located.** No significant security incident,
  outage postmortem, or pricing controversy specific to E2B surfaced in this
  research pass. Given E2B's product is *executing untrusted AI-generated code*,
  sandbox-escape risk is an inherent concern, but no specific documented
  E2B incident was found. **Could not verify** the existence of any such event;
  absence of a finding is **not** proof of absence.

---

## Items marked "Could not verify"

- **Exact founding month/day** and the **incorporation date** of **FoundryLabs,
  Inc.** ("March 2023" is the pivot month per the founders' interview, not a
  stated incorporation date).
- **The specific viral tweet and "Greg Brockman retweet / ~500k views"** —
  **Mlejnsky's own recollection** in the Latent Space interview; not verified
  against an archived primary tweet.
- **The founders' university** ("Faculty of Mathematics and Physics") — from
  secondary profiles, not a first-party E2B source.
- **Exact Code Interpreter SDK launch / Show HN date** — documented by the HN
  thread itself but the precise date was not separately confirmed here.
- **Sunflower Capital's participation in the *seed*** (vs. clearly named in the
  Series A).
- **Total-raised figure** — E2B's own post says **$32M**; some secondary
  profiles say **$35M**.
- **Any valuation** for either round, and **any funding round after the July
  2025 Series A** — none located in primary or reputable secondary sources as of
  this research pass.
- **Any E2B-specific security/outage/pricing controversy** — none located;
  could not be verified either way.
- **First-party E2B comparisons to Daytona/Cloudflare by name** — comparative
  rankings are third-party analysis, not E2B claims.
