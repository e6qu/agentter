# DuckDB: A Sourced History

This is a chronological, fully-sourced history of **DuckDB** — the in-process
analytical (OLAP) database created at **CWI** in Amsterdam — together with the
organizations around it: the **DuckDB Foundation** (the non-profit that holds the
IP), **DuckDB Labs** (the creators' company), and **MotherDuck** (the commercial
cloud company built on DuckDB).

DuckDB is frequently described as "the **SQLite for analytics**." For the history
of SQLite itself — the in-process OLTP database whose embedding model DuckDB
deliberately copied — see [`sqlite.md`](./sqlite.md) (cross-referenced here, not
duplicated). For the object-storage / S3 / Parquet ecosystem that DuckDB queries
"in place," see [`s3-object-storage.md`](./s3-object-storage.md).

Every factual claim below carries an inline source. Where a claim could not be
pinned to a primary source it is marked **"Could not verify."** Opinions are
attributed to the person or outlet that expressed them.

---

## Timeline

### 2004–2010 — The CWI vectorized-execution lineage (prehistory)

DuckDB did not appear from nowhere; it sits at the end of two decades of
column-store and vectorized-execution research in the **Database Architectures**
group at **Centrum Wiskunde & Informatica (CWI)**, the Dutch national research
institute for mathematics and computer science in Amsterdam. (CWI is also where
**Guido van Rossum** created **Python** — see CWI's own history pages.)
- CWI on its role as the birthplace of Python:
  https://web.archive.org/web/2id_/https://www.cwi.nl/en/news/cwi-and-the-birth-of-python/

CWI researcher **Peter Boncz** designed **MonetDB**, one of the first relational
column-store systems, and in 2004 started the **MonetDB/X100** project that
introduced **vectorized processing** — operators executed not on individual rows
but on small columnar blocks ("vectors"). X100 was later commercialized as
**VectorWise** (acquired by Actian in 2010).
- Peter Boncz, Wikipedia (MonetDB, X100, VectorWise, and the note that
  Boncz's group members Mühleisen and Raasveldt later launched DuckDB,
  "which incorporates ideas from MonetDB, VectorWise and Hyper"):
  https://en.wikipedia.org/wiki/Peter_Boncz
- MonetDB/X100: Hyper-Pipelining Query Execution (Boncz, Zukowski, Nes), CIDR 2005:
  https://www.cidrdb.org/cidr2005/papers/P19.pdf

DuckDB's columnar-vectorized engine is directly inspired by this line of work;
Boncz sits on the DuckDB Foundation board (see governance section below).

### ~2018 — Development begins at CWI

DuckDB was started by **Mark Raasveldt** (then a PhD student) and **Hannes
Mühleisen** in CWI's Database Architectures group. In CWI's own retrospective,
Mühleisen states: **"So we set out to develop a prototype in 2018."**
- CWI story, "DuckDB: introducing a new class of data management systems"
  (quotes the 2018 prototype start and the 2021 spin-off decision):
  https://www.cwi.nl/en/stories/duckdb-introducing-a-new-class-of-data-management-systems/

The goal was a database that filled an empty quadrant: **in-process** (embedded,
like SQLite) **+ OLAP** (analytical), as opposed to in-process OLTP (SQLite) or
client/server OLAP (warehouses). Mühleisen frames it as enabling "analyses on a
single laptop, which previously required dozens or even hundreds of computers."
- Same CWI story:
  https://www.cwi.nl/en/stories/duckdb-introducing-a-new-class-of-data-management-systems/

**The name.** DuckDB is named after Mühleisen's late pet duck, **Wilbur**.
Mühleisen: "DuckDB got its name because I used to have a pet duck. Ducks are
amazing animals. They can fly, walk and swim, and they are quite resilient to
environmental challenges. So, they are the perfect mascot for a versatile and
resilient data management system." The duck-versatility framing also appears
verbatim in the official FAQ.
- Origin-story write-up quoting Mühleisen ("DuckDB comes from my late pet duck
  Wilbur"): https://www.stacksync.com/blog/named-after-a-real-duck-the-origin-story-of-duckdb
- DuckDB FAQ ("Ducks are amazing animals. They can fly, walk and swim..."):
  https://duckdb.org/faq

### 2019-06 — First public release and the SIGMOD demo paper

The first tagged public release, **v0.1.0**, was published on **2019-06-27** on
GitHub. (Verified against the GitHub releases API; v0.1.0 is the earliest tag,
followed by v0.1.1 on 2019-09-24.)
- GitHub release tag dates verified via `gh api repos/duckdb/duckdb/releases`
  (v0.1.0 = 2019-06-27): https://github.com/duckdb/duckdb/releases

The system was introduced academically as a **demo paper at SIGMOD 2019**:
**"DuckDB: an Embeddable Analytical Database,"** Mark Raasveldt and Hannes
Mühleisen, *Proceedings of the 2019 International Conference on Management of
Data*, pp. 1981–1984 (SIGMOD '19 was held in Amsterdam).
- ACM DL: https://dl.acm.org/doi/abs/10.1145/3299869.3320212
- Author PDF: https://mytherin.github.io/papers/2019-duckdbdemo.pdf

The paper pitches DuckDB for the **"embedded analytics"** scenario — running
analytical SQL inside another process (e.g., a Python or R session) rather than
talking to a separate database server.

### What DuckDB is (the design, in its own words)

DuckDB's own "Why DuckDB" page describes it as a relational SQL DBMS with
**"embedded in-process operation"** explicitly modeled on SQLite's success
("Simplicity in installation, and embedded in-process operation are central to
its [SQLite's] success. DuckDB adopted the ideas of simplicity and in-process
operation"). It uses **"a columnar-vectorized query execution engine ... a large
batch of values (a 'vector') are processed in one operation,"** targeting
**"analytical query workloads, also known as online analytical processing
(OLAP)."**
- https://duckdb.org/why_duckdb

It can query data **in place** — Parquet, CSV, JSON, and Pandas data frames —
"without ever importing or copying any data," and over protocols including
**"HTTP(S) and S3."** (For the S3/object-storage and Parquet ecosystem DuckDB
reads from, see [`s3-object-storage.md`](./s3-object-storage.md).) It is released
under the **"very permissive MIT License."**
- Same page: https://duckdb.org/why_duckdb

The standard one-line framing — **"DuckDB is the SQLite for analytics"** —
captures the contrast: SQLite is an in-process **OLTP** (transactional)
engine optimized for many small row-oriented reads/writes; DuckDB is an
in-process **OLAP** (analytical) engine optimized for scanning and aggregating
large columnar datasets. Both deliberately reject the client/server model. For
SQLite's own history and the embedding model DuckDB borrowed, see
[`sqlite.md`](./sqlite.md). (Could not verify a single canonical source where the
DuckDB team itself prints the exact slogan "the SQLite for analytics"; the
phrasing is widespread in press and community materials, and the team's own FAQ
and "Why DuckDB" page make the SQLite analogy explicitly without using that exact
five-word slogan.)

### 2021-07-14 — DuckDB Labs spins out of CWI

In summer 2021 the creators founded **DuckDB Labs B.V.** as a spin-off company
from CWI, located near CWI in Amsterdam Science Park, still led by Mühleisen and
Raasveldt. CWI's own announcement is dated **2021-07-14**: "DuckDB will still
continue to be an Open-Source project under the current permissive MIT licence,"
and DuckDB Labs would "act as the environment for innovative projects around
DuckDB ... as well as a platform for support services."
- CWI announcement (2021-07-14):
  https://www.cwi.nl/en/news/cwi-spin-off-company-duckdb-labs-provides-solutions-for-fast-database-analytics/
- DuckDB Labs' own announcement (same date):
  https://duckdblabs.com/news/2021/07/14/spin-off-company-DuckDB-Labs

CWI quotes Mühleisen on the strategy of keeping the company small: "Our idea is
to keep DuckDB Labs small and artisanal, but incubate a separate company where
venture capitalists can invest in and that will quickly grow" — foreshadowing
MotherDuck.
- https://www.cwi.nl/en/news/cwi-spin-off-duckdb-labs-partners-with-motherduck-who-raises-47-5-million-1/

### ~2021 — The DuckDB Foundation is established

To keep the open-source project independent of the commercial entity, **most of
the DuckDB intellectual property was moved to the non-profit DuckDB Foundation**
(legally **"Stichting DuckDB Foundation," incorporated in the Netherlands**).
Its statutes ensure DuckDB **remains open-source under the MIT license in
perpetuity**, and it is funded by **charitable donations** (tiered Silver
10,000 EUR+ / Gold 100,000 EUR+ sponsorships) rather than venture capital. The
foundation board is **Hannes Mühleisen, Mark Raasveldt, and Peter Boncz**.
- DuckDB Foundation site (https://duckdb.org/foundation/ → redirects to
  https://duckdb.foundation/): "Stichting DuckDB Foundation is incorporated in
  the Netherlands"; "The foundation holds most of the intellectual property of
  the project"; board listing.
- DuckDB FAQ ("a non-profit organization that holds the intellectual property of
  the DuckDB project" and ensures it "remains open-source under the MIT license
  in perpetuity"): https://duckdb.org/faq

**Could not verify** the exact incorporation date/year of the Stichting from a
primary source — neither the foundation page nor the FAQ states it. Secondary
sources commonly place it around 2021; treat the year as approximate until the
deed of incorporation or a dated primary source is found.

### 2022-04 — MotherDuck is founded

**MotherDuck** — the commercial cloud company built on DuckDB — began in
**April 2022**, founded by **Jordan Tigani**, a **founding engineer on Google
BigQuery** (and previously chief product officer at SingleStore). Press reporting
(GeekWire) places the company's start in April 2022; **Tino Tereshko**, also a
BigQuery veteran, was the first to join.
- GeekWire ("MotherDuck began in April 2022"; Tigani BigQuery / SingleStore
  background; Tereshko as first hire):
  https://www.geekwire.com/2022/seattle-data-analytics-startup-motherduck-emerges-from-stealth-reveals-47-5m-in-funding/
- MotherDuck "About" page: https://motherduck.com/about-us/

(Tino Tereshko's specific title/co-founder status is described in press as the
first to join the team / a BigQuery veteran; **could not verify** a primary
MotherDuck page that lists the full founding-team roster with titles.)

### 2022-11-15 — MotherDuck emerges from stealth: $47.5M, and the DuckDB Labs partnership

On **2022-11-15**, MotherDuck emerged from stealth with **$47.5M total funding**:
a **$35M Series A led by Andreessen Horowitz (a16z)**, following a **$12.5M seed
led by Redpoint Ventures**, at a **$175M valuation**. Other backers named:
Amplify Partners, Madrona, Altimeter, SV Angel.
- PR Newswire ("MotherDuck Raises $47.5 Million at $175M Valuation"; seed
  "$12.5 million led by Redpoint," Series A "$35 million led by Andreessen
  Horowitz," total $47.5M):
  https://www.prnewswire.com/news-releases/motherduck-raises-47-5-million-at-175m-valuation-301678657.html
- TechCrunch: https://techcrunch.com/2022/11/15/motherduck-secures-investment-from-andreessen-horowitz-to-commercialize-duckdb/
- GeekWire: https://www.geekwire.com/2022/seattle-data-analytics-startup-motherduck-emerges-from-stealth-reveals-47-5m-in-funding/

> **Note on the figure.** The brief said "~$47.5M Series A." More precisely:
> $47.5M is the **total to date** ($12.5M seed + $35M Series A), not a single
> Series A round. Source: PR Newswire release above.

The same day, **DuckDB Labs announced a long-term strategic partnership with
MotherDuck**. Per CWI's coverage, **DuckDB Labs acquired shares in MotherDuck**,
and MotherDuck began supporting the DuckDB Foundation. Mühleisen — who combines a
tenured CWI research position with the **CEO role at DuckDB Labs** — said: "We
look forward to the continued growth and adoption that partnering with MotherDuck
will bring."
- DuckDB Labs partnership post (2022-11-15):
  https://duckdblabs.com/news/2022/11/15/motherduck-partnership
- CWI coverage (DuckDB Labs acquired shares; Mühleisen CWI + DuckDB Labs CEO):
  https://www.cwi.nl/en/news/cwi-spin-off-duckdb-labs-partners-with-motherduck-who-raises-47-5-million-1/

This structure is deliberate: the **non-profit Foundation** holds the IP and
guarantees MIT-licensing; **DuckDB Labs** (small, no VC) does core development and
support; **MotherDuck** (VC-funded) commercializes a cloud product — and DuckDB
Labs' equity stake aligns the three. MotherDuck has publicly stated it will
**not fork DuckDB**.
- The New Stack, "Why MotherDuck refuses to fork DuckDB":
  https://thenewstack.io/motherduck-duckdb-mcp-collaboration/

### 2023-02-07 — Jordan Tigani's "Big Data is Dead" essay

On **2023-02-07**, Tigani published **"Big Data is Dead"** on the MotherDuck blog.
Its thesis, in his framing: data sizes grew, but **hardware grew faster**, and —
crucially — **the data actually touched by analytics queries is small** (typically
a recent hot slice), even when total stored data is large. Coming from a BigQuery
founding engineer who had spent years telling conferences how to handle massive
data growth, the essay became a manifesto for the "small data" / local-first
analytics movement that DuckDB rode.
- Essay (MotherDuck blog): https://motherduck.com/blog/big-data-is-dead/
- Anna Geller's summary (corroborates date 2023-02-07 and argument):
  https://www.annageller.com/p/summary-big-data-is-dead-by-jordan-tigani

Tigani (attributed opinion, from the funding release): "The fact is, 'Big Data'
is dead; the simplicity and the ease of making sense of your data is a lot more
important."
- https://www.prnewswire.com/news-releases/motherduck-raises-47-5-million-at-175m-valuation-301678657.html

(Note: the essay reproduces an investor survey figure — that ~100 GB is the right
order of magnitude for a data-warehouse size for many companies — which is an
**investor/portfolio anecdote**, not an independently verified statistic. Treat
as a claim in the essay, attributed to MotherDuck/its investors.)

### The movement — "analytics on your laptop" / small data / embedded analytics

DuckDB's rise is inseparable from a broader shift: instead of shipping data to a
distributed warehouse, run analytics **in-process on a single machine** — laptops
now have enough RAM/CPU for the small hot slice most queries touch. CWI's own
materials note DuckDB reaching **two million downloads a month within two years**.
- CWI story (two million downloads/month within two years):
  https://www.cwi.nl/en/stories/duckdb-introducing-a-new-class-of-data-management-systems/

DuckDB spread as an **embeddable engine inside other tools** — Python and R
bindings, dbt (dbt-duckdb), and a large ecosystem — because of the same in-process
design that makes SQLite ubiquitous (see [`sqlite.md`](./sqlite.md)). It is
commonly used to query **Parquet/CSV/JSON on S3 in place** (see
[`s3-object-storage.md`](./s3-object-storage.md)). (Specific third-party tool
integrations are widely documented but vary; treat individual tool claims as
needing per-tool sourcing.)

### 2023-06 — MotherDuck private preview; 2023-09 Series B

MotherDuck opened a **private preview in June 2023** and removed its waitlist in
September 2023 (reporting >2,000 users at the time of the Series B).
- GeekWire (Series B coverage, mentions June preview and waitlist removal):
  https://www.geekwire.com/2023/seattle-startup-motherduck-raises-52-5m-at-a-400m-valuation-to-fuel-duckdb-analytics-platform/

On **2023-09-20**, MotherDuck announced a **$52.5M Series B led by Felicis**, at
a **$400M post-money valuation**, bringing **total funding to $100M**.
Participants included a16z, Madrona, Amplify, Altimeter, Redpoint, Zero Prime.
Felicis GP **Viviana Faga** joined the board.
- PR Newswire ("MotherDuck Raises $52.5 Million Series B Funding as DuckDB
  Adoption Soars"):
  https://www.prnewswire.com/news-releases/motherduck-raises-52-5-million-series-b-funding-as-duckdb-adoption-soars-301932741.html
- TechCrunch: https://techcrunch.com/2023/09/20/database-startup-motherduck-lands-52-5m-to-grow-its-duckdb-based-platform/
- GeekWire ($52.5M, $400M valuation, Felicis lead):
  https://www.geekwire.com/2023/seattle-startup-motherduck-raises-52-5m-at-a-400m-valuation-to-fuel-duckdb-analytics-platform/

### 2024-06-03 — DuckDB 1.0.0 ("Snow Duck")

DuckDB reached **1.0.0** on **2024-06-03**, codename **"Snow Duck"** (*anas
nivis*). The release's headline is **stability**, especially a **backward-
compatible storage format**: "DuckDB files created with DuckDB 1.0.0 will be
compatible with future DuckDB versions." The team's framing: "version 1.0.0
means something else for a data management system than it means for an egg timer
app," backed by "thousands of test cases with millions of test queries being run
every night."
- DuckDB blog, "Announcing DuckDB 1.0.0" (2024-06-03):
  https://duckdb.org/2024/06/03/announcing-duckdb-100.html

### 2024-06 — MotherDuck General Availability

MotherDuck announced **general availability** of its serverless cloud data
warehouse in **June 2024** (after the ~year-long private preview), adding
ecosystem integrations (Tableau, Power BI, Fivetran, Monte Carlo).
- PR Newswire ("MotherDuck Announces General Availability..."):
  https://www.prnewswire.com/news-releases/motherduck-announces-general-availability-brings-simplicity-and-power-of-duckdb-in-a-serverless-data-warehouse-302168749.html
- MotherDuck blog (GA announcement):
  https://motherduck.com/blog/announcing-motherduck-general-availability-data-warehousing-with-duckdb/

### 2024-11-26 — MotherDuck/DuckDB MCP server (the AI angle)

MotherDuck released an **open-source DuckDB MCP (Model Context Protocol) server**
on **2024-11-26**, among the first MCP servers in the ecosystem, letting AI
assistants/agents run DuckDB SQL against local files, in-memory/S3 databases, and
MotherDuck. (A **remote** MCP server followed in late 2025.)
- MotherDuck MCP product page: https://motherduck.com/product/mcp-server/
- GitHub: https://github.com/motherduckdb/mcp-server-motherduck
- (Specific 2024-11-26 / late-2025 remote dates: drawn from MotherDuck materials
  and reporting; the exact 2024-11-26 release date should be confirmed against
  the GitHub release/commit history before treating as load-bearing —
  **partially verify**.)

### 2025-05-27 — DuckLake (SQL-based lakehouse format)

On **2025-05-27**, DuckDB announced **DuckLake**, a lakehouse format that
**"simplifies lakehouses by using a standard SQL database for all metadata,
instead of complex file-based systems, while still storing data in open formats
like Parquet."** It positions an SQL catalog as an alternative to file-based
metadata layers used by formats like Iceberg/Delta.
- DuckDB blog, DuckLake announcement (2025-05-27):
  https://duckdb.org/2025/05/27/ducklake.html

### Post-1.0 releases (selected)

Subsequent named releases include **1.1.0** (Sept 2024), **1.2.0** (Feb 2025),
**1.3.0** (May 2025), and **1.4.0** (Sept 2025, an LTS release). DuckDB uses duck
species as codenames.
- Per the Wikipedia DuckDB version table:
  https://en.wikipedia.org/wiki/DuckDB
- **Could not verify** each individual post-1.0 release date and codename against
  the corresponding DuckDB blog post in this pass; the Wikipedia table is the
  source above and individual blog posts at https://duckdb.org/news/ should be
  used to confirm specific dates/codenames before treating them as load-bearing.
  (Some codenames in secondary tables looked inconsistent with DuckDB's
  duck-species convention and were not reproduced here without a primary source.)

### Current status (as of this writing, 2026)

DuckDB is an established, widely-adopted in-process analytical database under the
MIT license, governed by the DuckDB Foundation, developed by DuckDB Labs, and
commercialized in the cloud by MotherDuck — with the "small data" / local-first
analytics thesis and an increasingly **AI/agent** orientation (MCP, DuckLake for
agentic lakehouse workloads).
- MotherDuck on AI/lakehouse positioning:
  https://motherduck.com/blog/dont-fear-the-agents-ai-on-the-data-lakehouse/

---

## Key people & teams

- **Mark Raasveldt** — co-creator of DuckDB (originally as a CWI PhD student),
  co-founder of DuckDB Labs, DuckDB Foundation board member. Lead author of the
  SIGMOD 2019 demo paper.
  - Personal site: https://mytherin.github.io/
  - SIGMOD paper: https://mytherin.github.io/papers/2019-duckdbdemo.pdf
- **Hannes Mühleisen** — co-creator of DuckDB, **CEO of DuckDB Labs**, tenured CWI
  researcher, DuckDB Foundation board member; the name "DuckDB" comes from his
  pet duck Wilbur.
  - Personal site: https://hannes.muehleisen.org/
  - CWI partnership coverage (Mühleisen CWI + DuckDB Labs CEO):
    https://www.cwi.nl/en/news/cwi-spin-off-duckdb-labs-partners-with-motherduck-who-raises-47-5-million-1/
- **Peter Boncz** — senior CWI researcher; architect of MonetDB and MonetDB/X100
  (vectorized execution), the intellectual lineage behind DuckDB's engine; DuckDB
  Foundation board member.
  - https://en.wikipedia.org/wiki/Peter_Boncz
  - DuckDB Foundation board: https://duckdb.foundation/
- **Jordan Tigani** — co-founder & CEO of MotherDuck; founding engineer on Google
  **BigQuery**; author of "Big Data is Dead."
  - https://motherduck.com/blog/big-data-is-dead/
  - https://www.geekwire.com/2022/seattle-data-analytics-startup-motherduck-emerges-from-stealth-reveals-47-5m-in-funding/
- **Tino Tereshko** — BigQuery veteran; described in press as the first to join
  MotherDuck. (Exact title/co-founder status: could not verify from a primary
  MotherDuck source.)
  - https://www.geekwire.com/2022/seattle-data-analytics-startup-motherduck-emerges-from-stealth-reveals-47-5m-in-funding/
- **CWI Database Architectures group** — the research home (MonetDB → X100 →
  VectorWise → DuckDB). CWI is also the birthplace of Python.
  - https://www.cwi.nl/en/stories/duckdb-introducing-a-new-class-of-data-management-systems/

---

## Company & corporate history (DuckDB Labs, Foundation, MotherDuck)

The DuckDB world is deliberately split into three legally distinct entities, an
arrangement designed to keep the open-source project independent of venture
capital while still allowing a VC-funded company to commercialize it:

1. **DuckDB Foundation** — *Stichting DuckDB Foundation*, a Dutch **non-profit**
   that **holds most of DuckDB's intellectual property** and guarantees, via its
   statutes, that DuckDB stays **open-source under the MIT license in perpetuity**.
   Funded by charitable donations (not VC). Board: Mühleisen, Raasveldt, Boncz.
   - https://duckdb.foundation/ · https://duckdb.org/faq
   - *Could not verify* the exact incorporation year (commonly cited as ~2021).

2. **DuckDB Labs** — the **company founded by the creators**, spun out of CWI on
   **2021-07-14**, providing **core development and commercial support / feature
   prioritization** for DuckDB. Deliberately kept small and **not VC-funded**;
   Mühleisen is CEO. DuckDB Labs holds **equity in MotherDuck**.
   - https://www.cwi.nl/en/news/cwi-spin-off-company-duckdb-labs-provides-solutions-for-fast-database-analytics/
   - https://duckdblabs.com/news/2022/11/15/motherduck-partnership

3. **MotherDuck** — the **VC-funded commercial cloud company** (Seattle), founded
   **April 2022** by **Jordan Tigani** (and team incl. Tino Tereshko), building a
   **serverless cloud data warehouse on DuckDB**. It does **not fork** DuckDB and
   partners with / supports DuckDB Labs and the Foundation.
   - Founding & stealth exit (2022-11-15): https://www.geekwire.com/2022/seattle-data-analytics-startup-motherduck-emerges-from-stealth-reveals-47-5m-in-funding/

**MotherDuck funding summary (verified):**

| Round | Amount | Lead | Valuation | Date | Source |
|---|---|---|---|---|---|
| Seed | $12.5M | Redpoint Ventures | — | (announced 2022-11-15) | [PR Newswire](https://www.prnewswire.com/news-releases/motherduck-raises-47-5-million-at-175m-valuation-301678657.html) |
| Series A | $35M | Andreessen Horowitz (a16z) | $175M (total $47.5M to date) | 2022-11-15 | [PR Newswire](https://www.prnewswire.com/news-releases/motherduck-raises-47-5-million-at-175m-valuation-301678657.html) |
| Series B | $52.5M | Felicis | $400M post-money (total $100M to date) | 2023-09-20 | [PR Newswire](https://www.prnewswire.com/news-releases/motherduck-raises-52-5-million-series-b-funding-as-duckdb-adoption-soars-301932741.html) |

> The brief described "~$47.5M Series A (2022/2023, a16z/Redpoint)." Corrected
> above: $47.5M was the **total** at stealth-exit ($12.5M Redpoint seed + $35M
> a16z Series A), both announced 2022-11-15; the Series B ($52.5M, Felicis,
> $400M) was 2023-09-20. Any post-Series-B raises are not covered here and were
> not verified.

---

## Cross-references (not duplicated here)

- **[`sqlite.md`](./sqlite.md)** — SQLite, the in-process OLTP database whose
  embedding/in-process model DuckDB explicitly adopted ("DuckDB is the SQLite for
  analytics"). *(Note: at the time of writing, this sibling file may not yet
  exist in the repo; the link anticipates it.)*
- **[`s3-object-storage.md`](./s3-object-storage.md)** — S3 and the
  object-storage / Parquet ecosystem DuckDB queries "in place" over httpfs/S3.

---

## Could not verify (open items)

- **Exact incorporation date/year of the DuckDB Foundation (Stichting).** Neither
  the foundation page nor the FAQ states it; ~2021 is a common secondary claim.
- **A single canonical DuckDB-authored source printing the exact slogan "the
  SQLite for analytics."** The SQLite-for-analytics *analogy* is explicit in
  DuckDB's own docs, but the exact five-word slogan is mostly press/community.
- **Tino Tereshko's precise title / co-founder status** from a primary MotherDuck
  source (press says "first to join" / BigQuery veteran).
- **Per-release dates and codenames for DuckDB 1.1–1.4** against their individual
  DuckDB blog posts (only the Wikipedia table was checked this pass).
- **The exact 2024-11-26 MCP server release date** against GitHub history (taken
  from MotherDuck materials/reporting).
- **Any MotherDuck funding after the 2023 Series B**, and current valuation —
  not researched here.
