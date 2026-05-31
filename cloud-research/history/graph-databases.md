# Graph Databases and RDF Triple Stores: A Sourced History

A chronological, fully-sourced survey of two intertwined lineages: **RDF /
semantic-web triple stores** (rooted in W3C standards, ~1999 onward) and
**property-graph databases** (Neo4j and its successors, ~2000 onward), through
the modern knowledge-graph and GraphRAG revival (2012–2025).

Every non-trivial claim links to a primary or reputable source. Where a fact
could not be confirmed, it is explicitly flagged **"Could not verify."**
Opinions are attributed to their source.

This document deliberately does **not** re-tell the broader NoSQL story — see
the sibling doc `history/mongodb.md` for the NoSQL era (10gen/MongoDB, the
document-store wave, SSPL relicensing, etc.). Graph databases are commonly
grouped under the NoSQL umbrella, but their intellectual roots (graph theory,
the semantic web) and their query-language standardization arc (GQL) are
distinct enough to warrant separate treatment.

---

## Two lineages at a glance

There are two largely separate technical traditions, with different data
models, query languages, and communities:

1. **RDF / triple stores** — store data as **subject–predicate–object
   triples**, query with **SPARQL**, governed by **W3C** standards (RDF, RDFS,
   OWL, SPARQL). Grew out of Tim Berners-Lee's *Semantic Web* vision.
   - Source (triple data model): Resource Description Framework — Wikipedia,
     <https://en.wikipedia.org/wiki/Resource_Description_Framework>

2. **Property graphs** — store **nodes and edges with arbitrary key/value
   properties**, query with **Cypher** / **Gremlin** / (now) **GQL**. Grew out
   of practical engineering frustration with SQL joins (Neo4j's origin story).
   - Source (property-graph model and Cypher's role): Cypher (query language) —
     Wikipedia, <https://en.wikipedia.org/wiki/Cypher_(query_language)>

Many modern systems straddle both (e.g. Amazon Neptune supports RDF/SPARQL
**and** property-graph/Gremlin/openCypher).
- Source: Amazon Neptune — Wikipedia,
  <https://en.wikipedia.org/wiki/Amazon_Neptune>

---

## Master timeline

| Year | Event | Source |
|------|-------|--------|
| 1997 | Meta Content Framework (MCF) work by R.V. Guha (Apple) and Tim Bray (Netscape) — a precursor that shaped RDF | <https://en.wikipedia.org/wiki/Resource_Description_Framework> |
| 1998 | Virtuoso engine first unveiled (OpenLink Software) | <https://vos.openlinksw.com/owiki/wiki/VOS/VOSHistory> |
| **1999** | **W3C publishes the first RDF Recommendation** ("RDF Model and Syntax Specification") | <https://en.wikipedia.org/wiki/Resource_Description_Framework> |
| 2000 | Emil Eifrem's "napkin sketch" of the graph model (flight, 2000) — Neo4j conception | <https://en.wikipedia.org/wiki/Neo4j> |
| ~2000 | Ontotext founded (Sofia, Bulgaria) within Sirma Group | <https://en.wikipedia.org/wiki/Ontotext_GraphDB> |
| 2001 | Jena (RDF framework) on SourceForge (HP Labs) | <https://en.wikipedia.org/wiki/Apache_Jena> |
| ~2002 | Sesame (later RDF4J) created by Aduna (NL), via the On-To-Knowledge project (1999–2002) | <https://en.wikipedia.org/wiki/RDF4J> |
| 2004 | **RDF 1.0** — revised RDF spec (set of six W3C Recommendations) replaces the 1999 spec | <https://en.wikipedia.org/wiki/Resource_Description_Framework> |
| 2004 | **OWL** (Web Ontology Language) becomes a W3C Recommendation | search: <https://atlan.com/know/rdf-vs-owl/> |
| 2004 | AllegroGraph 1.0 released (Franz Inc.) | <https://dbdb.io/db/allegrograph> |
| 2007 | Neo Technology incorporated (Sweden); Neo4j spun out as OSS | <https://en.wikipedia.org/wiki/Neo4j> |
| 2007 | OWL 2 work / later Recommendation (2009) | search: <https://atlan.com/know/rdf-vs-owl/> |
| **2008** | **SPARQL** becomes a W3C Recommendation (Jan 15, 2008) | <https://en.wikipedia.org/wiki/Resource_Description_Framework> |
| 2009 | Gremlin / TinkerPop created by Marko A. Rodriguez (Oct–Dec 2009) | <https://en.wikipedia.org/wiki/Gremlin_(query_language)> |
| 2010 | Neo4j 1.0 released (Feb 2010) | <https://en.wikipedia.org/wiki/Neo4j> |
| 2010 | Jena donated to the Apache Software Foundation (Nov 2010) | <https://en.wikipedia.org/wiki/Apache_Jena> |
| 2010 | OrientDB authored by Luca Garulli | <https://dbdb.io/db/orientdb> |
| 2011 | **Cypher** invented by Andrés Taylor at Neo Technology | <https://en.wikipedia.org/wiki/Cypher_(query_language)> |
| 2012 | Titan graph database first released (Aurelius) | <https://www.bigdatawire.com/2017/01/13/janusgraph-picks-titandb-left-off/> |
| 2012 | TigerGraph founded (as GraphSQL) | <https://en.wikipedia.org/wiki/TigerGraph> |
| **2012** | **Google Knowledge Graph** launched (May 16, 2012) | <https://en.wikipedia.org/wiki/Knowledge_Graph_(Google)> |
| 2014 | **RDF 1.1** (six W3C Recommendations) supersedes RDF 1.0 | <https://en.wikipedia.org/wiki/Resource_Description_Framework> |
| 2014 | ArangoDB GmbH founded (multi-model) | <https://en.wikipedia.org/wiki/ArangoDB> |
| 2015 | Blazegraph (renamed from Bigdata, v1.5, Feb 2015), SYSTAP | <https://en.wikipedia.org/wiki/Blazegraph> |
| 2015 | Aurelius (Titan) acquired by DataStax | <https://www.bigdatawire.com/2017/01/13/janusgraph-picks-titandb-left-off/> |
| 2015 | **GraphQL** open-sourced by Facebook (NOT a graph-DB language) | <https://en.wikipedia.org/wiki/GraphQL> |
| 2015 | Dgraph created by Manish Rai Jain (July 2015) | <https://dbdb.io/db/dgraph> |
| 2015 | openCypher project opens Cypher (Oct 2015) | <https://en.wikipedia.org/wiki/Cypher_(query_language)> |
| 2016 | Sesame forks into **Eclipse RDF4J** (May 2016) | <https://en.wikipedia.org/wiki/RDF4J> |
| 2016 | Memgraph founded (Dominik Tomicevic, Marko Budiselic) | <https://www.crunchbase.com/person/dominik-tomicevic> |
| 2017 | **JanusGraph** forks Titan under the Linux Foundation (Jan 2017) | <https://opensource.googleblog.com/2017/01/janusgraph-connects-past-and-future-of-titan.html> |
| 2017 | OrientDB acquired by CallidusCloud (Sep 2017) → SAP (2018) | <https://www.globenewswire.com/news-release/2017/09/19/1124824/0/en/CallidusCloud-Acquires-Leading-Multi-Model-Database-Technology.html> |
| 2017 | **Amazon Neptune** announced (Nov 29, 2017; GA May 2018) | <https://en.wikipedia.org/wiki/Amazon_Neptune> |
| 2018 | Amazon acqui-hires the Blazegraph/SYSTAP team (Apr 2018) | <https://en.wikipedia.org/wiki/Blazegraph> |
| 2018 | NebulaGraph / Vesoft Inc. founded (Oct 2018) | search: <https://nebula-graph.io/about-us> |
| 2023 | Dgraph Labs acquired by Hypermode (Nov 6, 2023) | <https://web.archive.org/web/2id_/https://hypermode.com/blog/dgraph-part-of-hypermode> |
| 2023 | RedisGraph end-of-life announced (new licenses stop Jul 5, 2023) | <https://redis.io/blog/redisgraph-eol/> |
| 2024 | **ISO/IEC 39075 GQL** published (Apr 12, 2024) — first new ISO query-language standard since SQL | <https://www.iso.org/standard/76120.html> |
| 2024 | **Microsoft GraphRAG** announced (graph + LLM retrieval) | <https://www.microsoft.com/en-us/research/blog/graphrag-unlocking-llm-discovery-on-narrative-private-data/> |
| 2024 | Ontotext + Semantic Web Company merge to form Graphwise (Oct 2024) | <https://blocksandfiles.com/2024/10/23/graphwise/> |
| 2025 | Dgraph acquired by Istari Digital from Hypermode (Oct 23, 2025) | <https://www.prnewswire.com/news-releases/istari-digital-acquires-dgraph-to-strengthen-data-foundation-for-ai-and-engineering-302593246.html> |

---

## 1. Theory and standards

### Graph data models

Two competing serializations dominate:

- **RDF triples** — every fact is a `(subject, predicate, object)` statement;
  elements are IRIs, blank nodes, or literals. A set of triples forms a graph.
  - Source: Resource Description Framework — Wikipedia,
    <https://en.wikipedia.org/wiki/Resource_Description_Framework>
- **Labeled property graphs (LPG)** — nodes and relationships, each carrying a
  set of key/value properties, with relationships being first-class, typed, and
  directed. This is the model used by Neo4j, Titan/JanusGraph, TigerGraph, etc.
  - Source (Cypher describes the property-graph model it queries): Cypher
    (query language) — Wikipedia,
    <https://en.wikipedia.org/wiki/Cypher_(query_language)>

### The Semantic Web and RDF

- The **W3C** published the **first RDF Recommendation in 1999** (the "RDF Model
  and Syntax Specification," "RDF M&S"), describing RDF's data model and an XML
  serialization.
  - Source: Resource Description Framework — Wikipedia,
    <https://en.wikipedia.org/wiki/Resource_Description_Framework>
- RDF's design drew on the **Meta Content Framework (MCF)**, developed
  1995–1997 by **Ramanathan V. Guha** (Apple) and **Tim Bray** (Netscape), and
  on Dublin Core and PICS.
  - Source: Resource Description Framework — Wikipedia (same).
  - **Attribution note:** The brief popularly credits the Semantic Web vision
    to **Tim Berners-Lee** (W3C director); however, the Wikipedia RDF article
    credits the *RDF specification's* technical lineage to Guha, Bray, and W3C
    working groups (IBM, Microsoft, Netscape, etc.) rather than naming
    Berners-Lee as a spec author. Berners-Lee's role is as the originator of
    the broader Semantic Web vision and director of W3C, not as RDF's
    document author. **Could not verify** a primary source naming Tim
    Berners-Lee as an author of the 1999 RDF Recommendation.
- The original 1999 spec was **replaced in 2004** by a set of six W3C
  Recommendations (often called **"RDF 1.0"** retroactively), and that series
  was **superseded in 2014 by "RDF 1.1"** (also six documents).
  - Source: Resource Description Framework — Wikipedia (same).
  - **Date nuance:** the user's "RDF 1.0 ~1999" maps to the *1999 M&S
    Recommendation*; the named-and-numbered "RDF 1.0" spec set is actually the
    **2004** revision. Both are flagged here to avoid conflation.

### SPARQL

- **SPARQL** (SPARQL Protocol and RDF Query Language) is the SQL-like query
  language for RDF; it became a **W3C Recommendation on January 15, 2008**.
  - Source: Resource Description Framework — Wikipedia,
    <https://en.wikipedia.org/wiki/Resource_Description_Framework>
  - SPARQL 1.1 followed in 2013; SPARQL 1.2 is in progress as of this writing.
    - Source (SPARQL 1.2 draft exists): W3C,
      <https://w3c.github.io/sparql-query/spec/>

### OWL

- **OWL** (Web Ontology Language) is a richer language built on top of RDF for
  defining classes, relationships, and logical constraints to enable machine
  inference. OWL became a W3C Recommendation in **2004**, and **OWL 2** in
  **2009** (work began ~2007).
  - Source: "RDF vs OWL," Atlan,
    <https://atlan.com/know/rdf-vs-owl/>
  - **Could not verify** the exact OWL/OWL 2 Recommendation dates against a W3C
    primary URL in this pass; the 2004 / 2009 dates come from the Atlan summary
    and common references. Flagged for primary-source confirmation.

---

## 2. RDF / triple stores

### Apache Jena (HP Labs, ~2000–2001)

- **Jena** is an open-source Semantic Web framework for Java (RDF, SPARQL,
  OWL). It was **created by HP Labs**, was on **SourceForge since 2001**, and
  was **donated to the Apache Software Foundation in November 2010** (becoming a
  top-level Apache project in 2012).
  - Source: Apache Jena — Wikipedia, <https://en.wikipedia.org/wiki/Apache_Jena>
  - Source: Apache Jena home, <https://jena.apache.org/>
- **Status:** Actively maintained Apache project (Jena 5.x, RDF 1.1/1.2 and
  SPARQL 1.1/1.2 support).
  - Source: Apache Jena — Wikipedia (same).
  - **Could not verify** an exact "founded ~2000" year; the earliest hard date
    is the 2001 SourceForge presence.

### Sesame → Eclipse RDF4J (Aduna)

- **Sesame** (later **OpenRDF Sesame**) was an RDF framework created by
  **Aduna**, a Dutch company, with roots in the **On-To-Knowledge** EU project
  (1999–2002).
  - Source: RDF4J — Wikipedia, <https://en.wikipedia.org/wiki/RDF4J>
- In **May 2016**, Sesame forked into an **Eclipse Foundation** project renamed
  **RDF4J**, "in recognition of Aduna no longer being involved in its
  development."
  - Source: RDF4J — Wikipedia (same).
- **Status:** Active Eclipse project (Java; Eclipse Distribution License),
  repo at <https://github.com/eclipse-rdf4j/rdf4j>.
  - Source: RDF4J — Wikipedia (same).

### Virtuoso (OpenLink Software — Kingsley Idehen)

- **Virtuoso** is a hybrid RDBMS / RDF triple store / web-application server
  from **OpenLink Software**, founded by **Kingsley Idehen** (who established
  the consultancy that became OpenLink in **1992**).
  - Source: History of Virtuoso, OpenLink,
    <https://vos.openlinksw.com/owiki/wiki/VOS/VOSHistory>
  - Source (Idehen founder/CEO): Crunchbase,
    <https://www.crunchbase.com/person/kingsley-idehen>
- The **Virtuoso engine was first unveiled in fall 1998**, born from merging
  OpenLink's data-access middleware with the Kubl RDBMS; RDF/triple-store and
  SPARQL capabilities were layered on later.
  - Source: History of Virtuoso (same).
- **Status:** Active, commercial + open-source ("VOS," Virtuoso Open Source).
  Notably hosts large public Linked Data endpoints (e.g. DBpedia historically).
  - Source: OpenLink company profile,
    <https://www.openlinksw.com/company/>

### AllegroGraph (Franz Inc. — Jans Aasman)

- **AllegroGraph** is a persistent RDF triple store / knowledge-graph platform
  developed by **Franz Inc.** (Common Lisp heritage). **AllegroGraph 1.0** was
  released **at the end of 2004**, and was an early system to load and index 1
  billion triples on commodity 64-bit hardware.
  - Source: Database of Databases — AllegroGraph,
    <https://dbdb.io/db/allegrograph>
  - Source: Franz Inc. / AllegroGraph,
    <https://franz.com/products/allegrograph/allegrograph.datasheet.pdf>
- **Jans Aasman** is Franz Inc.'s CEO and a long-time public face of
  AllegroGraph.
  - **Could not verify** an exact founding date tying Aasman specifically to
    AllegroGraph's inception (Franz Inc. predates AllegroGraph as a Lisp tools
    vendor). Flagged.
- **Status:** Active, commercial.

### GraphDB / OWLIM (Ontotext — Atanas Kiryakov)

- **Ontotext** is a Bulgarian software company **founded in 2000** (Sofia) as
  an R&D lab within the **Sirma Group**, founded by **Atanas Kiryakov**.
  - Source: Ontotext — Wikipedia,
    <https://en.wikipedia.org/wiki/Ontotext_GraphDB>
- Its RDF triple store was originally **OWLIM**; the OWLIM family was described
  in the 2005 paper "OWLIM — A Pragmatic Semantic Repository for OWL"
  (Kiryakov, Ognyanov, Manov).
  - Source: SpringerLink,
    <https://link.springer.com/chapter/10.1007/11581116_19>
- OWLIM was **renamed GraphDB**; in **2014 Ontotext acquired the "GraphDB"
  trademark from Sones**.
  - Source: Ontotext — Wikipedia (same).
- In **October 2024**, Ontotext **merged with Semantic Web Company to form
  Graphwise**.
  - Source: "Semantic Web Company and Ontotext merge to form Graphwise,"
    Blocks & Files, <https://blocksandfiles.com/2024/10/23/graphwise/>
- **Status:** Active (now under Graphwise), commercial RDF triple store.
  - **Could not verify** OWLIM's exact first-release year (academic references
    cluster around 2004–2005); flagged.

### Stardog (Stardog Union — Mike Grove / Kendall Clark)

- **Stardog** is a pure-Java RDF/knowledge-graph database with OWL2 reasoning.
  Co-founders include **Michael (Mike) Grove** (founder, engineering) and
  **Kendall Clark**; the company grew out of **Clark & Parsia**, a consultancy.
  The name "Stardog" came from NASA's POPS system work, and the company adopted
  the Stardog name (Arlington/Washington-DC area).
  - Source (Grove founder): LinkedIn,
    <https://www.linkedin.com/in/michaelhgrove/>
  - Source (Stardog/NASA/Clark & Parsia origin and "Stardog" name): NASA
    Spinoff, <https://spinoff.nasa.gov/Data_Analysis_Goes_to_the_Dogs>
  - Source (about): Stardog company page,
    <https://www.stardog.com/company/about/>
- **Status:** Active, commercial (Stardog Union).
  - **Could not verify** a single authoritative founding year — Clark & Parsia
    predates the "Stardog Union" entity (commonly cited ~2005 for Clark &
    Parsia and ~2016 for the Stardog rename), but I did not pin a primary
    source giving an exact incorporation year. Flagged.

### Blazegraph (SYSTAP → Amazon)

- **Blazegraph** (formerly **Bigdata**) is an open-source triple store / graph
  database by **SYSTAP, LLC**; the rename to Blazegraph came with **v1.5
  (Feb 12, 2015)**. **Bryan Thompson** was the primary developer.
  - Source: Blazegraph — Wikipedia,
    <https://en.wikipedia.org/wiki/Blazegraph>
- Blazegraph powers the **Wikidata Query Service** (the Wikimedia SPARQL
  endpoint).
  - Source: Blazegraph — Wikipedia (same).
  - Source (Wikidata reload context): Wikimedia Tech Blog,
    <https://techblog.wikimedia.org/2025/04/08/wikidata-query-service-graph-database-reload-at-home-2025-edition/>
- **Amazon acquired the Blazegraph developers** (an acqui-hire, including the
  trademark and domain); **open-source development essentially stopped in April
  2018**, and the team's work fed into **Amazon Neptune**, which is "based on
  Blazegraph." Bryan Thompson became a Senior Principal Engineer at Amazon.
  - Source: Blazegraph — Wikipedia (same).
  - Source (Thompson at Amazon): LinkedIn,
    <https://www.linkedin.com/in/bryanthompson2/>
- **Status:** Abandoned since ~2020, yet still in production at Wikimedia
  Deutschland for Wikidata.
  - Source: Blazegraph — Wikipedia (same).

### 4store and Mulgara (older / smaller RDF stores)

- **4store** and **Mulgara** are open-source RDF triple stores frequently
  listed among RDF4J-compatible / SPARQL backends.
  - Source (Mulgara/AllegroGraph among RDF4J-accessible stores): RDF4J —
    Wikipedia / Apache Jena — Wikipedia,
    <https://en.wikipedia.org/wiki/Apache_Jena>
  - **Could not verify** precise founding years / founders for 4store and
    Mulgara in this pass (4store originated at Garlik; Mulgara forked from
    Kowari/Tucana). Flagged for follow-up. Both are largely dormant today.

---

## 3. Property-graph databases

### Neo4j — the flagship (Neo Technology, Sweden)

**Founding and origin story:**

- Neo4j was founded by **Emil Eifrem, Johan Svensson, and Peter Neubauer**.
  **Neo Technology** was incorporated in **2007 in Sweden**, and Neo4j was spun
  out as open source at that time.
  - Source: Neo4j — Wikipedia, <https://en.wikipedia.org/wiki/Neo4j>
- The **conception dates to 2000**: Eifrem **sketched the graph data model "on
  the back of his napkin" during a flight in 2000** while the team struggled
  with an enterprise CMS on a relational database (Informix), where deeply
  interconnected data made SQL joins painful — the canonical "napkin sketch."
  - Source: Neo4j — Wikipedia (same).
  - Source (napkin-sketch narrative; treat the dramatized framing as
    journalism, the core facts as corroborated): "The Database That Toppled a
    Government," Stacksync,
    <https://www.stacksync.com/blog/the-database-that-toppled-a-government-the-origin-story-of-neo4j>
- **Neo4j 1.0** was released in **February 2010**.
  - Source: Neo4j — Wikipedia (same).
  - **Date nuance:** "conceived ~2000, company 2007, first GA release 2010."
    The Wikipedia article phrases the 2007 milestone as the OSS spin-out / Neo
    Technology incorporation, with v1.0 in Feb 2010.

**Cypher query language:**

- **Cypher** was "largely an invention of **Andrés Taylor**" at Neo Technology
  in **2011**, modeled on SQL's declarative style but for property graphs.
  - Source: Cypher (query language) — Wikipedia,
    <https://en.wikipedia.org/wiki/Cypher_(query_language)>
- Cypher was opened up via the **openCypher** project in **October 2015**.
  - Source: Cypher — Wikipedia (same).

**Licensing:**

- Neo4j **Community Edition** is GPLv3. The **Enterprise Edition** was
  originally dual-licensed (GPLv3, with parts under AGPLv3 + the **Commons
  Clause**) before moving to a closed-source commercial license — i.e. the
  enterprise product became *source-available with restrictions* rather than
  pure open source.
  - Source: Neo4j — Wikipedia, <https://en.wikipedia.org/wiki/Neo4j>

**The PureThink / iGov litigation:**

- **Neo4j, Inc. v. PureThink, LLC** centered on PureThink **removing the
  restrictive Commons Clause from Neo4j's AGPL-licensed code** and continuing
  to use the **"Neo4j" name** when selling to government agencies (an "ONgDB"
  fork marketed as free Neo4j Enterprise).
  - Source: Neo4j — Wikipedia (same).
- A judgment dated **July 22, 2024** found PureThink liable, with **$597,000 in
  actual damages** for a DMCA violation and trademark infringement.
  - Source: Neo4j — Wikipedia (same).
  - **Note / opinion attribution:** the dispute is often cited in
    open-source-licensing debates over whether "remove the Commons Clause"
    forks are legitimate. The legal *outcome* (Neo4j prevailing, damages
    awarded) is the sourced fact; characterizations of who was "right" are
    contested opinion and should be attributed to whoever voices them.

**Funding / AI era:**

- Neo4j (the company relocated its HQ toward Silicon Valley in 2011 while
  keeping Swedish engineering) has raised substantial venture funding and, as
  of 2024, leaned into AI/GraphRAG positioning.
  - Source: "Database startup Neo4j embraces AI to supercharge growth,"
    TechCrunch, <https://techcrunch.com/2024/11/19/database-startup-neo4j-embraces-ai-to-supercharge-growth/>
  - Source (relocation to Silicon Valley 2011): Neo4j — Wikipedia (same).
- **Status:** Active, the market-leading property-graph vendor.

### Titan → JanusGraph; Apache TinkerPop / Gremlin

- **Titan** (TitanDB) was a distributed graph database **first released in
  2012**, developed by **Aurelius** — co-founded by **Marko Rodriguez** and
  **Matthias Bröcheler**.
  - Source: "JanusGraph Picks Up Where TitanDB Left Off," BigDATAwire,
    <https://www.bigdatawire.com/2017/01/13/janusgraph-picks-titandb-left-off/>
- **Aurelius was acquired by DataStax in 2015** (the company behind Apache
  Cassandra). After the acquisition Titan stagnated (no releases after v1.0 in
  Sept 2015); DataStax pivoted to DataStax Enterprise Graph.
  - Source: BigDATAwire (same).
- In **January 2017**, the community forked Titan as **JanusGraph** under the
  **Linux Foundation**, with founding support from IBM, Hortonworks, Expero,
  and GRAKN.AI (after a DataStax lawyer reportedly blocked moving Titan to the
  ASF).
  - Source: "JanusGraph connects the past and future of Titan," Google Open
    Source Blog,
    <https://opensource.googleblog.com/2017/01/janusgraph-connects-past-and-future-of-titan.html>
  - Source: "The Linux Foundation Welcomes JanusGraph," Linux Foundation,
    <https://www.linuxfoundation.org/blog/blog/the-linux-foundation-welcomes-janusgraph>
- **Apache TinkerPop** is a graph-computing framework, and **Gremlin** is its
  graph-traversal language — both **created by Marko A. Rodriguez** starting
  around **October–December 2009** (TinkerPop 0.1 / Gremlin debut Dec 2009).
  TinkerPop 3 (July 2015) introduced bytecode traversals and multi-language
  bindings.
  - Source: Gremlin (query language) — Wikipedia,
    <https://en.wikipedia.org/wiki/Gremlin_(query_language)>
  - Source: Apache TinkerPop, <https://tinkerpop.apache.org/>
- **Status:** JanusGraph and TinkerPop are active open-source projects; Titan
  is dead (superseded by JanusGraph).

### OrientDB (Luca Garulli → CallidusCloud → SAP)

- **OrientDB** is a multi-model (document + graph + key/value) database
  **authored by Luca Garulli in 2010**. Garulli's keynote in **2012** in
  Cologne is credited with first associating "multi-model" with databases.
  - Source: Database of Databases — OrientDB, <https://dbdb.io/db/orientdb>
  - Source: OrientDB — Wikipedia, <https://en.wikipedia.org/wiki/OrientDB>
- OrientDB **was acquired by CallidusCloud on Sept 15, 2017**; CallidusCloud
  itself was **acquired by SAP** (announced Jan 2018, ~$2.4B). SAP later
  **dropped commercial support for OrientDB (Sept 1, 2021)**; Garulli then
  started **ArcadeDB**.
  - Source: "CallidusCloud Acquires Leading Multi-Model Database Technology,"
    GlobeNewswire,
    <https://www.globenewswire.com/news-release/2017/09/19/1124824/0/en/CallidusCloud-Acquires-Leading-Multi-Model-Database-Technology.html>
  - Source (SAP dropped support 2021): GitHub issue,
    <https://github.com/orientechnologies/orientdb/issues/9734>
- **Status:** OrientDB is largely dormant; spiritual successor is ArcadeDB.

### ArangoDB (Claudius Weinberger — multi-model)

- **ArangoDB GmbH** was **founded in 2014** by **Claudius Weinberger** and
  **Frank Celler**. It is a multi-model database (graph + JSON document +
  key/value) with a unified query language, **AQL**. The project was originally
  named **AvocadoDB** ("A Versatile Object Container").
  - Source: ArangoDB — Wikipedia, <https://en.wikipedia.org/wiki/ArangoDB>
  - **Date nuance:** the *company* dates to 2014, but the database project
    (as AvocadoDB) is a bit older; the rename to ArangoDB followed a trademark
    issue. The 2014 figure here is the GmbH founding.
- **Status:** Active, commercial + open source.

### TigerGraph (Yu Xu)

- **TigerGraph** was **founded in 2012** under the name **GraphSQL**. Wikipedia
  lists the founding team as **Yu Xu** (the public founder/CEO) along with
  Ruoming Jin, Li Chen, Like Gao, and Mingxi Wu. Its query language is
  **GSQL** (designed by Mingxi Wu and Alin Deutsch, 2015).
  - Source: TigerGraph — Wikipedia, <https://en.wikipedia.org/wiki/TigerGraph>
- It emerged from stealth in **Sept 2017 with $31–33M**, later raising a
  $105M Series C (Feb 2021), reaching ~$170M cumulative.
  - Source: TigerGraph — Wikipedia (same).
  - **Note:** the user's "founder Yu Xu" is the commonly cited founder/CEO;
    Wikipedia attributes a broader founding team. Both framings are recorded.
- **Status:** Active, commercial (native parallel graph + analytics).

### Dgraph (Manish Rai Jain → Hypermode → Istari Digital)

- **Dgraph** was **created in July 2015 by Manish Rai Jain**, based on his prior
  work at **Google** (where he led a graph backend for web-search serving).
  - Source: Database of Databases — DGraph, <https://dbdb.io/db/dgraph>
- **Dgraph Labs was acquired by Hypermode on November 6, 2023** (not 2024).
  - Source: "Dgraph Labs is becoming part of Hypermode," Hypermode,
    <https://web.archive.org/web/2id_/https://hypermode.com/blog/dgraph-part-of-hypermode>
  - **Correction to the brief:** the acquisition was **2023**, not 2024.
- **Dgraph was then sold by Hypermode to Istari Digital on Oct 23, 2025.**
  - Source: "Istari Digital Acquires Dgraph...," PR Newswire,
    <https://www.prnewswire.com/news-releases/istari-digital-acquires-dgraph-to-strengthen-data-foundation-for-ai-and-engineering-302593246.html>
  - Source (deal completion from Hypermode): MergerLinks,
    <https://app.mergerlinks.com/transactions/2025-10-23-dgraph>
- **Status:** Active open-source project, now owned by Istari Digital. (Note:
  Dgraph uses GraphQL as a primary interface — a rare case of a *graph
  database* exposing GraphQL, distinct from the GraphQL-isn't-a-graph-DB point
  below.)
  - Source (Dgraph native GraphQL): PR Newswire (same).

### NebulaGraph (Vesoft Inc.)

- **NebulaGraph** is an open-source distributed graph database developed by
  **Vesoft Inc.**, **founded in October 2018** by graph/distributed-systems
  veterans (ex-Meta, Ant Group, etc.). First public version **v0.1.0-alpha**
  appeared in **2019**.
  - Source (Vesoft Oct 2018): NebulaGraph about page,
    <https://nebula-graph.io/about-us>
  - Source (project, releases): GitHub,
    <https://github.com/vesoft-inc/nebula>
- **Status:** Active open source.
  - **Could not verify** named individual founders against a primary source
    (the about page describes the team collectively). Flagged.

### Memgraph

- **Memgraph** is an in-memory, real-time property-graph database **founded in
  2016 by Dominik Tomicevic and Marko Budiselic**. It uses Cypher and has
  raised venture funding (Microsoft among investors).
  - Source (Tomicevic co-founder/CEO): Crunchbase,
    <https://www.crunchbase.com/person/dominik-tomicevic>
  - Source (Microsoft-backed €8M round): The Recursive,
    <https://therecursive.com/croatian-graph-database-startup-memgraph-raises-e8m-with-microsoft-as-key-investor-plans-to-boost-r-d/>
- **Status:** Active, commercial + open source.

### RedisGraph (Redis / RedisLabs — deprecated)

- **RedisGraph** was a pluggable graph module for Redis (developed by
  RedisLabs), using **openCypher**.
  - Source (openCypher usage): Cycode blog,
    <https://cycode.com/blog/aws-neptune-neo4j-arangodb-or-redisgraph-how-we-chose-our-graph-database/>
- **RedisGraph reached end-of-life:** new licenses stopped **July 5, 2023**;
  end of support **Jan 31, 2025**; graph capabilities removed from Redis Stack
  starting 7.2.x.
  - Source: "RedisGraph End-of-Life Announcement," Redis,
    <https://redis.io/blog/redisgraph-eol/>
  - **Note:** the brief's "deprecated 2023" is correct (EOL *announced* 2023;
    full sunset by early 2025). A community fork, **FalkorDB**, continues the
    code.
    - Source (FalkorDB as successor): FalkorDB migration guide,
      <https://www.falkordb.com/blog/redisgraph-eol-migration-guide/>
- See `history/redis.md` for the broader Redis story (this doc covers only the
  graph module).

### Amazon Neptune

- **Amazon Neptune** was **announced Nov 29, 2017** (GA **May 30, 2018**). It is
  a managed graph database supporting **both** the property-graph model
  (Gremlin, openCypher) **and** RDF (SPARQL). Its RDF engine derives from the
  acqui-hired **Blazegraph/SYSTAP** team.
  - Source: Amazon Neptune — Wikipedia,
    <https://en.wikipedia.org/wiki/Amazon_Neptune>
  - Source (Blazegraph lineage): Blazegraph — Wikipedia,
    <https://en.wikipedia.org/wiki/Blazegraph>
- **Status:** Active AWS service.

### Microsoft Azure Cosmos DB — Gremlin API

- **Azure Cosmos DB** (Microsoft's globally distributed multi-model database)
  offers a **Gremlin (TinkerPop) graph API**, making it a TinkerPop-enabled
  property-graph store.
  - Source (Cosmos DB among TinkerPop-enabled databases): PuppyGraph,
    <https://www.puppygraph.com/blog/gremlin-graph-database>
- **Status:** Active Azure service.

---

## 4. Query languages and the standard

### Cypher → openCypher → GQL

- **Cypher** (2011, Andrés Taylor, Neo4j) → **openCypher** (Oct 2015, opened to
  other vendors) → **GQL** (ISO standard, 2024).
  - Source: Cypher — Wikipedia,
    <https://en.wikipedia.org/wiki/Cypher_(query_language)>
- **GQL (Graph Query Language)** was published as **ISO/IEC 39075:2024 on
  April 12, 2024**. It is widely described as the **first new ISO database
  query-language standard since SQL** (SQL was first ISO-standardized in 1987).
  - Source (ISO catalog): ISO/IEC 39075:2024,
    <https://www.iso.org/standard/76120.html>
  - Source ("first new ISO DB query language standard since SQL in 1987"):
    Graph Query Language — Wikipedia,
    <https://en.wikipedia.org/wiki/Graph_Query_Language>
  - **Attribution note:** GQL was "inspired by Cypher and built upon the
    foundation of SQL," influenced by SQL, Cypher, GSQL, PGQL, and G-CORE; the
    editors include **Stefan Plantikow** (Neo4j; first lead engineer of
    Neo4j's Cypher-for-Spark) and **Stephen Cannan** (SQL Technical Corrigenda
    editor). The standardization push traces to a private Neo4j proposal in
    July 2016 and an Oracle proposal within ISO/IEC JTC1 the same year.
    - Source: Graph Query Language — Wikipedia (same).

### Gremlin (TinkerPop)

- **Gremlin** is the imperative/functional graph-traversal language of Apache
  TinkerPop (Marko Rodriguez, 2009). It runs across many TinkerPop-enabled
  systems (JanusGraph, Neptune, Cosmos DB).
  - Source: Gremlin — Wikipedia,
    <https://en.wikipedia.org/wiki/Gremlin_(query_language)>

### SPARQL (RDF)

- The W3C standard for RDF (Recommendation 2008; 1.1 in 2013) — see §1.
  - Source: <https://en.wikipedia.org/wiki/Resource_Description_Framework>

### PGQL (Oracle) and GSQL (TigerGraph)

- **PGQL** is Oracle's property-graph query language; **GSQL** is TigerGraph's
  (designed 2015). Both are cited as influences on the GQL standard.
  - Source (GSQL designed 2015; GQL influences): TigerGraph — Wikipedia,
    <https://en.wikipedia.org/wiki/TigerGraph>; Graph Query Language —
    Wikipedia, <https://en.wikipedia.org/wiki/Graph_Query_Language>
  - **Could not verify** a primary Oracle source for PGQL's exact introduction
    year in this pass; flagged.

### GraphQL is NOT a graph-database query language (clarifying a common confusion)

- **GraphQL** is a **query language for APIs**, **open-sourced by Facebook
  (publicly presented at React.js Conf 2015)**. It is **not** a query language
  for graph databases.
  - Source: GraphQL — Wikipedia, <https://en.wikipedia.org/wiki/GraphQL>
  - Source (official FAQ — "GraphQL is not a graph database query language"):
    GraphQL FAQ, <https://graphql.org/faq/>
- The name causes confusion because both contain "graph" and both involve
  "queries." But GraphQL is **storage-agnostic**: a GraphQL server can be
  backed by SQL, a document store, REST APIs, or anything — it queries "the
  graph of your application data," not a graph database.
  - Source: How to GraphQL — common questions,
    <https://www.howtographql.com/advanced/5-common-questions/>
  - **Caveat:** some graph databases (notably **Dgraph**) *do* expose GraphQL
    as a native interface, which can deepen the confusion — but GraphQL itself
    remains an API layer, not a graph-DB query language in the sense of
    Cypher/Gremlin/SPARQL/GQL.
    - Source (Dgraph GraphQL): PR Newswire,
      <https://www.prnewswire.com/news-releases/istari-digital-acquires-dgraph-to-strengthen-data-foundation-for-ai-and-engineering-302593246.html>

---

## 5. Modern revival (2012–2025)

### Knowledge graphs go mainstream

- **Google Knowledge Graph** launched **May 16, 2012**, introduced by Amit
  Singhal, to return facts about entities (people, places, things) rather than
  just links. It grew to ~570M entities / 18B facts within seven months. The
  term **"knowledge graph"** entered mainstream tech vocabulary largely because
  of this launch.
  - Source: Knowledge Graph (Google) — Wikipedia,
    <https://en.wikipedia.org/wiki/Knowledge_Graph_(Google)>
  - Source (launch coverage): "Google Launches Knowledge Graph...,"
    Search Engine Land, <https://searchengineland.com/google-launches-knowledge-graph-121585>

### Fraud, recommendations, and other drivers

- The 2010s graph-DB commercial boom was driven by relationship-heavy use cases
  — fraud/AML detection, recommendation engines, network/IT operations, and
  master-data management — where multi-hop traversals outperform relational
  joins. Vendors (Neo4j, TigerGraph, Neptune, etc.) market these heavily.
  - Source (Neo4j fraud/recommendation positioning is corroborated in vendor
    coverage): TechCrunch,
    <https://techcrunch.com/2024/11/19/database-startup-neo4j-embraces-ai-to-supercharge-growth/>
  - **Opinion attribution:** specific claims that "graph databases would grow
    exponentially" were made by analyst reports — Redis's EOL post itself
    pushes back, noting many companies "need help developing software based on
    graph databases" (a stated reason for sunsetting RedisGraph). This is
    Redis's stated opinion, not an industry consensus.
    - Source: RedisGraph EOL post, <https://redis.io/blog/redisgraph-eol/>

### The GraphRAG wave (graph + LLM retrieval)

- **GraphRAG** combines knowledge graphs with LLM retrieval-augmented
  generation. **Microsoft Research introduced its GraphRAG approach in 2024**:
  an LLM builds a knowledge graph from a corpus, and graph community summaries
  augment prompts at query time, improving global/whole-corpus question
  answering over baseline vector RAG.
  - Source: "GraphRAG: Unlocking LLM discovery on narrative private data,"
    Microsoft Research,
    <https://www.microsoft.com/en-us/research/blog/graphrag-unlocking-llm-discovery-on-narrative-private-data/>
  - Source (open-source implementation): microsoft/graphrag, GitHub,
    <https://github.com/microsoft/graphrag>
  - Source (survey, 2025): "Retrieval-Augmented Generation with Graphs
    (GraphRAG)," arXiv, <https://arxiv.org/abs/2501.00309>
- This AI-era resurgence is why incumbents (Neo4j) and newcomers (Dgraph under
  Hypermode/Istari) reposition around "AI-native" graphs and agent memory.
  - Source (Neo4j AI pivot): TechCrunch (same as above).
  - Source (Dgraph "AI-native"): PR Newswire,
    <https://www.prnewswire.com/news-releases/istari-digital-acquires-dgraph-to-strengthen-data-foundation-for-ai-and-engineering-302593246.html>
  - **Opinion attribution:** "GraphRAG outperforms baseline RAG" is Microsoft
    Research's claim from its own evaluations; independent results vary by task.

---

## Cross-reference

- **NoSQL era / document stores / SSPL relicensing:** see
  `history/mongodb.md`. Graph databases are often classed under NoSQL, but this
  doc focuses on the graph/RDF-specific lineage rather than re-covering the
  document-store wave.
- **Redis (and the RedisGraph module's parent):** see `history/redis.md`.

---

## Summary of items flagged "Could not verify" / corrected

1. **Tim Berners-Lee as RDF author** — Could not verify a primary source naming
   him an author of the 1999 RDF Recommendation; Wikipedia credits Guha, Bray,
   and W3C working groups. Berners-Lee's role is the Semantic Web *vision* /
   W3C directorship.
2. **"RDF 1.0 ~1999" vs 2004** — The *first* RDF Recommendation is 1999 (M&S);
   the named/numbered "RDF 1.0" spec set is the **2004** revision. Both
   recorded.
3. **OWL / OWL 2 exact Recommendation dates** (2004 / 2009) — taken from a
   secondary source (Atlan); not pinned to a W3C primary URL this pass.
4. **Apache Jena exact creation year** — earliest hard date is 2001
   (SourceForge); "~2000" not confirmed.
5. **AllegroGraph / Jans Aasman** — AllegroGraph 1.0 = end of 2004 confirmed;
   could not confirm a primary date binding Aasman to its inception (Franz Inc.
   predates the product).
6. **OWLIM first-release year** — academic references cluster 2004–2005; exact
   first release not pinned.
7. **Stardog founding year** — Clark & Parsia (~2005) vs Stardog rename
   (~2016); no single primary incorporation-year source confirmed.
8. **NebulaGraph named founders** — Vesoft founded Oct 2018 confirmed;
   individual founder names not confirmed against a primary source.
9. **PGQL introduction year (Oracle)** — not confirmed against an Oracle
   primary source.
10. **4store / Mulgara** — founders and founding years not confirmed this pass.
11. **CORRECTION (brief said 2024):** Dgraph → **Hypermode** acquisition was
    **November 2023**, not 2024. Dgraph subsequently went **Hypermode →
    Istari Digital** in **October 2025**.
12. **TigerGraph founder framing** — "Yu Xu" is the cited founder/CEO, but
    Wikipedia lists a broader founding team (Yu Xu, Ruoming Jin, Li Chen, Like
    Gao, Mingxi Wu). Both recorded.
