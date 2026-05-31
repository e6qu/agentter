# Salt / SaltStack: A Chronological History

*SaltStack → VMware → Broadcom. Focus: cloud-API integration and controversies — especially the 2020 CVE mass-exploitation and the acquisitions.*

> **Sourcing note:** Every factual claim below carries an inline URL. Primary sources (official advisories, vendor blogs, SEC filings, victim post-mortems) are preferred. Where only secondary press is available, the outlet is named. Reported (not independently confirmed) claims are flagged as such. Items that could not be verified are listed at the end.

---

## 1. Founding and the Salt model (2011–2012)

- **March 19, 2011 — Initial release of Salt.** Thomas S. Hatch created Salt and made the first release on March 19, 2011, to address "high-speed data collection and task execution for data center systems." ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

- **Motivation: speed.** Hatch built Salt after becoming frustrated with the speed of the Ruby-based open-source configuration-management systems of the time, including Puppet and Chef. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

- **The ZeroMQ message-bus / remote-execution model.** Hatch chose the ZeroMQ messaging library to meet the high-speed requirements and built Salt's networking layers on it. Salt is fundamentally a high-speed *remote execution* engine, with configuration management layered on top — architecturally distinct from the agent/pull model emphasized by Puppet and Chef. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)); [ZeroMQ wiki: Salt](http://wiki.zeromq.org/story:4))

  - Contrast with Ansible: Ansible (first released 2012) is agentless and SSH-based, whereas Salt uses a persistent ZeroMQ message bus between a *salt-master* and *salt-minions*. (Architectural contrast; see [InfoWorld: Why use SaltStack](https://www.infoworld.com/article/2255086/why-use-saltstack-for-automation-and-orchestration.html))

- **Python / YAML / Jinja stack.** Salt is written in Python, uses ZeroMQ for messaging, and uses YAML for configuration data (Salt "states"). Jinja is the default templating engine used inside SLS state files. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

- **State system maturity (late 2011).** Experimental Salt State functionality appeared in May 2011 but was not considered stable until the release of Salt 0.9.3 in November 2011. Hatch described Salt as a "garage project" until it was featured on FLOSS Weekly in November 2011. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

- **SaltStack, the company.** The commercial entity, SaltStack, Inc., was founded to back the open-source project. (VMware's later coverage describes SaltStack as "founded in 2012" and ultimately led by CEO Marc Chenn, with Hatch as CTO/co-founder. ([Channel Post MEA: VMware completes acquisition](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/); [AiThority interview with Thomas Hatch](https://aithority.com/interviews/ait-megamind/aithority-interview-with-thomas-hatch-cto-and-co-founder-at-saltstack/))

---

## 2. Cloud-API integration: salt-cloud (2013 onward)

- **salt-cloud / Salt Virt introduced in 0.14.0.** Salt's cloud-management capabilities were introduced in the 0.14.0 release. Salt Cloud grew to support roughly **25 public and private cloud systems**, including **AWS, Azure, VMware, IBM Cloud, and OpenStack**. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

- **What salt-cloud does.** salt-cloud is the provisioning layer: it talks to cloud provider APIs to spin up VM instances, then automatically bootstraps the Salt minion onto them so they immediately join the master's message bus for configuration and remote execution. Beyond pure config management, contemporaneous coverage stressed that "Salt is not just configuration management. It is cloud management, orchestration, the Salt reactor, etc." ([Linux.com: 5 Things to Know About Salt Cloud Management](https://www.linux.com/news/5-things-know-about-salt-cloud-management/))

  > Note on cloud-API integration significance for the 2020 attacks: F-Secure specifically warned that compromise of a Salt master could be used to "configure new resources on cloud instances" — i.e., the same cloud-provisioning capabilities that make salt-cloud useful also amplify the blast radius of a master compromise. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass))

---

## 3. The 2020 critical CVEs and mass exploitation

### Disclosure and patch timeline

- **March 12, 2020 — Initial security contact.** F-Secure (now WithSecure) first contacted SaltStack about the vulnerabilities. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass))

- **April 29, 2020 — Patch released.** SaltStack released fixed versions **3000.2** and **2019.2.4**. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass); [The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html))

- **April 30, 2020 — Public advisory.** F-Secure published its public advisory disclosing the two CVEs. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass))

### The vulnerabilities

- **CVE-2020-11651 — Authentication bypass.** In the salt-master `ClearFuncs` class, the `_send_pub()` method was exposed to unauthenticated requests (allowing arbitrary message queueing) and `_prep_auth_info()` was exposed, returning the master's "root key" — enabling an unauthenticated remote attacker to bypass authentication and execute commands as root on the master and all connected minions. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass); [NVD: CVE-2020-11651](https://nvd.nist.gov/vuln/detail/CVE-2020-11651))

- **CVE-2020-11652 — Directory traversal.** The salt-master wheel module and the `get_token()` method of `salt.tokens.localfs` failed to sanitize input paths, allowing `..` path elements to read/write files outside intended directories. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass); [Trend Micro](https://www.trendmicro.com/vinfo/us/security/news/vulnerabilities-and-exploits/coinminers-exploit-saltstack-vulnerabilities-cve-2020-11651-and-cve-2020-11652))

- **Combined impact.** Chaining the two yielded "full remote command execution as root on both the master and all minions that connect to it." ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass))

- **Affected versions.** All versions before **2019.2.4** and **3000** before **3000.2**. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass))

- **Exposure.** F-Secure's scan found **over 6,000 Salt masters exposed to the public internet**. ([WithSecure/F-Secure advisory](https://labs.withsecure.com/advisories/saltstack-authorization-bypass)) A few days into the attacks, Censys data cited by BleepingComputer counted **more than 5,000** still-exposed, potentially-vulnerable SaltStack servers. ([BleepingComputer](https://www.bleepingcomputer.com/news/security/hackers-exploit-salt-rce-bugs-in-widespread-attacks-pocs-public/))

### SaltStack's official advisory

- SaltStack published its own advisory describing "a critical vulnerability affecting Salt Master versions 2019.2.3 and 3000.1 and earlier," "easily exploitable if a Salt Master is exposed to the open internet," and warned that "some vulnerable, unpatched systems have been accessed by unauthorized users since the release of the patches." It urged that systems "must be hardened and updated immediately." ([Salt Project security announcement, 2020-05-04](https://saltproject.io/security-announcements/2020-05-04-advisory/))

### Mass exploitation and cryptojacking

- **Weekend of May 2–4, 2020 — exploitation in the wild.** Within days of disclosure (and with multiple public PoCs circulating), attackers began mass-exploiting unpatched masters. ([Tenable](https://www.tenable.com/blog/cve-2020-11651-cve-2020-11652-critical-salt-framework-vulnerabilities-exploited-in-the-wild); [BleepingComputer](https://www.bleepingcomputer.com/news/security/hackers-exploit-salt-rce-bugs-in-widespread-attacks-pocs-public/))

- **Cryptojacking payloads.** Attacks were largely driven by the **Kinsing / H2Miner** botnet targeting cloud environments, deploying the **XMRig** Monero miner under process names disguised as Salt components — e.g. `salt-minions`, `salt-minions-bak`, and `salt-store`. ([BleepingComputer](https://www.bleepingcomputer.com/news/security/hackers-exploit-salt-rce-bugs-in-widespread-attacks-pocs-public/); [Trend Micro](https://www.trendmicro.com/vinfo/us/security/news/vulnerabilities-and-exploits/coinminers-exploit-saltstack-vulnerabilities-cve-2020-11651-and-cve-2020-11652))

### High-profile victims (each verified)

- **LineageOS (custom Android OS).** Compromised **~8 PM PST, May 2, 2020**, forcing services offline. LineageOS stated: "Around 8 pm PST on May 2nd, 2020, an attacker used a CVE in our SaltStack master to gain access to our infrastructure." Android builds and signing keys were reported unaffected. ([The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html))

- **Ghost (blogging platform).** Compromised **~1:30 AM UTC, May 3, 2020**; attackers installed a cryptocurrency miner whose CPU spikes overloaded systems and triggered alerts. Ghost reported no customer data, passwords, or financial information were compromised. Ghost: "The mining attempt spiked CPUs and quickly overloaded most of our systems, which alerted us." ([The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html))

- **DigiCert (certificate authority).** Around the night of **May 3, 2020**, the key for **Certificate Transparency (CT) Log 2** — used to sign Signed Certificate Timestamps (SCTs) — was compromised, and that CT log was deactivated. DigiCert said other logs (CT 1, Yeti, Nessie) were unaffected and that it did "not believe the key was used to sign SCTs outside of the CT log's normal operation." ([The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html))

- **Xen Orchestra (Vates).** Infrastructure services became unreachable with elevated CPU usage; rogue salt-minion processes deployed cryptocurrency mining. ([BleepingComputer](https://www.bleepingcomputer.com/news/security/hackers-exploit-salt-rce-bugs-in-widespread-attacks-pocs-public/))

- **Algolia (search-as-a-service; powers Twitch, Hacker News, Stripe, etc.).** Hacked **May 3, 2020** via CVE-2020-11651. Attackers injected two payloads — a cryptocurrency miner and a backdoor — on **more than 500 servers**. Algolia concluded the attack's sole goal was crypto-mining, not data theft, and responded by reinstalling its SaltStack servers from scratch and rotating keys/secrets. ([Algolia: "Salt Incident: May 3rd 2020 Retrospective and Update"](https://www.algolia.com/blog/engineering/salt-incident-may-3rd-2020-retrospective-and-update); [SecurityWeek](https://www.securityweek.com/search-company-algolia-hacked-recent-salt-vulnerabilities/))

---

## 4. VMware acquires SaltStack (2020)

- **September 29, 2020 — Intent to acquire announced.** VMware announced its intent to acquire SaltStack in a blog post, just hours before kicking off its virtual VMworld 2020 conference (Sept 29–Oct 1). Ajay Singh, SVP/GM for VMware's Cloud Management Business Unit, said the deal would "significantly broaden [VMware's] software configuration management and infrastructure and network automation capabilities" and "help us complete our automation story." Financial terms were not disclosed at announcement. ([VMware news: Intent to acquire SaltStack](https://web.archive.org/web/2020/https://news.vmware.com/apps-cloud/intent-to-acquire-saltstack); [SiliconANGLE](https://siliconangle.com/2020/09/29/vmware-picks-infrastructure-automation-provider-saltstack/))

- **October 2020 — Deal completed.** VMware completed the acquisition in October 2020 (press coverage dated the completion to mid-October; one outlet published the completion on Oct 15, 2020). SaltStack was folded into VMware's vRealize Automation product line. ([Channel Post MEA: VMware completes acquisition](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/))

- **Purchase price: $51 million.** Per VMware's SEC Form 10-Q (quarter ended Oct 30, 2020), the total purchase price net of cash acquired was **$51 million** (≈$29M identifiable intangibles, ≈$24M goodwill). ([VMware Form 10-Q, FY2020 Q3](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm))

  > *Timing note:* The acquisition closed roughly five months after the CVE-2020-11651/11652 mass-exploitation events, which had put SaltStack's brand in the security spotlight.

---

## 5. Broadcom acquires VMware (2022–2023) and the impact on Salt

- **May 2022 — Deal announced.** Broadcom announced its agreement to acquire VMware. ([Manufacturing Dive](https://www.manufacturingdive.com/news/semiconductor-maker-broadcom-vmware-layoffs-almost-3k-new-york-virginia-california/702038/))

- **November 22, 2023 — Deal closed.** Broadcom completed its acquisition of VMware; VMware common stock ceased trading on the NYSE. ([DataCenterDynamics](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/))

- **Immediate layoffs.** Days after close, Broadcom issued WARN Act notices and began laying off employees — press reported on the order of ~2,000–3,000 cuts across locations including Broomfield (CO), Atlanta (GA), Bellevue (WA), and ~1,267 in California. ([DataCenterDynamics](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/); [Manufacturing Dive](https://www.manufacturingdive.com/news/semiconductor-maker-broadcom-vmware-layoffs-almost-3k-new-york-virginia-california/702038/))

- **Impact on the Salt team specifically.** The Salt Project team itself addressed this: per the Salt Project's own communications, the team at Broadcom is now "working with a much smaller team than in the past to reduce overall maintenance burden," following layoffs across the entire Tanzu Division throughout 2024. ([Salt Project Open Hour, May 2024](https://saltproject.io/blog/open-hour-2024-may-16/))

  > *Reported/uncertainty:* General VMware-wide layoff figures come from press (DataCenterDynamics, Manufacturing Dive); the specific characterization of a "much smaller" Salt team and Tanzu-division layoffs comes from the Salt Project's own Open Hour communications.

---

## 6. Salt's current open-source status (the Salt Project)

- **License.** Salt is open source under the **Apache License 2.0**, with the canonical repository at [github.com/saltstack/salt](https://github.com/saltstack/salt). ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)); [GitHub: saltstack/salt](https://github.com/saltstack/salt))

- **Stewardship.** The Salt Project remains an open-source ecosystem that **Broadcom** now sponsors and manages (SaltStack → VMware (2020) → Broadcom (2023)). ([Salt Project docs: About Salt Project](https://docs.saltproject.io/en/latest/topics/about_salt_project.html))

- **No relicensing planned.** At the **May 16, 2024** Open Hour, the Salt Project stated there are **no plans to change the license or community governance** — directly addressing community concerns about a possible move away from Apache 2.0 (a fear heightened by Broadcom's broader VMware changes). ([Salt Project Open Hour, May 2024](https://saltproject.io/blog/open-hour-2024-may-16/))

- **Infrastructure migration.** To integrate with Broadcom infrastructure/policies, the project migrated **off AWS public cloud** and consolidated services by **end of October 2024**, moving public repos under broadcom.com infrastructure. ([Salt Project Open Hour, May 2024](https://saltproject.io/blog/open-hour-2024-may-16/); [Lobsters discussion: repos moving to broadcom.com](https://lobste.rs/s/b7b2r0/saltproject_io_moving_all_public_repos))

- **Current release line.** As of early 2025, the stable release was **3006.10** (Wikipedia infobox dated March 19, 2025). ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)))

---

## Condensed timeline

| Date | Event | Source |
|---|---|---|
| 2011-03-19 | Salt first released by Thomas S. Hatch | [Wikipedia](https://en.wikipedia.org/wiki/Salt_(software)) |
| 2011-11 | Salt 0.9.3 (stable state system); FLOSS Weekly feature | [Wikipedia](https://en.wikipedia.org/wiki/Salt_(software)) |
| ~2012 | SaltStack, Inc. founded | [Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/) |
| 2013 (0.14.0) | salt-cloud / Salt Virt; multi-cloud (AWS/Azure/etc.) | [Wikipedia](https://en.wikipedia.org/wiki/Salt_(software)) / [Linux.com](https://www.linux.com/news/5-things-know-about-salt-cloud-management/) |
| 2020-03-12 | F-Secure first contacts SaltStack re CVEs | [WithSecure](https://labs.withsecure.com/advisories/saltstack-authorization-bypass) |
| 2020-04-29 | Patches 3000.2 & 2019.2.4 released | [WithSecure](https://labs.withsecure.com/advisories/saltstack-authorization-bypass) |
| 2020-04-30 | F-Secure public advisory (CVE-2020-11651/11652) | [WithSecure](https://labs.withsecure.com/advisories/saltstack-authorization-bypass) |
| 2020-05-02 | LineageOS compromised | [The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html) |
| 2020-05-03 | Ghost, DigiCert, Algolia, Xen Orchestra compromised | [The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html) / [Algolia](https://www.algolia.com/blog/engineering/salt-incident-may-3rd-2020-retrospective-and-update) |
| 2020-05-04 | SaltStack official advisory; mass cryptojacking underway | [Salt Project](https://saltproject.io/security-announcements/2020-05-04-advisory/) |
| 2020-09-29 | VMware announces intent to acquire SaltStack (VMworld) | [VMware](https://web.archive.org/web/2020/https://news.vmware.com/apps-cloud/intent-to-acquire-saltstack) |
| 2020-10 | VMware completes SaltStack acquisition ($51M) | [Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/) / [VMware 10-Q](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm) |
| 2022-05 | Broadcom announces intent to acquire VMware | [Manufacturing Dive](https://www.manufacturingdive.com/news/semiconductor-maker-broadcom-vmware-layoffs-almost-3k-new-york-virginia-california/702038/) |
| 2023-11-22 | Broadcom closes VMware acquisition; layoffs begin | [DataCenterDynamics](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/) |
| 2024-05-16 | Salt Project: no license/governance change planned | [Salt Project](https://saltproject.io/blog/open-hour-2024-may-16/) |
| 2024-10 | Salt Project off AWS; repos under Broadcom infra | [Salt Project](https://saltproject.io/blog/open-hour-2024-may-16/) / [Lobsters](https://lobste.rs/s/b7b2r0/saltproject_io_moving_all_public_repos) |

---

## Could not fully verify / caveats

- **Could not verify the exact day VMware *closed* the SaltStack acquisition.** Press placed completion in mid-October 2020 (one outlet: Oct 15, 2020; another widely cited date is Oct 13), and VMware's 10-Q confirms it closed in fiscal-2021 Q3 (quarter ended Oct 30, 2020), but the precise close date is not nailed down by a single primary source here. ([Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/); [VMware 10-Q](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm))
- **Could not verify exact total Salt-team headcount before/after Broadcom layoffs.** The Salt Project confirmed a "much smaller team" and Tanzu-division layoffs through 2024, but no specific Salt-team numbers were published. ([Salt Project Open Hour, May 2024](https://saltproject.io/blog/open-hour-2024-may-16/))
- **Could not verify a precise SaltStack-company founding date from a primary source.** "Founded in 2012" comes from acquisition-era press characterizations, not an official SaltStack incorporation record. ([Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/))
- **DigiCert / Ghost / LineageOS victim quotes** are sourced via The Hacker News' aggregation of the victims' own statements; the original victim post-mortem pages were not separately fetched here, though the quotes are consistently reported across outlets. ([The Hacker News](https://thehackernews.com/2020/05/saltstack-rce-exploit.html))

---

## Key people & teams (chronological)

### Thomas S. Hatch — creator of Salt, CTO/co-founder of SaltStack

- **Background before Salt.** Before founding SaltStack, Hatch worked as principal cloud architect for Beyond Oblivion, a software engineer for Applied Signal Technology, and a systems administrator for Backcountry.com. He has described building fully automated, secure IT environments for the U.S. intelligence community over a career spent automating data-center infrastructure. ([Open Source Underdogs Ep. 8: SaltStack with Thomas Hatch](https://opensourceunderdogs.com/episode-8-saltstack-cloud-configuration-management-software-with-thomas-hatch/); [O'Reilly author page: Thomas Hatch](https://www.oreilly.com/pub/au/6240))

- **Why he built Salt (and on ZeroMQ).** Hatch created Salt in 2011 after becoming "frustrated with the speed and limitations of the legacy systems management options" — designing it "from the beginning as a high-speed remote execution platform" for web-scale automation. ([AiThority interview with Thomas Hatch, 2019-11-29](https://aithority.com/interviews/ait-megamind/aithority-interview-with-thomas-hatch-cto-and-co-founder-at-saltstack/)) The choice of the ZeroMQ messaging library was driven by those high-speed requirements; Salt's networking layers were built on ZeroMQ to meet them. ([Wikipedia: Salt (software)](https://en.wikipedia.org/wiki/Salt_(software)); [ZeroMQ wiki: Salt](http://wiki.zeromq.org/story:4))

- **Recognition.** In 2012 Hatch received Black Duck's "Rookie of the Year" award, and Salt appeared on the GitHub Octoverse list in both 2012 and 2013 for leading a project with one of the highest counts of unique contributors. ([Open Source Underdogs Ep. 8](https://opensourceunderdogs.com/episode-8-saltstack-cloud-configuration-management-software-with-thomas-hatch/))

- **Role over time: CTO/principal architect.** Hatch served as CTO and co-founder of SaltStack and is consistently identified as the project's "creator and principal architect." ([AiThority interview, 2019-11-29](https://aithority.com/interviews/ait-megamind/aithority-interview-with-thomas-hatch-cto-and-co-founder-at-saltstack/))

- **At VMware (2020–2023) and Broadcom (2023–2024).** After VMware acquired SaltStack in 2020 Hatch moved into VMware as an engineering leader (his Crunchbase profile lists "Sr Staff Engineer / Director of Engineering @ VMware"). ([Crunchbase: Thomas Hatch](https://www.crunchbase.com/person/thomas-hatch)) He continued to act as the lead technical voice for the project under Broadcom; for example, the January 2024 policy-changes post announcing the end of the SEP process and module migration is published in his voice ("We are changing issue tracking and pull request policies… The Salt Enhancement Proposals process will also be ended: I do not feel that the SEP process has been a success."). ([Salt Project: Salt Project changes in policy, 2024-01-17](https://saltproject.io/blog/salt-project-policy-changes/))

- **Left Broadcom in 2024 (verify — yes, he left; stayed involved in Salt community).** On **May 16, 2024** Hatch announced he was exiting Broadcom: "It's with mixed emotions that I announce the time has come for me to say goodbye, and move on to the next chapter." He stated his intent to remain involved with the open-source Salt Project ("Tom Hatch is here to stay, and I plan to push forward in new ways!") and expressed confidence that "Salt is in good hands… in a position to continue to grow and thrive." ([Salt Project: I'm exiting Broadcom — Staying with Salt Project forever, 2024-05-16](https://saltproject.io/blog/tom-exits-broadcom-stays-with-salt/))

- **What he did next: ContextOS.** Hatch went on to co-found and lead a new company, **ContextOS** (Salt Lake City, UT), where he is listed as Co-founder and CEO, pursuing "enterprise-grade infrastructure that's approachable by anyone." Early ContextOS team members named publicly include several long-time Salt collaborators: C. R. Oldham, Gareth Greenaway, J. Patrick Moffitt, Joe Eacott, and David Boucha. ([Thomas S Hatch — LinkedIn (Co-founder & CEO of ContextOS)](https://www.linkedin.com/in/thhatch); [RocketReach: Thomas Hatch, ContextOS Co-founder and CEO](https://rocketreach.co/thomas-hatch-email_938181))

  > *Sequencing note:* The May 16, 2024 exit post does not itself name ContextOS; the ContextOS co-founder/CEO role is documented via Hatch's later LinkedIn/RocketReach profiles. The exact ContextOS founding date is not nailed down by a primary source here (see caveats).

### Marc W. Chenn — co-founder and CEO of SaltStack

- **Co-founder / CEO.** SaltStack's commercial entity was co-founded by Marc Chenn (CEO) and Thomas Hatch (CTO); Chenn held the CEO role from the company's founding (his profiles date this to June 2012). ([Crunchbase: Marc W. Chenn](https://www.crunchbase.com/person/marc-chenn); [The Org: Marc Chenn, CEO/Co-Founder/Board Member at SaltStack](https://theorg.com/org/saltstack/org-chart/marc-chenn))

- **Background.** Chenn is originally from Hong Kong, earned an undergraduate degree and an MBA in finance from Brigham Young University, and previously held sales/associate roles at Compliance11 (acquired by Charles Schwab), Altiris (IPO, later acquired by Symantec), Morgan Stanley, and Goldman Sachs. ([The Software Report: Marc Chenn](https://web.archive.org/web/2id_/https://www.thesoftwarereport.com/top-leaders/marc-chenn/); [Crunchbase: Marc W. Chenn](https://www.crunchbase.com/person/marc-chenn))

- **Funding led as CEO.** Under Chenn, SaltStack raised seed and Series A financing; his profiles cite roughly **$31 million** in total venture funding led through those rounds. ([The Software Report: Marc Chenn](https://web.archive.org/web/2id_/https://www.thesoftwarereport.com/top-leaders/marc-chenn/))

### Other early SaltStack / Salt contributors

- **Founding-era collaborators.** Beyond the two co-founders, **C. R. Oldham, Gareth Greenaway, J. Patrick Moffitt, Joe Eacott, and David Boucha** are repeatedly named as people who helped build the Salt Project and SaltStack and worked with infrastructures across the globe; several later regrouped around Hatch at ContextOS. ([Open Source Underdogs Ep. 8](https://opensourceunderdogs.com/episode-8-saltstack-cloud-configuration-management-software-with-thomas-hatch/); [Thomas S Hatch — LinkedIn](https://www.linkedin.com/in/thhatch))

### VMware acquisition (2020) — which org absorbed the Salt team

- **Folded into VMware's cloud-management line.** Following the October 2020 acquisition, SaltStack's product was integrated into VMware's automation/cloud-management portfolio, surfacing as **vRealize Automation SaltStack Config** (vRealize being VMware's Cloud Management Business Unit product line, the same unit whose SVP/GM Ajay Singh announced the deal). ([VMware: Intent to acquire SaltStack](https://web.archive.org/web/2020/https://news.vmware.com/apps-cloud/intent-to-acquire-saltstack); [Channel Post MEA: VMware completes acquisition](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/))

- **Rebranding chain under VMware/Broadcom.** The product was subsequently rebranded as **VMware Aria Automation Config** (when vRealize → Aria) and then as **VMware Tanzu Salt**. After the Broadcom acquisition, "the existing VMware Tanzu Salt solution is now supported by the **Broadcom VCF (VMware Cloud Foundation) Business Unit** and will be supported through October 2028." Broadcom's own communications describe Salt as "an essential software component of many VMware by Broadcom products within its **Tanzu and VCF** divisions." ([Broadcom KB: Tanzu Salt transitioning, knowledge.broadcom.com/external/article/413088](https://knowledge.broadcom.com/external/article/413088/the-vmware-tanzu-salt-solution-is-transi.html); [Salt Project: Community Core Maintainer Program, 2024-06-25](https://saltproject.io/blog/community-maintainers-wanted/))

### Broadcom acquisition (2023) — impact on the Salt team & leadership

- **Smaller team after layoffs (sourced).** After Broadcom closed its VMware acquisition on **November 22, 2023** and began company-wide layoffs, the Salt Project itself stated it is "working with a much smaller team than in the past to reduce overall maintenance burden," following layoffs across the entire Tanzu Division throughout 2024. ([Salt Project Open Hour, 2024-05-16](https://saltproject.io/blog/open-hour-2024-may-16/); [DataCenterDynamics: layoffs hit VMware days after Broadcom close](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/))

- **Departure of the founder (sourced fact, not rumor).** The most clearly documented leadership change is Thomas Hatch's own departure from Broadcom, announced May 16, 2024 (see above). ([Salt Project: I'm exiting Broadcom, 2024-05-16](https://saltproject.io/blog/tom-exits-broadcom-stays-with-salt/))

  > *Fact vs. rumor:* The "much smaller team"/Tanzu-division-layoffs characterization is the Salt Project's own wording; broader VMware layoff figures are press estimates (DataCenterDynamics). Beyond Hatch, this research did not find primary-sourced, named accounts of which specific Salt engineers departed, so individual departures beyond Hatch are left unstated rather than guessed.

### The Salt Project community / maintainer structure today

- **Core Team within Broadcom.** Many core Salt Project contributors are Broadcom employees; this "Salt Core Team" reviews and enhances Salt modules. ([Salt Project docs: About Salt Project](https://docs.saltproject.io/en/latest/topics/about_salt_project.html); [Salt Project: Community Core Maintainer Program, 2024-06-25](https://saltproject.io/blog/community-maintainers-wanted/))

- **End of the SEP governance process.** Historically, new features flowed through the **Salt Enhancement Proposal (SEP)** process, which required approval from five core-team members, with Hatch holding a final veto as project creator. ([saltstack/salt-enhancement-proposals (README)](https://github.com/saltstack/salt-enhancement-proposals/blob/master/README.md)) On **January 17, 2024**, the project announced it was **ending the SEP process** ("I do not feel that the SEP process has been a success") and migrating the bulk of modules out of the core codebase toward an "ecosystem focus." ([Salt Project: Salt Project changes in policy, 2024-01-17](https://saltproject.io/blog/salt-project-policy-changes/))

- **Community Core Maintainer Program (2024).** To re-broaden contribution, the project launched a **Community Core Maintainer Program** (announced **June 25, 2024** by community manager **Jimmy Chunga**), inviting selected community members to work directly with the Salt Core Team and attend a weekly stand-up. ([Salt Project: Salt Project Launches Community Core Maintainer Program!, 2024-06-25](https://saltproject.io/blog/community-maintainers-wanted/))

#### Could not verify (this section)

- **Could not verify the exact ContextOS founding date** (or whether Hatch holds the CEO title from inception). Sourced only to Hatch's LinkedIn/RocketReach profiles, not an incorporation record or company announcement. ([LinkedIn: Thomas S Hatch](https://www.linkedin.com/in/thhatch); [RocketReach: Thomas Hatch](https://rocketreach.co/thomas-hatch-email_938181))
- **Could not verify the full product-renaming chain from a single primary source.** "vRealize Automation SaltStack Config → Aria Automation Config → Tanzu Salt → (supported by) VCF Business Unit" is assembled from VMware/Broadcom materials; the Broadcom KB confirms the Tanzu Salt → VCF/Oct-2028 support and the Aria Automation Config branding, but a single authoritative timeline of every rename was not located. ([Broadcom KB 413088](https://knowledge.broadcom.com/external/article/413088/the-vmware-tanzu-salt-solution-is-transi.html))
- **Could not verify named, primary-sourced accounts of Salt engineers (other than Hatch) leaving after the Broadcom acquisition.** Only the aggregate "much smaller team" statement is sourced. ([Salt Project Open Hour, 2024-05-16](https://saltproject.io/blog/open-hour-2024-may-16/))
- **Could not verify Marc Chenn's role/whereabouts after the VMware acquisition** from a primary source in this research. The "$31M raised" and "CEO since June 2012" figures come from profile aggregators (The Software Report, Crunchbase), not SaltStack filings. ([Crunchbase: Marc W. Chenn](https://www.crunchbase.com/person/marc-chenn))

---

## Company & corporate history (chronological)

*The business/corporate story of SaltStack, Inc. as a venture-backed company — founding, funding, business model, and the two acquisitions that absorbed it. (Distinct from the people-focused section above; here the emphasis is the corporate entity, its capital, and its product line.)*

### Founding (2012)

- **SaltStack, Inc. founded in 2012.** The commercial entity backing the open-source Salt project was founded in 2012 by Thomas Hatch (creator/principal architect of Salt, CTO) and Marc Chenn (CEO). ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))

- **Headquarters: Utah (Lehi / Salt Lake City).** Sources differ on the exact municipality: SaltStack's own Series A press release datelines the company in **Salt Lake City**, while several company profiles list **Lehi, Utah** (both are in the Salt Lake metro / "Silicon Slopes" corridor). ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))

### Business model: open-source Salt + SaltStack Enterprise

- **Open core / commercial-on-top model.** SaltStack's business was built around the free, Apache-2.0 open-source Salt project as the foundation, with a paid commercial layer — **SaltStack Enterprise** (later **SaltStack Config**) — sold on top. The enterprise product added a web console with dashboards/reports, role-based access control with LDAP integration, database encryption, activity auditing, and commercial support, none of which shipped in core Salt. ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html); [InfoWorld: Review — SaltStack shifts devops into high gear](https://www.infoworld.com/article/2256718/review-saltstack-shifts-devops-into-high-gear.html))

- **Positioning.** The company positioned SaltStack Enterprise as event-driven automation for configuration management, security compliance, and orchestration across hybrid cloud, network, IoT, and application environments. CEO Marc Chenn framed the value around configuration drift: "Eighty percent of all vulnerabilities stem from the fact that configurations have drifted, so connecting in real time to know when something changes enables you to be more proactive in your response." ([SiliconANGLE, 2018-02-16](https://siliconangle.com/2018/02/16/saltstacks-15-5m-series-funding-round-largest-ever-automation-firm/))

### Venture funding (~2012–2018, total $28M)

- **Total raised: ~$28 million.** By its 2018 Series A, SaltStack had raised a cumulative **$28 million** in venture funding. ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html); [SiliconANGLE, 2018-02-16](https://siliconangle.com/2018/02/16/saltstacks-15-5m-series-funding-round-largest-ever-automation-firm/))

- **Early/seed investors.** Prior to the Series A, SaltStack's existing investors were **Peak Capital (Peak Capital Partners), EPIC Ventures, and Deep Fork Capital**. ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html); [SiliconANGLE, 2018-02-16](https://siliconangle.com/2018/02/16/saltstacks-15-5m-series-funding-round-largest-ever-automation-firm/))

- **February 14, 2018 — $15.5M Series A led by Mercato Partners.** SaltStack closed a **$15.5 million Series A** round led by **Mercato Partners**, additive to the prior Peak Capital / EPIC Ventures / Deep Fork Capital investments and bringing total funding to $28 million. **Ryan Sanders** of Mercato Partners joined SaltStack's board of directors. The capital was earmarked for product/engineering headcount and expanded sales and marketing to accelerate SaltStack Enterprise adoption. ([SaltStack Series A press release, PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))

- **"Largest-ever" framing.** SaltStack billed the round as "the largest-ever Series A financing round in its market's history," explicitly contrasting it with the much smaller Series A rounds of competitors Puppet (~$2 million) and Chef (~$2.5 million). ([SiliconANGLE, 2018-02-16](https://siliconangle.com/2018/02/16/saltstacks-15-5m-series-funding-round-largest-ever-automation-firm/))

### VMware acquisition (2020)

- **September 29 / October 1, 2020 — VMware announces intent to acquire.** VMware announced its intent to acquire SaltStack around the opening of its virtual VMworld 2020 conference. **Ajay Singh**, head of VMware's Cloud Management Business Unit, said SaltStack would help VMware deliver an "end-to-end automation solution with integrated configuration management" and "help us to complete our automation story." VMware noted Salt had been downloaded over 17 million times and said it would continue supporting other config tools (Puppet, Ansible, Terraform). ([RCR Wireless: VMware 'completes its automation story' with SaltStack acquisition, 2020-10-01](https://www.rcrwireless.com/20201001/telco-cloud/vmware-completes-its-automation-story-with-saltstack-acquisition))

- **October 2020 — Acquisition completed.** VMware completed the acquisition in October 2020 (press dated completion to mid-October; one outlet cites October 13, 2020). SaltStack became part of VMware's **vRealize Automation** product line as its configuration-management, infrastructure-automation and SecOps offering. ([Channel Post MEA: VMware completes acquisition, 2020-10-15](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/); [RCR Wireless, 2020-10-01](https://www.rcrwireless.com/20201001/telco-cloud/vmware-completes-its-automation-story-with-saltstack-acquisition))

- **Purchase price: $51 million.** Per VMware's SEC Form 10-Q (fiscal Q3, quarter ended Oct 30, 2020), the total purchase price net of cash acquired was **$51 million** (≈$29M identifiable intangibles, ≈$24M goodwill). ([VMware Form 10-Q, FY2021 Q3](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm))

  > *Corporate-timing note:* The deal closed roughly five months after the CVE-2020-11651/11652 mass-exploitation events. The $51M price was modest relative to the company's $28M raised, reflecting a non-headline outcome for investors.

- **Product line within VMware.** SaltStack's product surfaced inside VMware's cloud-management portfolio as **vRealize Automation SaltStack Config**, later rebranded **VMware Aria Automation Config** (when vRealize → Aria) and then **VMware Tanzu Salt**. ([Broadcom KB 413088: VMware Tanzu Salt transitioning](https://knowledge.broadcom.com/external/article/413088/the-vmware-tanzu-salt-solution-is-transi.html))

### Broadcom acquisition (2023) and Salt under Broadcom/Tanzu

- **November 22, 2023 — Broadcom closes VMware acquisition.** Broadcom (announced May 2022) completed its ~$61B acquisition of VMware on November 22, 2023; VMware common stock ceased trading on the NYSE, and company-wide layoffs began within days. SaltStack's product line carried over to Broadcom along with the rest of VMware. ([DataCenterDynamics: layoffs hit VMware days after Broadcom close](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/))

- **Salt's home inside Broadcom: Tanzu / VCF.** Under Broadcom, the commercial product became **VMware Tanzu Salt**, shipped as part of the **VMware Tanzu Platform** (Tanzu Platform 10, announced August 2024) — bundled with Tanzu Platform Self-Managed and offered as SaaS, with compliance/vulnerability-management integrations (Tenable, Qualys, Carbon Black). Broadcom describes Tanzu Salt as "powered by Salt, an open-source automation and configuration management engine sponsored, approved, and sanctioned by Broadcom." Per Broadcom's support KB, Tanzu Salt is now supported by the **Broadcom VCF (VMware Cloud Foundation) Business Unit**, with support stated through October 2028. ([Broadcom: VMware Tanzu Platform 10 announcement, 2024](https://news.broadcom.com/releases/vmware-explore-2024-tanzu); [Broadcom KB 413088](https://knowledge.broadcom.com/external/article/413088/the-vmware-tanzu-salt-solution-is-transi.html))

### Current open-source status of the underlying project

- **Salt remains open source under Apache-2.0, as the "Salt Project."** Independent of the commercial Tanzu Salt product, the underlying engine continues as the open-source **Salt Project** under the **Apache License 2.0**, with the canonical repo at [github.com/saltstack/salt](https://github.com/saltstack/salt). Broadcom sponsors and manages the project (lineage: SaltStack, Inc. → VMware (2020) → Broadcom (2023)), and at its May 16, 2024 Open Hour the project stated there were no plans to change the license or governance. ([GitHub: saltstack/salt](https://github.com/saltstack/salt); [Salt Project docs: About Salt Project](https://docs.saltproject.io/en/latest/topics/about_salt_project.html); [Salt Project Open Hour, 2024-05-16](https://saltproject.io/blog/open-hour-2024-may-16/))

### Corporate-history timeline

| Date | Event | Source |
|---|---|---|
| 2012 | SaltStack, Inc. founded (Hatch + Chenn), Utah | [PRNewswire](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html) |
| ~2012–2017 | Seed/early funding from Peak Capital, EPIC Ventures, Deep Fork Capital | [PRNewswire](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html) |
| 2018-02-14 | $15.5M Series A led by Mercato Partners; total funding $28M; Ryan Sanders joins board | [PRNewswire](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html) / [SiliconANGLE](https://siliconangle.com/2018/02/16/saltstacks-15-5m-series-funding-round-largest-ever-automation-firm/) |
| 2020-09-29 / 10-01 | VMware announces intent to acquire SaltStack (VMworld 2020) | [RCR Wireless](https://www.rcrwireless.com/20201001/telco-cloud/vmware-completes-its-automation-story-with-saltstack-acquisition) |
| 2020-10 | VMware completes acquisition ($51M); folded into vRealize Automation | [Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/) / [VMware 10-Q](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm) |
| 2023-11-22 | Broadcom closes VMware acquisition; Salt carried over | [DataCenterDynamics](https://www.datacenterdynamics.com/en/news/layoffs-hit-vmware-days-after-completion-of-broadcom-acquisition/) |
| 2024-08 | VMware Tanzu Salt shipped within Tanzu Platform 10 (Broadcom) | [Broadcom](https://news.broadcom.com/releases/vmware-explore-2024-tanzu) |
| ongoing | Salt remains open source (Apache-2.0), sponsored by Broadcom | [GitHub: saltstack/salt](https://github.com/saltstack/salt) / [Salt Project docs](https://docs.saltproject.io/en/latest/topics/about_salt_project.html) |

### Could not verify (corporate-history section)

- **Could not verify a separate, dated seed-round announcement or per-investor amounts.** Primary sources confirm Peak Capital, EPIC Ventures, and Deep Fork Capital as pre-Series-A investors and a $28M cumulative total, but no primary source breaks out the seed round's date or the dollars contributed by each early investor. The "$27–31M raised" figure in the brief reconciles with the **$28M total** confirmed by SaltStack's own 2018 press release; the higher "$31M" figure comes only from profile aggregators. ([PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))
- **Could not pin the exact HQ municipality from a single authoritative record.** SaltStack's own press release says Salt Lake City; other profiles say Lehi, Utah. Both sit in the same Utah metro area. ([PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))
- **Could not verify the precise day VMware *closed* the SaltStack acquisition** from a single primary source. Press places completion in mid-October 2020 (e.g., Oct 13 and Oct 15 cited by different outlets); VMware's 10-Q confirms it closed in the quarter ended Oct 30, 2020. ([Channel Post MEA](https://channelpostmea.com/2020/10/15/vmware-completes-acquisition-saltstack/); [VMware 10-Q](https://www.sec.gov/Archives/edgar/data/0001124610/000112461020000061/vmw-1030202010xq.htm))
- **Could not verify a precise official incorporation/founding date** beyond the year 2012, which is stated in SaltStack's own materials. ([PRNewswire, 2018-02-14](https://www.prnewswire.com/news-releases/saltstack-completes-series-a-financing-round-led-by-mercato-partners-bringing-total-funding-to-28-million-300598470.html))
