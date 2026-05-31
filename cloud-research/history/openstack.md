# OpenStack — A Sourced History

**OpenStack** is an open-source cloud-computing platform — a collection of interrelated
projects that together provide **Infrastructure-as-a-Service (IaaS)**: compute, storage,
networking, identity, and orchestration, controllable through a common set of APIs and a
web dashboard. It was founded in **2010 by Rackspace Hosting and NASA** as an explicitly
open alternative to the proprietary public clouds (above all Amazon Web Services), with the
mission "to produce the ubiquitous Open Source Cloud Computing platform that will meet the
needs of public and private clouds regardless of size, by being simple to implement and
massively scalable."
Sources: https://en.wikipedia.org/wiki/OpenStack ,
https://docs.openstack.org/project-team-guide/introduction.html

> "We are founding the OpenStack initiative to help drive industry standards, prevent
> vendor lock-in and generally increase the velocity of innovation."
> — Lew Moorman, President of Cloud & Chief Strategy Officer, Rackspace, in the founding
> press release, 26 July 2010.
> Source: https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html

This document is a **broad history of OpenStack as a whole**. It deliberately does **not**
re-tell stories that already have dedicated docs:

### Cross-references (not duplicated here)

- **Heat (Orchestration)** — OpenStack's infrastructure-as-code / CloudFormation-compatible
  orchestration program has its own deep history in
  [`openstack-heat.md`](openstack-heat.md). This doc only mentions Heat in passing as one
  project in the constellation.
- **Ceph** — the de-facto software-defined storage backend for OpenStack (Cinder block,
  Glance images, and an alternative object store to Swift). See
  [`ceph.md`](ceph.md).
- **Swift vs. S3 / the object-storage paradigm** — for the history of the S3 API as a de
  facto standard and the ecosystem of S3-compatible implementations (against which Swift
  competed), see [`s3-object-storage.md`](s3-object-storage.md).

Every non-trivial factual claim below carries an inline source. Where a claim could not be
pinned to a primary or reputable source, it is marked **"Could not verify."**

---

## Timeline

### 2010 — Founding

- **21 July 2010** — OpenStack was announced publicly at **OSCON** (O'Reilly Open Source
  Convention) in Portland, Oregon. (The formal Rackspace/NASA press release carries a
  dateline of **26 July 2010**.)
  Sources: https://docs.openstack.org/project-team-guide/introduction.html ,
  https://en.wikipedia.org/wiki/OpenStack ,
  https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html
  - **Founding parents and seed code:**
    - **Rackspace Hosting** donated the code powering its **Cloud Files** (object storage)
      and **Cloud Servers** products. Cloud Files became the seed of **Swift**.
    - **NASA** contributed technology from its **Nebula Cloud Platform** (built at NASA Ames
      Research Center). Nebula's compute fabric became the seed of **Nova**.
    Sources: https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html ,
    https://www.hpcwire.com/2010/07/19/nasa_rackspace_open-sourcing_the_cloud/
  - **The motive** was an open, interoperable IaaS to counter the rise of Amazon Web
    Services and to "prevent vendor lock-in" (Moorman, above). NASA's interest was driven
    by the open-ended storage and compute demands of scientific computing: "Modern
    scientific computation requires ever increasing storage and processing power delivered
    on-demand." — Chris Kemp, NASA CTO for IT.
    Source: https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html

- **21 October 2010 — first release, "Austin" (2010.1).** The inaugural release combined
  the two seed projects: **OpenStack Compute (Nova)** — including an early **Glance** image
  registry — and **OpenStack Object Storage (Swift)**. The release blog post was published
  **25 October 2010** by Rick Clark, then Chief Architect of OpenStack.
  Sources: https://www.openstack.org/blog/announcing-the-openstack-2010-1-austin-release/ ,
  https://wiki.openstack.org/wiki/ReleaseNotes/Austin ,
  https://en.wikipedia.org/wiki/OpenStack
  - This established OpenStack's signature convention: **alphabetical release codenames**
    (Austin, Bexar, Cactus, Diablo, Essex, Folsom, Grizzly, Havana, Icehouse, Juno, Kilo,
    Liberty, Mitaka, Newton, Ocata, Pike, Queens, Rocky, Stein, Train, Ussuri, Victoria,
    Wallaby, Xena, Yoga, Zed …), traditionally tied to the location of the corresponding
    design summit. After "Zed" the project switched to year-based names (Antelope = 2023.1,
    Bobcat = 2023.2, Caracal = 2024.1, etc.).
    Sources: https://en.wikipedia.org/wiki/OpenStack ,
    https://releases.openstack.org/

### 2011–2012 — The constellation grows

- **3 February 2011 — "Bexar"** introduced **Glance** as a distinct image service.
  Source: https://en.wikipedia.org/wiki/OpenStack
- **5 April 2012 — "Essex"** added **Keystone** (identity) and **Horizon** (the web
  dashboard) as integrated projects.
  Source: https://en.wikipedia.org/wiki/OpenStack
- **27 September 2012 — "Folsom"** added **Quantum** (networking) and **Cinder** (block
  storage). **Quantum was later renamed Neutron** (because of a trademark conflict); the
  Neutron name took effect in the Havana cycle (2013).
  Sources: https://en.wikipedia.org/wiki/OpenStack ,
  https://openmetal.io/resources/blog/what-are-the-projects-that-make-up-openstack/

### September 2012 — The OpenStack Foundation

- **September 2012 — the OpenStack Foundation launched** as an independent non-profit to
  steward the project (previously the trademark and stewardship sat with Rackspace). It
  launched with **more than \$10 million** in committed funding from member dues and
  corporate sponsors, and named **Jonathan Bryce** — a co-founder of the Rackspace Cloud —
  as its **Executive Director**.
  Sources: https://www.datacenterknowledge.com/archives/2012/09/19/openstack-foundation-launches ,
  https://www.theregister.com/2012/09/19/openstack_foundation_nebula_jumpers ,
  https://en.wikipedia.org/wiki/OpenStack
  See **Foundation & governance** below for the later evolution.

### 2013 — Havana: Heat and Ceilometer

- **17 October 2013 — "Havana"** brought in **Heat** (orchestration) and **Ceilometer**
  (telemetry/metering) as integrated projects.
  Source: https://en.wikipedia.org/wiki/OpenStack
  - For Heat's full story (incubation during Grizzly, graduation in Feb 2013, the
    CloudFormation-compatibility design, the HOT template format, key people), see the
    dedicated doc [`openstack-heat.md`](openstack-heat.md). It is **not** repeated here.

### 2014–2015 — Bare metal, and the governance reform

- **17 April 2014 — "Icehouse"** added **Trove** (database-as-a-service).
  Source: https://en.wikipedia.org/wiki/OpenStack
- **30 April 2015 — "Kilo"** added **Ironic** (bare-metal provisioning), which had been
  forked out of Nova's bare-metal driver into a standalone project.
  Sources: https://en.wikipedia.org/wiki/OpenStack ,
  https://openmetal.io/resources/blog/what-are-the-projects-that-make-up-openstack/
- **The "Big Tent" governance change (2014–2015).** The Technical Committee approved a
  **"project structure reform" resolution dated 2 December 2014**; the new model — widely
  called the **"Big Tent"** — was rolled out across the **Kilo** (April 2015) and
  **Liberty** (October 2015) cycles. It abolished the curated "integrated release" and the
  Incubation gate, replacing the question *"Is this OpenStack?"* with *"Are you OpenStack?"*
  (i.e. does the project follow OpenStack's open processes), governed by a system of
  descriptive tags such as `tc-approved-release`. (See **Foundation & governance**.)
  Sources: https://governance.openstack.org/tc/resolutions/20141202-project-structure-reform-spec.html ,
  https://siliconangle.com/2015/10/16/openstack-liberty-release-intros-big-tent-governance-model/ ,
  https://www.eweek.com/cloud/openstack-moves-from-integrated-release-to-big-tent-model/

### 2015 — The vendor shakeout begins

- **1 April 2015 — Nebula shuts down** (Chris Kemp's startup; see **vendor wars** below).
  Source: https://venturebeat.com/2015/04/01/openstack-hardware-startup-nebula-shuts-down/
- **3 June 2015 — "OpenStack acquisitions galore":** on a single day, **IBM acquired
  Blue Box** and **Cisco acquired Piston Cloud** — marking the acceleration of market
  consolidation. (Cisco had already bought **Metacloud** in 2014.)
  Sources: https://www.networkworld.com/article/2930728/openstack-acquisitions-galore-ibm-buys-blue-box-cisco-snaps-up-piston.html ,
  https://techcrunch.com/2015/06/03/piston-goes-to-cisco-bluebox-to-ibm-as-openstack-consolidation-accelerates/
- **October 2015 — HP winds down Helion Public Cloud** (the public-cloud play shut down
  31 January 2016). See **vendor wars** below.
  Sources: https://venturebeat.com/business/hp-is-officially-shutting-down-its-helion-public-cloud-in-january-2016/ ,
  https://en.wikipedia.org/wiki/HPE_Helion

### 2019–2021 — Beyond OpenStack: the Foundation broadens

- **April 2019** — **Kata Containers** and **Zuul** were confirmed as the first top-level
  "Open Infrastructure Projects" of the OpenStack Foundation — the foundation's first
  projects that were **not** OpenStack itself.
  Source: https://www.openstack.org/news/view/426/kata-containers-and-zuul-are-first-pilot-projects-confirmed-as-toplevel-open-infrastructure-projects-by-the-openstack-foundation-board
- **19 October 2020** — the OpenStack Foundation announced it would be **renamed the
  Open Infrastructure Foundation (OpenInfra)**, effective **January 2021**, reflecting a
  broader scope across multiple open-infrastructure projects (OpenStack, Airship, Kata
  Containers, StarlingX, Zuul).
  Sources: https://techcrunch.com/2020/10/19/the-openstack-foundation-becomes-the-open-infrastructure-foundation/ ,
  https://en.wikipedia.org/wiki/OpenStack

### 2025 — Into the Linux Foundation

- **12 March 2025** — the OpenInfra Foundation board announced its **intent to join the
  Linux Foundation** (unanimous approval by both boards), to operate as a directed fund
  within the LF (the model used by CNCF and the PyTorch Foundation).
  Sources: https://www.linuxfoundation.org/press/open-infrastructure-foundation-board-announces-intent-to-join-the-linux-foundation ,
  https://www.theregister.com/2025/03/12/openinfra_joins_the_linux_foundation/ ,
  https://techcrunch.com/2025/03/12/openstack-comes-to-the-linux-foundation/
- **3 June 2025** — OpenInfra announced the deal was **closed**: "It's official: The
  OpenInfra Foundation is now part of the Linux Foundation." (Exact legal closing date not
  separately stated in the post.)
  Source: https://openinfra.org/blog/openinfra-joins-linux-foundation/
- **2024–2025 — resurgence narrative** driven by the Broadcom/VMware fallout (see
  **Resurgence**). OpenInfra Summit Europe (Paris, October 2025) was framed around
  "AI, Sovereignty and VMware Migrations."
  Source: https://www.prnewswire.com/news-releases/openinfra-summit-europe-kicks-off-in-paris-openinfra-is-the-resilience-playbook-for-ai-sovereignty-and-vmware-migrations-302586975.html

### 2026 — Mirantis exits to a neocloud

- **May 2026** — **IREN** (a Bitcoin-miner-turned-"neocloud" / AI-infrastructure company)
  agreed to acquire **Mirantis** — historically the leading pure-play OpenStack vendor — in
  a ~\$625 million all-stock deal. *The Register* headlined it "Neocloud IREN buys OpenStack
  champion Mirantis."
  Sources: https://www.theregister.com/off-prem/2026/05/07/neocloud-iren-buys-openstack-champion-mirantis/5231644 ,
  https://www.sdxcentral.com/news/iren-to-buy-mirantis-for-625m-to-strengthen-bare-metal-gpu-and-kubernetes-stack/

---

## The project constellation

OpenStack is not one program but a federation of services with code-name nicknames, each
exposing its own API and (usually) integrating through **Keystone** for identity. The
canonical core, in rough order of appearance:

| Project | Service | First integrated | Notes |
|---|---|---|---|
| **Nova** | Compute (VMs) | Austin (Oct 2010) | Seeded by NASA Nebula's compute fabric |
| **Swift** | Object storage | Austin (Oct 2010) | Seeded by Rackspace Cloud Files; compare to S3 — see [`s3-object-storage.md`](s3-object-storage.md) |
| **Glance** | Images | Bexar (Feb 2011) | VM/image registry & delivery |
| **Keystone** | Identity | Essex (Apr 2012) | Auth, authorization, service catalog |
| **Horizon** | Dashboard | Essex (Apr 2012) | Web UI across services |
| **Neutron** (orig. *Quantum*) | Networking | Folsom (Sep 2012) | SDN: networks, subnets, routers, ports |
| **Cinder** | Block storage | Folsom (Sep 2012) | Volumes for Nova/Ironic; commonly backed by Ceph RBD |
| **Heat** | Orchestration | Havana (Oct 2013) | Infrastructure-as-code; CloudFormation-compatible — see [`openstack-heat.md`](openstack-heat.md) |
| **Ceilometer** | Telemetry/metering | Havana (Oct 2013) | Usage data for billing/monitoring |
| **Trove** | Database-as-a-service | Icehouse (Apr 2014) | |
| **Ironic** | Bare-metal provisioning | Kilo (Apr 2015) | Forked from Nova's bare-metal driver |

Sources for the table: https://en.wikipedia.org/wiki/OpenStack ,
https://openmetal.io/resources/blog/what-are-the-projects-that-make-up-openstack/

After the **Big Tent** reform (2015), the number of official projects expanded well beyond
this core — OpenStack is often described as having on the order of **dozens of components**
("around sixty"), which is both a strength (modularity) and the root of its
"too complex" reputation (see **decline**).
Source: https://phoenixnap.com/blog/kubernetes-vs-openstack

Two storage relationships are worth flagging because they connect to the cross-referenced
docs:
- **Swift vs. S3.** Swift is OpenStack's native object store; the broader market converged
  on the **S3 API** as the de facto standard. See [`s3-object-storage.md`](s3-object-storage.md).
- **Ceph as the common backend.** In practice many OpenStack deployments use **Ceph** for
  Cinder (block, via RBD), Glance (images), and sometimes object storage (RADOS Gateway,
  which speaks both Swift and S3 APIs) rather than Swift. See [`ceph.md`](ceph.md).
  Source (Ceph's Swift/S3 gateway): https://docs.ceph.com/en/latest/architecture/

---

## Key people & teams

- **Chris C. Kemp** — **NASA's first CTO for IT** (and previously CIO at NASA Ames Research
  Center). He led the NASA team whose Nebula platform seeded **Nova**, and is credited as a
  co-founder of OpenStack. He later co-founded the startup **Nebula** (incorporated, as
  "Fourth Paradigm Development, Inc.," on 25 March 2011, with Steve O'Hara and Devin
  Carlen) to commercialize OpenStack hardware appliances.
  Sources: https://en.wikipedia.org/wiki/Chris_Kemp ,
  https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html
- **Joshua McKenty** — former NASA IT contractor and **founding technical architect of NASA
  Nebula**; an OpenStack "founding father." He co-founded the OpenStack startup **Piston
  Cloud Computing**, and in **September 2014** left Piston to join **Pivotal** as Field CTO
  for **Cloud Foundry** (Pivotal was later folded into VMware/VMware Tanzu).
  Sources: https://www.datacenterknowledge.com/archives/2014/09/30/openstack-founder-mckenty-to-lead-pivotals-cloud-foundry ,
  https://www.prnewswire.com/news-releases/cloud-visionary-and-openstack-founder-joins-pivotal-277611471.html
- **Lew Moorman** — President of Cloud & Chief Strategy Officer at **Rackspace**; one of
  the executive voices launching OpenStack ("prevent vendor lock-in").
  Source: https://www.prnewswire.com/news-releases/rackspace-announces-plans-to-collaborate-with-nasa-on-openstack-project-99223354.html
- **Jim Curry** — a Rackspace executive widely credited as a key driver of OpenStack's
  creation and early general manager of the effort. **Could not verify:** a primary,
  by-name press citation for Jim Curry's exact title/role in the founding pass (he is
  consistently named in secondary histories; the press release itself quotes Moorman and
  Kemp, not Curry).
- **Rick Clark** — Chief Architect of OpenStack at the time of the Austin release; authored
  the first release announcement.
  Source: https://www.openstack.org/blog/announcing-the-openstack-2010-1-austin-release/
- **Jonathan Bryce** — co-founder of the Rackspace Cloud; **Executive Director of the
  OpenStack Foundation from its 2012 launch**, and subsequently CEO/Executive Director of
  the Open Infrastructure Foundation. He steered the 2020 rename and the 2025 Linux
  Foundation merger.
  Sources: https://www.datacenterknowledge.com/archives/2012/09/19/openstack-foundation-launches ,
  https://techcrunch.com/2020/10/19/the-openstack-foundation-becomes-the-open-infrastructure-foundation/ ,
  https://openinfra.org/blog/openinfra-joins-linux-foundation/
- **Mark Collier** — long-time COO of the OpenStack/OpenInfra Foundation, frequently the
  public voice of its strategy ("Open source should be part of cloud, for infrastructure").
  Source: https://techcrunch.com/2020/10/19/the-openstack-foundation-becomes-the-open-infrastructure-foundation/

(For Heat-specific people — Steven Dake, Steve Hardy, Zane Bitter, etc. — see
[`openstack-heat.md`](openstack-heat.md).)

---

## Foundation & governance

OpenStack pioneered the now-common pattern of a **vendor-neutral foundation** stewarding a
large multi-project open-source ecosystem.

- **Stewardship handoff (2012).** OpenStack began under Rackspace's wing; the
  **OpenStack Foundation** was set up in **September 2012** to hold the trademark and run
  governance independently, launching with \$10M+ in funding and Jonathan Bryce as ED.
  Source: https://www.datacenterknowledge.com/archives/2012/09/19/openstack-foundation-launches
- **Technical governance.** A community-elected **Technical Committee (TC)** governs the
  technical side; each project team has an elected **PTL (Project Team Lead)**. Historically
  projects entered via **Incubation** and graduated to the curated **"integrated release."**
  Source: https://governance.openstack.org/tc/
- **The "Big Tent" (2014–2015).** A TC **resolution dated 2 December 2014** reformed the
  project structure: the integrated-release/incubation gatekeeping was replaced with a more
  inclusive model in which any project following OpenStack's processes could be "official,"
  with descriptive **tags** signaling maturity. It shipped across the **Kilo** and
  **Liberty** cycles. Supporters saw it as removing arbitrary gatekeeping; critics worried
  it would dilute the meaning of "OpenStack."
  Sources: https://governance.openstack.org/tc/resolutions/20141202-project-structure-reform-spec.html ,
  https://siliconangle.com/2015/10/16/openstack-liberty-release-intros-big-tent-governance-model/
  - **Attributed skepticism:** Mirantis's own blog asked, "Will the Big Tent 'break'
    OpenStack?" — capturing the worry that the looser model could fragment the project.
    Source: https://www.mirantis.com/blog/will-big-tent-break-openstack/
- **Rename to Open Infrastructure Foundation (2020/2021).** As the foundation took on
  projects beyond OpenStack — **Airship, Kata Containers, StarlingX, Zuul** (Kata and Zuul
  confirmed as the first top-level non-OpenStack projects in April 2019) — it rebranded:
  announced **19 October 2020**, effective **January 2021**.
  Sources: https://www.openstack.org/news/view/426/kata-containers-and-zuul-are-first-pilot-projects-confirmed-as-toplevel-open-infrastructure-projects-by-the-openstack-foundation-board ,
  https://techcrunch.com/2020/10/19/the-openstack-foundation-becomes-the-open-infrastructure-foundation/
- **Into the Linux Foundation (2025).** Intent announced **12 March 2025**; deal reported
  closed (member-ratified) by **3 June 2025**. OpenInfra now operates as a directed fund
  within the Linux Foundation, alongside the LF's other projects (Linux, Kubernetes/CNCF,
  PyTorch, etc.). Its four core projects — OpenStack, Kata Containers, StarlingX, Zuul —
  continue under their existing models.
  Sources: https://www.linuxfoundation.org/press/open-infrastructure-foundation-board-announces-intent-to-join-the-linux-foundation ,
  https://openinfra.org/blog/openinfra-joins-linux-foundation/

---

## The hype cycle, vendor wars & decline

> **Note on framing:** opinions and value-judgments in this section are **attributed** to
> their sources. There is genuine disagreement about how to characterize OpenStack's arc.

### The hype (≈2011–2015)

Following the 2010 founding, OpenStack rode an enormous wave of vendor and press
enthusiasm as the open answer to AWS. It won out over rival open-source IaaS efforts such as
**CloudStack** and **Eucalyptus**, and attracted backing from nearly every major IT vendor.
Chris Kemp, by then Nebula's CEO, told VentureBeat that the next year would be **"the year
of OpenStack."**
Sources: https://www.theregister.com/2020/10/22/openstack_at_10/ ,
https://venturebeat.com/cloud/nebula-ceo-former-nasa-cto-chris-kemp-next-year-is-the-year-of-openstack/

*The Register*'s 10-year retrospective records a vivid period quote of the hype's geopolitical
flavor: a Chinese government official reportedly declared, "OpenStack will smash the monopoly
of the Western cloud providers." (Attributed via that retrospective.)
Source: https://www.theregister.com/2020/10/22/openstack_at_10/

### The disillusionment: "too complex"

As the project sprawled into dozens of loosely-coupled services, OpenStack acquired a lasting
reputation for **operational complexity** — easy to start, hard to run and upgrade in
production.

- **Attributed (Gartner):** analyst **Michael Warrilow** framed the contradiction as
  "Everyone says they want open, then they say they want easy … They end up in the middle
  with an easy closed solution." — i.e., buyers said they wanted openness but defaulted to
  easier proprietary stacks.
  Source: https://www.theregister.com/2020/10/22/openstack_at_10/
- **Attributed (Aptira CEO Tristan Goode):** "I think the hype kind of killed the mission
  because it became a tug of war between vendors … pulled it away from being a cloud
  platform into being an infrastructure platform."
  Source: https://www.theregister.com/2020/10/22/openstack_at_10/
- **Attributed (The Register, 2020):** the publication's own verdict in the headline was
  that OpenStack at 10 was "a failure on its own terms, a success in its own niche" —
  noting the hyperscale public clouds ignored it, while it found real homes in private,
  telco, and research clouds.
  Source: https://www.theregister.com/2020/10/22/openstack_at_10/

### The vendor wars & shakeout

The pure-play OpenStack vendor market — once crowded — consolidated sharply, roughly
2014–2017:

- **Nebula** (Chris Kemp's hardware-appliance startup) — came out of stealth in 2011, raised
  ~\$38.5M (Kleiner Perkins, Highland, Comcast Ventures, plus angels Andy Bechtolsheim,
  David Cheriton, Ram Shriram) — **shut down 1 April 2015**, citing the immaturity of the
  OpenStack market and running out of runway before it matured.
  Sources: https://venturebeat.com/2015/04/01/openstack-hardware-startup-nebula-shuts-down/ ,
  https://techcrunch.com/2015/04/02/openstack-market-consolidation-continues-as-nebula-shuts-its-doors/ ,
  https://www.datacenterknowledge.com/archives/2015/04/01/private-openstack-startup-nebula-goes-out-of-business
- **Piston Cloud** (co-founded by Joshua McKenty) — **acquired by Cisco** (announced
  3 June 2015). (McKenty himself had already left Piston for Pivotal in September 2014.)
  Sources: https://techcrunch.com/2015/06/03/piston-goes-to-cisco-bluebox-to-ibm-as-openstack-consolidation-accelerates/ ,
  https://www.datacenterknowledge.com/archives/2014/09/30/openstack-founder-mckenty-to-lead-pivotals-cloud-foundry
- **Metacloud** — acquired by **Cisco in 2014**; **Blue Box** — acquired by **IBM**
  (announced 3 June 2015, same day as Piston/Cisco). Other deals in the same wave:
  **Cloudscaling** and **Virtustream** (EMC), **Eucalyptus** (HP).
  Sources: https://www.networkworld.com/article/2930728/openstack-acquisitions-galore-ibm-buys-blue-box-cisco-snaps-up-piston.html ,
  https://techcrunch.com/2015/06/03/piston-goes-to-cisco-bluebox-to-ibm-as-openstack-consolidation-accelerates/
- **HP / HP Helion** — HP's ambition to challenge AWS with a Helion public cloud collapsed:
  it stopped taking new public-cloud accounts on 21 October 2015 and **shut down Helion
  Public Cloud on 31 January 2016**, retreating to private/hybrid. (Per HPE Helion's own
  history, the broader Helion line wound down over 2015–2016.)
  Sources: https://venturebeat.com/business/hp-is-officially-shutting-down-its-helion-public-cloud-in-january-2016/ ,
  https://en.wikipedia.org/wiki/HPE_Helion
- **Mirantis** — the breakaway **pure-play OpenStack leader**, having raised a \$100M Series
  B, ultimately **pivoted toward Kubernetes/containers**, buying **Docker Enterprise**
  (assets, ~750 customers) on **13 November 2019** — a move *CIO Dive* framed as
  "a lifeline as industry shifts to Kubernetes." It later branded "Mirantis OpenStack for
  Kubernetes," running OpenStack on top of Kubernetes.
  Sources: https://www.ciodive.com/news/mirantis-docker-kubernetes-containers/567321/ ,
  https://www.mirantis.com/blog/mirantis-raises-100-million-series-b-challenging-incumbents-pure-play-openstack-leader/ ,
  https://en.wikipedia.org/wiki/Mirantis
- **Red Hat** continued to invest (the community **RDO** distribution and the commercial
  **Red Hat OpenStack Platform / RHOSP**, built with TripleO); **Canonical** shipped
  OpenStack on Ubuntu (via Juju/MAAS, later Sunbeam) — both treated OpenStack as part of a
  broader portfolio rather than a pure-play bet.
  Sources: https://www.redhat.com/en/blog/openstacks-history-community-and-7-its-core-projects ,
  https://en.wikipedia.org/wiki/OpenStack
  - **Could not verify (in this pass):** a single primary-source citation cleanly dating
    Canonical's OpenStack-distribution milestones — the claim that Canonical shipped/curated
    OpenStack on Ubuntu is well established generally but not pinned here to a specific
    primary URL. Marked **Could not verify: precise Canonical OpenStack milestone dates.**

### Kubernetes overshadows OpenStack

By the late 2010s, industry attention shifted decisively to **Kubernetes / containers**.
Commentators repeatedly cast Kubernetes as the new center of gravity, with OpenStack relegated
to specific niches; some even argued Kubernetes risked inheriting OpenStack's complexity
problem. (Opinion — attributed.)
Sources: https://www.ciodive.com/news/mirantis-docker-kubernetes-containers/567321/ ,
https://medium.com/@kp9810113/kubernetes-is-the-new-openstack-why-it-is-finally-becoming-too-complex-to-survive-9e9505c878d8

**The "OpenStack is dead / not dead" debate** is genuinely contested and should be attributed:
- Skeptics point to the vendor shakeout, the "too complex" reputation, hyperscaler
  indifference, and Kubernetes' dominance (e.g. *The Register*'s "failure on its own terms"
  framing).
  Source: https://www.theregister.com/2020/10/22/openstack_at_10/
- Defenders point to its survival and scale in private/telco/research clouds (CERN, Walmart,
  China Mobile, Chinese hyperscalers) and a post-2024 resurgence (see below). A 2025
  vendor-side rebuttal title captures the "not dead" camp: "OpenStack is back — not that it
  ever left" (Pure Storage).
  Sources: https://www.theregister.com/2022/11/18/openstack_thriving_survey/ ,
  https://blog.purestorage.com/perspectives/openstack-is-back-not-that-it-ever-left/

### Notable users

- **CERN** — one of the largest OpenStack deployments in the world, running hundreds of
  thousands of cores for LHC data processing (cited figure: 380,000+ CPU cores).
  Source: https://openmetal.io/resources/blog/who-is-using-openstack/
- **Walmart** — large retail OpenStack cloud (cited: 170,000+ cores across 30+ regions),
  used to handle peak events such as Black Friday.
  Source: https://openmetal.io/resources/blog/who-is-using-openstack/
- **China Mobile** — among a handful of organizations running **over 1 million cores** in
  production; OpenStack also underpins large Chinese providers (Tencent, Baidu cited).
  Sources: https://openmetal.io/resources/blog/who-is-using-openstack/ ,
  https://www.theregister.com/2020/10/22/openstack_at_10/
- More broadly, telcos and **sovereign/national clouds** are a core constituency — the
  foundation reports aggregate production usage growing past **40 million cores**.
  Source: https://www.theregister.com/2022/11/18/openstack_thriving_survey/
  - **Could not verify (precise figures):** the specific core counts above come from a
    vendor/secondary aggregation (OpenMetal) summarizing OpenInfra user-survey data; treat
    exact numbers as approximate. Marked **Could not verify: exact per-user core counts.**

---

## Resurgence

After years of "decline" framing, OpenStack saw a marked **resurgence in 2024–2025**, driven
largely by the fallout from **Broadcom's acquisition of VMware** (closed late 2023) and the
ensuing licensing/price changes.

- **The VMware-exit driver.** European cloud customers (via the CISPE trade body) reported
  Broadcom/VMware price increases ranging from **800% to 1,500%**, pushing enterprises to
  look for alternatives. OpenStack — as a mature, open IaaS that can run VMs at scale — became
  a leading "VMware exit" target. (Vendor and trade-body claims; attributed.)
  Sources: https://www.theregister.com/2025/05/22/euro_cloud_body_ecco_says_broadcom_licensing_unfair/ ,
  https://openmetal.io/resources/blog/navigating-the-vmware-exit/ ,
  https://platform9.com/blog/the-resurgence-of-openstack-addressing-the-cloud-conundrum/
- **Sovereign cloud.** Renewed regulatory and geopolitical pressure for **data sovereignty**
  (especially in Europe and Asia-Pacific) gave OpenStack a second tailwind, since it enables
  fully self-hosted/sovereign clouds. The OpenInfra Summit Europe 2025 (Paris) was explicitly
  themed around "AI, Sovereignty and VMware Migrations," and OpenInfra positioned OpenStack as
  the "resilience playbook."
  Sources: https://www.prnewswire.com/news-releases/openinfra-summit-europe-kicks-off-in-paris-openinfra-is-the-resilience-playbook-for-ai-sovereignty-and-vmware-migrations-302586975.html ,
  https://www.theregister.com/2025/10/31/resilience_openinfra_summit/
- **Caveat on the growth numbers.** Bullish market projections (e.g. an "OpenStack services
  market" growing from ~\$22.8B in 2024 toward ~\$91B by 2029 at ~32% CAGR) come from
  **market-research and vendor sources**, not OpenInfra primary data — treat as
  vendor/analyst optimism, attributed.
  Sources: https://www.mordorintelligence.com/industry-reports/openstack-services-market ,
  https://openmetal.io/resources/blog/navigating-the-vmware-exit/

### Current status (as of mid-2026)

- OpenStack remains an **actively developed, officially governed** project. Releases continue
  on a roughly six-month cadence under year-based names (Antelope/2023.1 → Caracal/2024.1 →
  and onward), now under the **Open Infrastructure Foundation operating inside the Linux
  Foundation** (merger closed June 2025).
  Sources: https://releases.openstack.org/ ,
  https://openinfra.org/blog/openinfra-joins-linux-foundation/
- The vendor landscape keeps shifting: in **May 2026**, **Mirantis** — the original pure-play
  OpenStack champion — agreed to be acquired by the neocloud/AI-infrastructure firm **IREN**
  (~\$625M), a deal some analysts read as a sign of where independent open-cloud vendors are
  heading (toward AI infrastructure). (Analysis — attributed.)
  Sources: https://www.theregister.com/off-prem/2026/05/07/neocloud-iren-buys-openstack-champion-mirantis/5231644 ,
  https://hyperframeresearch.com/2026/05/11/does-an-exit-to-a-bitcoin-miner-signal-the-end-of-independent-open-cloud/

---

## Summary

OpenStack was founded in **July 2010** by **Rackspace** (donating Cloud Files → Swift and
Cloud Servers) and **NASA** (donating the Nebula compute fabric → Nova) as an open-source IaaS
to counter AWS and prevent vendor lock-in. Its first release, **"Austin," shipped 21 October
2010**, establishing the alphabetical-codename tradition. The platform grew into a
**constellation** of services (Glance, Keystone, Horizon, Neutron née Quantum, Cinder, Heat,
Ceilometer, Trove, Ironic, …), governed by an independent **OpenStack Foundation (Sept 2012,
ED Jonathan Bryce)**, reformed via the **"Big Tent"** model (2014–2015), **rebranded the Open
Infrastructure Foundation (2020/2021)**, and ultimately **folded into the Linux Foundation
(2025)** while stewarding Kata Containers, Zuul, and StarlingX alongside OpenStack.

Its arc ran through enormous **2011–2015 hype**, a "**too complex**" disillusionment, and a
brutal **vendor shakeout** (Nebula shut down; Piston/Metacloud → Cisco; Blue Box → IBM; HP
Helion shut down; Mirantis pivoting to Kubernetes), with **Kubernetes** ultimately
overshadowing it — all of which fed an attributed "**OpenStack is dead / not dead**" debate.
Yet it survived and thrived in **private, telco, research, and sovereign clouds** (CERN,
Walmart, China Mobile), and enjoyed a **2024–2025 resurgence** powered by the
**Broadcom/VMware** price shock and the **sovereign-cloud** narrative. As of mid-2026 it is
actively maintained under the Linux-Foundation-housed OpenInfra Foundation, even as the vendor
landscape keeps churning (Mirantis → IREN, May 2026).

### Could-not-verify items
1. **Jim Curry's exact founding title/role** — named consistently in secondary histories as a
   key Rackspace driver, but the founding press release quotes Moorman and Kemp, not Curry; no
   by-name primary citation pinned here.
2. **Precise Canonical OpenStack-distribution milestone dates** — Canonical's role shipping
   OpenStack on Ubuntu is well established generally but not pinned to a specific primary URL
   in this pass.
3. **Exact per-user core counts** (CERN ~380k, Walmart ~170k, China Mobile >1M) — drawn from
   a vendor/secondary aggregation of OpenInfra user-survey data; approximate.
4. **Bullish market-size projections** for the OpenStack "resurgence" — from market-research /
   vendor sources, not OpenInfra primary data; attributed as analyst/vendor optimism.
5. **The exact legal closing date** of the OpenInfra → Linux Foundation merger — the
   announcement that it was "now part of the Linux Foundation" is dated 3 June 2025, but a
   distinct signing/closing date was not separately stated.
