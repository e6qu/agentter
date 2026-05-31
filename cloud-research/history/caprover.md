# CapRover — A Sourced History

A chronological, sourced history of **CapRover**, the open-source, self-hosted
**platform-as-a-service (PaaS)** built on **Docker Swarm** and **Nginx** that pitches
itself as "Heroku on Steroids" — a one-server (or clustered) deployment tool with a
web GUI, a CLI, automatic HTTPS via Let's Encrypt, and a one-click app marketplace.
CapRover began life in 2017 under the name **CaptainDuckDuck**, created by **Kasra
Bigdeli**, and was renamed to CapRover with its v1.0.0 release in January 2019.

This is a smaller, single-maintainer-led open-source project, so primary sourcing is
proportionately thinner than for a venture-backed company. Every non-trivial claim
below carries a working source link, with primary sources (the GitHub repositories,
their releases/changelog, the creator's own freeCodeCamp/Medium article and podcast
interviews, and the project's Open Collective) preferred. Where a detail could not be
confirmed it is explicitly flagged **Could not verify:**. Opinions and
characterizations are attributed to their sources.

> **Note on the creator.** The research brief named **Kasra Bigdeli** and a founding
> year of ~2017. Both are confirmed: the GitHub account **`githubsaturn`** is Kasra
> Bigdeli (bio "Working on CapRover"), and the creator's own article dates the first
> release to **October 2017**.
> - Sources: [githubsaturn (Kasra Bigdeli) — GitHub profile](https://github.com/githubsaturn);
>   [How I built a replacement for Heroku and cut my platform costs by 4X — Kasra Bigdeli, freeCodeCamp](https://www.freecodecamp.org/news/how-i-cut-my-heroku-cost-by-400-5b9d0220ce13)

---

## Timeline

### 2017 — Origin as "CaptainDuckDuck"

- **Motivation: Heroku's cost for side projects.** In his own retrospective, Kasra
  Bigdeli writes that he was paying over **$100/month to Heroku** to host multiple
  small apps, and realized that a single **DigitalOcean** server (2 GB RAM for ~$20/mo)
  could host several of them. He looked at how Heroku worked under the hood, found
  Docker, and built an open-source equivalent: "The main engines that Captain uses
  under the hood are nginx and docker. Both are among the most trusted, production-ready
  tools."
  - Source: [How I built a replacement for Heroku and cut my platform costs by 4X — Kasra Bigdeli, freeCodeCamp](https://www.freecodecamp.org/news/how-i-cut-my-heroku-cost-by-400-5b9d0220ce13)
  - In a later podcast interview, Bigdeli recounts that he had a working version within
    roughly **2.5 months**, and that the first version "was very simple back then. It
    didn't have support for persistent data," gaining significant traction on Hacker
    News.
    - Source: [#16 CapRover Interview 1 — Craft of Open Source Podcast, Flagsmith](https://www.flagsmith.com/podcast/kasra-bigdeli-caprover)

- **First release: October 2017.** The creator's article states the tool was initially
  called **CaptainDuckDuck** and first released in **October 2017**. The earliest
  GitHub releases of the `githubsaturn/captainduckduck` repository carry late-2017 dates
  (e.g., **v0.1.2 on November 17** and **v0.2.1 on December 4**), and the project was
  featured in **RisingStack's "Node.js Weekly Update — December 15, 2017."**
  - Sources: [How I built a replacement for Heroku… — freeCodeCamp](https://www.freecodecamp.org/news/how-i-cut-my-heroku-cost-by-400-5b9d0220ce13);
    [githubsaturn/captainduckduck — Releases](https://github.com/githubsaturn/captainduckduck/releases);
    [Node.js Weekly Update — 15 December 2017, RisingStack](https://community.risingstack.com/node-js-weekly-update-december-15/)
  - **Could not verify:** the exact day in October 2017 of the very first release. The
    GitHub releases page does not display years inline for the oldest tags, and the
    earliest `v0.x` tag's precise date could not be re-read directly; the "October 2017"
    first-release date rests on the creator's own article rather than a dated release
    artifact.

- **The architecture that has stayed constant.** From the start, CaptainDuckDuck/
  CapRover combined **Docker** (later Docker Swarm) for containers and clustering,
  **Nginx** as a customizable reverse proxy / load balancer, and **Let's Encrypt** for
  free automatic HTTPS — all behind a web GUI and CLI so users need no Docker or Nginx
  expertise.
  - Sources: [caprover/caprover — GitHub README](https://github.com/caprover/caprover);
    [How I built a replacement for Heroku… — freeCodeCamp](https://www.freecodecamp.org/news/how-i-cut-my-heroku-cost-by-400-5b9d0220ce13)

### 2018 — Adoption under the CaptainDuckDuck name

- During 2018 the project circulated under the CaptainDuckDuck name and accumulated, per
  the creator, "millions of downloads from DockerHub" over roughly a year before the
  rebrand. Third-party tutorials from this period (e.g., Florimond Manca's two-part
  CaptainDuckDuck deployment guide) document its use as a cheap, self-hosted Heroku
  alternative.
  - Sources: [CapRover v1.0.0 — Open Collective update (Jan 20, 2019)](https://opencollective.com/caprover/updates/caprover-v-1-0-0);
    [Cheap and easy deployment: CaptainDuckDuck (Part 2) — Florimond Manca (Aug 2018)](https://florimond.dev/en/posts/2018/08/cheap-and-easy-deployment-captainduckduck-2)

- **Why the rename happened.** Community members argued the whimsical "CaptainDuckDuck"
  name was hard to pitch in professional settings — captured in a GitHub issue titled
  "Change the name to 'Captain' so that I can ask my boss if we can use it."
  - Source: ["Change the name to 'Captain' so that I can ask my boss if we can use it" — Issue #194, githubsaturn/captainduckduck](https://github.com/caprover/caprover/issues/194)

### January 2019 — Rename to CapRover (v1.0.0)

- **January 20, 2019** — The project released **v1.0.0** and was renamed from
  **CaptainDuckDuck** to **CapRover**. The Open Collective announcement states: "After
  one year of CaptainDuckDuck and millions of downloads from DockerHub, CaptainDuckDuck
  graduated and got renamed to CapRover." The GitHub v1.0.0 release notes lead with
  "Major Update. Renamed from CaptainDuckDuck to CapRover."
  - Sources: [CapRover v1.0.0 — Open Collective update (Jan 20, 2019)](https://opencollective.com/caprover/updates/caprover-v-1-0-0);
    [Release v1.0.0 — caprover/caprover](https://github.com/caprover/caprover/releases/tag/v1.0.0)
  - **What v1.0.0 added.** The release bumped the `captain-definition` schema to
    **version 2** (removing the previously required `./src` prefix for Dockerfile
    paths), and added **one-click deployment rollback**, improved in-dashboard **build
    logs**, support for external Dockerfiles and pre-built Docker Hub images, a
    refreshed environment-variable UI, and a **separate one-click apps repository**. The
    release also reflects substantial **backend, frontend, and CLI rewrites in
    TypeScript**.
    - Source: [Release v1.0.0 — caprover/caprover](https://github.com/caprover/caprover/releases/tag/v1.0.0)
  - **Migration path.** CapRover published a migration guide and script to upgrade
    existing CaptainDuckDuck servers to CapRover (backing up the config directory).
    - Source: [CaptainDuckDuck Upgrade — CapRover docs](https://caprover.com/docs/cdd-migration.html)

### One-click apps marketplace

- CapRover ships a **one-click apps** catalog — a community-maintained repository of
  app templates (WordPress, MySQL, MongoDB, Postgres, Redis, and many more) deployable
  from the dashboard. Apps are defined in **Docker Compose–style YAML** with
  CapRover-specific variables (e.g., `$$cap_appname`, `$$cap_root_domain`,
  `$$cap_gen_random_hex(length)`) that the dashboard substitutes at install time. Users
  can also point CapRover at their own third-party app repositories.
  - Source: [caprover/one-click-apps — GitHub](https://github.com/caprover/one-click-apps)
  - The one-click-apps repository is licensed **Apache-2.0** (distinct from the main
    CapRover repository's later license change, below).
    - Source: [caprover/one-click-apps — GitHub](https://github.com/caprover/one-click-apps)

### July 2023 — License change (Apache 2.0 → modified Apache)

- The **main `caprover/caprover` repository's license** is a **modified Apache 2.0
  license**, with a copyright line reading **"Copyright 2017-2024 BigZee Ventures
  LLC."** An appended set of terms adds commercial restrictions on top of the base
  Apache text, including: "Unless provided with a written agreement, the paid features
  of CapRover (as a service) cannot be modified"; "no persons are permitted to
  redistribute another paid version of CapRover"; and "any modifications of free
  features of CapRover should be distributed as free & opensource software." The license
  states these appended terms supersede the standard Apache provisions where they
  conflict.
  - Source: [caprover/caprover — LICENSE](https://github.com/caprover/caprover/blob/master/LICENSE)

- **Community criticism.** A March 28, 2024 GitHub issue (#2035, by user **@sneak**)
  argued that, as of **July 20, 2023**, CapRover had ceased to be open source — citing
  the modified Apache license and a new requirement to accept Terms and Conditions —
  while still describing itself as open source on its website and docs. The filer also
  alleged the relicensing occurred without consent from all contributors, given the
  absence of a Contributor License Agreement. The issue was **closed as "not planned."**
  - Source: ["CapRover is no longer open source but still lists open source…" — Issue #2035, caprover/caprover](https://github.com/caprover/caprover/issues/2035)
  - **Could not verify:** the maintainers' substantive response to the open-source
    complaint. The issue was closed as "not planned," but a documented maintainer
    rationale beyond the license text itself was not located in this research pass.
    Note this is the **main repository's** license; the one-click-apps repository
    remained Apache-2.0.
  - *(The "no longer open source" framing is the filer's characterization, attributed
    above; CapRover continues to market itself as "Free and Self-hosted" on
    [caprover.com](https://caprover.com/). The factual core — a modified Apache license
    with added commercial restrictions — is verifiable from the LICENSE file.)*

### Ongoing development (2019–2026)

- CapRover has continued steady, incremental releases since v1.0.0. As of this research
  pass the GitHub repository shows **~38 releases**, the latest being **v1.14.2 (May 14,
  2026)**, with the codebase predominantly **TypeScript** and **15,000+ GitHub stars**.
  - Source: [caprover/caprover — GitHub](https://github.com/caprover/caprover)
  - **Could not verify:** a full release-by-release timeline between v1.0.0 (2019) and
    v1.14.2 (2026); only the endpoints and selected releases were checked directly.

---

## Key people & teams

- **Kasra Bigdeli** — **Creator and primary maintainer** of CaptainDuckDuck/CapRover
  (GitHub: `githubsaturn`, bio "Working on CapRover"). He is the administrator listed on
  CapRover's Open Collective. Per his podcast interview, his day job is an **engineering
  manager at Uber**, where he has led the **in-app messaging team for UberEats**; he
  describes a background in mechanical/structural engineering before moving into
  software, and built CapRover on nights and weekends, motivated by Heroku's cost for
  side projects (he cites hosting a small vaccine-appointment scraper as one example).
  - Sources: [githubsaturn (Kasra Bigdeli) — GitHub profile](https://github.com/githubsaturn);
    [CapRover — Open Collective](https://opencollective.com/caprover);
    [#16 CapRover Interview 1 — Craft of Open Source Podcast, Flagsmith](https://www.flagsmith.com/podcast/kasra-bigdeli-caprover)
  - **Could not verify** Bigdeli's exact current title or tenure at Uber against a
    first-party (e.g., LinkedIn or Uber) primary source confirmed in this pass; the Uber
    / UberEats in-app-messaging details come from the Flagsmith podcast interview and are
    presented as **self-reported**.

- **BigZee Ventures LLC** — the entity named as copyright holder in CapRover's modified
  Apache license ("Copyright 2017-2024 BigZee Ventures LLC").
  - Source: [caprover/caprover — LICENSE](https://github.com/caprover/caprover/blob/master/LICENSE)
  - **Could not verify** the corporate details, ownership, or relationship of BigZee
    Ventures LLC to Kasra Bigdeli beyond the inference from the name and the license file
    itself.

- **Community contributors and backers** — CapRover is community-supported via Open
  Collective (under the Open Source Collective fiscal host), with backer/sponsor tiers.
  At the time of this research the collective reported roughly **$8,340 total raised**,
  **~136 contributors listed**, and named financial backers (e.g., DANTOO LTD, Louis
  Brauer). The one-click-apps catalog is explicitly **community-maintained**.
  - Sources: [CapRover — Open Collective](https://opencollective.com/caprover);
    [caprover/one-click-apps — GitHub](https://github.com/caprover/one-click-apps)
  - **Could not verify:** current/precise Open Collective totals (figures fluctuate and
    are a point-in-time snapshot).

---

## Company & corporate history

CapRover is a community open-source project led by an individual maintainer rather than
a venture-backed company; there is no funding-round history of the kind seen in
commercial PaaS entries in this corpus.

- **October 2017** — First release as **CaptainDuckDuck**, created by **Kasra
  Bigdeli**; Docker + Nginx + Let's Encrypt architecture.
  - [freeCodeCamp — Kasra Bigdeli](https://www.freecodecamp.org/news/how-i-cut-my-heroku-cost-by-400-5b9d0220ce13) ·
    [githubsaturn/captainduckduck — Releases](https://github.com/githubsaturn/captainduckduck/releases)
- **2018** — Adoption under the CaptainDuckDuck name; "millions of downloads from
  DockerHub"; community pressure for a more professional name.
  - [Open Collective v1.0.0 update](https://opencollective.com/caprover/updates/caprover-v-1-0-0) ·
    [Issue #194](https://github.com/caprover/caprover/issues/194)
- **January 20, 2019** — **v1.0.0**: renamed **CaptainDuckDuck → CapRover**; TypeScript
  rewrite; one-click rollback; separate one-click apps repo; `captain-definition` schema
  v2.
  - [Open Collective v1.0.0 update](https://opencollective.com/caprover/updates/caprover-v-1-0-0) ·
    [Release v1.0.0](https://github.com/caprover/caprover/releases/tag/v1.0.0)
- **July 20, 2023** — Main repository relicensed from Apache 2.0 to a **modified Apache
  license** with added commercial restrictions (copyright BigZee Ventures LLC), prompting
  later community pushback.
  - [LICENSE](https://github.com/caprover/caprover/blob/master/LICENSE) ·
    [Issue #2035](https://github.com/caprover/caprover/issues/2035)
- **2019–2026** — Continuous incremental releases; latest **v1.14.2 (May 14, 2026)**;
  15,000+ GitHub stars; funded via Open Collective.
  - [caprover/caprover — GitHub](https://github.com/caprover/caprover) ·
    [Open Collective](https://opencollective.com/caprover)

---

## Controversies & culture

> Each item separates **established fact** from **reported claim / characterization**,
> with attribution.

### 1. The CaptainDuckDuck → CapRover rename (2019)

- **Fact:** The project was renamed from CaptainDuckDuck to CapRover at v1.0.0
  (Jan 20, 2019), with a documented migration path.
  - [Release v1.0.0](https://github.com/caprover/caprover/releases/tag/v1.0.0) ·
    [CDD migration guide](https://caprover.com/docs/cdd-migration.html)
- **Reported motivation:** Community members found the original name hard to pitch
  professionally — captured in issue #194.
  - [Issue #194](https://github.com/caprover/caprover/issues/194)

### 2. License change and "no longer open source" dispute (2023–2024)

- **Fact:** The main repository's license is a modified Apache 2.0 with added commercial
  restrictions and a EULA/terms requirement; the LICENSE names BigZee Ventures LLC.
  - [LICENSE](https://github.com/caprover/caprover/blob/master/LICENSE)
- **Reported claim/criticism:** A community member (issue #2035, Mar 28, 2024) argued
  CapRover stopped being open source as of July 20, 2023 while still advertising itself
  as open source, and questioned the relicensing's legitimacy absent a CLA. The issue was
  closed as "not planned." This is the filer's characterization; CapRover still markets
  itself as "Free and Self-hosted."
  - [Issue #2035](https://github.com/caprover/caprover/issues/2035) ·
    [caprover.com](https://caprover.com/)

### 3. Single-maintainer / "bus factor" (context)

- **Context (not a controversy per se):** CapRover is closely tied to one maintainer who
  works on it part-time alongside a full-time job, a common dynamic for solo-led OSS that
  shapes its release cadence and governance. This is **descriptive context** drawn from
  the creator's own interviews, not a reported controversy.
  - [#16 CapRover Interview 1 — Flagsmith](https://www.flagsmith.com/podcast/kasra-bigdeli-caprover)

---

## Items marked "Could not verify"

- **Exact first-release date in October 2017** — the month/year rests on the creator's
  freeCodeCamp article; the earliest GitHub `v0.x` tag's precise date could not be
  re-read directly (the releases page omits years inline for the oldest entries, and the
  oldest release pages did not render in this pass). Observed nearby dates (v0.1.2 Nov 17,
  v0.2.1 Dec 4) and the RisingStack Dec 15, 2017 feature corroborate a late-2017
  timeframe.
- **A Show HN / Hacker News launch post for CaptainDuckDuck (2017)** — the creator says
  it gained traction on Hacker News, but a specific dated "Show HN" thread was not located
  in this research pass.
- **Kasra Bigdeli's exact current Uber title/tenure** — self-reported via the Flagsmith
  podcast; not confirmed against a first-party employer/LinkedIn source here.
- **BigZee Ventures LLC's corporate details and its formal relationship to Kasra
  Bigdeli** — inferred from the LICENSE copyright line only.
- **Maintainer's substantive response to the open-source/relicensing complaint
  (issue #2035)** — the issue was closed "not planned"; a documented rationale beyond the
  LICENSE text was not located.
- **A complete v1.0.0→v1.14.2 release timeline** — only endpoints and selected releases
  were verified directly.
- **Precise, current Open Collective totals** — a point-in-time snapshot that fluctuates.
- **"Millions of DockerHub downloads"** — stated in the creator's Open Collective v1.0.0
  update; not independently corroborated against DockerHub statistics here.
