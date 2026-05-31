# HashiCorp Terraform & OpenTofu: A Chronological History

A dated timeline focused on cloud-API integration, the provider ecosystem, and
the controversies, spats, and partnerships that have defined Terraform and its
OpenTofu fork.

**Conventions used in this document:**
- Every factual claim carries an inline source URL.
- Established facts are stated plainly; reported claims, opinions, and gossip
  are attributed to their source ("According to…", "In a HN thread…").
- Claims that could not be confirmed against a primary or reputable source are
  flagged explicitly as **"Could not verify."**

---

## 2012 — Founding of HashiCorp

- HashiCorp was founded in **2012** by **Mitchell Hashimoto** and **Armon
  Dadgar**, who had been classmates at the University of Washington's Paul G.
  Allen School of Computer Science. The company name is a portmanteau of
  Hashimoto's surname and "Corporation."
  ([Wikipedia: HashiCorp](https://en.wikipedia.org/wiki/HashiCorp);
  [HashiCorp origin story](https://www.hashicorp.com/en/about/origin-story))

---

## 2014 — Terraform's First Release

- **July 2014:** HashiCorp released **Terraform 0.1**, an open-source,
  cloud-agnostic infrastructure-as-code (IaC) tool. It shipped with a limited
  set of integrations, including **AWS** and **DigitalOcean**, at launch.
  ([Wikipedia: Terraform](https://en.wikipedia.org/wiki/Terraform_(software));
  [The Story of HashiCorp Terraform with Mitchell Hashimoto](https://www.hashicorp.com/en/resources/the-story-of-hashicorp-terraform-with-mitchell-hashimoto))
- Terraform was released under the **Mozilla Public License v2.0 (MPL-2.0)**, a
  permissive open-source license — a fact that becomes central to the 2023–2024
  controversies below.
  ([HashiCorp adopts BSL](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license))
- The **AWS provider was the first official Terraform provider**, built on the
  AWS SDK, and AWS support has shipped out-of-the-box since the 0.1 release.
  ([AWS: Two billion downloads of the Terraform AWS Provider](https://aws.amazon.com/blogs/aws-insights/two-billion-downloads-of-the-terraform-aws-provider-shows-value-of-iac-for-infrastructure-management/))

---

## 2017 — The Provider/Plugin Split and the Terraform Registry

- **Terraform 0.10 (2017):** HashiCorp **split providers out of the core
  Terraform binary** into independently versioned and released plugins. Before
  this, a change to (for example) the AWS provider required cutting a whole new
  Terraform release; decoupling let providers and core move on separate
  cadences. The transition was bumpy during the 0.10 beta cycle.
  ([hashicorp/terraform issue #15427](https://github.com/hashicorp/terraform/issues/15427);
  [HashiCorp: A Guide to Terraform Binary, Provider, and Module Versioning](https://www.hashicorp.com/en/resources/a-guide-to-terraform-binary-provider-and-module-versioning))
- **HashiConf 2017:** The **Terraform Registry** launched, with initial support
  added in Terraform 0.10.6 to coincide with it; **Terraform 0.11** completed
  the integration with module version constraints and private registries.
  ([HashiCorp Terraform 0.11 blog](https://www.hashicorp.com/en/blog/hashicorp-terraform-0-11))
- The Registry became the canonical distribution point for publicly available
  providers and modules, with a provider registry protocol that lets the
  Terraform CLI discover and auto-install providers.
  ([Provider registry protocol reference](https://developer.hashicorp.com/terraform/internals/provider-registry-protocol))

---

## How Providers Wrap Cloud APIs (architecture context)

- A Terraform **provider is a plugin** that translates Terraform's declarative
  resource model into calls against an upstream cloud/SaaS API. Terraform core
  and providers communicate over a gRPC-based **plugin protocol** (versions 5
  and 6).
  ([How Terraform works with plugins](https://developer.hashicorp.com/terraform/plugin/how-terraform-works))
- Providers were historically built with the **Terraform Plugin SDK** (and
  SDKv2). All resources in the AWS provider are **hand-written in Go** (rather
  than fully code-generated), which the maintainers note gives rigorous test
  coverage but makes full AWS-service coverage a manual, prioritization-driven
  effort.
  ([HashiCorp: AWS and AWSCC Terraform providers — Better together](https://www.hashicorp.com/en/blog/aws-and-awscc-terraform-providers-better-together))

### The AWS provider's scale and the AWS↔HashiCorp partnership
- The **Terraform AWS provider is the largest and most-used provider**. As of
  this research it shows roughly **10.9k GitHub stars, 10.2k forks, ~399
  releases, and over 151,000 commits** on
  [hashicorp/terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws).
- The provider **celebrated its 10-year anniversary in 2024** and surpassed
  **three billion downloads**; by mid-2025 it had topped **four billion
  downloads** with the 6.0 release in public beta.
  ([AWS provider 6.0 GA](https://www.hashicorp.com/en/blog/terraform-aws-provider-6-0-now-generally-available);
  [AWS provider tops 4 billion downloads](https://www.hashicorp.com/en/blog/terraform-aws-provider-tops-4-billion-downloads-6-0-now-in-public-beta))
- HashiCorp describes the AWS provider as a **collaborative effort between
  HashiCorp and AWS**, and the two companies have publicly framed it as an
  ongoing, expanding partnership.
  ([AWS and HashiCorp's Journey to 1 Billion Terraform AWS Provider Downloads](https://www.hashicorp.com/en/blog/aws-and-hashicorp-s-journey-to-1-billion-terraform-aws-provider-downloads);
  [AWS Prescriptive Guidance: Understanding Terraform providers](https://docs.aws.amazon.com/prescriptive-guidance/latest/getting-started-terraform/providers.html))

---

## 2021 — Mitchell Hashimoto Steps Back

- **July 2021:** Co-founder **Mitchell Hashimoto announced he was leaving the
  CTO role to return to being an individual contributor** — "stepping down to
  the job he loves" as a hands-on engineer — while remaining at the company.
  ([The New Stack: Hashimoto on when to step down](https://thenewstack.io/hashicorps-mitchell-hashimoto-on-when-to-step-down-to-the-job-you-love/);
  [The New Stack: move from CTO garners respect](https://thenewstack.io/mitchell-hashimotos-move-from-cto-garners-r-e-s-p-e-c-t/))

*(Note: some secondary sources loosely date this to "December 2021"; the
primary reporting places the CTO-to-IC announcement in mid-2021. His full
departure from the company came later — see December 2023.)*

---

## January 2023 — Terraform Plugin Framework 1.0

- HashiCorp shipped **Terraform Plugin Framework 1.0** GA, a next-generation
  framework intended to improve upon and eventually **replace the Terraform
  Plugin SDKv2** for building providers. SDKv2 remained supported, but new
  features and tooling were prioritized for the new framework.
  ([HashiCorp: Terraform Plugin Framework Is Now Generally Available](https://www.hashicorp.com/en/blog/terraform-plugin-framework-is-now-generally-available);
  [InfoQ coverage](https://www.infoq.com/news/2023/01/terraform-plugin-framework/))

---

## August 2023 — The BSL Relicense (the inflection point)

- **August 10, 2023:** HashiCorp announced it was **changing the license of its
  core products from MPL-2.0 to the Business Source License (BSL / BUSL)
  v1.1**, effective for all **future releases**. The change covered Terraform,
  Vault, Consul, Boundary, Nomad, Waypoint, Packer, and Vagrant. **APIs, SDKs,
  and most other libraries stayed MPL-2.0.**
  ([HashiCorp: HashiCorp adopts Business Source License](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license);
  [GlobeNewswire press release](https://www.globenewswire.com/en/news-release/2023/08/10/2723189/0/en/HashiCorp-adopts-the-Business-Source-License-for-future-releases-of-its-products.html))
- **HashiCorp's stated rationale (verbatim from the announcement):** "there are
  other vendors who take advantage of pure OSS models … without providing
  material contributions back," and "Open source has reduced the barrier to
  copying innovation and selling it through existing distribution channels."
  The BSL's restriction: "Vendors who provide competitive services built on our
  community products will no longer be able to incorporate future releases, bug
  fixes, or security patches."
  ([HashiCorp adopts BSL](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license))
- BSL is **source-available, not open source**: code is viewable, but
  production/commercial use that competes with HashiCorp requires a separate
  commercial agreement; a non-compete restriction sits at the core.
  ([The Register: HashiCorp changes its source licence to BSL](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/))

### Backlash (attributed)
- **Pulumi CEO Joe Duffy** (rival IaC vendor), as reported by **The Register**,
  called the post "disingenuous," claiming: *"We tried many times to contribute
  upstream fixes to Terraform providers, but HashiCorp would never accept
  them."*
  ([The Register](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/))
- **OpenUK's Amanda Brock**, per The Register, called the framing *"open
  washing … they have indeed switched away from open source."*
  ([The Register](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/))
- Not all reaction was negative: **Scarf CEO Avi Press**, per The Register, gave
  qualified approval, saying HashiCorp "handled the transition smoothly."
  ([The Register](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/))
- HashiCorp later **updated its licensing FAQ** in response to community
  questions, attempting to clarify the scope of the "competitive" restriction.
  ([HashiCorp: updates licensing FAQ](https://www.hashicorp.com/en/blog/hashicorp-updates-licensing-faq-based-on-community-questions))

### Practical fallout
- The **last MPL-licensed Terraform release was v1.5.7**; vendors such as
  Gruntwork advised customers to stay on v1.5.7 or evaluate OpenTofu while the
  licensing picture stabilized.
  ([Gruntwork blog: impact of the HashiCorp license change](https://www.gruntwork.io/blog/the-impact-of-the-hashicorp-license-change-on-gruntwork-customers);
  [Spacelift: Terraform License Change](https://spacelift.io/blog/terraform-license-change))

---

## August–September 2023 — The OpenTF Manifesto → OpenTofu Fork

- **August 15, 2023:** An initiative called **OpenTF** published the **OpenTF
  Manifesto**, asking HashiCorp to reverse the BSL decision and return Terraform
  to a "truly open source" license.
  ([opentofu/manifesto on GitHub](https://github.com/opentofu/manifesto);
  [OpenTofu Manifesto page](https://opentofu.org/manifesto/))
- Within a month the manifesto repo gathered **~33,000 GitHub stars**, with
  **~140 companies and ~700 individuals** pledging support.
  ([Linux Foundation: Announcing OpenTofu](https://www.linuxfoundation.org/press/announcing-opentofu))
- **August 25, 2023:** When HashiCorp did not reverse course, OpenTF announced
  it would create an **open-source fork of Terraform**.
  ([Spacelift: Terraform license change recap](https://spacelift.io/blog/terraform-license-change))
- **September 20, 2023:** The **Linux Foundation announced the formation of
  OpenTofu** (renamed from OpenTF), positioning it as an open, community-driven,
  neutrally governed alternative under the LF umbrella.
  Backers named in the announcement included **Gruntwork, Spacelift, env0,
  Scalr, Harness, Digger, Terrateam, Massdriver, and Terramate**, alongside
  "140+ organizations and 600+ individuals."
  ([Linux Foundation: Announcing OpenTofu](https://www.linuxfoundation.org/press/announcing-opentofu))
- Quotes from that launch: **Jim Zemlin** (LF Executive Director): "OpenTofu
  signifies a collective commitment to fostering truly open collaboration and
  innovation." **Yevgeniy Brikman** (Gruntwork co-founder): "Essential building
  blocks of the modern Internet must be truly open source."
  ([Linux Foundation: Announcing OpenTofu](https://www.linuxfoundation.org/press/announcing-opentofu))

---

## December 2023 — Mitchell Hashimoto Fully Departs

- **December 2023:** After **more than 11 years**, Mitchell Hashimoto announced
  he was **leaving HashiCorp entirely**, sharing a farewell letter with
  employees. This is distinct from his 2021 step-down from the CTO role.
  ([Mitchell Hashimoto on X](https://x.com/mitchellh/status/1735410621859221931);
  [HashiCorp: Mitchell reflects as he departs](https://www.hashicorp.com/en/blog/mitchell-reflects-as-he-departs-hashicorp);
  [The Register: co-founder leaves company](https://www.theregister.com/2023/12/15/hashimoto_departs_hashicorp/))

---

## January 2024 — OpenTofu General Availability

- **January 10, 2024:** The OpenTofu community announced **GA of OpenTofu 1.6**,
  a production-ready Linux Foundation project, after roughly **four months of
  development** across "over five dozen developers." It offered a documented
  migration path for Terraform users (largely a drop-in replacement at the
  forked version).
  ([Linux Foundation: OpenTofu Announces General Availability](https://www.linuxfoundation.org/press/opentofu-announces-general-availability);
  [Linux Foundation: OpenTofu RC out, GA set for Jan 10](https://www.linuxfoundation.org/blog/opentofu-release-candidate-is-out))
- Corporate backers cited at GA included **Cloudflare, Buildkite, GitLab, and
  Oracle**; CNCF CTO **Chris Aniszczyk** praised "its first stable release after
  only a few short months."
  ([Linux Foundation: OpenTofu Announces General Availability](https://www.linuxfoundation.org/press/opentofu-announces-general-availability))

---

## ~September 2023 / 2024 — Registry Terms-of-Service Spat

- HashiCorp updated the **Terraform Registry terms of service** to state that
  downloads of providers, modules, and other content were "solely for use with,
  or in support of, HashiCorp Terraform" — effectively **closing the Registry to
  non-Terraform tools** like OpenTofu.
  ([TechTarget: Terraform Registry TOS change stokes open source ire](https://www.techtarget.com/searchitoperations/news/366555192/Terraform-Registry-TOS-change-stokes-open-source-ire))
- In response, OpenTofu **built its own registry** (the OpenTofu Registry) for
  providers and modules. OpenTofu's founders said they believed the TOS change
  was a deliberate effort to make their project harder to succeed.
  ([OpenTofu: Building the OpenTofu Registry](https://opentofu.org/blog/building-the-opentofu-registry/))

---

## April 2024 — The Cease-and-Desist Fight

- **April 3, 2024:** OpenTofu received a **cease-and-desist letter from
  HashiCorp**, alleging that OpenTofu's implementation of the **`removed`
  block** infringed HashiCorp's copyright — claiming OpenTofu had "repeatedly
  taken code HashiCorp provided only under the Business Source License (BSL) and
  used it in a manner that violates those license terms."
  ([OpenTofu: Our Response to HashiCorp's Cease and Desist](https://opentofu.org/blog/our-response-to-hashicorps-cease-and-desist/);
  [Futurum: Deep Dive into the HashiCorp/OpenTofu dispute](https://futurumgroup.com/insights/a-deep-dive-into-the-hashicorp-and-opentofu-dispute/))
- **OpenTofu's public rebuttal:** The team called the claims "completely
  unsubstantiated," publishing a detailed **Source Code Origin (SCO) analysis**
  arguing the disputed code was **copied from older MPL-2.0 code** — and that
  *"HashiCorp seems to have copied the same code itself when they implemented
  their version of this feature."* They stated they "vehemently disagree[d] with
  any suggestion that it misappropriated … HashiCorp's BSL code."
  ([OpenTofu response](https://opentofu.org/blog/our-response-to-hashicorps-cease-and-desist/);
  [Slashdot: OpenTofu denies allegations](https://news.slashdot.org/story/24/04/13/0422200/the-linux-foundations-opentofu-project-denies-hashicorps-allegations-of-code-theft))
- **OpenTofu's counter-warning:** OpenTofu's lawyers suggested the reverse risk
  — that HashiCorp's incorporation of MPL-2.0-origin code into BSL-licensed
  Terraform files could itself violate the MPL-2.0.
  ([OpenTofu response](https://opentofu.org/blog/our-response-to-hashicorps-cease-and-desist/);
  [DevOps.com: OpenTofu denies code-stealing accusations](https://devops.com/opentofu-denies-hashicorps-code-stealing-accusations/))
- Commentary was mixed. **InfoWorld** ran a skeptical opinion piece, "OpenTofu
  may be showing us the wrong way to fork," reflecting that not all observers
  sided fully with OpenTofu.
  ([InfoWorld](https://www.infoworld.com/article/2336694/opentofu-may-be-showing-us-the-wrong-way-to-fork.html))
- The Hacker News thread on OpenTofu's response is a primary record of community
  sentiment at the time.
  ([Hacker News thread](https://news.ycombinator.com/item?id=40003692))

---

## April 2024 — IBM Acquires HashiCorp

- **April 24, 2024:** **IBM announced a definitive agreement to acquire
  HashiCorp** for **$35.00 per share in cash**, an **enterprise value of ~$6.4
  billion**.
  ([IBM Newsroom: IBM to Acquire HashiCorp](https://newsroom.ibm.com/2024-04-24-IBM-to-Acquire-HashiCorp-Inc-Creating-a-Comprehensive-End-to-End-Hybrid-Cloud-Platform);
  [HashiCorp 8-K exhibit 99.1 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312524114310/d804229dex991.htm))
- Quotes from the announcement: **Arvind Krishna** (IBM Chairman/CEO):
  "Combining IBM's portfolio and expertise with HashiCorp's capabilities will
  create a comprehensive hybrid cloud platform designed for the AI era."
  **Armon Dadgar** (HashiCorp co-founder/CTO): "I'm incredibly excited … to be
  joining IBM to accelerate HashiCorp's mission." **Dave McJannet** (HashiCorp
  CEO): IBM is "the ideal home for HashiCorp as we enter the next phase of our
  growth journey."
  ([IBM Newsroom](https://newsroom.ibm.com/2024-04-24-IBM-to-Acquire-HashiCorp-Inc-Creating-a-Comprehensive-End-to-End-Hybrid-Cloud-Platform))
- The deal was positioned to drive synergies across **Red Hat, watsonx, data
  security, IT automation, and Consulting**.
  ([IBM Newsroom](https://newsroom.ibm.com/2024-04-24-IBM-to-Acquire-HashiCorp-Inc-Creating-a-Comprehensive-End-to-End-Hybrid-Cloud-Platform))
- The acquisition **closed in early 2025** for ~$6.4 billion.
  ([ITdaily: IBM completes HashiCorp acquisition](https://itdaily.com/news/business/ibm-deal-with-hashicorp/);
  [TechRepublic: IBM completes HashiCorp acquisition](https://www.techrepublic.com/article/ibm-hashicorp-acquisition-completed/))

---

## Positioning: Terraform vs Pulumi vs CloudFormation/CDK

*(This is competitive/analyst framing, not a single dated event; sourced to
comparison write-ups.)*

- **Terraform** — declarative, uses **HCL**, the de-facto multi-cloud standard
  with the largest provider ecosystem (thousands of providers). Strength:
  ecosystem maturity and multi-cloud breadth.
  ([Naviteq: IaC tools comparison](https://www.naviteq.io/blog/choosing-the-right-infrastructure-as-code-tools-a-ctos-guide-to-terraform-pulumi-cdk-and-more/);
  [Firefly: Pulumi vs Terraform vs CloudFormation](https://www.firefly.ai/academy/pulumi-vs-terraform-vs-cloudformation-which-iac-tool-is-best-for-your-infrastructure))
- **Pulumi** — challenges the declarative-DSL model by letting you define
  infrastructure in **general-purpose languages** (TypeScript, Python, Go, C#,
  Java). Notably, Pulumi's CEO was a vocal critic of HashiCorp's BSL move (see
  August 2023 backlash).
  ([GitGuardian: Pulumi vs Terraform](https://blog.gitguardian.com/pulumi-v-s-terraform-the-definitive-guide-to-choosing-your-iac-tool/);
  [The Register, Aug 2023](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/))
- **AWS CloudFormation / CDK** — AWS-native. CloudFormation is declarative;
  **CDK** lets developers write AWS infrastructure in familiar languages that
  **synthesize down to CloudFormation templates**. Positioned as "AWS-first,
  developer-friendly" but AWS-only, versus Terraform's multi-cloud reach.
  ([StackGen: Terraform vs Pulumi vs CDK](https://stackgen.com/blog/terraform-vs-pulumi-vs-cdk);
  [Firefly comparison](https://www.firefly.ai/academy/pulumi-vs-terraform-vs-cloudformation-which-iac-tool-is-best-for-your-infrastructure))

---

## Verification of the specific claim: "HashiCorp threatening the deprecation of the AWS provider"

**Could not verify.** I searched extensively for any real event in which
HashiCorp threatened to deprecate, abandon, or end support for the **Terraform
AWS provider** (or for HashiCorp/AWS tension producing such a threat). Queries
included variants of: "HashiCorp threatening deprecation AWS provider," "AWS
provider maintenance mode / end support controversy," "HashiCorp end official
support Terraform AWS provider abandon / AWS takes over maintenance," and
"deprecate AWS provider OpenTofu fork community fears."

What the evidence actually shows is the **opposite trajectory**:
- The AWS provider is **actively, jointly maintained by HashiCorp and AWS**,
  hit its **10-year anniversary in 2024**, surpassed **3–4 billion downloads**,
  and shipped a major **6.0 GA in 2025**.
  ([AWS provider 6.0 GA](https://www.hashicorp.com/en/blog/terraform-aws-provider-6-0-now-generally-available);
  [AWS provider tops 4 billion downloads](https://www.hashicorp.com/en/blog/terraform-aws-provider-tops-4-billion-downloads-6-0-now-in-public-beta))
- The only "deprecation" activity I found in the AWS provider is **routine,
  granular deprecation of individual AWS services that AWS itself is sunsetting**
  (e.g., Amazon FinSpace, Glacier standalone service, CodeGuru Reviewer, S3
  Object Lambda, App Runner, WorkMail, Elastic Transcoder, OpsWorks Stacks) —
  normal provider maintenance, not a threat to the provider as a whole.
  ([terraform-provider-aws issue #44717 (FinSpace)](https://github.com/hashicorp/terraform-provider-aws/issues/44717);
  [issue #47161 (App Runner)](https://github.com/hashicorp/terraform-provider-aws/issues/47161);
  [AWS provider v6.0.0 tracking issue #41101](https://github.com/hashicorp/terraform-provider-aws/issues/41101))

**Possible source of the user's recollection (speculative, flagged as such):**
The most likely real events that could be misremembered as "HashiCorp
threatening the AWS provider" are (a) the **BSL relicense** and (b) the
**Registry TOS change** plus the **cease-and-desist to OpenTofu**, all of which
created genuine community fear about HashiCorp restricting the **broader
provider ecosystem and Registry** — but none of which specifically targeted the
AWS provider or threatened its deprecation. If the user has a specific source
(article, talk, tweet) in mind, that would be needed to confirm; **I found no
primary or reputable secondary source asserting a deprecation threat against the
AWS provider.**

---

## Summary of unverifiable / uncertain points

1. **"HashiCorp threatening the deprecation of the AWS provider"** —
   **Could not verify.** No primary or reputable source found; all evidence
   points to active joint HashiCorp/AWS maintenance and growth. See verification
   section above for the full list of searches.
2. **Exact date of Mitchell Hashimoto's CTO step-down** — primary reporting
   places the *CTO-to-IC* announcement in **July 2021** (some secondary sources
   loosely say "December 2021," which appears to conflate it with his **full
   departure in December 2023**). Treated the 2021/2023 split as two distinct
   events.
3. **IBM deal close date** — the **announcement** (April 24, 2024) and ~$6.4B
   value are firmly sourced (IBM Newsroom + SEC 8-K). The **closing** is
   reported by secondary press as **early 2025**; I did not pull the specific
   closing 8-K, so the exact close date is sourced to trade press rather than a
   primary filing.

---

## Key people & teams (chronological)

*(This section traces the people and teams behind HashiCorp/Terraform and
OpenTofu over time. As above, every claim carries an inline source and
unverifiable points are flagged **"Could not verify."")*

### 2010–2012 — The founders meet and start HashiCorp

- **Mitchell Hashimoto** and **Armon Dadgar** met as students at the
  **University of Washington's Paul G. Allen School of Computer Science** and
  co-founded **HashiCorp in 2012**. The company name combines Hashimoto's
  surname with "Corporation."
  ([HashiCorp origin story](https://www.hashicorp.com/en/about/origin-story);
  [Wikipedia: HashiCorp](https://en.wikipedia.org/wiki/HashiCorp))
- In the early years the two co-founders ran the company directly: Hashimoto as
  the **founding CEO** and Dadgar in a co-founder/technical role, with both
  later described as having shifted to **joint CTO** roles to focus on product
  once a professional CEO was hired (see 2016).
  ([Crunchbase: David McJannet](https://www.crunchbase.com/person/david-mcjannet))

### 2016 — Dave McJannet hired as CEO

- **June 2016: Dave McJannet joined HashiCorp as CEO**, taking day-to-day
  leadership so the co-founders could concentrate on product as joint CTOs.
  ([HashiCorp: Dave McJannet bio](https://www.hashicorp.com/en/about/person/dave-mcjannet);
  [Crunchbase: David McJannet](https://www.crunchbase.com/person/david-mcjannet))
  - *Note on date:* the precise month is sourced to secondary aggregators
    (Crunchbase and a DevOps.com announcement headlined "Dave McJannet joins
    HashiCorp as CEO"); HashiCorp's own bio page does not state the month. He
    was already referred to as CEO in press coverage by November 2016.
    ([DiscoPosse interview, Nov 2016](https://discoposse.com/2016/11/30/talking-hashicorp-with-ceo-dave-mcjannet/))
- McJannet's prior background: marketing leadership at **GitHub** and
  **Hortonworks** (which IPO'd in 2014), plus roles at **VMware/SpringSource**
  and **Microsoft**.
  ([HashiCorp: Dave McJannet bio](https://www.hashicorp.com/en/about/person/dave-mcjannet))

### July 2021 — Mitchell Hashimoto steps down as CTO (stays as IC)

- **July 2021:** Mitchell Hashimoto **stepped down from the CTO role to return
  to being an individual contributor**, while remaining at the company. **Armon
  Dadgar continued as CTO.**
  ([The New Stack: Hashimoto on when to step down](https://thenewstack.io/hashicorps-mitchell-hashimoto-on-when-to-step-down-to-the-job-you-love/))
  *(This is distinct from his full departure in December 2023; some secondary
  sources conflate the two — see the "uncertain points" section above.)*

### December 2021 — IPO; leadership at the bell

- **December 8, 2021:** HashiCorp **priced its IPO** at **$80.00/share**
  (15.3M shares, ~$1.22B gross proceeds); **Class A shares began trading on the
  Nasdaq Global Select Market under ticker "HCP" on December 9, 2021**, with the
  offering closing **December 13, 2021**.
  ([GlobeNewswire: HashiCorp Announces Pricing of IPO](https://www.globenewswire.com/news-release/2021/12/09/2348726/0/en/HashiCorp-Announces-Pricing-of-Initial-Public-Offering.html);
  [SEC: HashiCorp 8-K exhibit (FY2021)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312521355378/d199913dex991.htm))
- Leadership through the IPO: **Dave McJannet (CEO)**, **Armon Dadgar
  (co-founder/CTO)**, with **Mitchell Hashimoto** as co-founder and individual
  contributor.
  ([HashiCorp: Dave McJannet bio](https://www.hashicorp.com/en/about/person/dave-mcjannet);
  [HashiCorp: Armon Dadgar bio](https://www.hashicorp.com/en/about/person/armon-dadgar))

### September 2023 — OpenTofu's initiating companies, core team, and governance

- The fork was **initiated by a coalition of commercial Terraform-ecosystem
  vendors** — named in the Linux Foundation launch announcement as
  **Gruntwork, Spacelift, env0, Scalr, Harness, Digger, Terrateam, Massdriver,
  and Terramate**, alongside "140+ organizations and 600+ individuals."
  ([Linux Foundation: Announcing OpenTofu](https://www.linuxfoundation.org/press/announcing-opentofu))
- **Governance model (Linux Foundation stewardship):** OpenTofu is governed by a
  **Technical Steering Committee (TSC)** with "overall responsibility for the
  technical direction and oversight of the project," sitting above a **core
  team** of engineers who review PRs, triage issues, and drive the roadmap. The
  TSC meets regularly and uses supermajority (two-thirds) votes for major
  decisions; the structure is explicitly designed so **no single company
  controls direction**.
  ([OpenTofu org GOVERNANCE.md](https://github.com/opentofu/org/blob/main/GOVERNANCE.md);
  [OpenTofu FAQ](https://opentofu.org/faq/))
- The **TSC is composed of representatives of the companies contributing
  engineering resources** — reported as **Harness, Spacelift, Scalr, Gruntwork,
  and env0** — and the **core team is led by technical lead Christian Mesh**.
  ([Spacelift: Two Million — and Three — Things to Celebrate](https://spacelift.io/blog/two-million-and-three-things-to-celebrate-in-the-opentofu-community);
  [SE Radio 652: Christian Mesh on OpenTofu](https://se-radio.net/2025/01/se-radio-652-christian-mesh-on-opentofu/))
  - *Note:* the named individual (Christian Mesh) and the exact company roster of
    the TSC are sourced to secondary material (a Spacelift community post and an
    SE Radio interview with Mesh); the primary `GOVERNANCE.md` defines the
    structure but does not list current members by name.

### December 2023 — Mitchell Hashimoto fully departs HashiCorp

- **December 2023:** Mitchell Hashimoto **left HashiCorp entirely** after more
  than 11 years (see fuller entry above).
  ([Mitchell Hashimoto on X](https://x.com/mitchellh/status/1735410621859221931);
  [HashiCorp: Mitchell reflects as he departs](https://www.hashicorp.com/en/blog/mitchell-reflects-as-he-departs-hashicorp))
- **What he did next:** Hashimoto turned to **desktop software**, building
  **Ghostty**, an open-source, GPU-accelerated terminal emulator written in the
  **Zig** programming language. He announced **Ghostty 1.0 would ship in
  December 2024**, and **Ghostty 1.0 was released on December 26, 2024**.
  ([Mitchell Hashimoto: "Ghostty 1.0 is Coming"](https://mitchellh.com/writing/ghostty-is-coming);
  [Mitchell Hashimoto: Ghostty project page](https://mitchellh.com/ghostty);
  [Mitchell Hashimoto: Reflecting on Reaching 1.0](https://mitchellh.com/writing/ghostty-1-0-reflection))

### April 2024 → February 2025 — IBM acquisition and leadership

- **April 24, 2024:** IBM announced the agreement to acquire HashiCorp
  (~$6.4B, $35.00/share). At announcement, **Armon Dadgar (co-founder/CTO)** and
  **Dave McJannet (CEO)** both issued supportive statements (quoted in the IBM
  acquisition entry above).
  ([IBM Newsroom: IBM to Acquire HashiCorp](https://newsroom.ibm.com/2024-04-24-IBM-to-Acquire-HashiCorp-Inc-Creating-a-Comprehensive-End-to-End-Hybrid-Cloud-Platform))
- **February 27, 2025:** **IBM completed the acquisition** for an enterprise
  value of ~$6.4 billion. In IBM's completion announcement, **Dave McJannet
  (CEO)** and **Armon Dadgar (co-founder/CTO)** again provided statements,
  indicating both were continuing in leadership as HashiCorp became an IBM
  company, with the products folded into IBM's automation/hybrid-cloud portfolio
  (alongside Red Hat).
  ([IBM Newsroom: IBM Completes Acquisition of HashiCorp](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform))
- The **HashiCorp brand was retained** as "HashiCorp, An IBM Company," and the
  HashiCorp site continues to operate under that identity.
  ([HashiCorp: Armon Dadgar bio ("An IBM Company")](https://www.hashicorp.com/en/about/person/armon-dadgar))

### March 2026 — Armon Dadgar steps down

- **Late March 2026:** Co-founder **Armon Dadgar announced he was leaving
  HashiCorp**, his last day being a Friday in late March 2026 (reported as
  **March 27/28, 2026**), about **13 years after co-founding the company** and
  roughly a year after the IBM deal closed. He framed it as a chance to **"pause
  and recharge,"** saying he had **"no immediate plans for what comes next"** and
  planned to rest, travel over the summer, and **move from Seattle to New York
  City**.
  ([SDxCentral: Armon Dadgar steps down to "pause and recharge"](https://www.sdxcentral.com/news/hashicorp-co-founder-and-cto-armon-dadgar-steps-down-to-pause-and-recharge/);
  [GeekWire: Tech Moves — HashiCorp CTO resigns](https://www.geekwire.com/2026/tech-moves-c-suite-exec-leaves-microsoft-for-alaska-airlines-amazon-leaders-depart-hashicorp-cto-resigns/);
  [Armon Dadgar LinkedIn: "This Friday is my last day at HashiCorp"](https://www.linkedin.com/posts/armon-dadgar_this-friday-is-my-last-day-at-hashicorp-activity-7444405653940596736-s7sO))
  - *Note:* the **exact last-day date** is given only as "this Friday"/"late
    March 2026" in the sources reviewed; the specific calendar date is **not
    pinned to a primary statement** beyond "Friday." Treat **March 27/28, 2026**
    as approximate.
- With Dadgar's exit, **both co-founders had now left** the company they
  founded (Hashimoto in Dec 2023; Dadgar in Mar 2026). **Dave McJannet remained
  CEO** of HashiCorp (as an IBM company); reporting around Dadgar's departure
  also noted **Satyan Nair** joining as a new **field CTO**.
  ([SDxCentral: Armon Dadgar steps down](https://www.sdxcentral.com/news/hashicorp-co-founder-and-cto-armon-dadgar-steps-down-to-pause-and-recharge/);
  [GeekWire: HashiCorp CTO resigns](https://www.geekwire.com/2026/tech-moves-c-suite-exec-leaves-microsoft-for-alaska-airlines-amazon-leaders-depart-hashicorp-cto-resigns/))
  - *Could not fully verify:* whether **Satyan Nair's "field CTO" role directly
    replaces** Dadgar's co-founder/CTO function, or the exact title hierarchy
    post-departure — sourced only to trade-press summaries (SDxCentral/GeekWire),
    not to a primary HashiCorp/IBM announcement.

### People & teams — summary of unverifiable / uncertain points

1. **Dave McJannet's exact start month (June 2016)** — sourced to Crunchbase and
   a DevOps.com announcement, not to a primary HashiCorp statement; HashiCorp's
   bio page omits the month. Confirmed as CEO by Nov 2016.
2. **OpenTofu TSC named members / Christian Mesh as technical lead** — the
   governance *structure* is primary-sourced (OpenTofu `GOVERNANCE.md`), but the
   *named* individuals and current company roster are from secondary sources
   (Spacelift post, SE Radio interview).
3. **Armon Dadgar's exact last day (March 2026)** — sources say "this
   Friday"/"late March 2026"; the precise calendar date (March 27/28) is
   approximate.
4. **Satyan Nair's role relative to Dadgar's** — "field CTO" per trade press; not
   confirmed against a primary HashiCorp/IBM announcement.

---

## Company & corporate history (chronological)

*(This section traces HashiCorp as a **business/legal entity** — funding,
valuations, revenue, headcount, HQ, IPO, M&A, and the licensing/business-model
pivots — distinct from the "Key people & teams" section above. As elsewhere,
every claim carries an inline source URL and unverifiable points are flagged
**"Could not verify."")*

### 2012 — Founding and legal entity

- **HashiCorp, Inc.** was founded in **2012** by **Mitchell Hashimoto** and
  **Armon Dadgar**, and is **headquartered in San Francisco, California**. The
  company sells infrastructure-automation software under an **open-core model**:
  free open-source/community editions of its tools alongside paid Enterprise and
  hosted-cloud editions.
  ([HashiCorp origin story](https://www.hashicorp.com/en/about/origin-story);
  [Wikipedia: HashiCorp](https://en.wikipedia.org/wiki/HashiCorp))
- HashiCorp's SEC filings are made under **CIK 0001720671** as **HashiCorp,
  Inc.**
  ([HashiCorp S-1, FY2021 (SEC EDGAR)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312521319849/d205906ds1.htm))

### The open-core product portfolio (business-model context)

- By the time of its 2017 Series C, HashiCorp described **six primary
  open-source tools** — **Vagrant, Packer, Terraform, Vault, Consul, and
  Nomad** — that were "downloaded thousands of times per day and … broadly
  adopted by the Global 2000," monetized via **enterprise editions** that "enhance
  the open source tools with features that promote collaboration, operations,
  governance, and multi-data center functionality." This dual open-source +
  Enterprise (and later hosted **HashiCorp Cloud Platform / HCP**) structure is
  the **open-core business model** at the heart of the company.
  ([GlobeNewswire: HashiCorp Raises $40 Million (Series C)](https://www.globenewswire.com/news-release/2017/10/24/1219041/0/en/HashiCorp-Raises-40-Million-to-Meet-Demand-for-Cloud-Infrastructure-Automation.html))
  - *Later additions to the portfolio:* **Boundary** and **Waypoint** joined the
    product line and are both named among the products later relicensed (see the
    Aug 2023 BSL entry).
    ([HashiCorp adopts BSL](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license))

### Venture funding rounds (Series A–E)

- **Series A — Dec 10, 2014 — ~$10M.** HashiCorp's first institutional round; the
  Series A is associated with **GGV Capital's** first investment in the company.
  ([Tracxn: HashiCorp funding & investors](https://tracxn.com/d/companies/hashicorp/__jKwBJFQRuQVsngXwM7j5GFJTnZICd9WRr531LGxBZhA/funding-and-investors))
  - *Could not verify (primary):* exact Series A size/date are sourced to funding
    aggregators (Tracxn/Crunchbase), not a primary HashiCorp press release.
- **Series B — Sept 7, 2016 — $24M**, led by **GGV Capital**, with **Mayfield,
  True Ventures, and Redpoint** participating.
  ([Crunchbase: HashiCorp Series B (2016-09-07)](https://www.crunchbase.com/funding_round/hashicorp-series-b--17e68d3e);
  [PE Hub: HashiCorp scores $24M Series B led by GGV Capital](https://www.pehub.com/3358694/))
- **Series C — Oct 24, 2017 — $40M**, co-led by **GGV Capital and Redpoint**
  (with Mayfield and True Ventures), bringing **total raised to ~$74M**. At this
  point HashiCorp reported **22 million downloads** of its open-source products.
  ([GlobeNewswire: HashiCorp Raises $40 Million](https://www.globenewswire.com/news-release/2017/10/24/1219041/0/en/HashiCorp-Raises-40-Million-to-Meet-Demand-for-Cloud-Infrastructure-Automation.html);
  [GeekWire: HashiCorp raises $40M Series C](https://www.geekwire.com/2017/hashicorp-raises-40m-series-c-round-businesses-realize-need-help-cloud/))
- **Series D — Nov 2018 — $100M at a ~$1.9B valuation**, making HashiCorp a
  **cloud "unicorn."** **IVP** and **Bessemer Venture Partners** are associated
  with first investments in this round.
  ([GeekWire: HashiCorp raises $100M, becomes newest cloud unicorn at $1.9B](https://www.geekwire.com/2018/hashicorp-raises-100m-becomes-newest-cloud-unicorn-valuation-1-9b/);
  [Tracxn: HashiCorp funding & investors](https://tracxn.com/d/companies/hashicorp/__jKwBJFQRuQVsngXwM7j5GFJTnZICd9WRr531LGxBZhA/funding-and-investors))
- **Series E — Mar 16, 2020 — $175M at a $5.1B valuation**, **led by Franklin
  Templeton**, with **funds and accounts advised by T. Rowe Price Associates**
  and **Geodesic Capital**, plus existing investors **GGV Capital, IVP, Mayfield,
  Redpoint Ventures, and True Ventures**. The release stated HashiCorp had
  achieved **over 100% year-over-year revenue growth for four consecutive years**
  and that **more than 100 Fortune 500 companies** were deploying its commercial
  products.
  ([GlobeNewswire: HashiCorp Raises $175 Million in Series E](https://www.globenewswire.com/news-release/2020/03/16/2001541/0/en/HashiCorp-Raises-175-Million-in-Series-E-Funding-to-Support-Multi-Cloud-Transformation-for-Global-Enterprises.html);
  [TechCrunch: HashiCorp soars above $5B valuation in new $175M round](https://techcrunch.com/2020/03/16/hashicorp-soars-above-5b-valuation-in-new-175m-venture-round/))
  - *Funding totals:* aggregators put **total venture funding at roughly
    $349M across five rounds** prior to the IPO.
    ([Tracxn: HashiCorp funding & investors](https://tracxn.com/d/companies/hashicorp/__jKwBJFQRuQVsngXwM7j5GFJTnZICd9WRr531LGxBZhA/funding-and-investors))

### Revenue / ARR milestones

- The Series E release (Mar 2020) cited **100%+ YoY revenue growth for four
  consecutive years** — placing HashiCorp on a steep pre-IPO growth curve.
  ([GlobeNewswire: Series E](https://www.globenewswire.com/news-release/2020/03/16/2001541/0/en/HashiCorp-Raises-175-Million-in-Series-E-Funding-to-Support-Multi-Cloud-Transformation-for-Global-Enterprises.html))
- **Fiscal 2021 revenue: $211.9M.** **Fiscal 2022 revenue: $320.8M** (up 51%).
  **Fiscal 2023 revenue: $475.9M** (up 48%). (HashiCorp's fiscal year ends
  January 31, so "FY2023" ends Jan 31, 2023.)
  ([HashiCorp 8-K, Q4 FY2022 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000095017022011078/hcp-ex99_1.htm);
  [HashiCorp 8-K, Q4 FY2023 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000162828023007289/hcp-q4fy23xex991.htm))
- **High-value customers** (≥$100K ARR) grew from **655** at end of FY2022 to
  **798** at end of FY2023, reflecting enterprise traction underpinning the
  open-core model.
  ([HashiCorp 8-K, Q4 FY2023 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000162828023007289/hcp-q4fy23xex991.htm))
  - *Could not verify (precise figure):* the often-quoted **~$294.9M "implied
    ARR" at the time of the S-1** is reported by secondary analysis (e.g.,
    Meritech) summarizing the S-1; treat the exact ARR number as
    secondary-sourced.
    ([Meritech: HashiCorp IPO S-1 Breakdown](https://web.archive.org/web/2id_/https://www.meritechcapital.com/blog/hashicorp-ipo-s-1-breakdown))

### Headcount growth

- HashiCorp's IPO-era S-1 / coverage put headcount at **~1,650 employees** around
  the **2021 IPO**, distributed across the US, Canada, Australia, India, and
  Europe.
  ([HashiCorp S-1, FY2021 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312521319849/d205906ds1.htm))
- By **January 31, 2024** headcount was reported at roughly **2,200 employees**.
  ([stockanalysis.com: HashiCorp employees](https://stockanalysis.com/stocks/hcp/employees/))
  - *Could not verify (primary):* the ~2,200 figure is from a financial-data
    aggregator, not pulled directly from the corresponding 10-K; treat as
    approximate.

### December 2021 — IPO (Nasdaq: HCP)

- **December 8, 2021:** HashiCorp **priced its IPO at $80.00/share** (15,300,000
  Class A shares), for **gross proceeds of ~$1.22 billion**. Lead book-running
  managers were **Morgan Stanley, Goldman Sachs, and J.P. Morgan**.
  ([GlobeNewswire: HashiCorp Announces Pricing of IPO](https://www.globenewswire.com/news-release/2021/12/09/2348726/0/en/HashiCorp-Announces-Pricing-of-Initial-Public-Offering.html);
  [HashiCorp 8-K, FY2021 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312521355378/d199913dex991.htm))
- **December 9, 2021:** **Class A shares began trading on the Nasdaq Global
  Select Market under ticker "HCP."** The stock opened at **$81.16** and closed
  its first day at **$85.19** (up ~6.5% from the $80 offer price). Based on the
  offering price, the IPO **valued HashiCorp at over ~$14 billion** — one of the
  largest software IPOs of 2021. The offering **closed December 13, 2021.**
  ([CNBC: HashiCorp shares rise after one of top software IPOs of 2021, values company at over $14 billion](https://www.cnbc.com/2021/12/09/cloud-software-maker-hashicorp-hcp-starts-trading-on-nasdaq.html);
  [HashiCorp 8-K, FY2021 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312521355378/d199913dex991.htm))
  - *Note:* the ~$14B figure is a **market-capitalization calculation** reported
    by trade press (CNBC), not a number stated in the SEC filings themselves; the
    filings confirm only the share count, $80 price, and ~$1.22B gross proceeds.

### August 2023 — BSL relicense as a business decision

- **August 10, 2023:** As a deliberate **value-capture / business-model
  decision**, HashiCorp **relicensed all of its core products** from MPL-2.0 to
  the **Business Source License (BSL/BUSL) v1.1** for all **future releases** —
  **not just Terraform**. The products named across HashiCorp's own materials
  include **Terraform, Vault, Consul, Nomad, Boundary, Waypoint, Packer, and
  Vagrant**; only **APIs, SDKs, and almost all other libraries remained
  MPL-2.0.**
  ([HashiCorp adopts Business Source License](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license);
  [GlobeNewswire: HashiCorp adopts the BSL](https://www.globenewswire.com/en/news-release/2023/08/10/2723189/0/en/HashiCorp-adopts-the-Business-Source-License-for-future-releases-of-its-products.html))
- **The business rationale (verbatim):** HashiCorp argued that "there are other
  vendors who take advantage of pure OSS models, and the community work on OSS
  projects, for their own commercial goals, without providing material
  contributions back," and that "Open source has reduced the barrier to copying
  innovation and selling it through existing distribution channels." The BSL's
  **non-compete restriction** — barring vendors of "competitive services" from
  using future releases — was the mechanism for HashiCorp to **capture more of the
  commercial value** of its software against competitors.
  ([HashiCorp adopts BSL](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license))
  - *(See the "August 2023 — The BSL Relicense" section above for the full
    licensing/community-fallout treatment and the OpenTofu fork it triggered.
    This entry frames the same event specifically as a corporate value-capture
    move.)*

### April 2024 → February 2025 — IBM acquisition (~$6.4B)

- **April 24, 2024:** **IBM announced a definitive agreement to acquire
  HashiCorp** for **$35.00 per share in cash**, an **enterprise value of ~$6.4
  billion** — a markdown from HashiCorp's ~$14B IPO valuation, reflecting the
  broader software-multiple reset since 2021.
  ([IBM Newsroom: IBM to Acquire HashiCorp](https://newsroom.ibm.com/2024-04-24-IBM-to-Acquire-HashiCorp-Inc-Creating-a-Comprehensive-End-to-End-Hybrid-Cloud-Platform);
  [HashiCorp 8-K exhibit 99.1 (SEC)](https://www.sec.gov/Archives/edgar/data/0001720671/000119312524114310/d804229dex991.htm))
- **February 27, 2025:** **IBM completed the acquisition** at the ~$6.4B
  enterprise value, folding HashiCorp's products into IBM's automation/hybrid-cloud
  portfolio (alongside Red Hat).
  ([IBM Newsroom: IBM Completes Acquisition of HashiCorp](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform))

### Current status — a HashiCorp, An IBM Company

- HashiCorp now operates as **"HashiCorp, An IBM Company,"** retaining its brand
  while owned by IBM; both co-founders have since departed (Hashimoto Dec 2023,
  Dadgar Mar 2026), with **Dave McJannet** continuing as CEO. (See "Key people &
  teams" above for leadership detail.)
  ([HashiCorp: Armon Dadgar bio ("An IBM Company")](https://www.hashicorp.com/en/about/person/armon-dadgar);
  [IBM Newsroom: IBM Completes Acquisition of HashiCorp](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform))

### Corporate history — summary of unverifiable / uncertain points

1. **Series A size/date (~$10M, Dec 2014)** — sourced to funding aggregators
   (Tracxn/Crunchbase), not a primary HashiCorp press release. **Could not
   verify** against a primary source.
2. **Series D investor specifics ($100M, ~$1.9B, Nov 2018)** — the amount and
   valuation are firmly reported (GeekWire); the precise lead/syndicate is
   partly from aggregators.
3. **~$14B IPO valuation** — a **market-cap calculation** reported by trade press
   (CNBC), not stated in the SEC filings (which confirm only share count, $80
   price, ~$1.22B gross proceeds).
4. **~$294.9M implied ARR at S-1** and **~2,200 FY2024 headcount** — both
   secondary-sourced (Meritech analysis; stockanalysis.com), not pulled directly
   from the underlying SEC filings; treat as approximate.
