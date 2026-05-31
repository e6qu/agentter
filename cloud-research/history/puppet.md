# Puppet: A Chronological History (Reductive Labs → Puppet Labs → Perforce)

A dated, source-cited history of Puppet, with emphasis on its cloud-API
integration story and the controversies surrounding the 2022 Perforce
acquisition and the 2024–2025 source-available / community-fork dispute.

Every factual claim below is followed by an inline source URL. Where a
specific claim could not be confirmed against a primary or reputable
secondary source, it is flagged with **"Could not verify."**

> Note on sourcing: Reported claims (community statements, quotes, opinions)
> are attributed to their speaker/outlet and kept distinct from established
> facts (dates, releases, license terms).

---

## 1. Founding and the early open-source era (2005–2010)

- **2005 — Development begins.** Luke Kanies began writing the code that
  became Puppet in 2005, as an alternative to existing configuration
  management tools (notably CFEngine and BladeLogic). Puppet uses a custom
  *declarative* domain-specific language (DSL) to describe system state, and a
  client–server ("agent/master") architecture.
  ([Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)),
  [Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies))

- The company was originally named **Reductive Labs**. Puppet is widely
  credited as one of the first "infrastructure as code" / configuration
  management tools and helped launch the IaC movement.
  ([Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies),
  [TechCrunch, 2010-07-19](https://techcrunch.com/2010/07/19/puppet-labs/))

- **2010 — Rebrand to Puppet Labs + funding.** Reductive Labs rebranded as
  **Puppet Labs** in 2010, around a **$5 million** funding round reported in
  July 2010, used to build out the engineering team.
  ([TechCrunch, 2010-07-19](https://techcrunch.com/2010/07/19/puppet-labs/))

> Founding-year note: Some sources cite **2005** as the founding date (when
> Kanies began development), while the 2022 TechCrunch acquisition piece says
> the company was "founded in 2009." The 2005 date (start of development) is
> the more commonly cited and primary-sourced figure; the 2009 figure in
> TechCrunch likely refers to incorporation/funding milestones.
> ([Wikipedia](https://en.wikipedia.org/wiki/Puppet_(software)) vs.
> [TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

---

## 2. Commercialization, funding, and the Chef rivalry (2011–2018)

- **Feb 2011 — Puppet Enterprise.** Puppet released its first commercial
  product, **Puppet Enterprise**, built on the open-source base with added
  commercial components.
  ([Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- **Nov 2011 — Series A.** Puppet Labs raised an **$8.5 million** round led by
  Cisco, Google Ventures, and VMware.
  ([Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- **Puppet vs. Chef rivalry (early 2010s).** Puppet and Chef were the two
  leading configuration-management tools of the early DevOps era, representing
  competing philosophies: Puppet's **declarative** model (define the desired
  end state) versus Chef's more **imperative/procedural** model (script the
  steps). Puppet (dev started 2005) predated Chef and had a longer commercial
  track record and larger install base.
  ([Logz.io: Chef vs. Puppet](https://logz.io/blog/chef-vs-puppet/),
  [UpGuard: Chef vs Puppet](https://www.upguard.com/blog/puppet-vs-chef-revisited))

- **Sep 2017 — Distelli acquisition.** Puppet acquired Distelli, an
  infrastructure automation firm (pipelines/CD).
  ([Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- **Jun 2018 — Later funding.** Puppet raised a further **$42 million**
  (bringing total raised to roughly **$150 million**) in a round led by Cisco,
  with Kleiner Perkins, True Ventures, EDBI, and VMware participating.
  ([Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

> Funding totals vary by source: Wikipedia cites ~$150M total; the 2022
> TechCrunch acquisition article states Puppet raised "nearly $190 million"
> overall, including a **$40 million debt round from BlackRock in 2020.** The
> discrepancy likely reflects debt vs. equity and timing.
> ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

---

## 3. Cloud-API integration: Puppet Forge and cloud provisioning modules

- **The Puppet Forge** is Puppet's public module repository; cloud integration
  modules are distributed there. Perforce/Puppet has stated the Forge "and
  module content hosted there will remain freely available" even after the
  2024 changes (see Section 5).
  ([Puppet blog, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025))

- **Legacy: `puppetlabs/cloud_provisioner`** was an early cloud-provisioning
  module; Puppet later recommended **`puppetlabs-aws`** as its replacement.
  ([Puppet Forge: puppetlabs/cloud_provisioner](https://forge.puppet.com/modules/puppetlabs/cloud_provisioner))

- **`puppetlabs-aws`** lets users "drive AWS APIs using Puppet code" — e.g.,
  create EC2 instances and model relationships between AWS components,
  describing entire AWS infrastructure declaratively.
  ([Puppet Forge: puppetlabs/aws](https://forge.puppet.com/modules/puppetlabs/aws))

- **`puppetlabs-provision`** is a multi-cloud module that provisions compute
  instances across **AWS, Azure, and GCP** using Puppet Bolt plans, leveraging
  Terraform under the hood to talk to provider APIs.
  ([GitHub: puppetlabs/puppetlabs-provision](https://github.com/puppetlabs/puppetlabs-provision))

- **Puppet Enterprise** integrates with public cloud providers including
  Microsoft Azure, VMware, Google Cloud Platform, and AWS for hybrid IT
  management.
  ([Puppet: Cloud use case](https://www.puppet.com/why-puppet/use-cases/cloud),
  [Puppet blog: Google Cloud integrations](https://www.puppet.com/blog/puppet-google-cloud-platform))

---

## 4. Perforce acquisition and the 2022 layoffs

- **Apr 11, 2022 — Acquisition announced.** Perforce Software signed a
  definitive agreement to acquire Puppet, adding infrastructure automation to
  Perforce's DevOps portfolio. Deal terms were not disclosed. Perforce is
  backed by **Clearlake Capital** (which acquired Perforce in 2018) and
  Francisco Partners.
  ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/),
  [Clearlake press release](https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/))

  - Reported quote — Tim Russell (Perforce CPO): Perforce "is an industry
    leader in DevOps, but focused more on the planning through verification
    phases."
    ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))
  - Then-Puppet CEO **Yvonne Wassenaar** was quoted on the rationale.
    ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

- **May 18, 2022 — Acquisition completed.**
  ([Perforce press release: acquisition completed](https://www.perforce.com/press-releases/perforce-completes-acquisition-puppet))

- **Aug 2022 — Layoffs.** Less than three months after the deal closed,
  Perforce laid off roughly **15% of Puppet's workforce (~75 employees)** in
  Portland. Puppet was Portland's largest homegrown tech company and employed
  ~500 at the time of sale.
  ([Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/),
  [Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- Puppet itself framed the acquisition positively in an open letter to its
  community at the time.
  ([Puppet blog: "Puppet Acquired by Perforce — An Open Letter"](https://www.puppet.com/blog/puppet-acquired-an-open-letter))

---

## 5. The 2024–2025 source-available controversy

### 5.1 Perforce's announcement (Nov 7, 2024)

In a blog post titled **"Our Plans for Open Source Puppet in 2025"** (published
**November 7, 2024**), Perforce/Puppet announced significant changes to how
open-source Puppet would be distributed:
([Puppet blog, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025))

- **Private binaries.** "In early 2025, Puppet will begin to ship any new
  binaries and packages developed by our team to a **private, hardened, and
  controlled location**."
- **Developer EULA + 25-node cap.** A new development license (an EULA) gives
  developers free access to hardened Puppet releases **up to 25 nodes**.
- **Commercial license beyond 25 nodes.** "Capacities higher than 25 nodes
  will require a **Puppet Labs Support Commercial License**."
- **Source stays Apache 2.0.** The source code remains under the Apache 2.0
  license, and users "will continue to have full access to Puppet source
  code." But the company would **"slow down the frequency of commits of source
  code to public repositories."**
- **Forge unaffected.** "The Puppet Forge and module content hosted there will
  remain freely available."
- **Stated justification.** Perforce framed the move as increasing "security
  hardening and stability for Puppet downstream."

### 5.2 Community backlash and fork plans (Dec 2024)

The community reacted strongly, viewing the change as effectively closing off
open binaries and pushing users toward commercial licenses.
([The New Stack: Puppet's open source community plans to fork](https://thenewstack.io/puppets-open-source-community-plans-to-fork-the-program/),
[DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))

- Reported quote — **Antoine Beaupré**: "We're not forking Puppet; Perforce is
  forking Puppet… What Perforce is doing right now is taking the open source
  code that we have collaboratively used, debugged, written, collaborated,
  stared at and deployed on thousands of machines, and closing access to it to
  paying customers."
  ([DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))
- Reported quote — **Gene Liverman** (former Puppet SRE, 2017–2023): "a fork
  is absolutely coming now," after concluding "there was no longer hope of
  really working together."
  ([DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))
- An **OpenPuppetProject** GitHub repository was established; Perforce
  **"refused to let us use the [Puppet] name quite explicitly,"** so candidate
  names floated included Muppet, Manikin, Dolly, Openvox, and OpenDCM.
  ([DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/),
  [DevOps.com: "Perforce Forks Puppet, Community Considers Muppet"](https://devops.com/perforce-forks-puppet-community-considers-muppet/))

### 5.3 The OpenVox fork (Jan 2025)

- **Origin.** OpenVox began as a **Puppet mirror created by Overlook
  InfraTech** to keep providing community packages after Perforce
  discontinued public packaging efforts in late 2024. It is hosted under
  **Vox Pupuli's GitHub namespace (OpenVoxProject)**. Vox Pupuli is a
  long-standing collective of Puppet module, tooling, and documentation
  maintainers.
  ([Vox Pupuli: OpenVox page](https://voxpupuli.org/openvox/),
  [Overlook InfraTech: first release](https://overlookinfratech.com/2025/01/21/first-release-hot-off-the-presses/))

- **Jan 21, 2025 — First release: OpenVox 8.11.** Announced on the Vox Pupuli
  blog (by community member **binford2k**), described as "functionally
  equivalent to Puppet and… a drop-in replacement." Vox Pupuli calls it a
  **"soft-fork"** because it intends to maintain downstream compatibility "for
  as long as we are able."
  ([Vox Pupuli blog, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/))

- **Stated project goals:** modernize the codebase/ecosystem (current OS
  support), recenter on community/user needs, democratize platform support via
  community contributions, and sustain an active open-source community.
  ([Vox Pupuli blog, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/))

- **Puppet Standards Steering Committee.** Vox Pupuli said it was working with
  Perforce to set up this committee to guide feature direction and language
  evolution; Perforce was "invited to participate."
  ([Vox Pupuli blog, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/),
  [Vox Pupuli: OpenVox page](https://voxpupuli.org/openvox/))

- Press coverage of the launch:
  [The New Stack: "OpenVox: The Community-Driven Fork of Puppet Has Arrived"](https://thenewstack.io/openvox-the-community-driven-fork-of-puppet-has-arrived/),
  [InfoWorld: "Puppet open source fork OpenVox arrives"](https://www.infoworld.com/article/3809889/puppet-open-source-fork-openvox-arrives.html),
  [LWN: "Puppet fork OpenVox makes first release"](https://lwn.net/Articles/1005781/).

### 5.4 The EULA fallout (May 2025)

- **May 19, 2025 — Vox Pupuli rejects the Puppet Core Developer EULA.** Vox
  Pupuli published a statement concluding it is "unable to sign the Puppet Core
  Developer EULA" because "the restrictions placed on usage prevent effective
  testing and distribution of modules," and to avoid "potential legal
  challenges."
  ([Vox Pupuli blog, 2025-05-19](https://voxpupuli.org/blog/2025/05/19/perforce-eula/))
- **Practical impact:** Vox Pupuli modules are **no longer tested against
  Puppet Core** ("please use them at your own risk"); they are tested against
  OpenVox packages instead. Vox Pupuli said it remains "interested in working
  together with Perforce" but the EULA currently prevents that collaboration.
  ([Vox Pupuli blog, 2025-05-19](https://voxpupuli.org/blog/2025/05/19/perforce-eula/))

---

## 6. Current status: open-source Puppet vs. commercial Puppet Enterprise

- **OpenVox** is now the community-maintained open-source line, continuing to
  ship releases (e.g., new OpenVoxProject 8 releases in mid-2025). Downstreams
  have begun migrating from Puppet to OpenVox (e.g., NC State Linux community).
  ([Vox Pupuli blog, 2025-07-31](https://voxpupuli.org/blog/2025/07/31/openvox-releases/),
  [NC State Linux: Puppet to OpenVox transition](https://linux.ncsu.edu/news/2025/07/puppet-to-openvox-transition/))
- **Puppet (Perforce)** continues commercial **Puppet Enterprise**, with
  open-source Puppet source remaining Apache 2.0 but new official binaries
  gated behind the private, EULA-controlled location and the 25-node free
  cap. Perforce published a follow-up framing of its open-source plans.
  ([Puppet blog, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025),
  [Puppet releases page](https://www.puppet.com/releases))
- The **Puppet Forge** remains freely available to both ecosystems, per
  Perforce's stated commitment.
  ([Puppet blog, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025))

---

## Sources (selected primary / reputable)

- Wikipedia — Puppet (software): https://en.wikipedia.org/wiki/Puppet_(software)
- Puppet — Luke Kanies author page: https://www.puppet.com/author/luke-kanies
- TechCrunch (2010-07-19), Puppet Labs $5M / Reductive Labs rebrand: https://techcrunch.com/2010/07/19/puppet-labs/
- TechCrunch (2022-04-11), Perforce acquires Puppet: https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/
- Clearlake Capital press release: https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/
- Perforce — acquisition completed: https://www.perforce.com/press-releases/perforce-completes-acquisition-puppet
- Puppet — "Puppet Acquired by Perforce" open letter: https://www.puppet.com/blog/puppet-acquired-an-open-letter
- Bend Bulletin (2022-08-08), layoffs: https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/
- Puppet — "Our Plans for Open Source Puppet in 2025" (2024-11-07): https://www.puppet.com/blog/open-source-puppet-updates-2025
- DevClass (2024-12-18), community fork plans: https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/
- The New Stack — community plans to fork: https://thenewstack.io/puppets-open-source-community-plans-to-fork-the-program/
- The New Stack — OpenVox has arrived: https://thenewstack.io/openvox-the-community-driven-fork-of-puppet-has-arrived/
- DevOps.com — "Perforce Forks Puppet, Community Considers Muppet": https://devops.com/perforce-forks-puppet-community-considers-muppet/
- Vox Pupuli — OpenVox page: https://voxpupuli.org/openvox/
- Vox Pupuli — first release (2025-01-21): https://voxpupuli.org/blog/2025/01/21/openvox-release/
- Overlook InfraTech — first release (2025-01-21): https://overlookinfratech.com/2025/01/21/first-release-hot-off-the-presses/
- Vox Pupuli — Perforce EULA (2025-05-19): https://voxpupuli.org/blog/2025/05/19/perforce-eula/
- InfoWorld — OpenVox arrives: https://www.infoworld.com/article/3809889/puppet-open-source-fork-openvox-arrives.html
- LWN — OpenVox first release: https://lwn.net/Articles/1005781/
- Puppet Forge — puppetlabs/aws: https://forge.puppet.com/modules/puppetlabs/aws
- GitHub — puppetlabs/puppetlabs-provision: https://github.com/puppetlabs/puppetlabs-provision
- Puppet — Cloud use case: https://www.puppet.com/why-puppet/use-cases/cloud

---

## Key people & teams (chronological)

This section traces the people and teams behind Puppet over time, in
chronological order. As elsewhere, every factual claim is followed by an
inline source URL; unconfirmed claims are flagged **"Could not verify."**

### 2005–2009 — Founders and the Reductive Labs team

- **Luke Kanies — founder.** Kanies began writing Puppet in 2005 "after years
  as a sysadmin and consultant seeking better tools for managing complex IT
  systems." He had been a Unix admin and publishing/speaking on system
  administration since 1997, shifting toward software development around 2001.
  Frustrated with CFEngine's closed development and a brief stint at the
  commercial vendor BladeLogic, he turned his consulting company into a
  software company.
  ([Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies),
  [The Pathless Path interview](https://pathlesspath.com/kanies/))

- **Company name: Reductive Labs.** Kanies founded the company as **Reductive
  Labs** (rebranded to Puppet Labs in 2010 — see Section 1 above). As of the
  June 2009 Series A led by True Ventures it was "a three-person company called
  Reductive Labs."
  ([True Ventures — Why we invested in Reductive Labs](https://trueventures.com/blog/why-we-invested-in-reductive-labs))

- **Co-founders: Andrew (Clay) Shafer and Teyo Tyree.** Andrew Clay Shafer is
  widely described as a co-founder of Reductive Labs/Puppet alongside Kanies;
  Kanies and Shafer first met as college roommates. Shafer later (2014) joined
  Pivotal as a director of technology working on Cloud Foundry, and is broadly
  recognized as an early popularizer of "infrastructure as code" and DevOps.
  ([Data Center Knowledge — Pivotal grabs Puppet Labs co-founder Andrew Clay Shafer, 2014-07-21](https://www.datacenterknowledge.com/archives/2014/07/21/puppet-labs-co-founder-shafer-to-push-cloud-foundry-community-growth-at-pivotal))
  - **Teyo Tyree** is also credited as a co-founder; at the June 2009 Series A
    he was Founder and VP of Professional Services, with Kanies as Founder and
    CEO.
    ([RedMonk podcast — Teyo Tyree on Puppet/Reductive Labs, 2010-01-04](https://redmonk.com/cote/2010/01/04/itmanagement062/),
    [Silicon Florist — Puppet Labs explained by co-founder Teyo Tyree, 2012-04-26](https://siliconflorist.com/2012/04/26/puppet-labs-explanation-cofounder-teyo-tyree/))

### 2016 — First CEO transition (Kanies → Mirchandani)

- **Sanjay Mirchandani named CEO (Sep 26, 2016).** Puppet appointed **Sanjay
  Mirchandani** as CEO and board member on September 26, 2016, replacing
  founder Luke Kanies. Mirchandani had joined Puppet in **May 2016** as the
  company's first president and COO before being promoted. He is an industry
  veteran whose prior roles included VMware, EMC, and Microsoft.
  ([Light Reading — Puppet appoints Sanjay Mirchandani as CEO](https://www.lightreading.com/operations/puppet-appoints-sanjay-mirchandani-as-ceo-replacing-founder-luke-kanies),
  [The Register — Puppet names new CEO, 2016-09-27](https://www.theregister.com/2016/09/27/puppet_names_new_ceo/))

- **Kanies → Executive Chair.** After stepping down as CEO in 2016, Kanies
  "continued to shape Puppet's strategic direction as Executive Chair until
  2022."
  ([Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies))

### 2019 — Second CEO transition (Mirchandani → Wassenaar)

- **Yvonne Wassenaar named CEO (Jan 29, 2019; start Jan 31, 2019).** Puppet
  announced **Yvonne Wassenaar** as its next CEO on January 29, 2019, effective
  January 31, 2019, replacing Mirchandani, who stepped down "to embark on a new
  opportunity." Wassenaar had previously been CEO of Airware, CIO of New Relic,
  and spent four years at VMware.
  ([Puppet press release — Names Yvonne Wassenaar as Next CEO, 2019-01-29](https://www.globenewswire.com/news-release/2019/01/29/1707093/0/en/Puppet-Names-Yvonne-Wassenaar-as-Next-CEO.html),
  [GeekWire — Puppet's new CEO Yvonne Wassenaar, 2019](https://www.geekwire.com/2019/puppet-makes-change-top-new-ceo-yvonne-wassenaar/))
  - **Mirchandani's next role:** he became CEO of **Commvault**.
    ([Blocks & Files — Commvault's new puppet-master, 2019-02-05](https://blocksandfiles.com/2019/02/05/commvault-has-a-new-puppet-master-pulling-its-strings/))

### 2019–2021 — Luke Kanies after the CEO role: Clickety

- **Clickety (founded 2019, shut down Sep 2021).** Kanies founded **Clickety**,
  a Portland-based "project management for people" tool, in 2019. It raised a
  ~$2M seed round (Founders' Co-op, Flying Fish, Oregon Venture Fund, Liquid 2
  Ventures, and angels including Kenny Van Zant and Jay Simons) and shut down
  at the end of September 2021.
  ([GeekWire — Clickety shutting down, 2021](https://www.geekwire.com/2021/clickety-project-management-people-tool-puppet-founder-luke-kanies-shutting/))

- **Advisory roles.** Beyond Puppet and Clickety, Kanies has advised companies
  including GitLab, Sensu, and Wallaroo Labs.
  ([Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies))
  - **Could not verify:** a role for Luke Kanies at **Indeed** (the job site).
    No source found connecting Kanies to Indeed; searches surfaced only generic
    Indeed.com listings unrelated to him.

### 2022 — Perforce acquisition: leadership on both sides

- **Yvonne Wassenaar (Puppet CEO) through the acquisition.** Wassenaar was
  Puppet's CEO when Perforce announced (Apr 11, 2022) and completed (May 18,
  2022) the acquisition, and was quoted on the deal rationale (see Section 4).
  After the deal closed, she joined the **JFrog** board of directors in
  September 2022.
  ([TechCrunch — Perforce acquires Puppet, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/),
  [GeekWire — Portland's Puppet to be acquired by Perforce, 2022](https://www.geekwire.com/2022/portland-cloud-infrastructure-company-puppet-to-be-acquired-by-perforce-software/))
  - **Could not verify (precise date):** the exact date Wassenaar departed the
    Puppet CEO role after the acquisition completed.

- **Perforce leadership at acquisition: Mark Ties (CEO).** **Mark Ties** was
  Perforce's CEO at the time of the 2022 Puppet acquisition. Ties had been with
  Perforce since 2016 and CEO since 2018, growing it from a ~$50M single-product
  company to a multi-product DevOps provider with 1,500+ employees.
  **Tim Russell** was Perforce's Chief Product Officer and was quoted on the
  acquisition.
  ([Perforce — Names Jim Cassens CEO; Mark Ties retires](https://www.perforce.com/in-the-news/perforce-software-names-jim-cassens-ceo-mark-ties-retires),
  [TechCrunch — Perforce acquires Puppet, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

- **Aug 2022 layoffs.** Roughly three months after closing, Perforce laid off
  ~15% of Puppet's workforce (~75 of ~500 Portland employees) — see Section 4.
  ([Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/))

### 2023–2024 — Perforce CEO change

- **Jim Cassens succeeds Mark Ties (announced Nov 7, 2023; effective Jan 1,
  2024).** Perforce appointed **Jim Cassens** (formerly President of Fortra) as
  CEO effective January 1, 2024, succeeding Mark Ties, who retired and became
  Executive Chair of the Perforce board. Cassens was therefore Perforce's CEO
  during the November 2024 open-source Puppet announcement and the 2025 OpenVox
  fallout (Section 5).
  ([Perforce — Names Jim Cassens CEO; Mark Ties retires](https://www.perforce.com/in-the-news/perforce-software-names-jim-cassens-ceo-mark-ties-retires),
  [Clearlake — Perforce appoints Jim Cassens as CEO](https://clearlake.com/news/perforce-software-appoints-technology-veteran-jim-cassens-as-new-chief-executive-officer/))

### 2024–2025 — Community figures behind the OpenVox fork

- **Antoine Beaupré** — a community member who publicly criticized Perforce's
  changes, framing them as "Perforce… forking Puppet" by closing access to
  collaboratively built open-source code (see Section 5.2).
  ([DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))

- **Gene Liverman** — a former Puppet SRE (2017–2023) who concluded "a fork is
  absolutely coming now" after community-collaboration hopes faded (see
  Section 5.2).
  ([DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))

- **Vox Pupuli** — a long-standing collective of Puppet module, tooling, and
  documentation maintainers ("working together for the greater good") that
  adopted and now hosts the OpenVox fork under its **OpenVoxProject** GitHub
  namespace.
  ([Vox Pupuli — OpenVox page](https://voxpupuli.org/openvox/),
  [GitHub — OpenVoxProject org](https://github.com/openvoxproject))

- **Overlook InfraTech** — the company that started OpenVox "as a Puppet mirror
  … to continue providing community packages when Perforce discontinued public
  packaging efforts in late Fall of 2024," using its packaging pipeline; work
  then moved to Vox Pupuli. Overlook continues to host package repositories
  (`apt|yum.overlookinfratech.com`) and sponsors the project; it describes its
  people as "founding members of the Puppet community… writing Puppet code
  since the very beginning."
  ([Vox Pupuli — OpenVox page](https://voxpupuli.org/openvox/),
  [GitHub — Overlook InfraTech org](https://github.com/overlookinfra))
  - **Could not verify:** the specific named individual founders/principals of
    Overlook InfraTech (the About page at
    https://overlookinfratech.com/about/ returned HTTP 403 and could not be
    fetched).

- **Ben Ford (GitHub: binford2k)** — published the first OpenVox release
  announcement (Jan 21, 2025) on the Vox Pupuli blog and is a key OpenVox
  maintainer. Ford is a longtime Puppet community figure who served as Puppet's
  community director / developer advocate, overseeing the Forge and Ecosystem
  team.
  ([Vox Pupuli blog — first release, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/),
  [GitHub — binford2k (Ben Ford)](https://github.com/binford2k),
  [Puppet — Who the Vox Pupuli Are (podcast, Sep 2023)](https://www.puppet.com/resources/podcasts/vox-pupuli-sept-2023))

- **Puppet Standards Steering Committee.** Vox Pupuli created this committee to
  set the direction of features and language evolution, and "invited Perforce
  to participate" (see Section 5.3).
  ([Vox Pupuli — OpenVox page](https://voxpupuli.org/openvox/),
  [Vox Pupuli blog — first release, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/))

#### People/teams sources (this section)

- Puppet — Luke Kanies author page: https://www.puppet.com/author/luke-kanies
- The Pathless Path — Luke Kanies interview: https://pathlesspath.com/kanies/
- True Ventures — Why we invested in Reductive Labs: https://trueventures.com/blog/why-we-invested-in-reductive-labs
- Data Center Knowledge — Pivotal grabs co-founder Andrew Clay Shafer (2014): https://www.datacenterknowledge.com/archives/2014/07/21/puppet-labs-co-founder-shafer-to-push-cloud-foundry-community-growth-at-pivotal
- RedMonk podcast — Teyo Tyree (2010-01-04): https://redmonk.com/cote/2010/01/04/itmanagement062/
- Silicon Florist — Teyo Tyree (2012-04-26): https://siliconflorist.com/2012/04/26/puppet-labs-explanation-cofounder-teyo-tyree/
- Light Reading — Mirchandani named CEO (2016): https://www.lightreading.com/operations/puppet-appoints-sanjay-mirchandani-as-ceo-replacing-founder-luke-kanies
- The Register — Puppet names new CEO (2016-09-27): https://www.theregister.com/2016/09/27/puppet_names_new_ceo/
- Puppet press release — Wassenaar named CEO (2019-01-29): https://www.globenewswire.com/news-release/2019/01/29/1707093/0/en/Puppet-Names-Yvonne-Wassenaar-as-Next-CEO.html
- GeekWire — Wassenaar new CEO (2019): https://www.geekwire.com/2019/puppet-makes-change-top-new-ceo-yvonne-wassenaar/
- Blocks & Files — Mirchandani to Commvault (2019-02-05): https://blocksandfiles.com/2019/02/05/commvault-has-a-new-puppet-master-pulling-its-strings/
- GeekWire — Clickety shutting down (2021): https://www.geekwire.com/2021/clickety-project-management-people-tool-puppet-founder-luke-kanies-shutting/
- Perforce — Jim Cassens named CEO; Mark Ties retires: https://www.perforce.com/in-the-news/perforce-software-names-jim-cassens-ceo-mark-ties-retires
- Clearlake — Perforce appoints Jim Cassens CEO: https://clearlake.com/news/perforce-software-appoints-technology-veteran-jim-cassens-as-new-chief-executive-officer/
- GeekWire — Portland's Puppet acquired by Perforce (2022): https://www.geekwire.com/2022/portland-cloud-infrastructure-company-puppet-to-be-acquired-by-perforce-software/
- GitHub — OpenVoxProject: https://github.com/openvoxproject
- GitHub — Overlook InfraTech: https://github.com/overlookinfra
- GitHub — binford2k (Ben Ford): https://github.com/binford2k
- Puppet — Who the Vox Pupuli Are (podcast, Sep 2023): https://www.puppet.com/resources/podcasts/vox-pupuli-sept-2023

---

## Company & corporate history (chronological)

This section traces Puppet as a *business entity* — its corporate names,
funding, ownership, and the private-equity decisions that shaped its later
years. It is deliberately distinct from the "Key people & teams" section
above (which tracks individuals). As elsewhere, every factual claim is
followed by an inline source URL; unconfirmed claims are flagged
**"Could not verify."**

### 2005–2009 — Reductive Labs (the founding entity)

- **2005 — Reductive Labs founded.** Luke Kanies turned his consulting
  business into a software company and went full-time on Puppet development in
  **March 2005**; the corporate entity was named **Reductive Labs** (Puppet was
  the product name).
  ([RedMonk — Reductive Labs Q&A, 2009-06-24](https://redmonk.com/cote/2009/06/24/reductivelabs/),
  [Puppet — Luke Kanies author page](https://www.puppet.com/author/luke-kanies))

  > Founding-year discrepancy: the 2022 TechCrunch acquisition article states
  > Puppet was "founded in 2009," which most likely tracks a formal
  > incorporation / first-institutional-funding milestone rather than the 2005
  > start of development. Primary sources favor **2005** (dev start) /
  > **2009** (first venture round). This research uses 2005 as the founding of
  > the business and flags 2009 as the alternative corporate-formation date.
  > ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

- **Jun 2009 — First venture funding (Series A), still "Reductive Labs."** At
  the time of its first institutional round (led by True Ventures, ~$2M),
  Reductive Labs was a small (~3-person) company; the contemporaneous RedMonk
  Q&A confirms the company was still operating under the Reductive Labs name in
  June 2009.
  ([RedMonk — Reductive Labs Q&A, 2009-06-24](https://redmonk.com/cote/2009/06/24/reductivelabs/),
  [True Ventures — Why we invested in Reductive Labs](https://trueventures.com/blog/why-we-invested-in-reductive-labs))
  - **Could not verify:** the precise headquarters/location of Reductive Labs
    in 2009. The RedMonk Q&A does not state a Tennessee HQ (one secondary
    summary asserted "headquartered in Tennessee," but that claim is not
    supported by the primary Q&A text). Puppet later established its HQ in
    **Portland, Oregon**.

### 2010 — Rebrand to Puppet Labs

- **2010 — Reductive Labs renamed Puppet Labs.** The company rebranded to
  **Puppet Labs** in 2010 (the product had far more market recognition than the
  corporate name), around a reported **$5M** round in July 2010. HQ was in
  **Portland, Oregon**, where Puppet grew into the city's largest homegrown
  tech company.
  ([TechCrunch, 2010-07-19](https://techcrunch.com/2010/07/19/puppet-labs/),
  [Act-On — The Puppet rebranding story](https://act-on.com/learn/blog/the-perils-pleasures-of-rebranding-the-puppet-story/),
  [Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/))

### 2011–2018 — Venture-funded scale-up (Series C → Series F)

The company raised roughly **$150M in equity** across its venture life
(plus debt — see reconciliation below). Key equity rounds:

- **Late 2011 — Series C, $8.5M.** Led by Cisco, with Google Ventures and
  VMware participating. (Some coverage labels the November 2011 round Series A;
  the VMware-investment coverage explicitly calls the late-2011 round a
  **Series C**.)
  ([Data Center Knowledge — VMware invests $30M in Puppet Labs, 2013-01-24](https://www.datacenterknowledge.com/investing/vmware-invests-30-million-in-puppet-labs),
  [Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- **Jan 24, 2013 — VMware $30M strategic investment (Series D).** VMware made a
  **$30 million** strategic investment paired with a commercial agreement to
  jointly develop, market, and sell integrations (vCloud Automation Center,
  vCenter Operations Manager, vCenter Configuration Manager). Total funding
  reached ~**$45.5M** after this round.
  ([Data Center Knowledge — VMware invests $30M in Puppet Labs, 2013-01-24](https://www.datacenterknowledge.com/investing/vmware-invests-30-million-in-puppet-labs),
  [InfoWorld — VMware takes a $30M interest in Puppet](https://www.infoworld.com/article/2612791/vmware-takes-a--30-million-interest-in-puppet.html))

  > Date correction: the VMware **$30M** strategic investment was announced
  > **January 2013** (reported as a Series D / strategic round), *not* 2014.
  > Multiple contemporaneous outlets (Data Center Knowledge, InfoWorld,
  > Network World, IT World Canada) date it to January 2013. Treat any "2014
  > VMware strategic investment" framing as the **January 2013** event.
  > ([Network World — VMware takes a $30M interest in Puppet](https://www.networkworld.com/article/2162978/vmware-takes-a--30-million-interest-in-puppet.html))

- **2014 — Series E, $40M.** Puppet Labs closed a **$40 million** Series E,
  bringing total venture capital raised to ~$86M; existing investors Cisco,
  Google Ventures, Kleiner Perkins Caufield & Byers, Triangle Venture Capital,
  True Ventures, and VMware participated.
  ([Channel Futures — Puppet Labs closes $40M Series E](https://www.channelfutures.com/cloud/puppet-labs-closes-40-million-series-e-funding-round))

- **2016 — $22M debt round.** Puppet took on ~**$22M** in debt financing in
  2016 (distinct from equity).
  ([TechCrunch — Puppet announces $40M debt round from BlackRock, 2020-07-16](https://techcrunch.com/2020/07/16/puppet-announces-40-million-debt-round-from-blackrock/))

- **Jun 27, 2018 — Series F, $42M.** Led by Cisco Investments, with Kleiner
  Perkins, True Ventures, EDBI, and VMware participating; announced alongside
  the milestone of 40,000+ businesses using Puppet. This brought cumulative
  funding to roughly **$150M**.
  ([TechCrunch — Puppet raises $42M led by Cisco, 2018-06-27](https://techcrunch.com/2018/06/27/puppet-raises-42m-led-by-cisco-as-its-devops-automation-platform-passes-40000-businesses/),
  [Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

### 2016–2017 — Corporate name simplification to "Puppet" / "Puppet, Inc."

- **2016–2017 — "Puppet Labs" → "Puppet."** The company dropped "Labs" and
  began operating simply as **Puppet** (legal entity **Puppet, Inc.**). The
  **Puppet, Inc.** name was in use by the time of the **Sep 20, 2017** Distelli
  acquisition, where the acquirer is identified as "Puppet, Inc."
  ([Puppet Support — Puppet Labs vs. Puppet naming](https://support.puppet.com/hc/en-us/articles/217916728-Why-are-some-things-under-under-the-name-Puppet-Labs-and-others-under-the-name-Puppet-),
  [Mergr — Distelli acquired by Puppet, Inc. (2017-09-20)](https://mergr.com/distelli-acquired-by-puppet),
  [GlobeNewswire — Puppet Acquires Distelli, 2017-09-20](https://www.globenewswire.com/en/news-release/2017/09/20/1230031/0/en/Puppet-Acquires-Distelli-to-Fuel-the-New-Age-of-Automation-Across-the-Software-Delivery-Lifecycle.html))
  - **Could not verify (exact date):** the precise month the legal entity name
    changed to "Puppet, Inc." Sources confirm the name was *in use* by Sep
    2017 but do not pin a specific rename date; the user's "Puppet, Inc.
    (2017)" framing is consistent with the available evidence.

### 2020 — BlackRock debt round and the funding-total reconciliation

- **Jul 16, 2020 — $40M debt round from BlackRock.** Puppet secured **$40
  million** in debt financing from funds managed by **BlackRock** — debt, not
  equity (Puppet repays it; BlackRock took a **board observer** seat rather
  than a stake). CEO **Yvonne Wassenaar** framed it as the first step of a
  longer-term relationship; BlackRock cited COVID-19 pulling forward demand.
  ([TechCrunch — Puppet announces $40M debt round from BlackRock, 2020-07-16](https://techcrunch.com/2020/07/16/puppet-announces-40-million-debt-round-from-blackrock/),
  [GlobeNewswire — Puppet Secures $40 Million in New Funding, 2020-07-16](https://www.globenewswire.com/news-release/2020/07/16/2063391/0/en/Puppet-Secures-40-Million-in-New-Funding.html))

  > **Reconciling ~$150M vs ~$190M total.** The two commonly cited totals are
  > *not* contradictory once debt vs. equity is separated:
  > - **~$150M** = cumulative **equity** venture funding through the 2018
  >   Series F (the figure Wikipedia and the 2020 TechCrunch piece use for
  >   "previously raised almost $150 million").
  > - **~$190M** ("nearly $190 million," used in the 2022 acquisition coverage)
  >   = that equity total **plus debt**, principally the **$40M BlackRock 2020
  >   debt round** (and the earlier **~$22M 2016 debt round**). $150M + $40M ≈
  >   $190M.
  > Crunchbase separately reports a total in the ~$189.5M range across ~10
  > rounds, consistent with the debt-inclusive figure.
  > ([TechCrunch, 2020-07-16](https://techcrunch.com/2020/07/16/puppet-announces-40-million-debt-round-from-blackrock/),
  > [TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/))

### Revenue & headcount (corporate metrics)

- **Customers / market reach (YE 2021).** At acquisition, Puppet reported
  **40,000+ organizations** using its solutions, including **85% of the world's
  largest banks** and **80% of top technology firms**, and **40 of the Fortune
  50**.
  ([Clearlake — Perforce to acquire Puppet](https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/))
- **Headcount.** Puppet employed roughly **500 people** at the time of the 2022
  sale, and was Portland's largest homegrown tech company.
  ([Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/))
  - **Could not verify (revenue).** No primary/reputable source confirms
    Puppet's revenue. Third-party aggregators (e.g., getlatka, growjo) list
    figures such as "$16.4M revenue (2021)," but these are unaudited estimates
    and are **not** treated as verified here. Puppet was privately held and did
    not disclose revenue; Perforce did not disclose deal terms or Puppet
    financials.
    ([Clearlake — Perforce to acquire Puppet](https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/))

### 2022 — Perforce acquisition (PE ownership via Clearlake Capital)

- **Apr 11, 2022 — Acquisition announced.** **Perforce Software**
  (Minneapolis/Minnesota-based) agreed to acquire Puppet, adding infrastructure
  automation to its DevOps portfolio; terms undisclosed, expected to close in
  Q2 2022.
  ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/),
  [Clearlake — Perforce to acquire Puppet](https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/))

- **Perforce's PE ownership.** Perforce is backed by private-equity firms
  **Clearlake Capital** (which acquired Perforce in **2018**) and **Francisco
  Partners**. The Puppet acquisition was thus, in corporate terms, a
  **Clearlake/Francisco-Partners-controlled** company buying Puppet — making
  Puppet's subsequent direction a private-equity-portfolio decision.
  ([TechCrunch, 2022-04-11](https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/),
  [Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/),
  [Clearlake — Perforce to acquire Puppet](https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/))

- **May 18, 2022 — Acquisition completed.** Puppet became a Perforce company
  (legal entity **Puppet, Inc.**, now a Perforce subsidiary).
  ([Perforce — acquisition completed](https://www.perforce.com/press-releases/perforce-completes-acquisition-puppet),
  [Wikipedia: Puppet (software)](https://en.wikipedia.org/wiki/Puppet_(software)))

- **Aug 2022 — Post-acquisition layoffs (~75 / ~15%).** Less than three months
  after closing, Perforce restructured Puppet, cutting a reported **~15% of the
  workforce (~75 employees)** in Portland, citing a need to "balance
  operational efficiencies with continued innovation."
  ([Pittsburgh Post-Gazette / Oregonian wire, 2022-08](https://markets.post-gazette.com/postgazette/news/read/42602869/perforce_software_starts_layoffs_at_portland's_puppet),
  [Bend Bulletin / Oregonian, 2022-08-08](https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/))
  - **Sourcing nuance:** the original Bend Bulletin/Oregonian story documented
    **16 named** layoffs with employees believing **"several dozen"** total;
    the **~75 / ~15%** figure appears in the wire/aggregated versions of the
    same reporting (e.g., Pittsburgh Post-Gazette). Both reflect the same
    August 2022 restructuring.

### 2024 — Source-available business-model change (a Perforce/Clearlake commercial decision)

- **Nov 7, 2024 — Open-source Puppet moves to private, EULA-gated binaries.**
  Under Perforce (and ultimately Clearlake's) ownership, Puppet announced that
  from early 2025 it would ship new binaries/packages to a **private, hardened,
  controlled location**, free for development up to **25 nodes** under a new
  EULA, with capacities beyond 25 nodes requiring a **Puppet Labs Support
  Commercial License**. Source remains Apache 2.0, but public-repo commit
  frequency would slow. This was, in corporate terms, a **monetization /
  commercial decision by the Perforce/Clearlake-owned entity** to push
  production users toward paid licensing — the trigger for the community
  OpenVox fork (see Section 5).
  ([Puppet blog — Our Plans for Open Source Puppet in 2025, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025),
  [DevClass, 2024-12-18](https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/))

### Current corporate status (as of 2025)

- **Puppet (Perforce) — commercial.** Perforce continues to sell **Puppet
  Enterprise** and now distributes open-source Puppet binaries via the private,
  EULA-controlled channel with the 25-node free cap; Puppet source stays Apache
  2.0 and the Puppet Forge remains freely available.
  ([Puppet blog, 2024-11-07](https://www.puppet.com/blog/open-source-puppet-updates-2025),
  [Puppet releases page](https://www.puppet.com/releases))
- **OpenVox — community.** The independent, community-maintained fork (hosted
  by Vox Pupuli, started by Overlook InfraTech) now carries the freely
  packaged open-source line, positioned as a drop-in replacement for Puppet
  (see Section 5 for the full fork narrative).
  ([Vox Pupuli — OpenVox page](https://voxpupuli.org/openvox/),
  [Vox Pupuli blog — first release, 2025-01-21](https://voxpupuli.org/blog/2025/01/21/openvox-release/))

#### Corporate-history sources (this section)

- RedMonk — Reductive Labs Q&A (2009-06-24): https://redmonk.com/cote/2009/06/24/reductivelabs/
- True Ventures — Why we invested in Reductive Labs: https://trueventures.com/blog/why-we-invested-in-reductive-labs
- TechCrunch — Puppet Labs $5M / rebrand (2010-07-19): https://techcrunch.com/2010/07/19/puppet-labs/
- Act-On — The Puppet rebranding story: https://act-on.com/learn/blog/the-perils-pleasures-of-rebranding-the-puppet-story/
- Data Center Knowledge — VMware invests $30M in Puppet Labs (2013-01-24): https://www.datacenterknowledge.com/investing/vmware-invests-30-million-in-puppet-labs
- InfoWorld — VMware takes a $30M interest in Puppet: https://www.infoworld.com/article/2612791/vmware-takes-a--30-million-interest-in-puppet.html
- Network World — VMware takes a $30M interest in Puppet: https://www.networkworld.com/article/2162978/vmware-takes-a--30-million-interest-in-puppet.html
- Channel Futures — Puppet Labs closes $40M Series E: https://www.channelfutures.com/cloud/puppet-labs-closes-40-million-series-e-funding-round
- TechCrunch — Puppet raises $42M led by Cisco (2018-06-27): https://techcrunch.com/2018/06/27/puppet-raises-42m-led-by-cisco-as-its-devops-automation-platform-passes-40000-businesses/
- TechCrunch — Puppet announces $40M debt round from BlackRock (2020-07-16): https://techcrunch.com/2020/07/16/puppet-announces-40-million-debt-round-from-blackrock/
- GlobeNewswire — Puppet Secures $40 Million in New Funding (2020-07-16): https://www.globenewswire.com/news-release/2020/07/16/2063391/0/en/Puppet-Secures-40-Million-in-New-Funding.html
- Puppet Support — Puppet Labs vs. Puppet naming: https://support.puppet.com/hc/en-us/articles/217916728-Why-are-some-things-under-under-the-name-Puppet-Labs-and-others-under-the-name-Puppet-
- Mergr — Distelli acquired by Puppet, Inc. (2017-09-20): https://mergr.com/distelli-acquired-by-puppet
- GlobeNewswire — Puppet Acquires Distelli (2017-09-20): https://www.globenewswire.com/en/news-release/2017/09/20/1230031/0/en/Puppet-Acquires-Distelli-to-Fuel-the-New-Age-of-Automation-Across-the-Software-Delivery-Lifecycle.html
- TechCrunch — Perforce acquires Puppet (2022-04-11): https://techcrunch.com/2022/04/11/perforce-adds-infrastructure-automation-tooling-with-puppet-acquisition/
- Clearlake — Perforce to acquire Puppet: https://clearlake.com/news/perforce-to-acquire-devops-pioneer-puppet/
- Perforce — acquisition completed (2022-05-18): https://www.perforce.com/press-releases/perforce-completes-acquisition-puppet
- Bend Bulletin / Oregonian — layoffs (2022-08-08): https://bendbulletin.com/2022/08/08/oregon-tech-puppets-new-owner-is-laying-off-staff/
- Pittsburgh Post-Gazette / Oregonian wire — Perforce starts layoffs at Puppet: https://markets.post-gazette.com/postgazette/news/read/42602869/perforce_software_starts_layoffs_at_portland's_puppet
- Puppet blog — Our Plans for Open Source Puppet in 2025 (2024-11-07): https://www.puppet.com/blog/open-source-puppet-updates-2025
- DevClass — community fork plans (2024-12-18): https://devclass.com/2024/12/18/community-plans-to-fork-puppet-unhappy-with-perforce-changes-to-open-source-project/
- Vox Pupuli — OpenVox page: https://voxpupuli.org/openvox/
- Vox Pupuli blog — first release (2025-01-21): https://voxpupuli.org/blog/2025/01/21/openvox-release/
- Wikipedia — Puppet (software): https://en.wikipedia.org/wiki/Puppet_(software)
