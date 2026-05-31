# Val Town — A Sourced History (Runnable Gists → AI App-Builder in the Browser)

A chronological, sourced history of **Val Town** — the New York–based startup
founded by **Steve Krouse** (with **Tom MacWright** as co-founder/CTO) that built
a "**social website to write and deploy** TypeScript/JavaScript **vals**"
(serverless functions, cron jobs, and HTTP endpoints) entirely in the browser.
Every non-trivial claim links to a working source. Primary sources (Val Town's own
blog, the founders' posts, the official "About" page, funding announcements) are
preferred, with reputable corroboration (Simon Willison, podcasts, Product Hunt)
where useful. This is a **smaller, younger company** than the other subjects in
this corpus, so the record is kept proportionate, and gaps are flagged rather than
padded. Items that could not be confirmed are marked **"Could not verify."**
Last verified: 2026-05-31.

---

## Timeline

### 2022 — Origins: the first runtime and the pre-seed

- Val Town's first runtime — a prototype built on **Node.js's built-in `vm`
  module** — dates to **July 2022**, per Tom MacWright's "first four runtimes"
  retrospective.
  Source (Val Town blog): <https://blog.val.town/blog/first-four-val-town-runtimes/>
- **August 2022 — $1.5M pre-seed.** In Val Town's seed-round post, Steve Krouse
  writes that Accel's **Dan Levine** "led our **$1.5m pre-seed in August 2022**"
  — described as happening **"before the first line of code"** of the funded
  company.
  Source (Val Town blog): <https://blog.val.town/blog/seed/>
- The product is framed by Val Town's own "About" page with the tagline
  **"If GitHub Gists could run and AWS Lambda were fun."** It calls Val Town
  "an automation & internal tools platform for programmers" and says programming
  in it should feel "**more like editing a spreadsheet than using an IDE**."
  Source (Val Town): <https://www.val.town/about>
  - **Note on the founding year:** Multiple sources place the founding in **2022**
    (the pre-seed and first runtime are both August/July 2022), while MacWright's
    own retrospective frames the active company build as **"early 2023"** and says
    he joined "shortly after [Krouse] as cofounder/CTO."
    Source: <https://macwright.com/2025/11/11/val-town>
    **Could not verify** a single precise incorporation date against a primary
    filing; treat **2022** as the origin year (first code + pre-seed) and note
    MacWright joined around the **early-2023** company formation.

### What a "val" is, and the product concept

- A **val** is a snippet of JavaScript/TypeScript that runs server-side — as a
  script, on a **schedule (cron)**, or as an **HTTP endpoint / web service** —
  written and deployed from the browser with no infrastructure setup. Val Town's
  About page describes creating "APIs, schedule crons, email yourself, and persist
  data" with versioned code that "executes immediately."
  Source (Val Town): <https://www.val.town/about>
- The "runnable GitHub Gist" framing is core to how the product was understood.
  Val Town's own marketing leads with "**If GitHub Gists could run…**"
  (<https://www.val.town/about>), and the idea was widely retold that way — e.g.
  a Hacker News submission titled *"Val town has a cool idea of making gists
  runnable."*
  Source (HN): <https://news.ycombinator.com/item?id=40139196>
  - **Could not verify** a "CodePen for the backend" phrasing as a primary Val
    Town tagline. **Simon Willison**, who covered Val Town repeatedly, describes
    it functionally — "Val Town provides a web interface for building, running and
    deploying server-side JavaScript apps" — rather than with that slogan.
    Source: <https://simonwillison.net/tags/val-town/>

### The untrusted-code problem: a runtime evolution (2022–2024)

Because Val Town runs **arbitrary, untrusted user code**, sandboxing has been a
central engineering concern. MacWright's "first four runtimes" post (published
**February 8, 2024**) lays out the sequence:

- **Runtime 1 — Node.js `vm` (July 2022 → ~Sept 2022):** a prototype; the `vm`
  module's own docs warn it "is not a security mechanism. Do not use it to run
  untrusted code."
- **Runtime 2 — Node.js `vm2` (from ~September 2022):** the `vm2` package
  attempted real isolation, but **sandbox escapes "kept coming"** and the
  maintainer ultimately **deprecated `vm2`**.
- **Runtime 3 — Deno + Workers:** a separate Deno server improved security
  substantially but suffered memory growth over time.
- **Runtime 4 — Node.js + Deno subprocesses (current as of the post):** vals run
  as "**temporary Deno subprocesses of a Node.js server**" via the **`node-deno-vm`**
  module (a WebSocket/postMessage bridge between Node and Deno).
  Source (Val Town blog, MacWright, Feb 8 2024):
  <https://blog.val.town/blog/first-four-val-town-runtimes/>
- MacWright separately credits the Deno move as decisive: "**we haven't identified
  a single security bug caused by Deno**," contrasting it with the earlier `vm2`
  era (where, e.g., Express's `response.download(path)` could exfiltrate arbitrary
  server files).
  Source (retrospective): <https://macwright.com/2025/11/11/val-town>
- The Feb 2024 post is explicit that "**v4 is not the last version of the Val Town
  runtime**" and discusses learning from **Firecracker** (the microVM tech behind
  AWS Lambda) without committing to it.
  Source: <https://blog.val.town/blog/first-four-val-town-runtimes/>
  - **Could not verify** that Val Town has actually **migrated to microVMs /
    Firecracker** in production. As of the latest sources reviewed, its production
    isolation is **process isolation** (Deno subprocesses) — a Nov 1, 2024 post
    refers to "the runtime strategy that we use today, which uses process isolation."
    Source: <https://blog.val.town/blog/val-town-town/>
    The brief's "move to microVMs" is therefore flagged as **aspirational/discussed,
    not confirmed-complete**.

### October 2023 — V3 redesign (standard ESM imports)

- MacWright dates a **V3 redesign to October 2023**, in which Val Town dropped its
  bespoke `@username.helper` import syntax in favor of "**standard ESM import
  syntax**," normalizing the platform toward ordinary JavaScript tooling. The
  original interface had been "**heavily inspired by Twitter**," with an
  infinite-scrolling list of vals.
  Source (retrospective): <https://macwright.com/2025/11/11/val-town>

### 2024 — The AI/Townie turn

- **Summer 2024 — JP Posma's intern project.** MacWright credits **JP Posma**,
  who joined as a **summer 2024 intern**, with "**inject[ing] some AI-abilities
  into Val Town**," building RAG-powered search and the first version of the
  **Townie** chatbot.
  Source (retrospective): <https://macwright.com/2025/11/11/val-town>
- **September 26, 2024 — Townie AI.** Val Town announced **Townie**, described as
  "our AI assistant that helps you build apps," turning prompts into deployed
  applications. MacWright notes this landed "around the same time as a lot of the
  'vibe-coding' applications, like Bolt and Lovable," but attached to a platform
  that actually runs the code.
  Sources (Val Town blog): <https://blog.val.town/blog/townie/> ;
  (retrospective) <https://macwright.com/2025/11/11/val-town>
- **Business impact:** MacWright writes Townie "became **a huge growth driver for
  a while**," with many users "**hearing about Townie first**" before realizing Val
  Town could run code and act as a community. But vibe-coding users "**really don't
  want to pay**," so Val Town moved Townie to **pay-as-you-go** pricing — after
  which Townie became "**profitable pretty quickly**." Townie credits carry a
  reported **~50% markup over raw LLM cost**.
  Sources: <https://macwright.com/2025/11/11/val-town> ;
  (Townie credits) <https://blog.val.town/townie-credits>

### April 9, 2024 — $5.5M seed (Accel-led)

- On **April 9, 2024**, Steve Krouse announced Val Town's **seed round: "$5.5m in a
  round led by Accel,"** with Accel's **Dan Levine** joining the board. The same
  post lists a long roster of angel investors.
  Source (Val Town blog, Krouse): <https://blog.val.town/blog/seed/>
- **Named angels (from the seed post / About page):** Tom Preston-Werner,
  Guillermo Rauch, James Lindenbaum, Adam Wiggins, David Cramer, Simon Last,
  Calvin French-Owen, Matt McClure, Tod Sacerdoti, Cristina Cordova, Matt Brezina,
  Ben Vinegar, Chet Corcos, Devon Zuegel, Sebastian Bensusan, Linus Lee, Michelle
  Lim, Dan Shipper, Shawn "swyx" Wang, Meagan Gamache, Yasyf Mohamedali, Daniel
  Marcotte, Nick Arner, Jordan Scales, plus **Zapier's investment fund**.
  Sources: <https://blog.val.town/blog/seed/> ; <https://www.val.town/about>
- The seed post also names the early team beyond the two co-founders: **Max
  McDonnell** and **André Terron**.
  Source: <https://blog.val.town/blog/seed/>

### 2025 — Townie deepens; MCP/CLI; per-val SQLite

- During 2024–2025 Val Town shipped a **Val Town MCP server** and a **`vt` CLI**
  ("so you can work on vals wherever you get your LLMs"), gave **every val its own
  SQLite database**, and rebuilt Townie "in product-space." By its **5th version**,
  Townie "**lives alongside your code editor, powered by the Claude 4.5 family**"
  and is pitched as "**like Claude Code, but in the browser**," optimized for Val
  Town's runtime.
  Sources (Val Town blog): <https://blog.val.town/townie-v5> ;
  (retrospective) <https://macwright.com/2025/11/11/val-town>

### Late 2025 — Retrospective: a smaller team, a GTM focus, break-even target

- In a **November 11, 2025** retrospective, MacWright reports the team is "**three
  people**" (down from five), citing departures of **Charmaine to Anthropic** and
  **Max to Cloudflare**. He states break-even is "**the goal for 2026, and it's
  optimistically possible**," and that go-to-market has shifted toward selling
  "tools for 'Go To Market'" (signup capture, CRM integration). The post lists
  open roles at **$175k salary / 1% equity**.
  Source: <https://macwright.com/2025/11/11/val-town>
  - **Could not verify** these team-size, headcount, and break-even figures
    against any second independent source; they are **self-reported** by a
    co-founder and are treated as such.

---

## Key people & teams

- **Steve Krouse** — **Co-founder & CEO.** Before Val Town he was a prominent
  figure in the **"Future of Coding"** community: he **created and hosted the
  Future of Coding podcast/community**, maintained an open research log
  (2017–2019), and **stepped away in late 2019**, handing podcast/community
  stewardship to **Ivan Reese**. He has described founding the earlier startups
  **Compose** and **Zaplib** before Val Town, and has a background in programming
  education (e.g., teaching kids to code, the "woof.js" tool).
  Sources: <https://futureofcoding.org/about> (the Future of Coding "About" page,
  to which futureofcoding.org now redirects) ;
  (interview) <https://changelog.com/jsparty/287>
  - **Could not verify** the precise dates/outcomes of Compose and Zaplib against
    primary sources; they are referenced in Krouse's own bios and interviews and
    treated as **self-reported**.
- **Tom MacWright** — **Co-founder & CTO**, joined "shortly after" Krouse. Known
  in the geospatial/JS open-source world; author of the detailed engineering
  retrospectives cited throughout this doc.
  Source: <https://macwright.com/2025/11/11/val-town>
- **Early team (per the seed post / About):** **Max McDonnell**, **André Terron**,
  plus later additions including **Brent Jackson** (design-engineer) and **Pete
  Millspaugh** (writer-engineer); **JP Posma** built the first AI/Townie features
  as a 2024 intern.
  Sources: <https://blog.val.town/blog/seed/> ; <https://www.val.town/about> ;
  <https://macwright.com/2025/11/11/val-town>
- **Notable backer:** **Dan Levine (Accel)** — led both the **$1.5M pre-seed
  (Aug 2022)** and the **$5.5M seed (Apr 2024)**, and sits on the board.
  Source: <https://blog.val.town/blog/seed/>

---

## Company & corporate history

- **Product arc:** browser-based "runnable Gist" for server-side JS/TS vals
  (scripts, crons, HTTP endpoints) → standard-ESM platform (V3, Oct 2023) →
  AI-assisted app-building via **Townie** (Sept 2024) → AI agent "like Claude Code
  in the browser" plus MCP server, `vt` CLI, and per-val SQLite (2024–2025).
  Sources: <https://www.val.town/about> ;
  <https://blog.val.town/blog/townie/> ; <https://blog.val.town/townie-v5>
- **Funding ladder (verified):** **$1.5M pre-seed** (Accel/Dan Levine, **Aug
  2022**) → **$5.5M seed** (Accel/Dan Levine, announced **Apr 9, 2024**).
  Source: <https://blog.val.town/blog/seed/>
  No later round was located in this pass; **Could not verify** any Series A.
- **Runtime / security substrate:** Node `vm` → `vm2` → Deno+Workers → **Node +
  Deno subprocesses (`node-deno-vm`, process isolation)**, with Firecracker/
  microVMs discussed as a possible future but **not confirmed adopted**.
  Sources: <https://blog.val.town/blog/first-four-val-town-runtimes/> ;
  <https://blog.val.town/blog/val-town-town/>
- **Mission (company-stated):** "**Our mission is end-user programming. Everyone
  should be able to build software, tailor apps to their needs, and automate their
  lives.**"
  Source: <https://blog.val.town/blog/seed/>
- **Status (per co-founder, late 2025):** a small (~3-person) NYC startup, Townie
  now a paid/profitable line, targeting **break-even in 2026**, refocusing on
  go-to-market tooling.
  Source: <https://macwright.com/2025/11/11/val-town>

---

## Controversies & tensions

> Val Town is small and has not been the subject of the kind of marquee public
> controversy seen elsewhere in this corpus. The genuine, sourced *tensions* are
> technical and commercial rather than scandalous; they are recorded here as such.

### 1. Running untrusted code — repeated sandbox-escape risk

- **Fact:** Val Town's core technical risk is executing **arbitrary untrusted
  code**. Its early `vm2`-based sandbox suffered real escapes — `vm2` was
  **deprecated by its maintainer after "sandbox escapes kept coming"** — and
  MacWright documents a concrete `vm2`-era exfiltration vector (Express's
  `response.download(path)` sending arbitrary server files). The fix was the move
  to **Deno**, after which MacWright says **no Deno-caused security bug** had been
  identified.
  Sources: <https://blog.val.town/blog/first-four-val-town-runtimes/> ;
  <https://macwright.com/2025/11/11/val-town>
- Val Town also maintains public **security disclosures** (e.g. "Security
  Disclosure 1"), consistent with the inherent risk of a code-running platform.
  Source (referenced; index): <https://blog.val.town/>
  **Could not verify** the contents/severity of specific disclosure posts in this
  pass.

### 2. The "vibe-coding" monetization problem (commercial tension)

- **Fact (co-founder-stated):** MacWright is candid that AI/vibe-coding usage drove
  big top-of-funnel growth but that those users "**really don't want to pay**,"
  forcing a shift to **pay-as-you-go** Townie pricing to make the AI feature
  profitable — and that the company is still working toward **break-even (2026
  goal)**. This is a real strategic tension (growth vs. unit economics), reported
  by Val Town itself rather than alleged by outsiders.
  Sources: <https://macwright.com/2025/11/11/val-town> ;
  <https://blog.val.town/townie-credits>

---

## Items marked "Could not verify"

- **Exact incorporation/founding date.** **2022** is supported (first runtime July
  2022; pre-seed Aug 2022 "before the first line of code"), but MacWright frames
  the active company build as **early 2023**; no primary incorporation filing was
  located. Sources: <https://blog.val.town/blog/seed/> ;
  <https://blog.val.town/blog/first-four-val-town-runtimes/> ;
  <https://macwright.com/2025/11/11/val-town>
- **A completed move to microVMs / Firecracker.** Discussed as a future direction
  in Feb 2024, but production isolation is described as **process isolation (Deno
  subprocesses)** as recently as Nov 2024. The brief's "move to microVMs" is
  **not confirmed**. Sources:
  <https://blog.val.town/blog/first-four-val-town-runtimes/> ;
  <https://blog.val.town/blog/val-town-town/>
- **"CodePen for the backend" as an official tagline.** Not verified; Val Town's
  own slogan is **"If GitHub Gists could run and AWS Lambda were fun."** Simon
  Willison describes it functionally, not with that phrase. Sources:
  <https://www.val.town/about> ; <https://simonwillison.net/tags/val-town/>
- **Steve Krouse's prior startups Compose and Zaplib** — referenced in his own
  bios/interviews but **not pinned to primary sources** here. Sources:
  <https://futureofcoding.org/about> ; <https://changelog.com/jsparty/287>
- **Any funding after the Apr 2024 seed** (e.g. a Series A) — **none located**;
  the verified ladder ends at the $5.5M seed. Source:
  <https://blog.val.town/blog/seed/>
- **Late-2025 headcount, departures, and break-even figures** — **self-reported**
  by MacWright; no independent corroboration found. Source:
  <https://macwright.com/2025/11/11/val-town>
- **Crunchbase round detail pages** (pre-seed/seed) returned **403/blocked** to
  automated fetching; the round facts here rely on Val Town's **own** seed post
  rather than Crunchbase.

---

## Sources (primary & reputable, deduplicated)

- Val Town blog — Seed round ($5.5M, Accel; Apr 9 2024; pre-seed Aug 2022; mission; angels): <https://blog.val.town/blog/seed/>
- Val Town — About page (tagline, mission, team, "spreadsheet not IDE"): <https://www.val.town/about>
- Val Town blog — "The first four Val Town runtimes" (MacWright, Feb 8 2024; sandbox history): <https://blog.val.town/blog/first-four-val-town-runtimes/>
- Val Town blog — "Val Town Town" (Nov 1 2024; "process isolation … we use today"): <https://blog.val.town/blog/val-town-town/>
- Val Town blog — "Introducing Townie AI" (Sept 26 2024): <https://blog.val.town/blog/townie/>
- Val Town blog — "Townie's back in town!" (v5; Claude 4.5; "like Claude Code in the browser"): <https://blog.val.town/townie-v5>
- Val Town blog — Townie Credits (pay-per-use; ~50% markup): <https://blog.val.town/townie-credits>
- Val Town blog — index (security disclosures, newsletters): <https://blog.val.town/>
- Tom MacWright — "Val Town 2023–2025 Retrospective" (Nov 11 2025): <https://macwright.com/2025/11/11/val-town>
- Future of Coding — About (Steve Krouse; redirect target of futureofcoding.org): <https://futureofcoding.org/about>
- JS Party #287 — "Take me to Val Town featuring Steve Krouse": <https://changelog.com/jsparty/287>
- Simon Willison — val-town tag (functional description / coverage): <https://simonwillison.net/tags/val-town/>
- Hacker News — "Val town has a cool idea of making gists runnable": <https://news.ycombinator.com/item?id=40139196>
- Product Hunt — Val Town ("If GitHub Gists could run and AWS Lambda were fun."): <https://www.producthunt.com/products/val-town>
