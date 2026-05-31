# MongoDB (10gen → MongoDB, Inc.): A Sourced History

A chronological, fully-sourced history of MongoDB and the company behind it,
from its founding as 10gen through the SSPL relicensing controversy and the
cloud/AI era. Every non-trivial claim links to a primary or reputable source.
Where a fact could not be confirmed, it is explicitly flagged
"Could not verify."

---

## Timeline

### 2007 — 10gen founded; PaaS origins

- 10gen, Inc. was founded in **2007** in New York City by **Dwight Merriman**
  (former DoubleClick founder/CTO), **Kevin P. Ryan** (former DoubleClick CEO,
  Gilt Groupe founder), and **Eliot Horowitz** (former DoubleClick engineer,
  ShopWiki co-founder/CTO).
  - Source: MongoDB Inc. — Wikipedia,
    <https://en.wikipedia.org/wiki/MongoDB_Inc.>
  - Source (founders' DoubleClick lineage): Eliot Horowitz — Wikipedia,
    <https://en.wikipedia.org/wiki/Eliot_Horowitz>
- 10gen originally aimed to build an **open-source platform-as-a-service (PaaS)**.
  Unable to find an existing database that fit their cloud architecture, the
  team built a document-oriented database — MongoDB — as a component, then
  pivoted to focus on the database itself.
  - Source: MongoDB Inc. — Wikipedia,
    <https://en.wikipedia.org/wiki/MongoDB_Inc.>
  - Note: MongoDB's own company history states 10gen "began developing MongoDB
    in 2007 as a component of a planned platform-as-a-service product" and
    "shifted to an open-source development model" in 2009. Source: MongoDB —
    Wikipedia, <https://en.wikipedia.org/wiki/MongoDB>

### 2009 — MongoDB first released, open-sourced under AGPL

- MongoDB **version 1.0** was released in **February 2009**. The name derives
  from "hu**mongo**us."
  - Source: MongoDB — Wikipedia, <https://en.wikipedia.org/wiki/MongoDB>
  - Source (name origin): "How Did MongoDB Get Its Name?" Morpheus,
    <https://morpheusdata.com/how-did-mongodb-get-its-name/>
- In 2009 10gen shifted to an open-source model, releasing the database (the
  server) under the **GNU AGPL v3**, with drivers under Apache 2.0. The data
  model is document/JSON-style, stored as **BSON** (binary JSON), and was
  marketed within the "NoSQL" movement.
  - Source (AGPL was the server license until 2018): MongoDB — Wikipedia,
    <https://en.wikipedia.org/wiki/MongoDB> ("On November 8, 2018 ... the
    software's license changed from AGPL 3.0 to SSPL"; "The last versions
    licensed as AGPL version 3 are 4.0.3 (stable) and 4.1.4.")
  - Could not verify (precise month/day the AGPL was first adopted): the exact
    date 10gen first applied AGPLv3 in 2009 was not pinned to a primary source
    in this research.

### ~2010 — The "MongoDB is web scale" meme and early durability criticism

- A satirical animated video lampooning NoSQL/MongoDB hype ("it's web scale!")
  circulated and was widely shared starting **September 2010**, posted on a blog
  titled "MongoDB is Web Scale."
  - Source (dated Sept 5, 2010 blog coverage): High Scalability, "Hilarious
    Video: Relational Database vs NoSQL Fanbois,"
    <http://highscalability.com/blog/2010/9/5/hilarious-video-relational-database-vs-nosql-fanbois.html>
    (the post credits Alex Popescu for surfacing the video and says "Whoever
    made this deserves a Webby"; it does not name the creator).
  - Note on dating: Know Your Meme's archived copy of the Xtranormal video lists
    a creation date of January 31, 2012, which is a re-upload — the meme itself
    was already circulating in September 2010 per the High Scalability post.
    Source: Know Your Meme, <https://knowyourmeme.com/videos/29985-xtranormal>
  - Could not verify: the identity of the original creator of the parody video.
- The meme became shorthand for hollow scalability marketing slogans
  ("web scale," "sharding") parroted without understanding.
  - Source: Hacker News discussion, "Mongo DB is web scale,"
    <https://news.ycombinator.com/item?id=1636198>

#### Durability criticism (attributed)

- MongoDB's **default write concern** historically acknowledged a write after a
  single node received it ("fire-and-forget"-style defaults), meaning
  acknowledged writes could be lost if a primary stepped down before
  replication.
  - This durability/consistency critique is most rigorously associated with
    **Kyle Kingsbury ("Aphyr")** and his **Jepsen** project.
- **May 18, 2013** — Aphyr's "Call Me Maybe: MongoDB" (Jepsen) tested MongoDB
  2.4.1/2.4.3 and reported that acknowledged writes were lost at every
  consistency level under partition.
  - Verbatim conclusion (attributed to Aphyr): "MongoDB is neither AP nor CP.
    The defaults can cause significant loss of acknowledged writes. The
    strongest consistency offered has bugs which cause false acknowledgements,
    and even if they're fixed, doesn't prevent false failures."
  - Source: Aphyr, "Jepsen: MongoDB,"
    <https://aphyr.com/posts/284-call-me-maybe-mongodb>
- **April 2015** — Aphyr published a follow-up on MongoDB stale reads.
  - Source: Aphyr, "Jepsen: MongoDB stale reads,"
    <https://aphyr.com/posts/322-jepsen-mongodb-stale-reads>
- **May 2020** — A commissioned Jepsen analysis of **MongoDB 4.2.6** found that
  even at the strongest read/write concerns it failed to preserve snapshot
  isolation, observing read skew, cyclic information flow, and that weak
  defaults could downgrade requested safety. (Attributed to Jepsen; coverage by
  InfoQ.)
  - Source (Jepsen report): <https://jepsen.io/analyses/mongodb-4.2.6>
  - Source (coverage): InfoQ, "Jepsen Disputes MongoDB's Data Consistency
    Claims," <https://www.infoq.com/news/2020/05/Jepsen-MongoDB-4-2-6/>

### August 27, 2013 — 10gen renamed MongoDB, Inc.

- On **August 27, 2013**, 10gen announced it would rename itself **MongoDB, Inc.**
  to align with its flagship product.
  - Source: MongoDB Inc. — Wikipedia,
    <https://en.wikipedia.org/wiki/MongoDB_Inc.>

### June 28, 2016 — MongoDB Atlas (managed cloud)

- At MongoDB World on **June 28, 2016**, MongoDB unveiled **MongoDB Atlas**, its
  fully managed database-as-a-service, initially on AWS with Azure and Google
  Cloud planned.
  - Source (MongoDB press release): "MongoDB Unveils MongoDB Atlas, The New
    Industry Standard For Database As A Service,"
    <https://www.mongodb.com/company/newsroom/press-releases/mongodb-unveils-mongodb-atlas-the-new-industry-standard-for-database-as-a-service>
  - Source (PR Newswire copy): <https://www.prnewswire.com/news-releases/mongodb-unveils-mongodb-atlas-the-new-industry-standard-for-database-as-a-service-300291043.html>

### October 2017 — IPO (Nasdaq: MDB)

- MongoDB filed for IPO on **September 21, 2017**, and priced its IPO at **$24
  per share**, raising roughly **$192 million**. Shares listed on **Nasdaq**
  under ticker **MDB** and began trading **October 19, 2017**, closing up about
  34% on the first day.
  - Source (filing date and name change): MongoDB Inc. — Wikipedia,
    <https://en.wikipedia.org/wiki/MongoDB_Inc.>
  - Source (IPO pricing, raise, first-day pop): Nasdaq/Investor's Business
    Daily, "MongoDB IPO Raises $192 Million As Stock Soars On First Trades,"
    <https://www.nasdaq.com/articles/mongodb-ipo-raises-192-million-stock-soars-first-trades-2017-10-19>
  - Source (SEC Form 424B4 prospectus): <https://www.sec.gov/Archives/edgar/data/0001441816/000104746917006446/a2233574z424b4.htm>
  - Note: Reporting on the exact first-trade date varies slightly (Oct 19 vs.
    Oct 20). The 424B4 and Nasdaq coverage support pricing on Oct 18 and first
    trades on Oct 19, 2017.

### October 16, 2018 — Relicensing from AGPLv3 to SSPL

See the [SSPL controversy](#the-sspl-licensing-controversy) section below for
detail. In short: on **October 16, 2018**, MongoDB announced the **Server Side
Public License (SSPL)** for MongoDB Community Server, replacing AGPLv3, and
submitted it to the **Open Source Initiative (OSI)** for approval.
- Source (MongoDB press release): "MongoDB Issues New Server Side Public License
  for MongoDB Community Server,"
  <https://www.mongodb.com/company/newsroom/press-releases/mongodb-issues-new-server-side-public-license-for-mongodb-community-server>
- Source (coverage): TechCrunch, "MongoDB switches up its open-source license,"
  <https://techcrunch.com/2018/10/16/mongodb-switches-up-its-open-source-license/>

### January 9, 2019 — AWS launches Amazon DocumentDB

- On **January 9, 2019**, AWS announced **Amazon DocumentDB (with MongoDB
  compatibility)**, a managed document database supporting the MongoDB API —
  widely read as a response to the SSPL relicensing.
  - Source (AWS press release): "AWS Announces Amazon DocumentDB (with MongoDB
    Compatibility),"
    <https://press.aboutamazon.com/2019/1/aws-announces-amazon-documentdb-with-mongodb-compatibility>
  - Source (coverage): InfoQ, "AWS Launches New Document-Oriented Database
    Compatible with MongoDB,"
    <https://www.infoq.com/news/2019/01/aws-documentdb-mongodb/>

### March 2019 — MongoDB withdraws SSPL from OSI review

- In **March 2019** (the withdrawal message is dated **March 9, 2019**), MongoDB
  withdrew the SSPL from OSI's license-review process after sustained criticism
  that it failed the Open Source Definition.
  - Source (coverage): Open Source For You, "MongoDB withdraws its controversial
    SSPL from OSI consideration,"
    <https://www.opensourceforu.com/2019/03/mongodb-withdraws-its-server-side-public-license-from-osi-consideration-process/>
  - Source (analysis with quoted withdrawal text): Lukas Atkinson, "MongoDB no
    longer seeks OSI approval for SSPL,"
    <https://lukasatkinson.de/2019/mongodb-no-longer-seeks-osi-approval-for-sspl/>

### December 4, 2023 — Atlas Vector Search GA (AI era)

- On **December 4, 2023**, MongoDB announced general availability of **MongoDB
  Atlas Vector Search** (and dedicated Atlas Search Nodes), positioning Atlas
  for generative-AI / RAG workloads.
  - Source (MongoDB press release): "MongoDB Announces General Availability of
    New Capabilities to Power Next-Generation Applications,"
    <https://www.mongodb.com/company/newsroom/press-releases/mongo-db-announces-general-availability-of-new-capabilities-to-power-next-generation-apps>
  - Source (PR Newswire copy): <https://www.prnewswire.com/news-releases/mongodb-announces-general-availability-of-new-capabilities-to-power-next-generation-applications-302004077.html>

---

## Key people & teams

- **Dwight Merriman** — co-founder; former DoubleClick founder/CTO; early
  chairman/architect.
  - Source: <https://en.wikipedia.org/wiki/MongoDB_Inc.>
- **Eliot Horowitz** — co-founder; long-serving CTO; the principal public voice
  defending the SSPL relicensing. Former DoubleClick engineer and ShopWiki
  co-founder.
  - Source: <https://en.wikipedia.org/wiki/Eliot_Horowitz>
  - Source (SSPL quotes): TechCrunch,
    <https://techcrunch.com/2018/10/16/mongodb-switches-up-its-open-source-license/>
- **Kevin P. Ryan** — co-founder; former DoubleClick CEO and Gilt Groupe
  founder.
  - Source: <https://en.wikipedia.org/wiki/MongoDB_Inc.>
- **Dev Ittycheria** — President & CEO (the executive who presented Atlas as a
  major milestone in 2016 and led the company through its IPO and cloud
  transformation).
  - Source (Atlas launch quote): MongoDB press release,
    <https://www.mongodb.com/company/newsroom/press-releases/mongodb-unveils-mongodb-atlas-the-new-industry-standard-for-database-as-a-service>
- **Mark Porter** — CTO (as of 2021); publicly disputed AWS DocumentDB's
  "MongoDB compatibility" claim.
  - Source: The Register,
    <https://www.theregister.com/2021/12/06/aws_documentdb_not_mongodb_compatible/>
- **Kyle Kingsbury ("Aphyr")** — independent researcher, creator of **Jepsen**;
  externally drove the durability/consistency critique of MongoDB (2013, 2015,
  and the 2020 commissioned analysis).
  - Source: <https://aphyr.com/posts/284-call-me-maybe-mongodb> ;
    <https://jepsen.io/analyses/mongodb-4.2.6>

---

## Company & corporate history

- **2007:** Founded as **10gen** in NYC; original goal an open-source PaaS.
  (<https://en.wikipedia.org/wiki/MongoDB_Inc.>)
- **2009:** Pivoted to the database; **MongoDB 1.0** released (Feb 2009);
  open-sourced (server under AGPLv3). (<https://en.wikipedia.org/wiki/MongoDB>)
- **Aug 27, 2013:** Renamed **MongoDB, Inc.**
  (<https://en.wikipedia.org/wiki/MongoDB_Inc.>)
- **Jun 28, 2016:** **MongoDB Atlas** launched (managed cloud DBaaS).
  (<https://www.mongodb.com/company/newsroom/press-releases/mongodb-unveils-mongodb-atlas-the-new-industry-standard-for-database-as-a-service>)
- **Oct 2017:** **IPO on Nasdaq (MDB)**, ~$24/share, ~$192M raised.
  (<https://www.nasdaq.com/articles/mongodb-ipo-raises-192-million-stock-soars-first-trades-2017-10-19>)
- **Oct 16, 2018:** Relicensed Community Server to **SSPL**.
  (<https://www.mongodb.com/company/newsroom/press-releases/mongodb-issues-new-server-side-public-license-for-mongodb-community-server>)
- **2016 → present — cloud transformation:** MongoDB shifted from a
  support/license business to a cloud-first company; **Atlas became the majority
  of revenue**. Multiple sources report Atlas at roughly 70% of revenue by 2024.
  - Source (Atlas ~70% of revenue by 2024): Wikipedia summary citing this figure,
    <https://en.wikipedia.org/wiki/MongoDB_Inc.>
  - Note: For precise, audited revenue mix figures, see MongoDB's SEC filings
    (10-K / 10-Q) at <https://investors.mongodb.com/>. Could not verify an exact
    quarter-by-quarter Atlas revenue percentage against a primary filing in this
    research; the ~70% figure is from secondary summaries.
- **AI era:** **Atlas Vector Search** reached GA on **Dec 4, 2023**, repositioning
  Atlas as a vector database for generative-AI/RAG.
  (<https://www.mongodb.com/company/newsroom/press-releases/mongo-db-announces-general-availability-of-new-capabilities-to-power-next-generation-apps>)

---

## Controversies (durability, SSPL, DocumentDB)

### 1. Durability / "web scale" criticism

- The ~2010 **"MongoDB is web scale"** parody video crystallized criticism that
  MongoDB's marketing outran its engineering, particularly around default
  durability.
  - Source: High Scalability (Sept 5, 2010),
    <http://highscalability.com/blog/2010/9/5/hilarious-video-relational-database-vs-nosql-fanbois.html>
- The substantive technical critique came from **Aphyr's Jepsen** work:
  - **2013:** acknowledged writes lost at all consistency levels (MongoDB 2.4).
    Attributed to Aphyr. Source:
    <https://aphyr.com/posts/284-call-me-maybe-mongodb>
  - **2015:** stale reads. Source:
    <https://aphyr.com/posts/322-jepsen-mongodb-stale-reads>
  - **2020:** MongoDB 4.2.6 failed snapshot isolation at strongest concerns;
    weak defaults could silently downgrade safety. Attributed to Jepsen.
    Source: <https://jepsen.io/analyses/mongodb-4.2.6> ; coverage:
    <https://www.infoq.com/news/2020/05/Jepsen-MongoDB-4-2-6/>
- Root issue (attributed to these analyses): MongoDB's **default write concern**
  acknowledged on a single node, so acknowledged writes could be rolled back on
  failover unless users explicitly requested majority write/read concern.

### 2. The SSPL licensing controversy (Oct 2018)

- **What happened:** On **October 16, 2018**, MongoDB moved Community Server from
  **AGPLv3** to the new **Server Side Public License (SSPL)**. The stated goal
  was to stop cloud providers from offering MongoDB-as-a-service without
  contributing back.
  - Source (MongoDB press release): <https://www.mongodb.com/company/newsroom/press-releases/mongodb-issues-new-server-side-public-license-for-mongodb-community-server>
  - Source (full license text): MongoDB SSPL,
    <https://www.mongodb.com/legal/licensing/server-side-public-license> ;
    SPDX text, <https://spdx.org/licenses/SSPL-1.0.html>
- **Motivation (attributed to MongoDB CTO Eliot Horowitz):** "once an open source
  project becomes interesting, it is too easy for cloud vendors who have not
  developed the software to capture all of the value but contribute nothing
  back."
  - Source: TechCrunch,
    <https://techcrunch.com/2018/10/16/mongodb-switches-up-its-open-source-license/>
- **The SSPL's core change:** SSPL is AGPL-derived but adds **Section 13**,
  requiring anyone offering the software "as a service" to open-source the
  entire service stack (management, orchestration, etc.) under SSPL.
  - Source (license text): <https://spdx.org/licenses/SSPL-1.0.html>
- **OSI did NOT approve SSPL.** MongoDB submitted it to the OSI in 2018 and
  **withdrew it in March 2019** amid criticism that it failed the Open Source
  Definition. SSPL remains **not OSI-approved** and is **not** recognized as
  open source by the OSI or FSF-aligned distributions.
  - Source (withdrawal): <https://www.opensourceforu.com/2019/03/mongodb-withdraws-its-server-side-public-license-from-osi-consideration-process/>
  - Source (Wikipedia summary of OSI status): <https://en.wikipedia.org/wiki/Server_Side_Public_License>
- **Critic positions (attributed):**
  - Red Hat's **Tom Callaway** said SSPL is "intentionally crafted to be
    aggressively discriminatory towards a specific class of users," and that
    treating it as Free/Open Source "casts a shadow across all other licenses in
    the FOSS ecosystem." Source (coverage quoting Callaway): GeekWire,
    <https://www.geekwire.com/2019/mongodbs-licensing-changes-led-red-hat-drop-database-latest-version-server-os/>
  - ScyllaDB (a competitor) published a pointed critique. Source: "The Dark Side
    of MongoDB's New License,"
    <https://www.scylladb.com/2018/10/22/the-dark-side-of-mongodbs-new-license/>
    (note: ScyllaDB is a market competitor; weigh accordingly).
- **Distributions dropped MongoDB:**
  - **Red Hat** removed MongoDB from **RHEL 8** (flagged in the RHEL 8.0 beta
    release notes, late 2018) and from **Fedora** over SSPL.
    Source: GeekWire,
    <https://www.geekwire.com/2019/mongodbs-licensing-changes-led-red-hat-drop-database-latest-version-server-os/>
  - **Fedora** added SSPLv1 to its list of disallowed licenses, determining it is
    **not a Free Software license**. Source: Packt Hub,
    <https://hub.packtpub.com/red-hat-drops-mongodb-over-concerns-related-to-its-server-side-public-license-sspl/>
  - **Debian** dropped MongoDB; Debian Project Leader **Chris Lamb** said SSPL is
    "clearly not in the spirit of" Debian's free software guidelines. Source:
    Packt Hub (above) and developpez.com coverage,
    <https://www.developpez.com/actu/241843/Apres-Debian-Red-Hat-supprime-MongoDB-de-RHEL-8-et-Fedora-a-cause-de-sa-licence-SSPL-dont-le-statut-de-licence-libre-ou-open-source-est-conteste/>
    (Note: the verbatim Chris Lamb quote above is relayed via secondary coverage;
    the original Debian-legal thread was not fetched directly in this research —
    Could not verify the exact original wording against the primary mailing-list
    post.)
- **Landmark relicensing event / the "relicensing era":** MongoDB's SSPL is
  widely treated as the opening move of a broader wave of source-available
  relicensing by infrastructure companies — later joined by **Redis** (RSALv2/
  SSPL in 2024), **Elastic** (SSPL/Elastic License in 2021), **HashiCorp**
  (BSL in 2023), **Confluent**, **CockroachDB**, and others — all reacting to
  hyperscalers monetizing open-source software as managed services.
  - Source (SSPL as a precedent / relicensing context): Wikipedia,
    <https://en.wikipedia.org/wiki/Server_Side_Public_License>
  - Could not verify in this research (left for cross-referencing against the
    project's relicensing-era notes): exact dates/licenses for each of the
    other companies above are summarized from general knowledge and should be
    independently cited where used in CODE_GENERATION.md or a relicensing doc.

### 3. AWS DocumentDB (Jan 2019) and the "compatibility" dispute

- **AWS's response to SSPL:** On **January 9, 2019**, AWS launched **Amazon
  DocumentDB (with MongoDB compatibility)** — a purpose-built document database
  exposing the MongoDB API, built over more than two years.
  - Source: AWS press release,
    <https://press.aboutamazon.com/2019/1/aws-announces-amazon-documentdb-with-mongodb-compatibility>
- **MongoDB disputed the "compatibility" claim (attributed):** On **December 6,
  2021**, MongoDB CTO **Mark Porter** told The Register DocumentDB "is not
  MongoDB compatible. That is an untruth… it is 34 per cent compatible, through
  our tests," calling it a "Frankenbase" lacking aggregation and change streams,
  and describing it as "our Apache 2.0 drivers" plus "a plug-in for PostgreSQL."
  - Source: The Register,
    <https://www.theregister.com/2021/12/06/aws_documentdb_not_mongodb_compatible/>
  - Attribution note: the "34 per cent" figure is MongoDB's own internal test
    result as relayed by its CTO — i.e., an interested party's claim, not an
    independent benchmark.

---

## Open items / could not verify

- Exact month/day in 2009 that 10gen first applied AGPLv3 to the server.
- Identity of the original creator of the "MongoDB is web scale" parody video
  (and definitive original publication date — Sept 2010 circulation is sourced;
  the Jan 31, 2012 date on Know Your Meme is a re-upload).
- Precise first-trade date of the IPO (Oct 19 vs. Oct 20, 2017) — sources differ;
  Oct 19, 2017 is supported by Nasdaq coverage and the 424B4 timeline.
- Exact, audited Atlas share of revenue against a primary SEC filing (the ~70%
  figure is from secondary summaries; verify against MongoDB 10-K/10-Q at
  <https://investors.mongodb.com/>).
- Verbatim original wording of Chris Lamb's Debian-legal statement (relayed via
  secondary coverage here).
