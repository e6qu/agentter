# RabbitMQ and the AMQP Protocol: A Sourced History

A chronological, fully-cited history of **RabbitMQ** — the open-source message
broker written in Erlang — and the **Advanced Message Queuing Protocol (AMQP)**
that it was built to implement. Every non-trivial claim links to a working
source. Items that could not be confirmed from a reputable source are marked
**"Could not verify."** Opinions are attributed to the person or outlet that
expressed them.

> **Cross-reference, not duplication:** RabbitMQ co-founder **Alexis Richardson**
> later founded **Weaveworks** and is widely credited with coining **"GitOps."**
> That thread is covered in depth in
> [`history/argocd-flux.md`](./argocd-flux.md); here it is noted only briefly
> with sources, to avoid duplication.

---

## Timeline

### 2003–2006 — AMQP is conceived at JPMorgan Chase
- **2003** — **AMQP is originated by John O'Hara at JPMorgan Chase in London.**
  Source: [Wikipedia, "Advanced Message Queuing Protocol"](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol)
  ("AMQP was originated in 2003 by John O'Hara at JPMorgan Chase in London").
- **mid-2004 to mid-2006** — The **initial design phase** runs at JPMorgan
  Chase, which contracts **iMatix Corporation** to develop a C broker and the
  protocol documentation.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).
- **2005** — JPMorgan Chase assembles a **working group** initially including
  **Cisco Systems, IONA Technologies, iMatix, Red Hat, and TWIST**; it would
  grow to 23 companies by the time of standardization.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).
  - **Motivation (per O'Hara, as reported):** at QCon London 2025, O'Hara said
    AMQP was aimed at "commoditizing middleware and reducing reliance on a single
    vendor," recounting writing a SWIFT gateway for a derivatives trading system
    whose first live message triggered "two billion dollars in collateral calls."
    Source: [InfoQ, "QCon London 2025: the Origin Story of AMQP – Advanced
    Message Queuing Politics" (Apr 2025)](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/).
  - **Motivation (per Richardson):** Richardson says JPMorgan calculated "about
    30% of their annual budget in IT was going on spending for these messaging
    systems," motivating an open protocol to reduce lock-in with IBM and TIBCO.
    Source: [RedMonk, "RabbitMQ Was Designed for the Cloud Era (with Alexis
    Richardson)" (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/).

### 2006–2007 — RabbitMQ and Rabbit Technologies Ltd
- **2007** — **Rabbit Technologies Ltd. is established as a joint venture
  between LShift and CohesiveFT**, and releases **RabbitMQ** as an open-source
  AMQP broker.
  Source: [Wikipedia, "RabbitMQ"](https://en.wikipedia.org/wiki/RabbitMQ)
  ("Rabbit Technologies Ltd. … established in 2007 as a joint venture between
  LShift and CohesiveFT").
  - **Origin story (per Richardson):** Alexis Richardson obtained a pre-release
    AMQP specification from the JPMorgan team and brought it to **Matthias
    Radestock**, CTO of **LShift**, who said "it would be quite easy to implement
    this in Erlang." Richardson's own company was **CohesiveFT** (referred to as
    "Cohesive"); the two firms partnered to build RabbitMQ.
    Source: [RedMonk (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/);
    corroborated by the foreword/text of
    [*RabbitMQ in Action* (Manning), PDF excerpt](https://classpages.cselabs.umn.edu/Spring-2018/csci8980/Papers/PublishSubscribe/RabbitMQinAction.pdf).
  - **Why Erlang (per Richardson):** "Erlang was designed to implement switching
    exchanges for telephone companies in Sweden. Ericsson built it" — and the
    exchange-and-queue telecom pattern aligned precisely with AMQP's
    architecture, giving the concurrency and fault-tolerance a broker needs.
    Source: [RedMonk (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/).
  - **Could not verify (exact founding month / first public release date):**
    One secondary source states Rabbit Technologies was "founded in February
    2007 … as a spin out from LShift Ltd. … and CohesiveFT" (surfaced in search
    of [Oliver Wyman Labs / former CohesiveFT staff](https://tech.labs.oliverwyman.com/about/news/rabbitmq-2/)),
    but that page would not load (ECONNREFUSED) and the precise month and the
    exact date of RabbitMQ's first public release could not be confirmed against
    a primary source. The year **2007** is confirmed by Wikipedia.
- RabbitMQ was positioned as **the reference AMQP 0-9-1 broker** — it
  "originally implemented the Advanced Message Queuing Protocol (AMQP)" before
  being extended to other protocols.
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).

### 2009 — VMware acquires SpringSource (sets up the corporate chain)
- **August 10, 2009** — VMware announces a definitive agreement to acquire
  **SpringSource** (for ~$362M cash/equity plus ~$58M assumed stock/options).
  Source: [TechCrunch, "VMWare Acquires SpringSource" (Aug 10, 2009)](https://techcrunch.com/2009/08/10/vmware-acquires-springsource/);
  [InfoQ, "VMware Acquires SpringSource for $420 Million"](https://www.infoq.com/news/2009/08/vmware-springsource/).
- **September 16, 2009** — VMware **completes** the SpringSource acquisition.
  Source: [VMware IR / Broadcom News, "VMware Completes Acquisition of
  SpringSource"](https://news.broadcom.com/releases/springsource-close).

### 2010 — SpringSource (a VMware division) acquires Rabbit Technologies
- **April 13, 2010** — **SpringSource, a division of VMware, acquires Rabbit
  Technologies Ltd.**, the company behind RabbitMQ.
  Source: [Spring blog, "SpringSource Hops On Cloud Messaging with RabbitMQ"
  (Apr 13, 2010)](https://spring.io/blog/2010/04/13/springsource-hops-on-cloud-messaging-with-rabbitmq/)
  ("the SpringSource division of VMware has acquired Rabbit Technologies Ltd.,
  the company behind the popular open source cloud messaging technology
  RabbitMQ"); [TechCrunch (Apr 13, 2010)](https://techcrunch.com/2010/04/13/springsource-rabbit/);
  [InfoQ, "SpringSource Acquires RabbitMQ"](https://www.infoq.com/news/2010/04/springsource-rabbit/).
  - Terms were undisclosed; RabbitMQ remained open source and the team stayed on
    under SpringSource/VMware.
    Source: [The Register, "VMware SpringSources for open source Rabbit" (Apr 13,
    2010)](https://www.theregister.com/2010/04/13/springsource_buys_open_source_rabbit/).

### 2011 — AMQP 1.0 and the protocol fork
- **October 30, 2011** — **AMQP 1.0 is released** by the working group at a
  conference in New York; the **OASIS AMQP Technical Committee** forms on
  November 1, 2011.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).
  - **Divergence:** earlier versions (0-8, 0-9, 0-10, **0-9-1**) are
    "significantly different from the 1.0 specification" — AMQP 1.0 is effectively
    a different wire protocol, not a point upgrade of the 0-9-1 line that RabbitMQ
    natively implemented.
    Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).
  - **iMatix departure:** iMatix CEO **Pieter Hintjens** published the critical
    "What is wrong with AMQP (and how to fix it)" (2008) and by 2010 iMatix
    withdrew to focus on **ZeroMQ**, which Hintjens considered "significantly
    simpler and faster."
    Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).

### 2013 — Pivotal spinout
- **April 2013** — VMware and parent **EMC** (with GE investment) spin out
  **Pivotal Software**; VMware's application-oriented products — including Spring
  and RabbitMQ — are transferred to Pivotal.
  Source: [Pivotal Software (Wikipedia)](https://en.wikipedia.org/wiki/Pivotal_Software);
  [Network World, "EMC and VMware spin out big data/cloud division"](https://www.networkworld.com/article/2161877/emc-and-vmware-spin-out-big-data-cloud-division.html).
  - Some accounts date the RabbitMQ project's move to Pivotal to **May 2013**.
    Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ)
    ("May 2013: The project transitioned to Pivotal Software").

### 2014 — AMQP becomes an ISO/IEC standard
- **April 2014** — **OASIS AMQP 1.0 is approved as an ISO and IEC International
  Standard**, becoming **ISO/IEC 19464**.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).

### 2014–2017 — The Alexis Richardson cross-link (brief)
- **2014** — Richardson **founds Weaveworks**; he later **coins "GitOps" (2017)**.
  This is covered fully in [`history/argocd-flux.md`](./argocd-flux.md) and is
  noted here only to connect the lineage.
  Source: [TechCrunch, "Cloud native container management platform Weaveworks
  shuts its doors" (Feb 5, 2024)](https://techcrunch.com/2024/02/05/cloud-native-container-management-platform-weaveworks-shuts-its-doors/);
  [SiliconANGLE, "How Weaveworks pioneered GitOps"](https://siliconangle.com/2022/01/20/weaveworks-pioneered-gitops-brought-containers-mainstream-awsshowcases2e1/).
  See [`argocd-flux.md`](./argocd-flux.md) for the nuance (Richardson himself
  could not pin the exact date the term was coined).

### 2019 — Quorum queues; VMware reabsorbs Pivotal
- **November 2019** — **RabbitMQ 3.8** ships, introducing **quorum queues**, a
  Raft-based replicated queue type intended to replace mirrored classic queues.
  Source: [RabbitMQ blog, "RabbitMQ 3.8 Release Overview" (Nov 11, 2019)](https://www.rabbitmq.com/blog/2019/11/11/rabbitmq-3-8-release-overview);
  [RabbitMQ docs, "Quorum Queues"](https://www.rabbitmq.com/docs/quorum-queues).
  - **Could not verify (exact 3.8.0 GA date):** the official release-overview
    blog post is dated **November 11, 2019**; the precise 3.8.0 tag/GA day was
    not confirmed against the GitHub release page in this research.
- **August 22, 2019** — VMware and Pivotal announce VMware will acquire Pivotal
  (~$2.7B enterprise value). **December 30, 2019** — VMware **completes** the
  acquisition, bringing RabbitMQ back under VMware.
  Source: [Forum Insights, "VMware Completes Acquisition of Pivotal" (Dec 2019)](https://insights.govforum.io/2019/12/press-release-vmware-completes-acquisition-of-pivotal/);
  [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ)
  ("December 2019: VMware completed its acquisition of Pivotal").

### 2020–2021 — Commercial editions and streams
- **November 2020** — Commercial **VMware RabbitMQ** offerings emerge (e.g.,
  "VMware RabbitMQ," "VMware RabbitMQ for Kubernetes," OVA).
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
- **July 23, 2021** — **RabbitMQ 3.9** introduces **streams** — a persistent,
  replicated, append-only log "queue type" with non-destructive consumption —
  plus a dedicated high-throughput binary stream protocol.
  Source: [GitHub, "RabbitMQ 3.9.0 is now generally available" (Discussion #3228)](https://github.com/rabbitmq/rabbitmq-server/discussions/3228)
  (release date July 23, 2021; streams description).

### 2023 — Broadcom acquires VMware
- **November 22, 2023** — **Broadcom completes its acquisition of VMware**
  (the deal expected to close around Oct 30, 2023; UK CMA gave final approval
  Aug 21, 2023). RabbitMQ now sits under Broadcom.
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ)
  ("Broadcom now serves as the listed developer"); deal timeline per
  [search of VMware SEC Form 425 filings (FY2023)](https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001124610&type=425).
  - **Could not verify (exact close date):** search results variously cited an
    expected close of Oct 30, 2023; the precise legal close date was not pinned
    to a single primary source here. The acquisition itself is well documented.

### 2024–2025 — RabbitMQ 4.x: AMQP 1.0 as a core protocol
- **September 2024** — **RabbitMQ 4.0** ships. **AMQP 1.0 becomes a core,
  always-enabled protocol** (no longer a plugin), quorum queues gain features
  (including priorities), and **Khepri** (a Raft-based metadata store replacing
  Mnesia) matures to full support.
  Source: [RabbitMQ blog, "What's New in RabbitMQ 4.0"](https://blog.rabbitmq.com/docs/4.0/whats-new);
  [GitHub, rabbitmq-server release notes 4.0.1](https://github.com/rabbitmq/rabbitmq-server/blob/main/release-notes/4.0.1.md)
  (4.0.1 dated September 18, 2024).
- **April 2026** — RabbitMQ continues active 4.x development (e.g.,
  **RabbitMQ 4.3**).
  Source: [RabbitMQ blog, "RabbitMQ 4.3 Highlights" (Apr 23, 2026)](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release).

---

## AMQP origins

The **Advanced Message Queuing Protocol** was created to solve a specific
enterprise-messaging problem: large institutions (banks above all) were locked
into expensive proprietary middleware (IBM MQ, TIBCO) with no interoperable
**open wire protocol**. **John O'Hara at JPMorgan Chase** (London) originated
AMQP in **2003**, with the core design work running **mid-2004 to mid-2006**;
JPMorgan contracted **iMatix Corporation** to build a C broker and write the
spec.
Sources: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol);
[InfoQ, "QCon London 2025: the Origin Story of AMQP"](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/).

**Why an open wire protocol mattered.** A standardized wire protocol means any
compliant client can talk to any compliant broker, breaking single-vendor
lock-in and letting different languages and platforms interoperate. O'Hara's
stated aim was "commoditizing middleware and reducing reliance on a single
vendor" ([InfoQ](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/)).
Richardson frames the business case bluntly: JPMorgan reckoned "about 30% of
their annual budget in IT was going on … messaging systems"
([RedMonk](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/)).

**The AMQP Working Group** (formed 2005) started with **JPMorgan Chase, Cisco
Systems, IONA Technologies, iMatix, Red Hat, and TWIST**, and grew to 23
companies — including **Bank of America, Barclays, Credit Suisse, Goldman Sachs,
Deutsche Börse, Microsoft, Novell, Red Hat, Software AG, Solace, VMware, and
WSO2** — by the time of standardization.
Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).

**The 0-9-1 / 1.0 fork.** RabbitMQ implemented the **AMQP 0-9-1** line (preceded
by 0-8, 0-9, 0-10). **AMQP 1.0** (released **Oct 30, 2011**, standardized by
OASIS and later **ISO/IEC 19464** in April 2014) is "significantly different" —
effectively a separate protocol. iMatix's **Pieter Hintjens** publicly criticized
the direction and left the effort by 2010 to build **ZeroMQ**.
Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).

---

## Key people & teams

- **John O'Hara** — Originator of **AMQP** at **JPMorgan Chase** (London),
  ~2003–2006. Delivered the "Advanced Message Queuing Politics" origin-story
  keynote at QCon London 2025.
  Source: [InfoQ (Apr 2025)](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/);
  [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol).
- **Alexis Richardson** — Co-founder / CEO of **Rabbit Technologies Ltd.**; from
  **CohesiveFT** ("Cohesive"). Obtained the pre-release AMQP spec from JPMorgan
  and connected it with LShift; "a long-time contributor to the messaging space"
  who played a "pivotal role in the popularization and success of RabbitMQ and,
  by extension, AMQP" ([InfoQ](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/)).
  **Later founded Weaveworks (2014) and coined "GitOps" (2017)** — see
  [`argocd-flux.md`](./argocd-flux.md).
  Source: [RedMonk (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/);
  [Erlang Factory speaker bio (London 2009): "Alexis Richardson, AMQP Expert and
  CEO at RabbitMQ"](https://www.erlang-factory.com/conference/London2009/speakers/alexisrichardson).
- **Matthias Radestock** — CTO of **LShift**; identified **Erlang** as the ideal
  implementation language ("it would be quite easy to implement this in Erlang")
  and was a principal architect of the RabbitMQ broker.
  Source: [RedMonk (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/).
- **Pieter Hintjens** — CEO of **iMatix**, contracted to build the first AMQP
  broker; later AMQP critic who departed to create **ZeroMQ**.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol);
  [InfoQ (Apr 2025)](https://www.infoq.com/news/2025/04/origin-advanced-message-queuing/).
- **LShift Ltd.** (UK software consultancy) and **CohesiveFT** (US
  virtualization/cloud) — the two firms whose joint venture became **Rabbit
  Technologies Ltd.** (2007).
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
  - **Could not verify:** Richardson credits **Francesco Cesarini** of **Erlang
    Solutions** with validating that AMQP's exchange/queue model matched telecom
    patterns; the name appears as "Francesco Cesareani" in the RedMonk write-up
    and the precise spelling/role detail was not cross-checked against a second
    primary source.
    Source: [RedMonk (Mar 31, 2025)](https://redmonk.com/blog/2025/03/31/rmc-rabbitmq-was-designed-for-the-cloud-era-with-alexis-richardson/).

---

## Company & corporate history

The corporate lineage of the company behind RabbitMQ runs through a long chain
of acquisitions:

1. **Rabbit Technologies Ltd. (2007)** — joint venture of **LShift** +
   **CohesiveFT**; sponsor of open-source RabbitMQ.
   Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
2. **SpringSource → VMware (2009):** VMware acquires SpringSource (announced
   Aug 10, 2009; completed Sept 16, 2009).
   Source: [TechCrunch (Aug 10, 2009)](https://techcrunch.com/2009/08/10/vmware-acquires-springsource/);
   [Broadcom/VMware, "VMware Completes Acquisition of SpringSource"](https://news.broadcom.com/releases/springsource-close).
3. **SpringSource (VMware) acquires Rabbit Technologies (April 13, 2010).**
   Source: [Spring blog (Apr 13, 2010)](https://spring.io/blog/2010/04/13/springsource-hops-on-cloud-messaging-with-rabbitmq/);
   [InfoQ (Apr 2010)](https://www.infoq.com/news/2010/04/springsource-rabbit/).
4. **Pivotal spinout (2013):** VMware/EMC (with GE) spin out **Pivotal
   Software**; Spring and RabbitMQ move to Pivotal (project move dated to
   ~May 2013).
   Source: [Pivotal Software (Wikipedia)](https://en.wikipedia.org/wiki/Pivotal_Software);
   [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
5. **VMware reabsorbs Pivotal (2019):** announced Aug 22, 2019; completed
   Dec 30, 2019 — RabbitMQ returns to VMware.
   Source: [Forum Insights (Dec 2019)](https://insights.govforum.io/2019/12/press-release-vmware-completes-acquisition-of-pivotal/);
   [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
6. **Broadcom acquires VMware (2023):** Broadcom completes the VMware
   acquisition (late 2023); **Broadcom is now the listed developer** of RabbitMQ,
   shipped commercially as part of **VMware Tanzu**.
   Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ);
   [Broadcom TechDocs, "VMware Tanzu RabbitMQ" release notes](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-rabbitmq-on-kubernetes/4-0/tanzu-rabbitmq-kubernetes/release-notes.html).

**Net chain:** Rabbit Technologies → SpringSource/VMware (2010) → Pivotal (2013)
→ VMware (2019) → **Broadcom (2023)**.

---

## Protocol & technology evolution

- **AMQP 0-9-1** — RabbitMQ's original native protocol and the one for which it
  served as the **reference broker**.
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
- **AMQP 1.0** — the divergent OASIS standard (2011; ISO/IEC 19464 in 2014).
  RabbitMQ long supported it via plugin, and made it a **core, always-enabled
  protocol in RabbitMQ 4.0 (2024)**.
  Source: [Wikipedia, AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol);
  [RabbitMQ blog, "What's New in RabbitMQ 4.0"](https://blog.rabbitmq.com/docs/4.0/whats-new).
- **Multi-protocol via plugins** — RabbitMQ's plug-in architecture added
  **STOMP, MQTT**, and other protocols/gateways on top of the AMQP core.
  Source: [Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).
- **Quorum queues (3.8, 2019)** — Raft-based replicated queues replacing
  mirrored classic queues for data-safety.
  Source: [RabbitMQ docs, "Quorum Queues"](https://www.rabbitmq.com/docs/quorum-queues);
  [RabbitMQ 3.8 Release Overview](https://www.rabbitmq.com/blog/2019/11/11/rabbitmq-3-8-release-overview).
- **Streams (3.9, 2021)** — append-only, replicated log with non-destructive
  consumption and a dedicated high-throughput binary protocol.
  Source: [GitHub, RabbitMQ 3.9.0 GA (Discussion #3228)](https://github.com/rabbitmq/rabbitmq-server/discussions/3228).
- **Khepri (4.0, 2024)** — Raft-based metadata store replacing Mnesia.
  Source: [RabbitMQ blog, "What's New in RabbitMQ 4.0"](https://blog.rabbitmq.com/docs/4.0/whats-new).

---

## Current status

RabbitMQ remains one of the most widely used open-source message brokers,
developed under **Broadcom** (post-VMware) and shipped commercially within
**VMware Tanzu**. It is on the **4.x** line (4.0 in Sept 2024; active development
through 4.3 in 2026), with **AMQP 1.0 now a first-class core protocol**,
**quorum queues** and **streams** as its modern durable primitives, and
**Khepri** as its metadata store. It remains a flagship production user of the
**Erlang/OTP** ecosystem — the concurrency-and-fault-tolerance runtime that
Matthias Radestock chose at the project's outset.
Sources: [RabbitMQ blog, "What's New in RabbitMQ 4.0"](https://blog.rabbitmq.com/docs/4.0/whats-new);
[RabbitMQ blog, "RabbitMQ 4.3 Highlights" (Apr 2026)](https://www.rabbitmq.com/blog/2026/04/23/rabbitmq-4.3-release);
[GitHub, rabbitmq/rabbitmq-server](https://github.com/rabbitmq/rabbitmq-server);
[Wikipedia, RabbitMQ](https://en.wikipedia.org/wiki/RabbitMQ).

---

## Items that could not be verified

1. **Exact founding month of Rabbit Technologies / first public RabbitMQ release
   date.** Year **2007** is confirmed (Wikipedia); a "February 2007" spin-out
   date and the exact first-release date came from a secondary page
   (Oliver Wyman Labs / ex-CohesiveFT) that would not load, so they are
   unconfirmed against a primary source.
2. **Exact RabbitMQ 3.8.0 GA date.** The release-overview blog is dated
   **Nov 11, 2019**; the precise tag/GA day was not confirmed against the GitHub
   release page.
3. **Exact legal close date of the Broadcom–VMware acquisition.** The
   acquisition is well documented (late 2023; UK CMA approval Aug 21, 2023;
   expected close Oct 30, 2023) but the single authoritative close date was not
   pinned to one primary source here.
4. **Francesco Cesarini's name/role.** Reported by RedMonk (spelled
   "Cesareani") as validating AMQP's fit with telecom patterns via Erlang
   Solutions; not cross-checked against a second primary source.
