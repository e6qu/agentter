# Surge.sh — A Sourced History (One of the First "`npm install surge`, then `surge`" Static Hosts)

A chronological, sourced history of **Surge.sh** — the command-line static-web
publishing service built by **Brock Whitten** (a.k.a. **sintaxi**) and his company
**Chloi Inc.**, which let a front-end developer install a tool from npm and put a
folder of HTML/CSS/JS online with a single `surge` command, for free. Surge was one
of the **earliest CLI-driven static-site publishing tools**, predating the rise of
Netlify, Vercel (ZEIT), and the "Jamstack" framing, and it grew directly out of
Whitten's earlier **Harp** static web server. Every non-trivial claim links to a
working source. Primary sources (the founder's own "Introducing Surge" post, the
npm registry, the GitHub repo, the founder's site) are preferred, with reputable
corroboration where useful.

This is a **small, old, founder-run indie product**, not a venture-scale company,
so the documentary record is **thin** — there are no funding rounds, press releases,
or corporate filings to trace. The doc is kept proportionate to that record, and
gaps are flagged rather than padded. Items that could not be confirmed are marked
**"Could not verify."** Last verified: 2026-05-31.

---

## Timeline

### 2012 — The precursor: Harp / Harp.io (Mozilla WebFWD)

Before Surge, Whitten co-built **Harp**, an open-source static web server with
built-in preprocessing, and the **Harp Platform**, a hosting/deployment service. The
Mozilla Hacks blog introduced **Harp.io** on **October 3, 2012**, naming its
creators as **Rob Ellis, Brock Whitten, and Jorge Pedret**, and describing it as
"one of the companies in Mozilla's WebFWD portfolio" — a Dropbox-backed development
platform meant to make web deployment dramatically simpler than FTP or GitHub Pages.
- Mozilla Hacks, "Much simpler web deployment ahead: Harp.io" (Oct 3, 2012):
  <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/>
- Whitten's own site frames Surge as the lineal descendant of this work: he lists
  **Harp** ("zero-configuration static web server with built-in preprocessing") and
  **Surge** ("CLI platform for deploying static websites to a global CDN") as
  distinct creations, and describes himself as **founder & principal engineer** of
  the Surge Platform and a **Mozilla WebFWD** alumnus.
  Source (founder's site): <https://sintaxi.com/>
  - **Could not verify** a clean primary-sourced statement that the "Harp Platform"
    was formally shut down and *re-launched* as Surge; the evolution is **described
    by the founder** (Harp and Surge as related projects from the same person/team)
    and by secondary summaries, not pinned to a single dated migration announcement.
    The original **harpjs.com / harp.sh** blog posts that once documented the Harp
    Platform now resolve to a parked/hijacked domain and were **not** usable as a
    source in this pass.

### 2014-07-18 — First `surge` npm publish (the real "birth" anchor)

The **earliest hard, dated primary artifact** for Surge is the npm package. The
`surge` package was **first published on 2014-07-18** (version `0.0.0`), with rapid
versioning through the second half of 2014 (`0.1.0` on 2014-08-16, `0.2.0` on
2014-08-28, `0.3.0` on 2014-09-17). The package is authored by **Brock Whitten
(brock@chloi.io)** under the **ISC** license, described simply as **"Static Web
Publishing."**
- npm registry metadata for `surge` (created `2014-07-18T18:36:30Z`; author Brock
  Whitten / brock@chloi.io; ISC): <https://registry.npmjs.org/surge>
- npm package page: <https://www.npmjs.com/package/surge>

This npm date is why Surge is properly dated to **circa 2013–2014**: the
**tooling first shipped publicly in mid-2014**, even though the public-facing
marketing ("Introducing Surge") came later. (See the dating note below.)

### 2014-07-26 — The `sintaxi/surge` CLI repository

The GitHub repository **`sintaxi/surge`** ("CLI for the surge.sh CDN") was
**created on 2014-07-26**, a week after the first npm publish. As of this pass it has
~**3,032 stars**, is **not archived**, and is still receiving releases.
- GitHub API metadata for `sintaxi/surge` (created `2014-07-26T09:30:05Z`; ~3,032
  stars; not archived): <https://api.github.com/repos/sintaxi/surge>
- Repository: <https://github.com/sintaxi/surge>

### 2015-01 — Earliest archived surge.sh website

The **earliest Wayback Machine capture of `surge.sh`** is **2015-01-21**, with
regular captures continuing through 2015. (The Internet Archive has no 2013 or 2014
snapshot of the homepage, consistent with the public site coming together around the
turn of 2015 even though the CLI shipped in mid-2014.)
- Internet Archive availability API (closest snapshot to 2014-01-01 is
  `20150121083347`): <http://archive.org/wayback/available?url=surge.sh&timestamp=20140101>
- Wayback CDX index (first listed captures begin `20150121`):
  <http://web.archive.org/cdx/search/cdx?url=surge.sh&output=json&from=2013&to=2015>

### 2015-03-03 — "Introducing Surge" (the public launch post)

Whitten published **"Introducing Surge — the CDN for Front-End Developers"** on the
**surge.sh Medium publication** on **March 3, 2015**. It pitches Surge as a way to
deploy a static/native web app by running `npm install -g surge` and then `surge`
(optionally `surge www`) from a project directory, and highlights features like
clean URLs, graceful trailing-slash handling, fallback 404 pages, and a catch-all
file for **PushState** apps. The post thanks **@sintaxi, @rob_ellis, and
@kennethormandy** and credits the team at **chloi.io**.
- Brock Whitten, "Introducing Surge" (Mar 3, 2015), surge.sh Medium publication:
  <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- Contemporary corroboration — Raymond Camden, "Hosting static sites with Surge"
  (Mar 4, 2015): <https://www.raymondcamden.com/2015/03/04/hosting-static-sites-with-surge>

### 2016-06-10 — Hacker News "Show"-style discussion; the free model debated

Surge surfaced on **Hacker News on June 10, 2016** ("Surge – Static Web Publishing
for Front-End Developers," submitted by *stevelacy*), where the **free tier** and
paid pricing were debated. Whitten ("Brock from Surge.sh") participated, noting the
free plan offered unlimited projects with custom domains, while paid features
(custom SSL, basic auth, custom redirects) sat behind a subscription; several
commenters compared the paid tier unfavorably to S3/CloudFront and GitHub Pages.
- Hacker News, "Surge – Static Web Publishing for Front-End Developers"
  (Jun 10, 2016): <https://news.ycombinator.com/item?id=11878339>

### 2014–present — The free static-hosting model

Surge's enduring pitch is **free, single-command static hosting**: publish any
folder, get a `*.surge.sh` subdomain (or a custom domain), with basic SSL, at no
cost; paid tiers add production features. As of this pass the live pricing page
lists a **free "Surge"** plan ("Unlimited publishing, Custom domain, Basic SSL") and
a paid **"Surge Professional"** plan (listed at **$30/month**) adding custom SSL,
forced HTTPS, CORS, custom redirects, and password protection.
- Surge pricing page: <https://surge.sh/pricing>
- Surge homepage / "Front-end devs deploy.": <https://surge.sh/>
  - **Note:** the exact free-vs-paid feature split and the paid price have changed
    over time (the 2016 HN thread references a **$13/month** tier; the current page
    shows **$30/month**). Treat specific dollar figures as **point-in-time**, sourced
    to the page/thread where they appear.

### Maintenance status — quiet but not dead (verify, don't assume)

The brief's premise that Surge "has been largely static/dormant for years" is
**partly right and partly wrong, and the distinction matters.** The *project* is not
abandoned: the `surge` npm package was still being **actively republished in 2026**
(versions `0.27.0`–`0.27.4` between **2026-02-21** and **2026-05-13**), and the
GitHub repo's `pushed_at` is **2026-05-13**. The npm package metadata describes the
service as having handled **14 million deployments across 10 global regions**, and
the copyright notice reads **"© 2012-2026 Chloi Inc."**
- npm registry (latest `0.27.4` published `2026-05-13`; versions in Feb–May 2026):
  <https://registry.npmjs.org/surge>
- GitHub API (`pushed_at` `2026-05-13`): <https://api.github.com/repos/sintaxi/surge>
- GitHub repo description ("CLI for the surge.sh CDN"): <https://github.com/sintaxi/surge>
  - **What *is* true:** the *public profile* of Surge has been quiet for years — it
    has **no recent blog posts, no funding, no marketing cadence**, and the founder's
    public attention has clearly moved on (his site now foregrounds AI/quant work and
    other roles; see "Key people" below). So "dormant as a *product story*, but still
    maintained as *software*" is the accurate framing.
  - **Could not verify** the exact current operational scale, uptime, or whether the
    CDN is actively expanded; the "14 million deployments / 10 regions" and
    "~196 TB across 12 datacenters" figures are **self-reported** (npm description
    and the founder's own résumé/site) and are **not independently confirmed**. The
    figures even disagree with each other (10 vs. 12 regions/datacenters), so treat
    all scale numbers as **founder-reported, point-in-time, unverified**.

---

## Key people & teams

- **Brock Whitten** (a.k.a. **sintaxi**) — **founder and principal engineer** of
  Surge, and the npm package author (`brock@chloi.io`). Previously **co-created Harp**
  (the static web server that preceded Surge) and **co-created PhoneGap / Apache
  Cordova** (with Rob Ellis, at Nitobi). A **Mozilla WebFWD** alumnus; his bio also
  lists engineering roles at **Joyent** and elsewhere. His public focus has since
  shifted toward AI/quantitative-finance engineering, with Surge presented as a past
  creation that "continues to serve production traffic."
  - Founder's site (Surge, Harp, PhoneGap/Cordova, WebFWD, roles):
    <https://sintaxi.com/>
  - GitHub profile (`sintaxi`; Harp and Surge as top repos; org **Chloi Inc.**):
    <https://github.com/sintaxi>
  - npm author field (Brock Whitten / brock@chloi.io): <https://registry.npmjs.org/surge>

- **Chloi Inc.** — Whitten's company, the entity behind Surge. It appears in the
  npm author email (`@chloi.io`), the "Introducing Surge" credit to "the team at
  chloi.io," and the **"© 2012-2026 Chloi Inc."** copyright on Surge properties.
  - "Introducing Surge" (credits chloi.io):
    <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
  - npm registry (author email domain `chloi.io`): <https://registry.npmjs.org/surge>
  - **Could not verify** Chloi Inc.'s incorporation date, jurisdiction, headcount, or
    any funding against a primary registry/filing; no such record was located, and
    none is implied by the sources — Surge reads as a **founder/small-team indie
    project under Chloi**, not a funded startup.

- **Rob Ellis** (`@rob_ellis`) and **Kenneth Ormandy** (`@kennethormandy`) — thanked
  in the "Introducing Surge" post; Ellis was also a **co-creator of Harp** (and of
  PhoneGap). Their precise roles on Surge itself are not detailed in the sources.
  - "Introducing Surge" (thanks @sintaxi, @rob_ellis, @kennethormandy):
    <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
  - Mozilla Hacks (Harp creators Rob Ellis, Brock Whitten, Jorge Pedret):
    <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/>

---

## Company & corporate history

- **Lineage:** **Harp** static web server / **Harp Platform** (Mozilla WebFWD,
  introduced Oct 2012) → **Surge** CLI + CDN, by the same founder (Brock Whitten)
  and company (**Chloi Inc.**).
  Sources: <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/> ;
  <https://sintaxi.com/>
- **Product arc:** `npm install -g surge` → run `surge` in a folder → free static
  publishing on a `*.surge.sh` subdomain or custom domain, with optional paid
  production features. First npm publish **2014-07-18**; CLI repo **2014-07-26**;
  earliest archived website **Jan 2015**; public "Introducing Surge" post
  **Mar 3, 2015**.
  Sources: <https://registry.npmjs.org/surge> ;
  <https://api.github.com/repos/sintaxi/surge> ;
  <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- **Funding:** **none located.** No seed/venture rounds, acquisitions, or
  press-release corporate events were found — consistent with an independent,
  founder-run product under Chloi Inc.
- **Status (verified, point-in-time):** the `surge` CLI is **still maintained** on
  npm/GitHub (releases into **2026**), while Surge's **public/marketing presence has
  been dormant for years**. Sources: <https://registry.npmjs.org/surge> ;
  <https://github.com/sintaxi/surge>

### Place in history (precursor to Netlify / Vercel / GitHub Pages)

Surge is widely (and fairly) described as one of the **earliest CLI-first static-site
publishing tools** — shipping its `surge` command in **mid-2014**, before
**Netlify's** April-2015 public launch and well before **Vercel** (then ZEIT) made
`now`/CLI deploys famous. Its core idea — *type one command in a folder of static
files and it's live on a CDN, for free* — prefigured the developer-experience bar
those later, venture-funded platforms were built around. GitHub Pages predates Surge
(GitHub Pages launched in 2008), but Surge's contribution was the **zero-config,
npm-installed, single-command CLI** publishing workflow specifically.
- Cross-reference for the Netlify launch date and Jamstack framing:
  [`netlify.md`](./netlify.md) (Netlify publicly launched **April 7, 2015**).
- Surge's own "first" framing and CLI workflow: <https://surge.sh/> ;
  <https://github.com/sintaxi/surge>
  - **Note:** the "earliest" / "precursor" characterization is **historical
    interpretation** supported by the relative dates above (Surge CLI mid-2014 vs.
    Netlify Apr 2015), not a single company-stated claim. It is presented as such.

---

## Controversies & tensions

> Surge is a small indie product and has **not** been the subject of any marquee
> public controversy (no data-breach, no viral billing scandal, no acquisition
> drama) located in this pass. The only genuine, sourced *tensions* are minor and
> are recorded as such rather than inflated.

### 1. Free-tier vs. paid pricing grumbling (2016)

On the 2016 Hacker News thread, several developers argued Surge's paid tier was
**overpriced relative to rolling your own S3/CloudFront** or using GitHub Pages —
the standard tension for a free-hosting product trying to monetize. Whitten engaged
directly. This is ordinary pricing debate, not a scandal.
- Hacker News (Jun 10, 2016): <https://news.ycombinator.com/item?id=11878339>

### 2. Abuse / phishing-host reputation (inherent to free static hosting)

Free, instant, custom-domain static hosting is attractive to abuse, and Surge has a
documented reputation in security circles as a convenient host for **XSS payloads /
phishing pages** — a structural risk of the free model rather than a company action.
The founder's own résumé/site notes building **"fraud detection and content abuse
prevention systems"** for Surge, which is consistent with this being a known
operational concern.
- Hakluke, "How to use Surge.sh: The perfect host for XSS payloads":
  <https://hakluke.com/how-to-use-surge-the-perfect-host-for-xss-payloads/>
- Founder's site (mentions abuse-prevention systems built for Surge):
  <https://sintaxi.com/>
  - **Could not verify** any specific incident, takedown volume, or company
    statement about abuse; this is a **structural/characterization** point, sourced
    to a security write-up and the founder's own description of what he built.

---

## A note on dating (2013 vs. 2014 vs. 2015)

The brief asks for "circa 2013–2014." The **hard primary anchors** are:
- **mid-2014** for the *tooling* (npm `surge` first published **2014-07-18**; CLI
  repo created **2014-07-26**) — <https://registry.npmjs.org/surge> ;
  <https://api.github.com/repos/sintaxi/surge>
- **early 2015** for the *public website and launch post* (first Wayback capture
  **2015-01-21**; "Introducing Surge" **2015-03-03**) —
  <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- **2012** for the *precursor* Harp (Mozilla WebFWD) —
  <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/>

So "2013–2014" is a reasonable **origin window** when you count the Harp lineage and
early development, but the **first publicly shippable Surge artifact is 2014-07** and
the **public launch is 2015-03**. **Could not verify** any specifically **2013**
Surge.sh artifact (no 2013 npm publish, repo, or website capture was found); a clean,
defensible statement is *"Surge's CLI first shipped in July 2014 and launched
publicly in March 2015, growing out of the 2012-era Harp project."*

---

## Items marked "Could not verify"

- **A specific 2013 Surge.sh launch.** No 2013 artifact (npm/repo/website) was found;
  the earliest hard anchors are the **2014-07** npm publish/repo and the **2015-03**
  launch post. Sources: <https://registry.npmjs.org/surge> ;
  <https://api.github.com/repos/sintaxi/surge> ;
  <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- **A formal "Harp Platform shut down and became Surge" migration.** The
  Harp → Surge evolution is **described by the founder** and secondary summaries, not
  pinned to a dated primary announcement; the original Harp blog domain now resolves
  to a parked/hijacked site and was unusable. Sources: <https://sintaxi.com/> ;
  <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/>
- **Chloi Inc. corporate details.** No incorporation date, jurisdiction, headcount,
  or funding located; Surge reads as an **indie/founder project**, with "Chloi Inc."
  known only from the npm author email and the "© 2012-2026 Chloi Inc." notice.
  Sources: <https://registry.npmjs.org/surge> ; <https://surge.sh/pricing>
- **Operational scale numbers** ("14 million deployments / 10 regions" on npm;
  "~196 TB across 12 datacenters" on the founder's site) — **self-reported**,
  **internally inconsistent** (10 vs. 12 regions/datacenters), and **not
  independently verified**. Sources: <https://registry.npmjs.org/surge> ;
  <https://sintaxi.com/>
- **Exact pricing over time.** The free-vs-paid split and dollar figures have changed
  (HN 2016 references **$13/mo**; the current page shows **$30/mo**); treat each as
  **point-in-time**. Sources: <https://news.ycombinator.com/item?id=11878339> ;
  <https://surge.sh/pricing>
- **Precise roles of Rob Ellis / Kenneth Ormandy on Surge** (vs. Harp) — only that
  they were thanked in the launch post (and Ellis co-built Harp). Source:
  <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- **Any specific abuse/takedown incident.** The phishing/XSS-host reputation is a
  structural characterization, not a sourced incident or company statement. Source:
  <https://hakluke.com/how-to-use-surge-the-perfect-host-for-xss-payloads/>

---

## Sources (primary & reputable, deduplicated)

- Brock Whitten, "Introducing Surge — the CDN for Front-End Developers" (Mar 3, 2015): <https://medium.com/surge-sh/introducing-surge-the-cdn-for-front-end-developers-b4a50a61bcfc>
- npm registry metadata for `surge` (first publish 2014-07-18; author; license; latest 2026): <https://registry.npmjs.org/surge>
- npm package page, `surge`: <https://www.npmjs.com/package/surge>
- GitHub API, `sintaxi/surge` (repo created 2014-07-26; stars; pushed_at 2026): <https://api.github.com/repos/sintaxi/surge>
- GitHub repo, `sintaxi/surge` ("CLI for the surge.sh CDN"): <https://github.com/sintaxi/surge>
- GitHub profile, `sintaxi` (Brock Whitten; Harp & Surge; Chloi Inc.): <https://github.com/sintaxi>
- Brock Whitten's site (founder bio; Surge/Harp/PhoneGap; WebFWD; roles): <https://sintaxi.com/>
- Surge homepage: <https://surge.sh/>
- Surge pricing page: <https://surge.sh/pricing>
- Mozilla Hacks, "Much simpler web deployment ahead: Harp.io" (Oct 3, 2012; Harp creators): <https://hacks.mozilla.org/2012/10/much-simpler-web-deployment-ahead-harp-io/>
- Hacker News, "Surge – Static Web Publishing for Front-End Developers" (Jun 10, 2016): <https://news.ycombinator.com/item?id=11878339>
- Raymond Camden, "Hosting static sites with Surge" (Mar 4, 2015): <https://www.raymondcamden.com/2015/03/04/hosting-static-sites-with-surge>
- Internet Archive availability API (earliest surge.sh snapshot 2015-01-21): <http://archive.org/wayback/available?url=surge.sh&timestamp=20140101>
- Hakluke, "How to use Surge.sh: The perfect host for XSS payloads": <https://hakluke.com/how-to-use-surge-the-perfect-host-for-xss-payloads/>
