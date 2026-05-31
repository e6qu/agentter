# Redis (and the Valkey fork): A Sourced History

A chronological, fully-sourced history of Redis from its 2009 origins through the
2024 licensing rupture, the Valkey fork, and the 2025 partial return to open source.
Every dated claim links to a primary or reputable secondary source. Opinion and
controversy are attributed to their source.

---

## Timeline

### 2009 — Founding

- **2009** — **Salvatore Sanfilippo** (online handle **"antirez"**), an Italian
  programmer, began developing **Redis** ("REmote DIctionary Server"). The project
  grew out of his attempt to scale **LLOOOGG** (also rendered "LLOOGG"), a real-time
  web log analyzer he built for his Italian startup. After hitting scaling limits with
  traditional database systems, he prototyped Redis first in Tcl, then rewrote it in C
  and implemented the first data type (the list).
  - Source: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo);
    [Redis — Wikipedia](https://en.wikipedia.org/wiki/Redis)
  - Redis is an **in-memory data-structure store** supporting strings, lists, sets,
    sorted sets, hashes, and (later) streams, originally released under the permissive
    **3-clause BSD license**.
    - Source: [Redis — Wikipedia](https://en.wikipedia.org/wiki/Redis)
  - *Note on exact release date:* secondary sources differ. One Wikipedia-derived
    extract cites a first public release of **April 10, 2009**; another cites a
    release date of **February 26, 2009**. **Could not verify: the exact day of the
    first public Redis release** from a single authoritative primary source; both
    candidate dates trace to Wikipedia rather than antirez's original announcement.

### 2010 — VMware sponsorship

- **March 15, 2010** — antirez announced on his blog that he was joining **VMware** to
  work on Redis (and Redis tools) full-time, after multiple companies approached him
  about hiring him to develop Redis. This put Redis development under corporate
  sponsorship for the first time.
  - Source: [antirez, "VMware: the new Redis home"](http://oldblog.antirez.com/post/vmware-the-new-redis-home.html)
    (dated Monday, March 15, 2010)
  - Wikipedia frames VMware's sponsorship period as **2010–2013**.
    - Source: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)

### 2013 — Pivotal

- **2013** — Sponsorship of Redis development passed to **Pivotal Software**, a VMware
  spin-off, which sponsored the project through roughly 2015.
  - Source: [Redis — Wikipedia](https://en.wikipedia.org/wiki/Redis) /
    [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)
  - *Could not verify the exact Pivotal handoff month from a primary source;* dating
    here rests on Wikipedia's sponsorship table (VMware 2010–2013, then Pivotal).

### 2015 — Redis Labs becomes steward; antirez joins

- **July 15, 2015** — **Redis Labs** (later **Redis Inc.**) became the primary
  commercial steward of the project, and **antirez joined Redis Labs** as the project's
  creator and "community member numero uno." Redis Labs' post credited the project's
  earlier success to sponsorship by **VMware and Pivotal**.
  - Source: [Redis blog, "Salvatore Sanfilippo – Welcome to Redis Labs"](https://redis.io/blog/salvatore-sanfilippo-welcome-to-redis-labs/)
    (dated July 15, 2015)

### 2018 — The Commons Clause controversy

- **August 2018** — Redis Labs added the **Commons Clause** as a rider on top of the
  Apache 2.0 license for several **Redis Modules** — including **RediSearch**, **RedisGraph**,
  **ReJSON**, **ReBloom**, and **Redis-ML** — moving them away from AGPL. The Commons
  Clause forbids selling software "whose value derives, entirely or substantially, from
  the functionality of the Software."
  - Sources: [The Register, "Redis has a license to kill" (Aug 23, 2018)](https://www.theregister.com/2018/08/23/redis_database_license_change/);
    [Redis blog, "Redis Labs' Modules License Changes"](https://redis.io/blog/redis-labs-modules-license-changes/)
  - **Stated rationale (attributed to Redis Labs / backers):** the change was meant to
    stop cloud providers from taking an open-source project, running it as a service,
    and "keeping the profits" while contributing little back.
    - Source: [TechCrunch, "Commons Clause stops open-source abuse" (Sept 7, 2018)](https://techcrunch.com/2018/09/07/commons-clause-stops-open-source-abuse/)
      (op-ed by Bain Capital's Salil Deshpande, an investor backing the clause)
  - **Community backlash (attributed to critics):** commentators argued the Commons
    Clause produces "source available," not open source, software and effectively makes
    these projects proprietary under the industry's accepted definition of "open source."
    - Source: [RedMonk (Stephen O'Grady), "Tragedy of the Commons Clause" (Sept 10, 2018)](https://redmonk.com/sogrady/2018/09/10/tragedy-of-the-commons-clause/)
  - **Important scope note:** the Commons Clause applied only to *modules*. The **Redis
    core itself remained 3-clause BSD** throughout this episode.
    - Source: [Redis blog, "Redis Labs' Modules License Changes"](https://redis.io/blog/redis-labs-modules-license-changes/)

### 2019 — Commons Clause dropped for RSAL

- **February 21, 2019** — Redis Labs dropped the Commons Clause for its modules and
  replaced it with its own **Redis Source Available License (RSAL)**, citing user
  "confusion" over the prior "Apache2 modified by Commons Clause" wording, ambiguity
  around the word "substantial," and unintended restrictions on "support." Under RSAL,
  developers may use, modify, and integrate the software, with the key restriction that
  the resulting application may not be a database, caching engine, stream-processing
  engine, search engine, indexing engine, or ML/DL/AI serving engine.
  - Sources: [Redis blog, "Redis Labs' Modules License Changes" (Feb 21, 2019)](https://redis.io/blog/redis-labs-modules-license-changes/);
    [The Register, "Redis kills Modules' Commons Clause licensing" (Feb 22, 2019)](https://www.theregister.com/2019/02/22/redis_labs_changes_license_funding_60m/)
  - Again, **the Redis core stayed 3-clause BSD** and was unaffected.
    - Source: [Redis blog, "Redis Labs' Modules License Changes"](https://redis.io/blog/redis-labs-modules-license-changes/)

### 2020 — antirez steps down

- **June 30, 2020** — antirez stepped away from day-to-day maintenance of Redis
  (bug fixes, releases, contributions). The project moved to a **core-team governance
  model**, with **Yossi Gottlieb** and **Oran Agra** taking over leadership and the
  broader direction guided by a core team of community contributors. antirez remained on
  the project's technical advisory board, and Redis Labs affirmed the **core would
  remain under the 3-clause BSD license**.
  - Source: [Redis blog, "Thank You, Salvatore Sanfilippo" (June 30, 2020)](https://redis.io/blog/thank-you-salvatore-sanfilippo/)
  - Wikipedia notes he cited a desire to pursue other projects and a dislike for the
    maintenance-focused phase of the work.
    - Source: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)

### 2022 — The KeyDB fork is acquired by Snap

- **May 12, 2022** — **Snap Inc.** acquired **KeyDB**, a multithreaded, BSD-3-licensed
  fork of Redis created by **John Sully** and **Ben Schermel** at EQ Alpha Technology
  (Toronto). Snap committed to continuing the open source project and open-sourcing
  KeyDB's Pro and Enterprise offerings. (KeyDB predates — and is distinct from — the
  later Valkey fork.)
  - Sources: [TechCrunch, "Snap snaps up database developer KeyDB" (May 12, 2022)](https://techcrunch.com/2022/05/12/snap-snaps-up-database-developer-keydb-to-make-its-infrastructure-more-snappy/amp/);
    [Snapchat/KeyDB on GitHub](https://github.com/Snapchat/KeyDB)

### 2024 — The license change and the Valkey fork

- **March 20, 2024** — **Redis Inc.** announced it was relicensing **Redis core away
  from the 3-clause BSD license**. Starting with **Redis 7.4**, Redis would be
  **dual-licensed under RSALv2 and SSPLv1** (both **source-available**, neither
  **OSI-approved open source**). CEO **Rowan Trollope** said the new licenses let Redis
  sustainably provide permissive source-code use while ensuring cloud service providers
  hosting Redis "will no longer be permitted to use the source code of Redis free of
  charge."
  - Sources: [Redis blog, "Redis Adopts Dual Source-Available Licensing"](https://redis.io/blog/redis-adopts-dual-source-available-licensing/);
    [TechCrunch (Valkey article, March 31, 2024)](https://techcrunch.com/2024/03/31/why-aws-google-and-oracle-are-backing-the-valkey-redis-fork/)
    (states the BSD-to-SSPL switch occurred **March 20, 2024**)
  - **Critical framing (attributed):** The Register's Liam Proven headlined the change
    "Redis tightens its license terms, pleasing no one," noted there is "nothing wrong
    with making money from free software," and cited the **Open Source Initiative's**
    position that **"the SSPL is not an open source license."**
    - Source: [The Register, "Redis tightens its license terms, pleasing no one" (March 22, 2024)](https://www.theregister.com/2024/03/22/redis_changes_license/)
  - **Stated rationale (attributed to Redis):** to stop cloud providers (e.g.
    AWS ElastiCache) from monetizing Redis as a managed service without contributing
    back — framed by commentators as Redis's "1% conversion" problem.
    - Source: [InfoQ, "Redis Switches to SSPLv1" (March 2024)](https://www.infoq.com/news/2024/03/redis-license-open-source/)

- **March 28, 2024** — **The Linux Foundation announced Valkey**, a community fork
  continuing development on **Redis 7.2.4** and keeping the project under the open-source
  **BSD 3-clause license**. Backers named in the announcement: **Amazon Web Services
  (AWS), Google Cloud, Oracle, Ericsson, and Snap Inc.** Valkey would follow an open
  governance model under the Linux Foundation.
  - Sources: [Linux Foundation press release, "Linux Foundation Launches Open Source Valkey Community"](https://www.linuxfoundation.org/press/linux-foundation-launches-open-source-valkey-community)
    (dated March 28, 2024);
    [PR Newswire mirror](https://www.prnewswire.com/news-releases/linux-foundation-launches-open-source-valkey-community-302102803.html)
  - **Madelyn Olson's role:** the fork originated with longtime Redis maintainer
    **Madelyn Olson** (at AWS), who first started the project in her own GitHub account.
    Per her account to reporters, when the license news broke "a lot of the current Redis
    maintainers quickly decided that it was time to move on." The Linux Foundation
    connection came together after AWS's David Nalley met LF executive director Jim
    Zemlin at KubeCon in Paris.
    - Source: [TechCrunch, "Why AWS, Google and Oracle are backing the Valkey Redis fork" (March 31, 2024)](https://techcrunch.com/2024/03/31/why-aws-google-and-oracle-are-backing-the-valkey-redis-fork/)
  - *Naming/date nuance:* the Linux Foundation's formal **press release is dated
    March 28, 2024**. Some secondary coverage refers to the launch as "April 1" or
    "April 2024"; the **March 28** date is from the LF's own release and is treated here
    as authoritative.

- **December 10, 2024** — **antirez returned to Redis** (the company), in an
  "evangelist" role — positioned as a bridge between the company and community, producing
  demos, patterns, docs, and blog content, and influencing Redis core direction. He also
  announced work on a new **Vector Sets** data type (with commands like `VSIM`).
  - Source: [Redis blog, "Welcome back to Redis, antirez" (Dec 10, 2024)](https://redis.io/blog/welcome-back-to-redis-antirez/)

### 2025 — Redis 8 and the AGPLv3 partial reversal

- **May 1, 2025** — **Redis 8.0** became generally available as the **first Redis
  version offered under the OSI-approved open-source AGPLv3 license**, added as a third
  option alongside RSALv2 and SSPLv1 (tri-licensing). This was a **partial reversal** of
  the 2024 source-available move. antirez led the push back to an OSI-approved license and
  contributed the new **Vector Sets** feature to the release.
  - Sources: [antirez, "Redis is open source again"](https://antirez.com/news/151);
    [Redis blog, "Redis is now available under the AGPLv3 open source license"](https://redis.io/blog/agplv3/);
    [LWN.net summary](https://lwn.net/Articles/1019686/)
  - **Attributed to antirez:** he wrote that he had rejoined ~five months earlier and
    advocated for AGPL because "the SSPL, in practical terms, failed to be accepted by the
    community" — "the OSI wouldn't accept it, nor would the software community regard the
    SSPL as an open license." He added that he "truly wanted the code I wrote for the new
    Vector Sets data type to be released under an open source license," concluding "today
    I'm happy."
    - Source: [antirez, "Redis is open source again"](https://antirez.com/news/151)
  - **Skeptical framing (attributed):** coverage questioned whether the reversal came
    "too late" given Valkey's momentum.
    - Source: [InfoQ, "Redis Returns to Open Source under AGPL License: Is It Too Late?" (May 2025)](https://www.infoq.com/news/2025/05/redis-agpl-license/)

---

## Key people & teams

- **Salvatore Sanfilippo ("antirez")** — Creator of Redis (2009); BDFL for ~11 years;
  hired by VMware (2010); joined Redis Labs (2015); stepped down as maintainer
  (June 30, 2020); returned to Redis Inc. as evangelist (Dec 10, 2024); led the move to
  AGPLv3 and built Vector Sets for Redis 8 (2025).
  - Sources: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo);
    [Redis blog, "Welcome back to Redis, antirez"](https://redis.io/blog/welcome-back-to-redis-antirez/);
    [antirez, "Redis is open source again"](https://antirez.com/news/151)
- **Yossi Gottlieb** and **Oran Agra** — Core maintainers/leaders who took over Redis
  governance when antirez stepped down in 2020.
  - Source: [Redis blog, "Thank You, Salvatore Sanfilippo"](https://redis.io/blog/thank-you-salvatore-sanfilippo/)
- **Rowan Trollope** — CEO of Redis Inc., public voice of the March 2024 source-available
  relicensing.
  - Source: [Redis blog, "Redis Adopts Dual Source-Available Licensing"](https://redis.io/blog/redis-adopts-dual-source-available-licensing/)
- **Madelyn Olson** — Longtime (ex-)Redis maintainer at AWS who started the Valkey fork
  in her personal GitHub account; central to organizing the maintainers' move.
  - Source: [TechCrunch, "Why AWS, Google and Oracle are backing the Valkey Redis fork"](https://techcrunch.com/2024/03/31/why-aws-google-and-oracle-are-backing-the-valkey-redis-fork/)
- **John Sully** and **Ben Schermel** — Creators of KeyDB (EQ Alpha Technology),
  acquired by Snap in 2022.
  - Source: [TechCrunch, "Snap snaps up database developer KeyDB"](https://techcrunch.com/2022/05/12/snap-snaps-up-database-developer-keydb-to-make-its-infrastructure-more-snappy/amp/)
- **David Nalley (AWS)** and **Jim Zemlin (Linux Foundation)** — Helped land Valkey at the
  Linux Foundation after meeting at KubeCon Paris.
  - Source: [TechCrunch, "Why AWS, Google and Oracle are backing the Valkey Redis fork"](https://techcrunch.com/2024/03/31/why-aws-google-and-oracle-are-backing-the-valkey-redis-fork/)

---

## Company & corporate history

- **2009** — Redis created by antirez as a side project out of LLOOOGG; open-sourced
  under 3-clause BSD.
  - Source: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)
- **2010–2013** — **VMware** sponsors Redis development (antirez hired March 15, 2010).
  - Sources: [antirez, "VMware: the new Redis home"](http://oldblog.antirez.com/post/vmware-the-new-redis-home.html);
    [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)
- **2013–2015** — **Pivotal Software** (VMware spin-off) sponsors development.
  - Source: [Salvatore Sanfilippo — Wikipedia](https://en.wikipedia.org/wiki/Salvatore_Sanfilippo)
- **2015 →** — **Redis Labs** (rebranded **Redis Inc.** / **Redis Ltd.**) becomes the
  commercial steward; antirez joins (July 15, 2015). Redis Inc. sells **Redis Enterprise**
  and modules, and has been the driver of the 2018, 2019, and 2024 licensing changes.
  - Sources: [Redis blog, "Salvatore Sanfilippo – Welcome to Redis Labs"](https://redis.io/blog/salvatore-sanfilippo-welcome-to-redis-labs/);
    [Redis blog, "Redis Adopts Dual Source-Available Licensing"](https://redis.io/blog/redis-adopts-dual-source-available-licensing/)
- **2024 → present** — After the license backlash and the Valkey fork, Redis Inc. rehired
  antirez (Dec 2024) and reversed course toward open source with AGPLv3 in Redis 8 (2025).
  - Sources: [Redis blog, "Welcome back to Redis, antirez"](https://redis.io/blog/welcome-back-to-redis-antirez/);
    [Redis blog, "Redis is now available under the AGPLv3 open source license"](https://redis.io/blog/agplv3/)

---

## Licensing controversies & the Valkey fork

**1. Commons Clause (2018) → RSAL (2019) — modules only.**
In August 2018 Redis Labs put the **Commons Clause** atop Apache 2.0 for modules
(RediSearch, RedisGraph, ReJSON, ReBloom, Redis-ML), restricting commercial sale. Critics
(e.g. RedMonk's Stephen O'Grady) argued this is "source available," not open source; Redis
Labs and backers (e.g. Salil Deshpande in TechCrunch) framed it as stopping cloud
providers from free-riding. In **February 2019** Redis Labs dropped the Commons Clause for
its own **RSAL**, citing user confusion. Crucially, the **Redis core stayed 3-clause BSD**
through both changes.
- Sources: [The Register (Aug 2018)](https://www.theregister.com/2018/08/23/redis_database_license_change/);
  [RedMonk (Sept 2018)](https://redmonk.com/sogrady/2018/09/10/tragedy-of-the-commons-clause/);
  [TechCrunch (Sept 2018)](https://techcrunch.com/2018/09/07/commons-clause-stops-open-source-abuse/);
  [Redis blog (Feb 2019)](https://redis.io/blog/redis-labs-modules-license-changes/);
  [The Register (Feb 2019)](https://www.theregister.com/2019/02/22/redis_labs_changes_license_funding_60m/)

**2. The 2024 core relicensing — the real rupture.**
On **March 20, 2024**, Redis Inc. moved the **Redis core itself** off BSD to dual
**RSALv2 / SSPLv1** (source-available, **not OSI-approved**), starting with Redis 7.4. The
OSI and critics held that SSPL is not an open-source license; The Register called the move
one that pleased "no one." Redis framed it as preventing cloud providers from monetizing
Redis without paying.
- Sources: [Redis blog](https://redis.io/blog/redis-adopts-dual-source-available-licensing/);
  [The Register (March 22, 2024)](https://www.theregister.com/2024/03/22/redis_changes_license/);
  [InfoQ (March 2024)](https://www.infoq.com/news/2024/03/redis-license-open-source/)

**3. The Valkey fork (March 28, 2024).**
Within days, the **Linux Foundation launched Valkey**, a BSD-3 fork continuing Redis 7.2.4,
backed by **AWS, Google Cloud, Oracle, Ericsson, and Snap**, and seeded by ex-Redis
maintainers led by **Madelyn Olson**. Valkey adopted an open, multi-vendor governance model
explicitly to avoid single-vendor control. (An earlier multithreaded fork, **KeyDB**, had
been acquired by **Snap in 2022** but is a separate lineage.)
- Sources: [Linux Foundation press release (March 28, 2024)](https://www.linuxfoundation.org/press/linux-foundation-launches-open-source-valkey-community);
  [TechCrunch (March 31, 2024)](https://techcrunch.com/2024/03/31/why-aws-google-and-oracle-are-backing-the-valkey-redis-fork/);
  [TechCrunch on KeyDB (2022)](https://techcrunch.com/2022/05/12/snap-snaps-up-database-developer-keydb-to-make-its-infrastructure-more-snappy/amp/)

**4. The partial reversal (Redis 8 / AGPLv3, May 2025).**
With antirez back, Redis added the **OSI-approved AGPLv3** as a third license option in
**Redis 8.0 (GA May 1, 2025)** — a partial walk-back of the source-available stance. antirez
wrote that "the SSPL … failed to be accepted by the community." Commentators (InfoQ) asked
whether the change came "too late" given Valkey's adoption momentum.
- Sources: [antirez, "Redis is open source again"](https://antirez.com/news/151);
  [Redis blog, AGPLv3](https://redis.io/blog/agplv3/);
  [InfoQ (May 2025)](https://www.infoq.com/news/2025/05/redis-agpl-license/)

---

## Current status (as of mid-2026)

- **Redis Inc.** continues to develop Redis, now **tri-licensed (RSALv2 / SSPLv1 / AGPLv3)**
  from Redis 8 onward, with antirez back and contributing (Vector Sets).
  - Sources: [Redis blog, AGPLv3](https://redis.io/blog/agplv3/);
    [antirez, "Redis is open source again"](https://antirez.com/news/151)
- **Valkey** continues under the **Linux Foundation** with broad cloud-vendor adoption
  (AWS, Google Cloud, Oracle, etc.) and an active multi-company contributor base; multiple
  managed services and cloud providers shifted to Valkey after the 2024 license change.
  - Sources: [Linux Foundation, "Forking Ahead: A Year of Valkey"](https://www.linuxfoundation.org/blog/a-year-of-valkey);
    [Linux Foundation, "Announcing Valkey 8.0"](https://www.linuxfoundation.org/press/valkey-8-0)
  - *Could not independently verify precise current market-share / adoption percentages;*
    some secondary outlets cite cost savings and "rapidly overtaking Redis," but those are
    vendor-influenced or analyst estimates rather than primary data.

---

## Items that could NOT be fully verified

1. **Exact day of the first public Redis release in 2009** — secondary sources give both
   **April 10, 2009** and **February 26, 2009**; both trace to Wikipedia, not antirez's
   original announcement. Marked: *Could not verify.*
2. **Exact month of the VMware→Pivotal sponsorship handoff (2013)** — relies on Wikipedia's
   sponsorship table, not a primary announcement. Marked: *Could not verify (precise date).*
   (The VMware hiring of antirez itself **is** primary-sourced: March 15, 2010.)
3. **Precise current Valkey vs Redis adoption/market-share figures** — only vendor or
   analyst estimates found, no neutral primary data. Marked: *Could not verify.*
