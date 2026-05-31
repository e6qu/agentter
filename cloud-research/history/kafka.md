# Apache Kafka and Confluent: A Sourced History

This is a chronological, fully-sourced history of **Apache Kafka** — the distributed
commit-log / publish-subscribe streaming platform born at LinkedIn — and of
**Confluent**, the company its creators founded to commercialize it. It traces the
origin and naming, the conceptual core ("The Log"), the move to Apache, the
Confluent ecosystem (Connect, Streams, KSQL/ksqlDB, Schema Registry), the
**Confluent Community License** relicensing controversy, the removal of ZooKeeper
via **KRaft (KIP-500)**, and the recent diskless / object-storage Kafka wave.

The diskless / "Kafka-on-S3" trend (WarpStream, AutoMQ, Bufstream, Confluent
Freight, Redpanda) is part of the broader object-storage-as-a-substrate story
covered in [`s3-object-storage.md`](./s3-object-storage.md); that doc has the S3
side and is **cross-referenced here, not duplicated**. This doc focuses on the
Kafka/Confluent side of those events.

Every factual claim below carries an inline source. Where a claim could not be
pinned to a primary source, it is marked **"Could not verify."** Opinion and
controversy are attributed to the party who voiced them.

---

## Timeline

### 2010–2011 — Kafka is created at LinkedIn

Kafka was originally developed at **LinkedIn**, co-created by **Jay Kreps, Neha
Narkhede, and Jun Rao**, to solve LinkedIn's need for a high-throughput,
low-latency system to move massive volumes of real-time event/activity data
between systems. It is a **distributed, append-only commit log** that functions as
a **publish-subscribe** messaging platform — it retains messages in a durable,
ordered, append-only log rather than as a traditional destructive queue.
- Apache Kafka — Wikipedia (origin, creators, system classification):
  https://en.wikipedia.org/wiki/Apache_Kafka

**The name — after Franz Kafka.** Jay Kreps has stated the naming rationale
directly (originally on Quora). The widely-quoted version:
> "I thought that since Kafka was a system optimized for writing using a writer's
> name would make sense. I had taken a lot of lit classes in college and liked
> Franz Kafka. Plus the name sounded cool for an open source project."

- Quote attributed to Jay Kreps; reproduced from his Quora answer in multiple
  secondary collections, e.g.:
  https://alyjee.github.io/tech/2019/07/26/kafka-a-system-optimized-for-writing.html
  and discussed at
  https://www.quora.com/What-is-the-relation-between-Kafka-the-writer-and-Apache-Kafka-the-distributed-messaging-system
- **Attribution / verify note:** the *substance* of the quote ("system optimized
  for writing" → a writer's name; he liked Franz Kafka) is corroborated across
  sources including Wikipedia. I could **not** independently load the original
  Quora post in this pass to confirm the exact wording word-for-word, so the
  long-form quote above is **best treated as Kreps's reported phrasing** rather
  than a verbatim-verified primary quotation. **Could not verify** the exact
  original Quora wording from the primary URL.

### 2011 (early) — Kafka open-sourced; enters the Apache Incubator

Kafka was open-sourced by LinkedIn in **early 2011** (commonly dated to **January
2011**) under the **Apache License 2.0**, and entered the **Apache Incubator**.
- Apache Kafka — Wikipedia (open-sourced early 2011; Apache 2.0):
  https://en.wikipedia.org/wiki/Apache_Kafka

### 2012-10-23 — Kafka graduates to a top-level Apache project

Apache Kafka **graduated from the Apache Incubator on October 23, 2012**, becoming
a top-level Apache Software Foundation project.
- Apache Kafka — Wikipedia (graduation date):
  https://en.wikipedia.org/wiki/Apache_Kafka
- **Could not verify** the original ASF press release / board announcement URL for
  the October 23, 2012 graduation in this pass; the date is consistently reported
  but the primary ASF announcement link was not confirmed.

### 2013-12-16 — Jay Kreps publishes "The Log" (the conceptual core)

Jay Kreps published **"The Log: What every software engineer should know about
real-time data's unifying abstraction"** on the LinkedIn Engineering blog on
**December 16, 2013**. It is the conceptual manifesto behind Kafka: the idea that
an append-only, totally-ordered log is the unifying primitive underneath
databases, replication, stream processing, and data integration.

He defines the log plainly:
> "A log is an append-only, totally-ordered sequence of records ordered by time."

and frames its importance:
> "You can't fully understand databases, NoSQL stores, key value stores,
> replication, paxos, hadoop, version control, or almost any software system
> without understanding logs."

- Jay Kreps, "The Log..." (LinkedIn Engineering, 2013-12-16):
  https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying

The essay was later expanded into the O'Reilly book **"I ❤ Logs: Event Data,
Stream Processing, and Data Integration"** (reported September 2014).
- **Could not verify** an exact O'Reilly publication date from a primary
  O'Reilly catalog page in this pass; "September 2014" is reported secondarily.

### 2014-11-01 — Confluent is founded

Kreps, Narkhede, and Rao left LinkedIn to found **Confluent**, the company built
around Kafka and real-time data. Kreps announced it in **"Announcing Confluent, a
Company for Apache Kafka and Realtime Data"** on **November 1, 2014**. He framed
Kafka's purpose and the company's mission:
> "It let's you take everything happening in your company and turn it into a
> realtime data stream that other systems can subscribe to and process."

> "We wanted to make bringing this realtime streams vision to the rest of the
> world our full time job."

He also committed to keeping the core open:
> "Kafka will remain 100% open source, as will much of the rest of what we plan to
> do."

- Jay Kreps, "Announcing Confluent..." (Confluent blog, 2014-11-01):
  https://www.confluent.io/blog/announcing-confluent-a-company-for-apache-kafka-and-real-time-data/

(See [Company & corporate history](#company--corporate-history-confluent) for
funding and the IPO.)

### 2015 — Kafka Connect

**Kafka Connect** — the framework for scalably streaming data in and out of Kafka
via reusable source/sink connectors — shipped as part of Apache Kafka (it landed
in the **0.9** release line, late 2015).
- Confluent docs — Kafka Connect overview (current):
  https://docs.confluent.io/platform/current/connect/index.html
- **Could not verify** the precise 0.9 release date / month from a primary Apache
  release announcement in this pass; "Kafka Connect arrived with Kafka 0.9 in late
  2015" is the commonly reported framing.

### 2016 — Kafka Streams

**Kafka Streams** — a client library for building stream-processing applications
directly on top of Kafka (no separate processing cluster) — was introduced in the
Apache Kafka **0.10** release line (2016).
- Confluent docs — Kafka Streams for Confluent Platform (current):
  https://docs.confluent.io/platform/current/streams-ksql.html
- **Could not verify** the precise 0.10 release date from a primary Apache release
  announcement in this pass; "2016" is the commonly reported year.

### 2017 — KSQL (streaming SQL) developer preview

Confluent announced **KSQL**, a streaming SQL engine for Kafka (built on Kafka
Streams), as a developer preview in **2017**. KSQL later evolved into **ksqlDB**.
- Confluent docs — ksqlDB and Kafka Streams (relationship):
  https://docs.confluent.io/platform/current/ksql/docs/concepts/ksql-and-kafka-streams.html
- **Could not verify** the exact 2017 KSQL preview announcement date / URL from a
  primary Confluent post in this pass.

(The **Confluent Schema Registry** — a versioned registry for Avro/JSON
Schema/Protobuf schemas — is a long-standing Confluent component; see the license
section below, where it is one of the components moved to the Confluent Community
License.)
- Confluent Schema Registry (repo): https://github.com/confluentinc/schema-registry

### 2018-11/12 — AWS launches Amazon MSK (managed Kafka), preview

At **AWS re:Invent 2018** (late November 2018), AWS announced **Amazon Managed
Streaming for Apache Kafka (Amazon MSK)** as a fully managed Kafka service, in
**open preview**.
- InfoQ, "Amazon Announces Managed Streaming for Kafka in Public Preview"
  (2018-12): https://www.infoq.com/news/2018/12/aws-managed-kafka-msk/

This managed-Kafka move by a hyperscaler is the immediate backdrop to Confluent's
license change three weeks later (see next entry, and the
[Controversies](#controversies-confluent-community-license) section).

### 2018-12-14 — The Confluent Community License (relicensing)

On **December 14, 2018**, Jay Kreps announced in **"License Changes for Confluent
Platform"** that several Confluent-developed components — including **KSQL**, the
**Schema Registry**, the **REST Proxy**, and various connectors — would move from
the **Apache License 2.0** to a new, **source-available** license: the **Confluent
Community License**. The license lets you freely use, modify, and redistribute the
code, but **prohibits offering the software as a competing SaaS/cloud service**.

Crucially, **Apache Kafka itself was unaffected** and remains Apache 2.0, governed
by the ASF.
- Jay Kreps, "License Changes for Confluent Platform" (Confluent, 2018-12-14):
  https://www.confluent.io/blog/license-changes-confluent-platform/
- Confluent Community License FAQ:
  https://www.confluent.io/confluent-community-license-faq/

See [Controversies](#controversies-confluent-community-license) for the full,
attributed account.

### 2019-05-30 — Amazon MSK reaches general availability

AWS announced **Amazon MSK general availability on May 30, 2019** (after the
re:Invent 2018 preview). MSK is full-Kafka-compatible managed Kafka on AWS.
- AWS press release, "AWS Announces General Availability of Amazon Managed
  Streaming for Apache Kafka (Amazon MSK)" (2019-05-30):
  https://press.aboutamazon.com/2019/5/aws-announces-general-availability-of-amazon-managed-streaming-for-apache-kafka-amazon-msk
- AWS News Blog, "Amazon Managed Streaming for Apache Kafka (MSK) – Now Generally
  Available":
  https://aws.amazon.com/blogs/aws/amazon-managed-streaming-for-apache-kafka-msk-now-generally-available/

(So the brief's "AWS MSK (managed Kafka, 2018)" is correct for the **preview**;
the **GA** date is **May 30, 2019**.)

### 2019-08-01 — KIP-500 proposed: replace ZooKeeper with KRaft

**KIP-500, "Replace ZooKeeper with a Self-Managed Metadata Quorum,"** authored by
**Colin McCabe**, proposed removing Kafka's dependency on **Apache ZooKeeper** and
instead storing cluster metadata in a self-managed, Raft-based quorum inside Kafka
itself (later branded **KRaft**, "Kafka Raft"). The KIP was announced to the dev
list on **August 1, 2019**.
- KIP-500 wiki page (author Colin McCabe; "Replace ZooKeeper with a Self-Managed
  Metadata Quorum"):
  https://cwiki.apache.org/confluence/display/KAFKA/KIP-500%3A+Replace+ZooKeeper+with+a+Self-Managed+Metadata+Quorum
- ASF JIRA tracking issue (KAFKA-9119):
  https://issues.apache.org/jira/browse/KAFKA-9119
- DISCUSS thread on dev@kafka (Aug 2019):
  https://www.mail-archive.com/dev@kafka.apache.org/msg99949.html
- Confluent, "Kafka Needs No Keeper — Removing the ZooKeeper Dependency":
  https://www.confluent.io/blog/removing-zookeeper-dependency-in-kafka/

### 2024-09-09 — Confluent acquires WarpStream (diskless Kafka-on-S3)

Confluent acquired **WarpStream** (founded **July 2023** by ex-Datadog engineers
**Richard Artoul** and **Ryan Worl**), a Kafka-compatible, **diskless / "Bring
Your Own Cloud"** platform whose agents write **directly to object storage (S3)**
with no local disks and no cross-AZ replication networking costs. Announced
**September 9, 2024**.
- Confluent blog, "Confluent acquires WarpStream":
  https://www.confluent.io/blog/confluent-acquires-warpstream/
- Confluent press release, "Confluent Acquires WarpStream to Advance Next-Gen BYOC
  Data Streaming":
  https://www.confluent.io/press-release/confluent-acquires-warpstream-to-advance-next-gen-byoc-data-streaming/
- TechCrunch, "Confluent acquires streaming data startup WarpStream" (2024-09-09):
  https://techcrunch.com/2024/09/09/confluent-acquires-streaming-data-startup-warpstream/

This is one node in the broader **diskless / object-storage Kafka wave**; see
[The diskless / object-storage Kafka wave](#the-diskless--object-storage-kafka-wave)
below, and [`s3-object-storage.md`](./s3-object-storage.md) for the S3-side
context.

### 2025-03-18 — Apache Kafka 4.0: ZooKeeper-free (KRaft only)

**Apache Kafka 4.0** was released on **March 18, 2025** — the first major release
to run **entirely without ZooKeeper**. **KRaft** is now the only supported
metadata mode. (4.0 also brought GA of the new consumer group protocol, KIP-848,
and raised Java requirements.)
- Apache Kafka, "Apache Kafka 4.0.0 Release Announcement" (2025-03-18):
  https://kafka.apache.org/blog/2025/03/18/apache-kafka-4.0.0-release-announcement/
- Confluent, "Apache Kafka 4.0 Release" (default KRaft, queues, faster
  rebalances): https://www.confluent.io/blog/latest-apache-kafka-release/

The KRaft path: proposed Aug 2019 (KIP-500) → early access in Kafka 2.8 (2021) →
production-ready for new clusters in Kafka 3.3 (2022) → migration support in 3.x →
ZooKeeper removed in 4.0 (2025). The intermediate per-release milestone dates are
**reported secondarily** and **could not all be verified** against individual
Apache release announcements in this pass; the **endpoints** (KIP-500 in Aug 2019,
4.0 ZooKeeper-free on 2025-03-18) are primary-sourced above.

---

## Key people & teams

- **Jay Kreps** — co-creator of Kafka at LinkedIn; author of "The Log" (2013);
  co-founder and **CEO of Confluent**. Primary voice for both the naming rationale
  and the 2018 license change.
  https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying
  | https://www.confluent.io/blog/license-changes-confluent-platform/
- **Neha Narkhede** — co-creator of Kafka at LinkedIn; co-founder of Confluent
  (former CTO/CPO). https://en.wikipedia.org/wiki/Neha_Narkhede
- **Jun Rao** — co-creator of Kafka at LinkedIn; co-founder of Confluent.
  https://en.wikipedia.org/wiki/Apache_Kafka
- **Colin McCabe** — author of **KIP-500** (replace ZooKeeper with KRaft), the
  proposal behind Kafka's ZooKeeper removal.
  https://cwiki.apache.org/confluence/display/KAFKA/KIP-500%3A+Replace+ZooKeeper+with+a+Self-Managed+Metadata+Quorum
- **Richard Artoul** and **Ryan Worl** — ex-Datadog engineers, founders of
  **WarpStream** (diskless Kafka-on-S3), acquired by Confluent in 2024.
  https://www.confluent.io/blog/confluent-acquires-warpstream/
- **Alexander (Alex) Gallego** — founder/CEO of **Vectorized / Redpanda**, the
  C++ Kafka-compatible alternative (founded 2019).
  https://www.globenewswire.com/news-release/2021/01/26/2164522/0/en/Vectorized-Creates-Redpanda-the-Intelligent-Data-API-Platform-backed-by-15-5M-initial-funding-from-Lightspeed-Venture-Partners-and-GV.html

---

## Company & corporate history (Confluent)

**Founding (2014).** Confluent was founded by Jay Kreps, Neha Narkhede, and Jun
Rao, who left LinkedIn to commercialize Kafka; announced November 1, 2014.
- https://www.confluent.io/blog/announcing-confluent-a-company-for-apache-kafka-and-real-time-data/

**Funding rounds (selected).** The following rounds are widely reported; **the
specific dollar amounts, dates, and lead investors below come largely from funding
aggregators/secondary sources and should be treated as approximate** unless tied
to a primary Confluent/press source:

- **Series D — $125M (2019), led by Sequoia**, reported ~$2.5B valuation.
  Primary: Confluent blog, "Confluent Raises a $125M Series D Funding Round":
  https://www.confluent.io/blog/confluent-raises-a-125m-series-d-funding-round/
- **Series A (2014), Series B (2015), Series C (2017), Series E (~$250M, 2020,
  led by Coatue, ~$4.5B valuation)** — **Could not verify** each of these from a
  primary Confluent/press source in this pass; the figures and dates are from
  aggregators (Crunchbase/Tracxn-class sources) and are **reported, not verified
  here**.

**IPO — June 2021 (Nasdaq: CFLT).** Confluent went public on **June 24, 2021**,
listing on the **Nasdaq** under ticker **CFLT**. It priced its IPO at **$36 per
share** (above the $29–$33 range), selling ~23 million shares and **raising about
$828 million**; the stock jumped on its first day.
- CNBC, "Confluent climbs 25% in Nasdaq debut after ... raises over $800 million in
  IPO" (2021-06-24):
  https://www.cnbc.com/2021/06/24/confluent-climbs-26percent-after-raising-828-million-in-ipo.html
  (**Note:** this URL returned HTTP 403 to the automated fetcher in this pass; the
  headline figures — June 24, 2021; CFLT; $36/share; ~$828M — are corroborated by
  the CNBC title and by the SEC S-1 filing below. The intraday open/close
  percentages are **reported**, not independently re-verified.)
- Confluent S-1 (SEC EDGAR, filed June 2021):
  https://www.sec.gov/Archives/edgar/data/1699838/000119312521178773/d63025ds1.htm

**Ecosystem (what Confluent builds around Kafka).**
- **Kafka Connect** (in Apache Kafka) — pluggable data integration:
  https://docs.confluent.io/platform/current/connect/index.html
- **Kafka Streams** (in Apache Kafka) — stream-processing library:
  https://docs.confluent.io/platform/current/streams-ksql.html
- **ksqlDB / KSQL** — streaming SQL (Confluent Community License):
  https://docs.confluent.io/platform/current/ksql/docs/concepts/ksql-and-kafka-streams.html
- **Schema Registry** — versioned schema management (Confluent Community License):
  https://github.com/confluentinc/schema-registry

---

## Controversies (Confluent Community License)

On **December 14, 2018**, Confluent moved several of its own components —
**KSQL**, **Schema Registry**, **REST Proxy**, and various connectors — from the
**Apache License 2.0** to the new, **source-available Confluent Community
License**. The new license permits use, modification, and redistribution but
**bars providing the software as a competing SaaS offering** (e.g.
"KSQL-as-a-service"). **Apache Kafka itself stayed Apache 2.0** under the ASF.
- Jay Kreps, "License Changes for Confluent Platform" (2018-12-14):
  https://www.confluent.io/blog/license-changes-confluent-platform/
- Confluent Community License FAQ:
  https://www.confluent.io/confluent-community-license-faq/

**The stated motivation (attributed to Jay Kreps).** Kreps framed it as a
response to the structural advantages cloud providers hold over open-source
companies. In his words:
> "In this new world, the cloud providers have significant advantages: they
> control the pricing of all resources a service provider will use and can tightly
> integrate their own services across all their offerings."

He argued cloud providers can either partner with open-source companies or "take
the open source code, bake it into the cloud offering, and put all their own
investments into differentiated proprietary offerings" — and that sustaining
ongoing R&D in distributed data systems requires protecting the commercial entity.
- Same post (2018-12-14):
  https://www.confluent.io/blog/license-changes-confluent-platform/

**The trigger (attributed to press coverage).** Contemporary reporting tied the
timing directly to **Amazon MSK**, which had just been announced (re:Invent 2018),
and characterized the move as aimed at cloud vendors (Amazon, and by extension
Microsoft/Google/Alibaba) offering Confluent's components as managed services.
- GeekWire, "Concerned about cloud providers, Confluent becomes latest open-source
  company to set new restrictions on usage" (2018):
  https://www.geekwire.com/2018/concerned-cloud-providers-confluent-becomes-latest-open-source-company-set-new-restrictions-usage/
- InfoQ, "License Changes for Confluent Platform Restricting Cloud Vendor Usage":
  https://www.infoq.com/news/2018/12/confluent-license-changes/

**The broader "relicensing era" context.** Confluent's move was part of a wave of
infrastructure/open-source companies adopting **source-available** or restrictive
licenses to blunt cloud-provider competition. Adjacent events of the same era —
**Redis** (Commons Clause / later RSALv2 & SSPLv1, then back toward open with
AGPL), **MongoDB** (the **SSPL**, 2018), **Elastic** (SSPL/Elastic License, 2021),
**HashiCorp** (**BSL**, 2023) — share the same "cloud provider monetization vs.
open-source sustainability" framing. Those are tracked in their own histories where
present; here the Confluent Community License is the Kafka-ecosystem instance of
that pattern.
- SD Times, "New software licenses aim to protect against cloud providers":
  https://sdtimes.com/os/new-software-licenses-aim-to-protect-against-cloud-providers/
- **Attribution note:** the characterization that these licenses are "not open
  source" (per the OSI's definition) is a **critique voiced by open-source
  advocates / the OSI**, while Confluent calls its license "source-available" and
  "community." Both framings should be attributed to their source rather than
  stated as settled fact.

---

## The diskless / object-storage Kafka wave

A recent and distinct trend reimagines Kafka so that brokers write **directly to
object storage (S3 and compatibles)** instead of replicating across local disks and
availability zones — slashing the cross-AZ networking and disk costs that dominate
cloud Kafka bills, at the price of higher latency. This is the **Kafka side** of
the object-storage-as-substrate story; the **S3 side** (why S3 became the universal
substrate) is in [`s3-object-storage.md`](./s3-object-storage.md).

- **WarpStream** — diskless, BYOC, Kafka-compatible; agents talk only to object
  storage. Founded July 2023 (Artoul, Worl); **acquired by Confluent, Sept 9,
  2024**. https://www.confluent.io/blog/confluent-acquires-warpstream/
- **AutoMQ** — Kafka built on a shared **S3-backed** storage layer ("S3Stream"),
  marketed as "Diskless Kafka on S3," 100% Kafka-protocol compatible.
  https://github.com/automq/automq | https://www.automq.com/
- **Bufstream** — Buf's drop-in Kafka replacement that writes to S3-compatible
  object storage, with broker-side schema (Protobuf) awareness; announced public
  beta **July 9, 2024**. https://buf.build/product/bufstream
  (Per Buf's own blog, Bufstream was later acquired by **CoreWeave**:
  https://buf.build/blog/bufstream-kafka-lower-cost — **verify** the CoreWeave
  acquisition date against a primary CoreWeave/Buf announcement; only the Buf blog
  was seen in this pass.)
- **Confluent Freight** — Confluent Cloud cluster type using the Kora engine's
  "direct write" to object storage (e.g. S3), bypassing multi-AZ replication for
  ~90% cost savings on latency-tolerant workloads; reached **GA on AWS**.
  https://www.confluent.io/blog/freight-clusters-are-generally-available/
- **Redpanda** (formerly **Vectorized**) — a **C++**, Kafka-API-compatible
  streaming platform (Seastar framework, Raft), "no ZooKeeper, no JVM," founded
  **2019** by Alex Gallego; revealed $15.5M seed/Series A in Jan 2021. Redpanda is
  a **rewrite-from-scratch alternative** to Kafka (not a fork), and also added
  object-storage tiering ("Tiered Storage"/Cloud).
  https://github.com/redpanda-data/redpanda
  | https://www.globenewswire.com/news-release/2021/01/26/2164522/0/en/Vectorized-Creates-Redpanda-the-Intelligent-Data-API-Platform-backed-by-15-5M-initial-funding-from-Lightspeed-Venture-Partners-and-GV.html

---

## Current status (as of 2026)

- **Apache Kafka** is a mature, ZooKeeper-free (KRaft) top-level ASF project as of
  **4.0 (2025-03-18)**, still Apache 2.0.
  https://kafka.apache.org/blog/2025/03/18/apache-kafka-4.0.0-release-announcement/
- **Confluent** is a public company (**Nasdaq: CFLT**, IPO June 24, 2021) and the
  primary commercial steward of the Kafka ecosystem; its KSQL/ksqlDB/Schema
  Registry/REST Proxy remain under the **Confluent Community License**, while Kafka
  core stays Apache 2.0. Confluent now spans fully-managed (Confluent Cloud),
  self-managed (Confluent Platform), and BYOC/diskless (WarpStream) offerings.
  https://www.confluent.io/blog/confluent-acquires-warpstream/
- The **diskless / Kafka-on-S3** model (WarpStream, AutoMQ, Bufstream, Confluent
  Freight, plus Redpanda's object-storage tiering) is the current competitive
  frontier — see [`s3-object-storage.md`](./s3-object-storage.md) for the
  object-storage substrate behind it.

---

## Sources (primary, consolidated)

- Apache Kafka — Wikipedia (origin, naming, Apache graduation):
  https://en.wikipedia.org/wiki/Apache_Kafka
- Jay Kreps, "The Log..." (LinkedIn Engineering, 2013-12-16):
  https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying
- Jay Kreps, "Announcing Confluent..." (2014-11-01):
  https://www.confluent.io/blog/announcing-confluent-a-company-for-apache-kafka-and-real-time-data/
- Jay Kreps, "License Changes for Confluent Platform" (2018-12-14):
  https://www.confluent.io/blog/license-changes-confluent-platform/
- Confluent Community License FAQ:
  https://www.confluent.io/confluent-community-license-faq/
- AWS — Amazon MSK GA press release (2019-05-30):
  https://press.aboutamazon.com/2019/5/aws-announces-general-availability-of-amazon-managed-streaming-for-apache-kafka-amazon-msk
- AWS News Blog — Amazon MSK GA:
  https://aws.amazon.com/blogs/aws/amazon-managed-streaming-for-apache-kafka-msk-now-generally-available/
- KIP-500 (wiki) — Replace ZooKeeper with a Self-Managed Metadata Quorum:
  https://cwiki.apache.org/confluence/display/KAFKA/KIP-500%3A+Replace+ZooKeeper+with+a+Self-Managed+Metadata+Quorum
- ASF JIRA KAFKA-9119 (KIP-500 tracking):
  https://issues.apache.org/jira/browse/KAFKA-9119
- Apache Kafka 4.0.0 Release Announcement (2025-03-18):
  https://kafka.apache.org/blog/2025/03/18/apache-kafka-4.0.0-release-announcement/
- Confluent blog — "Confluent acquires WarpStream" (2024-09-09):
  https://www.confluent.io/blog/confluent-acquires-warpstream/
- Confluent press release — WarpStream acquisition:
  https://www.confluent.io/press-release/confluent-acquires-warpstream-to-advance-next-gen-byoc-data-streaming/
- Confluent S-1 (SEC EDGAR, 2021):
  https://www.sec.gov/Archives/edgar/data/1699838/000119312521178773/d63025ds1.htm
- CNBC — Confluent IPO (2021-06-24):
  https://www.cnbc.com/2021/06/24/confluent-climbs-26percent-after-raising-828-million-in-ipo.html
- GeekWire — Confluent license change (2018):
  https://www.geekwire.com/2018/concerned-cloud-providers-confluent-becomes-latest-open-source-company-set-new-restrictions-usage/
- InfoQ — Confluent license change:
  https://www.infoq.com/news/2018/12/confluent-license-changes/
- InfoQ — Amazon MSK public preview (2018-12):
  https://www.infoq.com/news/2018/12/aws-managed-kafka-msk/
- AutoMQ (repo): https://github.com/automq/automq
- Bufstream (Buf): https://buf.build/product/bufstream
- Confluent Freight clusters GA:
  https://www.confluent.io/blog/freight-clusters-are-generally-available/
- Redpanda (repo): https://github.com/redpanda-data/redpanda
- Vectorized/Redpanda funding (GlobeNewswire, 2021-01-26):
  https://www.globenewswire.com/news-release/2021/01/26/2164522/0/en/Vectorized-Creates-Redpanda-the-Intelligent-Data-API-Platform-backed-by-15-5M-initial-funding-from-Lightspeed-Venture-Partners-and-GV.html
