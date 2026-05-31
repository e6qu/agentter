# Bitbucket (Atlassian) — A Sourced History

A chronological, cited history of Bitbucket, from its origins as a Mercurial-only
hosting startup through its acquisition by Atlassian and its controversial 2020
sunset of Mercurial support.

> Sourcing note: Every dated claim below links to a primary or reputable secondary
> source. Where sources disagree on a date or detail, the discrepancy is called out
> inline. Items that could not be independently confirmed are listed under
> **Could not verify** at the end.

---

## Timeline

### 2002 — Atlassian founded (corporate backdrop)
Atlassian was founded in Sydney, Australia, in **2002** by **Mike Cannon-Brookes**
and **Scott Farquhar**, who bootstrapped the company partly on credit-card debt.
(Cannon-Brookes first emailed UNSW classmates in 2001 looking for a co-founder;
Farquhar was the one who replied.)
- Source: [Atlassian — Wikipedia](https://en.wikipedia.org/wiki/Atlassian)
- Source: [NPR, "Atlassian: Mike Cannon-Brookes and Scott Farquhar" (How I Built This)](https://www.npr.org/2021/02/04/964091025/atlassian-mike-cannon-brookes-and-scott-farquhar)

### 2008 — Bitbucket founded as Mercurial-only hosting
Bitbucket launched in **2008** as an independent startup founded by **Jesper Nøhr**
(also rendered "Jesper Noehr"). It launched supporting **exclusively Mercurial**
repositories — effectively the Mercurial counterpart to GitHub (often described as
"GitHub for Mercurial users"). This Mercurial-first origin is the defining detail of
Bitbucket's early identity.
- Source: [Bitbucket — Wikipedia](https://en.wikipedia.org/wiki/Bitbucket)
- Source: [The Register, "There once was a biz called Bitbucket…" (Aug 21, 2019)](https://www.theregister.com/2019/08/21/bitbucket_mercurial_repositories/) — "Bitbucket launched in 2008 supporting exclusively Mercurial repositories."

> Note on a Wikipedia discrepancy: one passage of the Bitbucket Wikipedia article
> describes Bitbucket as having "initially supported Mercurial repositories alongside
> Git." This conflicts with The Register's reporting and with Bitbucket's own 2011
> "Announcing Git support" blog post (below), both of which indicate Mercurial was the
> original and sole VCS at launch, with Git added later. The Mercurial-only origin is
> the better-supported account.

### August 2010 — Accel investment (context for the acquisition)
A month before acquiring Bitbucket, Atlassian announced a **$60M** investment from
Accel Partners, earmarked in part for R&D and M&A. The Bitbucket deal was reported as
Atlassian's first acquisition following that round.
- Source: [TechCrunch, "Atlassian Buys Mercurial Project Hosting Site BitBucket" (Sep 29, 2010)](https://techcrunch.com/2010/09/29/atlassian-buys-mercurial-project-hosting-site-bitbucket/)

### September 29, 2010 — Acquired by Atlassian
On **September 29, 2010**, Atlassian announced it had acquired **Bitbucket.org**. At
the time Bitbucket had **over 60,000 accounts** and was the leading hosted code
collaboration provider for the Mercurial DVCS. **Terms were not disclosed.** Founder
**Jesper Nøhr** (CEO/co-founder) and the Bitbucket team joined Atlassian. Atlassian
quickly moved Bitbucket to user-based pricing with unlimited public and private
repositories.
- Source (primary): [Atlassian blog, "Atlassian Acquires Bitbucket.org" (Sep 29, 2010)](https://www.atlassian.com/blog/archives/atlassian_acquires_bitbucket_org_distributed_version_control_system_hosting$) — Nøhr quote; Mike Cannon-Brookes quote ("Bitbucket has a very similar philosophy…").
- Source: [TechCrunch (Sep 29, 2010)](https://techcrunch.com/2010/09/29/atlassian-buys-mercurial-project-hosting-site-bitbucket/) — "over 60,000 accounts"; terms not disclosed.

### May 2012 — Stash launched (self-managed Git, behind the firewall)
Atlassian released **Stash** in **May 2012**: an enterprise-grade, self-managed Git
repository hosting and collaboration tool, built specifically for on-premises
deployment behind a company firewall. Stash is the ancestor of today's Bitbucket
Server / Data Center product line.
- Source: [Atlassian, "Bitbucket rebrand FAQ"](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) — "first released in May 2012."

### October 3, 2011 — Git support added (the key differentiator era begins)
On **October 3, 2011** — the one-year anniversary of the Atlassian acquisition —
Bitbucket announced **Git support**, so users could host both Mercurial (Hg) and Git
repos in one place, plus importers for Git, Mercurial, Subversion, and GitHub.
- Source (primary): [Bitbucket blog, "Announcing Git support"](https://bitbucket.org/blog/announcing-git-support)
- Source: [InfoQ, "BitBucket Offers Git Support" (Oct 2011)](https://www.infoq.com/news/2011/10/bitbucket-git/)

> Note: The Register's 2019 retrospective dates Git support to "2012," while
> Bitbucket's own announcement post and contemporaneous InfoQ coverage date it to
> **October 3, 2011**. The 2011 date is the better-sourced one (it comes from the
> primary announcement).

**Differentiator — free private repositories:** For years a notable competitive
distinction was that Bitbucket offered **free private repositories** (with limits on
collaborators), at a time when **GitHub charged for private repos**. Atlassian moved
Bitbucket to unlimited private/public repos under user-based pricing right after the
2010 acquisition.
- Source: [TechCrunch (Sep 29, 2010)](https://techcrunch.com/2010/09/29/atlassian-buys-mercurial-project-hosting-site-bitbucket/) — "unlimited private and public repositories."

### December 10, 2015 — Atlassian IPO (NASDAQ: TEAM)
Atlassian went public on the **NASDAQ** on **December 10, 2015** under the ticker
**TEAM**, at a market capitalization around **$4.37 billion**, making Cannon-Brookes
and Farquhar Australia's first tech-startup billionaires.
- Source: [Atlassian — Wikipedia](https://en.wikipedia.org/wiki/Atlassian)

### September 22, 2015 — Stash rebranded to Bitbucket Server
With the release of **Bitbucket Server 4.0** on **September 22, 2015**, Atlassian
unified its Git products under the Bitbucket brand: the cloud product became
**Bitbucket Cloud** and **Stash** became **Bitbucket Server** (with the high-scale,
self-managed variant as **Bitbucket Data Center**).
- Source (primary): [Atlassian, "Bitbucket rebrand FAQ"](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) — "Starting September 22nd, 2015… Bitbucket Server 4.0."

### May/June 2016 — Bitbucket Pipelines (CI/CD) introduced
Atlassian unveiled **Bitbucket Pipelines** in beta at **AtlasCamp 2016** (Barcelona),
a built-in continuous-delivery / CI/CD feature for Bitbucket Cloud using a
config-as-code approach on ephemeral Docker containers — no separate build agents or
external CI tool required. This slotted Bitbucket into Atlassian's broader DevOps
story alongside **Jira** and **Bamboo** (Atlassian also announced end-of-life for
Bamboo Cloud as of Jan 31, 2017, steering cloud CI/CD toward Pipelines).
- Source: [InfoQ, "Bitbucket Pipelines Provides Continuous Delivery within Atlassian's Bitbucket Cloud" (Jun 2016)](https://www.infoq.com/news/2016/06/atlassian-bitbucket-pipelines/)
- Source: [Atlassian — Bitbucket Pipelines product page](https://www.atlassian.com/software/bitbucket/features/pipelines)

> Note: Sources place the Pipelines beta announcement in mid-2016 (AtlasCamp /
> June 2016 coverage). The exact general-availability ("GA") date was not pinned down
> from these sources — see **Could not verify**.

### July 2016 — Git LFS support
Bitbucket added support for **Git Large File Storage (LFS)** in **July 2016**.
- Source: [Bitbucket — Wikipedia](https://en.wikipedia.org/wiki/Bitbucket)

---

## The 2020 Mercurial sunset (the controversial chapter)

This is the episode for which Bitbucket is most remembered in the Mercurial community:
the company that began life as the premier Mercurial host chose to remove Mercurial
entirely.

### August 20, 2019 — Announcement that Mercurial support would be dropped
On **Tuesday, August 20, 2019**, Bitbucket announced it would **sunset Mercurial
support** on Bitbucket Cloud. Senior product marketing manager **Denise Chan**
authored the announcement ("Sunsetting Mercurial support in Bitbucket"). The original
deadlines given were:
- **February 1, 2020** — users could no longer **create new** Mercurial repositories.
- **June 1, 2020** — Mercurial features and repositories would be **removed** entirely.
- Source (primary): [Atlassian/Bitbucket blog, "Sunsetting Mercurial support in Bitbucket"](https://www.atlassian.com/blog/bitbucket/sunsetting-mercurial-support-in-bitbucket)
- Source: [The Register (Aug 21, 2019), Thomas Claburn](https://www.theregister.com/2019/08/21/bitbucket_mercurial_repositories/) — announcement dated Aug 20, 2019; Feb 1, 2020 and June 1, 2020 deadlines.

**Atlassian's stated rationale** (attributed to Atlassian/Denise Chan):
- Git had become the dominant choice; per StackOverflow's 2018 survey, ~87% of
  developers used Git vs ~4% Mercurial.
- Mercurial usage on Bitbucket was steadily declining — **fewer than 1%** of new
  Bitbucket users chose Mercurial.
- "Supporting two version control systems means splitting focus — doubling shipping
  time and technical overhead."
- Source: [Atlassian/Bitbucket blog (Denise Chan)](https://www.atlassian.com/blog/bitbucket/sunsetting-mercurial-support-in-bitbucket)
- Source: [The Register (Aug 21, 2019)](https://www.theregister.com/2019/08/21/bitbucket_mercurial_repositories/)

### The deadline shift — removal landed July 1, 2020
The originally announced **June 1, 2020** removal date was **extended by 30 days** to
**July 1, 2020**. Per the updated Atlassian blog (updated April 21, 2020):
- **February 1, 2020** — new Mercurial repo creation disabled.
- **July 1, 2020** — all Mercurial repositories, wikis, and snippets became
  **read-only**.
- **August 26, 2020** — all Mercurial repositories disabled and made inaccessible.
- Source (primary): [Atlassian/Bitbucket blog, "Sunsetting Mercurial support in Bitbucket" (updated Apr 21, 2020)](https://www.atlassian.com/blog/bitbucket/sunsetting-mercurial-support-in-bitbucket)

> Date reconciliation: The widely cited "Mercurial removed on **July 1, 2020**" refers
> to the date repos went **read-only** (effectively the end of usable Mercurial
> hosting). The Atlassian blog's later-dated **August 26, 2020** is when repos were
> fully disabled/deleted and became inaccessible. Both dates are correct for different
> milestones; the original announcement's **June 1, 2020** target was pushed back 30
> days. Earlier secondary coverage (e.g., Packt) referenced a "May 2020" framing, which
> the final timeline superseded.
> - Secondary (pre-final): [Packt, "Bitbucket to no longer support Mercurial… by May 2020"](https://www.packtpub.com/en-us/learning/how-to-tutorials/bitbucket-to-no-longer-support-mercurial-users-must-migrate-to-git-by-may-2020)

### Why it mattered & community backlash
Bitbucket was, by 2019, **arguably the leading commercial Mercurial hosting platform**
and one of the last large hosts for the ecosystem — so its exit was a significant blow
to Mercurial users, many of whom faced a forced migration to Git. Reaction (attributed
to the named sources):
- The Register framed it bluntly in its headline: *"There once was a biz called
  Bitbucket, that told Mercurial to suck it. Now devs are dejected, their code soon
  ejected."* It quoted developer **Andi McClure**, who lamented the migration burden
  and called Git "the worst piece of software ever created."
  - Source: [The Register (Aug 21, 2019)](https://www.theregister.com/2019/08/21/bitbucket_mercurial_repositories/)
- On Atlassian's own community forum, users reacted with shock and complaints about the
  short timeline and lack of an automatic migration path; one commenter quipped they
  "initially thought this was an April fool's joke, then realized it was August."
  - Source: [Atlassian Community, "What to do with your Mercurial repos when Bitbucket sunsets support"](https://community.atlassian.com/forums/Bitbucket-articles/What-to-do-with-your-Mercurial-repos-when-Bitbucket-sunsets/ba-p/1155380)
- The announcement drew heavy discussion on Hacker News and Lobsters.
  - Source: [Hacker News thread, "Sunsetting Mercurial support in Bitbucket"](https://news.ycombinator.com/item?id=20745393)
  - Source: [Lobsters thread](https://lobste.rs/s/xuppr2/sunsetting_mercurial_support_bitbucket)
- Long after the deletion, users still surfaced in the forums reporting lost
  Mercurial repos.
  - Source: [Atlassian Community, "Lost my old mercurial repos! Help!"](https://community.atlassian.com/forums/Bitbucket-questions/Lost-my-old-mercurial-repos-Help/qaq-p/2597862)

**Migration tooling** Atlassian pointed users to included the `hg-fast-export` and
`hg-git` plugins, plus links to alternative Mercurial hosts.
- Source: [Atlassian/Bitbucket blog](https://www.atlassian.com/blog/bitbucket/sunsetting-mercurial-support-in-bitbucket)

---

## Current status

Bitbucket remains an active part of Atlassian's developer/DevOps platform, offered as:
- **Bitbucket Cloud** — the fully managed, multi-tenant SaaS (historically built in
  Python/Django), with **Bitbucket Pipelines** for CI/CD and tight Jira integration.
- **Bitbucket Data Center** (formerly Bitbucket Server / Stash) — the self-managed,
  high-availability, high-scale Git product (built in Java).

Git-only since the 2020 Mercurial removal.
- Source: [Bitbucket — Wikipedia](https://en.wikipedia.org/wiki/Bitbucket)
- Source: [Atlassian, "Bitbucket rebrand FAQ"](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html)

> Note: As of the cutoff for these sources, Atlassian's Bitbucket Server product line
> is marketed under the **Bitbucket Data Center** name (current docs reference versions
> up to ~10.x). The original standalone "Bitbucket Server" branding has folded into
> Data Center.

---

## Key people & teams

- **Jesper Nøhr** ("Jesper Noehr") — Founder, CEO, and co-founder of Bitbucket (2008);
  joined Atlassian with the team upon the 2010 acquisition.
  - [Atlassian blog (Sep 29, 2010)](https://www.atlassian.com/blog/archives/atlassian_acquires_bitbucket_org_distributed_version_control_system_hosting$)
- **Mike Cannon-Brookes** — Atlassian co-founder & co-CEO; publicly framed the
  Bitbucket acquisition ("Bitbucket has a very similar philosophy…").
  - [Atlassian blog (Sep 29, 2010)](https://www.atlassian.com/blog/archives/atlassian_acquires_bitbucket_org_distributed_version_control_system_hosting$)
- **Scott Farquhar** — Atlassian co-founder & co-CEO (corporate backdrop).
  - [Atlassian — Wikipedia](https://en.wikipedia.org/wiki/Atlassian)
- **Jay Simons** — Atlassian president (era of the acquisition); quoted on Atlassian's
  developer-tools ambition.
  - [TechCrunch (Sep 29, 2010)](https://techcrunch.com/2010/09/29/atlassian-buys-mercurial-project-hosting-site-bitbucket/)
- **Denise Chan** — Senior product marketing manager at Atlassian; author of the
  "Sunsetting Mercurial support in Bitbucket" announcement.
  - [Atlassian/Bitbucket blog](https://www.atlassian.com/blog/bitbucket/sunsetting-mercurial-support-in-bitbucket)

---

## Company & corporate history

- **Atlassian** was founded in **2002** in Sydney by **Mike Cannon-Brookes** and
  **Scott Farquhar**, bootstrapped (famously on ~$10,000 of credit-card debt).
  - [Atlassian — Wikipedia](https://en.wikipedia.org/wiki/Atlassian) · [NPR/How I Built This](https://www.npr.org/2021/02/04/964091025/atlassian-mike-cannon-brookes-and-scott-farquhar)
- **August 2010** — raised **$60M** from Accel Partners, partly for M&A.
  - [TechCrunch (Sep 29, 2010)](https://techcrunch.com/2010/09/29/atlassian-buys-mercurial-project-hosting-site-bitbucket/)
- **September 29, 2010** — acquired Bitbucket (Atlassian's first acquisition after the
  Accel round; terms undisclosed).
  - [Atlassian blog](https://www.atlassian.com/blog/archives/atlassian_acquires_bitbucket_org_distributed_version_control_system_hosting$)
- **December 10, 2015** — IPO on **NASDAQ** (ticker **TEAM**), ~$4.37B market cap.
  - [Atlassian — Wikipedia](https://en.wikipedia.org/wiki/Atlassian)
- Bitbucket's role in the portfolio: the source-code-management and CI/CD pillar
  (Pipelines), integrated with Jira (issues/project tracking), Confluence (docs), and
  historically Bamboo (server CI), forming Atlassian's DevOps suite.
  - [Atlassian — Bitbucket Pipelines](https://www.atlassian.com/software/bitbucket/features/pipelines)

---

## Could not verify

- **Could not verify:** The exact **general-availability (GA) date** of Bitbucket
  Pipelines. Sources confirm a **beta** announcement at AtlasCamp / mid-2016 (June 2016
  coverage), but a precise GA date was not pinned down from the consulted sources.
- **Could not verify:** A precise founding **month/day** in 2008 for Bitbucket (sources
  give the year 2008, not an exact date).
- **Could not verify (conflicting sources):** Whether Git support arrived in **2011**
  vs **2012**. The primary Bitbucket announcement and InfoQ place it on **Oct 3, 2011**;
  The Register's 2019 retrospective says "2012." This doc treats **Oct 3, 2011** as
  correct (primary source), flagging the conflict.
- **Could not verify (conflicting sources):** Whether Bitbucket was Mercurial-**only**
  at launch (The Register; Git-support blog post imply yes) vs "Mercurial alongside
  Git" (one Wikipedia phrasing). This doc treats **Mercurial-only at launch** as
  correct, flagging the conflict.
- **Could not verify:** Precise **acquisition price** — officially undisclosed in all
  located sources.
