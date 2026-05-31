# Deno & Deno Deploy — A Sourced History

A chronological, sourced history of **Deno** — the JavaScript/TypeScript runtime
created by **Ryan Dahl** (the creator of Node.js) and **Bert Belder**, announced
at JSConf EU in 2018, reaching 1.0 in May 2020 — and of **Deno Deploy**, the
V8-isolate edge-serverless platform built by **Deno Land Inc.** (the Deno
company). It traces Dahl's path from Node.js to Deno, the company's funding, the
Node/npm-compatibility pivot (Deno 2), the framework (Fresh), the Deno Deploy
"Classic" → next-generation rework and its 2026 sunset, and Deno's campaign to
cancel Oracle's **"JavaScript"** trademark.

Every non-trivial claim links to a working source. Primary sources (the Deno
blog, the company's own announcements, USPTO/legal filings as reported, founder
talks) are preferred, with reputable outlets (The Register, InfoWorld, TechCrunch
via Yahoo, The New Stack) as corroboration. Items that could not be confirmed are
marked **"Could not verify."** No quotes are paraphrased as if verbatim; quoted
phrases are attributed to the source that published them.

> **Cross-references (not duplicated here):**
> - Deno Deploy's place in the broader CDN / edge-functions / V8-isolate
>   landscape — alongside **Cloudflare Workers**, **Vercel Edge Functions**, and
>   **Netlify Edge Functions** (which run on Deno Deploy) — is set in
>   [`cloudflare-cdn.md`](./cloudflare-cdn.md). That doc states the market
>   positioning; this doc covers Deno's own runtime and corporate history.
> - Vercel's own history is in [`vercel.md`](./vercel.md). (Vercel's Guillermo
>   Rauch is an early Deno angel investor — see the 2021 seed round below.)

---

## Timeline

### 2009 — Ryan Dahl creates Node.js

Ryan Dahl began work on a server-side JavaScript runtime in early 2009 and first
presented **Node.js** — "evented I/O for V8 JavaScript" — at **JSConf EU 2009** in
Berlin (November 2009), reportedly to a standing ovation.
- JSConf.eu 2009 talk page, "Ryan Dahl: Node.js, Evented I/O for V8 Javascript":
  https://www.jsconf.eu/2009/speaker/speakers_selected.html
- JSConf.eu 2009 video page, "Video: Node.js by Ryan Dahl":
  https://www.jsconf.eu/2009/video_nodejs_by_ryan_dahl.html
- **Could not verify** the exact "January 2009" start date or the
  standing-ovation detail against a primary Dahl source in this pass; the 2009
  JSConf EU debut is sourced via the JSConf.eu pages above. (Node.js itself is
  not the subject of this doc; this entry establishes Dahl's starting point.)

### 2018-06 — "10 Things I Regret About Node.js" and the Deno announcement

At **JSConf EU 2018**, Ryan Dahl gave the talk **"10 Things I Regret About
Node.js,"** in which he catalogued design choices he wished he had made
differently in Node — including removing **Promises** from early Node (he had
added them in 2009 and removed them in 2010), the **GYP** build system, and the
**`node_modules` / `package.json`** dependency model — and used the last portion
of the talk to unveil a prototype of a new, secure TypeScript runtime on V8:
**Deno**.
- JSConf EU 2018 speaker page (Ryan Dahl): https://2018.jsconf.eu/speakers/ryan-dahl-propel-a-machine-learning-framework-for-javascript.html
- Class Central listing of the talk ("10 Things I Regret About Node.js — Ryan
  Dahl — JSConf EU"): https://www.classcentral.com/course/youtube-10-things-i-regret-about-node-js-ryan-dahl-jsconf-eu-234004
- Wikipedia, "Deno (software)" (announced at JSConf EU 2018 in this talk):
  https://en.wikipedia.org/wiki/Deno_(software)
- The talk video is widely cited as YouTube `M3BM9TB-8yA`. **Could not verify**
  the exact talk date (the conference ran in June 2018) against a primary
  schedule in this pass; the JSConf-EU-2018 attribution is sourced above.

### 2018 — From Go to Rust; Tokio replaces libuv

Deno was initially prototyped in **Go** (using Protocol Buffers to serialize
between a privileged Go side and the unprivileged V8 side), but the project soon
switched to **Rust** to avoid "double runtime and garbage-collection pressure,"
and adopted the **Tokio** async runtime in place of Node's **libuv**. A Go-style
**standard library** was started in November 2018. (FlatBuffers, briefly used for
zero-copy serialization, was removed in August 2019 after benchmarks showed
serialization overhead.)
- Wikipedia, "Deno (software)" (Go→Rust switch; Tokio replacing libuv;
  std-library Nov 2018; FlatBuffers removed Aug 2019):
  https://en.wikipedia.org/wiki/Deno_(software)

### 2020-05-13 — Deno 1.0

Deno reached **1.0 on May 13, 2020**, after roughly two years of development. Per
Deno's own announcement, Deno is "a new runtime for executing JavaScript and
TypeScript outside of the web browser"; it **supports TypeScript without
additional tooling**, runs code "in a secure sandbox by default" (scripts cannot
touch disk or open network connections without explicit command-line permission
flags), ships as a single executable, and can import remote code directly from
URLs. The CLI is built on the Rust crate **`deno_core`** and on **`rusty_v8`**,
"high quality Rust bindings to V8's C++ API." (Attribution: Deno.)
- Deno blog, "Deno 1.0" (May 13, 2020): https://deno.com/blog/v1
- The Register, "Node.js creator delivers Deno 1.0, a new runtime that fixes
  'design mistakes in Node'" (May 14, 2020): https://www.theregister.com/2020/05/14/nodejs_creator_deno_10/
- InfoQ, "Deno Is Ready for Production" (June 2020): https://www.infoq.com/news/2020/06/deno-1-ready-production/

### 2021-03-29 — The Deno Company (Deno Land Inc.) and a $4.9M seed round

On **March 29, 2021**, Dahl and Belder announced **the Deno company** (incorporated
as **Deno Land Inc.**) with **$4.9 million** in seed funding. Investors named in
the announcement include **Dan Scholnick / Four Rivers Ventures**, **Guillermo
Rauch** (Vercel's CEO, via Rauch Capital), **Lee Jacobs / Long Journey
Ventures**, **Mozilla Corporation**, **Shasta Ventures**, and **Ben Noordhuis**.
The post pledged that **"Deno will remain MIT licensed,"** explicitly rejected the
"open core" model, and said the business would "build on the open source project,
not attempt to monetize it directly." (Attribution: Deno.)
- Deno blog, "Announcing the Deno Company" (Mar 29, 2021): https://deno.com/blog/the-deno-company
- The Register, "The JavaScript ecosystem is 'hopelessly fragmented'… Deno is now
  a company" (Apr 6, 2021): https://www.theregister.com/2021/04/06/deno_is_now_a_company/
- InfoWorld, "Deno Company forms to back Node.js rival": https://www.infoworld.com/article/2263929/deno-company-forms-to-back-nodejs-rival.html
- Changelog, "The Deno team takes funding and starts a company around the
  project": https://changelog.com/news/the-deno-team-takes-funding-and-starts-a-company-around-the-project-4OPD

### 2021-06-23 — Deno Deploy Beta 1 (the isolate cloud)

On **June 23, 2021**, Deno launched **Deno Deploy Beta 1**, a hosted edge service.
The announcement describes it as "a multi-tenant JavaScript engine running in 25
data centers across the world" that "deeply integrates cloud infrastructure with
the V8 virtual machine," and states plainly: **"Deploy does not run on AWS Lambda
nor does it use Cloudflare Workers; this is a new system with a unique design."**
Its stated goal was "to be the best place to host modern server-side JavaScript."
(Attribution: Deno.) Beta releases 2–4 followed over the next year.
- Deno blog, "Deno Deploy Beta 1" (Jun 23, 2021): https://deno.com/blog/deploy-beta1
- Deno blog, "Deno Deploy Beta 4": https://deno.com/blog/deploy-beta4
- Deno's place alongside Cloudflare Workers / Vercel / Netlify edge runtimes is in
  [`cloudflare-cdn.md`](./cloudflare-cdn.md).

### 2022-04-19 — Netlify Edge Functions, built on Deno Deploy

On **April 19, 2022**, Netlify launched **Netlify Edge Functions** built on **Deno
Deploy** infrastructure — choosing Deno (and its Web-standard `Request`/`Response`
primitives) over Node.js for its edge-compute product. This made Deno Deploy the
underlying runtime for a second major platform's edge layer.
- Deno blog, "Netlify Edge Functions on Deno Deploy" (Apr 19, 2022): https://deno.com/blog/netlify-edge-functions-on-deno-deploy
- Netlify blog, "Netlify Edge Functions: Serverless Compute Powered by Deno":
  https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/
- DevClass, "Netlify chooses Deno rather than Node.js to power new Edge Functions"
  (Apr 19, 2022): https://devclass.com/2022/04/19/netlify-chooses-deno-rather-than-node-js-to-power-new-edge-functions/

### 2022-06-21 — $21M Series A led by Sequoia

On **June 21, 2022**, Deno announced a **$21 million Series A** led by **Sequoia
Capital**, bringing total raised to about **$26 million**. Participants included
**Four Rivers Ventures**, **Nat Friedman**, **Insight Partners**, **Long Journey
Ventures**, **Dylan Field**, **Automattic**, **Netlify**, and **Shasta Ventures**.
Dahl said the cash would go toward building out the commercial offering, **Deno
Deploy**. (Attribution: Deno / reporting.)
- Deno blog, "Deno raises $21M" (Jun 21, 2022): https://deno.com/blog/series-a
- Yahoo/TechCrunch, "Deno raises $21M to launch a fully managed runtime service":
  https://www.yahoo.com/news/deno-raises-21m-launch-fully-160041959.html
- **Note on the prompt's "2021" framing:** the $21M Sequoia/Four-Rivers round is
  dated **June 21, 2022** by Deno's own post (the earlier 2021 raise was the
  **$4.9M seed** above). The "Sequoia / Four Rivers" detail is correct; the year
  is **2022**, not 2021.

### 2022-06-28 — Fresh 1.0

On **June 28, 2022**, Deno released **Fresh 1.0**, a full-stack web framework for
Deno that "sends zero JavaScript to the client by default" and "has no build
step," using **Preact** and JSX/TSX for server and (selective) client rendering
via an islands architecture. (Attribution: Deno.)
- Deno blog, "Fresh 1.0" (Jun 28, 2022): https://deno.com/blog/fresh-is-stable
- Deno on X (deno_land), Fresh stable-release announcement (Jun 28, 2022):
  https://x.com/deno_land/status/1541790500985905159
  *(X/Twitter posts can return HTTP 402 to automated fetching; the release date
  and "zero JavaScript… no build step" wording are corroborated by the Deno blog
  post above.)*

### 2024-10-09 — Deno 2 (Node/npm compatibility, JSR)

On **October 9, 2024**, Deno released **Deno 2**, a major pivot toward
**backwards compatibility with Node.js and npm**. Per the announcement, Deno 2
understands **`package.json`** and **`node_modules`**, supports importing npm
packages via **`npm:` specifiers** ("over 2 million npm modules"), adds
package-management subcommands (**`deno install` / `deno add` / `deno remove`**),
and introduces a Long-Term-Support release channel (from 2.1). It also promotes
**JSR**, Deno's "modern, open sourced JavaScript registry" with native TypeScript
support. (Attribution: Deno.)
- Deno blog, "Announcing Deno 2" (Oct 9, 2024): https://deno.com/blog/v2.0
- The New Stack, "Deno 2 Arrives With Long-Term Support, npm Compatibility":
  https://thenewstack.io/deno-2-arrives-with-long-term-support-node-js-compatibility/
- Simon Willison, "Announcing Deno 2" (Oct 10, 2024): https://simonwillison.net/2024/Oct/10/announcing-deno-2/

### 2024-11-22 — Deno petitions USPTO to cancel Oracle's "JavaScript" trademark

After an unanswered 2022 open letter to Oracle, Deno **filed a petition with the
USPTO** (reported as **November 22, 2024**) to **cancel Oracle's trademark on
"JavaScript."** The petition argues the term is **generic** (the common name for
the ECMA-262 language, not a brand), that Oracle has **abandoned** any trademark
use, and that Oracle **committed fraud** in its **2019** renewal by submitting a
screenshot of the **Node.js website** (a project not affiliated with Oracle) as a
specimen of use. The petition was preceded by a **September 2024** open letter
from Dahl, **Brendan Eich** (JavaScript's creator), and others, reportedly signed
by **14,000+** developers. (Facts: the filing, the arguments; the signature count
is **reported**.)
- Deno blog, "Deno v. Oracle: Canceling the JavaScript Trademark": https://deno.com/blog/deno-v-oracle
- The Register, "Deno to USPTO: Drop Oracle's grip on 'JavaScript' trademark"
  (Nov 26, 2024): https://www.theregister.com/2024/11/26/cancel_oracles_javascript_trademark_deno/
- InfoWorld, "USPTO petitioned to cancel Oracle's JavaScript trademark":
  https://www.infoworld.com/article/3612364/uspto-petitioned-to-cancel-oracles-javascript-trademark.html
- RedMonk conversation with Ryan Dahl on the petition (Dec 16, 2024): https://redmonk.com/blog/2024/12/16/rmc-ryan-dahl-on-the-deno-v-oracle-petition/

### 2025-06-18 — TTAB dismisses the fraud claim; Deno presses genericness/abandonment

Per Deno's update, the **Trademark Trial and Appeal Board dismissed Deno's fraud
claim on June 18, 2025**; rather than amend it, Deno chose to proceed on its two
remaining theories — **genericness** and **abandonment**. Dahl's stated position:
"Everyone uses 'JavaScript' to describe a language — not a brand." The update
listed upcoming milestones of **August 7, 2025** (Oracle's answer to the petition)
and **September 6, 2025** (start of discovery). (Attribution: Deno; procedural
dates as Deno reported them.)
- Deno blog, "JavaScript™ Trademark Update" (Jun 27, 2025): https://deno.com/blog/deno-v-oracle4
- Deno blog, "Deno v Oracle Update 3: Fighting the JavaScript Trademark": https://deno.com/blog/deno-v-oracle3
- The Register, "Oracle lays mines in JavaScript trademark battle" (Feb 5, 2025):
  https://www.theregister.com/2025/02/05/oracle_dismissal_javascript_trademark_fraud/
- **Could not verify** any final TTAB ruling on genericness/abandonment in this
  pass; as of the latest sourced update the case was headed into **discovery**
  (expected to run into 2026). Treat the outcome as **unresolved**.

### 2026-02-03 — Deno Deploy goes GA (the next-generation rework); Deno Sandbox beta

On **February 3, 2026**, Deno announced that the **next-generation Deno Deploy is
generally available**, described as "the easiest way to deploy and run any
JavaScript or TypeScript to the web" with **no required adapters, build configs,
or vendor-specific files**. The GA platform is a ground-up rework of **Deploy
Classic**, with a new dashboard, a new execution environment running **Deno 2**,
GitHub-based zero-config CI/CD with per-commit previews and rollbacks, built-in
**Deno KV** and **Postgres**, and a **Prisma** partnership. The same announcement
introduced **Deno Sandbox** (beta) — a service for running untrusted/AI-generated
code in **ephemeral Linux microVMs**. The GA free plan was stated as **1M
requests/month, 100 GB egress, and 15 CPU hours**. (Attribution: Deno.)
- Deno blog, "Deno Deploy is Generally Available" (Feb 3, 2026): https://deno.com/blog/deno-deploy-is-ga
- AlternativeTo, "Deno Deploy reaches GA with CI/CD, observability, and Deno
  Sandbox beta launch" (Feb 2026): https://alternativeto.net/news/2026/2/deno-deploy-reaches-ga-with-ci-cd-observability-and-deno-sandbox-beta-launch/
- InfoWorld, "Deno Sandbox launched for running AI-generated code": https://www.infoworld.com/article/4127684/deno-sandbox-launched-for-running-ai-generated-code.html
- heise online, "Deno Deploy is generally available": https://www.heise.de/en/news/Deno-Deploy-is-generally-available-11166032.html

### 2026-07-20 — Deno Deploy "Classic" scheduled sunset

Per Deno's documentation, **Deploy Classic is scheduled to shut down on July 20,
2026**. Classic is no longer onboarding new users or organizations; existing
projects must be migrated to the new Deno Deploy (at `console.deno.com`), which
uses a separate account/organization system (projects are **not** auto-transferred
— users create new apps and redeploy). The migration also retires the
**`deployctl`** CLI in favor of the **`deno deploy`** subcommand, and drops the
legacy `serve()` entry point in favor of **`Deno.serve()`**. (Attribution: Deno
docs.)
- Deno docs, "Migrating from Deploy Classic to Deno Deploy": https://docs.deno.com/deploy/migration_guide/
- Deno docs, "Deploy Classic": https://docs.deno.com/deploy/classic/
- Deno docs, "About Deno Deploy": https://docs.deno.com/deploy/

---

## Key people & teams

- **Ryan Dahl** — Creator of **Node.js** (debuted at JSConf EU 2009) and, a decade
  later, co-creator and public face of **Deno**; CEO of **Deno Land Inc.**
  Announced Deno at JSConf EU 2018 in "10 Things I Regret About Node.js," and
  leads the Oracle "JavaScript" trademark-cancellation campaign.
  - JSConf.eu 2009 (Node.js): https://www.jsconf.eu/2009/speaker/speakers_selected.html
  - JSConf EU 2018 (Deno): https://2018.jsconf.eu/speakers/ryan-dahl-propel-a-machine-learning-framework-for-javascript.html
  - Deno company announcement: https://deno.com/blog/the-deno-company

- **Bert Belder** — Co-creator of Deno and co-founder of the Deno company; a
  long-time Node.js core contributor (notably on libuv/Windows support) before
  Deno.
  - Wikipedia, "Deno (software)" (Belder as co-creator): https://en.wikipedia.org/wiki/Deno_(software)
  - Deno company announcement (co-founders Dahl & Belder): https://deno.com/blog/the-deno-company
  - **Could not verify** the specific scope of Belder's prior Node.js
    contributions against a primary source in this pass; his Deno co-creator/
    co-founder role is sourced above.

- **Ben Noordhuis** — Named investor in the 2021 Deno seed round; a former Node.js
  core contributor.
  - Deno company announcement: https://deno.com/blog/the-deno-company

- **Brendan Eich** — Creator of JavaScript; co-signer of the September 2024 open
  letter urging Oracle to release the "JavaScript" trademark (a campaign Deno
  filed the formal USPTO petition for).
  - The Register: https://www.theregister.com/2024/11/26/cancel_oracles_javascript_trademark_deno/

---

## Company & corporate history

- **2009** — **Ryan Dahl** creates **Node.js**; debuts it at **JSConf EU 2009**.
  [JSConf.eu](https://www.jsconf.eu/2009/speaker/speakers_selected.html)
- **2018 (JSConf EU)** — Dahl gives **"10 Things I Regret About Node.js"** and
  unveils **Deno** (a Rust/V8, secure-by-default TS runtime). Prototype moves from
  **Go → Rust**; **Tokio** replaces **libuv**.
  [JSConf EU 2018](https://2018.jsconf.eu/speakers/ryan-dahl-propel-a-machine-learning-framework-for-javascript.html) ·
  [Wikipedia](https://en.wikipedia.org/wiki/Deno_(software))
- **May 13, 2020** — **Deno 1.0** (built-in TypeScript, sandboxed permissions,
  URL imports). [Deno](https://deno.com/blog/v1)
- **Mar 29, 2021** — **Deno Land Inc.** founded; **$4.9M seed** (Four Rivers,
  Rauch, Long Journey, Mozilla, Shasta, Noordhuis); pledges MIT license.
  [Deno](https://deno.com/blog/the-deno-company)
- **Jun 23, 2021** — **Deno Deploy Beta 1** (V8-isolate "isolate cloud," 25 data
  centers; not Lambda, not Cloudflare Workers). [Deno](https://deno.com/blog/deploy-beta1)
- **Apr 19, 2022** — **Netlify Edge Functions** launch on **Deno Deploy**.
  [Deno](https://deno.com/blog/netlify-edge-functions-on-deno-deploy) ·
  [Netlify](https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/)
- **Jun 21, 2022** — **$21M Series A** led by **Sequoia** (with Four Rivers, Nat
  Friedman, Insight, Long Journey, Dylan Field, Automattic, Netlify, Shasta);
  ~$26M total. [Deno](https://deno.com/blog/series-a)
- **Jun 28, 2022** — **Fresh 1.0** (zero-JS-by-default, no build step, Preact
  islands). [Deno](https://deno.com/blog/fresh-is-stable)
- **Oct 9, 2024** — **Deno 2** (Node/npm compatibility, `npm:` specifiers,
  `package.json`/`node_modules`, package-management subcommands, LTS, **JSR**).
  [Deno](https://deno.com/blog/v2.0)
- **Nov 22, 2024** — Deno **petitions USPTO** to cancel Oracle's **"JavaScript"**
  trademark (genericness / abandonment / fraud). [Deno](https://deno.com/blog/deno-v-oracle) ·
  [The Register](https://www.theregister.com/2024/11/26/cancel_oracles_javascript_trademark_deno/)
- **Jun 18, 2025** — **TTAB dismisses the fraud claim**; Deno presses
  genericness/abandonment; case heads to discovery. [Deno](https://deno.com/blog/deno-v-oracle4)
- **Feb 3, 2026** — **Next-gen Deno Deploy GA** (Deno-2 execution env, GitHub
  CI/CD, KV + Postgres, Prisma); **Deno Sandbox** beta (microVMs).
  [Deno](https://deno.com/blog/deno-deploy-is-ga)
- **Jul 20, 2026 (scheduled)** — **Deno Deploy Classic** shutdown; migration to
  the new platform; `deployctl` → `deno deploy`. [Deno docs](https://docs.deno.com/deploy/migration_guide/)

**Funding ladder (verified):** Seed $4.9M (Mar 29, 2021) → Series A $21M led by
Sequoia (Jun 21, 2022), ~$26M total raised.

---

## Controversies & tensions

> Each item separates **established fact** (dates/actions/announcements) from
> **reported claim / characterization**, with attribution.

### 1. Node.js "regrets" and the founder-rebuilds-his-own-tool framing

- **Fact:** Dahl, Node's creator, publicly enumerated Node design decisions he
  regretted ("10 Things I Regret About Node.js," JSConf EU 2018) and built Deno as
  a clean-slate alternative — secure-by-default, TypeScript-native, Web-standard
  APIs. [JSConf EU 2018](https://2018.jsconf.eu/speakers/ryan-dahl-propel-a-machine-learning-framework-for-javascript.html) ·
  [The Register (Deno 1.0)](https://www.theregister.com/2020/05/14/nodejs_creator_deno_10/)
- **Reported tension (characterization):** Coverage repeatedly framed Deno as a
  "Node.js rival" from its creator; the same outlets later noted Deno 2's pivot
  *toward* Node/npm compatibility as a pragmatic reversal of Deno 1's
  "no-`node_modules`" stance. This is **reporting/characterization**, attributed
  to the outlets, not a single company-stated fact.
  [InfoWorld](https://www.infoworld.com/article/2263929/deno-company-forms-to-back-nodejs-rival.html) ·
  [The New Stack (Deno 2)](https://thenewstack.io/deno-2-arrives-with-long-term-support-node-js-compatibility/)

### 2. Deno vs. Oracle — the "JavaScript" trademark fight

- **Fact:** Deno filed a USPTO cancellation petition (reported Nov 22, 2024)
  arguing "JavaScript" is generic and abandoned, and alleging fraud in Oracle's
  2019 renewal (Node.js-website specimen). The **TTAB dismissed the fraud claim on
  June 18, 2025**; Deno is proceeding on genericness/abandonment.
  [Deno](https://deno.com/blog/deno-v-oracle) ·
  [Deno update](https://deno.com/blog/deno-v-oracle4) ·
  [The Register](https://www.theregister.com/2025/02/05/oracle_dismissal_javascript_trademark_fraud/)
- **Reported/contested:** The **14,000+ signatures** on the open letter and the
  predicted timeline are **reported**; the case's **ultimate outcome is unresolved**
  as of the latest sourced update. [The Register](https://www.theregister.com/2024/11/26/cancel_oracles_javascript_trademark_deno/)

### 3. Deno Deploy "Classic" → next-gen migration (the 2026 sunset)

- **Fact:** Deno is **retiring Deploy Classic (scheduled July 20, 2026)** in favor
  of the next-generation Deno Deploy (GA Feb 3, 2026). Migration is **not**
  automatic — projects, accounts, and organizations don't carry over; the
  `deployctl` CLI and legacy `serve()` are being dropped.
  [Deno docs](https://docs.deno.com/deploy/migration_guide/) ·
  [Deno (GA)](https://deno.com/blog/deno-deploy-is-ga)
- **Reported tension (characterization):** A forced, non-automatic migration with
  a new account system and a CLI swap is the kind of change that draws user
  friction; this doc records the **documented mechanics** of the migration rather
  than asserting a quantified backlash. **Could not verify** any specific public
  outcry against a primary source in this pass.

### 4. Open-source steward vs. commercial host

- **Fact:** Deno explicitly **rejected the "open core" model** in 2021, keeping the
  runtime MIT-licensed and building a separate commercial business (Deno Deploy,
  Subhosting, Sandbox) on top. [Deno](https://deno.com/blog/the-deno-company)
- **Context:** This is the same open-source-framework-plus-hosted-platform pattern
  seen with Vercel/Next.js (see [`vercel.md`](./vercel.md)) and Netlify; the
  Netlify relationship is notably both **partner** (Edge Functions on Deno Deploy)
  and **investor** (Series A). [Deno (Netlify)](https://deno.com/blog/netlify-edge-functions-on-deno-deploy) ·
  [Deno (Series A)](https://deno.com/blog/series-a)

---

## Items marked "Could not verify"

- **Node.js "January 2009" start date** and the JSConf-EU-2009
  standing-ovation detail — the 2009 JSConf EU debut is sourced; the exact start
  month and reception are **reported**, not primary-verified here.
- **Exact date of the JSConf EU 2018 "10 Things I Regret" talk** — the
  conference (June 2018) and the talk's existence/content are sourced; the precise
  day was not pinned to a primary schedule in this pass.
- **The prompt's "$21M round, 2021, led by Sequoia/Four Rivers"** — corrected: the
  **$21M Sequoia/Four-Rivers Series A is dated June 21, 2022** (Deno's own post);
  the **2021** raise was the separate **$4.9M seed**. Both are primary-sourced.
- **Bert Belder's specific prior Node.js contributions** — his Deno co-creator/
  co-founder role is sourced; the detail of his earlier libuv/Windows work is
  **reported**, not primary-verified here.
- **Oracle "JavaScript" trademark — final outcome** — the petition, the arguments,
  and the **June 18, 2025 fraud-claim dismissal** are sourced; the case was headed
  into **discovery** and is **unresolved** as of the latest sourced update
  (post-Aug/Sept 2025 procedural steps and any final TTAB ruling were not
  verified).
- **14,000+ open-letter signatures** — **reported** by The Register/InfoWorld, not
  independently verified here.
- **Deploy Classic → next-gen migration backlash** — the documented migration
  mechanics and July 20, 2026 sunset date are sourced (Deno docs); any quantified
  user backlash was **not** verified.
- **X/Twitter posts** (e.g., the Fresh 1.0 announcement) can return HTTP 402 to
  automated fetching; their content is corroborated by the cited Deno blog posts.
