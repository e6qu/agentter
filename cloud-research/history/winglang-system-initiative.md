# Winglang (Wing) and System Initiative — A Chronological History

Two "next-generation, post-IaC" efforts, each launched by a person who helped
build the *previous* generation of infrastructure tooling and then set out to
replace it:

- **Winglang / Wing**, by **Elad Ben-Israel** — creator of the AWS CDK and
  jsii — after he left AWS. A *cloud-oriented programming language* that unifies
  infrastructure and runtime code and compiles down to Terraform/CloudFormation
  plus JavaScript.
- **System Initiative**, by **Adam Jacob** — co-founder of Chef — after Chef.
  A reactive, collaborative, graph/"digital-twin" model ("Figma for
  infrastructure") that explicitly rejects traditional IaC/YAML.

This document cross-references, and does not duplicate, the existing histories of
their authors' earlier work: see
[`cloudformation-cdk.md`](./cloudformation-cdk.md) for the AWS CDK / jsii lineage
and Elad Ben-Israel, and [`chef.md`](./chef.md) for Chef and Adam Jacob.

> **Sourcing note.** Every factual claim below carries an inline link to a
> primary or reputable secondary source. Where a date or claim could not be
> verified against a primary source, it is flagged explicitly with
> "**Could not verify:**". Reported claims (e.g., what a founder said about
> their own motives) are attributed to the source rather than stated as bare
> fact.

---

## Timeline

### 2019 — System Initiative is founded (in stealth)

System Initiative was founded in **2019** by **Adam Jacob** and co-founders,
remaining in stealth for roughly four years before any public launch
([TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/);
[Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/)).

- Jacob is the co-founder and former CTO of **Chef** (Opscode). For his Chef
  history and the company's 2020 sale to Progress Software, see
  [`chef.md`](./chef.md). Reporting notes that by the time Chef was acquired by
  Progress (2020, $220M), Jacob had stepped back from day-to-day work and
  remained on the board, and that he and his co-founders had been working on the
  System Initiative vision since 2019
  ([Runtime, Jun 21 2023](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/)).
- **Co-founders.** Adam Jacob (CEO) co-founded the company with **Mahir
  Lupinacci** (COO), described as an ex-Chef "Chief of Staff," and reporting also
  names **Alex Ethier** among the founding team
  ([Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/);
  [Tracxn — System Initiative](https://tracxn.com/d/companies/system-initiative/__MJQL4Kfk0zKHBDY595UG5D92oIFNt_k8ivQhAoz9y-Q)).
  **Could not verify:** Alex Ethier's exact title/role from a primary System
  Initiative source (Tracxn is a secondary aggregator).

### 2022 — Monada (later Wing Cloud) is founded

**Elad Ben-Israel** — creator of the **AWS Cloud Development Kit (CDK)**,
**CDK8s**, **jsii**, and **Projen** (see [`cloudformation-cdk.md`](./cloudformation-cdk.md)
for the CDK/jsii lineage) — left AWS to start a new company, originally named
**Monada**, in **2022**
([Times of Israel / Calcalist coverage, Jul 2023](https://www.calcalistech.com/ctechnews/article/sy3ro1149h);
[SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).

- Ben-Israel's own GitHub bio lists him as having founded "Winglang, AWS CDK,
  Projen" and being "Ex-AWS, Microsoft," confirming he left AWS before this
  venture ([github.com/eladb](https://github.com/eladb)).
- **Co-founder.** Monada/Wing was co-founded by **Shai Ber** (COO)
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/);
  [Code Story podcast — "Shai Ber & Elad Ben-Israel, Monada & Winglang"](https://codestory.co/podcast/bonus-shai-ber-elad-ben-israel-monada-winglang/)).
- The mission was framed as "democratize the cloud by reimagining cloud
  development from the ground up"
  ([Code Story / Monada coverage](https://codestory.co/podcast/bonus-shai-ber-elad-ben-israel-monada-winglang/)).
- **Could not verify:** the exact month in 2022 of founding/incorporation from a
  primary source. Sources consistently give the year 2022.

### June 21, 2023 — System Initiative exits stealth with $18M

System Initiative came out of stealth on **June 21, 2023**, disclosing **$18
million** in total funding and a private beta
([TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/);
[Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/)).

- **Funding breakdown:** a **$3M seed** led by **Amplify Partners** (with **Storm
  Ventures** and **Battery Ventures** participating) and a **$15M Series A** led
  by **Scale Venture Partners** (with existing investors)
  ([TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/)).
- **"Figma for infrastructure."** Pre-launch publicity used this exact framing —
  a multiuser, visual, collaborative design surface for infrastructure rather
  than text-file IaC
  ([Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/);
  [The New Stack — "A DevOps Makeover by Ex-Chef Adam Jacob"](https://thenewstack.io/system-initiative-a-devops-makeover-by-ex-chef-adam-jacob/)).
- **The rejection of traditional IaC.** Jacob's stated thesis is that the tools
  and the way they fit together "basically hasn't changed since 2009," and that
  DevOps needs to be rebuilt from the ground up rather than stitched together
  from existing tools
  ([Runtime, Jun 21 2023](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/);
  [TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/)).
- **The model: a reactive hypergraph + digital twin.** Jacob described the
  architecture as: "Every configuration parameter, qualification and action you
  can take is a TypeScript function sitting on a hypergraph. Each function takes
  inputs elsewhere on the graph, and if any inputs change, we automatically
  re-run the function for you, and store the results"
  ([Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/)).
  The system builds an interactive **digital twin / simulation** of a company's
  infrastructure (cloud or on-prem) that engineers manipulate visually; the
  platform then generates and applies the changes
  ([TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/)).
- **How it differs from IaC.** Instead of authoring static YAML/HCL templates and
  running a plan/apply CI/CD pipeline, SI maintains a live, reactive model where
  edits propagate automatically through the dependency graph, giving real-time
  feedback on configuration errors before deployment
  ([Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/);
  [Runtime, Jun 21 2023](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/)).

### August 10, 2023 — Monada rebrands to Wing Cloud

The company behind Winglang rebranded from **Monada** to **Wing Cloud**, marked
by a "Goodbye Monada — Hello Wing Cloud" post on the project blog dated **August
10, 2023**
([winglang.io blog, Aug 10 2023](https://web.archive.org/web/2id_/https://www.winglang.io/blog/2023/08/10/wingly-introducing-wing-cloud)).
**Could not verify:** the full text of this post (the page was not fetchable at
research time, returning a connection error); the date and title are taken from
the URL and search index. Add to `DO_NEXT.md` to re-fetch and quote directly.

### August 16, 2023 — System Initiative goes fully open source (Apache 2.0)

System Initiative open-sourced **all** of its software under the **Apache License
2.0** on **August 16, 2023**, with the source on GitHub at
[`github.com/systeminit/si`](https://github.com/systeminit/si)
([System Initiative blog — "Open Source"](https://www.systeminit.com/blog/open-source/);
[Devclass, Aug 17 2023](https://devclass.com/2023/08/17/system-initiative-automated-cloud-deployment-tool-now-open-source-devs-hope-it-improves-on-terraform/)).

- The release was explicitly **not** open-core: "no features held back, no
  competitive restrictions, and no special rights retained," with no separate
  enterprise version
  ([DevOps.com — "System Initiative Open Sources Digital Twin Tool for DevOps"](https://devops.com/system-initiative-open-sources-digital-twin-tool-for-devops/);
  [Devclass, Aug 17 2023](https://devclass.com/2023/08/17/system-initiative-automated-cloud-deployment-tool-now-open-source-devs-hope-it-improves-on-terraform/)).
- A CLI for managing local installations (Linux/macOS) shipped alongside
  ([Devclass, Aug 17 2023](https://devclass.com/2023/08/17/system-initiative-automated-cloud-deployment-tool-now-open-source-devs-hope-it-improves-on-terraform/)).
- **Note on dates / correction of a common impression:** InfoQ's write-up is
  dated **October 2023** and is sometimes cited as the open-source date, but the
  actual open-sourcing was **August 16, 2023** (the InfoQ piece is later coverage,
  confirming the Apache-2.0 license and the `systeminit/si` repo)
  ([InfoQ, Oct 2023](https://www.infoq.com/news/2023/10/system-initiative-open-source/)).
  The task brief's "~2024" estimate for open-sourcing is therefore **incorrect**:
  it happened in **August 2023**, roughly two months after the stealth exit.

### July 18, 2023 — Wing Cloud exits stealth with $20M seed

Wing Cloud launched out of stealth on **July 18, 2023** with **$20 million** in
seed funding — the total raised since founding in 2022, including a **$5M** round
in **May 2023**
([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/);
[Calcalist, Jul 2023](https://www.calcalistech.com/ctechnews/article/sy3ro1149h);
[Wing Cloud press release via BusinessWire, Jul 18 2023](https://www.businesswire.com/news/home/20230718296353/en/Wing-Cloud-Raises-$20Million-in-Seed-Funding-to-Build-Winglang-A-Unified-Programming-Language-to-Tame-Cloud-Complexity)).

> Note: this entry is placed after the August items only because the seed round
> closed before the August events; chronologically the **announcement** (Jul 18,
> 2023) preceded the rebrand post (Aug 10) and SI's open-sourcing (Aug 16).

- **Lead investors:** **Battery Ventures**, **Grove Ventures**, and **StageOne
  Ventures**, with **Secret Chord Ventures**, **Cerca Partners**, and **Operator
  Partners** participating
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **Angel investors** included **Amit Agarwal** (Datadog president), **Armon
  Dadgar** (HashiCorp co-founder/CTO), **Benny Schnaider** (Salto founder), and
  **Zach Kanter** (Stedi founder)
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **What Winglang is (the thesis: unify infra + runtime).** Wing is an
  **open-source, cloud-oriented programming language** that treats cloud
  infrastructure as a first-class language construct, combining **infrastructure
  definitions and runtime/application code in a single unified model**
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/);
  [github.com/winglang/wing](https://github.com/winglang/wing)).
- **What it compiles to.** The Wing compiler emits a ready-to-deploy package
  containing **infrastructure-as-code** for **Terraform** (and **CloudFormation**
  or other provisioning engines) **plus Node.js code** for compute platforms such
  as **AWS Lambda, Kubernetes, and edge systems**
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **Local simulator.** Wing shipped with a built-in **local cloud simulator** and
  an observability/debugging console, letting developers run and test cloud apps
  locally before deploying
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **Quote (attributed):** Ben-Israel framed the problem as: "The cloud has
  evolved into an incredibly powerful computing platform, but customers still find
  themselves having to deal with burdensome tasks" across security, networking,
  and operations
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- The Wing language repository
  ([github.com/winglang/wing](https://github.com/winglang/wing)) is licensed
  **MIT** and describes Wing as "a new open-source programming language designed
  for the cloud … combining infrastructure and application code in a unified
  programming model."

### Through 2024 — Wing develops in the open; System Initiative iterates

Both projects continued as open-source efforts through 2024. **Could not
verify** (from primary sources at research time): specific 2024 milestone dates,
release numbers, or adoption figures for either project. The Wing GitHub repo's
visible release history shows active development continuing into early 2025 (e.g.,
Wing **0.85.49**, dated **February 3, 2025**)
([github.com/winglang/wing — releases](https://github.com/winglang/wing)).

### April 9, 2025 — Wing Cloud shuts down

Wing Cloud ceased operations, announced by CEO **Elad Ben-Israel** in a post on
**LinkedIn**; press coverage is dated **April 9, 2025**
([Jewish Business News, Apr 9 2025](https://jewishbusinessnews.com/2025/04/09/israeli-startup-wing-cloud-shuts-down-less-than-two-years-after-launch-of-open-source-winglang-programming-language/);
[Calcalist — "Wing Cloud shuts down after raising $20 million to reinvent cloud development"](https://www.calcalistech.com/ctechnews/article/bj90wnmrjl)).

- **What he said (attributed).** Ben-Israel wrote: "After an amazing ride, we've
  made the tough decision to shut down our company, Wing (previously Monada)," and
  "It's bittersweet, but we're deeply proud of what we built—and even more
  grateful for the amazing people who joined us along the way"
  ([Jewish Business News, Apr 9 2025](https://jewishbusinessnews.com/2025/04/09/israeli-startup-wing-cloud-shuts-down-less-than-two-years-after-launch-of-open-source-winglang-programming-language/)).
- **Stated reason.** He attributed the shutdown to the difficulty of building a
  sustainable business around developer experience: "While developer experience
  is something engineers care deeply about, it's not always seen as
  business-critical by most companies." He also said that after exploring "various
  different directions in the cloud space," the team "didn't find the right fit"
  for a venture-scale business, despite strong community support (100+
  contributors)
  ([Calcalist](https://www.calcalistech.com/ctechnews/article/bj90wnmrjl);
  [Jewish Business News, Apr 9 2025](https://jewishbusinessnews.com/2025/04/09/israeli-startup-wing-cloud-shuts-down-less-than-two-years-after-launch-of-open-source-winglang-programming-language/)).
- **Could not verify:** the exact calendar date of the LinkedIn post (the
  announcement was widely covered on April 9, 2025; the post itself was not
  fetchable directly at research time — LinkedIn requires authentication). The
  closure was "less than two years after" the July 2023 stealth exit, consistent
  with an early-April 2025 date.
- **Could not verify:** the precise fate of the open-source Wing repository
  post-shutdown (whether archived, community-forked, or left dormant). The MIT
  license means the code remains usable regardless.

### After Wing — Elad Ben-Israel's next move

Ben-Israel's GitHub profile lists his current role as **CTO at Bellboy
Robotics**, indicating he moved on to a robotics company after Wing
([github.com/eladb](https://github.com/eladb)).
**Could not verify** further details about Bellboy Robotics from a primary
company source at research time.

### November 18, 2025 — System Initiative pivots to "AI-native" infrastructure automation

System Initiative remained active and announced an **AI-native infrastructure
automation platform** — "Limitless Multi-Cloud and API Coverage" — with
AI agents that understand a team's infrastructure and can "propose and safely
execute real, validated changes," available in private beta; release dated
**November 18, 2025**
([BusinessWire, Nov 18 2025](https://www.businesswire.com/news/home/20251118891036/en/System-Initiative-Introduces-Limitless-Multi-Cloud-and-API-Coverage-for-AI-Native-Infrastructure-Automation)).
This positions the reactive digital-twin model as the substrate for human + AI-agent
collaboration across AWS, Azure, and elsewhere.

- **Current status (as of late 2025):** System Initiative is **still operating**
  (in contrast to Wing Cloud's shutdown), having reframed its graph/simulation
  model around AI agents.
- **Could not verify:** any *new* funding round attached to the Nov 2025
  announcement (search snippets restated the original $18M; one secondary
  aggregator lists ~$24.2M total, which would imply additional capital beyond the
  2023 rounds — flag and confirm against a primary source). Add to `DO_NEXT.md`.

---

## Key people & teams

### Winglang / Wing Cloud (formerly Monada)

- **Elad Ben-Israel** — co-founder & CEO. Creator of the **AWS CDK**, **CDK8s**,
  **jsii**, and **Projen**; **ex-AWS** (and previously Microsoft). Left AWS to
  start Monada/Wing in 2022; announced the company's shutdown in April 2025; later
  CTO at Bellboy Robotics. For his AWS CDK/jsii history see
  [`cloudformation-cdk.md`](./cloudformation-cdk.md)
  ([github.com/eladb](https://github.com/eladb);
  [SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **Shai Ber** — co-founder & COO of Monada/Wing Cloud
  ([Code Story podcast](https://codestory.co/podcast/bonus-shai-ber-elad-ben-israel-monada-winglang/);
  [SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).
- **Lead investors:** Battery Ventures, Grove Ventures, StageOne Ventures
  (+ Secret Chord, Cerca Partners, Operator Partners; angels including Armon
  Dadgar and Amit Agarwal)
  ([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/)).

### System Initiative

- **Adam Jacob** — co-founder & CEO. Co-founder and former CTO of **Chef**
  (Opscode). For his Chef history and the 2019 "100% open source" relicensing /
  ICE-contract episode, see [`chef.md`](./chef.md). Began the System Initiative
  vision in 2019 after stepping back from Chef
  ([Runtime, Jun 21 2023](https://www.runtime.news/meet-system-initiative-a-new-devops-tool-from-adam-jacob/);
  [github.com/adamhjk](https://github.com/adamhjk)).
- **Mahir Lupinacci** — co-founder & COO; ex-Chef "Chief of Staff"
  ([Devclass, Jun 21 2023](https://devclass.com/2023/06/21/chef-inventor-adam-jacob-introduces-system-initiative-figma-for-infrastructure/)).
- **Alex Ethier** — named among the founding team (role unverified by a primary
  source) ([Tracxn — System Initiative](https://tracxn.com/d/companies/system-initiative/__MJQL4Kfk0zKHBDY595UG5D92oIFNt_k8ivQhAoz9y-Q)).
- **Lead investors:** Amplify Partners (seed) and Scale Venture Partners
  (Series A); Storm Ventures and Battery Ventures also participated
  ([TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/)).

### Shared thread

Both ventures are textbook cases of **"the people who built the previous
generation trying to replace it"**: Ben-Israel built AWS's first-party IaC
developer experience (CDK) and then tried to obsolete the
infra-code/runtime-code split with a *new language*; Jacob built one of the
defining config-management tools (Chef) and then tried to obsolete declarative
text IaC with a *reactive, collaborative graph model*. Notably, **Battery
Ventures invested in both**
([SiliconANGLE, Jul 18 2023](https://siliconangle.com/2023/07/18/wing-cloud-raises-20m-build-unified-programming-language-tames-cloud-complexity/);
[TechCrunch, Jun 21 2023](https://techcrunch.com/2023/06/21/with-18m-in-funding-system-initiative-wants-to-modernize-devops/)).
As of late 2025 their outcomes diverged: **Wing Cloud shut down (April 2025)**
while **System Initiative continued**, pivoting to AI-native automation.
