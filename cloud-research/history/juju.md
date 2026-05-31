# Juju (Canonical): A Sourced History

Juju is Canonical's open-source application/service modeling and orchestration
tool. It deploys, integrates, and operates applications across clouds, bare
metal (via MAAS), and Kubernetes using reusable operators called **charms**.
This document is a chronological, fully-sourced history. Every claim links to a
working source URL. Items that could not be confirmed are explicitly flagged.

---

## Timeline

### 2009 — Conception (as "Ensemble")

- Juju was **initially conceived in 2009 by Mark Shuttleworth, Gustavo
  Niemeyer, and Simon Wardley** as a way to simplify the deployment and
  operation of services on Ubuntu. The project's original codename was
  **"Ensemble."**
  Source: Juju official documentation, "About charming history" —
  https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/

### May 2011 — Public debut of Ensemble at UDS and the 11.10 cycle

- Following the Ubuntu Developer Summit in Budapest (May 2011), Canonical
  identified Ensemble as one of the focus areas for the Ubuntu 11.10 "Oneiric
  Ocelot" cycle. Wikipedia records Juju's **initial release as 5 May 2011**.
  Source: https://en.wikipedia.org/wiki/Juju_(software)
- Background context on the 11.10 server focus areas (OpenStack, Eucalyptus,
  Ensemble, Orchestra):
  https://www.phoronix.com/news/OTUwMA

### August 2011 — Ensemble explained: "service orchestration" / "APT for the cloud"

- Canonical's Dustin Kirkland published a detailed introduction (dated
  **19 August 2011**) framing Ensemble as a **service orchestration**
  framework — an "APT for the cloud." He compared Ensemble's maturity to
  "bzr or git circa 2004/2005, or apt circa 1998/1999." Crucially, at this
  stage the reusable service-definition packages were called **"Formulas"**
  (not yet "charms"): the workflow was `ensemble bootstrap` then
  `ensemble deploy your-web-app`.
  Source: https://blog.dustinkirkland.com/2011/08/ensemble-service-orchestration.html
- Independent contemporaneous explainer ("So what is Ensemble anyway?"),
  June 2011: https://fewbar.com/2011/06/so-what-is-ensemble-anyway/

### September 2011 — Rename: Ensemble → Juju

- The project was renamed from **Ensemble to Juju**. Gustavo Niemeyer
  announced the rename publicly ("The #ensemble project has been renamed to
  #juju!"). Secondary coverage placed the rename in mid-September 2011.
  - Niemeyer's announcement (Google+ archive link surfaced in search):
    https://plus.google.com/+GustavoNiemeyer/posts/iGXA1QK8aNY
    *(Could not verify: Google+ was shut down in 2019, so this URL is no
    longer live; it is preserved here only as the originally-cited source.)*
  - Secondary coverage of the rename ("Ubuntu Ensemble Is Now Juju"):
    https://www.cloudave.com/14950/ubuntu-ensemble-is-now-juju/
    *(Could not verify the precise rename date from this page directly — the
    fetch returned HTTP 500 on retry. Search summaries reported "September 14,
    2011," but this exact day is **Could not verify** from a primary source.)*

### November 2011 — The Juju name and logo rationale

- Canonical designer Marcus Haslam published the story of the Juju logo
  (dated **3 November 2011**). He explained the name: "Juju is a west-African
  system of beliefs, and has the 'u' sound much more akin to the other
  'Ubuntu' and 'Unity' words." The name is widely described as an
  (West-)African word for "magic." The logo design request went to the Design
  Team in July 2011, with community input in September 2011.
  Source: https://ubuntu.com/blog/2011/11/03/juju-logo

### April 2012 — Charm Store launch

- Wikipedia records the **Charm Store launching on 3 April 2012**, providing a
  central repository for charms.
  Source: https://en.wikipedia.org/wiki/Juju_(software)

### 2012–February 2013 — Rewrite from Python to Go (an early large Go codebase)

- Juju was originally written in Python; Canonical's team spent roughly a year
  porting it to **Go**, an early and unusually large adoption of the language
  (Go 1.0 had only shipped in March 2012). On **11 February 2013**, Dave Cheney
  announced on the golang-nuts mailing list (on behalf of the Juju team):
  *"Last week marked the first non experimental release of our rewrite of Juju
  in Go."* The Go codebase was **~109,000 lines (including tests)** at that
  point.
  Source: https://groups.google.com/g/golang-nuts/c/jLnMsUbYwrQ/m/isfMUvBOkEIJ
- The rewrite spun out several foundational Go libraries that became broadly
  used in the Go ecosystem, including the **mgo** MongoDB driver, **goamz**
  (AWS), and **goose** (OpenStack), plus utilities like tomb, goyaml,
  gnuflag, and gocheck (gustavo Niemeyer authored much of this).
  Same source as above (golang-nuts post); Niemeyer's library home (mgo):
  https://web.archive.org/web/2id_/http://niemeyer.net/mgo
- Industry context: by late 2013 Juju was cited as part of the wave that made
  Go "the emerging language of cloud infrastructure" (alongside Docker, etcd,
  fleet, Cloud Foundry components).
  Source: https://redmonk.com/dberkholz/2014/03/18/go-the-emerging-language-of-cloud-infrastructure/
- Scale milestone: by 2017 the Juju Go codebase had grown to roughly
  540,000 lines of Go across ~3,500 files — one of the larger open-source Go
  projects of its era.
  Source: https://npf.io/2017/03/3.5yrs-500k-lines-of-go/

### 2014 — Services Framework for charm authoring

- The **Services Framework** emerged from the `charmhelpers` library,
  standardizing event handling and giving charms a more declarative structure.
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/

### 2015 — The reactive framework (`charms.reactive`)

- The **`charms.reactive`** library was announced, introducing event-driven
  charm development and reusable composable "layers."
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/

### October 2016 — Juju 2.0

- **Juju 2.0** was released. Secondary/community sources place this on
  **14 October 2016** (Ubuntu Fridge / Ubuntu Weekly News). The 2.0 line
  introduced the modern model/controller architecture and multi-cloud
  modeling.
  - Community announcement (URL now redirects to the UWN landing page):
    https://ubuntu-news.org/2016/10/14/juju-2-0-is-here/
    *(Could not verify the full announcement body — the page now redirects to
    https://ubuntu.com/community/uwn — but the 2.0 series exists on Launchpad.)*
  - Launchpad 2.0 series: https://launchpad.net/juju/2.0

### 2019–2020 — The Operator Framework (`ops`) and the operator pattern

- Canonical introduced the **Operator Framework (`ops`)**, a pure-Python
  framework for writing Juju charms, initially focused on Kubernetes and then
  extended to "machine" (traditional Linux/Windows) workloads. The official
  history dates the Ops framework's emergence to the **2019–present** period.
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/
- The `ops` library's first stable line landed in late 2020: **ops 1.0.1 was
  announced on 5 November 2020** by John Lenton ("chipaca"), fixing a
  regression in 1.0.
  Source: https://discourse.charmhub.io/t/version-1-0-1-of-ops-released/3797
  *(Could not verify the exact ops 1.0.0 date from a primary page — PyPI fetch
  failed; the 1.0.1 announcement confirms 1.0 shipped shortly before
  5 Nov 2020.)*
- GitHub repo for the framework (pure-Python framework for Juju charms):
  https://github.com/canonical/operator/

### November 2020 — Open Operator Collection and Charmhub

- On **13 November 2020**, Canonical announced its **Open Operator Collection**
  — described as the largest collection of application operators — hosted at
  **Charmhub.io**, extending the Kubernetes operator pattern to traditional
  Linux and Windows applications.
  Source: https://ubuntu.com/blog/canonicals-open-operator-collection-extends-kubernetes-operators-to-traditional-linux-and-windows-applications
- Charmcraft was introduced alongside Ops as the charm-packaging tool, with
  Charmhub serving as the operator/charm repository.
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/

### October 2022 — Juju 3.0

- **Juju 3.0.0** was released. Launchpad records the 3.0.0 milestone; secondary
  search summaries report **22 October 2022**.
  - Launchpad milestone: https://launchpad.net/juju/+milestone/3.0.0
    *(Could not verify the exact 22 Oct 2022 date from a primary page body;
    the milestone exists on Launchpad.)*

### 2024–2025 — Juju 3.6 LTS (current line)

- **Juju 3.6** is the current **Long-Term Support (LTS)** release line. Per
  Canonical's roadmap, 3.6 LTS carries long-term support (security fixes over a
  multi-year window; Canonical documents an extended support horizon for the
  LTS).
  Source: https://documentation.ubuntu.com/juju/latest/releasenotes/juju_3.6.x/
  and roadmap: https://documentation.ubuntu.com/juju/3.6/reference/juju/juju-roadmap-and-releases/
  *(Could not verify the precise "support through April 2039 / 12 years"
  figure from a fetched primary page — this came from a search summary and
  should be confirmed against the roadmap page before being relied upon.)*
- Wikipedia lists a recent point release as **3.6.3 (27 February 2025)**.
  Source: https://en.wikipedia.org/wiki/Juju_(software)
- Launchpad 3.6 series: https://launchpad.net/juju/3.6

---

## How Juju differs from other tools

### vs. Puppet / Chef (and Ansible/SaltStack)

- Puppet, Chef, Ansible, and SaltStack are primarily **configuration
  management** tools: they install and configure software *within* a single
  (already-existing) machine and their responsibility traditionally stops at
  the machine boundary. Juju instead does **application modeling**: it models
  whole applications, their **relations/integrations**, scaling, and lifecycle
  *across* machines and clouds — a higher level of abstraction than per-host
  config files.
  Source: https://canonical.com/blog/ansible-vs-terraform-vs-juju-fight-or-cooperation
  Supplementary comparison:
  https://rhonabwy.com/2016/06/19/marathon-kubernetes-docker-compose-terraform-puppet-chef-ansible-saltstack-and-juju/

### vs. Terraform

- Like Terraform, Juju is **declarative**, but Juju pushes declaration *beyond
  provisioning up to the application layer*: you declare not just machines/units
  but application config, **relations between applications**, and even
  **cross-model relations**. Terraform focuses on provisioning/IaC at the
  infrastructure layer; Juju also covers **day-2 operations** (ongoing
  operation, integration, scaling) via charms/operators. Canonical positions
  the two as complementary rather than strictly competing.
  Source: https://canonical.com/blog/ansible-vs-terraform-vs-juju-fight-or-cooperation

### Adoption: a niche tool next to Terraform's dominance

- Juju occupies a **niche** compared to Terraform's market dominance. Third-
  party market-share data (6sense) reports Terraform at ~16.5% of the
  "Other Infrastructure Tools" category versus Juju at ~0.05%, with Terraform
  cited at tens of thousands of customers vs. roughly a hundred for Juju.
  Source: https://6sense.com/tech/other-infrastructure-tools/juju-market-share
  *(Caveat: 6sense figures are vendor estimates of a specific tracked category,
  not an authoritative census; treat the absolute numbers as indicative.)*

---

## Current status

- Juju remains **actively maintained by Canonical**. The current line is
  **Juju 3.x**, with **3.6 as the LTS**. It is used to operate workloads on
  **MAAS (bare metal), OpenStack, public/private clouds, and Kubernetes**,
  using **charms** authored with the **Ops (operator) framework** and
  distributed via **Charmhub**.
  Sources:
  - https://canonical.com/juju
  - https://documentation.ubuntu.com/juju/latest/releasenotes/juju_3.6.x/
  - https://github.com/canonical/juju
- The core orchestrator is still written in **Go** (`github.com/juju/juju` /
  `github.com/canonical/juju`); charms/operators are written in **Python** via
  `ops`.
  Sources: https://pkg.go.dev/github.com/juju/juju and
  https://github.com/canonical/operator/

---

## Key people & teams

- **Mark Shuttleworth** — founder of Canonical; co-conceived Juju/Ensemble in
  2009 and was the original backer/sponsor of the service-orchestration vision.
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/
- **Gustavo Niemeyer** — co-conceiver (2009); central figure in the Go rewrite
  and author of foundational Go libraries (mgo, goyaml/go-yaml, goamz, gocheck).
  Later described as Canonical's CTO in third-party profiles.
  Sources: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/
  and https://web.archive.org/web/2id_/http://niemeyer.net/mgo
  *(Could not verify the "Canonical CTO" title from a primary Canonical page;
  it appears in a third-party profile: https://www.getprog.ai/profile/378683)*
- **Simon Wardley** — co-conceiver (2009).
  Source: https://documentation.ubuntu.com/juju/3.6/explanation/charming-history/
- **Dustin Kirkland** — Canonical Systems Integration Team lead who publicly
  introduced/evangelized Ensemble in 2011.
  Source: https://blog.dustinkirkland.com/2011/08/ensemble-service-orchestration.html
- **Dave Cheney** — announced the first non-experimental Go rewrite release in
  February 2013 on behalf of the Juju team.
  Source: https://groups.google.com/g/golang-nuts/c/jLnMsUbYwrQ/m/isfMUvBOkEIJ
- **Marcus Haslam** — Canonical designer; authored the Juju name/logo story
  (2011).
  Source: https://ubuntu.com/blog/2011/11/03/juju-logo
- **John Lenton ("chipaca")** — announced the ops 1.0.x operator framework
  releases (2020).
  Source: https://discourse.charmhub.io/t/version-1-0-1-of-ops-released/3797
- **Canonical Ltd.** — the company that builds, backs, and maintains Juju,
  Charmhub, and the Ops framework throughout.
  Source: https://en.wikipedia.org/wiki/Juju_(software)

---

## Could not verify (open items)

- **Exact Ensemble→Juju rename date** (search said "14 September 2011"); the
  primary announcement was on Google+ (now defunct), and the secondary
  cloudave page failed to fetch (HTTP 500) on retry.
- **Juju 2.0 exact release date (14 Oct 2016)** — only confirmed via the
  Launchpad 2.0 series and a community announcement URL that now redirects;
  the announcement body itself was not fetched.
- **Juju 3.0.0 exact release date (22 Oct 2022)** — Launchpad milestone exists,
  but the exact day came from a search summary, not a fetched primary page.
- **ops 1.0.0 exact date** — only 1.0.1 (5 Nov 2020) confirmed from a primary
  page; PyPI fetch for 1.0.0 failed.
- **Juju 3.6 LTS support duration ("through April 2039" / "12 years")** — from
  a search summary; not confirmed against the roadmap page body.
- **Gustavo Niemeyer's "Canonical CTO" title** — third-party profile only.
