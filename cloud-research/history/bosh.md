# BOSH: A Sourced History

BOSH is an open-source tool chain for **release engineering, deployment, and
lifecycle management** of large-scale distributed systems. It was created at
VMware to deploy and operate **Cloud Foundry**, and it predates / parallels
modern Infrastructure-as-Code with its own VM- and release-centric model
("releases", "stemcells", "deployment manifests", and per-IaaS "Cloud Provider
Interfaces").

> Scope note: This doc traces BOSH's origin and evolution, tightly coupled to
> the history of Cloud Foundry (VMware → Pivotal → Cloud Foundry Foundation →
> VMware/Broadcom). Every dated claim below links to a working source. Items
> that could not be pinned down precisely are flagged **"Could not verify."**

---

## What the name means

BOSH is a **recursive acronym** for **"BOSH Outer Shell."** This is confirmed by
the official Cloud Foundry OSS documentation FAQ:

> "BOSH is a recursive acronym for 'BOSH Outer Shell'."
> — [cloudfoundry-attic/oss-docs, bosh/documentation/faq.md](https://github.com/cloudfoundry-attic/oss-docs/blob/master/bosh/documentation/faq.md)

The metaphor: BOSH is the **outer shell** that deploys and manages an inner
system (such as Cloud Foundry itself). It "unifies release engineering,
deployment, and lifecycle management of small and large-scale cloud software."
— [bosh.io/docs](https://bosh.io/docs/)

---

## Dated timeline

### 2009 — Cloud Foundry conceived at VMware (BOSH's parent project)
Cloud Foundry was originally conceived in 2009 and "designed and developed by a
small team at VMware led by **Derek Collison**." (The VMware open-source blog
notes it was initially called **"Project B29"** before being renamed the same
year.)
- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- [The Past, Present and Future of Cloud Foundry – Part 1 (VMware Open Source blog, 2020-06-25)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)

### 2010 — BOSH initially developed at VMware
> "While BOSH was initially developed by VMware in 2010 to deploy Cloud Foundry
> PaaS, it can be used to deploy other software."
> — [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

BOSH was conceived and built by a group of engineers from the Cloud Foundry
project at VMware, to replace earlier tooling (Chef was used originally) that
was limited for packaging, spinning servers up/down, monitoring, and
self-management at Cloud Foundry's scale.
- [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

> Note: Wikipedia dates initial BOSH development to **2010**; the Cloud Foundry
> Foundation's "BOSH Turns Five" retrospective is written from the perspective
> of its **2012 open-sourcing** (below). These are consistent — internal
> development at VMware (2010) preceded the public open-source release (2012).

### April 2011 — Cloud Foundry publicly announced
> "The announcement of Cloud Foundry took place in April 2011."
> — [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

BOSH was already in internal use by this point: the OSS-docs FAQ states BOSH
"has been used since the launch of CloudFoundry.com to create and update the
production service."
- [oss-docs FAQ](https://github.com/cloudfoundry-attic/oss-docs/blob/master/bosh/documentation/faq.md)

> **Could not verify:** an exact day-level date in April 2011 for the Cloud
> Foundry announcement (sources give "April 2011").

### April 11, 2012 — BOSH open-sourced by VMware
This is the most precisely sourced milestone. The Cloud Foundry Foundation's
five-year retrospective states:

> "I was at VMWare on April 11, 2012, when BOSH was first open sourced."
> — [BOSH Turns Five! (cloudfoundry.org blog, published 2017-04-11)](https://www.cloudfoundry.org/blog/bosh-turns-five/)

Wikipedia's Cloud Foundry article corroborates the month/year:
> "In April 2012, BOSH, an open source tool chain for release engineering,
> deployment, and life-cycle management of large scale distributed services, was
> publicly launched."
> — [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

### April 2013 — Pivotal spun out; BOSH stewardship moves to Pivotal
> "In April 2013, Pivotal was created from EMC and VMware, to market assets
> including Cloud Foundry, RabbitMQ and Spring."
> — [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

Per the Wikipedia BOSH article, engineering of BOSH transitioned to Pivotal,
and "Nearly all contributions to BOSH are made by Pivotal" (as of that article's
state).
- [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

> **Could not verify:** an exact day-level date for the Pivotal spinout
> (sources give "April 2013").

### February 2014 — Pivotal announces intent to create an open governance foundation
> "In February 2014, Pivotal announced its intention to establish an open
> governance model for the Cloud Foundry platform, as well as create a nonprofit
> foundation..."
> — [What is Cloud Foundry? (TechTarget)](https://www.techtarget.com/searchcloudcomputing/definition/Cloud-Foundry)

A launch announcement was made on **December 9, 2014** describing the Foundation
as a Linux Foundation Collaborative Project (per WebSearch summary of
Wikipedia / Linux Foundation press materials).
> **Could not verify (partial):** the December 9, 2014 day-level date could not
> be confirmed via direct WebFetch of a primary source in this session; the
> January 2015 formal-creation date below is firmly sourced.

### January 2015 — Cloud Foundry Foundation created; BOSH placed under it
> "In January 2015, the Cloud Foundry Foundation was created as an independent
> not-for-profit 501(c)(6) Linux Foundation Collaborative Project."
> — [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

The Foundation's portfolio "initially oversaw both Cloud Foundry Elastic Runtime
(later renamed Cloud Foundry Application Runtime) and BOSH." BOSH was thus
"gifted to the Cloud Foundry Foundation to secure its long-term success as an
open source, open community project."
- [The Past, Present and Future of Cloud Foundry – Part 1 (VMware Open Source blog)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
- [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

### April 11, 2017 — "BOSH Turns Five" retrospective published
The Cloud Foundry Foundation publishes a five-year retrospective, naming
long-time community figures (see Key People below).
- [BOSH Turns Five! (cloudfoundry.org blog)](https://www.cloudfoundry.org/blog/bosh-turns-five/)

### 2022 — Cloud Foundry Foundation operating as a "directed fund" of the Linux Foundation
By 2022, the Cloud Foundry Foundation is described as "an open source directed
fund of the Linux Foundation." On **October 18, 2022**, it announced Catherine
McGarvey (VP of software engineering, VMware) as the new chair of its Governing
Board.
- [Cloud Foundry Foundation – Who We Are](https://www.cloudfoundry.org/foundation/)
- [Cloud Foundry Foundation Announces New Chair of Governing Board (cloudfoundry.org blog)](https://web.archive.org/web/2id_/https://www.cloudfoundry.org/blog/cloud-foundry-foundation-announces-new-chair-of-governing-board-opens-project-roadmaps/)

> **Could not verify:** a precise date on which the Foundation formally
> transitioned from "Linux Foundation Collaborative Project" (2015 framing) to
> "directed fund of the Linux Foundation" (2022 framing). The "directed fund"
> terminology is in use by 2022, but the exact transition event/date was not
> confirmed in this session.

### November 22, 2023 — Broadcom completes acquisition of VMware
Broadcom and VMware announced their agreement on **May 26, 2022** (~$61B
cash-and-stock); the transaction **closed November 22, 2023**, after a delay
awaiting Chinese regulatory approval.
- [Broadcom Completes Acquisition of VMware (Broadcom investor relations)](https://investors.broadcom.com/news-releases/news-release-details/broadcom-completes-acquisition-vmware)
- [What is Cloud Foundry? (TechTarget)](https://www.techtarget.com/searchcloudcomputing/definition/Cloud-Foundry) (notes the Broadcom/VMware deal)

> **Could not verify:** a primary-source statement detailing exactly how the
> Broadcom acquisition changed Cloud Foundry / BOSH governance. The Cloud
> Foundry Foundation continued to operate as a directed fund of the Linux
> Foundation; the corporate ownership chain (VMware → Broadcom) is one of
> several stakeholders, not the governing body of the open-source project.

### Current status (as of 2026)
BOSH remains **actively maintained** under the `cloudfoundry/bosh` GitHub
organization, governed by the Cloud Foundry Foundation (a directed fund of the
Linux Foundation). The `cloudfoundry/bosh` repository shows ongoing releases —
e.g., **v282.1.13 dated May 26, 2026** at time of research, with 242 releases.
- [github.com/cloudfoundry/bosh](https://github.com/cloudfoundry/bosh)
- [Cloud Foundry Foundation – Who We Are](https://www.cloudfoundry.org/foundation/)

---

## Key people & teams / origin

- **Cloud Foundry founding team — VMware (led by Derek Collison).** Cloud
  Foundry (BOSH's parent project, originally "Project B29") was designed and
  developed by a small VMware team led by Derek Collison, conceived in 2009.
  BOSH grew out of this same Cloud Foundry team's need for a better
  release/deployment/lifecycle tool.
  - [The Past, Present and Future of Cloud Foundry – Part 1 (VMware Open Source blog)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
  - [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)

- **VMware Cloud Foundry engineering team (~2010).** A group of engineers from
  the Cloud Foundry project at VMware conceived and built the first iteration of
  BOSH. (Sources describe the team but do not enumerate individual BOSH
  authors.)
  - [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

- **Dmitriy Kalinin** — described in the Foundation's five-year retrospective as
  BOSH's "long-time leader" / "our stoic leader," credited with guiding BOSH
  into its current shape.
  - [BOSH Turns Five! (cloudfoundry.org blog)](https://www.cloudfoundry.org/blog/bosh-turns-five/)

- **Dr Nic Williams** — early and long-time BOSH community contributor (founder
  and CEO of the Stark & Wayne consultancy), who began working with BOSH around
  April 2011 and authored the "BOSH Turns Five" retrospective.
  - [BOSH Turns Five! (cloudfoundry.org blog)](https://www.cloudfoundry.org/blog/bosh-turns-five/)

- **Pivotal (2013–).** After the April 2013 spinout from EMC/VMware, Pivotal
  took over BOSH engineering; "nearly all contributions to BOSH" came from
  Pivotal during that era.
  - [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

> **Could not verify:** the specific named individual(s) who wrote the very
> first BOSH code, or who coined the "BOSH Outer Shell" name. Sources attribute
> creation to the VMware Cloud Foundry team collectively.

---

## BOSH's model (how it works) and comparison to Terraform

BOSH's core abstractions — all from official BOSH docs:

- **Stemcell** — a versioned, IaaS-specific OS image (a generic VM template).
  The name derives from biological "stem cells" (undifferentiated cells that can
  become many cell types): BOSH clones and specializes a stemcell into whatever
  VMs a deployment needs.
  - [What is a Stemcell? (bosh.io)](https://bosh.io/docs/stemcell/)

- **Release** — a versioned bundle of all related source code, binaries,
  configurable properties, compilation scripts, and startup scripts for a piece
  of software.
  - [bosh.io/docs](https://bosh.io/docs/)

- **Deployment manifest** — a YAML file defining the components and properties
  of a deployment; it is **IaaS-agnostic**. A separate **cloud-config** maps the
  abstract manifest onto concrete cloud resources.
  - [Deployment Manifest v1 (bosh.io)](https://bosh.io/docs/deployment-manifest/)
  - [Deployment Config / manifest-v2 (bosh.io)](https://bosh.io/docs/manifest-v2/)

- **Cloud Provider Interface (CPI)** — the pluggable API the BOSH Director uses
  to talk to an IaaS to create/manage stemcells, VMs, and disks ("like a driver
  to talk to a printer"). CPIs exist for **AWS, OpenStack, vSphere, vCloud**,
  with community CPIs for **Google Compute Engine, Microsoft Azure, CloudStack**.
  - [Components of BOSH (bosh.io)](https://bosh.io/docs/bosh-components/)
  - [bosh-deployment (GitHub)](https://github.com/cloudfoundry/bosh-deployment)

**Comparison to Terraform (analytical, drawn from the above primary sources):**
Both BOSH and Terraform are **declarative** and **multi-IaaS** (BOSH via CPIs;
Terraform via providers). The key difference is **what they manage and how
deeply**:

- BOSH is **VM- and release-centric and lifecycle-aware**: beyond initial
  provisioning, the BOSH Director continuously manages the deployed system —
  monitoring processes, healing failed VMs, performing rolling updates from
  versioned releases/stemcells, and managing persistent disks. It deploys *and
  operates* software (its original job: deploy and run Cloud Foundry itself).
- Terraform is primarily an **infrastructure provisioning / desired-state**
  tool: it creates and updates cloud resources to match declared state, but does
  not itself run a monitoring/self-healing agent on the deployed VMs or package
  software as versioned "releases" with compilation and process supervision.

In short, BOSH predates and parallels modern IaC, but occupies a broader niche
than a pure provisioner: it is a **release-engineering + deployment +
lifecycle-management** tool, with provisioning being only one stage.
- [bosh.io/docs](https://bosh.io/docs/)
- [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))

> **Could not verify:** a primary, first-party head-to-head BOSH-vs-Terraform
> comparison from the Cloud Foundry Foundation. The comparison above is
> synthesized from each tool's own documented capabilities; it is analysis, not
> a single sourced claim.

---

## Sources (all verified reachable during research)

- [BOSH (software) — Wikipedia](https://en.wikipedia.org/wiki/BOSH_(software))
- [Cloud Foundry — Wikipedia](https://en.wikipedia.org/wiki/Cloud_Foundry)
- [BOSH Turns Five! — Cloud Foundry Foundation blog (2017-04-11)](https://www.cloudfoundry.org/blog/bosh-turns-five/)
- [The Past, Present and Future of Cloud Foundry – Part 1 — VMware Open Source blog (2020-06-25)](https://blogs.vmware.com/opensource/2020/06/25/the-past-present-and-future-of-cloud-foundry-part-1/)
- [oss-docs BOSH FAQ ("BOSH Outer Shell")](https://github.com/cloudfoundry-attic/oss-docs/blob/master/bosh/documentation/faq.md)
- [bosh.io/docs](https://bosh.io/docs/)
- [What is a Stemcell? (bosh.io)](https://bosh.io/docs/stemcell/)
- [Deployment Manifest v1 (bosh.io)](https://bosh.io/docs/deployment-manifest/)
- [Deployment Config / manifest-v2 (bosh.io)](https://bosh.io/docs/manifest-v2/)
- [Components of BOSH (bosh.io)](https://bosh.io/docs/bosh-components/)
- [github.com/cloudfoundry/bosh](https://github.com/cloudfoundry/bosh)
- [github.com/cloudfoundry/bosh-deployment](https://github.com/cloudfoundry/bosh-deployment)
- [Cloud Foundry Foundation – Who We Are](https://www.cloudfoundry.org/foundation/)
- [Cloud Foundry Foundation Announces New Chair of Governing Board (2022-10-18)](https://web.archive.org/web/2id_/https://www.cloudfoundry.org/blog/cloud-foundry-foundation-announces-new-chair-of-governing-board-opens-project-roadmaps/)
- [Broadcom Completes Acquisition of VMware (Broadcom IR)](https://investors.broadcom.com/news-releases/news-release-details/broadcom-completes-acquisition-vmware)
- [What is Cloud Foundry? (TechTarget)](https://www.techtarget.com/searchcloudcomputing/definition/Cloud-Foundry)
