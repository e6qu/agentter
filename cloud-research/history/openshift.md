# Red Hat OpenShift — A Sourced History

A chronological, sourced history of Red Hat OpenShift: its 2011 launch as a
Platform-as-a-Service (PaaS) rooted in the 2010 Makara acquisition; the v1/v2
"gears and cartridges" architecture; the pivotal 2015 v3 rewrite onto Docker and
Kubernetes; the OpenShift 4 era built on the CoreOS acquisition (RHEL CoreOS, the
Operator pattern); OKD as the open-source upstream; and OpenShift's role in IBM's
$34B acquisition of Red Hat. Every non-trivial claim links to a working source.
Primary sources (Red Hat press releases and blogs, the OpenShift/OKD docs and
GitHub, IBM investor materials) are preferred, with reputable outlets (TechCrunch,
The Register, SDxCentral, etc.) as corroboration. Items that could not be confirmed
are marked **"Could not verify."**

---

## Timeline

### Origins: the Makara acquisition (November 2010)

- **November 30, 2010** — Red Hat announced it had **acquired Makara**, a
  Redwood City, California company that provided solutions to "deploy, manage,
  monitor and scale" applications on private or public clouds. Red Hat folded
  Makara's technology into its **Cloud Foundations** portfolio to accelerate a
  PaaS offering. Paul Cormier, then president of Products and Technologies,
  framed it as giving "customers and developers… an easy on-ramp to the cloud."
  - Source (primary): [Red Hat press release, "Red Hat Accelerates PaaS Strategy with Acquisition of Makara"](https://www.redhat.com/en/about/press-releases/makara)
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ("OpenShift originated from Red Hat's acquisition of Makara, a company marketing a platform as a service (PaaS) based on Linux containers, in 2010.")
  - Makara's container-based PaaS technology was a direct ancestor of OpenShift's
    "gears" (its early Linux-container abstraction). The "based on Linux
    containers" characterization is per Wikipedia.

### Launch as a PaaS (May 2011)

- **May 4, 2011** — Red Hat **launched OpenShift** as a Platform-as-a-Service,
  initially as a developer preview, with the concept featured in **Paul
  Cormier's keynote at Red Hat Summit** (Boston). It was launched as
  **proprietary** technology.
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) (initial release "May 4, 2011"; "announced in May 2011 as proprietary technology")
  - Source (primary, Red Hat partner-ecosystem announcement same week): [Business Wire / Red Hat, "Cloud Leaders Join Red Hat's Open Platform-as-a-Service Ecosystem" (May 4, 2011)](https://www.businesswire.com/news/home/20110504005646/en/Cloud-Leaders-Join-Red-Hat%E2%80%99s-Open-Platform-as-a-Service)
  - Source (Red Hat retrospective): [Red Hat blog, "PaaS to Kubernetes to cloud services: Looking back at 10 years of Red Hat OpenShift"](https://www.redhat.com/en/blog/paas-kubernetes-cloud-services-looking-back-10-years-red-hat-openshift) ("OpenShift… featured at Red Hat Summit in Paul Cormier's keynote")
  - **Could not verify from a single primary source: the exact "developer preview" wording for the May 4, 2011 launch.** Wikipedia gives the May 4, 2011 initial-release date; the "developer preview" framing is consistent across secondary retellings but was not pinned to a dated Red Hat primary document in this pass.

- **May 2012 — OpenShift goes open source (OpenShift Origin).** Roughly a year
  after launch, Red Hat open-sourced the platform as **OpenShift Origin**, the
  upstream community distribution.
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ("only became open-source in May 2012")
  - **Could not verify: a dated primary Red Hat announcement specifically for the May 2012 open-sourcing** (the "May 2012" month is from Wikipedia).

### The v1/v2 "gears and cartridges" architecture (2011–2015)

- **OpenShift v2 architecture.** The pre-Kubernetes OpenShift supported a variety
  of languages, frameworks, and databases via pre-built **"cartridges"** running
  under resource-quota **"gears."** A *gear* was an isolated, resource-constrained
  container (implemented with Linux **cgroups** and **SELinux**) in which
  applications ran; a *cartridge* was a plug-in that gave a gear its
  "personality" — a defined technology stack such as JBoss, Python, or MySQL. The
  system was split into **broker** (a central REST API service), **nodes** (which
  ran the gears), cartridges, a web **console**, and a **messaging** layer
  between broker and nodes.
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ("supported a variety of languages, frameworks, and databases via pre-built 'cartridges' running under resource-quota 'gears'")
  - Source (primary, v2 code/docs — now deprecated): [openshift/origin-server (GitHub): "OpenShift 2 (deprecated)"](https://github.com/openshift/origin-server)
  - Source (Red Hat docs comparing v2 and v3): [Red Hat Product Documentation, "Comparing with OpenShift Enterprise 2" (OCP 3.11 release notes)](https://docs.redhat.com/en/documentation/openshift_container_platform/3.11/html/release_notes/release-notes-v2-vs-v3)
  - Source (history narrative): [The New Stack, "Red Hat OpenShift Part 1: From Gears to Docker"](https://thenewstack.io/red-hat-openshift-part-1-from-gears-to-docker/)
  - Per the Red Hat 10-year retrospective, gears were the "predecessors to Linux
    containers" and cartridges supplied application runtimes, developed through the
    OpenShift Origin upstream community. ([Red Hat 10-years blog](https://www.redhat.com/en/blog/paas-kubernetes-cloud-services-looking-back-10-years-red-hat-openshift))

- **November 2012 — OpenShift Enterprise 1.0.** Red Hat launched the on-premises
  enterprise edition, **OpenShift Enterprise 1.0**, around the first AWS
  re:Invent.
  - Source (Red Hat retrospective): [Red Hat blog, "Looking back at 10 years of Red Hat OpenShift"](https://www.redhat.com/en/blog/paas-kubernetes-cloud-services-looking-back-10-years-red-hat-openshift) ("Red Hat OpenShift Enterprise 1.0… launched at the first AWS re:Invent conference" in November 2012)
  - **Could not verify: a precise GA date for OpenShift Online 1.0** (the hosted service). Different secondary sources place general availability of the hosted service in late 2012; no single dated primary source was confirmed here.

### The pivotal v3 rewrite: Docker + Kubernetes (June 2015)

This was OpenShift's defining bet — abandoning its own custom container and
orchestration stack (gears/cartridges) for Docker-format containers and Kubernetes.

- **June 24, 2015 — OpenShift Enterprise 3 GA.** Red Hat announced general
  availability of **OpenShift Enterprise 3** at Red Hat Summit (Boston),
  describing it as "the first enterprise-ready web-scale container application
  platform based on **Docker-format Linux containers**, **Kubernetes**
  orchestration and **Red Hat Enterprise Linux 7**." Ashesh Badani (then VP/GM,
  OpenShift) was the quoted Red Hat executive; the press release notes Red Hat
  developed Kubernetes "with Google."
  - Source (primary): [Red Hat press release, "Red Hat Delivers OpenShift Enterprise 3 to Power a New Web-Scale Distributed Application Platform" (June 24, 2015)](https://www.redhat.com/en/about/press-releases/red-hat-delivers-openshift-enterprise-3-power-new-web-scale-distributed-application-platform)
  - Source (Red Hat / OpenShift blog framing): [OpenShift Blog, "Red Hat puts Docker, Kubernetes at the center of its OpenShift 3 PaaS"](https://web.archive.org/web/2id_/https://blog.openshift.com/red-hat-puts-docker-kubernetes-at-the-center-of-its-openshift-3-paas/)
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ("Until version 3, released in June 2015, OpenShift used custom developed technologies… Version 3 adopted Docker… and Kubernetes…")

- **Context: an early enterprise bet on Kubernetes.** Red Hat had joined Google's
  Kubernetes effort early (the project went open source in mid-2014), and Clayton
  Coleman — later OpenShift's lead architect — became, by Red Hat's account, the
  **first external contributor to Kubernetes** and the architect of OpenShift's
  reinvention "from PaaS to enterprise Kubernetes."
  - Source: [The Register, "'Boringly reliable': Red Hat architect thinks Kubernetes is 'mostly done'" (June 17, 2020)](https://www.theregister.com/2020/06/17/kubernetes_clayton_coleman_interview/)
  - Source: [Kubernetes Podcast from Google, Ep. 85: "OpenShift and Kubernetes, with Clayton Coleman"](https://kubernetespodcast.com/episode/085-openshift-and-kubernetes/)
  - The "first external contributor" / "reinvention from PaaS to enterprise
    Kubernetes" framing comes from these (Red Hat-adjacent) sources. **Could not
    verify "first external contributor" from a neutral primary source** — treat as
    reported.

- **v2 sunset.** With v3 superseding it, the OpenShift v2 (gears/cartridges)
  hosted service was withdrawn on **September 30, 2017** for non-paying customers
  and **December 31, 2017** for paying customers.
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift)

### The CoreOS acquisition (January 2018)

- **January 30, 2018 — Red Hat to acquire CoreOS for ~$250 million.** Red Hat
  announced a definitive agreement to acquire **CoreOS**, a Kubernetes startup
  whose products included **Tectonic** (an enterprise Kubernetes platform),
  **Container Linux** (a lightweight, auto-updating container OS), the **Quay**
  container registry, and stewardship of **etcd**. Red Hat president Paul Cormier
  said the deal "cements Red Hat as a cornerstone of hybrid cloud and modern app
  deployments"; CoreOS CEO Alex Polvi was also quoted. Press reported CoreOS had
  ~130 employees and had raised ~$50M (largely from Alphabet's GV).
  - Source (primary): [Red Hat press release, "Red Hat to Acquire CoreOS, Expanding its Kubernetes and Containers Leadership" (Jan 30, 2018)](https://www.redhat.com/en/about/press-releases/red-hat-acquire-coreos-expanding-its-kubernetes-and-containers-leadership)
  - Source (price, headcount, funding): [TechCrunch, "Red Hat acquires CoreOS for $250 million in Kubernetes expansion" (Jan 30, 2018)](https://techcrunch.com/2018/01/30/red-hat-acquirescoreos-for-250-million-in-kubernetes-expansion/)
  - Source: [SDxCentral, "Red Hat Doubles Down on Containers with $250M CoreOS Acquisition"](https://www.sdxcentral.com/news/red-hat-doubles-down-on-containers-with-250m-coreos-acquisition/)
  - The ~$250M figure was "subject to closing adjustments" per Red Hat; the
    ~130 employees / ~$50M raised figures are from TechCrunch.

- **The Operator pattern (CoreOS, 2016) — the intellectual seed of OpenShift 4.**
  CoreOS had introduced the **"Operator"** concept in **November 2016**: software
  that encodes an operator's/engineer's domain knowledge (a "runbook") and
  extends the Kubernetes API (via custom resources) to automate
  create/configure/manage of stateful applications. The first Operators were the
  **etcd Operator** and the **Prometheus Operator**; CoreOS CTO **Brandon
  Philips** is credited with the concept. CoreOS later (2018) packaged this into
  the **Operator Framework** (SDK, Operator Lifecycle Manager, metering).
  - Source (primary, CoreOS): [CoreOS Blog, "Introducing Operators: Putting Operational Knowledge into Software"](https://coreos.com/blog/introducing-operators.html)
  - Source: [TechCrunch, "CoreOS introduces Operators to streamline Kubernetes container management" (Nov 3, 2016)](https://techcrunch.com/2016/11/03/coreos-introduces-operators-to-streamline-kubernetes-container-management/)
  - Source (Operator Framework, 2018): [TechCrunch, "RedHat's CoreOS launches a new toolkit for managing Kubernetes applications" (May 1, 2018)](https://techcrunch.com/2018/05/01/redhats-coreos-launches-a-new-toolkit-for-managing-kubernetes-applications/)

### OKD: the open-source upstream renamed (August 2018)

- **August 3, 2018 — OpenShift Origin renamed OKD.** With the v3.10 release, Red
  Hat renamed the upstream community distribution from **OpenShift Origin** to
  **OKD** ("the Origin Community Distribution of Kubernetes that powers Red Hat
  OpenShift"), relaunching the site as **okd.io**. OKD is the upstream from which
  the commercial OpenShift Container Platform is built.
  - Source (primary): [Red Hat Developer, "OKD: Renaming of OpenShift Origin with 3.10 release" (Aug 3, 2018)](https://developers.redhat.com/blog/2018/08/03/okd-renaming-of-openshift-origin-with-3-10-release)
  - Source (project): [okd-project/okd (GitHub), "OKD: The Community Distribution of Kubernetes that powers Red Hat OpenShift"](https://github.com/okd-project/okd)
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ("OKD, known until August 2018 as OpenShift Origin…")

### OpenShift 4: full-stack automation on RHEL CoreOS and Operators (2019)

- **May 8, 2019 — OpenShift 4 announced at Red Hat Summit.** Red Hat unveiled
  **OpenShift 4**, built directly on the CoreOS acquisition. Key elements:
  - **Red Hat Enterprise Linux CoreOS (RHEL CoreOS)** — "a fully immutable,
    container optimized Linux OS host," using the RHEL 8 kernel/core libraries,
    delivered and installed as a component of OpenShift (successor to CoreOS's
    Container Linux).
  - **Operators everywhere** — Operators (the CoreOS pattern) now drove the
    platform itself, including **over-the-air, telemetry-driven cluster updates**
    and a new automated **installer**.
  - **OperatorHub** and the **Operator Lifecycle Manager (OLM)** — an embedded
    registry of curated Operators (Red Hat cited 40+ at launch), launched with
    AWS, Google Cloud, and Microsoft.
  - Red Hat said **more than 1,000 organizations** were using OpenShift Container
    Platform. The launch blog was authored by **Joe Fernandes** (then VP/GM for
    OpenShift / cloud platforms). General availability followed "in the next
    month."
  - Source (primary, launch blog): [Red Hat blog, "Introducing Red Hat OpenShift 4: Kubernetes for the Enterprise" — Joe Fernandes (May 8, 2019)](https://www.redhat.com/en/blog/introducing-red-hat-openshift-4)
  - Source (Summit recap): [Red Hat blog, "Recapping all of the news from Red Hat Summit 2019"](https://web.archive.org/web/2id_/https://www.redhat.com/en/blog/recapping-all-news-red-hat-summit-2019)
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) (v4 adopted **CRI-O** as the container runtime, **Podman** for pods/containers, and **Buildah** for builds — removing the direct Docker dependency; control-plane components run on RHEL CoreOS)
  - **Could not verify: an exact day-level GA date for OpenShift 4.1** (the launch blog says "available in the next month" from May 8, 2019; a precise GA date was not pinned to a primary source here).

### IBM's $34B acquisition of Red Hat (closed July 2019)

- **July 9, 2019 — IBM closed its acquisition of Red Hat (~$34 billion).** IBM
  completed its purchase of all outstanding Red Hat common shares at **$190.00
  per share in cash**, a total equity value of approximately **$34 billion** —
  IBM's largest deal ever. The strategic thesis was an open, hybrid multicloud
  platform built on Linux and Kubernetes, with **OpenShift** positioned as the
  centerpiece. Ginni Rometty (IBM CEO) and Jim Whitehurst (Red Hat CEO, who
  joined IBM's senior leadership) were quoted; Red Hat was to retain operational
  independence from Raleigh, NC.
  - Source (primary, Red Hat): [Red Hat press release, "IBM Closes Landmark Acquisition of Red Hat for $34 Billion; Defines Open, Hybrid Cloud Future" (July 9, 2019)](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future)
  - Source (primary, IBM): [IBM Investor Relations, "IBM Completes Acquisition of Red Hat"](https://www.ibm.com/investor/news/ibm-completes-acquisition-of-red-hat)
  - For IBM, OpenShift became the standard hybrid-cloud application platform —
    OpenShift was the technical foundation IBM repeatedly cited to justify the
    price. (Strategic framing per the Red Hat and IBM releases above.)

### Where OpenShift sits today (2020s)

- OpenShift evolved into a broad managed/hybrid family: **OpenShift Dedicated**,
  **Red Hat OpenShift Service on AWS (ROSA)**, **Azure Red Hat OpenShift (ARO)**,
  OpenShift on IBM Cloud, plus edge variants (**MicroShift** / Red Hat Device
  Edge). The stable release as of this writing is **4.21 (February 3, 2026)**.
  - Source: [OpenShift — Wikipedia](https://en.wikipedia.org/wiki/OpenShift) (stable release 4.21, Feb 3, 2026; managed offerings)
  - Source (Red Hat retrospective listing ROSA / ARO / IBM Cloud / MicroShift): [Red Hat blog, "Looking back at 10 years of Red Hat OpenShift"](https://www.redhat.com/en/blog/paas-kubernetes-cloud-services-looking-back-10-years-red-hat-openshift)

---

## Key people & teams

- **Paul Cormier** — Long-time Red Hat president of Products and Technologies (and
  later Red Hat CEO/Chairman); the executive face of the **Makara acquisition
  (2010)**, the OpenShift PaaS launch keynote (2011), and the **CoreOS
  acquisition (2018)**.
  ([Makara press release](https://www.redhat.com/en/about/press-releases/makara);
  [CoreOS press release](https://www.redhat.com/en/about/press-releases/red-hat-acquire-coreos-expanding-its-kubernetes-and-containers-leadership))
- **Clayton Coleman** — Lead architect of Red Hat OpenShift and a top upstream
  Kubernetes contributor (emeritus Kubernetes Steering Committee). Credited by
  Red Hat-adjacent sources as the architect of OpenShift's reinvention from PaaS
  to "enterprise Kubernetes." Worked at IBM ~10 years before Red Hat.
  ([The Register interview](https://www.theregister.com/2020/06/17/kubernetes_clayton_coleman_interview/);
  [Kubernetes Podcast Ep. 85](https://kubernetespodcast.com/episode/085-openshift-and-kubernetes/))
- **Ashesh Badani** — VP/GM of OpenShift at the time of the **v3 (2015)** launch;
  the quoted Red Hat executive on the OpenShift Enterprise 3 press release; later
  a senior Red Hat product leader.
  ([OpenShift Enterprise 3 press release](https://www.redhat.com/en/about/press-releases/red-hat-delivers-openshift-enterprise-3-power-new-web-scale-distributed-application-platform))
- **Joe Fernandes** — VP/GM for OpenShift / cloud platforms who authored the
  **OpenShift 4 (2019)** launch blog; later VP/GM of Red Hat's AI Business Unit
  (RHEL AI, OpenShift AI).
  ([OpenShift 4 launch blog](https://www.redhat.com/en/blog/introducing-red-hat-openshift-4);
  [Red Hat author page](https://www.redhat.com/en/authors/joe-fernandes))
- **Alex Polvi** — Co-founder and CEO of **CoreOS**, acquired by Red Hat in 2018.
  ([CoreOS press release](https://www.redhat.com/en/about/press-releases/red-hat-acquire-coreos-expanding-its-kubernetes-and-containers-leadership))
- **Brandon Philips** — CoreOS CTO, credited with introducing the **Operator**
  pattern (2016) that became central to OpenShift 4.
  ([CoreOS "Introducing Operators" blog](https://coreos.com/blog/introducing-operators.html))
- **Jim Whitehurst** — Red Hat CEO at the time of the **IBM acquisition (2019)**;
  joined IBM's senior management team post-close.
  ([IBM/Red Hat closing release](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future))

---

## Company & corporate history

- **November 30, 2010** — Red Hat **acquires Makara** (Redwood City, CA),
  seeding OpenShift's PaaS technology.
  [Makara press release](https://www.redhat.com/en/about/press-releases/makara)
- **May 4, 2011** — **OpenShift launches** as a PaaS (proprietary), keynoted at
  Red Hat Summit. [Wikipedia](https://en.wikipedia.org/wiki/OpenShift) ·
  [Business Wire (May 4, 2011)](https://www.businesswire.com/news/home/20110504005646/en/Cloud-Leaders-Join-Red-Hat%E2%80%99s-Open-Platform-as-a-Service)
- **May 2012** — OpenShift **open-sourced** as **OpenShift Origin**.
  [Wikipedia](https://en.wikipedia.org/wiki/OpenShift)
- **November 2012** — **OpenShift Enterprise 1.0** (on-prem) launches around AWS
  re:Invent. [Red Hat 10-years blog](https://www.redhat.com/en/blog/paas-kubernetes-cloud-services-looking-back-10-years-red-hat-openshift)
- **June 24, 2015** — **OpenShift Enterprise 3** GA: the pivot to **Docker +
  Kubernetes**, abandoning gears/cartridges.
  [OpenShift Enterprise 3 press release](https://www.redhat.com/en/about/press-releases/red-hat-delivers-openshift-enterprise-3-power-new-web-scale-distributed-application-platform)
- **January 30, 2018** — Red Hat **acquires CoreOS** (~$250M) — Tectonic,
  Container Linux, Quay, etcd, and the Operator pattern.
  [Red Hat CoreOS press release](https://www.redhat.com/en/about/press-releases/red-hat-acquire-coreos-expanding-its-kubernetes-and-containers-leadership) ·
  [TechCrunch](https://techcrunch.com/2018/01/30/red-hat-acquirescoreos-for-250-million-in-kubernetes-expansion/)
- **August 3, 2018** — **OpenShift Origin renamed OKD** (v3.10), relaunched at
  okd.io. [Red Hat Developer](https://developers.redhat.com/blog/2018/08/03/okd-renaming-of-openshift-origin-with-3-10-release)
- **May 8, 2019** — **OpenShift 4** announced: RHEL CoreOS, Operators,
  OperatorHub/OLM, over-the-air updates.
  [OpenShift 4 launch blog](https://www.redhat.com/en/blog/introducing-red-hat-openshift-4)
- **July 9, 2019** — **IBM closes its ~$34B acquisition of Red Hat** ($190/share);
  OpenShift positioned as the hybrid-cloud centerpiece.
  [Red Hat closing release](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future) ·
  [IBM IR](https://www.ibm.com/investor/news/ibm-completes-acquisition-of-red-hat)
- **2020s** — Managed/hybrid expansion (ROSA, ARO, OpenShift on IBM Cloud,
  MicroShift); stable release 4.21 (Feb 3, 2026).
  [Wikipedia](https://en.wikipedia.org/wiki/OpenShift)

---

## The enterprise-Kubernetes competition

OpenShift's market positioning evolved through two competitive eras:

- **PaaS era (early 2010s) — vs. Cloud Foundry (and Heroku-style PaaS).** As a
  PaaS, OpenShift competed most directly with **Cloud Foundry**, the other major
  open-source enterprise PaaS of the period. Comparisons commonly note OpenShift
  bundled more out of the box (registry, monitoring, CI/CD) versus Cloud Foundry
  requiring more assembly.
  - Source (comparison framing): [TechTarget, "Compare Rancher vs. OpenShift vs. Tanzu for Kubernetes"](https://www.techtarget.com/searchitoperations/post/Compare-Rancher-vs-OpenShift-vs-Tanzu-for-Kubernetes)

- **Enterprise-Kubernetes era (post-2015) — vs. Rancher and VMware Tanzu.** After
  the v3 pivot, OpenShift competed as an enterprise Kubernetes distribution
  against **Rancher** (later SUSE) and **VMware Tanzu** (which grew out of
  VMware's Heptio/Pivotal acquisitions). Analysts characterize OpenShift as the
  most opinionated/integrated and highest-list-price option, Rancher as the
  lightest multi-cluster manager, and Tanzu as most efficient inside a VMware
  estate.
  - Source: [TechTarget, "Compare Rancher vs. OpenShift vs. Tanzu for Kubernetes"](https://www.techtarget.com/searchitoperations/post/Compare-Rancher-vs-OpenShift-vs-Tanzu-for-Kubernetes)
  - Source: [sanj.dev, "Rancher vs OpenShift vs Tanzu: Enterprise K8s Guide"](https://sanj.dev/post/rancher-openshift-tanzu-enterprise-kubernetes-comparison)
  - These "who's best for what" judgments are the **analysis/opinion of those
    outlets**, not neutral facts.

---

## Controversies & contested framings

> Separating **established fact** from **reported claim / characterization**.

### 1. The v3 rewrite — a discontinuous break for v2 customers

- **Fact:** OpenShift 3 (June 2015) replaced the entire gears/cartridges
  architecture with Docker + Kubernetes; it was not an in-place upgrade, and the
  v2 hosted service was withdrawn (Sept 30 / Dec 31, 2017). Red Hat published
  formal "Comparing with OpenShift Enterprise 2" migration documentation.
  [Red Hat v2-vs-v3 docs](https://docs.redhat.com/en/documentation/openshift_container_platform/3.11/html/release_notes/release-notes-v2-vs-v3) ·
  [Wikipedia (withdrawal dates)](https://en.wikipedia.org/wiki/OpenShift)
- **Reported characterization:** Industry histories frame the v3 move as a bold,
  risky bet on a then-young Kubernetes ("From Gears to Docker"). The "bold bet"
  framing is the press's.
  [The New Stack](https://thenewstack.io/red-hat-openshift-part-1-from-gears-to-docker/)

### 2. "First external contributor to Kubernetes" (Clayton Coleman)

- **Reported claim:** Red Hat and Red Hat-adjacent sources describe Clayton
  Coleman as the **first external (non-Google) contributor** to Kubernetes. This
  is widely repeated but sourced to Red Hat-adjacent material.
  [The Register](https://www.theregister.com/2020/06/17/kubernetes_clayton_coleman_interview/)
- **Could not verify** the "first external contributor" claim against a neutral
  primary source.

### 3. IBM's $34B price and the OpenShift thesis

- **Fact:** IBM paid ~$34B ($190/share), its largest acquisition, closing July 9,
  2019, explicitly framing OpenShift/Kubernetes as the hybrid-cloud foundation.
  [Red Hat closing release](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future)
- **Reported characterization:** Whether the price was justified — and whether
  IBM preserved Red Hat's promised independence — is a matter of ongoing industry
  debate, not addressed here.

---

## Items marked "Could not verify"

- **The exact "developer preview" wording** for the May 4, 2011 OpenShift launch
  (date is sourced; the "developer preview" label is from secondary retellings).
- **A dated primary Red Hat announcement for the May 2012 open-sourcing** of
  OpenShift Origin (the "May 2012" month is from Wikipedia).
- **A precise GA date for OpenShift Online 1.0** (the hosted service); only the
  ~November 2012 OpenShift Enterprise 1.0 timing is sourced.
- **An exact day-level GA date for OpenShift 4.1** (the May 8, 2019 launch blog
  says "available in the next month").
- **"First external contributor to Kubernetes" (Clayton Coleman)** — widely
  repeated but only sourced to Red Hat-adjacent material.
- **Makara's precise underlying technology** ("based on Linux containers" is
  Wikipedia's characterization; Red Hat's own release describes deploy/manage/
  scale capabilities without that exact phrasing).
