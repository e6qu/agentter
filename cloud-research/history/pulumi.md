# A Chronological History of Pulumi

Pulumi is a cloud infrastructure-as-code (IaC) company and open-source tool whose
central thesis is that infrastructure should be defined in **general-purpose
programming languages** (TypeScript, Python, Go, C#, Java, YAML) rather than a
domain-specific configuration language. This document traces its history with a
focus on (a) positioning versus HashiCorp Terraform, (b) funding, and
(c) controversies. Every factual claim is linked to a primary or reputable
secondary source. Where a claim could not be independently verified, it is
explicitly marked.

---

## 2017 — Founding

- **2017:** Pulumi Corporation was founded in Seattle by **Joe Duffy**, **Eric
  Rudder**, and **Luke Hoban**. Joe Duffy (CEO) spent roughly 12 years at
  Microsoft building developer technologies and tools (including work on .NET and
  the Midori research OS); Eric Rudder is a former senior Microsoft executive who
  serves as executive chairman; Luke Hoban is a former Microsoft and AWS product
  leader who became CTO.
  - Founders and 2017 founding: [Pulumi — Wikipedia](https://en.wikipedia.org/wiki/Pulumi);
    Madrona podcast with Rudder and Duffy: [Madrona — "Founded and Funded: Building an Open Source Business from Scratch"](https://www.madrona.com/founded-and-funded-building-an-open-source-business-from-scratch-with-eric-rudder-and-joe-duffy-of-pulumi/).
  - Duffy "helped co-found it in 2017 after spending 12 years at Microsoft":
    [TechCrunch, Oct 22 2018](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/).
  - Note: The June 2018 TechCrunch launch article names Duffy and Rudder but does
    not name Luke Hoban; Hoban's co-founder/CTO role is documented on Pulumi's
    leadership page and Wikipedia. ([Pulumi leadership](https://www.pulumi.com/about/leadership/),
    [Wikipedia](https://en.wikipedia.org/wiki/Pulumi))
- The name "Pulumi" is the Hawaiian word for "broom." (Reported by secondary
  source [CanvasBusinessModel — "A Brief History of Pulumi"](https://canvasbusinessmodel.com/blogs/brief-history/pulumi-brief-history); treat as
  reported, not primary.)

---

## June 18, 2018 — Public launch (out of stealth) and the core thesis

- Pulumi emerged from stealth and **open-sourced** its platform on
  **June 18, 2018**.
  - [TechCrunch — "Pulumi wants to let you manage your infrastructure with code" (Jun 18 2018)](https://techcrunch.com/2018/06/18/pulumi-wants-to-let-you-manage-your-infrastructure-with-code/)
  - Pulumi's own retrospective: [Pulumi Blog — "Happy Birthday to Pulumi open source!"](https://www.pulumi.com/blog/happy-birthday-to-pulumi-open-source/)
- **The "real programming languages instead of a DSL" thesis.** Pulumi's pitch
  was that instead of a cloud-specific configuration language, developers define
  infrastructure in the same programming languages they already use. Duffy and
  Rudder argued that vendor-specific templating leads to "configuration sprawl"
  and "templates that mix code and configuration into an unholy mix of unreadable
  files."
  - [TechCrunch (Jun 18 2018)](https://techcrunch.com/2018/06/18/pulumi-wants-to-let-you-manage-your-infrastructure-with-code/)
- Languages supported at/around launch: JavaScript, TypeScript, Python, and Go,
  with .NET/C# and Java added later.
  - [TechCrunch (Jun 18 2018)](https://techcrunch.com/2018/06/18/pulumi-wants-to-let-you-manage-your-infrastructure-with-code/);
    current language list: [Wikipedia](https://en.wikipedia.org/wiki/Pulumi)

---

## Funding timeline

> Caveat on the seed round: Multiple secondary sources (search aggregators and a
> Crunchbase funding-round page) report a **~$5M seed round in June 2018**, but I
> could not load the Crunchbase page (HTTP 403) to verify the exact figure, and
> the June 2018 TechCrunch launch piece does not state a seed amount. The
> Series A and later rounds below are confirmed against primary/press sources.

- **Seed (reported June 2018, ~$5M):** Backed by **Madrona Venture Group** and
  **Tola Capital**, with S. "Soma" Somasegar (Madrona) joining the board. The
  June 2018 launch article confirms Madrona + Tola backing and Somasegar's board
  seat but does not state the dollar amount.
  - [TechCrunch (Jun 18 2018)](https://techcrunch.com/2018/06/18/pulumi-wants-to-let-you-manage-your-infrastructure-with-code/)
  - **Could not verify the exact $5M seed figure from a primary source** (Crunchbase
    page returned 403). Reported by aggregators only.

- **Series A — $15M, October 22, 2018.** Led by **Madrona Venture Group**, with
  **Tola Capital** participating (Sheila Gulati joined the board). Announced
  alongside Pulumi's first commercial "Team Edition."
  - [TechCrunch (Oct 22 2018)](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/)
  - [GeekWire — "Pulumi raises $15M in Series A…"](https://www.geekwire.com/2018/pulumi-raises-15m-series-funding-round-launches-multicloud-app-deployment-service/)
  - [Pulumi press release — "Pulumi Announces $15M in Series A Funding"](https://info.pulumi.com/press-release/pulumi-announces-15m-in-series-a-funding-to-accelerate-development-and-adoption-of-its-cloud-native-development-platform)

- **Series B — $37.5M, October 28, 2020.** Led by **NEA** (New Enterprise
  Associates; partner Aaron Jacobson joined the board), with **Madrona** and
  **Tola Capital** participating. Pulumi stated total raised to date was **$57.5M**
  and cited "10X growth in adoption in the last 12 months."
  - [Pulumi press release — "Pulumi Raises $37.5M in Series B Funding"](https://info.pulumi.com/press-release/series-b-announcement)

- **Series C — $41M, announced October 3, 2023.** Led by **Madrona**, with
  **NEA**, **Tola Capital**, and **Strike Capital** participating. Pulumi cited
  150,000+ community users, 2,000+ customers, and 100+ employees. (Valuation not
  disclosed.)
  - [Pulumi Blog — "Building the Best Infrastructure as Code with $41M Series C Funding"](https://www.pulumi.com/blog/series-c/)
  - [Pulumi press release — "Pulumi Raises $41M in Series C"](https://info.pulumi.com/press-release/pulumi-raises-series-c)
  - [GeekWire — "Cloud startup Pulumi raises $41M…" (2023)](https://www.geekwire.com/2023/cloud-startup-pulumi-raises-41m-from-madrona-nea-to-grow-infrastructure-as-code-platform/)

**Cumulative:** ~$20M after Series A, **$57.5M** after Series B (per Pulumi), and
roughly **$99M** total after Series C (the $99M total is reported by aggregators
such as Tracxn/Clay; it is consistent with $57.5M + $41M but the aggregate figure
itself is secondary).
- [Tracxn — Pulumi funding](https://tracxn.com/d/companies/pulumi/__pkquhIUgxyBAsLc22Mtq7bRM4mGvg9wM_iThXB_c6cU/funding-and-investors)

---

## Cloud-API integration: how Pulumi gets its providers

Pulumi's resource coverage comes from two distinct mechanisms, both flowing
through a common **Pulumi Package Schema**.

### The Pulumi Package Schema
- The Package Schema is the metadata file that defines a provider's resources,
  inputs, and outputs. Language SDKs are code-generated from this schema; they may
  be published to package feeds or generated locally by the Pulumi CLI.
  - [Pulumi Docs — Pulumi Packages](https://www.pulumi.com/docs/iac/concepts/packages/)
  - [Pulumi Docs — Resource Providers](https://www.pulumi.com/docs/iac/concepts/providers/)

### Bridged providers — a dependency on the Terraform ecosystem
- **`pulumi-terraform-bridge`** is an Apache-2.0 library that "adapts any
  Terraform Provider built using the Terraform Plugin SDK for use with Pulumi."
  At **build time** it code-generates a Pulumi package by inspecting the
  Terraform provider's schema; at **runtime** it connects the Pulumi engine to
  the Terraform provider over Pulumi's RPC interfaces, reusing the Terraform
  provider for validation and diffs.
  - [GitHub — pulumi/pulumi-terraform-bridge](https://github.com/pulumi/pulumi-terraform-bridge)
- This means many of Pulumi's most-used providers (e.g., classic `aws`, `azure`,
  `gcp`) are **bridged Terraform providers**, i.e., Pulumi reuses the Terraform
  provider ecosystem. Pulumi itself states it has "supported bridging Terraform
  providers for use in Pulumi from the beginning" and that "many of the most used
  providers in the Pulumi ecosystem are bridged Terraform providers."
  - [Pulumi Blog — "Introducing: Support For Using Any Terraform Provider with Pulumi" (Aug 29 2024)](https://www.pulumi.com/blog/any-terraform-provider/)
- Pulumi frames Terraform providers as a de-facto industry standard rather than a
  Terraform-only artifact: "Terraform providers are the closest thing the
  industry has today to a 'defacto standard' … There is nothing innately
  Terraform-specific about these providers." (Note Pulumi can also bridge
  **OpenTofu** providers.)
  - [Pulumi Blog (Aug 29 2024)](https://www.pulumi.com/blog/any-terraform-provider/)

### Native providers — generated from cloud APIs (not Terraform)
- **Native providers** are generated directly from a cloud's own API
  specification, producing both resource definitions and CRUD calls. Examples
  include **Azure Native** (from the Azure Resource Manager / Azure OpenAPI specs)
  and **Google Native**, plus Kubernetes.
  - [Pulumi Docs — Resource Providers](https://www.pulumi.com/docs/iac/concepts/providers/)
  - [Pulumi Registry — Azure Native](https://www.pulumi.com/registry/packages/azure-native/)
- Pulumi announced this native-provider strategy around **April 20, 2021**,
  promising "100% API coverage" and "same-day access to feature updates," driven
  by nightly GitHub Actions automation that checks Azure/Google/AWS API specs and
  opens PRs to regenerate the providers. Pulumi explicitly contrasted this with
  hand-maintained/bridged providers that "can't always keep up with the pace of
  innovation."
  - [Pulumi Blog — "Model and program the cloud with Pulumi native providers" (Apr 20 2021)](https://www.pulumi.com/blog/pulumiup-native-providers/)

---

## Positioning vs Terraform, and the 2023 HashiCorp BSL relicense

### Background
- On **August 10, 2023**, HashiCorp relicensed Terraform (and most of its
  products) from the Mozilla Public License (MPL 2.0) to the **Business Source
  License (BSL) 1.1**, a source-available but non-open-source license.
  - [The Register — "HashiCorp changes its source licence to BSL" (Aug 11 2023)](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/)

### Pulumi's official response
- On **August 11, 2023**, Joe Duffy published a Pulumi blog post emphasizing that
  Pulumi is "true open source, uses the Apache 2.0 license, and does not and never
  will depend on BSL-licensed software in any way," and that Pulumi is
  "unaffected by HashiCorp relicensing their software." The post expressed support
  for "cloud friends who have been affected."
  - [Pulumi Blog — "Pulumi Loves Open Source" (Aug 11 2023), by Joe Duffy](https://www.pulumi.com/blog/pulumi-hearts-opensource/)

### Duffy's sharper comments on Hacker News (attributed opinion)
- On the HN thread about the relicense (**August 10, 2023**), Duffy, identifying
  as Pulumi's founder/CEO, was more pointed. These are **his reported
  statements/opinions**, attributed to the source:
  - "The blog post is disingenuous. We tried many times to contribute upstream
    fixes to Terraform providers, but HashiCorp would never accept them."
  - "So we've had to maintain forks. They lost their OSS DNA a long time ago, and
    this move just puts the final nail in the coffin."
  - [Hacker News thread (item 37082324)](https://news.ycombinator.com/item?id=37082324)
- This is consistent with — but separate from — the measured official blog tone;
  the strong language ("disingenuous," "final nail in the coffin") is Duffy's
  forum comment, not Pulumi corporate copy.

### Did Pulumi capitalize on it?
- Pulumi used the moment to reinforce its open-source positioning (Apache-2.0 vs
  BSL) rather than announce a license-driven product. It is fair to say Pulumi
  positioned itself as the genuinely open-source IaC alternative, while continuing
  to invest in native providers as a path that reduces reliance on the
  Terraform-provider ecosystem.
  - Positioning: [Pulumi Blog — "Pulumi Loves Open Source"](https://www.pulumi.com/blog/pulumi-hearts-opensource/);
    native-provider direction: [Pulumi Blog (Apr 20 2021)](https://www.pulumi.com/blog/pulumiup-native-providers/)
  - Pulumi's evergreen comparison page (positioning over time):
    [Pulumi Docs — "Pulumi vs. Terraform"](https://www.pulumi.com/docs/iac/comparisons/terraform/)
- Note on irony/tension: Pulumi simultaneously markets its own open-source purity
  **and** depends heavily on the (now-BSL) Terraform provider ecosystem via the
  bridge. Pulumi's mitigation narrative is (a) native providers and (b) bridging
  OpenTofu — the open-source Terraform fork. (Analytical synthesis grounded in the
  two blog posts cited above; the framing as "tension" is this document's
  characterization, not a Pulumi statement.)

---

## Pulumi's own licensing and business model

- **Open-source core:** Pulumi's engine, CLI, SDKs, and the terraform-bridge are
  licensed **Apache-2.0**.
  - [Wikipedia](https://en.wikipedia.org/wiki/Pulumi);
    [GitHub — pulumi/pulumi-terraform-bridge (Apache-2.0)](https://github.com/pulumi/pulumi-terraform-bridge)
- **Commercial model — Pulumi Cloud (formerly Pulumi Service):** a managed SaaS
  backend for state management, secrets, RBAC, policy, and team collaboration,
  introduced commercially as the "Team Edition" alongside the Series A in
  October 2018, with a free open-source self-managed/local backend also available.
  - [TechCrunch (Oct 22 2018)](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/)
- **Community/licensing friction:** I did not find evidence of a major
  *license*-driven community backlash against Pulumi itself (in contrast to
  HashiCorp's BSL controversy). The most notable reported quality controversy is
  about **Pulumi AI**, not licensing — see below.
  - **Could not verify** any significant community backlash specifically over
    Pulumi's *own* open-source licensing terms.

---

## Notable product milestones (brief, sourced)

- **April 2021 — Pulumi native providers** (azure-native, google-native,
  aws-native), generated from cloud API specs.
  - [Pulumi Blog (Apr 20 2021)](https://www.pulumi.com/blog/pulumiup-native-providers/)
- **2023 — Pulumi AI / Pulumi Insights:** natural-language generation of
  infrastructure-as-code, plus analytics/search across cloud infrastructure.
  - [Pulumi Blog — "A recap of October 2023"](https://www.pulumi.com/blog/october-23-roundup/)
- **October 10, 2023 — Pulumi ESC (Environments, Secrets, and Configuration):**
  launched in preview; a solution to manage environments/secrets/config that can
  pull from sources like AWS KMS, Azure Key Vault, GCP KMS, 1Password, and
  HashiCorp Vault, and be consumed by Pulumi, Terraform, GitHub Actions, Docker,
  and others. (Later reached general availability.)
  - [Pulumi press release — "Pulumi Makes Cloud Configuration Simple and Secure with Pulumi ESC" (Oct 10 2023)](https://info.pulumi.com/press-release/announcing-pulumi-esc)
  - GA announcement: [Pulumi Blog — "Announcing the General Availability of Pulumi ESC"](https://www.pulumi.com/blog/pulumi-esc-ga/)
- **Pulumi Copilot** (AI assistant within Pulumi Cloud) and ongoing ESC features
  (versioning, SDK, rotated secrets) appear in 2024–2025 release notes.
  - [Pulumi Release Notes 106](https://www.pulumi.com/blog/pulumi-release-notes-106/);
    [Pulumi Release Notes 117](https://www.pulumi.com/blog/pulumi-release-notes-117/)

---

## Controversies (separating fact from reported claim)

1. **HashiCorp BSL relicense reaction (Aug 2023).** *Fact:* Pulumi published an
   official Apache-2.0/open-source positioning post.
   ([Pulumi Blog](https://www.pulumi.com/blog/pulumi-hearts-opensource/))
   *Reported opinion (attributed to Joe Duffy on HN):* HashiCorp's post was
   "disingenuous," Pulumi's upstream provider fixes were repeatedly rejected,
   forcing forks, and HashiCorp "lost their OSS DNA."
   ([Hacker News](https://news.ycombinator.com/item?id=37082324))
2. **Pulumi AI code-quality concerns (reported May 2024).** *Reported claim:*
   The Register reported that Pulumi-AI-generated code examples indexed by Google
   were in many cases untested and/or buggy, raising quality-control concerns
   about auto-generated docs surfacing in search.
   ([Wikipedia summary, citing The Register](https://en.wikipedia.org/wiki/Pulumi))
   - **Partially verified:** This is sourced via Wikipedia's summary of a
     Register article; I did not fetch the original Register piece directly, so
     treat the specifics as reported, not independently confirmed.
3. **Structural tension:** Pulumi's open-source marketing coexists with deep
   reliance on the Terraform provider ecosystem via the bridge. This is an
   analytical observation in this document (grounded in the bridge repo and
   Pulumi's own blog), not a claim made by Pulumi.

---

## Claims I could NOT fully verify

- **Exact seed-round amount (~$5M) and precise date (June 2018):** reported only
  by aggregators (Crunchbase page returned HTTP 403; TechCrunch launch piece gave
  no figure).
- **$99M cumulative total funding:** arithmetic-consistent and aggregator-reported
  (Tracxn/Clay), but not stated in a Pulumi primary source.
- **Luke Hoban as a named co-founder in 2017:** supported by Pulumi's leadership
  page and Wikipedia, but the contemporaneous June 2018 TechCrunch launch article
  named only Duffy and Rudder.
- **Pulumi AI buggy-code controversy specifics:** sourced via Wikipedia's summary
  of The Register; original article not directly fetched here.
- **"Pulumi = Hawaiian for broom" / Chris Brumme tribute:** reported by a
  secondary business-model blog only; not from a Pulumi primary source.

---

*Compiled via web research with primary-source verification where possible.
Last researched: May 2026.*

---

## Key people & teams (chronological)

This section traces the people behind Pulumi roughly in the order they enter the
story. Every factual claim is linked inline; unverifiable items are marked
"Could not verify."

### Pre-history: the Microsoft developer-tools lineage (1980s–2016)

All three Pulumi co-founders came out of Microsoft's developer-tools and
languages world, which is the through-line connecting them.

- **Eric Rudder** joined Microsoft in **1988** and spent ~25 years there. He
  helped create the **Visual Studio** product line as its General Manager, ran
  the developer/platform evangelism and the multibillion-dollar **Server and
  Tools** business, and held the titles **Executive Vice President of Advanced
  Technology / Advanced Strategy** and **Chief Technical Strategy Officer**. He
  served directly under Chairman and Chief Software Architect **Bill Gates** on
  Microsoft's technical planning — reported as Gates's **Technical Assistant ("TA")
  for ~5 years**.
  - Microsoft EVP / Server & Tools / Advanced Technology background and Visual
    Studio GM role: [Madrona — "Why Madrona Invested in Pulumi"](https://www.madrona.com/pulumi/);
    [The Org — Eric Rudder (Co-Founder & Executive Chairman; "Previously, Eric was the Executive Vice President at Microsoft")](https://theorg.com/org/pulumi/org-chart/eric-rudder)
  - Working directly with Bill Gates / Technical Strategy / TA role: reported via
    search aggregation of Microsoft press and profile sources.
    **Could not verify the exact "TA for 5 years to Bill Gates" claim from a
    single primary Microsoft source** (the Microsoft press Q&A URL that would
    document it returned HTTP 404 when fetched); the EVP/Server-and-Tools and
    Visual Studio GM facts are corroborated by Madrona and The Org above.

- **Joe Duffy** spent roughly **20 years / ~12+ years at Microsoft** (his framing
  varies between "nearly two decades in industry" and "12 years at Microsoft")
  in the Developer Division. He was **an early engineer on .NET** who
  **architected its concurrency, parallelism, and asynchrony support** (work that
  fed into the async/await model now common across C#, JavaScript, Rust, Python),
  led the **developer platform for the Midori research OS** (a from-scratch,
  safety- and concurrency-focused operating system; he worked on it roughly
  **2009–2014**), and as **Director of Engineering for Languages/Compilers**
  managed Microsoft's languages groups — including **open-sourcing .NET Core** and
  taking it cross-platform.
  - Microsoft role / .NET concurrency / Midori / languages leadership:
    [QCon London — Joe Duffy speaker bio ("Pulumi Co-founder & CEO, Previously @Microsoft Director of Engineering for Languages/Compilers")](https://archive.qconlondon.com/speakers/joe-duffy);
    [Joe Duffy — "Hello, Pulumi!" (Jun 18 2018)](https://joeduffyblog.com/2018/06/18/hello-pulumi/)
  - Midori dates and scope: [Joe Duffy — "Blogging about Midori" (Nov 3 2015)](https://joeduffyblog.com/2015/11/03/blogging-about-midori/)
  - Concurrency career retrospective: [Joe Duffy — "15 Years of Concurrency" (Nov 30 2016)](https://joeduffyblog.com/2016/11/30/15-years-of-concurrency/)
  - His blog (referenced throughout): [joeduffyblog.com](https://joeduffyblog.com/)
  - "12 years at Microsoft" framing: [TechCrunch (Oct 22 2018)](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/)

- **Luke Hoban** was at Microsoft where he **co-founded / co-created TypeScript**,
  contributed to **Go support in Visual Studio Code**, sat on the design teams for
  **ECMAScript and C#**, was a **representative to the ECMA TC39** standards body,
  and served as **Technical Assistant to the CVP of the Developer Division**. He
  then moved to **AWS**, where he was a **product manager on EC2**, leading product
  definition for EC2 instance families (GPU, FPGA, and T2 compute).
  - TypeScript co-creator / AWS EC2 PM / Microsoft roles:
    [QCon London — Luke Hoban speaker bio ("CTO @PulumiCorp & TypeScript Co-Creator")](https://archive.qconlondon.com/speakers/luke-hoban);
    [Luke Hoban — GitHub profile](https://github.com/lukehoban);
    [lukehoban.com](https://lukehoban.com/)

### Late 2016 — Duffy + Rudder start exploring Pulumi

- Duffy says he and his **"friend and co-founder" Eric Rudder** began exploring
  what became Pulumi in **late 2016**, motivated by Duffy's frustration that,
  despite ~20 years of experience, "trying to get my code into the cloud made me
  feel dumb" — dozens of lines of JSON/YAML config to do simple things. This is
  the origin of the "real programming languages instead of a DSL" thesis.
  - [Joe Duffy — "Hello, Pulumi!" (Jun 18 2018)](https://joeduffyblog.com/2018/06/18/hello-pulumi/)

### 2017 — Founding trio

- Pulumi Corporation was founded in **2017** in Seattle by **Joe Duffy (CEO)**,
  **Eric Rudder (Executive Chairman)**, and **Luke Hoban (CTO)**. Madrona's
  investment note describes the three together as "a world-class team" with
  "decades of experience in platforms, tools, and programming models."
  - [Madrona — "Why Madrona Invested in Pulumi"](https://www.madrona.com/pulumi/);
    [Pulumi — Wikipedia](https://en.wikipedia.org/wiki/Pulumi)
  - **Note (consistent with the Founding section above):** the contemporaneous
    June 2018 launch coverage and Duffy's own launch post name Duffy and Rudder
    explicitly; **Luke Hoban's named co-founder/CTO role is documented via Pulumi's
    leadership page, Madrona, his own bios, and Wikipedia** rather than the launch
    press. ([Joe Duffy — "Hello, Pulumi!"](https://joeduffyblog.com/2018/06/18/hello-pulumi/))

### June 18, 2018 — Out of stealth, leadership public

- At launch, the three founders were public-facing: **Duffy (CEO)** as the
  technical voice and primary blogger, **Rudder (Executive Chairman)** as the
  enterprise/strategy figure (he and Duffy co-presented Pulumi's story), and
  **Hoban (CTO)** as the languages/SDK lead.
  - Rudder + Duffy as the public founder pair:
    [Madrona — "Founded and Funded: Building an Open Source Business from Scratch with Eric Rudder and Joe Duffy of Pulumi"](https://www.madrona.com/founded-and-funded-building-an-open-source-business-from-scratch-with-eric-rudder-and-joe-duffy-of-pulumi/)

### 2018–2023 — Board and investor people (entering with funding)

- **S. "Soma" Somasegar** (Managing Director, **Madrona**) — himself a former
  Microsoft Developer Division corporate VP — joined the board at the seed stage
  and championed the investment, calling the founders "a world-class team."
  - [Madrona — "Why Madrona Invested in Pulumi"](https://www.madrona.com/pulumi/)
- **Sheila Gulati** (**Tola Capital**) joined the board around the **Series A**
  (Oct 2018); **Aaron Jacobson** (**NEA**) joined around the **Series B**
  (Oct 2020). (See the Funding timeline above for sourcing.)
  - Series A board / Tola: [TechCrunch (Oct 22 2018)](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/)
  - Series B board / NEA: [Pulumi press release — "Pulumi Raises $37.5M in Series B Funding"](https://info.pulumi.com/press-release/series-b-announcement)

### August 2023 — Duffy as open-source spokesman

- During the HashiCorp BSL relicense, **Joe Duffy** was Pulumi's public voice both
  in the official "Pulumi Loves Open Source" post and (more pointedly) as a
  Hacker News commenter identifying as Pulumi's founder/CEO. (Full detail and
  quotes are in the BSL section above.)
  - [Pulumi Blog — "Pulumi Loves Open Source" (Aug 11 2023)](https://www.pulumi.com/blog/pulumi-hearts-opensource/);
    [Hacker News thread (item 37082324)](https://news.ycombinator.com/item?id=37082324)

### ~November 2024 — Luke Hoban departs for GitHub

- **Luke Hoban announced his departure from Pulumi "after an amazing 7.5 years"**
  on LinkedIn, praising Pulumi's transition into a multi-product company and
  expressing confidence in the remaining leadership. 7.5 years from a 2017 start
  places the departure in **late 2024**.
  - [Luke Hoban — LinkedIn departure post ("After an amazing 7.5 years I've made the…")](https://www.linkedin.com/posts/lukejhoban_after-an-amazing-75-years-ive-made-the-activity-7264344794238205953-j4sK)
  - **Could not verify the exact departure date** from a primary source; LinkedIn
    rendered the post as "1y" relative time rather than an absolute date, and the
    "7.5 years" phrasing is the basis for the late-2024 estimate.
- He moved to **GitHub / Microsoft as VP of Engineering** focused on **Developer
  AI and GitHub Copilot agents** (Copilot CLI, Copilot SDK, Copilot Cloud Agent,
  Copilot Code Review agent).
  - [Luke Hoban — GitHub profile](https://github.com/lukehoban)
  - **Could not verify a primary announcement** naming GitHub as the destination
    in the departure post itself (the post did not state the employer; the GitHub
    role is confirmed via his own GitHub profile bio rather than the LinkedIn
    farewell).

### Could not verify (people section)

- **Eric Rudder as Bill Gates's "Technical Assistant for ~5 years":** widely
  reported, but not pinned to a single primary Microsoft source here (the
  Microsoft press Q&A URL returned HTTP 404). His EVP / Server-and-Tools / Visual
  Studio GM background is corroborated by Madrona and The Org.
- **Luke Hoban's exact Pulumi departure date** and **a primary source naming
  GitHub as his next employer in the farewell announcement** (see above).
- **Precise count of Duffy's Microsoft tenure** ("12 years" per TechCrunch vs.
  "nearly two decades in industry" in his own framing) — both framings appear;
  the difference is industry-total vs. Microsoft-only.

---

## Company & corporate history (chronological)

This section traces Pulumi as a *business* — incorporation, funding, headcount,
products, and licensing/positioning as a commercial strategy — separate from the
people and the IaC-thesis narrative above. Every factual claim is linked inline;
unverifiable items are marked "Could not verify."

### 2017 — Pulumi Corporation incorporated (Seattle)

- **Pulumi Corporation** was founded in **2017** and is headquartered in
  **Seattle, Washington**. It remains a **privately held**, venture-backed
  company; as of this writing there has been **no IPO and no acquisition**.
  - HQ Seattle and 2017 founding: [Pulumi — Wikipedia](https://en.wikipedia.org/wiki/Pulumi);
    HQ "Seattle" stated in the seed press release: [Pulumi press release — "Pulumi Launches Cloud Development Platform…" (Jun 18 2018)](https://info.pulumi.com/press-release/pulumi-launches-cloud-development-platform-to-help-teams-get-code-to-the-cloud-faster)
  - Private / venture-backed status (no public-market listing): aggregator
    profiles such as [PitchBook — Pulumi profile](https://pitchbook.com/profiles/company/185684-32)
    and [CB Insights — Pulumi financials](https://www.cbinsights.com/company/pulumi/financials)
    classify it as a private company; no IPO or M&A event is reported in any of
    the funding sources cited below.

### June 18, 2018 — Out of stealth + $5M seed (Madrona / Tola)

- Pulumi launched publicly and **open-sourced** its platform on **June 18, 2018**,
  and simultaneously disclosed a **$5M "series seed" round** from **Madrona
  Venture Group** and **Tola Capital**. Madrona Managing Director **S. "Soma"
  Somasegar** joined the board.
  - Seed amount ($5M), investors, date, board seat, "Seattle" HQ — all stated in
    the primary press release: [Pulumi press release — "Pulumi Launches Cloud Development Platform…" (Jun 18 2018)](https://info.pulumi.com/press-release/pulumi-launches-cloud-development-platform-to-help-teams-get-code-to-the-cloud-faster)
  - (This now **confirms the $5M seed figure from a primary Pulumi source**,
    resolving the earlier "could not verify" caveat in the Funding timeline that
    relied on the 403-blocked Crunchbase page.)

### October 22, 2018 — Series A ($15M, Madrona) + first commercial tier

- **Series A — $15M**, announced **October 22, 2018**, led by **Madrona Venture
  Group** with **Tola Capital** participating. Announced alongside Pulumi's first
  paid commercial offering ("Team Edition"), establishing the **open-core
  business model**: free open-source CLI/SDK/engine plus a paid managed backend.
  - [TechCrunch — "Pulumi raises $15M…" (Oct 22 2018)](https://techcrunch.com/2018/10/22/pulumi-raises-15m-for-its-infrastructure-as-code-platform/);
    [Pulumi press release — "Pulumi Announces $15M in Series A Funding"](https://info.pulumi.com/press-release/pulumi-announces-15m-in-series-a-funding-to-accelerate-development-and-adoption-of-its-cloud-native-development-platform)
  - Cumulative after Series A: ~$20M ($5M seed + $15M).

### October 28, 2020 — Series B ($37.5M, NEA) — "cloud engineering"

- **Series B — $37.5M**, announced **October 28, 2020**, led by **NEA** (New
  Enterprise Associates; partner **Aaron Jacobson** joined the board), with
  **Madrona** and **Tola Capital** participating. Pulumi stated **total raised to
  date was $57.5M** and cited **"10x growth in adoption in the last 12 months."**
  The raise accompanied a go-to-market build-out (new CMO Jay Wampold, VP Sales
  Kevin Kotecki, VP Eng Lee-Ming Zen) and the "cloud engineering platform"
  repositioning (Pulumi 2.0: testing, policy-as-code, team collaboration).
  - [TechCrunch — "Pulumi raises $37.5M Series B…" (Oct 28 2020)](https://techcrunch.com/2020/10/28/pulumi-raises-37-5m-series-b-for-its-cloud-engineering-platform/);
    [Pulumi press release — "Pulumi Raises $37.5M in Series B Funding"](https://info.pulumi.com/press-release/series-b-announcement)
  - **Valuation not disclosed** in the round.

### March 3, 2022 — Commercial tiers formalized (Business Critical + self-hosting)

- Pulumi launched a **Business Critical** edition (premium enterprise tier),
  restructuring its commercial line into **Individual → Team → Enterprise →
  Business Critical** and retiring the older bronze/silver/gold structure.
  Business Critical adds **self-hosting in the customer's own cloud/data center**,
  policy guardrails, federated identity/SSO (SAML 2.0), auditing, 24/7 support,
  and AWS Marketplace availability — the enterprise/self-hosting tier of the
  business model.
  - [InfoWorld — "Pulumi launches Business Critical edition…" (Mar 3 2022)](https://www.infoworld.com/article/2334569/pulumi-launches-business-critical-edition-for-enterprise-customers.html)
  - Current pricing tiers and self-hosting: [Pulumi — Pricing](https://www.pulumi.com/pricing/);
    [Pulumi — Self-Hosted Pulumi Cloud](https://www.pulumi.com/product/self-hosted/)
  - Reported pricing (secondary): Enterprise from ~$25K, Business Critical ~$50K
    minimum spend — reported by InfoWorld above; treat exact figures as reported.

### 2023 — Product expansion into an AI/intelligence platform

The commercial product expanded well beyond state storage into "intelligence"
and AI, broadening the SaaS upsell surface.

- **April 13, 2023 — Pulumi Insights** (intelligence/search/analytics over cloud
  infrastructure) and **Pulumi AI** (generative-AI natural-language IaC) launched.
  - [Pulumi Blog — "Pulumi Insights: Intelligence for Cloud Infrastructure"](https://www.pulumi.com/blog/pulumi-insights/);
    [Business Wire — "Pulumi Launches 'Pulumi Insights'…" (Apr 13 2023)](https://www.businesswire.com/news/home/20230413005357/en/Pulumi-Launches-%E2%80%98Pulumi-Insights%E2%80%99-%E2%80%93-Intelligence-for-Infrastructure-as-Code)
- **October 3, 2023 — Series C ($41M, Madrona)** led by **Madrona** with **NEA**,
  **Tola Capital**, and **Strike Capital** participating. At the round Pulumi
  cited **2,000+ customers, 150,000+ community/end users, 100+ employees**, a
  **3,400+ contributor** open-source community, and that it had **doubled revenue**
  year-over-year. Crucially for the business model, Pulumi stated **"two-thirds of
  end users elect to use Pulumi Cloud"** — i.e., strong free-to-paid conversion
  toward the SaaS backend. **Valuation not disclosed.**
  - [Pulumi Blog — "Building the Best Infrastructure as Code with $41M Series C"](https://www.pulumi.com/blog/series-c/);
    [Pulumi press release — "Pulumi Raises $41M in Series C"](https://info.pulumi.com/press-release/pulumi-raises-series-c);
    [GeekWire — "Cloud startup Pulumi raises $41M…" (2023)](https://www.geekwire.com/2023/cloud-startup-pulumi-raises-41m-from-madrona-nea-to-grow-infrastructure-as-code-platform/);
    [Madrona — "Madrona Fuels Growth… With Pulumi" (Series C)](https://www.madrona.com/pulumi-series-c/)
- **October 10–11, 2023 — Pulumi ESC** (Environments, Secrets, and Configuration)
  launched in preview, and **Pulumi for Platform Teams** (developer portal,
  Backstage plugin, advanced deployments) was announced — pushing Pulumi up-market
  into platform engineering.
  - [Pulumi press release — "Pulumi Makes Cloud Configuration Simple and Secure with Pulumi ESC" (Oct 10 2023)](https://info.pulumi.com/press-release/announcing-pulumi-esc);
    [Pulumi Blog — "A recap of October 2023"](https://www.pulumi.com/blog/october-23-roundup/)
- **Cumulative raised after Series C: ~$99M** ($5M + $15M + $37.5M + $41M). The
  $99M aggregate is reported by aggregators (Clay/Tracxn) and matches the
  arithmetic of the primary round figures above; Pulumi's own Series C materials
  do not restate a single cumulative number.
  - [Clay — Pulumi funding](https://www.clay.com/dossier/pulumi-funding);
    [Tracxn — Pulumi funding](https://tracxn.com/d/companies/pulumi/__pkquhIUgxyBAsLc22Mtq7bRM4mGvg9wM_iThXB_c6cU/funding-and-investors)

### "Pulumi Service" → "Pulumi Cloud" rebrand

- The commercial managed backend, originally marketed as the **Pulumi Service**
  (a.k.a. "Team Edition" / "Enterprise"), is now branded **Pulumi Cloud**. Both
  names still appear in Pulumi's own assets (the IaC provider that manages it is
  still `pulumi-pulumiservice` / "Pulumi Service provider").
  - Current branding: [Pulumi — Pulumi Cloud product page](https://www.pulumi.com/product/pulumi-cloud/);
    [Pulumi Docs — Pulumi Cloud](https://www.pulumi.com/docs/pulumi-cloud/)
  - Legacy "Service" naming persisting: [GitHub — pulumi/pulumi-pulumiservice](https://github.com/pulumi/pulumi-pulumiservice)
  - **Could not verify** a single dated primary announcement formally renaming
    "Pulumi Service" to "Pulumi Cloud"; the change appears to have rolled out
    gradually across docs/marketing rather than via one press release.

### 2024 — Maturation of the platform (ESC GA, year of growth)

- **September 18, 2024 — Pulumi ESC reached general availability** (announced at
  the PulumiUP user conference), alongside Insights 2.0 — moving the secrets/
  config product from preview to a GA commercial offering.
  - [Pulumi Blog — "Announcing the General Availability of Pulumi ESC"](https://www.pulumi.com/blog/pulumi-esc-ga/);
    [ITOps Times — "Pulumi ESC now generally available, Insights 2.0 released"](https://www.itopstimes.com/itops/pulumi-esc-now-generally-available-insights-2-0-released/)
- **Pulumi Copilot**, an AI assistant embedded in Pulumi Cloud, was announced as a
  commercial differentiator in this period.
  - [Pulumi press release — "Announcing Pulumi Copilot…"](https://info.pulumi.com/press-release/announcing-pulumi-copilot)

### May 6, 2025 — Pulumi IDP (internal developer platform)

- **Pulumi IDP**, an **internal developer platform** product, was announced in
  **public preview on May 6, 2025** (at PulumiUP), positioned as the next
  evolution of Pulumi Cloud for platform-engineering "golden paths," with managed
  SaaS and self-hosted options and GA targeted later in 2025. This pushes Pulumi's
  commercial scope from IaC tooling into the broader platform-engineering market.
  - [Pulumi Blog — "Announcing Pulumi IDP: Platform Engineering Accelerated"](https://www.pulumi.com/blog/announcing-pulumi-idp/);
    [PRWeb — "Introducing Pulumi IDP…" (2025)](https://www.prweb.com/releases/introducing-pulumi-idp-the-fastest-most-secure-way-to-deliver-cloud-infrastructure-at-scale-302446312.html);
    [InfoQ — "Pulumi IDP Launches a Golden Path…" (May 2025)](https://www.infoq.com/news/2025/05/pulumi-idp/)

### The business model, summarized (open-core + SaaS)

- **Open-source core (Apache-2.0):** the Pulumi CLI, engine, language SDKs, and
  the terraform-bridge are free and open source under **Apache-2.0**, with a free
  self-managed/local state backend.
  - [Pulumi — Wikipedia](https://en.wikipedia.org/wiki/Pulumi);
    [GitHub — pulumi/pulumi-terraform-bridge (Apache-2.0)](https://github.com/pulumi/pulumi-terraform-bridge)
- **Commercial layer — Pulumi Cloud (formerly Pulumi Service):** a managed SaaS
  backend (state, secrets, RBAC, policy, deployments, Insights, Copilot/AI),
  monetized via **Individual / Team / Enterprise / Business Critical** tiers, with
  **self-hosting** available at the top tier for compliance-sensitive customers.
  Conversion economics: Pulumi reported **~two-thirds of end users adopt Pulumi
  Cloud**.
  - [Pulumi — Pricing](https://www.pulumi.com/pricing/);
    [Pulumi — Self-Hosted Pulumi Cloud](https://www.pulumi.com/product/self-hosted/);
    [Pulumi Blog — Series C (two-thirds adoption figure)](https://www.pulumi.com/blog/series-c/)

### Open source as a *business* differentiator vs HashiCorp's BSL

- When **HashiCorp relicensed Terraform to the Business Source License (BSL 1.1)**
  on **August 10, 2023**, Pulumi turned its **Apache-2.0** licensing into an
  explicit *commercial* and competitive talking point: CEO Joe Duffy stated Pulumi
  "is true open source, uses the Apache 2.0 license, and does not and never will
  depend on BSL-licensed software in any way." This positioned Pulumi as the
  "genuinely open" IaC vendor for buyers wary of license risk — a corporate
  positioning move, distinct from the licensing mechanics covered in the BSL
  section above.
  - HashiCorp BSL: [The Register — "HashiCorp changes its source licence to BSL" (Aug 11 2023)](https://www.theregister.com/2023/08/11/hashicorp_bsl_licence/)
  - Pulumi's positioning: [Pulumi Blog — "Pulumi Loves Open Source" (Aug 11 2023)](https://www.pulumi.com/blog/pulumi-hearts-opensource/)
  - (See the BSL section earlier in this document for the full mechanics, Duffy's
    sharper Hacker News remarks, and the structural-tension analysis.)

### Could not verify (corporate section)

- **Valuations:** no funding round (seed, A, B, or C) has a publicly disclosed
  pre-/post-money valuation; none of the primary press releases state one, and
  aggregator pages (PitchBook/CB Insights) are behind paywalls/not loaded here.
- **$99M cumulative total:** arithmetic-consistent and aggregator-reported
  (Clay/Tracxn); not restated as a single figure in a Pulumi primary source.
- **Exact current headcount:** Pulumi stated "100+ employees" at the Series C
  (Oct 2023); later aggregator figures (~129–132) are secondary/estimated and not
  primary-sourced here.
- **"Pulumi Service" → "Pulumi Cloud" rename date:** no single dated primary
  announcement located; the rebrand appears to have rolled out gradually.
