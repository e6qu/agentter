# Vercel (ZEIT) — A Sourced History

A chronological, sourced history of **Vercel** — the company founded by
**Guillermo Rauch** as **ZEIT** in 2015, which built the `now` serverless
deployment platform, created and stewards the **Next.js** React framework, and
rebranded to **Vercel** in April 2020 as it repositioned itself as a
"frontend cloud" (later "AI Cloud"). Every non-trivial claim links to a working
source. Primary sources (Vercel/Next.js blogs, founder posts, funding
announcements, official advisories) are preferred, with reputable outlets
(TechCrunch, Bloomberg, Reuters via Yahoo Finance, BusinessWire, etc.) as
corroboration. Items that could not be confirmed are marked
**"Could not verify."**

> **Cross-references (not duplicated here):**
> - Vercel's place in the broader CDN / edge-functions / JAMstack landscape —
>   alongside Cloudflare Pages, Netlify, and Fastly — is set in
>   [`cloudflare-cdn.md`](./cloudflare-cdn.md). That doc states the market
>   positioning; this doc covers Vercel's own corporate and product history.

---

## Timeline

### 2015 — ZEIT founded

ZEIT, Inc. was founded in **2015** by **Guillermo Rauch**. Rauch — an Argentine
self-taught developer — was already well known in the JavaScript community as the
creator of the realtime library **Socket.IO** and the MongoDB ODM **Mongoose**.
- Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel
- Vercel, "ZEIT is now Vercel" (the company's own rebrand post, which recounts the
  ZEIT origin and the `now` product): https://vercel.com/blog/zeit-is-now-vercel
- **Could not verify** the exact founding month against a primary ZEIT/SEC
  document in this pass; the year (2015) is sourced via Wikipedia and the company's
  own retrospective. (Some secondary profiles cite **November 2015** and name
  **Tony Kovanen** and **Naoyuki Kanezawa** as co-founders, but this was not
  confirmed against a primary source — treat the exact month and the
  co-founder list as **reported, not primary-verified**.)

### 2016 — The `now` deployment platform and `now.sh`

ZEIT's flagship product was **`now`** (also branded **`now.sh`** / **ZEIT Now**):
a CLI that let developers deploy, share, and scale apps with a single `now`
command, with the platform handling global distribution. Vercel's own rebrand post
later described the appeal: developers "**tired of boilerplate** … appreciated the
ability to **trivially deploy, share, and scale their apps.**" (Attribution:
Vercel/ZEIT.)
- Vercel, "ZEIT is now Vercel": https://vercel.com/blog/zeit-is-now-vercel
- **Could not verify** the exact launch date of `now` / `now.sh` against a dated
  primary announcement in this pass; 2016 is sourced via the company's own
  retrospective and secondary coverage.

### 2016-10-25 — Next.js first released

ZEIT released **Next.js**, an open-source React framework, on GitHub on
**October 25, 2016**. The original author is **Guillermo Rauch**, and the project's
co-creators include **Tim Neutkens**, **Naoyuki Kanezawa**, **Arunoda Susiripala**,
**Tony Kovanen**, and **Dan Zajdband**. Next.js shipped with server-side rendering,
file-system routing, and a zero-config developer experience, and it became the
center of Vercel's commercial strategy: an open-source framework with a hosted
platform tuned to run it.
- Wikipedia, "Next.js": https://en.wikipedia.org/wiki/Next.js

### 2019-02 — Next.js 8 and serverless deployment

**Next.js 8** (February 2019) introduced serverless deployment support
(per-page serverless functions / lambdas), aligning the framework with the
serverless model `now` was built around.
- Wikipedia, "Next.js": https://en.wikipedia.org/wiki/Next.js

### 2020-04-21 — ZEIT rebrands to Vercel; $21M Series A

On **April 21, 2020**, ZEIT announced it was **rebranding to Vercel**, stating its
"new focus merited a new identity." Alongside the rebrand, the company announced
**$21M in Series A** funding led by **Accel** and **CRV**, with angels including
**Naval Ravikant** and **Nat Friedman**. The company pitched itself around the
workflow to "**develop, preview, and ship**" and the "ultimate workflow for
developing, previewing, and shipping **Jamstack** sites," and noted Next.js then
powered "**over 35,000 sites**" at companies such as Uber, Nike, and Starbucks.
(Attribution: Vercel.)
- Vercel, "ZEIT is now Vercel" (rebrand + $21M Series A): https://vercel.com/blog/zeit-is-now-vercel
- BuiltIn SF, "Vercel, Formerly Known as Zeit, Raises $21 Million to Expand
  Platform" (Apr 22, 2020): https://www.builtinsf.com/2020/04/22/vercel-raises-21m-zeit-rebrand
- Wikipedia, "Vercel" (rebrand April 2020): https://en.wikipedia.org/wiki/Vercel

### 2021-06-23 — $102M Series C at a $1.1B valuation (first unicorn)

Vercel announced a **$102 million Series C** on **June 23, 2021**, led by
**Bedrock Capital**, at a **$1.1 billion** valuation — making it a unicorn. The
round brought total funding to ~$163 million; participants included Accel, CRV,
Geodesic Capital, Greenoaks, GV, plus new investors 8VC, Flex Capital, GGV,
Latacora, Salesforce Ventures, and Tiger Global.
- TechCrunch, "Vercel raises $102M Series C for its … front-end development
  platform" (Jun 23, 2021): https://techcrunch.com/2021/06/23/vercel-raises-102m-series-c-for-its-next-js-based-front-end-development-platform/

### 2021-11-23 — $150M Series D at a $2.5B valuation

Vercel announced a **$150 million Series D** on **November 23, 2021**, at a
**$2.5 billion** valuation, led by **GGV Capital**. The company's own announcement
and TechCrunch reported the round, with participation from Accel, Bedrock, CRV,
Geodesic, Greenoaks, GV, 8VC, Flex Capital, Latacora, Salesforce Ventures, Tiger
Global, and new investor SV Angel. Vercel cited Next.js at ~2 million weekly npm
installs and edge-network traffic up ~700% since April 2020.
- Vercel, "Vercel: Series D funding announcement": https://vercel.com/blog/vercel-funding-series-d-and-valuation
- TechCrunch, "Vercel raises $150M Series D…" (Nov 23, 2021): https://techcrunch.com/2021/11/23/vercel-raises-150m-series-d-as-it-looks-to-build-an-end-to-end-front-end-development-platform/
- BusinessWire, "Vercel Announces $150M in Series D Funding at a $2.5B Valuation"
  (Nov 23, 2021): https://www.businesswire.com/news/home/20211123005573/en/Vercel-Announces-%24150M-in-Series-D-Funding-at-a-%242.5B-Valuation-to-Further-Fuel-Innovation-and-Global-Adoption-of-Worlds-Fastest-Frontend-Development-Platform

### 2021-12 — Turborepo acquisition

Vercel acquired **Turborepo**, the monorepo build tool, in **December 2021**.
- Wikipedia, "Vercel" (acquisitions): https://en.wikipedia.org/wiki/Vercel
- **Could not verify** the exact December 2021 date / deal terms against a primary
  Vercel announcement in this pass; sourced via Wikipedia.

### 2022-10-25/26 — Next.js 13 and the App Router

At **Next.js Conf** on **October 25, 2022**, Vercel announced **Next.js 13**
(release dated **October 26, 2022**), introducing the **App Router** (the `app/`
directory, in beta) with support for **layouts**, **React Server Components**,
**streaming**, and new data-fetching methods — plus an alpha of **Turbopack**, a
Rust-based successor to Webpack. This was a foundational shift toward server-first
rendering.
- Next.js blog, "Next.js 13": https://nextjs.org/blog/next-13
- Wikipedia, "Next.js" (v13, Oct 26, 2022, App Router beta): https://en.wikipedia.org/wiki/Next.js

### 2022-10 — Splitbee acquisition

Vercel acquired the privacy-friendly analytics tool **Splitbee** in **October 2022**.
- Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel
- **Could not verify** the exact date / terms against a primary Vercel announcement
  in this pass; sourced via Wikipedia.

### 2023-03-28 — Tom Occhino joins Vercel from Meta's React team

**Tom Occhino**, who had led the **React** group at Facebook/Meta (React Core,
React Native, Relay), **joined Vercel** — announcing it publicly on
**March 28, 2023** — initially as **VP of Engineering, Frameworks**, and from
**September 2023** as **Chief Product Officer**.
- Tom Occhino on X (join announcement, Mar 28, 2023):
  https://x.com/tomocchino/status/1640800001625411606
  *(The X/Twitter post returned HTTP 402 to automated fetching; the March 28, 2023
  announcement and "joining @Vercel" wording are visible in the search-indexed
  tweet and corroborated by his professional profiles below.)*
- The Org, "Tom Occhino — Chief Product Officer at Vercel" (VP Eng Frameworks
  Mar 2023 → CPO Sept 2023): https://theorg.com/org/vercel/org-chart/tom-occhino
- **Could not verify** the exact CPO start date against a primary Vercel
  announcement; the March 2023 → September 2023 progression is per his
  profile/secondary sources.

### 2023-05 — Next.js 13.4: App Router goes stable

**Next.js 13.4** (May 2023) marked the **App Router as stable** for production use,
solidifying React Server Components as the recommended model.
- Wikipedia, "Next.js" (13.4, May 2023, stable App Router): https://en.wikipedia.org/wiki/Next.js

### 2023-10-11 — v0 (generative UI) enters beta

Vercel announced **v0** moving from alpha to **beta** on **October 11, 2023** —
"a product that makes website creation as simple as describing your ideas,"
combining frontend best practices with generative AI to turn text prompts into UI
code. The beta expanded access to 5,000 additional users with tiered plans from
free to $50/month. (Attribution: Vercel.)
- Vercel, "Announcing v0: Generative UI" (Oct 11, 2023): https://vercel.com/blog/announcing-v0-generative-ui
- SiliconANGLE, "Vercel announces the beta of v0…" (Oct 11, 2023): https://siliconangle.com/2023/10/11/vercel-announces-beta-v0-ai-powered-tool-front-end-web-dev/

### 2024-05-16 — $250M Series E at a $3.25B valuation

Vercel raised a **$250 million Series E** at a **$3.25 billion** valuation,
reported **May 16, 2024**, led by **Accel** (with CRV, GV, Notable Capital,
Bedrock, Geodesic, Tiger Global, 8VC, SV Angel). Vercel said it had recently
**exceeded $100 million in annual revenue** and that >1 million developers used
Next.js monthly; the company earmarked funds for **v0** and enterprise AI.
- Reuters via Yahoo Finance, "Exclusive-Vercel completes $250 million Series E round
  at $3.25 billion valuation" (May 16, 2024): https://finance.yahoo.com/news/exclusive-vercel-completes-250-million-144101385.html
- FinSMEs, "Vercel Raises $250M in Series E at $3.25 Billion Valuation" (May 2024):
  https://www.finsmes.com/2024/05/vercel-raises-250m-in-series-e-at-3-25-billion-valuation.html
- Crunchbase News, "Vercel's Valuation Jumps To $3.25B After $250M Series E":
  https://news.crunchbase.com/cloud/vercels-cloud-web-applications-funding-valuation-accel/

### 2025-01 — Tremor acquisition

Vercel acquired **Tremor**, an open-source React dashboard/charting component
library, in **January 2025**.
- Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel
- **Could not verify** the exact date / terms against a primary Vercel announcement
  in this pass; sourced via Wikipedia.

### 2025-03-21 — Next.js middleware authorization bypass (CVE-2025-29927)

On **March 21, 2025**, an advisory was published for **CVE-2025-29927**, a critical
**Next.js middleware authorization bypass**: by sending a crafted internal header
**`x-middleware-subrequest`**, an attacker could cause Next.js to skip middleware
entirely — bypassing middleware-based **authentication/authorization** checks and
reaching protected routes. The flaw carried a **CVSS 9.1** and affected versions
prior to 12.3.5 (12.x), 13.5.9 (13.x), 14.2.25 (14.x), and 15.2.3 (15.x).
- Datadog Security Labs, "Understanding CVE-2025-29927: The Next.js Middleware
  Authorization Bypass Vulnerability": https://securitylabs.datadoghq.com/articles/nextjs-middleware-auth-bypass/
- JFrog, "CVE-2025-29927 — Authorization Bypass Vulnerability in Next.js":
  https://jfrog.com/blog/cve-2025-29927-next-js-authorization-bypass/
- Qualys ThreatPROTECT (Mar 25, 2025): https://threatprotect.qualys.com/2025/03/25/next-js-middleware-authorization-bypass-vulnerability-cve-2025-29927/

### 2025-07 — Lee Robinson departs for Cursor; NuxtLabs acquisition

**Lee Robinson**, who joined Vercel in 2020 and rose from individual contributor
through DevRel to **VP of Product**, **left Vercel in July 2025** after five years.
In his own retrospective he described the company growing from ~30 people and ~$1M
ARR to **~650 people and >$200M ARR** during his tenure. He announced on X that he
had "just finished my last week at Vercel"; reporting and his subsequent move place
him at **Cursor** (Anysphere) as **Head of AI Education**.
- Lee Robinson, "5 Things I Learned From 5 Years At Vercel": https://leerob.com/vercel
- Lee Robinson on X ("After 5 years, I just finished my last week at Vercel"):
  https://x.com/leerob/status/1943446393819177342
  *(The X post returned HTTP 402 to automated fetching; the wording and timing are
  visible in the search-indexed post and corroborated by his own leerob.com
  retrospective.)*
- **Could not verify** the exact start date or title of his Cursor role against a
  primary source in this pass — treat "Head of AI Education at Cursor" as
  **reported**.

Also in **July 2025**, Vercel acquired **NuxtLabs**, the company behind the
**Nuxt** (Vue) framework ecosystem.
- Wikipedia, "Vercel" (NuxtLabs, July 2025): https://en.wikipedia.org/wiki/Vercel
- **Could not verify** the exact date / terms against a primary Vercel announcement
  in this pass; sourced via Wikipedia.

### 2025-09-15 — CEO's Netanyahu meeting and boycott backlash

On or about **September 15, 2025**, Guillermo Rauch posted a photo of himself with
Israeli Prime Minister **Benjamin Netanyahu** from a meeting of US tech executives
in New York, writing that he "enjoyed my conversation … about how education and
training in artificial intelligence can help free societies stay ahead of the
curve." The post triggered a significant **developer backlash** and **boycott
calls**, with users publicly cancelling Vercel subscriptions and discussing
migrating Next.js projects to competitors (Netlify, Cloudflare Pages, Fly.io,
Render). Rauch later said the blowback had not cost the startup customers or
employees but apologized for anyone hurt. (Facts: dates/actions; the boycott
framing is **reported**.)
- Middle East Eye, "Developers drop Vercel, call for boycott after CEO posts selfie
  with Netanyahu": https://www.middleeasteye.net/trending/developers-drop-vercel-call-boycott-after-ceo-posts-selfie-netanyahu
- The New Arab, "Vercel faces boycott after founder poses with Netanyahu":
  https://www.newarab.com/news/vercel-faces-boycott-after-founder-poses-netanyahu
- Bloomberg (video), "Vercel CEO Addresses Netanyahu Post Controversy" (Oct 3,
  2025): https://www.bloomberg.com/news/videos/2025-10-03/vercel-ceo-addresses-netanyahu-post-controversy-video
- **Could not verify** the precise date of the meeting/post against a primary
  source; secondary reporting places it ~September 15, 2025. The scale of any
  actual customer churn is disputed (Rauch said none; critics claimed an exodus) —
  treat churn numbers as **reported/contested**.

### 2025-09-30 — $300M Series F at a $9.3B valuation ("AI Cloud")

Vercel closed a **$300 million Series F** at a **$9.3 billion** valuation,
announced **September 30, 2025**, **co-led by Accel and GIC**, with new investors
including BlackRock, StepStone, Khosla Ventures, Schroders, Adams Street Partners,
and General Catalyst, plus existing investors GV, Notable Capital, Salesforce
Ventures, and Tiger Global. Vercel framed the raise around the **"AI Cloud"** —
"a cloud … designed and purpose-built for AI applications" — and said the **AI SDK**
had crossed **3 million downloads per week**. A ~$300M secondary tender offer for
early investors/employees was set to close in November.
- Vercel, "Towards the AI Cloud: Our Series F" (Sept 30, 2025): https://vercel.com/blog/series-f
- BusinessWire, "Vercel Closes Series F at $9.3B Valuation to Scale the AI Cloud"
  (Sept 30, 2025): https://www.businesswire.com/news/home/20250930898216/en/Vercel-Closes-Series-F-at-$9.3B-Valuation-to-Scale-the-AI-Cloud
- GIC newsroom, "Vercel Closes Series F at $9.3B Valuation to Scale the AI Cloud":
  https://www.gic.com.sg/newsroom/all/vercel-closes-series-f-at-9-3b-valuation-to-scale-the-ai-cloud/
- SiliconANGLE, "Vercel grabs $300M in late-stage funding to fuel its AI pivot"
  (Sept 30, 2025): https://siliconangle.com/2025/09/30/vercel-grabs-300m-late-stage-funding-fuel-ai-pivot/

### 2025-12-03 — Critical React Server Components RCE (CVE-2025-55182 / "React2Shell")

In **December 2025**, a **critical (CVSS 10.0)** vulnerability — **CVE-2025-55182**
in React (with a related **CVE-2025-66478** in Next.js), nicknamed **"React2Shell"**
— was disclosed: **insecure deserialization in the React Server Components "Flight"
protocol** allowed **unauthenticated remote code execution** by sending a crafted,
malformed HTTP payload. It affected React 19.0.0/19.1.0/19.1.1/19.2.0 and frameworks
using them, including **Next.js 15.x and 16.x**; fixes shipped in React 19.0.1/
19.1.2/19.2.1 and numerous Next.js 15.x/16.x patch releases. Multiple security
vendors and Google's threat-intelligence team reported **widespread in-the-wild
exploitation** shortly after disclosure.
- React, "Critical Security Vulnerability in React Server Components" (Dec 3, 2025):
  https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components
- vercel/next.js GitHub Security Advisory, "RCE in React Server Components"
  (GHSA-9qr9-h5gf-34mp): https://github.com/vercel/next.js/security/advisories/GHSA-9qr9-h5gf-34mp
- Microsoft Security Blog, "Defending against the CVE-2025-55182 (React2Shell)
  vulnerability…" (Dec 15, 2025): https://www.microsoft.com/en-us/security/blog/2025/12/15/defending-against-the-cve-2025-55182-react2shell-vulnerability-in-react-server-components/
- Google Cloud blog, "Multiple Threat Actors Exploit React2Shell (CVE-2025-55182)":
  https://cloud.google.com/blog/topics/threat-intelligence/threat-actors-exploit-react2shell-cve-2025-55182

---

## Key people & teams

- **Guillermo Rauch** — **Founder and CEO** of Vercel (ZEIT). Argentine,
  self-taught; creator of **Socket.IO** and **Mongoose** before ZEIT, and original
  author of **Next.js**. Remains CEO through the AI-Cloud era.
  - Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel
  - Wikipedia, "Next.js" (Rauch as original author / CEO): https://en.wikipedia.org/wiki/Next.js

- **Tim Neutkens** — Long-time **lead maintainer of Next.js**; named among the
  framework's co-creators.
  - Wikipedia, "Next.js": https://en.wikipedia.org/wiki/Next.js

- **Tom Occhino** — Joined Vercel from **Meta's React team** (announced **March 28,
  2023**) as **VP of Engineering, Frameworks**, then **Chief Product Officer** from
  **September 2023**. Previously led React Core / React Native / Relay at
  Facebook/Meta.
  - Tom Occhino on X (Mar 28, 2023): https://x.com/tomocchino/status/1640800001625411606
  - The Org profile: https://theorg.com/org/vercel/org-chart/tom-occhino

- **Lee Robinson** — Joined **2020**; grew through **DevRel** to **VP of Product**;
  a highly visible Next.js educator/evangelist. **Left in July 2025** (after five
  years), subsequently joining **Cursor**.
  - Lee Robinson, "5 Things I Learned From 5 Years At Vercel": https://leerob.com/vercel
  - Lee Robinson on X (departure): https://x.com/leerob/status/1943446393819177342

- **Co-creators of Next.js** — beyond Rauch and Neutkens, the framework's listed
  co-creators include **Naoyuki Kanezawa, Arunoda Susiripala, Tony Kovanen, and
  Dan Zajdband**.
  - Wikipedia, "Next.js": https://en.wikipedia.org/wiki/Next.js

---

## Company & corporate history

- **2015** — **ZEIT, Inc.** founded by **Guillermo Rauch** (creator of Socket.IO /
  Mongoose). [Vercel "ZEIT is now Vercel"](https://vercel.com/blog/zeit-is-now-vercel) ·
  [Wikipedia](https://en.wikipedia.org/wiki/Vercel)
- **2016** — `now` / `now.sh` serverless deployment platform; **Next.js** released
  **Oct 25, 2016**. [Wikipedia, Next.js](https://en.wikipedia.org/wiki/Next.js)
- **Feb 2019** — Next.js 8 adds serverless deployment.
  [Wikipedia](https://en.wikipedia.org/wiki/Next.js)
- **April 21, 2020** — **ZEIT rebrands to Vercel**; **$21M Series A** (Accel, CRV).
  [Vercel](https://vercel.com/blog/zeit-is-now-vercel) ·
  [BuiltIn SF](https://www.builtinsf.com/2020/04/22/vercel-raises-21m-zeit-rebrand)
- **June 23, 2021** — **$102M Series C** at **$1.1B** (Bedrock) — first unicorn.
  [TechCrunch](https://techcrunch.com/2021/06/23/vercel-raises-102m-series-c-for-its-next-js-based-front-end-development-platform/)
- **Nov 23, 2021** — **$150M Series D** at **$2.5B** (GGV).
  [Vercel](https://vercel.com/blog/vercel-funding-series-d-and-valuation) ·
  [BusinessWire](https://www.businesswire.com/news/home/20211123005573/en/Vercel-Announces-%24150M-in-Series-D-Funding-at-a-%242.5B-Valuation-to-Further-Fuel-Innovation-and-Global-Adoption-of-Worlds-Fastest-Frontend-Development-Platform)
- **Dec 2021** — acquires **Turborepo**. [Wikipedia](https://en.wikipedia.org/wiki/Vercel)
- **Oct 25/26, 2022** — **Next.js 13**: **App Router**, React Server Components,
  Turbopack (alpha). [Next.js 13](https://nextjs.org/blog/next-13)
- **Oct 2022** — acquires **Splitbee**. [Wikipedia](https://en.wikipedia.org/wiki/Vercel)
- **Mar 28, 2023** — **Tom Occhino** joins from Meta's React team.
  [X](https://x.com/tomocchino/status/1640800001625411606)
- **May 2023** — **Next.js 13.4**: App Router stable.
  [Wikipedia](https://en.wikipedia.org/wiki/Next.js)
- **Oct 11, 2023** — **v0** (generative UI) enters beta.
  [Vercel](https://vercel.com/blog/announcing-v0-generative-ui)
- **May 16, 2024** — **$250M Series E** at **$3.25B** (Accel); >$100M ARR disclosed.
  [Reuters/Yahoo](https://finance.yahoo.com/news/exclusive-vercel-completes-250-million-144101385.html)
- **Jan 2025** — acquires **Tremor**. [Wikipedia](https://en.wikipedia.org/wiki/Vercel)
- **Mar 21, 2025** — **Next.js middleware bypass** (CVE-2025-29927, CVSS 9.1).
  [Datadog](https://securitylabs.datadoghq.com/articles/nextjs-middleware-auth-bypass/)
- **July 2025** — **Lee Robinson** departs (→ Cursor); acquires **NuxtLabs**.
  [leerob.com](https://leerob.com/vercel) · [Wikipedia](https://en.wikipedia.org/wiki/Vercel)
- **~Sept 15, 2025** — CEO's **Netanyahu** photo triggers boycott backlash.
  [Middle East Eye](https://www.middleeasteye.net/trending/developers-drop-vercel-call-boycott-after-ceo-posts-selfie-netanyahu)
- **Sept 30, 2025** — **$300M Series F** at **$9.3B** ("AI Cloud"; Accel + GIC).
  [Vercel](https://vercel.com/blog/series-f) ·
  [BusinessWire](https://www.businesswire.com/news/home/20250930898216/en/Vercel-Closes-Series-F-at-$9.3B-Valuation-to-Scale-the-AI-Cloud)
- **Dec 3, 2025** — **React/Next.js RSC RCE** (CVE-2025-55182 "React2Shell",
  CVSS 10.0). [React](https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components) ·
  [GHSA](https://github.com/vercel/next.js/security/advisories/GHSA-9qr9-h5gf-34mp)

**Funding ladder (verified):** Series A $21M (Apr 2020) → Series C $102M @ $1.1B
(Jun 2021) → Series D $150M @ $2.5B (Nov 2021) → Series E $250M @ $3.25B (May 2024)
→ Series F $300M @ $9.3B (Sep 2025).
*(A distinct, separately announced **Series B** round was **not** located as a
clean primary-sourced event in this pass — see "Could not verify" below.)*

---

## Controversies & tensions

> Each item separates **established fact** (dates/actions/advisories) from
> **reported claim / characterization**, with attribution.

### 1. Next.js features tied to Vercel — the open-source-vs-hosted tension

- **Fact:** Vercel both **stewards the open-source Next.js framework** and sells the
  **hosted platform tuned to run it** — the core of its commercial model since the
  ZEIT/`now` era. [Vercel "ZEIT is now Vercel"](https://vercel.com/blog/zeit-is-now-vercel)
- **Reported tension (characterization):** A recurring community criticism is that
  some Next.js capabilities are best (or only fully) served on Vercel's own
  infrastructure, raising lock-in concerns relative to self-hosting or rival hosts.
  This is **community characterization**, not a single company-stated fact, and is
  the kind of "open-source steward vs. hosted vendor" friction also seen with other
  framework-and-cloud pairings. **Could not verify** a single authoritative primary
  source quantifying this; treat as **reported sentiment**.

### 2. Pricing / "bill shock" incidents

- **Fact / reported:** Vercel's usage-based pricing (bandwidth + function
  invocations) has produced multiple high-profile **surprise-bill** episodes when
  projects went viral or were hit by traffic floods. A widely shared 2025 example
  was **"Jmail,"** a viral Epstein-files search UI whose creator reportedly faced a
  ~**$50,000** bill, which **Guillermo Rauch personally offered to cover**; other
  reports describe a ~**$23,000** bill attributed to DDoS traffic billed at standard
  rates.
  - Peerlist, "The Jmail Story: From Viral to 50,000 in Debt…":
    https://peerlist.io/scroll/post/ACTHQ7M7REKP7R67DHOOQ8JOQ7NNDM
  - Sanity, "Discussion about estimating billing and preventing surprise charges
    with Vercel…": https://www.sanity.io/answers/discussion-about-estimating-billing-and-preventing-surprise-charges-with-vercel-and-sanity-hosting-services
  - **Could not verify** the exact dollar figures or per-incident details against
    primary Vercel statements; the Jmail/DDoS amounts are **reported** by the
    affected creators and secondary coverage. (Vercel's free/"Hobby" tier is
    reported to hard-cap and take projects offline rather than bill, mitigating
    bill-shock there.)

### 3. Next.js security advisories (2025)

- **Fact (CVE-2025-29927, Mar 21, 2025):** A **middleware authorization bypass**
  (`x-middleware-subrequest` header), **CVSS 9.1**, let attackers skip Next.js
  middleware-based auth checks.
  [Datadog](https://securitylabs.datadoghq.com/articles/nextjs-middleware-auth-bypass/) ·
  [JFrog](https://jfrog.com/blog/cve-2025-29927-next-js-authorization-bypass/)
- **Fact (CVE-2025-55182 "React2Shell", Dec 3, 2025):** A **CVSS 10.0**
  **unauthenticated RCE** via insecure deserialization in **React Server
  Components**, affecting Next.js 15.x/16.x, with reported widespread in-the-wild
  exploitation. [React](https://react.dev/blog/2025/12/03/critical-security-vulnerability-in-react-server-components) ·
  [GHSA](https://github.com/vercel/next.js/security/advisories/GHSA-9qr9-h5gf-34mp) ·
  [Google Cloud](https://cloud.google.com/blog/topics/threat-intelligence/threat-actors-exploit-react2shell-cve-2025-55182)

### 4. CEO's Netanyahu meeting (Sept 2025)

- **Fact:** Rauch publicly posted a photo with **Benjamin Netanyahu** (~Sept 15,
  2025); a **boycott/backlash** followed; Rauch later addressed it publicly.
  [Middle East Eye](https://www.middleeasteye.net/trending/developers-drop-vercel-call-boycott-after-ceo-posts-selfie-netanyahu) ·
  [Bloomberg video](https://www.bloomberg.com/news/videos/2025-10-03/vercel-ceo-addresses-netanyahu-post-controversy-video)
- **Reported/contested:** The **extent of customer churn** is disputed — critics
  described an exodus; Rauch said it cost no customers or employees.
  [The New Arab](https://www.newarab.com/news/vercel-faces-boycott-after-founder-poses-netanyahu)

### 5. Competition with Netlify / Cloudflare (context)

- **Fact / context:** Vercel competes directly with **Netlify** (the other major
  JAMstack/frontend platform) and **Cloudflare Pages/Workers**; the boycott
  reporting itself cited migrations toward Netlify, Cloudflare Pages, Fly.io, and
  Render. The broader frontend-cloud / edge competitive set is detailed in
  [`cloudflare-cdn.md`](./cloudflare-cdn.md).
  - [Middle East Eye](https://www.middleeasteye.net/trending/developers-drop-vercel-call-boycott-after-ceo-posts-selfie-netanyahu)

---

## Items marked "Could not verify"

- **Exact ZEIT founding month (2015) and the original co-founder list** — the year
  (2015) and Rauch as founder are sourced; the **November 2015** date and
  **Kovanen/Kanezawa** as ZEIT co-founders are **reported by secondary profiles**,
  not pinned to a primary document here.
- **Exact launch date of `now` / `now.sh`** — 2016 is sourced via the company's
  retrospective; a dated primary launch announcement was not located.
- **A distinct, separately announced Series B round** — the verified ladder is
  Series A ($21M, 2020) → C ($102M, 2021) → D ($150M, 2021) → E ($250M, 2024) →
  F ($300M, 2025). A clean, primary-sourced **Series B** event was **not** located
  in this pass (the $21M was branded "Series A"; the next announced round was the
  Series C). Flagged rather than asserted.
- **Acquisition dates/terms for Turborepo (Dec 2021), Splitbee (Oct 2022),
  Tremor (Jan 2025), and NuxtLabs (Jul 2025)** — sourced via Wikipedia; not pinned
  to primary Vercel announcements in this pass.
- **Tom Occhino's exact CPO start date** — March 2023 → September 2023 progression
  is per his profile/secondary sources, not a primary Vercel announcement.
- **Lee Robinson's exact Cursor title/start date** — "Head of AI Education at
  Cursor" is **reported**; his Vercel departure (July 2025) is sourced to his own
  posts.
- **Bill-shock dollar figures** (Jmail ~$50k; DDoS ~$23k) — **reported** by affected
  creators / secondary coverage, not primary Vercel statements.
- **Date of the Netanyahu meeting/post (~Sept 15, 2025)** and the **scale of
  customer churn** — secondary reporting; churn is **contested** between Rauch and
  critics.
- **The open-source-vs-hosted "lock-in" tension** — a real and recurring community
  theme but **characterization/sentiment**, not a single authoritative primary fact.
- **The X/Twitter posts** for Tom Occhino's join and Lee Robinson's departure
  returned HTTP 402 to automated fetching; their content is visible via
  search-indexing and corroborated by the cited profile pages / leerob.com.
