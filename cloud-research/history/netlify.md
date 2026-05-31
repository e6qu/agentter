# Netlify — A Sourced History

A chronological, sourced history of **Netlify** — the web-development and hosting
platform founded by Danish entrepreneurs **Mathias Biilmann** (also styled "Matt
Biilmann" / "Mathias Biilmann Christensen") and **Christian "Chris" Bach**, which
grew out of Biilmann's earlier **BitBalloon** drag-and-drop static host, publicly
launched as Netlify in **2015**, **coined and championed the term "Jamstack"**
(JavaScript / APIs / Markup), and built the git-driven build + global CDN +
deploy-preview workflow that defined the static-first/composable web era. Every
non-trivial claim links to a working source. Primary sources (Netlify's own blog
and press releases, founder posts, funding announcements) are preferred, with
reputable outlets (TechCrunch, The Register, etc.) and Wikipedia as corroboration.
Items that could not be confirmed are marked **"Could not verify."**

> **Cross-references (not duplicated here):**
> - Netlify's place in the broader CDN / edge-functions / Jamstack landscape —
>   alongside Cloudflare Pages, Fastly, Akamai, and the cloud-provider CDNs — is set
>   in [`cloudflare-cdn.md`](./cloudflare-cdn.md). That doc covers the market
>   positioning and the edge-runtime bets; this doc covers Netlify's own corporate
>   and product history.
> - Netlify's chief rival **Vercel** (ZEIT) has its own corporate/product history in
>   [`vercel.md`](./vercel.md). The Netlify-vs-Vercel rivalry is noted here but the
>   Vercel-internal detail lives there.

---

## Timeline

### 2013 — BitBalloon, the drag-and-drop predecessor

Before Netlify, **Mathias Biilmann** built **BitBalloon**, a static-site host whose
pitch was that you could "drag and drop a site folder onto bitballoon.com (or make a
call to the API)" and have it "automatically optimized and deployed onto production
hosting." BitBalloon is the technical and conceptual seed of Netlify.
- BitBalloon — Mathias Biilmann (founder's own page on BitBalloon):
  http://mathias-biilmann.net/posts/bitballoon
- Crunchbase, "BitBalloon": https://www.crunchbase.com/organization/bitballoon
- **Could not verify** the exact BitBalloon launch date against a primary
  announcement; Crunchbase lists a **June 1, 2013** founding date and names
  **Michael Ruescher** as a co-founder/CMO, but this was not confirmed against a
  primary BitBalloon document — treat the exact 2013 date and the second name as
  **reported, not primary-verified**.

### 2014 — The company is founded

The legal entity behind Netlify was founded in **2014** by **Mathias Biilmann**,
with **Christian Bach** joining as co-founder in **2015**. Biilmann and Bach are
Danish; secondary profiles describe them as longtime friends who relocated to San
Francisco. Per Wikipedia, the company was incorporated on **January 27, 2014** and
was originally named **MakerLoop, Inc.**, rebranded to **Netlify** in 2017.
- Wikipedia, "Netlify": https://en.wikipedia.org/wiki/Netlify
- **Could not verify** the **MakerLoop, Inc.** original corporate name and the
  exact **January 27, 2014** incorporation date against a primary
  Netlify/registry document in this pass; both are sourced via Wikipedia. The
  founding year (2014), Biilmann as founder, and Bach as 2015 co-founder are
  consistent across sources.

### 2015-04-07 — Netlify publicly launches

Netlify **publicly launched on April 7, 2015**, evolving BitBalloon's simple
static-site/app hosting and adding the git integration for continuous deployment
that became its signature.
- Wikipedia, "Netlify" (public launch April 7, 2015): https://en.wikipedia.org/wiki/Netlify
- **Could not verify** the exact April 7, 2015 launch date against a primary,
  dated Netlify announcement in this pass; the 2015 launch is sourced via Wikipedia
  and corroborated by the company's later retrospectives.

### 2015–2016 — Biilmann coins and champions "JAMstack"

Biilmann (with Bach) **coined the term "JAMstack"** — for **JavaScript, APIs, and
Markup** — to name the static-first, API-driven, CDN-served architecture Netlify was
built around, as an alternative to traditional server-rendered "LAMP"-style stacks.
Sources split on the precise date: the term is generally dated to **2015**, and it
was **publicly introduced** at **SmashingConf San Francisco in 2016**, where Biilmann
spoke. (See the format note below: both the 2015 coinage and the 2016 public
introduction are reported, and are preserved here rather than collapsed.)
- Smashing Magazine, "The Evolution Of Jamstack" (2021): https://www.smashingmagazine.com/2021/05/evolution-jamstack/
- SmashingConf SF 2016 speaker page, Mathias Biilmann: https://archive.smashingconf.com/sf-2016/speakers/mathias-biilman.html
- Jamstack.org: https://jamstack.org/
- Wikipedia, "JAMstack": https://en.wikipedia.org/wiki/JAMstack
- **Note on the date:** sources split between "coined 2015" and "introduced at
  SmashingConf 2016"; both are reported and preserved. (This matches the same
  distinction noted in [`cloudflare-cdn.md`](./cloudflare-cdn.md).)

### 2016-08 — $2.1M seed

Netlify raised **$2.1M in seed funding** in **August 2016**.
- Wikipedia, "Netlify" (Aug 2016, $2.1M seed): https://en.wikipedia.org/wiki/Netlify
- **Could not verify** the exact date/investor list against a primary Netlify
  announcement in this pass; sourced via Wikipedia.

### 2017-08-09 — $12M Series A (Andreessen Horowitz)

Netlify announced a **$12M Series A** on **August 9, 2017**, **led by Andreessen
Horowitz (a16z)**, with existing investors **Bloomberg Beta, Designer Fund, and Tank
Hill Ventures**. **Peter Levine** of a16z joined the board. (Attribution: Netlify.)
- Netlify, "Netlify Raises $12m from A16Z" (Aug 9, 2017): https://www.netlify.com/blog/2017/08/09/netlify-raises-dollar12m-from-a16z/
- FinSMEs, "Netlify Raises $12M in Series A Funding": http://www.finsmes.com/2017/08/netlify-raises-12m-in-series-a-funding.html

### 2018-03-20 — Netlify Functions (serverless via AWS Lambda)

Netlify launched **Functions** on **March 20, 2018** — serverless functions that
deploy "as simple as adding a file to your Git repository," running on **AWS Lambda**
under the hood but without the developer needing to configure API gateways or own an
AWS account. The functions are version-controlled, built, and deployed alongside the
rest of the site. (Attribution: Netlify.)
- Netlify, "Netlify's AWS Lambda functions bring the backend to your frontend
  workflow" (Mar 20, 2018): https://www.netlify.com/blog/2018/03/20/netlifys-aws-lambda-functions-bring-the-backend-to-your-frontend-workflow/

### 2018-10-09 — $30M Series B (Kleiner Perkins); the "Application Delivery Network"

Netlify announced a **$30M Series B** on **October 9, 2018**, **led by Kleiner
Perkins**, with participation from Andreessen Horowitz and angels including
**Stewart Butterfield** (Slack/Flickr co-founder) and **Jeremy Stoppelman** (Yelp
CEO/co-founder). Netlify framed the round around replacing web servers with a global
**"Application Delivery Network."** Reporting put total raised at **>$44M**.
- Netlify, "Netlify Raises $30 Million to Replace Web Servers with a Global
  'Application Delivery Network'": https://www.netlify.com/press/netlify-raises-usd30-million-to-replace-web-servers-with-a-global-application-delivery-network/
- TechCrunch, "Netlify just got $30 million to change the way developers build
  websites" (Oct 9, 2018): https://techcrunch.com/2018/10/09/netlify-just-got-30-million-to-change-the-way-developers-build-websites/

### 2020-03-04 — $53M Series C (EQT Ventures); 800,000 developers

Netlify announced a **$53M Series C** on **March 4, 2020**, **led by EQT Ventures**,
with participation from existing investors Andreessen Horowitz and Kleiner Perkins,
plus **Preston-Werner Ventures**. The company said it had onboarded **800,000**
developers/businesses and put total raised to date at **$97M**.
- Netlify press, "After Onboarding 800,000 Developers, Netlify Raises $53M in Series
  C Funding to Fuel Enterprise Growth": https://www.netlify.com/press/after-onboarding-800000-developers-netlify-raises-53m-in-series-c-funding-to-fuel-enterprise-growth/
- Netlify blog, "Netlify secures Series C funding…" (Mar 4, 2020): https://www.netlify.com/blog/2020/03/04/netlify-secures-series-c-funding-to-push-forward-our-vision-for-the-web/
- TechCrunch, "Netlify nabs $53M Series C…" (Mar 4, 2020): https://techcrunch.com/2020/03/04/netfily-nabs-53m-series-c-as-micro-services-approach-to-web-development-grows/

### 2020 — "JAMstack" → "Jamstack" (the lowercase rebrand)

In **2020**, after community discussion, Netlify and the jamstack.org community
standardized the spelling from the all-caps **"JAMstack"** to **"Jamstack"**
(treating it as a proper noun rather than an acronym).
- The New Stack, "Is Jamstack Toast? Some Developers Say Yes, Netlify Says No":
  https://thenewstack.io/is-jamstack-toast-some-developers-say-yes-netlify-says-no/
- jamstack/jamstack.org GitHub issue, "evolving the JAMstack branding design":
  https://github.com/jamstack/jamstack.org/issues/292
- **Could not verify** the precise 2020 date of the spelling change against a single
  primary Netlify announcement; the change and its rationale are sourced via the
  community issue and The New Stack.

### 2021-05-19 — Acquires FeaturePeek (deploy previews)

Netlify acquired **FeaturePeek** — a Y Combinator (S19) and Matrix Partners-backed
collaboration/preview startup — announced **May 19, 2021**, folding it into the next
generation of **Netlify Deploy Previews**. (Attribution: Netlify.)
- Netlify press, "Netlify Acquires FeaturePeek and Launches Next Generation of Deploy
  Previews…": https://www.netlify.com/press/netlify-acquires-featurepeek-and-launches-next-generation-of-deploy-previews-to-streamline-collaboration-for-web-teams/
- Netlify blog (May 19, 2021): https://www.netlify.com/blog/2021/05/19/next-generation-deploy-previews-plus-netlify-acquires-featurepeek/

### 2021-11-17 — $105M Series D at a $2B valuation; acquires OneGraph

Netlify announced a **$105M Series D** on **November 17, 2021**, **led by Bessemer
Venture Partners**, at a **$2 billion** valuation, with participation from existing
investors **Andreessen Horowitz, BOND, EQT Ventures, Kleiner Perkins, Mango Capital,
and Menlo Ventures**. The round came ~18 months after the $53M Series C; Netlify said
**over two million developers** had used the platform. Concurrently, Netlify
**acquired OneGraph**, a GraphQL platform (Y Combinator / SignalFire-backed;
co-founders **Sean Grove** and **Daniel Woelfel**) aimed at putting "all of the
internet's APIs under a single GraphQL endpoint." Reporting put total raised at
**$212M**. (Attribution: Netlify.)
- Netlify press, "Netlify Raises $105 Million to Transform Development for the Modern
  Web": https://www.netlify.com/press/netlify-raises-usd105-million-to-transform-development-for-the-modern-web/
- Netlify blog, "Netlify Acquires OneGraph…" (Nov 17, 2021): https://www.netlify.com/blog/2021/11/17/netlify-acquires-onegraph-a-powerful-graphql-platform-for-connecting-apis-and-services/
- TechCrunch, "Netlify snags $105M Series D…" (Nov 17, 2021): https://techcrunch.com/2021/11/17/netlify-snags-105m-series-d-to-fuel-jamstack-focused-web-development/
- The Register, "Netlify acquires OneGraph…" (Nov 19, 2021): https://www.theregister.com/2021/11/19/netlify_onegraph/

### 2022-02-01 — Acquires Quirrel (serverless scheduling)

Netlify acquired **Quirrel** — an open-source job/queue/scheduling service for
serverless functions built by **Simon Knott** (maintainer of Blitz.js) — announced
**February 1, 2022**. Per TechCrunch, Quirrel had raised no outside funding, and the
deal had quietly closed mid-2021 after a Netlify investor's introduction.
- TechCrunch, "Netlify acquires serverless scheduling service Quirrel" (Feb 1, 2022):
  https://techcrunch.com/2022/02/01/netlify-acquires-quirrel/
- **Could not verify** a primary Netlify press release for the Quirrel deal in this
  pass; the acquisition is sourced via TechCrunch and Wikipedia.

### 2022-04-19 — Netlify Edge Functions (powered by Deno)

Netlify announced **Edge Functions** in **public beta on April 19, 2022** —
serverless JavaScript/TypeScript that runs at the network edge, **built on the Deno
runtime** (chosen for security and isolation suited to multi-tenant edge code), and
designed to work with frameworks like Next.js, Nuxt, Astro, Eleventy, SvelteKit, and
Remix. (Attribution: Netlify.)
- Netlify blog, "Netlify Edge Functions: Serverless Compute Powered by Deno"
  (Apr 19, 2022): https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/
- Netlify press, "Netlify Edge Functions Accelerate Development of Modern Web
  Applications at the Edge": https://www.netlify.com/press/netlify-edge-functions-accelerate-development-of-modern-web-applications-at-the-edge/
- Deno blog, "Netlify Edge Functions on Deno Deploy": https://deno.com/blog/netlify-edge-functions-on-deno-deploy
  *(The Deno-powered detail is also cross-referenced in
  [`cloudflare-cdn.md`](./cloudflare-cdn.md).)*

### 2022-12 — Layoffs (~16% of staff)

In **December 2022**, Netlify conducted a **layoff** that secondary
reporting/employee accounts put at roughly **16%** of staff (~48 employees). This
preceded the Gatsby acquisition by weeks and drew criticism over the timing.
- nixCraft on Mastodon (noting "a 16% layoff"): https://mastodon.social/@nixCraft/109790645337177937
- TrueUp, "Netlify — Layoffs": https://www.trueup.io/co/netlify/layoffs
- **Could not verify** the exact percentage/headcount or date against a primary
  Netlify statement in this pass; the ~16% / ~48-employee figures are **reported**
  by secondary/employee sources, not a primary company announcement.

### 2023-02-01 — Acquires Gatsby Inc.

Netlify **acquired Gatsby Inc.** — the company behind the open-source **Gatsby**
React framework and **Gatsby Cloud** — announced **February 1, 2023**. Netlify
emphasized Gatsby's **Valhalla Content Hub** (a unified GraphQL data layer) and
committed to stewarding the open-source Gatsby framework. Reporting noted Gatsby had
raised ~**$46.8M** (including a 2020 **$28M Series B** led by Index Ventures); the
purchase price was **not disclosed**. Gatsby Cloud features were subsequently folded
into Netlify, and Gatsby Cloud was wound down. (Attribution: Netlify.)
- Netlify press, "Netlify Acquires Gatsby Inc. to Accelerate Adoption of Composable
  Web Architectures": https://www.netlify.com/press/netlify-acquires-gatsby-inc-to-accelerate-adoption-of-composable-web-architectures/
- Gatsby blog, "Gatsby is joining Netlify": https://www.gatsbyjs.com/blog/gatsby-is-joining-netlify/
- TechCrunch, "Netlify acquires front-end platform Gatsby" (Feb 1, 2023): https://techcrunch.com/2023/02/01/netlify-acquires-frontend-platform-gatsby/
- **Could not verify** the **purchase price** (undisclosed) or the precise
  post-acquisition Gatsby Cloud shutdown timeline against primary sources beyond the
  acquisition posts above. The decline of the Gatsby project post-acquisition is
  **characterization/reporting** (e.g., Smashing Magazine, "The End Of My Gatsby
  Journey," 2024: https://www.smashingmagazine.com/2024/03/end-of-gatsby-journey/),
  not a single company-stated fact.

### 2023-06-29 — Acquires Stackbit (visual editing)

Netlify acquired **Stackbit**, a visual-editing/content tooling company, dated by
Wikipedia to **June 29, 2023**.
- Wikipedia, "Netlify" (Stackbit, June 29, 2023): https://en.wikipedia.org/wiki/Netlify
- **Could not verify** the exact date/terms against a primary Netlify announcement in
  this pass; sourced via Wikipedia.

### 2024-02-16 — The $104,500 DDoS bill and pricing backlash

On or about **February 16, 2024**, a developer publicly reported a **$104,500
Netlify bill** for a small static side-project site after it was hit by what amounted
to a **DDoS / traffic flood** — reportedly ~**190 TB** of traffic over four days,
with a peak day of ~**60.7 TB**, billed at Netlify's overage rate. The story went
viral on Hacker News and triggered a **pricing-and-safeguards backlash** (no spending
limits, no automatic DDoS protection on free sites, slow proactive communication).
Netlify CEO **Matt Biilmann** responded on Hacker News (handle **"bobfunk"**),
saying support had reached out and the bill **would be forgiven**, and describing the
policy as not shutting down free sites during non-attack-pattern spikes but
**forgiving bills from legitimate mistakes after the fact**. (Facts: the bill,
forgiveness, and CEO response are sourced; some figures are reported by the affected
developer.)
- Hacker News, "Netlify just sent me a $104k bill for a simple static site": https://news.ycombinator.com/item?id=39520776
- Hacker News, Biilmann's reply ("Netlify CEO here. Our support team has reached out
  to the user from the thread…"): https://news.ycombinator.com/item?id=39521986
- Cybernews, "User got a $104K bill from hosting provider: 'I thought it was a joke'":
  https://cybernews.com/news/ddos-attack-104k-bill-from-hosting-provider/
- **Could not verify** the exact bandwidth volumes (~190 TB / ~60.7 TB peak) and the
  precise per-GB overage math against a primary Netlify statement; those figures are
  **reported** by the affected developer and secondary coverage. The bill-forgiveness
  and CEO response are sourced to the HN thread above.

### 2025 — The "Agent Experience (AX)" / AI-agent pivot

Beginning in **early 2025**, Biilmann publicly pushed a strategic pivot around
**"Agent Experience" (AX)** — which he defines as "the holistic experience AI agents
will have as the user of a product or platform" — arguing that AX would be Netlify's
"north star" for the next decade the way developer experience (DX) had been for the
prior one. Netlify built flows aimed at AI coding agents (e.g. "deploy anonymously,
then claim" a site), responding to the rise of AI app-builders like Bolt and
Lovable, and ran an **"Agent Week 2025."** (Attribution: Biilmann / Netlify.)
- Biilmann, "Introducing AX: Why Agent Experience Matters": https://biilmann.blog/articles/introducing-ax/
- Netlify, "Agent Experience (AX)": https://www.netlify.com/agent-experience/
- Netlify blog, "Agent Week 2025: Making It Easier to Go from Prompt to Production":
  https://www.netlify.com/blog/agent-week-2025/
- **Could not verify** the specific growth metrics sometimes cited around this pivot
  (e.g. "daily signups grew 10x," "daily new paying customers grew ~500x") against a
  primary, dated Netlify disclosure; treat those as **company-reported/secondary**,
  not independently verified.

---

## Key people & teams

- **Mathias Biilmann** (a.k.a. **Matt Biilmann** / **Mathias Biilmann Christensen**)
  — **co-founder and CEO** of Netlify. Danish; previously built **BitBalloon**.
  **Coined the term "Jamstack"** and is its chief evangelist; later the public face
  of the **"Agent Experience (AX)"** pivot. Uses the handle **"bobfunk"** on Hacker
  News.
  - Crunchbase, "Mathias Biilmann Christensen": https://www.crunchbase.com/person/matt-billmann-christensen
  - Founder's site: http://mathias-biilmann.net/about
  - Wikipedia, "Netlify": https://en.wikipedia.org/wiki/Netlify

- **Christian "Chris" Bach** — **co-founder** of Netlify (joined **2015**), described
  in his own interviews as holding **CCO / CSO**-type roles (creative/strategy). Danish;
  longtime collaborator of Biilmann.
  - TechBBQ interview with Christian Bach (CCO/CSO of Netlify): https://techbbq.dk/08-interview-with-christian-bach-cco-cso-of-netlify/
  - Wikipedia, "Netlify": https://en.wikipedia.org/wiki/Netlify
  - **Could not verify** Bach's exact current title against a primary Netlify "about"
    page in this pass; "CCO/CSO" is per his own TechBBQ interview.

- **Peter Levine** (Andreessen Horowitz) — joined Netlify's **board** with the 2017
  Series A.
  - Netlify, "Netlify Raises $12m from A16Z": https://www.netlify.com/blog/2017/08/09/netlify-raises-dollar12m-from-a16z/

- **Sean Grove & Daniel Woelfel** — co-founders of **OneGraph** (acquired Nov 2021);
  joined Netlify to lead API-ecosystem work.
  - Netlify blog (OneGraph): https://www.netlify.com/blog/2021/11/17/netlify-acquires-onegraph-a-powerful-graphql-platform-for-connecting-apis-and-services/

- **Simon Knott** — creator of **Quirrel** (acquired 2022) and maintainer of Blitz.js.
  - TechCrunch (Quirrel): https://techcrunch.com/2022/02/01/netlify-acquires-quirrel/

---

## Company & corporate history

- **~2013** — **BitBalloon**, Biilmann's drag-and-drop static host, the predecessor
  to Netlify. [Founder page](http://mathias-biilmann.net/posts/bitballoon) ·
  [Crunchbase](https://www.crunchbase.com/organization/bitballoon)
- **2014** — Company founded by **Mathias Biilmann** (originally **MakerLoop, Inc.**
  per Wikipedia); **Christian Bach** joins as co-founder **2015**.
  [Wikipedia](https://en.wikipedia.org/wiki/Netlify)
- **April 7, 2015** — **Netlify publicly launches** (git-driven deploys + global CDN).
  [Wikipedia](https://en.wikipedia.org/wiki/Netlify)
- **2015–2016** — Biilmann **coins "JAMstack"**; publicly introduced at **SmashingConf
  SF 2016**. [Smashing](https://www.smashingmagazine.com/2021/05/evolution-jamstack/) ·
  [SmashingConf](https://archive.smashingconf.com/sf-2016/speakers/mathias-biilman.html)
- **Aug 2016** — **$2.1M seed**. [Wikipedia](https://en.wikipedia.org/wiki/Netlify)
- **Aug 9, 2017** — **$12M Series A** (a16z). [Netlify](https://www.netlify.com/blog/2017/08/09/netlify-raises-dollar12m-from-a16z/)
- **Mar 20, 2018** — **Netlify Functions** (serverless on AWS Lambda).
  [Netlify](https://www.netlify.com/blog/2018/03/20/netlifys-aws-lambda-functions-bring-the-backend-to-your-frontend-workflow/)
- **Oct 9, 2018** — **$30M Series B** (Kleiner Perkins); "Application Delivery Network."
  [Netlify](https://www.netlify.com/press/netlify-raises-usd30-million-to-replace-web-servers-with-a-global-application-delivery-network/)
- **Mar 4, 2020** — **$53M Series C** (EQT Ventures); 800k developers.
  [Netlify](https://www.netlify.com/press/after-onboarding-800000-developers-netlify-raises-53m-in-series-c-funding-to-fuel-enterprise-growth/)
- **2020** — **"JAMstack" → "Jamstack"** spelling standardized.
  [GitHub issue](https://github.com/jamstack/jamstack.org/issues/292)
- **May 19, 2021** — acquires **FeaturePeek** (deploy previews).
  [Netlify](https://www.netlify.com/press/netlify-acquires-featurepeek-and-launches-next-generation-of-deploy-previews-to-streamline-collaboration-for-web-teams/)
- **Nov 17, 2021** — **$105M Series D** at **$2B** (Bessemer); acquires **OneGraph**.
  [Netlify](https://www.netlify.com/press/netlify-raises-usd105-million-to-transform-development-for-the-modern-web/) ·
  [TechCrunch](https://techcrunch.com/2021/11/17/netlify-snags-105m-series-d-to-fuel-jamstack-focused-web-development/)
- **Feb 1, 2022** — acquires **Quirrel** (serverless scheduling).
  [TechCrunch](https://techcrunch.com/2022/02/01/netlify-acquires-quirrel/)
- **Apr 19, 2022** — **Edge Functions** (on **Deno**).
  [Netlify](https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/)
- **Dec 2022** — **layoffs (~16%, reported)**. [TrueUp](https://www.trueup.io/co/netlify/layoffs)
- **Feb 1, 2023** — acquires **Gatsby Inc.** (framework + Valhalla Content Hub).
  [Netlify](https://www.netlify.com/press/netlify-acquires-gatsby-inc-to-accelerate-adoption-of-composable-web-architectures/) ·
  [TechCrunch](https://techcrunch.com/2023/02/01/netlify-acquires-frontend-platform-gatsby/)
- **Jun 29, 2023** — acquires **Stackbit** (visual editing).
  [Wikipedia](https://en.wikipedia.org/wiki/Netlify)
- **Feb 16, 2024** — **$104,500 DDoS bill** backlash; CEO forgives bill.
  [HN thread](https://news.ycombinator.com/item?id=39520776) ·
  [CEO reply](https://news.ycombinator.com/item?id=39521986)
- **2025** — **"Agent Experience (AX)"** / AI-agent pivot; **Agent Week 2025**.
  [Biilmann](https://biilmann.blog/articles/introducing-ax/) ·
  [Netlify](https://www.netlify.com/blog/agent-week-2025/)

**Funding ladder (verified):** Seed $2.1M (Aug 2016) → Series A $12M (Aug 2017) →
Series B $30M (Oct 2018) → Series C $53M (Mar 2020) → **Series D $105M @ $2B
(Nov 2021)**. Total reported raised ~**$212M**. As of this pass, **no funding round
after the Nov 2021 Series D** was located; secondary trackers (e.g.
[Tracxn](https://tracxn.com/d/companies/netlify/__UWAWrsJpFE3Vzn9J3YuRMWLZp1E84BA2KtPNWeH9EUE/funding-and-investors))
still list the Series D as the latest, with reported revenue of ~**$33M (2023)** →
~**$46.3M (2024)** per third-party estimates (not primary-verified).

---

## Product throughline & the Vercel rivalry

**What Netlify built:** a **git-driven build** pipeline (connect a repo; every push
triggers an atomic build + deploy), a **global CDN**/"Application Delivery Network"
serving pre-built assets, **Deploy Previews** (a live preview URL per pull request),
**Netlify Functions** (serverless on AWS Lambda, 2018), and **Edge Functions**
(serverless at the edge on Deno, 2022) — the canonical **Jamstack** workflow Biilmann
named and evangelized. (Sources: Functions —
[Netlify 2018](https://www.netlify.com/blog/2018/03/20/netlifys-aws-lambda-functions-bring-the-backend-to-your-frontend-workflow/);
Edge Functions —
[Netlify 2022](https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/);
Deploy Previews / FeaturePeek —
[Netlify 2021](https://www.netlify.com/blog/2021/05/19/next-generation-deploy-previews-plus-netlify-acquires-featurepeek/).)

**The Vercel rivalry:** Netlify (2014, Jamstack-first, framework-neutral) and
**Vercel** (2015, formerly ZEIT, built around **Next.js**) are widely described as
the two leading "frontend cloud" / Jamstack deployment platforms and each other's
strongest direct competitor — both offering git-push deploys, deploy previews, and
serverless/edge functions. Their differentiation is commonly framed as Vercel's deep
Next.js optimization vs. Netlify's broader framework neutrality.
- Codecademy, "Vercel vs Netlify": https://www.codecademy.com/article/vercel-vs-netlify-which-one-should-you-choose
- Prismic, "Vercel vs Netlify": https://prismic.io/blog/vercel-vs-netlify
- The Vercel-internal history is in [`vercel.md`](./vercel.md); the broader
  frontend-cloud/edge landscape is in [`cloudflare-cdn.md`](./cloudflare-cdn.md).
  *(This is competitive-landscape **characterization** from comparison write-ups, not
  a single company-stated fact.)*

---

## Items marked "Could not verify"

- **BitBalloon's exact launch date and co-founders** — the ~2013 origin and Biilmann
  as creator are sourced; the **June 1, 2013** date and **Michael Ruescher** as
  co-founder/CMO are **reported by Crunchbase**, not pinned to a primary BitBalloon
  document.
- **Original corporate name "MakerLoop, Inc." and the Jan 27, 2014 incorporation
  date** — sourced via **Wikipedia**, not a primary registry/Netlify document.
- **Exact April 7, 2015 public-launch date** — sourced via Wikipedia; a dated
  primary Netlify launch announcement was not located in this pass.
- **JAMstack coinage date (2015 vs. 2016)** — sources split between "coined 2015" and
  "introduced at SmashingConf 2016"; both reported and preserved.
- **$2.1M seed (Aug 2016) date/investors** — sourced via Wikipedia, not a primary
  announcement.
- **2020 "JAMstack → Jamstack" spelling change** — sourced via the community GitHub
  issue and The New Stack; no single primary dated Netlify announcement located.
- **Quirrel and Stackbit acquisition primary press / terms** — Quirrel via
  TechCrunch; Stackbit (June 29, 2023) via Wikipedia; primary Netlify press not
  located for both in this pass.
- **Dec 2022 layoffs (~16% / ~48 employees)** — **reported** by secondary/employee
  sources (TrueUp, Mastodon), not a primary Netlify statement.
- **Gatsby purchase price (undisclosed)** and the **post-acquisition Gatsby decline**
  — the acquisition is sourced; price was not disclosed; the framework's decline is
  **characterization/reporting** (Smashing Magazine), not a company-stated fact.
- **$104,500-bill bandwidth figures (~190 TB / ~60.7 TB peak)** — **reported** by the
  affected developer / secondary coverage; the bill-forgiveness and CEO response are
  sourced to the Hacker News thread.
- **AX-pivot growth metrics ("10x signups," "~500x paying customers")** —
  **company-reported/secondary**, not independently verified.
- **Christian Bach's exact current title** — "CCO/CSO" is per his own TechBBQ
  interview, not a primary Netlify "about" page.
- **Any funding round after the Nov 2021 Series D**, and **2023/2024 revenue figures
  (~$33M / ~$46.3M)** — no post-D round located; revenue figures are **third-party
  estimates** (Latka/Tracxn), not primary-verified.
