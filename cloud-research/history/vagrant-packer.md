# HashiCorp Vagrant & Packer: A Chronological History

A dated, fully-sourced history of HashiCorp's two oldest tools — **Vagrant**
(reproducible development environments) and **Packer** (machine-image builder).
The two tools bracket the founding of HashiCorp itself: Vagrant *predates* the
company and effectively seeded it, while Packer was the first product *started
at* the company.

**Conventions used in this document:**
- Every factual claim carries an inline source URL.
- Established facts are stated plainly; reported claims are attributed to their
  source.
- Claims that could not be confirmed against a primary or reputable source are
  flagged explicitly as **"Could not verify."**
- The full HashiCorp corporate history (founding, IPO, the 2023 BSL relicense
  fallout, the OpenTofu fork, the IBM acquisition) lives in
  [`terraform.md`](./terraform.md). This document cross-references it rather
  than duplicating it.

---

## 2010 — Vagrant is born (before HashiCorp existed)

- **January 2010:** Vagrant began as a personal side-project by **Mitchell
  Hashimoto** (with early collaborator **John Bender**). At the time Hashimoto
  was a student/early-career engineer; this predates HashiCorp by roughly two
  and a half years.
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software));
  [LWN: Vagrant 1.0](https://lwn.net/Articles/486319/))
- **March 7, 2010:** The first public release, **Vagrant 0.1.0**, shipped.
  ([LWN: Vagrant 1.0](https://lwn.net/Articles/486319/))
  - **Date note:** LWN and multiple secondary sources give **March 7, 2010**;
    the Wikipedia infobox lists **March 8, 2010**. This document uses the LWN
    date (a reputable primary-era technical source) and flags the one-day
    discrepancy.
    ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- **Purpose:** Vagrant gave developers a single command (`vagrant up`) to spin
  up a reproducible virtual-machine development environment from a declarative
  `Vagrantfile` and a shareable "base box." The initial release was built
  around **Oracle VirtualBox** as the sole virtualization provider.
  ([LWN: Vagrant 1.0](https://lwn.net/Articles/486319/);
  [Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- It was originally written in **Ruby** and released as permissive open-source
  software (MIT).
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- **October 2010:** **Engine Yard** announced it would sponsor the Vagrant
  project, an early signal of commercial interest in the tool.
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- Per a retrospective account, for roughly six months after the first release
  no version got more than 100 downloads; momentum built over the following
  summer until Vagrant became Hashimoto's main focus.
  ([SD Times: Mitchell Hashimoto is automating the world](https://sdtimes.com/atlas/mitchell-hashimoto-hashicorp-vagrant-atlas-automate-world/))

---

## 2012 — Vagrant 1.0, then HashiCorp is founded around it

- **March 2012:** **Vagrant 1.0** was released — "exactly two years" after the
  original. It remained focused on **VirtualBox** (4.0+) and was the first
  release to promise long-term backwards compatibility for the `Vagrantfile`,
  ending an earlier period of frequent syntax churn.
  ([LWN: Vagrant 1.0](https://lwn.net/Articles/486319/))
- **2012:** **HashiCorp** was founded by **Mitchell Hashimoto** and **Armon
  Dadgar**. Vagrant — Hashimoto's existing open-source project — was the
  catalyst: the company was created to support it full-time, and Vagrant became
  part of the new company's portfolio. (See [`terraform.md`](./terraform.md)
  for the corporate-founding detail.)
  ([HashiCorp — Wikipedia](https://en.wikipedia.org/wiki/HashiCorp);
  [Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- **November 28, 2012:** The company's launch was covered publicly under the
  framing "Vagrant founder launches HashiCorp." Vagrant stayed permissively
  licensed at this point.
  ([TechCrunch: Vagrant Founder Launches HashiCorp](https://techcrunch.com/2012/11/28/vagrant-founder-launches-hashicorp-to-support-his-open-source-developer-management-tool/);
  [Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))

> **How Vagrant seeded HashiCorp:** Vagrant was the proof-of-concept that an
> independent developer-tooling project could attract a large community and
> commercial sponsorship. It directly motivated the formation of HashiCorp,
> which then became the home for a whole family of infrastructure tools
> (Packer, Consul, Terraform, Vault, Nomad, and others). See
> [`terraform.md`](./terraform.md).

---

## 2013 — Provider plugins; Packer launches as HashiCorp's first new product

- **March 14, 2013:** **Vagrant 1.1** introduced the **provider plugin
  system**, decoupling Vagrant from VirtualBox so it could control machines on
  other backends. It shipped the **VMware Fusion** provider as "the first paid
  add-on for Vagrant from HashiCorp" ($79/seat), and open-source community
  providers for **AWS** and **Rackspace** were available the same day. This
  marked Vagrant's transition from a single-provider tool to a pluggable,
  multi-provider platform.
  ([HashiCorp blog: Vagrant 1.1, VMware Fusion](https://www.hashicorp.com/en/blog/vagrant-1-1-vmware-fusion))
- **June 28, 2013:** **Mitchell Hashimoto announced Packer 0.1** — an
  open-source tool for **creating machine images** such as **AMIs, VirtualBox
  images, and Vagrant boxes**, able to generate images for multiple platforms
  **in parallel** so identical AMIs, VMware machines, etc. could be produced
  at once.
  ([Mitchell Hashimoto: Packer announcement](http://mitchellh.com/packer))
- Per HashiCorp's own later retrospective, **"Packer was started in 2013 and
  was the first project started at HashiCorp."** (Note the careful wording:
  Vagrant predates the *company*; Packer was the first product *begun inside*
  it.)
  ([HashiCorp blog: Packer 1.0](https://www.hashicorp.com/en/blog/packer-1-0))

> **Packer's role in the IaC / immutable-infrastructure workflow:** Packer
> sits at the *build* stage of the infrastructure lifecycle. Rather than
> configuring servers after they boot, teams use Packer to bake a fully
> configured, versioned machine image once, then deploy that identical image
> repeatedly — the core of the **immutable infrastructure** pattern. In the
> HashiCorp toolchain this pairs naturally with Terraform (which provisions
> infrastructure from those images) and with Vagrant (Packer can output
> Vagrant boxes for local dev). ([Mitchell Hashimoto: Packer
> announcement](http://mitchellh.com/packer))

---

## 2017 — Packer 1.0

- **April 4, 2017:** **Packer 1.0** was released, marking the tool's stability
  milestone roughly four years after its first release. HashiCorp noted Packer
  had **over 500 contributors** by that point and recapped that, prior to
  Packer, image creation had been "a highly platform-specific problem."
  ([HashiCorp blog: Packer 1.0](https://www.hashicorp.com/en/blog/packer-1-0))

---

## 2021–2022 — The attempted Go rewrite of Vagrant ("Vagrant 3.0")

- **June 2021:** HashiCorp announced an effort to **port Vagrant from Ruby to
  Go** ("Toward Vagrant 3.0"). The plan was to port Vagrant's core to Go first,
  then its built-in plugins, while keeping existing Ruby `Vagrantfile`s working
  and adding a new plugin API based on HashiCorp's `go-plugin`/gRPC library.
  ([HashiCorp blog: Toward Vagrant 3.0](https://www.hashicorp.com/en/blog/toward-vagrant-3-0);
  [Mitchell Hashimoto on X (announcement)](https://x.com/mitchellh/status/1403400750311505924?lang=en))
- **September 2022:** **Vagrant 2.3** shipped the first alpha of the Go runtime,
  bundling a `vagrant-go` executable alongside the Ruby implementation.
  ([HashiCorp blog: Vagrant 2.3 Introduces Go Runtime](https://www.hashicorp.com/en/blog/vagrant-2-3-introduces-go-runtime))
- **Outcome:** The Go rewrite stalled and was effectively **abandoned**. A
  community thread (citing the tracking GitHub issue) reported as of **March 20,
  2025** that "Vagrant in Go is officially dead."
  ([HashiCorp Discuss: Is Vagrant 3.0 still happening?](https://discuss.hashicorp.com/t/is-vagrant-3-0-still-happening/40786);
  [hashicorp/vagrant issue #12819: Status of vagrant-go](https://github.com/hashicorp/vagrant/issues/12819))

---

## 2023 — The BSL relicense and Mitchell Hashimoto's departure

- **August 10, 2023:** HashiCorp **adopted the Business Source License (BSL /
  BUSL) v1.1** for future releases of essentially all of its products. The
  press release and FAQ explicitly name **Vagrant and Packer** alongside
  Terraform, Vault, Consul, Boundary, Nomad, and Waypoint — so both tools were
  relicensed from MPL-2.0 to the source-available BSL. (Full context, including
  the OpenTofu fork that followed, is in [`terraform.md`](./terraform.md).)
  ([HashiCorp blog: HashiCorp adopts the Business Source License](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license);
  [GlobeNewswire: HashiCorp adopts the Business Source License](https://www.globenewswire.com/news-release/2023/08/10/2723189/0/en/HashiCorp-adopts-the-Business-Source-License-for-future-releases-of-its-products.html);
  [HashiCorp Licensing FAQ](https://www.hashicorp.com/en/license-faq))
- **December 14, 2023:** **Mitchell Hashimoto announced his departure from
  HashiCorp**, after more than 11 years. In his farewell he noted he had
  stepped down as CEO in **2016** and left the leadership team and board in
  **2021**, working as a hands-on engineer thereafter; he cited a desire to
  explore engineering beyond infrastructure (and having recently become a
  father). As the original author of both Vagrant and Packer, his exit closed
  the era in which the tools' creator was inside the company.
  ([HashiCorp blog: Mitchell reflects as he departs HashiCorp](https://www.hashicorp.com/en/blog/mitchell-reflects-as-he-departs-hashicorp);
  [The Register: HashiCorp co-founder Mitchell Hashimoto leaves company](https://www.theregister.com/2023/12/15/hashimoto_departs_hashicorp/);
  [Mitchell Hashimoto on X (departure letter)](https://x.com/mitchellh/status/1735410621859221931))

---

## 2025 — Under IBM; current status

- **February 27, 2025:** **IBM completed its acquisition of HashiCorp** (a
  ~$6.4B deal announced April 24, 2024; stockholders approved July 15, 2024).
  Vagrant and Packer thus passed to IBM along with the rest of the portfolio.
  (Corporate-deal detail and timeline in [`terraform.md`](./terraform.md).)
  ([IBM Newsroom: IBM Completes Acquisition of HashiCorp](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform);
  [GovConWire: IBM Closes HashiCorp Acquisition](https://www.govconwire.com/articles/ibm-closes-hashicorp-acquisition))
- **Packer — actively maintained.** Packer continues regular releases; for
  example **Packer 1.14.3** was released **November 18, 2025** (per the project
  changelog), and remains under the BSL.
  ([hashicorp/packer CHANGELOG](https://github.com/hashicorp/packer/blob/main/CHANGELOG.md))
- **Vagrant — maintained but in a quieter, "legacy" posture.** The Ruby
  codebase still receives releases (current stable **2.4.x**; Wikipedia lists
  2.4.9 dated **August 21, 2025**), but the ambitious Go/3.0 rewrite is dead and
  the tool is no longer the strategic centerpiece it once was. HashiCorp has
  also flagged **Vagrant Cloud** (box hosting/registry) as periodically in
  maintenance mode.
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software));
  [hashicorp/vagrant issue #12819](https://github.com/hashicorp/vagrant/issues/12819))
  - **Could not verify:** A precise, officially-stated "maintenance mode" /
    deprecation declaration for the Vagrant *tool itself* (as opposed to
    Vagrant Cloud). Treat the "legacy posture" characterization as inference
    from the abandoned Go rewrite and reduced release cadence, not an official
    HashiCorp/IBM statement.

---

## Key people & teams

- **Mitchell Hashimoto** — Creator/original author of **both Vagrant (2010)**
  and **Packer (2013)**. Co-founded HashiCorp in 2012 (with Armon Dadgar);
  stepped down as CEO in 2016, left the board in 2021, and departed the company
  entirely in December 2023.
  ([HashiCorp blog: Mitchell reflects as he departs HashiCorp](https://www.hashicorp.com/en/blog/mitchell-reflects-as-he-departs-hashicorp);
  [TechCrunch: Vagrant Founder Launches HashiCorp](https://techcrunch.com/2012/11/28/vagrant-founder-launches-hashicorp-to-support-his-open-source-developer-management-tool/))
- **John Bender** — Early collaborator credited alongside Hashimoto on Vagrant's
  initial development in 2010.
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- **Armon Dadgar** — Co-founder of HashiCorp (2012) with Hashimoto; not a
  Vagrant/Packer originator but co-led the company that became the tools' home.
  See [`terraform.md`](./terraform.md).
  ([HashiCorp — Wikipedia](https://en.wikipedia.org/wiki/HashiCorp))
- **Engine Yard** — Early external sponsor of the Vagrant open-source project
  (October 2010), before HashiCorp existed.
  ([Vagrant (software) — Wikipedia](https://en.wikipedia.org/wiki/Vagrant_(software)))
- **HashiCorp (the company / its maintainer teams)** — Steward of both tools
  from 2012 onward; relicensed them to BSL in 2023.
  - **Could not verify:** The specific named individual maintainers or team
    leads currently responsible for Vagrant and Packer day-to-day. Not
    established from a primary source during this research.
- **IBM** — Owner of HashiCorp (and therefore Vagrant and Packer) since
  February 27, 2025.
  ([IBM Newsroom: IBM Completes Acquisition of HashiCorp](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform))

---

## Summary of "Could not verify" items

1. **Exact Vagrant 0.1.0 date:** LWN gives **March 7, 2010**; Wikipedia's
   infobox says **March 8, 2010**. One-day discrepancy; March 7 used here.
2. **Official "maintenance/legacy" status of the Vagrant tool itself** (distinct
   from Vagrant Cloud) — not found as an explicit HashiCorp/IBM declaration.
3. **Current named maintainers/team leads** for Vagrant and Packer — not
   established from a primary source.
