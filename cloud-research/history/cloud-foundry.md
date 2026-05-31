# Cloud Foundry — A Sourced History

A chronological, sourced history of Cloud Foundry, the open-source
platform-as-a-service (PaaS) that VMware launched in April 2011 as "the
industry's first open PaaS," and its long arc through Pivotal, the Cloud
Foundry Foundation, VMware/Broadcom, and the move onto Kubernetes (Korifi).
Every non-trivial claim links to a working source. Primary sources
(VMware/Pivotal/Cloud Foundry Foundation/Linux Foundation blogs and press,
founders' own posts, SEC filings) are preferred, with reputable outlets
(TechCrunch, The Register, InfoQ, GeekWire, InformationWeek, etc.) as
corroboration. Items that could not be confirmed are marked
**"Could not verify."**

> Scope note: Cloud Foundry and its release/deploy tool **BOSH** are tightly
> coupled. This doc focuses on Cloud Foundry the PaaS; for BOSH's own history
> and internal model, see the companion `bosh.md`. There is some deliberate
> overlap on the corporate timeline (VMware → Pivotal → Foundation →
> VMware/Broadcom), since both projects share it.

---

## The name: two different "Cloud Foundry" projects

The Cloud Foundry that VMware launched in 2011 is **unrelated** to an earlier
PaaS project that also bore the name. The name traces to a startup acquired in
2009:

- **SpringSource quietly acquired a startup called "Cloud Foundry" in June
  2009.** The Register reported: "SpringSource itself quietly scooped up the
  technology back in June by acquiring a startup called (shock!) Cloud
  Foundry," describing it as "built on the open-source Cloud Tools project
  currently used for Java Enterprise applications on Amazon EC2."
  - [VMware target Springs to open-source cloud management — The Register (2009-08-19)](https://www.theregister.com/2009/08/19/springsource_cloud_foundry/)

- VMware acquired SpringSource in 2009, so the "Cloud Foundry" name came into
  the VMware family that way. Wikipedia describes the original project as
  founded by **Chris Richardson in 2008** (a Java PaaS for Amazon EC2) and
  acquired by SpringSource in 2009; the VMware-developed project (below) later
  adopted the name when the original project ceased operation.
  - [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

> **Could not verify (precisely):** The Register's June-2009 acquisition note
> does not name the founder of the acquired startup. The "Chris Richardson /
> 2008 / Amazon EC2 Java PaaS" attribution is from Wikipedia; treat the founder
> attribution as **secondary-sourced**. The Register independently confirms the
> June-2009 acquisition and the Amazon-EC2-Java nature of the original
> technology.

---

## Timeline

### 2009 — Conceived at VMware as "Project B29"

The Cloud Foundry that exists today "was initially developed in 2009 by a small
team at VMware led by **Derek Collison**, at that point under the name 'Project
B29.'" Per VMware's own retrospective, "It was renamed that same year, grew
quickly, and by 2011 it was open sourced."

- [The Past, Present and Future of Cloud Foundry – Part 1 — VMware Open Source blog (2020-06-25)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

Collison himself has described the project's framing: NATS (the messaging
system, see below) "was kicked off as part of a system that he was building at
VMware called Cloud Foundry, which was his spin on Heroku for the enterprise
back in 2010" — explicitly positioning Cloud Foundry against Heroku.
- [RedMonk Conversation with Derek Collison (2025-02-10)](https://redmonk.com/blog/2025/02/10/rmc-derek-collison-the-forrest-gump-of-messaging/)

### April 12, 2011 — VMware launches Cloud Foundry as "the industry's first open PaaS"

VMware unveiled Cloud Foundry on **April 12, 2011**, as an open-source PaaS
released under the **Apache 2** license. InfoQ's contemporaneous coverage dates
the launch to April 12, 2011, names VMware's **Tod Nielsen** (Co-President,
Application Platform) and **Jerry Chen** (Senior Director of Cloud and
Application Services), and lists the supported frameworks/services: Java and
JVM frameworks (Grails, Roo), Ruby (Rails, Sinatra), Node.js, and services
including RabbitMQ, MySQL, MongoDB, and Redis. VMware pitched it as
"multi-cloud," spanning private and public environments.

- [VMware Unveils Open Source PaaS Cloud Foundry — InfoQ (2011-04)](https://www.infoq.com/news/2011/04/VMWare-Cloud-Foundry/)
- [What VMware's Cloud Foundry announcement is about — O'Reilly Radar (2011-04)](http://radar.oreilly.com/2011/04/what-vmwares-cloud-foundry-ann.html)

The launch had three prongs: a hosted public service at **cloudfoundry.com**
(beta), the open-source project/community at **CloudFoundry.org** (Apache 2),
and a forthcoming **Micro Cloud** (Q2 2011).
- [VMware Introduces Cloud Foundry, The Industry's First Open PaaS — VMware/Broadcom press release (April 2011)](https://news.broadcom.com/releases/cloud-foundry-apr2011)

> **Could not verify (via direct fetch):** The Broadcom-hosted permalink for the
> April 2011 VMware press release did not render its body to automated fetching
> in this session (it resolved to a Broadcom news index). The April 12, 2011
> date, the "first open PaaS" framing, Apache 2 license, and supported
> frameworks are independently confirmed by InfoQ and O'Reilly Radar.

### April 2012 — BOSH publicly launched

Cloud Foundry's release/deploy tool **BOSH** ("BOSH Outer Shell") was open
sourced by VMware on **April 11, 2012**. See `bosh.md` for the full BOSH
history; in short, BOSH was built by the Cloud Foundry team to deploy and
operate Cloud Foundry itself.
- [BOSH Turns Five! — Cloud Foundry Foundation blog (2017-04-11)](https://www.cloudfoundry.org/blog/bosh-turns-five/)
- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

### April 2013 — Pivotal spun out (EMC / VMware / GE)

In **April 2013**, **Pivotal** was created from EMC and VMware "to market
assets including Cloud Foundry, RabbitMQ and Spring." VMware's retrospective:
"In April 2013, Pivotal spun out from EMC and VMware to focus on supporting
several promising open source projects, including Cloud Foundry."

- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- [The Past, Present and Future of Cloud Foundry – Part 1 — VMware Open Source blog](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)

The spin-out was announced in **March 2013**, formally launched in Q2 2013 with
~1,400 employees (~600 from VMware, ~800 from EMC), led by former VMware CEO
**Paul Maritz**. On **April 24, 2013**, **General Electric invested $105
million** for a ~10% stake. The combined entity carried VMware's Cloud Foundry
and vFabric lines plus EMC's Greenplum/Pivotal Labs assets.
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)
- [EMC launches its cloudy Federation with Pivotal big data spinoff — The Register (2013-03-13)](https://www.theregister.com/2013/03/13/emc_vmware_pivotal_spinoff/)

> **Could not verify:** A day-level date for the Pivotal spinout's Cloud
> Foundry transfer (sources give "April 2013" / "March 2013 announced, Q2 2013
> launched").

### December 9, 2014 — Cloud Foundry Foundation announced

On **December 9, 2014**, the **Cloud Foundry Foundation** was established as an
independent nonprofit, managed as a **Linux Foundation Collaborative Project**,
with founding **Platinum members EMC, HP, IBM, Intel, Pivotal, SAP, and
VMware**. Pivotal CEO Paul Maritz was quoted: "The Cloud is too important to
allow it to become proprietary and have customers locked in."

- [Cloud Foundry Foundation Established to Advance Platform-as-a-Service — Linux Foundation press release (2014-12-09)](https://www.linuxfoundation.org/press/press-release/cloud-foundry-foundation-established-to-advance-platform-as-a-service)
- [Why Today's Cloud Foundry Foundation Launch Matters — VMware Cloud Provider Blog (2014-12)](https://web.archive.org/web/20151001112643/http://blogs.vmware.com:80/vcloud/2014/12/todays-cloud-foundry-foundation-launch-matters.html)

### January 2015 — Foundation incorporated; Sam Ramji named CEO

The Foundation was formally incorporated in **January 2015**. Wikipedia: "In
January 2015, the Cloud Foundry Foundation was created as an independent
not-for-profit 501(c)(6) Linux Foundation Collaborative Project." Cloud Foundry
(both the Elastic Runtime and BOSH) was placed under the Foundation's
stewardship. **Sam Ramji** was named the Foundation's first **CEO** (announced
February 2015), notably choosing the "CEO" title to signal commercial ambition.

- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- [Cloud Foundry Foundation Names Sam Ramji As CEO — Data Center Knowledge (2015-02-16)](https://www.datacenterknowledge.com/archives/2015/02/16/cloud-foundry-foundation-names-ceo)
- [Ex-Microsoft open source plan man lands top Cloud Foundry job — The Register (2015-02-12)](https://www.theregister.com/2015/02/12/sam_ramji_cloud_foundry_foundation_ceo)

### ~2015–2016 — Diego/Garden replace the DEA runtime

Cloud Foundry's original runtime — the **Droplet Execution Agent (DEA)**,
mostly Ruby, with **Warden** containers — was replaced by **Diego**, a
Go-based, self-healing container-orchestration runtime, using **Garden**
containers (Go-based, OCI-aligned, with pluggable Linux/Windows backends).
Diego subsumed app scheduling from the Cloud Controller and replaced the DEAs
and the HM9000 health manager, adding one-off **Tasks** alongside
**Long-Running Processes**.

- [Diego components and architecture — Cloud Foundry Docs](https://docs.cloudfoundry.org/concepts/diego/diego-architecture.html)
- [Differences Between DEA and Diego Architectures — Pivotal Docs](https://docs.pivotal.io/pivotalcf/2-5/concepts/diego/dea-vs-diego.html)
- [Cloud Foundry Diego Approaching 250,000 Containers in a Single Cluster — Cloud Foundry blog](https://www.cloudfoundry.org/blog/cloud-foundry-approaching-250000-containers/)

> **Could not verify:** A single dated primary announcement for Diego's GA / DEA
> retirement. The DEA→Diego/Warden→Garden architectural transition is documented
> in the official Cloud Foundry/Pivotal docs above, but an exact cut-over date
> was not pinned to a dated press item in this session (commonly placed
> ~2015–2016).

### April 20, 2018 — Pivotal IPO (NYSE: PVTL)

Pivotal Software went public on the **New York Stock Exchange on April 20,
2018**, under the ticker **PVTL**, pricing its IPO at **$15/share and raising
~$555 million**; its flagship product was **Pivotal Cloud Foundry**. Shares
closed up ~4% at $15.73 on day one. Dell Technologies (which had gained Pivotal
via its EMC acquisition) controlled the supermajority of voting power.

- [Pivotal Software closed up 5% following IPO, raised $555 million — TechCrunch (2018-04-20)](https://techcrunch.com/2018/04/20/pivotal-software-closes-up-5-following-ipo-raised-555-million/)
- [Pivotal Software is Latest Tech IPO — BigDataWire (2018-04-20)](https://www.bigdatawire.com/2018/04/20/pivotal-software-is-latest-tech-ipo/)
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)

### December 30, 2019 — VMware re-acquires Pivotal

VMware **completed its acquisition of Pivotal on December 30, 2019**, at an
enterprise value of **~$2.7 billion**; Pivotal "will now operate as a wholly
owned subsidiary of VMware," delisting PVTL from the NYSE. The deal had been
signed **August 22, 2019** (blended ~$11.71/share). Pivotal's Cloud Foundry
capabilities were folded into VMware's **Tanzu** portfolio.

- [VMware Completes Acquisition of Pivotal — GlobeNewswire / VMware press release (2019-12-30)](https://www.globenewswire.com/news-release/2019/12/30/1964966/0/en/VMware-Completes-Acquisition-of-Pivotal.html)
- [VMware Completes Acquisition of Pivotal — SEC filing (Form 8-K exhibit, FY2019)](https://www.sec.gov/Archives/edgar/data/1574135/000110465919076595/tm1917575d25_ex99-1.htm)

### May 16, 2022 — Korifi: Cloud Foundry on Kubernetes

The Cloud Foundry Foundation announced **Korifi**, a **beta** open-source PaaS
that brings the classic `cf push` Cloud Foundry experience to **Kubernetes**,
on **May 16, 2022**. Korifi implements a **CF API translation layer** (a subset
of the **v3 Cloud Foundry APIs**) on top of Kubernetes, using Paketo
buildpacks to produce OCI containers. Foundation figures framed it as making
Cloud Foundry "interoperate well with the growing ecosystem of other
cloud-native technologies" (Craig McLuckie, Governing Board Chair).

- [Cloud Foundry Launches New Kubernetes Platform: Korifi — Cloud Foundry blog (2022-05-16)](https://www.cloudfoundry.org/blog/cloud-foundry-launches-new-platform-to-simplify-kubernetes-developer-experience/)
- [cloudfoundry/korifi — GitHub](https://github.com/cloudfoundry/korifi)
- [korifi/docs/architecture.md — GitHub](https://github.com/cloudfoundry/korifi/blob/main/docs/architecture.md)

### November 13, 2024 — Korifi Marketplace

At KubeCon on **November 13, 2024**, the Foundation announced **Korifi 0.13.0**,
introducing the **Cloud Foundry Marketplace for Korifi** for discovering/
deploying pre-built apps and services (databases, message queues).
- [Cloud Foundry Introduces Marketplace for Korifi — Cloud Foundry blog (2024-11)](https://www.cloudfoundry.org/blog/cloud-foundry-introduces-marketplace-for-korifi-providing-access-to-pre-built-applications-and-services/)
- [Cloud Foundry Introduces Marketplace for Korifi — PRNewswire (2024-11)](https://www.prnewswire.com/news-releases/cloud-foundry-introduces-marketplace-for-korifi-providing-access-to-pre-built-applications-and-services-302304100.html)

### November 22, 2023 — Broadcom completes acquisition of VMware

Broadcom **completed its acquisition of VMware on November 22, 2023**, bringing
the VMware Tanzu / Cloud Foundry commercial assets under Broadcom. The Cloud
Foundry open-source project continued under the Cloud Foundry Foundation (a
directed fund of the Linux Foundation).
- [Broadcom Completes Acquisition of VMware — Broadcom investor relations (2023-11-22)](https://investors.broadcom.com/news-releases/news-release-details/broadcom-completes-acquisition-vmware)
- [What is Cloud Foundry? — TechTarget](https://www.techtarget.com/searchcloudcomputing/definition/Cloud-Foundry)

> **Could not verify:** A primary-source statement detailing exactly how the
> Broadcom acquisition changed Cloud Foundry's open-source governance. The
> Foundation continued operating under the Linux Foundation; corporate ownership
> (VMware → Broadcom) is one stakeholder among many, not the project's governing
> body.

---

## Key people & teams

- **Derek Collison** — Conceived and led Cloud Foundry at VMware (from 2009,
  as "Project B29"); served as VMware's CTO/Chief Architect of the Application
  Platform. He has called Cloud Foundry "his spin on Heroku for the enterprise."
  He left to found **Apcera** (2012), then **Synadia** (2017) around **NATS**
  — see his full trajectory below.
  - [The Past, Present and Future of Cloud Foundry – Part 1 — VMware Open Source blog](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
  - [RedMonk Conversation with Derek Collison (2025-02-10)](https://redmonk.com/blog/2025/02/10/rmc-derek-collison-the-forrest-gump-of-messaging/)

- **Mark Lucovsky** — VMware **VP of Engineering for Cloud Foundry** (~2011–
  2013). A Windows NT veteran (principal architect at Microsoft for ~16 years)
  and former Google engineering director, he co-led Cloud Foundry's engineering
  alongside Collison. He left VMware in 2013, later joining Meta (2017) as GM of
  Operating Systems for its VR/AR hardware.
  - [CloudStory.in Interview with Mark Lucovsky, VP of Engineering, Cloud Foundry at VMware — YourStory (2012-09)](https://yourstory.com/2012/09/an-interview-with-mark-lucovsky-vp-of-engineering-cloud-foundry-at-vmware)
  - [Former Microsoftie And Googler Lucovsky Leaves VMware For New Project — TechCrunch (2013-09-27)](https://techcrunch.com/2013/09/27/former-microsoftie-and-googler-lucovsky-leaves-vmware-for-new-project-no-word-on-chairs-thrown/)
  - *(The "Java, Ruby, PHP, Node.js" framing and the Meta/Mombo Labs details are
    per secondary summaries; treat the post-VMware roles as **reported**.)*

- **Chip Childers** — First staff member / co-founder of the **Cloud Foundry
  Foundation** (2015, as Technology Chief of Staff); named **CTO in November
  2016**; became **Executive Director on April 2, 2020**. Previously the first
  VP of Apache CloudStack. He steered the Foundation's pivot toward a
  Kubernetes-based platform.
  - [Cloud Foundry Foundation's CTO Steps into Executive Director Role — PRNewswire (2020)](https://www.prnewswire.com/news-releases/cloud-foundry-foundations-cto-steps-into-executive-director-role-301036443.html)
  - [Cloud Foundry Names Abby Kearns Executive Director, Chip Childers CTO — Cloud Foundry blog](https://www.cloudfoundry.org/blog/cloud-foundry-names-abby-kearns-executive-director-chip-childers-cto/)

- **Sam Ramji** — First **CEO** of the Cloud Foundry Foundation (Feb 2015);
  departed for Google in November 2016.
  - [Cloud Foundry Foundation CEO Sam Ramji departs for Google — TechCrunch (2016-11-17)](https://techcrunch.com/2016/11/17/cloud-foundry-foundation-ceo-sam-ramji-departs-for-google/)

- **Abby Kearns** — Succeeded Ramji; named **Executive Director** of the Cloud
  Foundry Foundation when Ramji left (Chip Childers became CTO).
  - [Abby Kearns named Executive Director of Cloud Foundry Foundation — CIO](https://www.cio.com/article/236632/abby-kearns-named-ceo-of-cloud-foundry-foundation-sam-ramji-headed-to-google.html)

- **Paul Maritz** — Former VMware CEO who became **CEO of Pivotal** at the 2013
  spinout and championed the Foundation's open-governance launch.
  - [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)
  - [Cloud Foundry Foundation Established... — Linux Foundation (2014-12-09)](https://www.linuxfoundation.org/press/press-release/cloud-foundry-foundation-established-to-advance-platform-as-a-service)

> **Could not verify:** A complete roster of the original VMware Cloud Foundry
> engineering team. Sources consistently name Collison (lead/architect) and
> Lucovsky (VP Eng); other individual founding engineers are not enumerated in
> the primary sources reviewed.

---

## Company & corporate history (Cloud Foundry the project's ownership chain)

- **2008–2009** — A *different* "Cloud Foundry" (a Java-on-EC2 PaaS, founded by
  Chris Richardson per Wikipedia) is acquired by SpringSource (June 2009); VMware
  acquires SpringSource (2009).
  [The Register (2009-08-19)](https://www.theregister.com/2009/08/19/springsource_cloud_foundry/) ·
  [Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- **2009** — VMware's own PaaS ("Project B29," led by Derek Collison) is built,
  renamed Cloud Foundry that year.
  [VMware Open Source blog](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
- **April 12, 2011** — VMware launches Cloud Foundry as the "industry's first
  open PaaS" (Apache 2). [InfoQ](https://www.infoq.com/news/2011/04/VMWare-Cloud-Foundry/)
- **April 2012** — BOSH open-sourced.
  [BOSH Turns Five!](https://www.cloudfoundry.org/blog/bosh-turns-five/)
- **April 2013** — Pivotal spun out (EMC/VMware; GE invests $105M Apr 24, 2013);
  Cloud Foundry moves to Pivotal.
  [Wikipedia (Pivotal)](https://en.wikipedia.org/wiki/Pivotal_Software) ·
  [The Register (2013-03-13)](https://www.theregister.com/2013/03/13/emc_vmware_pivotal_spinoff/)
- **December 9, 2014 / January 2015** — Cloud Foundry Foundation announced, then
  incorporated; Sam Ramji named CEO.
  [Linux Foundation (2014-12-09)](https://www.linuxfoundation.org/press/press-release/cloud-foundry-foundation-established-to-advance-platform-as-a-service) ·
  [Data Center Knowledge (2015-02-16)](https://www.datacenterknowledge.com/archives/2015/02/16/cloud-foundry-foundation-names-ceo)
- **April 20, 2018** — Pivotal IPO on NYSE (PVTL), ~$555M raised, Pivotal Cloud
  Foundry the flagship product.
  [TechCrunch (2018-04-20)](https://techcrunch.com/2018/04/20/pivotal-software-closes-up-5-following-ipo-raised-555-million/)
- **December 30, 2019** — VMware re-acquires Pivotal (~$2.7B); Pivotal becomes a
  VMware subsidiary; Cloud Foundry folds into Tanzu.
  [VMware press release (2019-12-30)](https://www.globenewswire.com/news-release/2019/12/30/1964966/0/en/VMware-Completes-Acquisition-of-Pivotal.html)
- **May 16, 2022** — Korifi (Cloud Foundry on Kubernetes) announced (beta).
  [Cloud Foundry blog](https://www.cloudfoundry.org/blog/cloud-foundry-launches-new-platform-to-simplify-kubernetes-developer-experience/)
- **November 22, 2023** — Broadcom completes its VMware acquisition; Tanzu/Cloud
  Foundry commercial assets move under Broadcom.
  [Broadcom IR](https://investors.broadcom.com/news-releases/news-release-details/broadcom-completes-acquisition-vmware)

---

## Rivalries and relationships

- **Heroku.** Cloud Foundry was conceived as an *enterprise* answer to Heroku.
  Collison: NATS "was kicked off as part of a system that he was building at
  VMware called Cloud Foundry, which was his spin on Heroku for the enterprise."
  The `cf push` UX mirrors Heroku's `git push`-style deploy ergonomics, and the
  two projects later converged on **Cloud Native Buildpacks** in the broader
  cloud-native ecosystem (CNB was started by Pivotal and Heroku — see
  `heroku.md`).
  - [RedMonk Conversation with Derek Collison (2025-02-10)](https://redmonk.com/blog/2025/02/10/rmc-derek-collison-the-forrest-gump-of-messaging/)
- **Kubernetes.** Initially a separate, BOSH-deployed PaaS stack, Cloud Foundry
  has progressively repositioned around Kubernetes — most concretely via
  **Korifi**, which reimplements the CF v3 API on top of Kubernetes rather than
  the BOSH/Diego stack.
  - [korifi/docs/architecture.md — GitHub](https://github.com/cloudfoundry/korifi/blob/main/docs/architecture.md)

> **Could not verify:** A first-party Cloud Foundry document framing OpenShift
> as a named "rival." The Cloud-Foundry-vs-Heroku and Cloud-Foundry-and-
> Kubernetes relationships are directly sourced above; the OpenShift rivalry,
> while widely discussed in trade press as part of the 2010s PaaS market, was
> **not** pinned to a primary Cloud Foundry source in this session — so it is
> omitted rather than asserted.

---

## Derek Collison after Cloud Foundry: Apcera → NATS → Synadia

- **Apcera (founded 2012).** After Cloud Foundry, Collison founded **Apcera**
  in 2012 in San Francisco — "where he designed the first open
  Platform-as-a-Service (PaaS), Cloud Foundry" — building a container
  management/policy platform.
  - [Apcera — Wikipedia](https://en.wikipedia.org/wiki/Apcera)
- **Ericsson (majority stake, September 2014).** Apcera emerged from stealth and
  on the same day **Ericsson acquired a majority stake** (undisclosed terms),
  which Ericsson called "the most significant investment to date in deploying
  the next generation of PaaS technology." Wikipedia dates the majority-stake
  acquisition to **September 30, 2014**.
  - [Apcera Emerges, Gets Snapped Up By Ericsson — InformationWeek (2014-09)](https://www.informationweek.com/software-services/apcera-emerges-gets-snapped-up-by-ericsson)
  - [Apcera — Wikipedia](https://en.wikipedia.org/wiki/Apcera)
- **NATS.** **NATS**, the high-performance messaging system, originated inside
  Cloud Foundry (Collison "kicked off" NATS as part of building Cloud Foundry at
  VMware, ~2010) and Collison continued developing it at Apcera.
  - [RedMonk Conversation with Derek Collison (2025-02-10)](https://redmonk.com/blog/2025/02/10/rmc-derek-collison-the-forrest-gump-of-messaging/)
- **Synadia (founded 2017).** Collison founded **Synadia** in 2017 to
  commercialize NATS; **Synadia donated NATS to the CNCF in 2018** under Apache
  2.0.
  - [CNCF and Synadia align on securing the future of the NATS.io project — PRNewswire (2025)](https://www.prnewswire.com/news-releases/cncf-and-synadia-align-on-securing-the-future-of-the-natsio-project-302444407.html)
- **The 2025 NATS / CNCF trademark dispute.** In 2025, Synadia sought to
  relicense future NATS releases under the **Business Source License (BSL)**
  and demanded the NATS.io domain and GitHub repos back; the CNCF filed a
  trademark petition. They **settled on May 2, 2025**: Synadia assigned its NATS
  trademark registrations to the Linux Foundation, the CNCF retained the NATS
  infrastructure/domain/repos under Apache 2.0, and Synadia remained free to
  build proprietary offerings on top of (or fork) open-source NATS.
  - [CNCF and Synadia settle NATS dispute — The Register (2025-05-02)](https://www.theregister.com/2025/05/02/cncf_synadia_nats/)
  - [CNCF tells NATS contributor Synadia it's free to fork off — The Register (2025-04-28)](https://www.theregister.com/2025/04/28/cncf_synadia_nats_dispute/)

> **Could not verify:** Whether/when Ericsson moved from majority stake to full
> ownership of Apcera, and any precise Apcera shutdown date. One search summary
> claimed Ericsson "now owns all of the company," but the primary/secondary
> sources reviewed (Wikipedia, InformationWeek) document only the **2014
> majority-stake** acquisition. The "full ownership" / shutdown claim is
> **omitted** rather than asserted.

---

## Controversies / contested points

> Each item separates **established fact** from **reported claim**, with
> attribution.

### 1. The two "Cloud Foundry" names
- **Fact:** A pre-existing "Cloud Foundry" (Java-on-EC2 PaaS) was acquired by
  SpringSource in June 2009; VMware's own, unrelated "Project B29" later took
  the name. [The Register (2009-08-19)](https://www.theregister.com/2009/08/19/springsource_cloud_foundry/)
- **Reported/secondary:** The original startup's founder (Chris Richardson) and
  2008 founding year are per Wikipedia, not the contemporaneous Register report.
  [Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

### 2. "Industry's first open PaaS"
- **Reported claim (VMware marketing):** Cloud Foundry was billed as "the
  industry's first open PaaS." This is VMware's own framing in its launch
  materials, not a neutral adjudication.
  [InfoQ (2011-04)](https://www.infoq.com/news/2011/04/VMWare-Cloud-Foundry/)

### 3. NATS relicensing / CNCF trademark fight (2025)
- **Fact:** Synadia (Collison) sought BSL relicensing and demanded NATS assets
  back; CNCF filed a trademark petition; they settled May 2, 2025, with Synadia
  assigning trademarks to the Linux Foundation and CNCF keeping NATS under
  Apache 2.0. [The Register (2025-05-02)](https://www.theregister.com/2025/05/02/cncf_synadia_nats/)

---

## Items marked "Could not verify"

- **Direct fetch of the April 2011 VMware press release body** — the Broadcom
  permalink resolved to a news index for automated fetching; date/claims
  corroborated by InfoQ and O'Reilly Radar.
- **Founder of the original (pre-VMware) "Cloud Foundry" startup** — Chris
  Richardson / 2008 is Wikipedia-sourced; the contemporaneous Register report
  confirms only the June-2009 acquisition and Amazon-EC2-Java nature.
- **Day-level date for the April 2013 Pivotal spinout / Cloud Foundry transfer**
  — sources give "April 2013" (announced March 2013).
- **A single dated primary announcement for Diego GA / DEA retirement** —
  architecture is documented; exact cut-over date not pinned (≈2015–2016).
- **A first-party Cloud Foundry framing of OpenShift as a named rival** — omitted
  rather than asserted; Heroku and Kubernetes relationships are directly sourced.
- **Ericsson moving from majority stake to full ownership of Apcera, and any
  Apcera shutdown date** — only the 2014 majority-stake acquisition is sourced.
- **Complete roster of the original VMware Cloud Foundry engineering team** —
  sources name Collison and Lucovsky; others not enumerated.
- **Post-VMware roles of Mark Lucovsky** (Mombo Labs, Meta) — secondary summary,
  treated as reported.

---

## Sources (all verified reachable during research)

- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)
- [Apcera — Wikipedia](https://en.wikipedia.org/wiki/Apcera)
- [The Past, Present and Future of Cloud Foundry – Part 1 — VMware Open Source blog (2020-06-25)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
- [VMware Unveils Open Source PaaS Cloud Foundry — InfoQ (2011-04)](https://www.infoq.com/news/2011/04/VMWare-Cloud-Foundry/)
- [What VMware's Cloud Foundry announcement is about — O'Reilly Radar (2011-04)](http://radar.oreilly.com/2011/04/what-vmwares-cloud-foundry-ann.html)
- [VMware Introduces Cloud Foundry, The Industry's First Open PaaS — VMware/Broadcom press release (April 2011)](https://news.broadcom.com/releases/cloud-foundry-apr2011)
- [VMware target Springs to open-source cloud management — The Register (2009-08-19)](https://www.theregister.com/2009/08/19/springsource_cloud_foundry/)
- [EMC launches its cloudy Federation with Pivotal big data spinoff — The Register (2013-03-13)](https://www.theregister.com/2013/03/13/emc_vmware_pivotal_spinoff/)
- [Cloud Foundry Foundation Established to Advance Platform-as-a-Service — Linux Foundation (2014-12-09)](https://www.linuxfoundation.org/press/press-release/cloud-foundry-foundation-established-to-advance-platform-as-a-service)
- [Why Today's Cloud Foundry Foundation Launch Matters — VMware Cloud Provider Blog (2014-12)](https://web.archive.org/web/20151001112643/http://blogs.vmware.com:80/vcloud/2014/12/todays-cloud-foundry-foundation-launch-matters.html)
- [Cloud Foundry Foundation Names Sam Ramji As CEO — Data Center Knowledge (2015-02-16)](https://www.datacenterknowledge.com/archives/2015/02/16/cloud-foundry-foundation-names-ceo)
- [Ex-Microsoft open source plan man lands top Cloud Foundry job — The Register (2015-02-12)](https://www.theregister.com/2015/02/12/sam_ramji_cloud_foundry_foundation_ceo)
- [Cloud Foundry Foundation CEO Sam Ramji departs for Google — TechCrunch (2016-11-17)](https://techcrunch.com/2016/11/17/cloud-foundry-foundation-ceo-sam-ramji-departs-for-google/)
- [Abby Kearns named Executive Director of Cloud Foundry Foundation — CIO](https://www.cio.com/article/236632/abby-kearns-named-ceo-of-cloud-foundry-foundation-sam-ramji-headed-to-google.html)
- [Cloud Foundry Foundation's CTO Steps into Executive Director Role — PRNewswire (2020)](https://www.prnewswire.com/news-releases/cloud-foundry-foundations-cto-steps-into-executive-director-role-301036443.html)
- [Cloud Foundry Names Abby Kearns Executive Director, Chip Childers CTO — Cloud Foundry blog](https://www.cloudfoundry.org/blog/cloud-foundry-names-abby-kearns-executive-director-chip-childers-cto/)
- [CloudStory.in Interview with Mark Lucovsky — YourStory (2012-09)](https://yourstory.com/2012/09/an-interview-with-mark-lucovsky-vp-of-engineering-cloud-foundry-at-vmware)
- [Former Microsoftie And Googler Lucovsky Leaves VMware For New Project — TechCrunch (2013-09-27)](https://techcrunch.com/2013/09/27/former-microsoftie-and-googler-lucovsky-leaves-vmware-for-new-project-no-word-on-chairs-thrown/)
- [Diego components and architecture — Cloud Foundry Docs](https://docs.cloudfoundry.org/concepts/diego/diego-architecture.html)
- [Differences Between DEA and Diego Architectures — Pivotal Docs](https://docs.pivotal.io/pivotalcf/2-5/concepts/diego/dea-vs-diego.html)
- [Cloud Foundry Diego Approaching 250,000 Containers in a Single Cluster — Cloud Foundry blog](https://www.cloudfoundry.org/blog/cloud-foundry-approaching-250000-containers/)
- [Pivotal Software closed up 5% following IPO, raised $555 million — TechCrunch (2018-04-20)](https://techcrunch.com/2018/04/20/pivotal-software-closes-up-5-following-ipo-raised-555-million/)
- [Pivotal Software is Latest Tech IPO — BigDataWire (2018-04-20)](https://www.bigdatawire.com/2018/04/20/pivotal-software-is-latest-tech-ipo/)
- [VMware Completes Acquisition of Pivotal — GlobeNewswire / VMware (2019-12-30)](https://www.globenewswire.com/news-release/2019/12/30/1964966/0/en/VMware-Completes-Acquisition-of-Pivotal.html)
- [VMware Completes Acquisition of Pivotal — SEC 8-K exhibit (FY2019)](https://www.sec.gov/Archives/edgar/data/1574135/000110465919076595/tm1917575d25_ex99-1.htm)
- [Cloud Foundry Launches New Kubernetes Platform: Korifi — Cloud Foundry blog (2022-05-16)](https://www.cloudfoundry.org/blog/cloud-foundry-launches-new-platform-to-simplify-kubernetes-developer-experience/)
- [cloudfoundry/korifi — GitHub](https://github.com/cloudfoundry/korifi)
- [korifi/docs/architecture.md — GitHub](https://github.com/cloudfoundry/korifi/blob/main/docs/architecture.md)
- [Cloud Foundry Introduces Marketplace for Korifi — Cloud Foundry blog (2024-11)](https://www.cloudfoundry.org/blog/cloud-foundry-introduces-marketplace-for-korifi-providing-access-to-pre-built-applications-and-services/)
- [Cloud Foundry Introduces Marketplace for Korifi — PRNewswire (2024-11)](https://www.prnewswire.com/news-releases/cloud-foundry-introduces-marketplace-for-korifi-providing-access-to-pre-built-applications-and-services-302304100.html)
- [Broadcom Completes Acquisition of VMware — Broadcom IR (2023-11-22)](https://investors.broadcom.com/news-releases/news-release-details/broadcom-completes-acquisition-vmware)
- [What is Cloud Foundry? — TechTarget](https://www.techtarget.com/searchcloudcomputing/definition/Cloud-Foundry)
- [Apcera Emerges, Gets Snapped Up By Ericsson — InformationWeek (2014-09)](https://www.informationweek.com/software-services/apcera-emerges-gets-snapped-up-by-ericsson)
- [RedMonk Conversation with Derek Collison (2025-02-10)](https://redmonk.com/blog/2025/02/10/rmc-derek-collison-the-forrest-gump-of-messaging/)
- [CNCF and Synadia align on securing the future of the NATS.io project — PRNewswire (2025)](https://www.prnewswire.com/news-releases/cncf-and-synadia-align-on-securing-the-future-of-the-natsio-project-302444407.html)
- [CNCF and Synadia settle NATS dispute — The Register (2025-05-02)](https://www.theregister.com/2025/05/02/cncf_synadia_nats/)
- [CNCF tells NATS contributor Synadia it's free to fork off — The Register (2025-04-28)](https://www.theregister.com/2025/04/28/cncf_synadia_nats_dispute/)
- [BOSH Turns Five! — Cloud Foundry Foundation blog (2017-04-11)](https://www.cloudfoundry.org/blog/bosh-turns-five/)
