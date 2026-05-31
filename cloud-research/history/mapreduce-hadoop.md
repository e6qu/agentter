# MapReduce, Hadoop, and the Big-Data Era: A Sourced History

This is a chronological, fully-sourced history of **MapReduce**, **Hadoop**, and
the open-source big-data movement they seeded — from the three Google papers
(**GFS 2003**, **MapReduce 2004**, **Bigtable 2006**) through the Hadoop
ecosystem, the **big-data company wars** (Cloudera, Hortonworks, MapR), and the
decline of on-prem HDFS/MapReduce in the face of **Apache Spark**, **cloud object
storage**, **cloud data warehouses**, and the **lakehouse**.

This doc focuses on the *history and market story* of the Hadoop era. It
deliberately **cross-references** rather than duplicates several sibling docs:

- For the "**Big Data is Dead**" framing (Jordan Tigani) and the in-process
  analytics counter-movement, see [`duckdb.md`](./duckdb.md).
- For **object storage replacing HDFS** (S3, the flat namespace, the S3 API as a
  de-facto standard), see [`s3-object-storage.md`](./s3-object-storage.md).
- For the surrounding **data landscape** — the relational mainstay and the NoSQL
  reaction that Bigtable helped inspire — see [`postgresql.md`](./postgresql.md)
  and [`mongodb.md`](./mongodb.md).

Every factual claim below carries an inline source. Where a claim could not be
pinned to a primary or reputable secondary source, it is marked
**"Could not verify."** Opinions are attributed to the person or outlet that
expressed them.

---

## Timeline

### 2003-10 — Google publishes the **Google File System** paper (SOSP 2003)

Sanjay Ghemawat, Howard Gobioff, and Shun-Tak Leung presented **"The Google File
System"** at the 19th ACM Symposium on Operating Systems Principles (SOSP 2003),
Bolton Landing, NY. It described a scalable distributed file system for large
data-intensive applications running on inexpensive commodity hardware, providing
fault tolerance and high aggregate throughput.
- Google's hosted PDF (authors verbatim: "Sanjay Ghemawat, Howard Gobioff, and
  Shun-Tak Leung"): https://research.google.com/archive/gfs-sosp2003.pdf
- ACM DL record (SOSP '03): https://dl.acm.org/doi/10.1145/945445.945450

### 2004-12 — Google publishes the **MapReduce** paper (OSDI 2004)

**Jeffrey Dean and Sanjay Ghemawat** presented **"MapReduce: Simplified Data
Processing on Large Clusters"** at the 6th Symposium on Operating Systems Design
and Implementation (OSDI 2004), San Francisco, Dec 6–8, 2004 (pp. 137–150). The
paper defined the **programming model**: a user-supplied `map` function emits
intermediate key/value pairs, and a `reduce` function merges all values for a
key — with the framework handling partitioning, scheduling, fault tolerance, and
machine communication.
- Google's hosted PDF: https://research.google.com/archive/mapreduce-osdi04.pdf
- Google Research listing (authors: Jeffrey Dean, Sanjay Ghemawat):
  https://research.google/pubs/mapreduce-simplified-data-processing-on-large-clusters/
- USENIX OSDI '04 record:
  https://www.usenix.org/conference/osdi-04/mapreduce-simplified-data-processing-large-clusters

### 2006-04-01 — Hadoop's first release (0.1.0); the code splits out of Nutch

Doug Cutting and Mike Cafarella had built a Java implementation of GFS (the
"Nutch Distributed File System") and MapReduce inside **Apache Nutch**; in
**January 2006** that code was factored into a new subproject, **Hadoop**.
Hadoop **0.1.0** was released **April 1, 2006**.
- Apache Hadoop, Wikipedia (subproject relocated January 2006; "0.1.0 was
  released in April 2006"; the factored-out code was ~5,000 lines of HDFS and
  ~6,000 lines of MapReduce): https://en.wikipedia.org/wiki/Apache_Hadoop

### 2006-10 — Google publishes the **Bigtable** paper (OSDI 2006)

Fay Chang, Jeffrey Dean, Sanjay Ghemawat, and others presented **"Bigtable: A
Distributed Storage System for Structured Data"** at OSDI 2006 — a distributed
storage system designed to scale to petabytes across thousands of commodity
servers, with a sparse, multidimensional sorted-map data model. It directly
inspired the open-source **HBase** and **Apache Cassandra**.
- Google Research listing: https://research.google/pubs/bigtable-a-distributed-storage-system-for-structured-data/
- USENIX OSDI '06 record: https://www.usenix.org/conference/osdi-06/bigtable-distributed-storage-system-structured-data

### 2008-01 — Hadoop becomes a top-level Apache project

Hadoop graduated to a **top-level Apache project in January 2008**; by then
Facebook, Last.fm, the New York Times, and others were using it.
- "A Brief History of Apache Hadoop" (Hadoop: The Definitive Guide):
  https://foreti.me/Hadoop-The-Definitive-Guide-4th/part-i-hadoop-fundamentals/chapter-1-meet-hadoop/a-brief-history-of-apache-hadoop.html
- Apache Hadoop, Wikipedia: https://en.wikipedia.org/wiki/Apache_Hadoop

### 2008-06-27 — **Cloudera** is founded

Cloudera, Inc. was formed June 27, 2008 in Burlingame, CA by Christophe
Bisciglia (ex-Google), Amr Awadallah (ex-Yahoo!), Jeff Hammerbacher
(ex-Facebook), and CEO Mike Olson (ex-Oracle; his prior company **Sleepycat** —
maker of Berkeley DB — was acquired by Oracle in 2006).
- Cloudera, Wikipedia (founding date, founders, prior employers verbatim):
  https://en.wikipedia.org/wiki/Cloudera

### 2008-08 — **Hive** open-sourced at Facebook (SQL-on-Hadoop)

Facebook open-sourced **Apache Hive** in August 2008 — a SQL-like declarative
language, **HiveQL**, compiled into MapReduce jobs — co-created by **Joydeep Sen
Sarma** and **Ashish Thusoo**. Hive entered the Apache Incubator in 2008 and
became a top-level Apache project in **October 2010**.
- Apache Hive, Wikipedia: https://en.wikipedia.org/wiki/Apache_Hive
- Meta Engineering, "Hive – A Petabyte Scale Data Warehouse using Hadoop"
  (2009-06-10): https://engineering.fb.com/2009/06/10/web/hive-a-petabyte-scale-data-warehouse-using-hadoop/

### 2009 — Doug Cutting joins Cloudera as Chief Architect

Cloudera's four founders "were joined in 2009 by Doug Cutting, a co-founder of
Hadoop." Cutting is widely described as Cloudera's **Chief Architect**.
- Cloudera, Wikipedia: https://en.wikipedia.org/wiki/Cloudera

### 2009-06 — **MapR** is founded

MapR Technologies was founded in 2009 by **John Schroeder** (CEO/Chairman) and
**M.C. Srivas** (CTO). MapR built a proprietary, POSIX-style distributed file
system (**MapR-FS**) intended to overcome HDFS limitations (random read/write,
NFS access).
- MapR, Wikiwand (founders, founding year): https://www.wikiwand.com/en/MapR
- John Schroeder interview (background as CEO/co-founder):
  https://www.cleverism.com/mapr-interview-with-its-ceo-co-founder-john-schroeder/

### 2011-06 — **Hortonworks** spins out of Yahoo!

Yahoo! spun out its core Hadoop engineering team into **Hortonworks**, funded
with ~$23M from Yahoo! and Benchmark Capital. **Eric Baldeschwieler** (known as
"Eric14") was the founding CEO; **Rob Bearden** (ex-COO of SpringSource and
JBoss) ran business operations as President.
- InfoQ (2011-06): https://www.infoq.com/news/2011/06/hortonworks/
- The Register, "Yahoo! seeds Hadoop startup" (2011-06-28):
  https://www.theregister.com/2011/06/28/yahoo_spins_off_hadoop_startup/
- Hortonworks, Wikipedia: https://en.wikipedia.org/wiki/Hortonworks

### 2013-10 — **Hadoop 2.0 / YARN** ships (GA)

YARN ("Yet Another Resource Negotiator") **decoupled cluster resource management
and scheduling from MapReduce**, letting Hadoop run interactive, streaming, and
other workloads alongside batch. It was a key feature of Hadoop 2.0, which became
generally available in **October 2013**.
- TechTarget, "What is Apache Hadoop YARN?":
  https://www.techtarget.com/searchdatamanagement/definition/Apache-Hadoop-YARN-Yet-Another-Resource-Negotiator

### 2014-06 — Google publicly moves off MapReduce (Cloud Dataflow)

At Google I/O 2014, Google announced **Cloud Dataflow** as a successor to
MapReduce. Urs Hölzle (SVP, Technical Infrastructure) said Google had effectively
stopped relying on MapReduce, which "became too cumbersome" once data reached a
few petabytes.
- Data Center Knowledge, "Hello Dataflow, Goodbye MapReduce" coverage:
  https://www.datacenterknowledge.com/hyperscalers/google-dumps-mapreduce-in-favor-of-new-hyper-scale-analytics-system
- InformationWeek, "Google I/O: Hello Dataflow, Goodbye MapReduce":
  https://www.informationweek.com/software-as-a-service/google-i-o-hello-dataflow-goodbye-mapreduce

### 2014-12-11 — **Hortonworks IPO** (NASDAQ: HDP)

Hortonworks priced its IPO at **$16/share** (above the $12–14 range), raising
~$100M; shares closed their first day at **$26.48**.
- VentureBeat (2014-12-11): https://venturebeat.com/2014/12/11/hortonworks-ipo-pricing/
- Hortonworks Form 424B4 (final IPO prospectus):
  https://www.sec.gov/Archives/edgar/data/0001610532/000119312514440570/d748349d424b4.htm

### 2017-04-28 — **Cloudera IPO** (NYSE: CLDR)

Cloudera priced its IPO at **$15/share** (above the $12–14 range), raising
~$225M; it began trading **April 28, 2017** and closed its debut up ~20%.
- Cloudera press release (pricing): https://www.cloudera.com/about/news-and-blogs/press-releases/2017-04-27-cloudera-announces-pricing-of-initial-public-offering-marking-its-debut-as-a-public-company.html
- CNBC (first-day trading): https://www.cnbc.com/2017/04/28/cloudera-ipo-cldr-opening-price-on-first-trading-day.html

### 2018-10-03 — **Cloudera + Hortonworks** announce a "merger of equals"

The two largest Hadoop distributors announced an **all-stock merger of equals**
with combined fully-diluted equity value of **~$5.2 billion** (based on Oct 2,
2018 closing prices). Cloudera holders would own ~60%, Hortonworks ~40%; each
Hortonworks share would convert to 1.305 Cloudera shares.
- Joint announcement (SEC Form 425 exhibit 99.1):
  https://www.sec.gov/Archives/edgar/data/0001610532/000162828018012255/cldr8-k10318ex991.htm

### 2019-01-03 — Cloudera–Hortonworks merger **closes**

The merger closed in early January 2019, creating a single combined Cloudera.
- Could not verify the exact close *date* from a single primary press release in
  this research pass; the deal was announced for Q1 2019 close (see Form 425
  above) and is widely reported as completing in early January 2019. Treat the
  precise day as approximate.

### 2019-08-05 — **MapR** assets sold to **HPE** (fire sale)

After warning in May 2019 that it might shut down without new funding, MapR sold
its business assets to **Hewlett Packard Enterprise**. The price was widely
reported as **under $50M** — for a company that had raised ~$280M.
- TechCrunch, "With MapR fire sale, Hadoop's promise has fallen on hard times"
  (2019-08-07): https://techcrunch.com/2019/08/07/with-mapr-fire-sale-hadoops-promise-has-fallen-on-hard-times/
- BigDATAwire, "HPE Acquires MapR" (2019-08-05):
  https://www.hpcwire.com/bigdatawire/2019/08/05/hpe-acquires-mapr/

### 2021-06-01 → 2021-10-08 — **Cloudera taken private** by CD&R and KKR ($5.3B)

Cloudera agreed to be acquired by **Clayton, Dubilier & Rice** and **KKR** in an
all-cash deal valued at **~$5.3 billion** ($16/share). Announced June 1, 2021;
completed **October 8, 2021**, ending Cloudera's run as a public company.
- Cloudera press release (announcement, $5.3B):
  https://www.cloudera.com/about/news-and-blogs/press-releases/2021-06-01-cloudera-enters-into-definitive-agreement-to-be-acquired-by-clayton-dubilier-and-rice-and-kkr-for-5-point-3-billion-dollars.html
- Cloudera press release (completion, "Completes Agreement to Become a Private
  Company"):
  https://www.prnewswire.com/news-releases/cloudera-completes-agreement-to-become-a-private-company-301396189.html

---

## The Google papers

The open-source big-data movement was, in a very direct sense, an *exercise in
re-implementing Google's published infrastructure*. Three papers form the
foundation:

**GFS (2003)** — Ghemawat, Gobioff, Leung. A distributed file system optimized
for large files, append-heavy workloads, and cheap, failure-prone commodity
disks; it tolerated failures as the normal case rather than the exception.
- https://research.google.com/archive/gfs-sosp2003.pdf

**MapReduce (2004)** — Jeffrey Dean & Sanjay Ghemawat. The programming model that
made cluster-scale data processing accessible: write a `map` and a `reduce`, and
the framework handles distribution, parallelism, fault tolerance, and
re-execution of failed tasks. It is the paper after which this whole era is
named.
- https://research.google.com/archive/mapreduce-osdi04.pdf

**Bigtable (2006)** — Chang, Dean, Ghemawat, et al. A wide-column, sorted-map
store on top of GFS. It seeded the NoSQL wide-column lineage — most directly
**HBase** and **Apache Cassandra**. (For the broader NoSQL reaction to the
relational status quo, see [`mongodb.md`](./mongodb.md) and
[`postgresql.md`](./postgresql.md).)
- https://research.google/pubs/bigtable-a-distributed-storage-system-for-structured-data/

### The Dean / Ghemawat legend (attributed)

Jeff Dean and Sanjay Ghemawat are Google's first and only **Senior Fellows /
"Level 11"** engineers, and the *only* two authors of the original MapReduce
paper — a partnership chronicled by James Somers in The New Yorker, "The
Friendship That Made Google Huge," which describes them famously
**pair-programming at a single keyboard**.
- The New Yorker piece (as summarized/linked by Simon Willison):
  https://simonwillison.net/2018/Dec/31/the-friendship-that-made-google-huge/

Dean separately became an internet meme via **"Jeff Dean facts"** — Chuck
Norris-style jokes about his programming prowess ("Compilers don't warn Jeff
Dean. Jeff Dean warns compilers."). Slate traced the phenomenon and Google's
Allen School (UW) credits Google engineer **Kenton Varda** with originating the
list (circulated internally on April 1).
- Slate, "Jeff Dean facts" (2013-01):
  https://slate.com/technology/2013/01/jeff-dean-facts-how-a-google-programmer-became-the-chuck-norris-of-the-internet.html
- UW Allen School News (Varda, April Fool's origin):
  https://news.cs.washington.edu/2012/01/25/astounding-facts-about-googles-most-badass-engineer-jeff-dean/
- Note: sources disagree on the exact year (2007 vs 2008) the "facts" list was
  first circulated internally. **Could not verify** a single authoritative date;
  treat the year as approximate.

---

## Hadoop & the ecosystem

**Origins.** Hadoop grew out of **Apache Nutch**, the open-source web crawler
Doug Cutting and **Mike Cafarella** (then a University of Washington grad
student) built to make the web "searchable." Nutch needed distributed storage and
compute to scale; Google's **GFS (2003)** and **MapReduce (2004)** papers
supplied the blueprint, which Cutting and Cafarella implemented in Java
(initially as the **Nutch Distributed File System**, later **HDFS**). In January
2006 that subsystem was carved out into **Hadoop**.
- Apache Hadoop, Wikipedia: https://en.wikipedia.org/wiki/Apache_Hadoop
- BigDATAwire, "From Spiders to Elephants: The History of Hadoop":
  https://www.bigdatawire.com/2015/04/15/from-spiders-to-elephants-the-history-of-hadoop/

**The name.** Cutting named the project after his young son's **yellow toy
elephant** called "Hadoop."
- Apache Hadoop, Wikipedia ("named it after his son's toy elephant"):
  https://en.wikipedia.org/wiki/Apache_Hadoop

**Doug Cutting's other projects.** Beyond Hadoop and Nutch, Cutting created
**Apache Lucene** (the Java text-search library, first written 1999, released
2000, donated to Apache in 2001) and later **Apache Avro** (a data-serialization
system).
- Doug Cutting, Wikipedia: https://en.wikipedia.org/wiki/Doug_Cutting
- Apache Lucene, Wikipedia: https://en.wikipedia.org/wiki/Apache_Lucene

**Yahoo!** Cutting joined **Yahoo!** (reported as January 2006), which invested
heavily in Hadoop and ran what were then the **largest clusters** in production.
- InformationWeek, "Hadoop At 10: Doug Cutting On Making Big Data Work":
  https://www.informationweek.com/software-services/hadoop-at-10-doug-cutting-on-making-big-data-work

**The core stack.** Classic Hadoop = **HDFS** (the GFS-style distributed file
system) + **Hadoop MapReduce** (the batch compute engine). Hadoop 2.0 (2013)
added **YARN** to separate resource management from MapReduce (see timeline).

**The surrounding ecosystem** ("the zoo"):

- **Hive** (Facebook, 2008) — SQL-on-Hadoop via HiveQL, compiled to MapReduce.
  https://en.wikipedia.org/wiki/Apache_Hive
- **Pig** (Yahoo!) — the **Pig Latin** dataflow scripting language; Yahoo
  reported that a large majority of its MapReduce work ran through Pig.
  https://www.geeksforgeeks.org/dbms/hadoop-ecosystem/
- **HBase** — an open-source, distributed, column-oriented store **modeled on
  Google's Bigtable paper**.
  https://www.analyticsvidhya.com/blog/2022/10/a-brief-introduction-to-apache-hbase-and-its-architecture/
- **ZooKeeper** (Yahoo!) — a distributed coordination service (named for managing
  the "zoo" of animal-named projects); functionally a clone of Google's
  **Chubby** lock service.
  https://www.geeksforgeeks.org/dbms/hadoop-ecosystem/
- **Sqoop, Oozie, Flume, Mahout** — bulk RDBMS import/export, workflow
  scheduling, log ingestion, and machine-learning libraries respectively; all
  part of the broader Hadoop ecosystem.
  https://www.geeksforgeeks.org/dbms/hadoop-ecosystem/
  - Note on the secondary sources above: the GeeksforGeeks / Analytics Vidhya
    pages are tutorial sites, not primary records. The *existence and lineage* of
    these projects is well established, but specific origin dates for
    Pig/Sqoop/Oozie/Flume/Mahout were **not individually verified to a primary
    Apache source** in this pass. **Could not verify** exact per-project dates.

---

## Key people & teams

- **Sanjay Ghemawat** — co-author of GFS, MapReduce, and Bigtable; Google Senior
  Fellow. https://research.google.com/archive/gfs-sosp2003.pdf
- **Jeffrey (Jeff) Dean** — co-author of MapReduce and Bigtable; Google Senior
  Fellow; later head of Google AI. The MapReduce paper lists only Dean and
  Ghemawat. https://research.google.com/archive/mapreduce-osdi04.pdf
- **Howard Gobioff** and **Shun-Tak Leung** — GFS co-authors.
  https://research.google.com/archive/gfs-sosp2003.pdf
- **Doug Cutting** — creator of Lucene, Nutch, Hadoop (with Cafarella), and Avro;
  joined Yahoo! (2006), then Cloudera Chief Architect (2009).
  https://en.wikipedia.org/wiki/Doug_Cutting
- **Mike Cafarella** — Hadoop co-creator; UW grad student during Nutch.
  https://en.wikipedia.org/wiki/Apache_Hadoop
- **Mike Olson** — Cloudera co-founder/CEO; ex-Oracle, ex-Sleepycat (Berkeley DB).
  https://en.wikipedia.org/wiki/Cloudera
- **Amr Awadallah** (ex-Yahoo!), **Jeff Hammerbacher** (ex-Facebook),
  **Christophe Bisciglia** (ex-Google) — Cloudera co-founders.
  https://en.wikipedia.org/wiki/Cloudera
- **Eric Baldeschwieler ("Eric14")** — Hortonworks founding CEO, ex-Yahoo!.
  https://www.infoq.com/news/2011/06/hortonworks/
- **Rob Bearden** — Hortonworks President (later CEO), ex-SpringSource/JBoss.
  https://www.infoq.com/news/2011/06/hortonworks/
- **John Schroeder** and **M.C. Srivas** — MapR co-founders; Srivas had worked at
  Google on GFS/Bigtable infrastructure.
  https://www.wikiwand.com/en/MapR
- **Matei Zaharia** — created Spark at UC Berkeley AMPLab; Databricks co-founder.
  https://en.wikipedia.org/wiki/Matei_Zaharia
- **Joydeep Sen Sarma** and **Ashish Thusoo** — Hive co-creators at Facebook.
  https://en.wikipedia.org/wiki/Apache_Hive

---

## The big-data company wars

Three venture-backed companies built businesses on packaging, supporting, and
extending the open-source Hadoop stack — and spent a decade competing, then
consolidating:

**Cloudera (2008)** — the first mover. Founded by Bisciglia, Awadallah,
Hammerbacher, and CEO Mike Olson; **Doug Cutting joined as Chief Architect in
2009**. It took on heavy investment, including a **$740M Intel investment for an
18% stake in 2014**, and IPO'd in April 2017.
- Cloudera, Wikipedia (Intel stake, IPO): https://en.wikipedia.org/wiki/Cloudera

**Hortonworks (2011)** — the Yahoo! spinout, positioned as the "100% open source"
distribution, led by Baldeschwieler and Bearden. IPO'd December 2014.
- https://www.infoq.com/news/2011/06/hortonworks/

**MapR (2009)** — the proprietary-differentiation play, built around its own
high-performance file system (MapR-FS) rather than vanilla HDFS.
- https://www.wikiwand.com/en/MapR

**The consolidation.** The market never grew enough to sustain three players:

- **Hortonworks IPO** Dec 2014 (HDP, $16/share) →
  https://venturebeat.com/2014/12/11/hortonworks-ipo-pricing/
- **Cloudera IPO** Apr 2017 (CLDR, $15/share) →
  https://www.cnbc.com/2017/04/28/cloudera-ipo-cldr-opening-price-on-first-trading-day.html
- **Cloudera + Hortonworks merge** — announced Oct 3, 2018 (~$5.2B all-stock
  "merger of equals"), closed early Jan 2019 →
  https://www.sec.gov/Archives/edgar/data/0001610532/000162828018012255/cldr8-k10318ex991.htm
- **MapR fire-sale to HPE** — Aug 2019, assets sold for a reported <$50M →
  https://techcrunch.com/2019/08/07/with-mapr-fire-sale-hadoops-promise-has-fallen-on-hard-times/
- **Cloudera taken private** by CD&R + KKR — $5.3B, completed Oct 8, 2021 →
  https://www.cloudera.com/about/news-and-blogs/press-releases/2021-06-01-cloudera-enters-into-definitive-agreement-to-be-acquired-by-clayton-dubilier-and-rice-and-kkr-for-5-point-3-billion-dollars.html

TechCrunch's framing of the MapR sale (attributed opinion): the deal showed that
"Hadoop's promise has fallen on hard times."
- https://techcrunch.com/2019/08/07/with-mapr-fire-sale-hadoops-promise-has-fallen-on-hard-times/

---

## Decline & legacy (Spark, cloud, the lakehouse)

### Spark supersedes MapReduce

**Apache Spark** was started by **Matei Zaharia** at UC Berkeley's **AMPLab** in
**2009**, and open-sourced in **2010** under a BSD license. Its central
abstraction, the **Resilient Distributed Dataset (RDD)**, allowed datasets to be
kept **in memory** across operations and rebuilt on failure via lineage — making
Spark dramatically faster than disk-bound MapReduce for iterative workloads.
Spark was donated to the Apache Software Foundation (2013) and became a top-level
project (2014).
- Apache Spark, Wikipedia: https://en.wikipedia.org/wiki/Apache_Spark
- Matei Zaharia, Wikipedia: https://en.wikipedia.org/wiki/Matei_Zaharia
- BigDATAwire, "A Decade Later, Apache Spark Still Going Strong":
  https://www.hpcwire.com/bigdatawire/2019/03/08/a-decade-later-apache-spark-still-going-strong/

### Databricks (2013) and the lakehouse

The Spark creators founded **Databricks** in 2013 (co-founders include Matei
Zaharia, Ali Ghodsi, Ion Stoica, Reynold Xin, Patrick Wendell, Andy Konwinski,
and Arsalan Tavakoli-Shiraji), out of the same AMPLab lineage. Databricks later
developed **Delta Lake** (ACID transactions on data lakes) and popularized the
**"lakehouse"** architecture (data-warehouse semantics over cheap object
storage). (Databricks belongs in its own history; treated here only as the
Spark/lakehouse successor.)
- Databricks, Wikipedia: https://en.wikipedia.org/wiki/Databricks

### Open table formats: Delta Lake, Iceberg, Hudi

The lakehouse layer was completed by **open table formats** that bring
transactions, schema evolution, and time-travel to files in object storage:
- **Apache Hudi** — created at **Uber** (~2016) for incremental ingestion and
  row-level upserts; donated to Apache (2017).
- **Apache Iceberg** — created at **Netflix** to overcome Hive-on-S3 scaling
  limits; later an Apache project, now a broadly adopted standard.
- **Delta Lake** — created at **Databricks** (~2017).
- Onehouse comparison (origins of all three):
  https://www.onehouse.ai/blog/apache-hudi-vs-delta-lake-vs-apache-iceberg-lakehouse-feature-comparison
- Dremio comparison: https://www.dremio.com/blog/comparison-of-data-lake-table-formats-apache-iceberg-apache-hudi-and-delta-lake/
- Note: these are vendor/secondary sources; the *creators and rough years* are
  consistent across them, but exact founding dates were **not individually
  verified against primary Apache/Netflix/Uber sources** in this pass.

### Why on-prem HDFS/MapReduce became obsolete

Several forces converged around 2017–2019 to undercut the on-prem Hadoop model:

1. **Cloud object storage replaced HDFS.** Storing data in **Amazon S3** (and GCS/
   Azure Blob) decoupled storage from compute, eliminated the need to run and
   babysit HDFS clusters, and became the de-facto data-lake substrate. See
   [`s3-object-storage.md`](./s3-object-storage.md) for that story.
2. **Compute/storage separation + cloud data warehouses.** **Redshift**,
   **BigQuery**, and **Snowflake** let teams query large datasets with SQL
   without running MapReduce or managing a cluster.
3. **The lakehouse** (Delta Lake / Iceberg / Hudi) brought warehouse-grade
   transactions and management directly onto object-stored files.
4. **MapReduce itself fell out of favor** — even Google had moved on (Cloud
   Dataflow, 2014), and Spark displaced MapReduce as the default engine.

### The "Hadoop is dead" narrative (~2019), attributed

In 2019 — punctuated by MapR's collapse and the Cloudera–Hortonworks merger — a
"Hadoop is dead" narrative took hold in the trade press and on Wall Street.
- SingleStore, "Hadoop: The Chronicle of an Expected Decline":
  https://www.singlestore.com/blog/hadoop-the-chronicle-of-an-expected-decline/

That narrative was contested. **Arun C. Murthy** (a Hortonworks/Cloudera leader
and longtime Hadoop committer) pushed back in "Hadoop is Dead. Long live
Hadoop." — arguing the ecosystem's ideas had won even as the "Hadoop" brand
faded (attributed opinion).
- https://medium.com/@acmurthy/hadoop-is-dead-long-live-hadoop-f22069b264ac

The broader "**Big Data is Dead**" framing — that most organizations never had
data large enough to justify big-data tooling — was articulated by **Jordan
Tigani** (a founding BigQuery engineer, later MotherDuck co-founder) in his
2023 essay. That argument, and the in-process/analytics counter-movement it
represents, is covered in [`duckdb.md`](./duckdb.md) (cross-referenced here, not
duplicated).

### Current status / survivors

- **MapReduce** survives mainly as a *legacy* execution mode and as the
  conceptual ancestor of essentially every modern distributed data engine; Hive
  and others moved to Tez/Spark engines, and Spark is the default for new work.
- **HDFS, YARN, Hive, HBase, ZooKeeper** remain maintained Apache projects and
  still run in many enterprises, but greenfield architectures overwhelmingly
  favor **object storage + a query engine/warehouse + a lakehouse table format**.
- **The companies:** Cloudera (now private under CD&R/KKR) is the surviving
  pure-play distributor; MapR's technology lives inside HPE; Hortonworks no longer
  exists as an independent entity. **Databricks** (Spark/lakehouse) and the cloud
  warehouses (**Snowflake**, **BigQuery**, **Redshift**) are the commercial
  centers of gravity for large-scale analytics today.
- Sources as cited throughout the timeline above.

---

## "Could not verify" summary

- **Exact close date of the Cloudera–Hortonworks merger** (early January 2019):
  announced for Q1 2019 in the Form 425; the precise day was not pinned to a
  single primary press release here.
- **Exact origin year of "Jeff Dean facts"** (2007 vs 2008): sources disagree.
- **Per-project founding dates for Pig, Sqoop, Oozie, Flume, Mahout**: lineage is
  well established but exact dates were not verified to primary Apache sources.
- **Exact founding dates of Delta Lake / Iceberg / Hudi**: creators and rough
  years are consistent across secondary sources but not individually confirmed
  against primary records in this pass.
