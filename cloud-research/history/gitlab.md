# GitLab — A Sourced History (Company & Platform)

> Scope: GitLab the open-source project and GitLab Inc. the company. Every
> non-trivial claim below carries an inline source URL. Where a specific detail
> could not be confirmed against a primary or reputable source, it is flagged
> with **Could not verify:**. Controversies are attributed to the outlet that
> reported them. Last verified: 2026-05-31.

---

## Timeline

### 2011 — The open-source project begins
- **October 2011** — Ukrainian developer **Dmitriy Zaporozhets** started GitLab
  as a hobby/side project (Ruby on Rails), together with **Valery Sizov**. In his
  own farewell post Zaporozhets writes: "I started the project in October of
  2011" and that he "started the project with Valery Sizov."
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
  Source (founding summary): <https://en.wikipedia.org/wiki/GitLab_Inc.>

### 2012–2013 — Sid Sijbrandije joins; GitLab.com
- **2012** — Dutch entrepreneur **Sytse "Sid" Sijbrandije** launched **GitLab.com**
  (the SaaS offering) and emailed Zaporozhets that he had started it. Zaporozhets:
  "In 2012, he received an email from Sid stating he had started GitLab.com,
  adding 'I hope you don't mind.'"
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
- **2013** — Zaporozhets joined full-time; his first official title later became
  Chief Technology Officer.
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
- A Dutch entity, **GitLab B.V.**, was incorporated in the Netherlands (2013) by
  Zaporozhets and Sijbrandije.
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>
  **Could not verify:** exact 2013 date of the GitLab B.V. incorporation from a
  primary registry filing (relying on Wikipedia summary).

### 2014 — GitLab Inc.
- **2014** — **GitLab Inc.** established (incorporated in Delaware) to build a
  business around the project, co-founded by Sijbrandije with Zaporozhets.
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>
  **Could not verify:** the precise "September 10, 2014" Delaware incorporation
  date — surfaced in search summaries but not confirmed against the actual
  Delaware filing; treat the year (2014) as solid, the exact day as unconfirmed.

### 2015 — Y Combinator
- **Winter 2015 (W15) batch** — GitLab participated in Y Combinator. GitLab
  published its own YC application.
  Source (GitLab's own W2015 application post): <https://about.gitlab.com/blog/gitlabs-application-for-y-combinator-winter-2015/>
  Source (YC company page): <https://www.ycombinator.com/companies/gitlab>
- **September 2015** — $4M Series A (Khosla Ventures).
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>

### All-remote + the public Handbook (ongoing identity)
- GitLab grew into one of the largest **all-remote** companies in the world and
  maintains a **public, web-readable Handbook** as its "single source of truth"
  (internal rule: "If it's not in the handbook, it doesn't exist").
  Source (Handbook): <https://handbook.gitlab.com/>
  Source (TeamOps / shared reality): <https://handbook.gitlab.com/teamops/shared-reality/>
  Source (all-remote reporting): <https://techcrunch.com/2020/03/24/gitlab-offers-key-lessons-in-running-an-all-remote-workforce-in-new-e-book/>

### Open-core model
- GitLab ships under an **open-core** model: the **Community Edition (CE)** under
  the **MIT License**, and the **Enterprise Edition (EE)** as proprietary
  (paid-tier features layered on top).
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>
  See also the 2019 telemetry episode below, where the open-core/free-software
  community pushed back hard on proposed changes.

### **January 31, 2017 — The production database deletion incident**
This is GitLab's most famous operational event.
- **What happened:** During work to fix replication, a GitLab engineer ran `rm`
  on the **production** PostgreSQL data directory (`/var/opt/gitlab/postgresql/data`
  on `db1.cluster.gitlab.com`) — believing they were on the secondary/staging
  host — removing roughly **295.5 GB of ~300 GB** before stopping.
  Source (GitLab live incident post, Feb 1 2017): <https://about.gitlab.com/2017/02/01/gitlab-dot-com-database-incident/>
- **The famous quote — all backups failed:** GitLab's own incident write-up
  states verbatim: *"So in other words, out of five backup/replication
  techniques deployed none are working reliably or set up in the first place."*
  Source: <https://about.gitlab.com/2017/02/01/gitlab-dot-com-database-incident/>
  - The five techniques (per the post-mortem): pg_dump SQL backups to S3 (failing
    silently due to a PostgreSQL **9.2 vs 9.6 version mismatch**; the S3 bucket
    was empty); LVM snapshots; Azure disk snapshots (not enabled for the DB
    servers); PostgreSQL replication (broken); and regular periodic backups.
  Source (official post-mortem): <https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/>
- **Data loss:** Approximately **6 hours** of database data was permanently lost —
  data created roughly between 17:20 and 00:00 UTC — affecting on the order of
  **5,000 projects, 5,000 comments, and 700 new user accounts**. Git repositories
  and wikis were **not** affected.
  Source (post-mortem): <https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/>
- **Live-streamed recovery on YouTube:** GitLab broadcast the recovery live, with
  a **peak of ~5,000 concurrent viewers**, and published a transparent
  post-mortem — celebrated as a landmark in radical operational transparency.
  Source (post-mortem, confirms YouTube live-stream + ~5,000 peak): <https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/>
  Source (contemporaneous press): <https://www.theregister.com/2017/02/01/gitlab_data_loss/>
  Source (TechCrunch): <https://techcrunch.com/2017/02/01/gitlab-suffers-major-backup-failure-after-data-deletion-incident/>
  - Note: the live blog page itself does not mention the YouTube stream; the
    YouTube live-stream and ~5,000-viewer peak are confirmed in the official
    post-mortem blog post.

### 2017–2018 — Migration from Microsoft Azure to Google Cloud
- GitLab moved its infrastructure **from Azure to Google Cloud Platform (GCP)**,
  primarily to run on Kubernetes (GKE) and to replace single-point-of-failure NFS
  storage with Google Cloud Storage (~200 TB of file data migrated). The official
  announcement was published **June 25, 2018**, with the production failover
  scheduled for late July 2018.
  Source (GitLab announcement): <https://about.gitlab.com/blog/2018/06/25/moving-to-gcp/>
  Source (press): <https://www.theregister.com/2018/06/26/gitlab_moving_platform_to_google_cloud/>

### 2019 — Late-stage funding
- **2019** — ~$268M Series E reportedly at a **$2.7B** valuation.
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>

### **October 14, 2021 — IPO (Nasdaq: GTLB)**
- GitLab priced its IPO at **$77/share** (above the indicated $66–$69 range),
  valuing the company at **about $11 billion** at pricing. It began trading on
  **Nasdaq under ticker GTLB on October 14, 2021**, and **closed up ~35% at
  $103.89**, giving a first-day market cap of about **$14.9 billion**; the company
  raised on the order of **$650M+**.
  Source (CNBC): <https://www.cnbc.com/2021/10/14/gitlab-jumps-in-nasdaq-debut-after-pricing-ipo-above-expected-range.html>
  Source (Fortune — Sijbrandije became a billionaire, net worth cited ~$2.6B): <https://fortune.com/2021/10/14/gitlab-ipo-stock-price-ceo-billionaire/>
- Zaporozhets and Sijbrandije rang the Nasdaq opening bell.
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>

### November 2021 — Co-founder departs
- **November 10, 2021** — Zaporozhets announced he was stepping away from his role
  as Engineering Fellow after ~10 years, saying he had "fulfilled my 10 year
  vision."
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>

### **December 5, 2024 — CEO transition**
- **Bill Staples** named **CEO** and board director, **effective December 5, 2024**.
  Co-founder **Sid Sijbrandije** transitioned to **Executive Chair of the Board**,
  citing the return of his cancer and a desire to focus on treatment ("I want more
  time to focus on my cancer treatment and health. My treatments are going well,
  my cancer is not metastatic.").
  Source (GitLab announcement): <https://about.gitlab.com/blog/gitlab-names-bill-staples-as-new-ceo/>
  Source (press): <https://siliconangle.com/2024/12/05/gitlab-co-founder-ceo-sid-sijbrandij-steps-bill-staples-named-replacement/>
- Staples previously was **CEO of New Relic**, with prior executive roles at Adobe
  and Microsoft.
  Source: <https://about.gitlab.com/blog/gitlab-names-bill-staples-as-new-ceo/>
  - Note: the transition was first surfaced around the company's Dec 2024 earnings
    timing; treat December 5, 2024 as the effective/announced date.

### Current status (as of this writing)
- GitLab positions itself as an **AI-powered DevSecOps platform** delivered as a
  single application, and ships **GitLab Duo** (its AI suite).
  Source (YC company description, "complete DevOps platform delivered as a single
  application"): <https://www.ycombinator.com/companies/gitlab>
  **Could not verify:** a single authoritative, current "scale" statistic
  (employees / revenue / customer count) from a primary source as of 2026 — the
  Wikipedia figure of ~1,300 employees across 65 countries is dated to 2020.
  Source (2020 figure): <https://en.wikipedia.org/wiki/GitLab_Inc.>

---

## Key people & teams

- **Dmitriy Zaporozhets** — Ukrainian developer; **started the GitLab project in
  October 2011** (with Valery Sizov); co-founder of GitLab Inc.; early CTO, later
  Engineering Fellow; left November 2021.
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
- **Valery Sizov** — co-created the original 2011 project with Zaporozhets.
  Source: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
- **Sytse "Sid" Sijbrandije** — Dutch co-founder & long-time CEO; launched
  GitLab.com (2012); CEO through to Dec 2024; then Executive Chair.
  Sources: <https://en.wikipedia.org/wiki/GitLab_Inc.>,
  <https://about.gitlab.com/blog/gitlab-names-bill-staples-as-new-ceo/>
- **Bill Staples** — CEO from December 5, 2024 (ex-CEO of New Relic; prior roles at
  Adobe, Microsoft).
  Source: <https://about.gitlab.com/blog/gitlab-names-bill-staples-as-new-ceo/>

---

## Company & corporate history

- **Open-source roots (2011)** → **GitLab.com SaaS (2012)** → **GitLab B.V.
  (Netherlands, 2013)** → **GitLab Inc. (Delaware, 2014)** → **Y Combinator W2015**.
  Sources: <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>,
  <https://about.gitlab.com/blog/gitlabs-application-for-y-combinator-winter-2015/>,
  <https://en.wikipedia.org/wiki/GitLab_Inc.>
- **Funding trajectory (per Wikipedia summary):** ~$4M Series A (Sep 2015,
  Khosla) → Series B/C (2016) → ~$100M Series D (2018) → ~$268M Series E at $2.7B
  (2019) → **IPO Oct 2021**.
  Source: <https://en.wikipedia.org/wiki/GitLab_Inc.>
  **Could not verify:** individual round amounts/dates against primary press
  releases (relying on the Wikipedia consolidated table).
- **Culture:** all-remote operating model and the **public GitLab Handbook**
  (radical transparency / single source of truth).
  Source: <https://handbook.gitlab.com/>

---

## Controversies (each attributed to its source)

### 1) 2019 — Telemetry / user-tracking plan (reversed after backlash)
- **What was proposed:** In October 2019 GitLab announced plans to add usage
  telemetry, including JavaScript snippets integrating a **third-party analytics
  service (Pendo)** across GitLab.com and self-managed packages, alongside Terms of
  Service changes.
- **Reversal:** After staff and community backlash, GitLab **rolled it back** and
  committed to "**not implementing telemetry in our products that sends usage data
  to a third-party product analytics service**" and to not activating user-level
  tracking before addressing feedback.
  Source (GitLab's own update post): <https://about.gitlab.com/blog/2019/10/10/update-free-software-and-telemetry/>
  Attributed press: *The Register* — "GitLab pulls U-turn on plan to crank up usage
  telemetry after both staff and customers cry foul":
  <https://www.theregister.com/2019/10/30/gitlab_backtracks_on_plan_to_add_usage_telemetry_after_user_protests/>
  Attributed press: *BleepingComputer* — "GitLab Backtracks on Forced Tracking
  After Negative Feedback":
  <https://www.bleepingcomputer.com/news/security/gitlab-backtracks-on-forced-tracking-after-negative-feedback/>
  - Dating nuance: GitLab's blog post is dated/anchored 2019-10-10 and carries an
    "Updated October 29th, 2019" note; press coverage of the announcement and the
    reversal clusters around Oct 23–30, 2019. The exact announce-vs-rollback day is
    reported slightly differently across outlets, so treat "late October 2019,
    reversed within days" as the safe framing.

### 2) 2019–2020 — Proposed China/Russia hiring restriction for support roles
- **What was proposed:** GitLab floated **not hiring** Site Reliability Engineers
  and Support Engineers **residing in China and Russia** for roles with access to
  customer data, citing concerns raised by enterprise customers and geopolitical
  considerations. VP of Engineering **Eric Johnson** cited "concern of several
  enterprise customers." GitLab said it had "zero current employees" affected and
  that the policy was under discussion, not yet implemented.
  Attributed press: *South China Morning Post*:
  <https://www.scmp.com/tech/start-ups/article/3036259/open-software-development-platform-gitlab-looks-suspending-new-hires>
  Attributed discussion (contemporaneous): Hacker News thread:
  <https://news.ycombinator.com/item?id=21437334>
  Attributed press (criticism / "hypocrisy" framing): *Global Times*:
  <https://www.globaltimes.cn/content/1168949.shtml>
  - Date: reported November 2019 (clarification statement ~Nov 5, 2019).
  **Could not verify:** the specific claim that GitLab's "Director of Global Risk
  and Compliance, Candice Ciresi, resigned in protest." It appears in a search
  summary but was **not** confirmed against a primary or reputable named source
  here — flagged as unverified.

### 3) 2022 — Plan to delete dormant free-tier projects (reversed after backlash)
- **What was proposed:** GitLab planned to **automatically delete free-tier
  projects inactive for more than ~1 year**, projected to save roughly **$1
  million/year**, slated to begin after **2022-09-22**.
- **Reversal:** After public backlash, GitLab **abandoned auto-deletion** and
  instead committed to **moving dormant projects to slower object storage** (kept
  visible/accessible). Sijbrandije: "Our current plan for object storage would keep
  the repos visible to everyone."
  Attributed press: *The Register* — original plan:
  <https://www.theregister.com/2022/08/04/gitlab_data_retention_policy/>
  Attributed press: *The Register* — reversal ("GitLab U-turns on deleting dormant
  projects after backlash"):
  <https://www.theregister.com/2022/08/05/gitlab_reverses_deletion_policy/>

---

## Source index (primary / official, most load-bearing)

- GitLab live incident blog (Feb 1, 2017) — the "five backup techniques" quote:
  <https://about.gitlab.com/2017/02/01/gitlab-dot-com-database-incident/>
- GitLab official post-mortem (Jan 31, 2017 outage):
  <https://about.gitlab.com/blog/postmortem-of-database-outage-of-january-31/>
- GitLab telemetry update/rollback post (2019):
  <https://about.gitlab.com/blog/2019/10/10/update-free-software-and-telemetry/>
- GitLab "Moving to GCP" announcement (2018):
  <https://about.gitlab.com/blog/2018/06/25/moving-to-gcp/>
- GitLab "Bill Staples as new CEO" (2024):
  <https://about.gitlab.com/blog/gitlab-names-bill-staples-as-new-ceo/>
- Zaporozhets farewell (founding details, 2021):
  <https://about.gitlab.com/blog/a-special-farewell-from-gitlab-dmitriy-zaporozhets/>
- GitLab YC W2015 application:
  <https://about.gitlab.com/blog/gitlabs-application-for-y-combinator-winter-2015/>
- The GitLab Handbook:
  <https://handbook.gitlab.com/>
- CNBC IPO coverage (Oct 14, 2021):
  <https://www.cnbc.com/2021/10/14/gitlab-jumps-in-nasdaq-debut-after-pricing-ipo-above-expected-range.html>
