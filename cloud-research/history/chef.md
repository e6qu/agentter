# A Chronological History of Chef (Opscode → Chef → Progress)

Focus: cloud-API integration and the controversies — especially the April 2019
"100% open source" relicensing and the September 2019 ICE/CBP contract episode
involving Seth Vargo and `chef-sugar`.

> **Sourcing note.** Every factual claim below carries an inline link to a
> primary or reputable secondary source. Where a claim could only be partially
> confirmed, or where sources conflict, it is flagged explicitly. Reported
> claims (e.g., what an individual said about their own motives) are attributed
> to the source rather than stated as bare fact.

---

## 2008 — Founding as Opscode

- Chef the tool was created by **Adam Jacob** as an internal tool for his
  infrastructure consultancy. The company **Opscode** was founded in 2008 by
  **Adam Jacob, Jesse Robbins, Barry Steinglass, Nathen Haneysmith** (and,
  per Wikipedia, **Joshua Timberman**). Founding CEO was Jesse Robbins, a former
  Amazon operations leader whose internal title was "Master of Disaster."
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef);
  [Chef blog: "Opscode Announces $2.5 Million in Series A Round"](https://www.chef.io/blog/opscode-announces-2-5-million-in-series-a-round))

- **Naming:** The project was originally called **"marionette,"** but the name
  was considered "too long and cumbersome to type." Because the configuration
  modules were called **"recipes"** (grouped into **"cookbooks"**), the project
  was renamed **"Chef."**
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

- **The technology / agent model.** Chef is a configuration-management tool
  written in **Ruby** (with a later Erlang server core) that uses a pure-Ruby
  **domain-specific language (DSL)** for writing system-configuration
  "recipes." It uses a **client/server agent model**: an agent (`chef-client`)
  runs on each managed node and converges the node to the state declared in
  recipes, pulling from a central Chef server.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

## January 2009 — Chef released; Series A

- Chef was first **released in January 2009**.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))
- In **April 2009**, Opscode closed a **$2.5M Series A** led by Draper Fisher
  Jurvetson.
  ([Chef blog: "Opscode Announces $2.5 Million in Series A Round"](https://www.chef.io/blog/opscode-announces-2-5-million-in-series-a-round))

## 2013 — Erlang server rewrite (Chef 11)

- In **February 2013**, Opscode released **Chef 11**, featuring "a complete
  rewrite of the core API server in Erlang."
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

## Cloud-API integration: knife plugins and the fog era

- Chef provisioned and bootstrapped cloud resources primarily through
  **`knife` cloud plugins** — `knife` being Chef's command-line tool. The cloud
  plugins ship as RubyGems and are installed into Chef Workstation.
  Chef-maintained plugins include **`knife-ec2`** (AWS EC2), **`knife-azure`**
  (Microsoft Azure), **`knife-google`** (Google Cloud), plus `knife-openstack`,
  `knife-rackspace`, `knife-vcenter`, and others.
  ([Chef docs: Knife Cloud Plugins](https://docs.chef.io/workstation/knife/);
  [chef/knife-ec2 on GitHub](https://github.com/chef/knife-ec2))

- **The fog/boto era.** These plugins talked to cloud provider APIs through
  Ruby cloud-abstraction libraries — notably the **`fog`** gem family.
  For example, `knife-ec2` depends on the **`fog-aws`** gem to drive the EC2
  API. (Python's `boto` played the analogous role in the Python ecosystem;
  Chef's own plugins were Ruby/`fog`-based.)
  ([chef/knife-ec2 on GitHub](https://github.com/chef/knife-ec2);
  O'Reilly, ["Knife EC2 plugin," *Mastering Chef Provisioning*](https://www.oreilly.com/library/view/mastering-chef-provisioning/9781785888915/ch02s05.html))

- `knife-azure` evolved alongside Azure's own API generations: commands
  prefixed `knife azure` use the older **Azure Service Management API**, while
  `knife azurerm` (from `knife-azure` 1.6.0+) uses the newer **Azure Resource
  Manager API**.
  ([Chef docs: Knife Azure](https://docs-acceptance.chef.io/workstation/knife_azure/))

## 2015 — Funding peak and an acquisition

- In **September 2015**, Chef was **valued at $360M** after a **$40M** venture
  round.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))
- In **November 2015**, Opscode/Chef acquired the German security startup
  **VulcanoSec** (work that fed into Chef's **InSpec** compliance tooling).
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

## July 2016 — Chef Automate

- At **ChefConf 2016 (July)**, Chef released **Chef Automate**, adding
  continuous-deployment pipelines with compliance and security testing.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

---

## April 2, 2019 — The "100% open source" relicensing (Apache 2.0)

On **April 2, 2019**, Chef announced it was moving **100% of its software to the
Apache 2.0 license** — eliminating prior restrictions on the use, distribution,
or monetization of the source code, subject to respecting Chef's trademark
policy.
([DevClass: "Chef says it's going 100% open source, forks optional…" (Apr 2, 2019)](https://devclass.com/2019/04/02/chef-says-its-going-100-open-source-forks-optional/);
[InfoQ: "Infrastructure Automation Company Chef Commits to Open Source"](https://www.infoq.com/news/2019/05/chef-open-source/))

Key elements of the new model:

- **Source open, distributions commercial.** While *all source code* became
  Apache 2.0, Chef simultaneously introduced the **Chef Enterprise Automation
  Stack** — a commercial distribution "licensed and tailored exclusively for
  commercial customers," bundling **Chef Workstation, Habitat, Infra, and
  InSpec**. Production use of the commercial *distributions* still required a
  paid subscription, governed by the **Chef EULA**, even though the underlying
  projects stayed Apache 2.0.
  ([DevClass (Apr 2, 2019)](https://devclass.com/2019/04/02/chef-says-its-going-100-open-source-forks-optional/);
  [Chef docs: About Chef Licenses](https://docs-acceptance.chef.io/chef_license/))

- **Explicitly a "Red Hat–style" model** — develop in the open, attach
  enterprise terms to the packaged distribution.
  ([DevClass (Apr 2, 2019)](https://devclass.com/2019/04/02/chef-says-its-going-100-open-source-forks-optional/))

- **Forks welcomed (officially).** Chef said: *"It is absolutely possible that
  there will be derivative branches of Chef's projects and we look forward to
  welcoming them into our communities."*
  ([DevClass (Apr 2, 2019)](https://devclass.com/2019/04/02/chef-says-its-going-100-open-source-forks-optional/))

- **Community reaction / the Cinc fork.** Because Chef's *binaries* now required
  commercial terms while the *source* was Apache 2.0, the community responded by
  creating the **Cinc** project, which builds and distributes fully
  Apache-2.0-licensed binaries from Chef's source (a "distro" of Chef without
  the trademarks or commercial EULA).
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

---

## July 2019 — Adam Jacob steps down as CTO

- In **2019**, co-founder and CTO **Adam Jacob announced he was stepping down**
  from his active CTO role after roughly a decade, while **remaining on the
  board of directors** as an advisor; he framed it as taking a break (e.g.,
  walking his kid to school).
  ([GeekWire: "Chef co-founder and CTO Adam Jacob stepping down, will remain on board of directors"](https://www.geekwire.com/2019/chef-co-founder-cto-adam-jacob-stepping-will-remain-board-directors/))
- Chef named a new CTO, **Corey Scobie**, to succeed Jacob — the same Corey
  Scobie who would later figure in the `chef-sugar` restoration episode.
  ([GeekWire: "Chef names new CTO to succeed its co-founder…"](https://www.geekwire.com/2019/chef-names-new-cto-succeed-co-founder-eyes-broader-market-enterprise-automation/))

> **Could not fully verify the exact month.** Reporting clusters this around
> 2019; one search summary ambiguously referenced both January and July 2019 for
> the announcement. The GeekWire article above is the primary source, but the
> precise month was not pinned down in the material gathered. Flagged as
> **partially verified: exact date of Adam Jacob's CTO departure announcement.**

---

## September 2019 — The ICE / CBP contract controversy

This is the episode the research most needed to nail down. The verified
sequence:

### The contract

- Chef held a software/development-tools contract with **U.S. Immigration and
  Customs Enforcement (ICE)** reported at roughly **$95,000**, plus a contract
  with **Customs and Border Protection (CBP)**. Reporting indicates the work
  originated **in 2015** (under the Obama administration) to modernize
  Department of Homeland Security software practices.
  ([GeekWire: "Tech company Chef won't renew U.S. immigration contracts…"](https://www.geekwire.com/2019/tech-company-chef-wont-renew-u-s-immigration-contracts-changing-course-amid-employee-activism/);
  [TechCrunch: "Chef CEO does an about face, says company will not renew ICE contract" (Sep 23, 2019)](https://techcrunch.com/2019/09/23/chef-ceo-does-an-about-face-says-company-will-not-renew-ice-contract/);
  [FedScoop: "After protest, open source software company Chef will let ICE contract expire"](https://fedscoop.com/protest-open-source-software-company-chef-will-let-ice-contract-expire/))

### Seth Vargo deletes `chef-sugar` (≈ Sep 19, 2019)

- **Seth Vargo**, a **former Chef employee**, authored an open-source add-on to
  Chef called **`chef-sugar`** (a library of Ruby helpers/syntactic sugar for
  Chef recipes). Per his own account, the code lived on his **personal** GitHub
  and RubyGems accounts.
  ([Vice/Motherboard: "'Everyone Should Have a Moral Code' Says Developer Who Deleted Code Sold to ICE" (Sep 20, 2019)](https://www.vice.com/en_us/article/mbm3xn/chef-sugar-author-deletes-code-sold-to-ice-immigration-customs-enforcement);
  [TechCrunch: "Programmer who took down open-source pieces over Chef ICE contract responds" (Sep 23, 2019)](https://techcrunch.com/2019/09/23/programmer-who-took-down-open-source-pieces-over-chef-ice-contract-responds/))

- **Reported trigger (attributed to Vargo).** Vargo said he learned of Chef's
  ICE work via a tweet (from the account **@shanley**) on **September 19, 2019**,
  and verified it against U.S. federal spending records.
  ([TechCrunch (Sep 23, 2019)](https://techcrunch.com/2019/09/23/programmer-who-took-down-open-source-pieces-over-chef-ice-contract-responds/))

- **Vargo's stated motive (his words, attributed):**
  *"I was having trouble sleeping at night knowing that software—code that I
  personally authored—was being sold to and used by such a vile organization."*
  He said he reached out to Chef and, *"After 72 hours without a response,"*
  concluded the company would not acknowledge the partnership, and then
  **deleted `chef-sugar` from GitHub and RubyGems**.
  ([Vice/Motherboard (Sep 20, 2019)](https://www.vice.com/en_us/article/mbm3xn/chef-sugar-author-deletes-code-sold-to-ice-immigration-customs-enforcement))

### The breakage

- Because `chef-sugar` was a transitive dependency in many customers' Chef code,
  its removal from RubyGems broke builds. Per Chef's CEO, the deletion caused
  **"customer downtime"** and affected **"production systems for a number of
  [Chef] customers."**
  ([Vice/Motherboard: "Company That Provides Tech to ICE Not Renewing Contract After Code-Deletion Protest"](https://www.vice.com/en/article/chef-not-renewing-ice-immigration-customs-enforcement-contract-after-code-deleting-protest/))

### Restoration of the code — and the Apache-license metadata dispute

- Chef **restored** `chef-sugar` (Chef's position being that the code was
  created during Vargo's employment and was therefore company property; Vargo
  disputed that open-source licenses or his employment obliged him to keep
  maintaining code on his personal accounts).
  ([TechCrunch (Sep 23, 2019)](https://techcrunch.com/2019/09/23/programmer-who-took-down-open-source-pieces-over-chef-ice-contract-responds/))

- **Reported claim (attributed to Vargo):** Chef *"actually violated the Apache
  license by removing my name, which they later restored in response to public
  pressure."*
  **Chef's response (attributed to CTO Corey Scobie):** *"In our haste to
  restore one of the objects, we inadvertently removed a piece of metadata that
  identified him as the author,"* and Chef said it reverted the change once
  notified.
  ([TechCrunch (Sep 23, 2019)](https://techcrunch.com/2019/09/23/programmer-who-took-down-open-source-pieces-over-chef-ice-contract-responds/))

### CEO Barry Crist: first defends the contract, then reverses

- **September 20, 2019 — initial defense.** In a Chef blog post, CEO **Barry
  Crist** *defended* continuing the ICE/CBP work:
  *"I have made a principled decision, with the support of the Chef executive
  team, to work with the institutions of our government,"* while adding *"I also
  find policies such as separating families and detaining children wrong and
  contrary to the best interests of our country."* He also argued it was not
  *"appropriate, practical, or within our mission to examine specific government
  projects with the purpose of selecting which U.S. agencies we should or should
  not do business [with]."*
  ([Chef blog: "Chef's Position on Customer Engagement in the Public and Private Sectors" (Sep 20, 2019)](https://www.chef.io/blog/chefs-position-on-customer-engagement-in-the-public-and-private-sectors);
  [TechCrunch: "Chef CEO says he'll continue to work with ICE in spite of protests" (Sep 20, 2019)](https://techcrunch.com/2019/09/20/chef-ceo-says-hell-continue-to-work-with-ice-in-spite-of-protests/))

- **September 23, 2019 — the about-face.** After a weekend of internal pressure,
  Crist reversed:
  *"After deep introspection and dialog within Chef, we will not renew our
  current contracts with ICE and CBP when they expire over the next year. Chef
  will fulfill our full obligations under the current contracts."* He also
  apologized: *"While I and others privately opposed this and various other
  related policies, we did not take a position despite the recommendation of
  many of our employees. I apologize for this."*
  Chef additionally committed to **donating the equivalent of its 2019 revenue
  from the ICE and CBP contracts** to organizations helping people affected by
  family separation and detention.
  ([TechCrunch: "Chef CEO does an about face…" (Sep 23, 2019)](https://techcrunch.com/2019/09/23/chef-ceo-does-an-about-face-says-company-will-not-renew-ice-contract/);
  [GeekWire (Sep 23, 2019)](https://www.geekwire.com/2019/tech-company-chef-wont-renew-u-s-immigration-contracts-changing-course-amid-employee-activism/);
  [Vice/Motherboard: "Company That Provides Tech to ICE Not Renewing Contract…"](https://www.vice.com/en/article/chef-not-renewing-ice-immigration-customs-enforcement-contract-after-code-deleting-protest/))

> **Verification note on the Sep 23 blog post.** The Chef blog URL for the
> public-sector statement now serves the **September 20** text with a note that
> a September 23 update exists; the updated body could not be fetched directly
> from chef.io. However, the **September 23 reversal and its exact quotes are
> independently corroborated** by TechCrunch, GeekWire, and Vice (linked above),
> so the claim itself is well-verified even though the live primary page renders
> the earlier version.

---

## September 8 / October 6, 2020 — Progress Software acquires Chef (~$220M)

- On **September 8, 2020**, **Progress Software Corporation** announced a
  definitive agreement to **acquire Chef for $220 million in cash** (subject to
  customary adjustments).
  ([Progress press release: "Progress Announces Acquisition of Chef"](https://investors.progress.com/news-releases/news-release-details/progress-announces-acquisition-chef);
  [Progress 8-K / SEC filing (press release)](https://www.sec.gov/Archives/edgar/data/0000876167/000087616720000123/chefpressrelease.htm);
  [GeekWire: "Chef to be acquired for $220M by Progress…"](https://www.geekwire.com/2020/chef-acquired-220m-progress-next-chapter-seattle-automation-tech-company/))

- The deal **closed on October 6, 2020** (Progress funded it with cash on hand
  plus its existing credit facility). At acquisition, Chef had roughly **$70M in
  annual revenue, ~95% recurring/subscription**.
  ([Progress press release: "Progress Completes Acquisition of Chef"](https://investors.progress.com/news-releases/news-release-details/progress-completes-acquisition-chef);
  [Progress 8-K closing / SEC](https://www.sec.gov/Archives/edgar/data/0000876167/000087616720000151/progress_chefclosing.htm);
  [GeekWire (Sep 8, 2020)](https://www.geekwire.com/2020/chef-acquired-220m-progress-next-chapter-seattle-automation-tech-company/))

- The acquired business was rebranded **Progress Chef**.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

---

## Adam Jacob's later venture — System Initiative

- After leaving Chef's day-to-day operations, Adam Jacob co-founded
  **System Initiative**. Co-founders cited include **Alex Ethier** and
  **Mahir Lupinacci** (COO).
  ([The New Stack: "System Initiative: A DevOps Makeover by Ex-Chef Adam Jacob"](https://thenewstack.io/system-initiative-a-devops-makeover-by-ex-chef-adam-jacob/);
  [Runtime: "Meet System Initiative…"](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/))

- System Initiative **came out of stealth on June 21, 2023** with **$18M** in
  venture funding and a private beta. The product builds a **"digital twin"**
  (a live simulation) of production infrastructure where teams can model and
  test changes before applying them — Jacob has described the multiplayer visual
  interface as **"like Figma for infrastructure."**
  ([Runtime (Jun 21, 2023)](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/);
  [TechTarget: "Chef founder's new venture: IT infrastructure digital twins"](https://www.techtarget.com/searchitoperations/feature/Chef-founders-new-venture-IT-infrastructure-digital-twins))

> **Note:** Some sources list co-founders slightly differently (The New Stack /
> Crunchbase emphasize Jacob; Runtime names Jacob and Lupinacci). The exact
> full founding-team roster is **partially verified**.

---

## Chef's decline relative to Terraform and Ansible (sourced commentary)

This section is **analyst/commentary**, not Chef's own framing, and is labeled
as such.

- Third-party market-share trackers place Chef well behind newer tools in the
  configuration-management / IaC category — e.g., one tracker lists **Terraform
  ~36%, Puppet ~12%, Chef ~6.6–6.7%**.
  ([6sense: Chef market share](https://6sense.com/tech/configuration-management/chef-market-share);
  [6sense: Terraform market share](https://6sense.com/tech/configuration-management/terraform-market-share))

- Commonly cited reasons for the relative decline (per industry comparison
  write-ups): Chef's **agent-based model** imposes installation/maintenance
  overhead that **agentless** Ansible and **provisioning-native** Terraform
  avoid; Chef's Ruby DSL has a steeper learning curve; and Chef was not designed
  primarily for cloud **provisioning**, the area Terraform owns. The prevailing
  pattern in many shops became **Terraform (provisioning) + Ansible
  (configuration)**.
  ([TechnologyMatch: "Terraform vs. Ansible vs. Puppet vs. Chef"](https://technologymatch.com/blog/terraform-ansible-puppet-or-chef-which-tool-is-right-for-it-leaders);
  [UpGuard: "Ansible vs Chef"](https://www.upguard.com/blog/ansible-vs-chef))

> These are secondary-source opinions and vendor-comparison framings; treat the
> specific market-share percentages as **directional, single-source figures**,
> not audited statistics.

---

## Summary of what could NOT be (fully) verified

1. **Exact month of Adam Jacob's CTO-departure announcement (2019).** The
   GeekWire primary source confirms the event but the precise date was
   ambiguous across the material gathered (Jan vs. Jul 2019). **Partially
   verified.**
2. **The live Chef.io blog body for the Sep 23, 2019 reversal.** The chef.io URL
   renders the **Sep 20** version (with a note that a Sep 23 update exists); the
   updated text was not directly fetchable. The **substance and exact quotes of
   the Sep 23 reversal are nonetheless independently corroborated** by
   TechCrunch, GeekWire, and Vice. **Verified via secondary sources, not the
   live primary page.**
3. **Exact dollar value of the CBP contract.** The **$95,000** figure is
   consistently reported for the **ICE** contract; a separate precise figure for
   the **CBP** contract was not pinned down. **Partially verified.**
4. **Full System Initiative founding-team roster.** Sources name Adam Jacob
   consistently but differ on co-founders (Alex Ethier / Mahir Lupinacci).
   **Partially verified.**
5. **Whether Joshua Timberman counts as a "co-founder."** Wikipedia lists him
   among Opscode's founders; the founder set most often cited in the prompt
   (Jacob, Robbins, Steinglass, Haneysmith) does not include him. **Conflicting
   across sources.**

---

## Key people & teams (chronological)

This section traces the individuals and teams behind Chef over time. Each claim
carries an inline source. Reported statements (what a person said about
themselves) are attributed to the source, not asserted as bare fact.

### 2008 — The Opscode founding team

- **Adam Jacob — co-founder & CTO.** Jacob created Chef and co-founded Opscode;
  he was the company's **Chief Technology Officer**. The English Wikipedia
  article on Progress Chef states the founders set out "In June of 2008 … to
  bring infrastructure automation to the masses," and that they "founded a new
  company (Opscode) with Barry Steinglass, Nathen Haneysmith, and Joshua
  Timberman to turn Chef into a product."
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

- **Jesse Robbins — co-founder & founding CEO.** Per his Wikipedia biography,
  Robbins "founded Chef" and "served as the first CEO." Before Opscode he ran
  operations at **Amazon**, where he held the manager-approved title **"Master
  of Disaster,"** responsible for "website availability for every property
  bearing the Amazon brand," and created **"GameDay,"** a program of
  deliberately injecting major failures to test resilience.
  ([Jesse Robbins — Wikipedia](https://en.wikipedia.org/wiki/Jesse_Robbins))

- **Barry Steinglass — co-founder.** Prior to Opscode, Steinglass was the
  Program Manager for the digital-entertainment features of the **Xbox 360** at
  Microsoft.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

- **Nathen Haneysmith — co-founder.** Formerly the **Linux Platform Lead for the
  Americas at IBM Global Services**.
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

- **Joshua Timberman — listed founder (discrepancy resolved).** The existing
  notes above flag a conflict over whether Timberman is a "co-founder." The
  **Progress Chef Wikipedia article explicitly names him** among the people with
  whom Chef/Opscode was founded ("…with Barry Steinglass, Nathen Haneysmith, and
  Joshua Timberman…"). So: **Wikipedia counts Timberman among the founding
  group; the four-name set (Jacob, Robbins, Steinglass, Haneysmith) commonly
  cited elsewhere omits him.** Best read: he was part of the founding team, and
  the four-name list is simply a narrower framing. (Still a sourcing
  discrepancy, now resolved in favor of "founding team member per Wikipedia.")
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Progress_Chef))

### 2011 — First CEO transition: Robbins → Mitch Hill

- On **August 9, 2011**, Opscode announced **Mitch Hill** as new CEO (hired
  after a six-month search), with founding CEO **Jesse Robbins** moving to
  **Chief Community Officer**. Robbins said he would dedicate his focus to
  "stewarding our community and launching and expanding programs for our
  contributors, customers, partners, and the technical community at large."
  ([Chef blog: "Announcing Mitch Hill as new CEO of Opscode & Jesse Robbins' role as Chief Community Officer"](https://www.chef.io/blog/announcing-mitch-hill-as-new-ceo-of-opscode-jesse-robbins-role-as-chief-community-officer))

### Jesse Robbins — after Chef

- Robbins later **founded Orion Labs**, a startup building real-time voice
  communication hardware/software (a "Real-Life Star Trek Communicator").
  ([Jesse Robbins — Wikipedia](https://en.wikipedia.org/wiki/Jesse_Robbins))
- He subsequently became a venture investor at the developer-focused firm
  **Heavybit**, with investments including PagerDuty, Snyk, and Tailscale.
  ([Jesse Robbins — Wikipedia](https://en.wikipedia.org/wiki/Jesse_Robbins);
  [Jesse Robbins — Crunchbase](https://www.crunchbase.com/person/jesse-robbins))

### 2013 — Barry Crist becomes CEO

- **Barry Crist** was appointed **CEO of Opscode/Chef on August 26, 2013** (after
  about five months as VP, Enterprise). His background: he had been **CEO of
  Likewise, Inc.** (acquired 2012), where he built an open-source, free-to-
  premium sales model, with prior stints at **Mercury Interactive, McAfee, and
  Apple**.
  ([Chef blog: "Opscode Appoints Barry Crist As Chief Executive Officer"](https://www.chef.io/blog/opscode-appoints-barry-crist-as-chief-executive-officer);
  [Data Center Knowledge: "Opscode Names Barry Crist as CEO"](https://www.datacenterknowledge.com/business/opscode-names-barry-crist-as-ceo))
- Crist was the CEO who steered Chef through the 2019 open-source relicensing and
  the ICE/CBP controversy (see below). After Progress acquired Chef, Crist
  later joined the board of **Buildkite** (reported by GeekWire in 2023).
  ([GeekWire: "Tech Moves: Former Chef CEO joins Buildkite board…" (2023)](https://www.geekwire.com/2023/tech-moves-former-chef-ceo-joins-buildkite-board-salesforce-hires-code-org-exec/))

### Seth Vargo — former Chef engineer, central to the ICE episode

- **Seth Vargo** worked at Chef from roughly **mid-January 2013 to August 29,
  2014**, in roles he describes as consultant, community engineer, evangelist,
  and release engineer (he helped build the first "Learn Chef" initiative).
  ([Seth Vargo: "Leaving Chef"](https://www.sethvargo.com/leaving-chef/))
- He authored **`chef-sugar`** and, after leaving, went on to **HashiCorp** and
  then **Google**. **At the time of the September 2019 `chef-sugar` deletion he
  was at Google** (widely reported as a Google staff/Cloud engineer) — i.e., he
  was **not** a Chef employee when he pulled the code. (His later bio lists him
  as a Distinguished Software Engineer at LinkedIn.)
  ([Seth Vargo: "Leaving Chef"](https://www.sethvargo.com/leaving-chef/);
  [The Register: "Chef roasted for tech contract with family-separating US immigration…" (Sep 20, 2019)](https://www.theregister.com/2019/09/20/chef_roasted_for_ice_dealings/);
  [Seth Vargo — Crunchbase](https://www.crunchbase.com/person/seth-vargo))

### 2019 — Adam Jacob steps down as CTO; Corey Scobie succeeds him

- In **2019**, after about a decade, **Adam Jacob stepped down from his active
  CTO role**, remaining on the **board of directors** as an advisor; he said he
  was taking a break (the "walk my kid to school" framing). **Corey Scobie**
  became the new CTO.
  ([GeekWire: "Chef co-founder and CTO Adam Jacob stepping down, will remain on board of directors"](https://www.geekwire.com/2019/chef-co-founder-cto-adam-jacob-stepping-will-remain-board-directors/);
  [GeekWire: "Chef names new CTO to succeed its co-founder…"](https://www.geekwire.com/2019/chef-names-new-cto-succeed-co-founder-eyes-broader-market-enterprise-automation/))
  > **Exact month still not firmly pinned.** As flagged earlier in this doc,
  > sources scatter between **January 2019** and **July 2019** for the
  > announcement; the GeekWire article carries a 2019 dateline but the precise
  > month was not reconfirmed from a directly-fetchable copy (the GeekWire page
  > returned HTTP 403 to automated fetches). **Partially verified.**

- **Corey Scobie — CTO.** Scobie is the executive who responded publicly in the
  `chef-sugar` Apache-license-metadata dispute: he said that "In our haste to
  restore one of the objects, we inadvertently removed a piece of metadata that
  identified him [Vargo] as the author," and that Chef reverted once notified.
  ([TechCrunch: "Programmer who took down open-source pieces over Chef ICE contract responds" (Sep 23, 2019)](https://techcrunch.com/2019/09/23/programmer-who-took-down-open-source-pieces-over-chef-ice-contract-responds/))

### September 2019 — Barry Crist's defend-then-reverse on ICE/CBP

- CEO **Barry Crist** first **defended** continuing the ICE/CBP work in a
  Sep 20, 2019 blog post, then **reversed on Sep 23, 2019**, committing not to
  renew the contracts and to donate the equivalent of 2019 ICE/CBP revenue.
  (Full quotes and sourcing are in the September 2019 section above.)
  ([Chef blog (Sep 20, 2019)](https://www.chef.io/blog/chefs-position-on-customer-engagement-in-the-public-and-private-sectors);
  [TechCrunch: "Chef CEO does an about face…" (Sep 23, 2019)](https://techcrunch.com/2019/09/23/chef-ceo-does-an-about-face-says-company-will-not-renew-ice-contract/))

### Adam Jacob — open-source commentary and System Initiative

- After leaving Chef's day-to-day operations, Jacob became a prominent voice on
  **open-source business models**. He launched an effort he called **Sustainable
  Free and Open Source Communities (SFOSC)** to debate licensing changes driven
  by cloud computing, and argued (his words) that "There's no evidence that when
  things are open source, you make less revenue." He also published a widely-read
  essay, **"Goodbye Open Core — Good Riddance to Bad Rubbish."**
  ([TechTarget/SearchITOperations: "Former Chef Software CTO talks IT automation, open source"](https://www.techtarget.com/searchitoperations/news/252463595/Former-Chef-Software-CTO-talks-IT-automation-open-source);
  [Adam Jacob: "Goodbye Open Core — Good Riddance to Bad Rubbish" (Medium)](https://medium.com/@adamhjk/goodbye-open-core-good-riddance-to-bad-rubbish-ae3355316494))

- Jacob then co-founded **System Initiative** (CEO). Reporting and the company's
  own materials name co-founders **Alex Ethier** and **Mahir Lupinacci** (COO).
  The company **came out of stealth on June 21, 2023** with **$18M** in funding
  and a private beta; the product is a "digital twin" of infrastructure with a
  multiplayer visual interface Jacob likens to **"Figma for infrastructure."**
  ([Runtime: "Meet System Initiative, a new DevOps tool from Chef founder Adam Jacob" (Jun 21, 2023)](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/);
  [The New Stack: "System Initiative: A DevOps Makeover by Ex-Chef Adam Jacob"](https://thenewstack.io/system-initiative-a-devops-makeover-by-ex-chef-adam-jacob/))

### 2020+ — The Progress era: who runs Chef now

- **Progress Software** (CEO **Yogesh Gupta**) acquired Chef, announcing the
  ~$220M deal on **Sep 8, 2020** and closing on **Oct 6, 2020**. Gupta framed it
  as fitting Progress's acquisition criteria (strong recurring revenue,
  complementary technology, loyal customer base).
  ([Progress: "Progress Announces Acquisition of Chef" (Sep 8, 2020)](https://investors.progress.com/news-releases/news-release-details/progress-announces-acquisition-chef);
  [Progress: "Progress Completes Acquisition of Chef" (Oct 6, 2020)](https://investors.progress.com/news-releases/news-release-details/progress-completes-acquisition-chef);
  [Yogesh Gupta — Progress leadership page](https://www.progress.com/company/leadership/yogesh-gupta))

- Within Progress, Chef has been run as part of the DevOps / infrastructure-
  management portfolio under **Sundar Subramanian**, titled **EVP & General
  Manager, DevOps** (more recent materials describe him as EVP & GM for
  Infrastructure Management). Coverage describes Chef operating as a business
  unit under his leadership.
  ([Sundar Subramanian — Progress leadership page](https://www.progress.com/company/leadership/sundar-subramanian);
  [Mass Tech Leadership Council: "Who's Who at Progress360: Meet Sundar Subramanian, EVP & GM, DevOps"](https://www.mtlc.co/whos-who-at-progress360-meet-sundar-subramanian-evp-gm-devops/))
  > **Note:** Subramanian's exact start date in the DevOps/Chef GM role and the
  > precise scope of "runs Chef" were not pinned to a single dated primary
  > source. **Partially verified.**

### Could not verify / partially verified (this section)

1. **Exact month of Adam Jacob's 2019 CTO-departure announcement** — sources
   split between Jan and Jul 2019; the GeekWire primary page returned 403 to
   automated fetch. **Partially verified.**
2. **Seth Vargo's precise 2019 title at Google** — multiple reputable reports
   place him at Google (staff/Cloud engineer) at the time of the deletion, and
   his own "Leaving Chef" post confirms Chef → HashiCorp → Google; the exact
   2019 job title was not nailed to a single primary source. **Substance
   verified (he was at Google, not Chef); exact title partially verified.**
3. **System Initiative full founding-team roster** — Jacob consistent; Ethier
   and Lupinacci named across Runtime/company materials but framings vary.
   **Partially verified.**
4. **Joshua Timberman as "co-founder"** — Wikipedia lists him among the founding
   group; the four-name framing omits him. **Resolved as founding-team member
   per Wikipedia; framing discrepancy noted.**
5. **Sundar Subramanian's start date / exact scope over Chef** — title
   confirmed; dated appointment not pinned. **Partially verified.**

---

## Company & corporate history (chronological)

This section traces Chef the *business* — incorporation, rebrand, venture
funding, business-model changes, revenue, and the eventual acquisition — as
distinct from the people-and-controversy threads above. Each claim carries an
inline source; figures that could not be pinned to a fetchable primary source
are flagged.

### 2008 — Opscode founded (Seattle)

- The company was founded as **Opscode, Inc.** in **2008**, headquartered in
  **Seattle, Washington**. It was co-founded by Jesse Robbins, Adam Jacob, and
  others (full founding-team roster is covered in the people section above).
  Opscode's stated business was to let "companies of all sizes … build, scale,
  and manage … fully automated infrastructures," productizing the open-source
  **Chef** framework.
  ([Chef blog: "Opscode Announces $2.5 Million in Series A Round"](https://blog.chef.io/opscode-announces-2-5-million-in-series-a-round/);
  [GeekWire: "Chef to be acquired for $220M by Progress…"](https://www.geekwire.com/2020/chef-acquired-220m-progress-next-chapter-seattle-automation-tech-company/))

### Venture funding rounds (Series A–E)

The company raised five priced venture rounds as Opscode/Chef. Verified
round-by-round:

- **Series A — $2.5M, April 2009.** Led by **Draper Fisher Jurvetson (DFJ)**.
  Announced April 24, 2009.
  ([Chef blog: "Opscode Announces $2.5 Million in Series A Round"](https://blog.chef.io/opscode-announces-2-5-million-in-series-a-round/))

- **Series B — $11M, June 2010.** Led by **Battery Ventures**, with DFJ
  following on. The announcement put total raised to date at **$13.5M**
  (Series A + B). Announced June 21, 2010.
  ([Chef blog: "Opscode Closes $11 Million Series B Round"](https://www.chef.io/blog/opscode-closes-11-million-series-b-round))

- **Series C — $19.5M, March 2012.** Led by **Ignition Partners** (Ignition's
  John Connors joined the board), with follow-on from Battery Ventures and DFJ;
  the round was described as oversubscribed. Announced March 26, 2012.
  ([PR Newswire / Opscode: "Opscode Secures $19.5 Million In Series C Funding"](https://www.prnewswire.com/news-releases/opscode-secures-195-million-in-series-c-funding-144191765.html))

- **Series D — $32M, December 2013.** Led by **Scale Venture Partners**.
  Announced **December 9, 2013** — the same day the company **renamed from
  Opscode to Chef** (see below). Reporting put total raised across four rounds
  at roughly **$63M** at this point.
  ([Data Center Knowledge: "Opscode Rebrands as Chef, Raises $32 Million"](https://www.datacenterknowledge.com/archives/2013/12/09/opscode);
  [Chef blog: "Chef: The Company Formerly Known as Opscode"](https://www.chef.io/blog/chef-the-company-formerly-known-as-opscode))

- **Series E — $40M, September 2015.** Led by **DFJ Growth**. New investors
  included **Millennium Technology Value Partners** and **Hewlett Packard
  Ventures** (a strategic investment); existing investors **Battery Ventures,
  Citi Ventures, DFJ, Ignition Partners, and ScaleVP** also participated.
  Announced September 9, 2015. (This is the **$40M round at a ~$360M valuation**
  referenced earlier in the people/timeline section.)
  ([Chef blog: "Chef Secures $40 Million in Funding to Meet Growing DevOps Demand"](https://www.chef.io/blog/chef-raises-40-million-in-series-e))

- **Total raised.** Across its life as a private company, Chef/Opscode raised
  **more than $100M** (commonly cited as ~$105M total). Lifetime investors
  named include **Battery Ventures, Citi Ventures, DFJ / DFJ Growth, Ignition
  Partners, Scale Venture Partners, Millennium Technology Value Partners, and
  Hewlett Packard Ventures**.
  ([GeekWire: "Chef to be acquired for $220M by Progress…"](https://www.geekwire.com/2020/chef-acquired-220m-progress-next-chapter-seattle-automation-tech-company/))
  > **Note on the "~$105M" total.** Summing the five verified rounds gives
  > $2.5M + $11M + $19.5M + $32M + $40M = **$105M** in priced equity, which
  > matches the "more than $100M" framing. **Verified by arithmetic over the
  > individually-sourced rounds; no single source states "$105M" verbatim.**

### December 9, 2013 — Opscode renamed Chef Software

- On **December 9, 2013**, the company **changed its corporate name from
  Opscode to Chef**, aligning the company identity with its widely recognized
  open-source product and community. The rationale given was brand equity:
  "Chef has brand equity and awareness around the world, and Opscode really
  doesn't." The rebrand shipped alongside the Series D and a move to the
  getchef.com domain.
  ([Chef blog: "Chef: The Company Formerly Known as Opscode"](https://www.chef.io/blog/chef-the-company-formerly-known-as-opscode);
  [Data Center Knowledge: "Opscode Rebrands as Chef, Raises $32 Million"](https://www.datacenterknowledge.com/archives/2013/12/09/opscode))
  > **Note:** The prompt referenced the rename as "2013" generally; the
  > precise date is **December 9, 2013**, concurrent with the Series D.

### April 2, 2019 — Business-model shift to the Chef Enterprise Automation Stack

- On **April 2, 2019**, Chef restructured its commercial model: it committed to
  developing **100% of its software as open source under the Apache 2.0
  license**, and simultaneously introduced a paid **commercial distribution**,
  the **Chef Enterprise Automation Stack (EAS)**, "licensed and tailored
  exclusively for commercial customers." EAS bundled **Chef Workstation, Chef
  Automate, Chef Infra, Chef InSpec, and Chef Habitat**; Chef developed,
  distributed, supported, warranted, and indemnified the commercial
  distribution, while the underlying source remained Apache 2.0 and the
  distributions were free for non-commercial use.
  ([Chef blog: "Introducing the New Chef: 100% Open, Always" (Apr 2, 2019)](https://blog.chef.io/2019/04/02/chef-software-announces-the-enterprise-automation-stack/);
  [GeekWire: "Chef unveils new commercial product strategy…"](https://www.geekwire.com/2019/chef-unveils-new-commercial-product-strategy-will-now-sell-distributions-open-source-projects/);
  [InfoQ: "Infrastructure Automation Company Chef Commits to Open Source"](https://www.infoq.com/news/2019/05/chef-open-source/))
  > This is the corporate/business framing of the same April 2019 event
  > documented from the licensing/controversy angle earlier in this file (the
  > "100% open source" relicensing). Here the emphasis is the **commercial
  > product strategy**: open source upstream + a paid, supported downstream
  > distribution (an explicitly "Red Hat–style" model).

### Cinc — community rebuild as a consequence of the commercial-distro model

- Because Chef's **source** became Apache 2.0 but its **branded binaries**
  required commercial terms (EULA + trademark), the community created **Cinc**
  ("**CINC Is Not Chef**," a recursive acronym) starting in **2019**. Cinc
  builds **fully Apache-2.0-licensed, EULA-free binaries** from Chef's own
  source — substituting only branding constants to comply with Chef's trademark
  policy — covering Chef Infra, InSpec, Habitat, and Automate. It is positioned
  as a community distribution (not a code fork), built to honor Chef's
  trademark policy, which Chef Software acknowledged.
  ([Cinc — About](https://cinc.sh/about/);
  [Cinc — Goals](https://cinc.sh/goals/);
  [DevClass: "Chef says it's going 100% open source, forks optional…" (Apr 2, 2019)](https://devclass.com/2019/04/02/chef-says-its-going-100-open-source-forks-optional/))

### Revenue / ARR at acquisition

- At the time of the 2020 acquisition, the commercial side of Chef had
  approximately **$70M in annual recurring revenue (ARR)**, reported as roughly
  **~95% recurring/subscription**.
  ([TechCrunch: "Progress snags software automation platform Chef for $220M" (Sep 8, 2020)](https://techcrunch.com/2020/09/08/progress-snags-software-automation-platform-chef-for-220m/);
  [Built In Seattle: "Progress Acquires Seattle Startup Chef for $220M"](https://www.builtinseattle.com/articles/progress-acquires-chef-220m);
  [GeekWire: "Chef to be acquired for $220M by Progress…"](https://www.geekwire.com/2020/chef-acquired-220m-progress-next-chapter-seattle-automation-tech-company/))

### September 8 – October 6, 2020 — Progress Software acquires Chef ($220M cash)

- On **September 8, 2020**, **Progress Software Corporation** (a Bedford,
  Massachusetts–based developer-tools company, CEO **Yogesh Gupta**) announced a
  definitive agreement to **acquire Chef for $220 million in cash**, subject to
  customary adjustments, with the deal expected to close the following month.
  ([Progress press release: "Progress Announces Acquisition of Chef"](https://investors.progress.com/news-releases/news-release-details/progress-announces-acquisition-chef);
  [Progress 8-K / SEC filing (press release)](https://www.sec.gov/Archives/edgar/data/0000876167/000087616720000123/chefpressrelease.htm);
  [TechCrunch (Sep 8, 2020)](https://techcrunch.com/2020/09/08/progress-snags-software-automation-platform-chef-for-220m/))

- The acquisition **closed on October 6, 2020**, funded with cash on hand plus
  Progress's existing credit facility.
  ([Progress press release: "Progress Completes Acquisition of Chef"](https://investors.progress.com/news-releases/news-release-details/progress-completes-acquisition-chef);
  [Progress 8-K closing / SEC](https://www.sec.gov/Archives/edgar/data/0000876167/000087616720000151/progress_chefclosing.htm);
  [GlobeNewswire: "Progress Completes Acquisition of Chef" (Oct 6, 2020)](https://www.globenewswire.com/news-release/2020/10/06/2104339/0/en/Progress-Completes-Acquisition-of-Chef.html))

- **Post-close layoffs.** Shortly after closing, Progress made layoffs at Chef,
  while stating it remained committed to the Chef product roadmap.
  ([GeekWire: "Progress makes layoffs at Chef after $220M acquisition…"](https://www.geekwire.com/2020/progress-makes-layoffs-chef-220m-acquisition-says-remains-committed-roadmap/))
  > **Could not directly fetch** the GeekWire layoffs article (HTTP 403 to
  > automated fetch); the headline/URL is shown in search results and the event
  > is consistent with Progress's stated integration approach. **Partially
  > verified.**

### 2020–present — Chef as a Progress product line ("Progress Chef")

- Within Progress, the acquired business operates as a product line branded
  **Progress Chef**, part of Progress's DevOps / infrastructure-management
  portfolio. (Leadership/who-runs-it-now detail is in the people section above.)
  ([Progress Chef — Wikipedia](https://en.wikipedia.org/wiki/Chef_(company)))

### Could not verify / partially verified (corporate section)

1. **Chef's headcount at acquisition (and over time).** No fetchable primary
   source pinned a specific employee count for Chef in 2019–2020; the
   acquisition coverage references "highly skilled employees" without a number,
   and third-party aggregators give only current (post-acquisition, much
   smaller) figures. **Could not verify: Chef headcount.**
2. **The "~$105M total raised" figure.** No single source states "$105M"
   verbatim; it is the **sum of the five individually-sourced rounds**
   ($2.5M+$11M+$19.5M+$32M+$40M = $105M), consistent with the "more than $100M"
   framing reported by GeekWire. **Verified by arithmetic; not by a single
   source quoting the total.**
3. **Live Progress investor-relations pages and SEC EDGAR pages.** The Progress
   IR press releases and the SEC 8-K filing pages returned timeouts / HTTP 403
   to automated fetch; their substance (price, dates, ARR) is **independently
   corroborated** by TechCrunch, Built In Seattle, GeekWire, and GlobeNewswire.
   **Verified via secondary sources; primary IR/EDGAR pages not directly
   fetchable in this session.**
4. **Exact Series C "total raised to date."** Reporting around the Series C gave
   slightly varying cumulative totals (~$31.5M vs. ~$33M); the per-round amounts
   are firm. **Round amounts verified; cumulative running total around Series C
   varies by source.**
