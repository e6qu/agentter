# Ansible: A Chronological History

A timeline of Ansible focused on **cloud-API integration** and on
**controversies, acquisitions, and community drama**. Every factual claim
below carries an inline link to a primary or reputable source. Where a claim
is a *report*, *rumor*, or *opinion* rather than an established fact, it is
attributed to its source and labeled. Claims that could not be verified are
listed explicitly at the end.

---

## 2012 — Founding

- **February 20, 2012:** Ansible's initial release. Ansible was created by
  **Michael DeHaan**, who had previously worked at Red Hat on the Cobbler
  provisioning tool and on Func (Fedora Unified Network Controller).
  ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

- **Why it was built:** DeHaan was frustrated that even with existing tooling
  it "still took several days (or longer) to get a setup working due to DNS and
  NTP problems," and he wanted to "build something SSH- and push-based, without
  a load of management agents."
  ([How Ansible got started and grew, Opensource.com](https://opensource.com/article/21/2/ansible-origin-story))

- **The agentless / SSH model — why it differed from Chef and Puppet:**
  Ansible is **agentless**. It connects to managed machines over SSH (or, on
  Windows, WinRM/PowerShell) and pushes work to them, rather than requiring a
  persistent daemon/agent installed on every node and a central server that
  nodes poll. Red Hat later described this directly: "Ansible's simple and
  agentless approach, unlike competing solutions, does not require any special
  coding skills."
  ([Red Hat press release, Oct 16, 2015](https://www.redhat.com/en/about/press-releases/red-hat-acquire-it-automation-and-devops-leader-ansible);
  agentless architecture per [Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))
  By contrast, **Chef** and **Puppet** (the dominant configuration-management
  tools at the time) were primarily agent/pull-based and required more setup;
  Ansible was positioned as "an easy, quick solution" that "one person could
  employ in less than one day."
  ([Opensource.com origin story](https://opensource.com/article/21/2/ansible-origin-story))

---

## 2013 — AnsibleWorks, Inc.

- **2013:** The company **AnsibleWorks, Inc.** was founded by **Michael DeHaan,
  Timothy Gerla, and Saïd Ziouani** to commercially support and sponsor the
  open-source Ansible project. AnsibleWorks was later renamed **Ansible, Inc.**
  ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

- The name **"AWX"** originates as shorthand for "AnsibleWorks" — this naming
  later resurfaced when the commercial UI product was open-sourced (see 2017).
  ([Jeff Geerling: Ansible open-sources Tower with AWX](https://www.jeffgeerling.com/blog/2017/ansible-open-sources-ansible-tower-awx/);
  also [AWX project](https://github.com/ansible/awx))

---

## 2014 — Tower and early features

- **2014:** Ansible's commercial web UI / management product was branded
  **Ansible Tower** (from version 1.4); prior to that it had been sold under the
  **AWX** name. The **Ansible Vault** secrets-encryption feature also dates to
  this era.
  ([Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software));
  Tower/AWX naming per [Jeff Geerling](https://www.jeffgeerling.com/blog/2017/ansible-open-sources-ansible-tower-awx/))

---

## January 2015 — Michael DeHaan steps away (community drama #1)

- **January 30, 2015:** Michael DeHaan publicly announced he was leaving the
  project in a post titled **"Happy Trails, Ansible."** This was *before* the
  Red Hat acquisition. Day-to-day project leadership passed to **James
  Cammarata**.
  ([Hacker News thread "Michael DeHaan leaves Ansible," posted 2015-01-30](https://news.ycombinator.com/item?id=8973916),
  which links to DeHaan's post at
  `http://michaeldehaan.net/post/109595670406/happy-trails-ansible`)

  > Note: DeHaan's original blog post URL
  > (`michaeldehaan.net/post/109595670406/happy-trails-ansible`) currently
  > redirects and was not directly fetchable during this research; the date,
  > title, and leadership-handoff details are taken from the Hacker News
  > submission (which mirrors the title and date) and the discussion thread in
  > which DeHaan himself commented about the upcoming "v2" refactor.

---

## October 2015 — Red Hat acquires Ansible

- **October 16, 2015:** Red Hat announced a definitive agreement to acquire
  **Ansible, Inc.** Red Hat framed Ansible as "a clear leader in IT automation
  and DevOps" (Joe Fitzgerald, VP Management) and emphasized the agentless model
  and hybrid-cloud management story.
  ([Red Hat press release](https://www.redhat.com/en/about/press-releases/red-hat-acquire-it-automation-and-devops-leader-ansible);
  [Red Hat 8-K exhibit on SEC EDGAR](https://www.sec.gov/Archives/edgar/data/0001087423/000119312515345189/d52998dex991.htm))

- **Price — established fact vs. reported figure:** Red Hat **did not officially
  disclose** the purchase price; the press release contains no dollar figure.
  The widely cited **~$150 million** number comes from press reporting, not an
  official Red Hat statement.
  ([TechCrunch, Oct 16, 2015 — "reportedly for around"](https://techcrunch.com/2015/10/16/red-hat-is-buying-it-automation-startup-ansible-reportedly-for-around-100m/);
  [Tech Times, $150M](https://www.techtimes.com/articles/96421/20151016/red-hat-picks-up-ansible-for-150-million-to-beef-up-hybrid-cloud-management.htm))
  Red Hat's own acquisition FAQ confirms the team was ~50 employees in Durham,
  NC, and that Red Hat planned to continue both Ansible (open source) and
  Ansible Tower.
  ([FAQ: Red Hat Acquires Ansible](https://www.redhat.com/en/blog/faq-red-hat-acquires-ansible))

---

## September 2017 — Ansible Tower open-sourced as AWX

- **September 2017:** Having committed at acquisition time to open-sourcing
  Tower, Red Hat released the **AWX** project as the open-source upstream of
  Ansible Tower. The relationship was explicitly modeled on **Fedora → RHEL**:
  AWX is the fast-moving upstream, and Tower is a hardened, supported snapshot
  built from selected AWX releases.
  ([Jeff Geerling: Ansible open-sources Ansible Tower with AWX](https://www.jeffgeerling.com/blog/2017/ansible-open-sources-ansible-tower-awx/);
  [eWeek coverage](https://www.eweek.com/enterprise-apps/red-hat-launches-open-source-ansible-tower-awx-automation-project/);
  [AWX project on GitHub](https://github.com/ansible/awx))

---

## October 2018 / July 2019 — IBM acquires Red Hat ($34B)

- **October 28, 2018:** IBM announced its intent to acquire Red Hat for
  **$190.00 per share in cash**, a total enterprise value of **approximately
  $34 billion** — IBM's largest acquisition ever.
  ([Red Hat press release on IBM acquisition](https://www.redhat.com/en/about/press-releases/ibm-acquire-red-hat-completely-changing-cloud-landscape-and-becoming-worlds-1-hybrid-cloud-provider);
  [Red Hat 8-K, SEC EDGAR FY2018](https://www.sec.gov/Archives/edgar/data/0001087423/000119312518309766/d638933dex991.htm))

- **July 9, 2019:** The acquisition **closed**. The closing announcement named
  Ansible explicitly among Red Hat's mainstream-enterprise open-source
  technologies: "technologies like Linux, Kubernetes, **Ansible**, Java, Ceph
  and many more."
  ([IBM Closes Landmark Acquisition of Red Hat for $34 Billion](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future);
  [IBM 8-K, SEC EDGAR FY2019](https://www.sec.gov/Archives/edgar/data/0000051143/000095014219001515/eh1900893_ex9901.htm))

- **What it meant for Ansible:** Ansible became part of IBM's hybrid-cloud
  automation strategy. Red Hat continued to operate Ansible, and the product
  line was later consolidated under the **Red Hat Ansible Automation Platform**
  branding.

---

## 2020 — Cloud-API integration and the "Collections" split

This year is pivotal for both the cloud-modules story and the biggest
architectural/community shift in Ansible's history.

### Cloud modules → Collections

- Historically, Ansible's cloud support (AWS, Azure, GCP, etc.) shipped as
  modules inside the single `ansible/ansible` monorepo. AWS modules were built
  on the Python **boto / botocore / boto3** SDKs.
  ([amazon.aws dev guidelines](https://docs.ansible.com/ansible/latest/collections/amazon/aws/docsite/dev_guidelines.html))

- **June 22, 2020:** The **`amazon.aws`** collection reached **version 1.0.0**
  (the 1.0.0 git tag commit is dated 2020-06-22), splitting AWS content out of
  the monorepo into a standalone, independently versioned collection on Ansible
  Galaxy. It is maintained by the Ansible Cloud Content team.
  ([amazon.aws 1.0.0 tag, GitHub](https://github.com/ansible-collections/amazon.aws/tree/1.0.0);
  [amazon.aws repo](https://github.com/ansible-collections/amazon.aws))

- **SDK evolution:** Starting with the **4.0** releases of `amazon.aws` (and the
  sibling `community.aws`), support for the original **boto** SDK was dropped —
  modules must use **botocore + boto3**. The collections follow a rolling
  support policy of supporting boto3/botocore versions released within the
  prior ~12 months.
  ([amazon.aws release notes / CHANGELOG](https://docs.ansible.com/ansible/latest/collections/amazon/aws/docsite/CHANGELOG.html);
  [dev guidelines](https://docs.ansible.com/ansible/latest/collections/amazon/aws/docsite/dev_guidelines.html))

### The 2.10 split: ansible-base vs. the Ansible community package

- **The big change:** Ansible had been "an outlier from most other open source
  projects in storing all contributed content in one giant repository… a giant
  open source monorepo was too burdensome to maintain." In 2.10, most modules
  and plugins were moved out of `ansible/ansible` into separate **Collections**
  distributed via **Ansible Galaxy**.
  ([Jeff Geerling: Collections signal a major shift in the Ansible ecosystem](https://www.jeffgeerling.com/blog/2020/collections-signal-major-shift-ansible-ecosystem/);
  [Ansible 2.10 collections roadmap](https://docs.ansible.com/ansible/latest/roadmap/COLLECTIONS_2_10.html))

- **August 13, 2020:** **`ansible-base` 2.10.0** released — the slimmed-down
  engine (the package later renamed **`ansible-core`**). Release engineer Rick
  Elrod described it as "the culmination of several years of effort to decouple
  Ansible engine releases from Ansible content releases."
  ([ansible-base 2.10.0 announcement, ansible-project list](https://www.mail-archive.com/ansible-project@googlegroups.com/msg53862.html);
  [ansible-base 2.10 roadmap](https://docs.ansible.com/ansible/latest/roadmap/ROADMAP_2_10.html))

- **September 22, 2020:** The **`ansible` community package 2.10.0** released —
  a curated "batteries-included" bundle of `ansible-base` plus a snapshot of
  community collections, preserving the familiar single-install experience.
  ([ansible-2.10.0 release announcement, ansible-announce list](https://groups.google.com/g/ansible-announce/c/QxIOml3i62A))

- **Why two version numbers now exist:** From 2.10 onward the **engine** (now
  `ansible-core`) and the **community package** (`ansible`) version
  independently — a frequent source of user confusion.
  ([Jeff Geerling](https://www.jeffgeerling.com/blog/2020/collections-signal-major-shift-ansible-ecosystem/))

- **Community reaction (reported/opinion):** Jeff Geerling — one of the most
  prominent community voices — called Collections a "major shift" and documented
  both the upside (independent release cadences, clearer support boundaries) and
  the pain (migration churn, confusion over what lives where, fully-qualified
  collection names like `amazon.aws.ec2`). Attributed to Geerling's blog, not an
  official Red Hat position.
  ([Jeff Geerling](https://www.jeffgeerling.com/blog/2020/collections-signal-major-shift-ansible-ecosystem/))

- **A clear support-boundary motivation:** the split made it easier to
  distinguish content officially supported under the paid **Red Hat Ansible
  Automation Platform** from content maintained by the wider community (e.g., the
  `community.general` collection).
  ([community.general on GitHub](https://github.com/ansible-collections/community.general))

---

## 2021 — Inclusive-language terminology changes

- **Ansible Core 2.11** (shipped in the **Ansible 4.0** community package on
  **May 18, 2021**) deprecated harmful terminology and introduced replacements,
  beginning with four terms: **master, slave, blacklist, whitelist**. Examples:

  | Deprecated | Replacement |
  |---|---|
  | `whitelist` (e.g. `callback_whitelist`) | `enabled` (e.g. `callback_enabled`) |
  | `blacklist` (e.g. `BLACKLIST_EXTS`) | `reject` (e.g. `REJECT_EXTS`) |
  | `master` machine/node | `controller` machine/node |

  The old terms remained available via aliases for a full **four-release
  deprecation cycle**. In parallel, default Git branches across the Ansible and
  Ansible-collections GitHub organizations were renamed from `master` to
  **`main`**.
  ([Opensource.com: "Ansible emphasizes inclusive language," by Jill Rouleau, May 7, 2021](https://opensource.com/article/21/5/inclusive-language-ansible);
  [Red Hat AAP docs: making open source more inclusive](https://access.redhat.com/documentation/en-us/red_hat_ansible_automation_platform/2.3/html/creating_and_consuming_execution_environments/making-open-source-more-inclusive))

- Red Hat tied this to the **Inclusive Naming Initiative** and an internal
  Diversity & Inclusion working group.
  ([Opensource.com](https://opensource.com/article/21/5/inclusive-language-ansible))

---

## Branding evolution: Tower → automation controller → Automation Platform

- Over time, **Ansible Tower** was folded into the **Red Hat Ansible Automation
  Platform**, with the former Tower product becoming the **automation
  controller** component; **AWX** remains its open-source upstream.
  ([Red Hat: Ansible vs. Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible/ansible-vs-red-hat-ansible-automation-platform);
  [Red Hat AWX page](https://www.redhat.com/en/ansible-collaborative/awx))

---

## 2023–2025 — IBM-era layoffs and restructuring (community friction)

- **2023:** Red Hat conducted layoffs. Reporting indicates roughly **4% of the
  workforce** (~hundreds of employees). Coverage noted concerns within the
  community about morale and the open-source ethos under IBM ownership. (Reported
  by press / community forums — treat the precise headcount and the
  team-by-team impact as *reported*, not officially confirmed per team.)
  ([CIO: IBM to cut jobs as Red Hat growth slows](https://www.cio.com/article/4084855/ibm-to-cut-thousands-of-jobs-as-red-hat-growth-slows.html))

- **2025:** Further Red Hat layoffs/reorganization were reported, framed around
  an AI and cloud strategy shift, and reports that some back-office functions
  would move from Red Hat into IBM from 2026. (Reported by press/aggregators.)
  ([WebProNews](https://www.webpronews.com/red-hat-plans-global-layoffs-in-september-2025-for-ai-and-cloud-shift/);
  [Slashdot: Red Hat back-office team moving to IBM from 2026](https://linux.slashdot.org/story/25/09/09/0039236/red-hat-back-office-team-moving-to-ibm-from-2026))

  > These layoff items are sourced to secondary press and community forums, not
  > to Red Hat/IBM primary statements naming the Ansible team specifically. The
  > specific *impact on the Ansible community team* is **reported/rumored**, not
  > established from a primary source — see "Could not verify" below.

---

## Trademark / branding

- "Ansible" is a registered trademark now held by Red Hat, Inc.; Red Hat
  maintains a trademark-usage policy and trademark guidelines for community use
  (e.g. for AWX logos).
  ([ANSIBLE trademark registration, USPTO via Justia](https://trademarks.justia.com/858/50/ansible-85850148.html);
  [Ansible trademark usage docs](https://docs.ansible.com/ansible/latest/dev_guide/style_guide/trademarks.html);
  [awx-logos TRADEMARKS.md](https://github.com/ansible/awx-logos/blob/master/TRADEMARKS.md))

---

## Summary of what is established fact vs. reported/opinion

**Established (primary-sourced):**
- DeHaan created Ansible; initial release Feb 20, 2012; agentless/SSH model.
- AnsibleWorks/Ansible, Inc. founded 2013 by DeHaan, Gerla, Ziouani.
- DeHaan announced departure Jan 30, 2015 ("Happy Trails, Ansible"), before the
  Red Hat deal.
- Red Hat agreed to acquire Ansible **Oct 16, 2015**; **no official price**
  disclosed.
- AWX open-sourced **Sep 2017** as Tower's upstream.
- IBM→Red Hat announced **Oct 28, 2018** ($190/share, ~$34B); closed **Jul 9,
  2019**; Ansible named in the closing PR.
- `amazon.aws` collection 1.0.0 commit **2020-06-22**; boto→boto3 migration
  (boto dropped at 4.0).
- `ansible-base` 2.10.0 released **Aug 13, 2020**; `ansible` 2.10.0 community
  package **Sep 22, 2020**.
- Inclusive-language deprecations in **Core 2.11 / Ansible 4.0, May 18, 2021**;
  master→controller, whitelist→enabled, blacklist→reject; `master`→`main` branch
  renames.

**Reported / opinion (attributed, not primary):**
- The **~$100M–$150M** Ansible price (press reporting only).
- Community sentiment about Collections (Jeff Geerling).
- 2023/2025 Red Hat layoff scale and IBM-integration friction (press/forums).

---

## Key people & teams (chronological)

This section traces the **people and teams** behind Ansible over time. It
re-uses, but does not modify, facts established earlier in this file; new
claims carry their own inline sources. Items that could not be confirmed are
flagged inline and collected at the end.

### Michael DeHaan — creator (career before Ansible)

- **Red Hat (joined 2005):** DeHaan joined Red Hat's **emerging technologies
  team** around 2005, where he was given latitude to work on customer-helping
  projects. He holds a B.S. in Computer Science from NC State University.
  ([How Ansible got started and grew, Opensource.com](https://opensource.com/article/21/2/ansible-origin-story))

- **Cobbler:** His **first** open-source project, built at Red Hat to automate
  PXE bare-metal provisioning; it became widely used.
  ([Opensource.com origin story](https://opensource.com/article/21/2/ansible-origin-story))

- **Func (Fedora Unified Network Controller):** His **next** project, bridging
  bare-metal provisioning and configuration management; Fedora used it in its
  infrastructure. Some of Func's concepts later influenced Ansible.
  ([Opensource.com origin story](https://opensource.com/article/21/2/ansible-origin-story))

- **Puppet Labs (and Red Hat) — the "interesting detail," verified:** DeHaan
  worked at **both** Red Hat (emerging technologies, from 2005) **and** Puppet
  ("spent a short spell working for Puppet") before creating Ansible. After
  Puppet he briefly worked at another company on an integration that "wasn't a
  good fit," which pushed him back toward open source — the design goal that
  became Ansible (SSH- and push-based, no agents).
  ([Opensource.com origin story](https://opensource.com/article/21/2/ansible-origin-story))

- **Ansible:** DeHaan wrote and released Ansible in **2012** (initial release
  Feb 20, 2012 — see "2012 — Founding" above).
  ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

### AnsibleWorks founding team (2013)

- **AnsibleWorks, Inc.** was founded in **2013** by **Michael DeHaan, Timothy
  (Tim) Gerla, and Saïd Ziouani** to commercially support the open-source
  project; it was later renamed **Ansible, Inc.** (see "2013 — AnsibleWorks"
  above).
  ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

- **Roles:** **Saïd Ziouani** was **co-founder and CEO**; **Michael DeHaan** was
  **co-founder and CTO**; **Tim Gerla** was also a **co-founder**. Note: some
  third-party profile databases label both DeHaan and Gerla as "CTO," so treat
  Gerla's exact title as *reported, not primary*.
  ([Ansible founders, Tracxn](https://tracxn.com/d/companies/ansible/__NxuFkx1AuALemnDjL4AjuDlF3oFD-9p5bZpxKxQUOO0/founders-and-board-of-directors))

- **Ziouani's background:** a former **Red Hat** executive (VP of Sales and
  Business Development) before co-founding Ansible; he later went on to found
  and lead **Anchore** as CEO.
  ([Saïd Ziouani, Crunchbase](https://www.crunchbase.com/person/sad-ziouani);
  [Saïd Ziouani, The Org / Anchore](https://theorg.com/org/anchore/org-chart/said-ziouani))

- **Funding context:** AnsibleWorks raised a **$6M** round in **August 2013**,
  reinforcing the 2013 company-formation timeline.
  ([TechCrunch, Aug 12, 2013](https://techcrunch.com/2013/08/12/ansibleworks-raises-6m-for-popular-open-source-and-easy-to-use-it-automation-framework/))

### James Cammarata — early hire, then core-engineering lead

- **Hired July 16, 2013:** DeHaan publicly welcomed **James Cammarata** to the
  Ansible team. At the time, DeHaan noted Cammarata had been **"running the
  Cobbler project and community for the last several years"** and was "a major
  contributor to the project when I was running it." His initial focus was
  "core Ansible and helping out with the mailing lists and IRC."
  ([Welcome James Cammarata, Ansible forum (archived announcement)](https://forum.ansible.com/t/welcome-james-cammarata/13134))

- **Project leadership after DeHaan (2015):** Per this file's earlier "January
  2015" section, day-to-day leadership passed to Cammarata after DeHaan's
  departure. A contemporaneous code-ownership snapshot (Aug 2015) shows
  Cammarata as the **author of ~54%** of Ansible files (vs. DeHaan ~25%),
  consistent with him being the central engineer; he is described as **head of
  Ansible core engineering**. *Note:* the **specific "Happy Trails" → Cammarata
  handoff** statement is **reported** (HN thread / community sources), not
  confirmed from DeHaan's original (now-unfetchable) blog post — see "Could not
  verify" below.
  ([Ansible Truck Factor, GitHub issue #11897 (Aug 2015 ownership stats)](https://github.com/ansible/ansible/issues/11897);
  ["head of Ansible core engineering" descriptor, Syscast podcast page](https://ma.ttias.be/syscast/5-ansible-config-management-deploying-code-james-cammarata-red-hat/))

### Michael DeHaan after Ansible (post-2015)

- **Departed Jan 30, 2015** ("Happy Trails, Ansible") — before the Red Hat deal
  (see earlier section).
  ([Hacker News thread, 2015-01-30](https://news.ycombinator.com/item?id=8973916))

- **Immediately after:** he turned mainly to **Django/Python** development and
  side projects (including the **WARP** music sequencer).
  ([Opensource.com origin story](https://opensource.com/article/21/2/ansible-origin-story))

- **Vespene (~2018):** he created **Vespene**, a Python CI/CD / build-automation
  server (described as ~3 months old in a Nov 2018 interview); it was later
  discontinued and archived.
  ([Michael DeHaan on the new Vespene project, Medium interview](https://medium.com/@l8istsh9y/michael-dehann-on-the-new-vespene-project-and-open-source-licensing-c413f12ab5bc))

- **JetPorch / "Jet" (2023–2024):** in **2023** he announced **JetPorch** (the
  "Jet Enterprise Professional Orchestrator"), a new IT-automation engine
  implemented in **Rust**, explicitly positioned as moving "beyond Ansible." He
  **discontinued** it shortly after, citing a lack of outward excitement; an
  obituary write-up is dated **2024-01-01**. (Exact start/stop dates: announce
  mid-2023, wind-down late 2023 / early 2024.)
  ([Michael DeHaan, "A New IT Automation Project? Moving Beyond Ansible…", LinkedIn (2023)](https://www.linkedin.com/posts/michaeldehaan_a-new-it-automation-project-moving-beyond-activity-7089600699050692608-MgW7);
  [Farewell to JetPorch Automation, AnsiblePilot (pub. 2024-01-01)](https://www.ansiblepilot.com/articles/farewell-to-jetporch-automation);
  [jetporch source mirror, sourcehut](https://git.sr.ht/~mpdehaan/jetporch))

### Red Hat era (2015+) — who led Ansible inside Red Hat

- After the **Oct 2015** acquisition, the ~50-person Ansible team (Durham, NC)
  joined Red Hat; Red Hat kept both open-source Ansible and Ansible Tower (see
  earlier "October 2015" section).
  ([FAQ: Red Hat Acquires Ansible](https://www.redhat.com/en/blog/faq-red-hat-acquires-ansible))

- **Engineering leadership:** **James Cammarata** continued as a Red Hat
  software-engineering manager / core-engineering lead for Ansible.
  ([James Cammarata, Software Engineering Manager at Red Hat (profile)](https://www.getprog.ai/profile/26403))

- **Community leadership:** **Greg DeKoenigsberg** served as a director of the
  **Ansible Community** at Red Hat — a documented community-team leadership
  role. The dedicated **Ansible Community Team** is a documented, named group at
  Red Hat (distinct from the product-engineering org).
  ([Greg DeKoenigsberg, Red Hat author profile](https://www.redhat.com/en/authors/greg-dekoenigsberg-author-profile-red-hat-blog);
  [The Ansible Community Team, Red Hat](https://www.redhat.com/en/authors/the-ansible-community-team))

- **Inclusive-language working group:** the 2021 terminology changes were driven
  in part by Red Hat community engineers such as **Jill Rouleau** and an
  internal Diversity & Inclusion working group (see "2021" section).
  ([Opensource.com: inclusive language in Ansible, by Jill Rouleau](https://opensource.com/article/21/5/inclusive-language-ansible))

### IBM era (2019+) — team/leadership changes and layoffs

- IBM's acquisition of Red Hat **closed July 9, 2019** (see earlier section);
  Ansible continued to be run by Red Hat as part of IBM's hybrid-cloud strategy.
  ([IBM closes Red Hat acquisition](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future))

- **April 2023 layoffs — established scale, team impact partly reported:** Red
  Hat cut **~4% of its workforce (~800 people)** by late April 2023. Reporting
  indicates the cuts **"hit hardest in customer success and project
  management,"** while **sales and engineering were largely spared**, and that
  **a prominent member of the Fedora community was laid off** "to the dismay of
  the Fedora and RHEL teams." The Register's piece does **not** name the
  **Ansible community team** specifically.
  ([The Register, Apr 28, 2023](https://www.theregister.com/2023/04/28/red_hat_layoffs_union/);
  [TechCrunch, May 24, 2023 (Red Hat CEO on layoffs)](https://techcrunch.com/2023/05/24/red-hat-ceo-layoffs-ai/))

- **Specific Ansible community-team impact — separate fact from rumor:** that
  the **Ansible community team** in particular was disbanded or heavily cut in
  2023 is **community rumor / forum-level claim**, *not* confirmed by a primary
  Red Hat statement naming that team. The Ansible Community Team continues to
  exist as a named Red Hat author/group post-2023.
  ([Ansible Community Team group, Ansible forum](https://forum.ansible.com/g/CommunityTeam);
  [The Ansible Community Team, Red Hat](https://www.redhat.com/en/authors/the-ansible-community-team))
  — see "Could not verify" below.

### Core team / governance structure (as documented)

- Ansible's contributor governance is documented via its **Community** and
  **Steering Committee** structures and the **Ansible Community Team** at Red
  Hat; the project also runs a public **forum** (forum.ansible.com) that
  replaced older mailing lists/IRC as the primary community hub.
  ([Ansible Community Team, Red Hat](https://www.redhat.com/en/authors/the-ansible-community-team);
  [Ansible Community Team group, forum.ansible.com](https://forum.ansible.com/g/CommunityTeam))

### People-and-teams: established vs. reported

**Established (primary / strong secondary):**
- DeHaan worked at **both Red Hat (2005+) and Puppet** before Ansible; created
  Cobbler and Func first. ([Opensource.com](https://opensource.com/article/21/2/ansible-origin-story))
- AnsibleWorks founded **2013** by DeHaan (CTO), Ziouani (CEO), Gerla
  (co-founder); $6M raise Aug 2013. ([TechCrunch](https://techcrunch.com/2013/08/12/ansibleworks-raises-6m-for-popular-open-source-and-easy-to-use-it-automation-framework/))
- Ziouani was ex-Red Hat; later CEO/founder of **Anchore**. ([Crunchbase](https://www.crunchbase.com/person/sad-ziouani))
- Cammarata hired **July 16, 2013** from the Cobbler project; later head of
  Ansible core engineering. ([Ansible forum](https://forum.ansible.com/t/welcome-james-cammarata/13134))
- DeHaan post-Ansible: Django/Python, **Vespene** (~2018), **JetPorch/Jet**
  (Rust, 2023, discontinued ~2024). ([AnsiblePilot](https://www.ansiblepilot.com/articles/farewell-to-jetporch-automation))
- Red Hat **April 2023** layoffs ~4% / ~800 people; hit customer success &
  project management hardest. ([The Register](https://www.theregister.com/2023/04/28/red_hat_layoffs_union/))

**Reported / rumor (attributed, not primary):**
- Tim Gerla's exact title ("CTO" vs. just "co-founder") — profile DBs disagree.
- The **specific** DeHaan-→-Cammarata "Happy Trails" leadership handoff wording.
- A 2023 layoff impact **specifically on the Ansible community team**.

### Could not verify

- **Could not verify:** the exact text/date of DeHaan's original "Happy Trails,
  Ansible" post naming Cammarata as successor — the original blog URL
  (`michaeldehaan.net/post/109595670406/...`) remains unfetchable; the handoff
  is corroborated only via the Hacker News thread and community sources.
- **Could not verify:** that the **Ansible community team specifically** was
  disbanded or disproportionately cut in the 2023 (or 2025) Red Hat layoffs —
  no primary Red Hat/IBM source naming that team was found; The Register names
  only customer success, project management, and a Fedora community member.
- **Could not verify:** a precise day-level start date for **JetPorch** (sources
  place the announcement in mid-2023 and the wind-down at late 2023 / the
  2024-01-01 farewell post) and Tim Gerla's exact officer title at founding.
- **Could not verify:** the name of a single post-2019 "general manager of the
  Ansible business unit" at Red Hat from a primary source (the BU/Automation
  org leadership is not named in a primary doc located during this research).

---

## Company & corporate history (chronological)

This section traces the **corporate / business** thread of Ansible — the
distinction between the open-source *project* and the commercial *company*,
the financing and naming changes, the two acquisitions, and the productization
of the commercial offering. It re-uses facts established earlier in this file
but adds business-angle detail with its own inline sources. Items that could
not be confirmed are flagged inline and collected at the end.

### 2012 — Project, not yet a company

- The Ansible **open-source project** had its initial release on **February 20,
  2012**, authored by Michael DeHaan (see "2012 — Founding" above). At this
  point there was **no company** behind it — it was a personal open-source
  project. ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

### 2013 — The company: AnsibleWorks, Inc. (Durham, NC)

- **AnsibleWorks, Inc.** was incorporated in **2013** to commercialize and
  sponsor the project, co-founded by **Michael DeHaan, Timothy Gerla, and Saïd
  Ziouani**. The company was based in **Durham, North Carolina** (American
  Tobacco Campus). The "Works" suffix was a deliberate stopgap because the
  bare "Ansible" name was not yet available to the company.
  ([Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software));
  [AnsibleWorks is now just Ansible — Ansible forum, Jan 29, 2014](https://forum.ansible.com/t/ansibleworks-is-now-just-ansible/14449))

- **First commercial product (mid-2013):** before the rename, AnsibleWorks
  launched its first commercial enterprise product under the **AWX** brand —
  the paid web UI/management layer that would later become **Ansible Tower**.
  ([TechCrunch, Aug 12, 2013](https://techcrunch.com/2013/08/12/ansibleworks-raises-6m-for-popular-open-source-and-easy-to-use-it-automation-framework/))

### August 2013 — Series A: $6M led by Menlo Ventures

- **August 12–13, 2013:** AnsibleWorks closed a **$6 million** financing round
  led by **Menlo Ventures**. TechCrunch's contemporaneous report frames this as
  the company's institutional raise, citing traction of **~300,000 users** and
  **~30,000 downloads/month** at the time, and notes the company had "last
  month" launched AWX as its first commercial product.
  ([TechCrunch, Aug 12, 2013](https://techcrunch.com/2013/08/12/ansibleworks-raises-6m-for-popular-open-source-and-easy-to-use-it-automation-framework/);
  [AnsibleWorks Raises $6 Mln in Series A — Venture Capital Journal](https://www.venturecapitaljournal.com/ansibleworks-raises-6-mln-series-a-funds/))

  > Round-type / investor-list caveat: TechCrunch names only **Menlo Ventures**
  > and does not label the round; trade outlets (Venture Capital Journal, vcnewsdaily)
  > characterize it as a **Series A**, and some secondary aggregators add
  > **e.ventures** as a participating investor. Treat the "Series A" label and
  > any investor beyond Menlo Ventures as **reported/secondary**, not confirmed
  > from a primary filing — see "Could not verify" below.

### January 2014 — AnsibleWorks → Ansible, Inc.

- **January 29, 2014:** The company publicly rebranded from **AnsibleWorks** to
  just **Ansible** ("Ansible, Inc."), with DeHaan describing it as "making
  things simpler by dropping five letters and an extra syllable." The same
  announcement moved web properties to bare-domain forms (`ansible.com`,
  `docs.ansible.com`, `galaxy.ansible.com`, `releases.ansible.com`), switched the
  Twitter handle to **@ansible**, and noted the commercial UI was being branded
  **Tower** ("a communications platform"). DeHaan stressed "company and project
  wise, absolutely nothing has changed."
  ([AnsibleWorks is now just Ansible — Ansible forum, Jan 29, 2014](https://forum.ansible.com/t/ansibleworks-is-now-just-ansible/14449);
  [Ansible (software), Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))

### October 2015 — Red Hat acquires Ansible, Inc.

- **October 16, 2015:** Red Hat announced a definitive agreement to acquire
  **Ansible, Inc.** (the Durham, NC company), bringing its ~50-person team into
  Red Hat. Red Hat said it would continue both open-source Ansible and the
  commercial **Ansible Tower** product (see "October 2015" section above for the
  primary press release and 8-K).
  ([Red Hat press release, Oct 16, 2015](https://www.redhat.com/en/about/press-releases/red-hat-acquire-it-automation-and-devops-leader-ansible);
  [FAQ: Red Hat Acquires Ansible](https://www.redhat.com/en/blog/faq-red-hat-acquires-ansible))

- **Deal value — disclosed figure vs. reporting:** Red Hat **did not officially
  disclose a price**. Press reporting placed it at **"more than $100M"**
  (VentureBeat) up to **~$150M** (Tech Times); WRAL TechWire flagged it as
  Durham's seventh tech exit on the American Tobacco Campus in two years. The
  dollar figure is therefore **reported, not official**.
  ([VentureBeat — "more than $100M"](https://venturebeat.com/dev/source-red-hat-is-buying-ansible-for-more-than-100m);
  [TechCrunch, Oct 16, 2015](https://techcrunch.com/2015/10/16/red-hat-is-buying-it-automation-startup-ansible-reportedly-for-around-100m/);
  [WRAL TechWire, Oct 16, 2015](https://www.wraltechwire.com/2015/10/16/ansible-becomes-durham-7th-tech-exit-in-two-year-151016/))

### 2015–2019 — Ansible as a Red Hat business unit; productizing the platform

- Inside Red Hat, Ansible became a distinct product line / business unit. The
  commercial product evolved from **Ansible Tower** + **Ansible Engine** (the
  supported open-source engine subscription) toward a unified platform offering.
  ([Red Hat: Ansible vs. Red Hat Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible/ansible-vs-red-hat-ansible-automation-platform))

- **September 24, 2019 (AnsibleFest, Atlanta):** Red Hat announced the
  **Red Hat Ansible Automation Platform** — the consolidated commercial product
  that integrated **Ansible Tower**, **Ansible Engine**, and Red Hat Network
  Automation, plus new SaaS capabilities (**Automation Hub**, **Automation
  Analytics**). General availability was set for **early November 2019**;
  existing Tower customers could upgrade at no additional cost. This is the
  lineage by which **Ansible Tower → (component of) Ansible Automation Platform**.
  ([Red Hat press release, Sep 24, 2019](https://www.redhat.com/en/about/press-releases/red-hat-elevates-enterprise-automation-new-red-hat-ansible-automation-platform))

- **2021 rebrand of the Tower component:** with **Ansible Automation Platform 2**
  (early-access preview announced Sep 30, 2021), the former **Ansible Tower**
  product was renamed the **automation controller** component, with **AWX**
  remaining its open-source upstream (see "Branding evolution" section above).
  ([DEVCLASS, Sep 30, 2021](https://devclass.com/2021/09/30/red-hat-previews-ansible-automation-platform-2-turns-tower-into-automation-controller/))

### October 2018 / July 2019 — IBM acquires Red Hat ($34B); Ansible carried along

- **October 28, 2018:** IBM announced its intent to acquire Red Hat for
  **$190.00/share in cash (~$34 billion)** — IBM's largest acquisition. The deal
  **closed July 9, 2019**, and the closing announcement named **Ansible**
  explicitly among Red Hat's flagship open-source technologies (see "October 2018
  / July 2019" section above for primary PRs and 8-Ks). Corporately, Ansible
  passed from a Red Hat business unit into Red Hat-as-an-IBM-subsidiary, slotted
  into IBM's hybrid-cloud automation strategy; Red Hat continued to operate it.
  ([IBM/Red Hat acquisition PR](https://www.redhat.com/en/about/press-releases/ibm-acquire-red-hat-completely-changing-cloud-landscape-and-becoming-worlds-1-hybrid-cloud-provider);
  [IBM closes Red Hat acquisition, Jul 9, 2019](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future))

### 2023 — IBM-era layoffs as corporate context (~4%)

- **April 2023:** Red Hat — under CEO **Matt Hicks** and IBM ownership —
  conducted the **first significant layoffs in its history**, cutting **just
  under 4%** of its ~20,000-person workforce (**fewer than 800 people**). Hicks
  framed the cuts as falling on **general and administrative roles**, stating
  they would **not** affect people **directly selling to customers or building
  products**. This is **corporate context**, distinct from any rumor about the
  Ansible team specifically.
  ([Axios Raleigh, Apr 24, 2023](https://www.axios.com/local/raleigh/2023/04/24/red-hat-lays-off-4-of-its-workforce);
  [The Register, Apr 24, 2023](https://www.theregister.com/2023/04/24/ibm_red_hat_layoffs/);
  [The Register, Apr 28, 2023](https://www.theregister.com/2023/04/28/red_hat_layoffs_union/))

  > Separation of fact from rumor: the **company-wide ~4% / <800** figure and the
  > G&A-vs-product framing are **on the record** (Hicks, via Axios/The Register).
  > Any claim that the **Ansible team or Ansible community team specifically** was
  > targeted in 2023 is **community rumor**, not confirmed by a primary
  > Red Hat/IBM statement (consistent with the earlier "Could not verify" note in
  > the people section).

### Current status (as of this research)

- Ansible exists today as: (1) the **open-source project** (`ansible-core` engine
  + community collections via Galaxy), and (2) the **Red Hat Ansible Automation
  Platform** — the commercial, supported product, operated by **Red Hat** as a
  **subsidiary of IBM**. The former Ansible Tower lives on as the **automation
  controller** component of AAP, with **AWX** as its open-source upstream.
  ([Red Hat: Ansible vs. Red Hat Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible/ansible-vs-red-hat-ansible-automation-platform);
  [Red Hat Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible))

### Corporate history: established vs. reported

**Established (primary / strong secondary):**
- Project released 2012; **company AnsibleWorks, Inc.** founded **2013** in
  Durham, NC by DeHaan/Gerla/Ziouani. ([Wikipedia](https://en.wikipedia.org/wiki/Ansible_(software)))
- **$6M** round led by **Menlo Ventures**, **Aug 2013**. ([TechCrunch](https://techcrunch.com/2013/08/12/ansibleworks-raises-6m-for-popular-open-source-and-easy-to-use-it-automation-framework/))
- Rename **AnsibleWorks → Ansible** on **Jan 29, 2014**. ([Ansible forum](https://forum.ansible.com/t/ansibleworks-is-now-just-ansible/14449))
- Red Hat agreed to acquire Ansible **Oct 16, 2015**; **no official price**. ([Red Hat PR](https://www.redhat.com/en/about/press-releases/red-hat-acquire-it-automation-and-devops-leader-ansible))
- **Red Hat Ansible Automation Platform** announced **Sep 24, 2019**, GA early
  Nov 2019, unifying Tower + Engine. ([Red Hat PR](https://www.redhat.com/en/about/press-releases/red-hat-elevates-enterprise-automation-new-red-hat-ansible-automation-platform))
- IBM→Red Hat (~$34B) closed **Jul 9, 2019**; Ansible named in closing PR. ([Red Hat PR](https://www.redhat.com/en/about/press-releases/ibm-closes-landmark-acquisition-red-hat-34-billion-defines-open-hybrid-cloud-future))
- Red Hat **Apr 2023** layoffs ~4% / <800, hitting G&A; first major layoffs in
  its history. ([Axios](https://www.axios.com/local/raleigh/2023/04/24/red-hat-lays-off-4-of-its-workforce))

**Reported / opinion (attributed, not primary):**
- The **$100M–$150M** Ansible purchase price (press reporting only).
- The **"Series A"** label and any investor **beyond Menlo Ventures** (e.g.
  e.ventures) in the 2013 round.
- Any 2023 layoff impact **specifically on the Ansible team/community team**.

### Could not verify (corporate)

- **Could not verify:** an **official Red Hat dollar figure** for the 2015
  Ansible acquisition — Red Hat never disclosed one; only press estimates
  (~$100M–$150M) exist.
- **Could not verify:** the **exact round type ("Series A")** and the **full
  investor syndicate** of the Aug 2013 $6M raise from a primary source — the
  TechCrunch primary report names only Menlo Ventures and gives no round label;
  the "Series A" label and additional investors come from trade/aggregator
  secondary sources.
- **Could not verify:** a precise **incorporation date** (month/day) for
  AnsibleWorks, Inc. in 2013 from a primary corporate filing (sources give the
  year and the Durham, NC location only).
- **Could not verify:** that the **Ansible team specifically** was affected by
  the 2023 Red Hat layoffs (the on-record framing limited cuts to G&A and spared
  product/sales roles).
