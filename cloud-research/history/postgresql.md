# PostgreSQL (Ingres → POSTGRES → PostgreSQL): A Sourced History

A chronological, fully-sourced history of PostgreSQL — from its Berkeley
academic lineage (Ingres, then POSTGRES), through the community
"PostgreSQL Global Development Group" era, the permissive-license-fueled
commercial ecosystem, the 2024–2025 acquisition wave, and the pgvector / AI
surge. Every non-trivial claim links to a primary or reputable source. Where a
fact could not be confirmed, it is flagged "Could not verify." Opinions are
attributed to their sources.

**Cross-references (not duplicated here):**
- The relational-vs-NoSQL framing, the document-database competition, and the
  SSPL relicensing drama live in [`mongodb.md`](./mongodb.md). This doc covers
  the *Postgres side* of that competition (JSON/JSONB) and uses MongoDB/Redis
  only as the licensing counterpoint.
- The BSL/relicensing counterpoint (Redis' 2024 move off BSD) lives in
  [`redis.md`](./redis.md).
- Managed Postgres as a *cloud* offering (RDS / Aurora and the broader managed
  database market) is contextualized against the object-storage and cloud-API
  history in [`s3-object-storage.md`](./s3-object-storage.md) and
  [`cloud-apis.md`](./cloud-apis.md); here it is covered only as part of the
  Postgres commercial ecosystem.

---

## Timeline

### ~1973–1974 — Ingres begins at UC Berkeley (Stonebraker & Wong)

- At UC Berkeley, **Michael Stonebraker** and **Eugene Wong** began work on
  **INGRES** (INteractive GRaphics REtrieval System), one of the earliest
  relational database management systems, inspired by Edgar Codd's relational
  model. ACM's Turing biography dates the invention of Ingres to 1974.
  - Source: ACM A.M. Turing Award — Michael Stonebraker,
    <https://amturing.acm.org/award_winners/stonebraker_1172121.cfm>
  - Source: Michael Stonebraker — Wikipedia,
    <https://en.wikipedia.org/wiki/Michael_Stonebraker>
- Ingres' query language was **QUEL** (not SQL). Stonebraker's work on Ingres
  introduced "query modification," used for integrity constraints and views.
  - Source: ACM Turing biography,
    <https://amturing.acm.org/award_winners/stonebraker_1172121.cfm>
- In **1980**, Stonebraker co-founded **Relational Technology, Inc.** to build a
  commercial Ingres; he left Berkeley around 1982 for the commercial effort and
  returned to Berkeley circa 1985.
  - Source: PostgreSQL — Wikipedia,
    <https://en.wikipedia.org/wiki/PostgreSQL>
  - Could not verify the exact founding month/day of Relational Technology, Inc.

### 1986 — POSTGRES ("post-Ingres") starts at Berkeley; the object-relational model

- Implementation of **POSTGRES** — explicitly the **"post-Ingres"** project —
  **began in 1986** under Professor Stonebraker at Berkeley, sponsored by
  **DARPA, the Army Research Office (ARO), the National Science Foundation
  (NSF), and ESL, Inc.**
  - Source (primary): PostgreSQL official docs, "A Brief History of PostgreSQL,"
    <https://www.postgresql.org/docs/current/history.html>
- The 1986 starting point and the name are corroborated by ACM: Stonebraker
  invented "Postgres (Post Ingres) in 1986," whose later work introduced the
  **object-relational model** — merging databases with abstract data types and
  enabling complex data (CAD, geospatial, time series).
  - Source: ACM Turing biography,
    <https://amturing.acm.org/award_winners/stonebraker_1172121.cfm>
- POSTGRES used its own query language, **POSTQUEL** (a descendant of QUEL, not
  SQL). The interface library `libpq` is named after PostQUEL.
  - Source: PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>

### 1987–1994 — Berkeley POSTGRES releases, then the project ends

- Per the official history:
  - **1987**: the first "demoware" system became operational.
  - **1988**: shown at the ACM-SIGMOD Conference.
  - **June 1989**: Version 1 released to external users.
  - **June 1990**: Version 2 (redesigned rule system).
  - **1991**: Version 3 (multiple storage managers, rewritten rule system).
  - The Berkeley POSTGRES project **officially ended with Version 4.2** (the
    growing user base created an unsustainable support burden for an academic
    team).
  - Source: PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>

### 1994–1995 — Postgres95: Andrew Yu & Jolly Chen add SQL

- **In 1994, Andrew Yu and Jolly Chen added an SQL language interpreter to
  POSTGRES**, replacing POSTQUEL with SQL in the server. The result was renamed
  **Postgres95** and released to the web as an open-source descendant of the
  Berkeley code.
  - Source (primary): PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>
- Postgres95 release 1.0.x ran about **30–50% faster** on the Wisconsin
  Benchmark than POSTGRES Version 4.2.
  - Source: PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>

### 1996 — Renamed PostgreSQL; version numbering resumes at 6.0; community formed

- **By 1996** it was clear "Postgres95" would not last. The project chose the
  name **PostgreSQL** "to reflect the relationship between the original POSTGRES
  and the more recent versions with SQL capability," and set the version
  numbering to start at **6.0**, resuming the Berkeley POSTGRES sequence.
  - Source (primary): PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>
- **Marc Fournier** provided the first non-university development server in
  **July 1996**, and stabilization work proceeded with **Bruce Momjian** and
  **Vadim B. Mikheev**, among others — the seed of the distributed,
  community-run development model.
  - Source: PostgreSQL — Wikipedia,
    <https://en.wikipedia.org/wiki/PostgreSQL>

### 1999 — PostgreSQL 6.5 ships MVCC

- **PostgreSQL 6.5** was released **June 9, 1999**, introducing
  **multiversion concurrency control (MVCC)** — replacing old table-level
  locking so that readers do not block writers and vice versa. The release notes
  describe it as "a locking system that is superior to most commercial database
  systems."
  - Source (primary, with quoted release notes): PostgreSQL 6.5 Release Notes,
    <https://www.postgresql.org/docs/release/6.5.0/>
  - Note: one secondary search result claimed MVCC arrived circa 2000–2001; this
    contradicts the primary 6.5 (1999) release notes, which explicitly list
    MVCC. The primary source is used here.

### 2001 — PostGIS: Postgres becomes the de-facto spatial database

- **In May 2001, Refractions Research released the first version of PostGIS**
  (0.1), a spatial database extension that "spatially enables" PostgreSQL for
  GIS and web-mapping. As functions accreted, PostGIS organized itself around
  the Open Geospatial Consortium's "Simple Features for SQL" specification.
  - Source: PostGIS — Wikipedia, <https://en.wikipedia.org/wiki/PostGIS>
  - Source (project history): "Introduction," Introduction to PostGIS,
    <https://postgis.net/workshops/postgis-intro/introduction.html>
- PostGIS is the canonical example of PostgreSQL's **extensibility** — custom
  types, operators, and index support classes added without forking the core.

### 2004–2005 — EnterpriseDB founded; the first big commercial Postgres company

- **EnterpriseDB (EDB)** was founded in **2004** and introduced its database
  product in 2005, positioning as Oracle-compatible Postgres. It is one of the
  largest corporate contributors to PostgreSQL.
  - Source: EnterpriseDB — Wikipedia,
    <https://en.wikipedia.org/wiki/EnterpriseDB>

### 2005 — Greenplum: Postgres-based MPP data warehouse

- **Greenplum** (San Mateo, CA) released its PostgreSQL-based massively parallel
  processing (MPP) DBMS in **April 2005** (initially "Bizgres"). It was
  **acquired by EMC in July 2010**, became part of **Pivotal Software** (2012),
  and — when **Pivotal was acquired by VMware (2019/2020)** — was commercialized
  as VMware Tanzu Greenplum.
  - Source: Greenplum — Wikipedia, <https://en.wikipedia.org/wiki/Greenplum>
  - Note (cross-ref): this is the analytics/MPP lineage; for the wider managed
    cloud-database market see [`cloud-apis.md`](./cloud-apis.md).

### 2011 — Citus Data founded (distributed Postgres extension)

- **Citus Data** was founded in **2011**, building an open-source extension that
  turns PostgreSQL into a distributed, sharded database for scale-out and
  real-time analytics.
  - Source: TechCrunch, "Microsoft acquires Citus Data" (Jan 24, 2019),
    <https://techcrunch.com/2019/01/24/microsoft-acquires-citus-data/>

### 2012 — Amazon Redshift (ParAccel/Postgres lineage)

- **Amazon Redshift** launched in **preview November 2012**, generally available
  **February 15, 2013**. Redshift is **based on ParAccel**, an MPP columnar
  database that was itself built as a **fork of PostgreSQL 8.0.2**; Redshift's
  SQL dialect is PostgreSQL-flavored.
  - Source: Amazon Redshift — Wikipedia,
    <https://en.wikipedia.org/wiki/Amazon_Redshift>
  - Source (Postgres lineage, AWS docs): "Amazon Redshift and PostgreSQL,"
    <https://docs.aws.amazon.com/redshift/latest/dg/c_redshift-and-postgres-sql.html>
  - Note: Redshift is *derived from* Postgres but is a proprietary AWS service;
    contrast with RDS/Aurora Postgres below, which run actual PostgreSQL.

### 2012 — JSON arrives in core: PostgreSQL 9.2

- **PostgreSQL 9.2 (2012)** added a native **`json` type** — at this stage it
  validated and stored JSON as text.
  - Source: dbvis, "Everything You Need to Know About the Postgres JSONB Data
    Type," <https://www.dbvis.com/thetable/everything-you-need-to-know-about-the-postgres-jsonb-data-type/>
  - Could not verify the exact 9.2 release date from a primary source in this
    research pass (secondary sources state "2012").

### 2013 — Amazon RDS for PostgreSQL (managed Postgres)

- **Amazon RDS for PostgreSQL** was announced at AWS re:Invent in
  **November 2013** (AWS "What's New," Nov 14, 2013).
  - Source (AWS): "Announcing Amazon RDS for PostgreSQL,"
    <https://aws.amazon.com/about-aws/whats-new/2013/11/14/announcing-amazon-rds-for-postgresql/>
  - Cross-ref: managed-database-as-a-cloud-service framing lives in
    [`cloud-apis.md`](./cloud-apis.md) and the object-storage analogue in
    [`s3-object-storage.md`](./s3-object-storage.md).

### 2014 — JSONB: PostgreSQL fires a shot at the document databases

- **PostgreSQL 9.4** was released **2014-12-18**, adding the **`jsonb`** type —
  a binary, indexable JSON storage format enabling efficient querying, indexing
  (GIN), and path search.
  - Source (primary release date): PostgreSQL 9.4.0 Release Notes,
    <https://www.postgresql.org/docs/release/9.4.0/>
  - Source ("what's new" list): "What's new in PostgreSQL 9.4," PostgreSQL wiki,
    <https://wiki.postgresql.org/wiki/What's_new_in_PostgreSQL_9.4>
- Commentary (attributed): with JSONB, "PostgreSQL implements a large chunk of
  the JSON data manipulation features available in databases like MongoDB and
  CouchDB, with comparable performance" — JSONB was widely framed as "a shot
  across the bow of dedicated document databases like MongoDB."
  - Source (opinion): dbvis, "Everything You Need to Know About the Postgres
    JSONB Data Type,"
    <https://www.dbvis.com/thetable/everything-you-need-to-know-about-the-postgres-jsonb-data-type/>
  - Cross-ref: the document-database competition from MongoDB's side, and the
    SSPL relicensing it triggered, are covered in [`mongodb.md`](./mongodb.md).

### 2014 — Stonebraker wins the ACM A.M. Turing Award

- **Michael Stonebraker** received the **2014 ACM A.M. Turing Award** "for
  fundamental contributions to the concepts and practices underlying modern
  database systems." The award (carrying a **$1 million** prize, funded by
  Google) was announced **March 25, 2015**.
  - Source: SD Times, "2014 Turing Award goes to MIT's Michael Stonebraker,"
    <https://sdtimes.com/acm/2014-turing-award-goes-to-mits-michael-stonebraker/>
  - Source (citation, prize, Ingres/Postgres description): MIT News,
    "Michael Stonebraker wins $1 million Turing Award" (Mar 25, 2015),
    <https://news.mit.edu/2015/michael-stonebraker-wins-turing-award-0325>
  - Note on year vs. announcement: ACM labels it the *2014* Turing Award though
    it was announced in March 2015 (standard ACM nomenclature).

### 2017 — Logical replication in core (PostgreSQL 10); Aurora Postgres; Timescale

- **PostgreSQL 10 (2017)** added native **logical replication** (publish/
  subscribe), building on the logical-decoding foundations introduced in 9.4.
  - Source: EDB, "Logical Replication in PostgreSQL 10,"
    <https://www.enterprisedb.com/blog/logical-replication-postgresql-10>
  - Source (10 docs): PostgreSQL 10 Logical Replication,
    <https://www.postgresql.org/docs/10/logical-replication.html>
- **Amazon Aurora** added **PostgreSQL compatibility in October 2017**.
  - Source: Amazon Aurora — Wikipedia,
    <https://en.wikipedia.org/wiki/Amazon_Aurora>
- **Timescale Inc.** was founded in **April 2017**; **TimescaleDB**, a
  time-series PostgreSQL extension, launched the same year. (The company later
  rebranded as Tiger Data.)
  - Source: TimescaleDB — Wikipedia,
    <https://en.wikipedia.org/wiki/TimescaleDB>

### 2019 — Microsoft acquires Citus Data

- On **January 24, 2019**, **Microsoft acquired Citus Data**, the distributed-
  Postgres company, to strengthen Azure's PostgreSQL offering ("Hyperscale
  (Citus)"). Citus is an open-source extension; Microsoft framed the deal as a
  commitment to open source.
  - Source (Microsoft): "Microsoft acquires Citus Data…" (Jan 24, 2019),
    <https://blogs.microsoft.com/blog/2019/01/24/microsoft-acquires-citus-data-re-affirming-its-commitment-to-open-source-and-accelerating-azure-postgresql-performance-and-scale/>
  - Source (Citus): "Microsoft Acquires Citus Data…" (Jan 24, 2019),
    <https://www.citusdata.com/blog/2019/01/24/microsoft-acquires-citus-data/>

### 2020 — EDB acquires 2ndQuadrant (Simon Riggs' company)

- In **2020, EDB acquired 2ndQuadrant**, the UK-based Postgres consultancy
  founded by **Simon Riggs**, making EDB "the largest dedicated provider of
  PostgreSQL products and solutions worldwide." Simon Riggs continued at EDB as
  a Postgres Fellow.
  - Source (EDB press release): "EDB Completes Acquisition of 2ndQuadrant…,"
    <https://www.enterprisedb.com/press-releases/edb-completes-acquisition-2ndquadrant-becomes-largest-dedicated-provider-postgresql>
  - Source (community statement): "Statement from the PostgreSQL Core Team on
    the EDB acquisition of 2ndQuadrant,"
    <https://www.postgresql.org/about/news/statement-from-the-postgresql-core-team-on-the-edb-acquisition-of-2ndquadrant-2094/>

### 2020 — Supabase: "the open-source Firebase alternative" built on Postgres

- **Supabase** was launched in **2020** by **Paul Copplestone** (CEO) and
  **Ant Wilson** (CTO) as an open-source, Postgres-based "Firebase
  alternative" (auth, storage, realtime, auto-generated REST/GraphQL APIs, Row
  Level Security). It raised a **$6M** round (led by Coatue, with YC and
  Mozilla) announced **December 15, 2020**.
  - Source: TechCrunch, "Supabase raises $6M for its open-source Firebase
    alternative" (Dec 15, 2020),
    <https://techcrunch.com/2020/12/15/supabase-raises-6m-for-its-open-source-firebase-alternative/>

### 2021 — pgvector: Postgres becomes a vector database (see "The AI era")

- **pgvector**, by **Andrew Kane**, had its first release on **April 20, 2021**
  (see [The AI era](#the-ai-era-pgvector) below for the 2023–2025 surge).
  - Source: Pgvector — Grokipedia,
    <https://grokipedia.com/page/Pgvector>
  - Could not verify the exact "April 20, 2021" first-release date against the
    pgvector GitHub release/tag history in this pass; flagged for primary
    confirmation.

### 2024 — "Postgres is eating the database world"; Simon Riggs dies

- The narrative crystallized in **2024**. Ruohang Feng ("Vonng") published
  **"Postgres is eating the database world"** (widely circulated Oct 2024),
  arguing Postgres had become "a data management framework with the potential to
  engulf the entire database realm" and that "Using Postgres for Everything" was
  becoming mainstream best practice.
  - Source (opinion, author Vonng): PIGSTY, "Postgres is eating the database
    world," <https://pigsty.io/blog/pg/pg-eat-db-world/>
  - Source (HN discussion): <https://news.ycombinator.com/item?id=39711863>
- LeadDev framed the same trend as **"PostgreSQL: the database that quietly ate
  the world,"** noting the 2023 Stack Overflow survey was the first in which
  PostgreSQL **eclipsed MySQL** as the most-used database (≈49% of professional
  developers).
  - Source (opinion): LeadDev, "PostgreSQL: the database that quietly ate the
    world,"
    <https://leaddev.com/technical-direction/postgresql-database-quietly-ate-world>
- **Simon Riggs** — 2ndQuadrant founder and a major PostgreSQL contributor
  (point-in-time recovery, hot standby, synchronous replication) — **died on
  March 26, 2024** in a light-aircraft crash near Duxford.
  - Source (PostgreSQL): "Remembering Simon Riggs,"
    <https://www.postgresql.org/about/news/remembering-simon-riggs-2830/>
  - Source (press): LWN, "The PostgreSQL community mourns Simon Riggs,"
    <https://lwn.net/Articles/966868/>

### May 2025 — Databricks acquires Neon (~$1B serverless Postgres)

- On **May 14, 2025**, **Databricks announced it would acquire Neon**, the
  serverless-Postgres company. The price was **not disclosed in the press
  release**, but TechCrunch and multiple outlets reported it at **~$1 billion**.
  - Source (Databricks press release, May 14, 2025; price not disclosed):
    <https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems>
  - Source (~$1B figure): TechCrunch, "Databricks to buy open source database
    startup Neon for $1B" (May 14, 2025),
    <https://techcrunch.com/2025/05/14/databricks-to-buy-open-source-database-startup-neon-for-1b/>
- **Neon** was founded in **2021**; its CEO is **Nikita Shamgunov** (co-founders
  include **Heikki Linnakangas** and **Stas Kelvich**). Databricks emphasized
  the AI-agent angle: per Neon telemetry, **over 80% of databases provisioned on
  Neon were created automatically by AI agents**, with new instances spun up in
  **under 500 ms**.
  - Source (founders): TechCrunch (May 14, 2025) and PR Newswire release,
    <https://www.prnewswire.com/news-releases/databricks-agrees-to-acquire-neon-to-deliver-serverless-postgres-for-developers--ai-agents-302454992.html>
  - Source (80% / 500ms): Databricks press release (above).
  - Could not verify a *single primary source* naming all three co-founders
    together; Shamgunov as CEO is confirmed by the Databricks release.

### June 2025 — Snowflake acquires Crunchy Data

- On **June 2, 2025**, **Snowflake announced the acquisition of Crunchy Data**,
  an enterprise PostgreSQL company **founded in 2012**, to launch **"Snowflake
  Postgres."** Press reports put the deal at **~$250 million**.
  - Source (Crunchy Data, Jun 2, 2025): "Crunchy Data Joins Snowflake,"
    <https://www.crunchydata.com/blog/crunchy-data-joins-snowflake>
  - Source (announcement): Business Wire, "Snowflake Acquires Crunchy Data…"
    (Jun 2, 2025),
    <https://www.businesswire.com/news/home/20250602455530/en/Snowflake-Acquires-Crunchy-Data-to-Bring-Enterprise-Ready-Postgres-Offering-to-the-AI-Data-Cloud>
  - Source (~$250M figure): TechCrunch, "Snowflake to acquire database startup
    Crunchy Data" (Jun 2, 2025),
    <https://techcrunch.com/2025/06/02/snowflake-to-acquire-database-startup-crunchy-data/>
  - Note: the two 2025 deals (Databricks→Neon, Snowflake→Crunchy) are the
    clearest evidence for the "Postgres won" narrative — two data-cloud giants
    each bought a Postgres company within ~3 weeks, both explicitly framing it
    around AI/agentic workloads.

---

## Key people & teams

- **Michael Stonebraker** — Berkeley professor; led both **Ingres** (with
  Eugene Wong, ~1974) and **POSTGRES** (1986). **2014 ACM Turing Award.**
  Founded multiple database companies (Ingres, Illustra, Vertica, VoltDB,
  Tamr, etc.).
  - Source: ACM Turing biography,
    <https://amturing.acm.org/award_winners/stonebraker_1172121.cfm>
- **Eugene Wong** — Stonebraker's Berkeley co-creator of Ingres.
  - Source: Michael Stonebraker — Wikipedia,
    <https://en.wikipedia.org/wiki/Michael_Stonebraker>
- **Andrew Yu** and **Jolly Chen** — added the SQL interpreter to POSTGRES in
  1994, creating Postgres95.
  - Source: PostgreSQL docs history,
    <https://www.postgresql.org/docs/current/history.html>
- **Marc Fournier** — provided the first non-university dev server (July 1996);
  early infrastructure steward of the open project.
  - Source: PostgreSQL — Wikipedia,
    <https://en.wikipedia.org/wiki/PostgreSQL>
- **Bruce Momjian** — long-time core contributor, historian, and co-founder of
  the PostgreSQL Global Development Group; author of the project's own history
  write-ups.
  - Source: "The History of PostgreSQL Open Source Development" (Momjian),
    <https://momjian.us/main/writings/pgsql/history.pdf>
- **Tom Lane** — one of the most prolific PostgreSQL core developers (query
  planner/optimizer and much more).
  - Source: PostgreSQL Contributor Profiles,
    <https://www.postgresql.org/community/contributors/>
- **Vadim B. Mikheev** — implemented foundational MVCC-era work.
  - Source: PostgreSQL — Wikipedia,
    <https://en.wikipedia.org/wiki/PostgreSQL>
- **Jan Wieck** — core contributor (e.g., Slony replication, TOAST, numeric
  types).
  - Source: PostgreSQL Contributor Profiles,
    <https://www.postgresql.org/community/contributors/>
- **Peter Eisentraut** — long-time core committer (SQL conformance, build
  system, logical replication work).
  - Source: PostgreSQL Contributor Profiles,
    <https://www.postgresql.org/community/contributors/>
- **Simon Riggs** — founder of **2ndQuadrant**; contributed point-in-time
  recovery, hot standby, synchronous replication; died March 26, 2024.
  - Source: "Remembering Simon Riggs,"
    <https://www.postgresql.org/about/news/remembering-simon-riggs-2830/>
- **The Core Team / PostgreSQL Global Development Group (PGDG)** — the central
  arbiter of project policy; the broader PGDG is a volunteer association of
  contributors and companies.
  - Source: PostgreSQL Core Team, <https://www.postgresql.org/developer/core/>
  - Source: PostgreSQL Governance, <https://www.postgresql.org/about/governance/>
- Could not verify, from a single primary source, an exhaustive roster of every
  individual contributor's specific feature attributions beyond what the
  contributor profiles and release notes state.

---

## Governance & license (why it matters)

- **No owning company.** PostgreSQL is governed by the **PostgreSQL Global
  Development Group (PGDG)** with a **Core Team** as the central arbiter of
  policy. "It is a community project and is not controlled by any company."
  - Source: PostgreSQL Governance,
    <https://www.postgresql.org/about/governance/>
  - Source: PostgreSQL Core Team,
    <https://www.postgresql.org/developer/core/>
- **The PostgreSQL License** is "a liberal Open Source license, similar to the
  BSD or MIT licenses," and the PGDG states it "remains committed to making
  PostgreSQL available as free and open source software in perpetuity… There are
  no plans to change the PostgreSQL License or release PostgreSQL under a
  different license."
  - Source (primary): PostgreSQL License,
    <https://www.postgresql.org/about/licence/>

### Why the permissive, un-relicensable license matters

The single most consequential governance fact about PostgreSQL is structural:
because the project is owned by no company and licensed under a permissive
BSD/MIT-style license held by a community foundation, **no commercial entity can
acquire, control, or relicense PostgreSQL itself.** Vendors can fork it, build
on it, embed it, and sell managed versions — but they cannot pull the rug out
from under the community.

This is precisely the **counterpoint** to the relicensing dramas covered in the
sibling docs:

- **MongoDB** relicensed its server from AGPL to the **SSPL** in 2018,
  explicitly to constrain cloud providers from offering it as a managed service
  — see [`mongodb.md`](./mongodb.md). MongoDB *could* do this because a single
  company (MongoDB, Inc., née 10gen) owned the copyright.
- **Redis** moved off the permissive 3-clause BSD to a dual SSPL/RSAL (and
  related source-available) arrangement in 2024 — see [`redis.md`](./redis.md) —
  again possible only because one company controlled the copyright.

PostgreSQL's structure makes such a move impossible by construction, and that
guarantee is *why* a vast commercial ecosystem (EDB, Citus, Greenplum, Aurora,
Supabase, Neon, Crunchy, Timescale, Yugabyte, CockroachDB, and more) could be
built on it without fear of a future relicensing. The PGDG's own statement —
"no plans to change the PostgreSQL License" — is the load-bearing promise that
the ecosystem relies on.
- Source (license-permanence statement): PostgreSQL License,
  <https://www.postgresql.org/about/licence/>
- Note: the causal claim "permissive license → ecosystem could build safely" is
  an interpretation; it is grounded in the PGDG's stated license-permanence and
  in the contrast with the MongoDB/Redis relicensing events documented in the
  sibling files, rather than asserted by a single citation.

---

## The commercial ecosystem & the acquisition wave

A non-exhaustive map of companies and products built on or derived from
PostgreSQL, with primary/reputable sources:

| Player | Relationship to Postgres | Key event | Source |
|---|---|---|---|
| **EnterpriseDB / EDB** | Oracle-compatible Postgres distro + support; major contributor | Founded 2004; acquired 2ndQuadrant in 2020 | [Wikipedia](https://en.wikipedia.org/wiki/EnterpriseDB); [EDB PR](https://www.enterprisedb.com/press-releases/edb-completes-acquisition-2ndquadrant-becomes-largest-dedicated-provider-postgresql) |
| **2ndQuadrant** | Postgres consultancy (Simon Riggs) | Founded by Riggs; acquired by EDB 2020 | [Core Team statement](https://www.postgresql.org/about/news/statement-from-the-postgresql-core-team-on-the-edb-acquisition-of-2ndquadrant-2094/) |
| **Greenplum** | Postgres-based MPP warehouse | 2005 → EMC (2010) → Pivotal (2012) → VMware (2019/2020) | [Wikipedia](https://en.wikipedia.org/wiki/Greenplum) |
| **Amazon Redshift** | Fork of ParAccel, itself a fork of Postgres 8.0.2 | Preview 2012, GA Feb 2013 | [Wikipedia](https://en.wikipedia.org/wiki/Amazon_Redshift); [AWS docs](https://docs.aws.amazon.com/redshift/latest/dg/c_redshift-and-postgres-sql.html) |
| **Amazon RDS / Aurora Postgres** | Managed real PostgreSQL | RDS Nov 2013; Aurora Postgres Oct 2017 | [AWS What's New](https://aws.amazon.com/about-aws/whats-new/2013/11/14/announcing-amazon-rds-for-postgresql/); [Aurora Wikipedia](https://en.wikipedia.org/wiki/Amazon_Aurora) |
| **Citus Data** | Distributed-Postgres extension | Founded 2011; acquired by Microsoft Jan 24, 2019 | [Microsoft blog](https://blogs.microsoft.com/blog/2019/01/24/microsoft-acquires-citus-data-re-affirming-its-commitment-to-open-source-and-accelerating-azure-postgresql-performance-and-scale/) |
| **Timescale (Tiger Data)** | Time-series Postgres extension | Founded Apr 2017 | [Wikipedia](https://en.wikipedia.org/wiki/TimescaleDB) |
| **YugabyteDB** | Reuses Postgres query layer over distributed storage (DocDB) | Postgres-compatible distributed SQL | [Yugabyte](https://www.yugabyte.com/postgresql/compare-postgresql-compatibility/) |
| **CockroachDB** | PostgreSQL **wire-compatible** (not a fork) | Postgres wire protocol compatibility | [Cockroach Labs](https://www.cockroachlabs.com/compare/yugabyte-vs-cockroachdb/) |
| **Supabase** | "Open-source Firebase alternative" on Postgres | Launched 2020; $6M round Dec 2020 | [TechCrunch](https://techcrunch.com/2020/12/15/supabase-raises-6m-for-its-open-source-firebase-alternative/) |
| **Neon** | Serverless Postgres | Founded 2021; acquired by Databricks ~$1B, May 2025 | [Databricks PR](https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems); [TechCrunch](https://techcrunch.com/2025/05/14/databricks-to-buy-open-source-database-startup-neon-for-1b/) |
| **Crunchy Data** | Enterprise Postgres + Kubernetes operator | Founded 2012; acquired by Snowflake ~$250M, Jun 2025 | [Crunchy blog](https://www.crunchydata.com/blog/crunchy-data-joins-snowflake); [TechCrunch](https://techcrunch.com/2025/06/02/snowflake-to-acquire-database-startup-crunchy-data/) |

### The 2024–2025 "Postgres won" acquisition wave

The framing that "**Postgres is eating the database world**" (Vonng, Oct 2024;
see <https://pigsty.io/blog/pg/pg-eat-db-world/>) was given hard corporate
validation in 2025 when **two data-cloud giants each bought a Postgres company
within roughly three weeks**, both explicitly tying the move to AI/agentic
workloads:

1. **Databricks → Neon** (~$1B, announced May 14, 2025) — serverless Postgres,
   pitched as the database AI agents provision on the fly (>80% of Neon DBs
   created by agents).
2. **Snowflake → Crunchy Data** (~$250M, announced Jun 2, 2025) — enterprise
   Postgres to become "Snowflake Postgres."

Combined with Microsoft's 2019 Citus acquisition and EDB's 2020 2ndQuadrant
acquisition, the pattern is unmistakable: the Postgres *ecosystem* consolidated
into the major clouds and data platforms, while the *core* — by license and
governance — stayed community-owned and un-buyable.

---

## The AI era (pgvector)

- **pgvector** — created by **Andrew Kane** — is an open-source PostgreSQL
  extension that adds a **`vector` type** plus similarity search (L2/Euclidean,
  cosine, inner product) and approximate-nearest-neighbor indexes (IVFFlat and,
  later, HNSW). It lets developers store **embeddings** alongside relational
  data and run **retrieval-augmented generation (RAG)** and semantic search
  **without a separate vector database.**
  - Source: Pgvector — Grokipedia, <https://grokipedia.com/page/Pgvector>
  - Source (Databricks explainer): "What is pgvector?",
    <https://www.databricks.com/blog/what-is-pgvector>
- First release: reported as **April 20, 2021** (secondary source).
  - Source: <https://grokipedia.com/page/Pgvector>
  - Could not verify the exact first-release date against the pgvector GitHub
    release history in this pass.
- **Why it mattered (2023–2025):** as LLMs drove demand for embedding storage,
  pgvector let teams reuse their existing Postgres rather than adopting a
  dedicated vector DB. It became "a widely used vector search solution in
  production environments, powering RAG systems, recommendation engines, and
  semantic search," and is a first-class building block in frameworks like
  LangChain.
  - Source (opinion/usage): Pgvector — Grokipedia,
    <https://grokipedia.com/page/Pgvector>
- This is the technical engine under the 2025 acquisitions: both Databricks
  (Neon) and Snowflake (Crunchy) framed their purchases around **AI/agentic**
  Postgres — and pgvector is the feature that made "Postgres as the AI database"
  a credible pitch.
  - Source (AI-agent framing): Databricks press release,
    <https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems>

---

## Current status (as of 2026)

- PostgreSQL remains a **community-governed** project under the **PGDG/Core
  Team** and the permissive **PostgreSQL License**, with no owning company and
  no relicensing on the table.
  - Source: PostgreSQL Governance,
    <https://www.postgresql.org/about/governance/>
  - Source: PostgreSQL License, <https://www.postgresql.org/about/licence/>
- It has repeatedly topped the **Stack Overflow Developer Survey** as the
  most-used database (first overtaking MySQL in 2023), and won DB-Engines
  "Database of the Year" multiple times — the empirical backbone of the
  "Postgres won" narrative.
  - Source (opinion/aggregation): LeadDev, "PostgreSQL: the database that
    quietly ate the world,"
    <https://leaddev.com/technical-direction/postgresql-database-quietly-ate-world>
  - Source (opinion/aggregation): Vonng, "PostgreSQL Has Dominated the Database
    World," <https://vonng.com/en/pg/so2025-pg/>
  - Could not independently verify each year's Stack Overflow / DB-Engines
    ranking from the primary survey pages in this pass; the dominance claim is
    attributed to the secondary analyses above.
- The commercial ecosystem is now anchored inside the major data clouds
  (Microsoft/Citus, AWS/RDS+Aurora, Databricks/Neon, Snowflake/Crunchy) plus
  independent vendors (EDB, Supabase, Timescale/Tiger, Yugabyte, Cockroach),
  while the core stays un-buyable — the defining structural feature of the
  Postgres story.

---

## Summary of "could not verify" items

- Exact founding month/day of **Relational Technology, Inc.** (1980).
- Primary-source **release date of PostgreSQL 9.2** (the `json` type, "2012"
  per secondary sources).
- Exact **pgvector first-release date** ("April 20, 2021" per a secondary
  source; not confirmed against GitHub tags).
- A **single primary source** naming all three **Neon co-founders** together
  (Shamgunov as CEO is confirmed).
- The **exact ~$1B Neon** and **~$250M Crunchy** prices are from press reports
  (TechCrunch); the official press releases did not disclose figures.
- **Per-year Stack Overflow / DB-Engines rankings** were taken from secondary
  analyses, not the primary survey pages.
- An exhaustive, individually-cited **feature-by-feature attribution** for every
  named contributor beyond the official contributor profiles and release notes.
