# Heroku — A Sourced History

A chronological, sourced history of Heroku, the platform-as-a-service (PaaS) that
popularized `git push` deployment and the "dyno," its acquisition by Salesforce,
and its long arc from developer darling to Salesforce "sustaining engineering."
Every non-trivial claim links to a working source. Primary sources (Heroku /
Salesforce blogs and press, founders' own posts, SEC filings) are preferred, with
reputable outlets (TechCrunch, The Register, Bloomberg, InfoWorld, etc.) as
corroboration. Items that could not be confirmed are marked **"Could not verify."**

---

## Timeline

### Founding and the pivot (2007–2009)

- **June 2007** — Heroku was founded in San Francisco by **James Lindenbaum,
  Adam Wiggins, and Orion Henry**. Heroku had "been in development since June 2007,
  when it supported only the Ruby programming language."
  Sources: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku);
  [Y Combinator company profile, "Heroku"](https://www.ycombinator.com/companies/heroku).

- **Winter 2008 (Y Combinator)** — Heroku went through **Y Combinator's Winter 2008
  batch**. The original product was an **in-browser Ruby/Rails code editor and
  deployment tool** — "a place where you could write Ruby on Rails applications right
  there in your web browser." The team found the editor "wasn't really sticky" and
  observed that developers were mainly using it as an easy way to deploy Ruby apps,
  which prompted a **pivot to a hosting platform (PaaS)** beginning around mid-2008.
  Sources: [Y Combinator company profile](https://www.ycombinator.com/companies/heroku);
  Adam Wiggins, "The story of Heroku" (The Changelog #513),
  [changelog.com/podcast/513](https://changelog.com/podcast/513).
  *(The "Winter 2008" batch label and the in-browser-editor origin are consistently
  reported in the YC profile and Wiggins's own Changelog interview; the precise
  mid-2008 pivot timing is from secondary retellings of that interview rather than a
  dated primary document — treat the exact month as **lightly sourced**.)*

- **January 2009** — Heroku **relaunched a rebuilt platform** "built almost from
  scratch after a three-month effort." This is the era in which the **`git push
  heroku`** deployment model and the **dyno** abstraction became the platform's
  defining features.
  Source: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku).
  *(The January 2009 relaunch is sourced to Wikipedia; the association of that
  relaunch specifically with the `git push`/dyno model is per the founders'
  retellings — see the Changelog interview above. A precise dated primary
  announcement of the first `git push heroku` release was **not** located —
  **Could not verify** an exact date.)*

- **Under the hood: AWS.** Heroku ran as an opinionated PaaS layered on **Amazon Web
  Services (EC2)** infrastructure, abstracting servers away behind the dyno (an
  isolated, virtualized Linux container that runs a single command).
  Sources: [Heroku, "Heroku Dynos"](https://www.heroku.com/dynos/);
  [Honeybadger, "Heroku vs AWS"](https://www.honeybadger.io/blog/heroku-vs-aws/).

- **October 2009** — **Byron Sebastian joined Heroku as CEO.**
  Source: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku).

- **Add-ons (≈2009).** Heroku's third-party **add-ons** (the seed of what became the
  add-ons marketplace, later **Heroku Elements**) date to the platform's early years;
  the broader **Heroku Elements** marketplace was formally introduced later.
  Sources: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku);
  [Heroku Blog, "Announcing Heroku Elements – The Marketplace for the Builders of the App Economy"](https://blog.heroku.com/introducing_the_heroku_elements_marketplace).
  *(The exact launch date of the original add-ons program and of the Elements
  marketplace was **not** pinned to a single dated primary source here — **Could not
  verify** precise dates; Elements is commonly cited as ~2015.)*

### Salesforce acquisition (December 2010)

- **December 8, 2010 (announced)** — **Salesforce.com signed a definitive agreement
  to acquire Heroku for approximately $212 million in cash.** TechCrunch reported the
  ~$212M cash figure, plus ~$27M in restricted stock/units for employees and ~$10M
  for unvested shares; Heroku had raised about **$13 million**, employed roughly **30
  people** in San Francisco, and powered **over 105,000 apps** at the time. CEO
  **Byron Sebastian** said, "Together, we will provide the best place to run and
  deploy Cloud 2 apps."
  Sources: [TechCrunch, "Salesforce.com Buys Heroku For $212 Million In Cash" (Dec 8, 2010)](https://techcrunch.com/2010/12/08/breaking-salesforce-buys-heroku-for-212-million-in-cash/);
  [Bloomberg, "Salesforce.com to Buy Heroku for About $212 Million" (Dec 8, 2010)](https://www.bloomberg.com/news/articles/2010-12-08/salesforce-com-to-buy-heroku-for-212-million-to-tap-market-for-ruby-apps);
  [Y Combinator blog, "Salesforce.com Buys Heroku For $212 Million In Cash"](https://www.ycombinator.com/blog/salesforcecom-buys-heroku-for-212-million-in/);
  [Salesforce Form 8-K (SEC, FY2010)](https://www.sec.gov/Archives/edgar/data/0001108524/000119312510276080/d8k.htm).
  *(The Salesforce press release URL returned HTTP 403 to automated fetching; the
  date and ~$212M price are independently confirmed by TechCrunch, Bloomberg, the YC
  blog, and the SEC 8-K filing. The acquisition is generally described as closing in
  Salesforce's fiscal Q4 / by early 2011.)*

### Polyglot, Cedar, and buildpacks (2011–2012)

- **July 2011** — Heroku **expanded beyond Ruby**, adding support for **Node.js and
  Clojure**, and **Yukihiro "Matz" Matsumoto** (creator of Ruby) joined Heroku as
  **Chief Architect**.
  Source: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku).

- **The Cedar stack and the polyglot platform.** Cedar was created as a **single,
  general-purpose stack with no native support for any one language**; language
  support is layered on via a **build-time adapter called a buildpack**. Cedar
  provided official support for **Clojure, Java, Node.js, Python, Ruby, and Scala**,
  with "extensibility for unlimited others via buildpacks." Heroku's GA post for
  Cedar is dated **May 25, 2012** (author: Keith Rarick, Heroku Staff).
  Sources: [Heroku Blog, "Powerful Cedar Now Generally Accessible for Use"](https://www.heroku.com/blog/cedar_goes_ga/);
  [Heroku Blog, "Buildpacks: Heroku-Designed Build-Time Adapter"](https://www.heroku.com/blog/buildpacks/).

- **The Twelve-Factor App (≈2011).** Heroku co-founder **Adam Wiggins** authored
  **The Twelve-Factor App**, a hugely influential methodology for building SaaS apps,
  published at **12factor.net** (~2011), synthesizing patterns the authors observed
  across hundreds of thousands of apps on Heroku.
  Sources: [12factor.net, "The Twelve-Factor App"](https://www.12factor.net/);
  [Wikipedia, "Twelve-Factor App methodology"](https://en.wikipedia.org/wiki/Twelve-Factor_App_methodology).
  *(Wikipedia attributes authorship to Adam Wiggins and dates first publication to
  ~2011; an exact dated primary announcement of the original release was not
  separately confirmed here. Heroku later published an "open sources the
  Twelve-Factor App definition" post — see [Heroku Blog](https://www.heroku.com/blog/heroku-open-sources-twelve-factor-app-definition/) —
  but its date was **not** verified in this pass.)*

### Buildpacks → Cloud Native Buildpacks (2018)

- **January 2018 / October 2018** — The **Cloud Native Buildpacks (CNB)** project was
  initiated by **Pivotal and Heroku in January 2018** and joined the **Cloud Native
  Computing Foundation (CNCF)** in **October 2018** as an Apache-2.0 project,
  generalizing Heroku's buildpack idea into an open spec that turns source code into
  OCI container images. It is now a CNCF project (incubating).
  Sources: [Cloud Native Buildpacks, buildpacks.io](https://buildpacks.io/);
  [Heroku Blog, "Buildpacks Go Cloud Native, Turning Source Code into Docker Images"](https://www.heroku.com/blog/buildpacks-go-cloud-native/);
  [DevClass, "Heroku pushes Buildpacks under cloud native umbrella" (Oct 4, 2018)](https://www.devclass.com/containers/2018/10/04/heroku-pushes-buildpacks-under-cloud-native-umbrella/1621831).

### Salesforce-era perception of stagnation (2010s–2020s)

- Across the Salesforce era, Heroku acquired a reputation for **stagnation/neglect**:
  a developer-focused product that "never fit within Salesforce's total product
  lineup," with long stretches of limited new-feature investment. InfoWorld covered
  "The decline of Heroku," and the theme of a years-long feature slowdown recurs in
  developer commentary.
  Sources: [InfoWorld, "The decline of Heroku"](https://www.infoworld.com/article/2264177/the-decline-of-heroku.html);
  [InfoWorld, "Salesforce may be prepping to phase out Heroku"](https://www.infoworld.com/article/4129430/salesforce-may-be-prepping-to-phase-out-heroku.html).
  *(The "stagnation/neglect" characterization is analysis/opinion as carried by
  InfoWorld and developer commentary, not a Salesforce admission — treat it as
  **reported perception**, not company-stated fact.)*

### The April 2022 OAuth-token security incident

This was a software-supply-chain breach in which **stolen OAuth tokens issued to
Heroku and Travis-CI** were used to access private GitHub repositories.

- **April 2022 (fact, per GitHub)** — GitHub Security identified the campaign around
  **April 12, 2022**, after detecting unauthorized access to **npm** production
  infrastructure via a compromised AWS API key. An attacker abused **stolen OAuth
  user tokens issued to two third-party integrators — Heroku and Travis-CI** — to
  **download private repositories from dozens of organizations**. GitHub disclosed to
  Heroku and Travis-CI around April 13–14 and notified affected customers through
  late April.
  Sources: [GitHub Blog, "Security alert: Attack campaign involving stolen OAuth user tokens issued to two third-party integrators"](https://github.blog/news-insights/company-news/security-alert-stolen-oauth-user-tokens/);
  [The Hacker News, "GitHub Notifies Victims Whose Private Data Was Accessed Using OAuth Tokens"](https://thehackernews.com/2022/04/github-notifies-victims-whose-private.html).

- **Heroku's response and disabled GitHub integration (fact).** On **April 16, 2022**,
  Heroku **revoked all GitHub-integration OAuth tokens**, which prevented customers
  from deploying from GitHub via the Heroku Dashboard or automation — and Heroku kept
  the **GitHub integration disabled for an extended period**. Heroku later disclosed
  that the attacker had also accessed an internal Heroku database and exfiltrated
  **hashed-and-salted passwords** for customer accounts.
  Sources: [Cycode, "GitHub OAuth Compromise Affecting Heroku and Travis-CI Users"](https://cycode.com/blog/github-oauth-compromise-affecting-heroku-and-travis-ci-users/);
  [BleepingComputer, "Heroku admits that customer credentials were stolen in cyberattack"](https://www.bleepingcomputer.com/news/security/heroku-admits-that-customer-credentials-were-stolen-in-cyberattack/amp/).

- **Criticism (reported).** Heroku's disclosure was widely criticized at the time as
  slow and uncommunicative, and the GitHub-integration outage stretched on for
  weeks. The Register's contemporaneous coverage tracked the confusion around what
  had actually happened.
  Source: [The Register, "What happened with GitHub, Heroku, and raided private repos?" (Apr 21, 2022)](https://www.theregister.com/2022/04/21/github-stolen-oauth-tokens-used-in-breaches/).
  *(The "slow/criticized disclosure" framing is reported characterization by the
  press and affected users, not a company admission. The specific April 7, 2022 date
  for the initial Heroku database access appears in secondary security write-ups
  (e.g. Cycode) attributing it to GitHub/Heroku's accounts — treat that exact day as
  **secondary-sourced**.)*

### End of free plans (August–November 2022)

- **August 25, 2022 (announced)** — Heroku announced the **end of its free product
  plans** in a blog post titled **"Heroku's Next Chapter,"** by **Bob Wise, Heroku
  General Manager and Salesforce EVP** (later titled Heroku CEO). The post said free
  **Heroku Dynos**, free **Heroku Postgres**, and free **Heroku Data for Redis** would
  be discontinued, and that **inactive accounts would be deleted**.
  Sources: [Heroku Blog, "Heroku's Next Chapter"](https://www.heroku.com/blog/next-chapter/);
  [TechCrunch, "Heroku announces plans to eliminate free plans, blaming 'fraud and abuse'" (Aug 25, 2022)](https://techcrunch.com/2022/08/25/heroku-announces-plans-to-eliminate-free-plans-blaming-fraud-and-abuse/).

- **Effective dates (fact).** Starting **October 26, 2022**, Heroku began **deleting
  inactive accounts** (inactive over a year); starting **November 28, 2022**, it
  **stopped offering free product plans** and began shutting down free dynos and data
  services. Heroku cited "an extraordinary amount of effort to manage **fraud and
  abuse** of the Heroku free product plans." Low-cost paid tiers (Eco/Mini dynos
  from ~$5–$7/month, etc.) replaced the free ones.
  Sources: [Heroku Blog, "Heroku's Next Chapter"](https://www.heroku.com/blog/next-chapter/);
  [Heroku Help, "Removal of Heroku Free Product Plans FAQ"](https://help.heroku.com/RSBRUH58/removal-of-heroku-free-product-plans-faq);
  [RedMonk, "The End of Heroku's Free Tier"](https://redmonk.com/kholterhoff/2022/12/01/the-end-of-herokus-free-tier/).
  This decision was widely seen as resetting industry expectations about free PaaS
  hosting and drove an exodus to alternatives.
  Source: [RedMonk (above)](https://redmonk.com/kholterhoff/2022/12/01/the-end-of-herokus-free-tier/).

### CNCF Platinum membership and the "Fir" re-platform (2024–2025)

- **June 27, 2024** — The **CNCF announced Heroku had joined as a Platinum member**,
  with a seat on the CNCF Governing Board; Heroku is a founding member/maintainer of
  the Cloud Native Buildpacks project. Heroku CEO **Bob Wise** framed it as
  reinforcing Heroku's commitment to cloud-native technologies (Kubernetes, CNB,
  OpenTelemetry).
  Sources: [CNCF, "Cloud Native Computing Foundation Announces Heroku Joins as a Platinum Member" (Jun 27, 2024)](https://www.cncf.io/announcements/2024/06/27/cloud-native-computing-foundation-announces-heroku-joins-as-a-platinum-member/);
  [Heroku Blog, "Heroku Joins CNCF as a Platinum Member"](https://www.heroku.com/blog/heroku-joins-cncf-platinum-member/).

- **December 2024 → April 2025 — "Fir," the next-generation, Kubernetes-based
  platform.** Salesforce/Heroku announced a **next-generation platform generation
  codenamed "Fir,"** built on **Kubernetes** (AWS EKS, ECR, OCI, Cloud Native
  Buildpacks, OpenTelemetry, AWS Graviton), pitched as the classic Heroku experience
  with Kubernetes-grade scaling underneath. Fir entered pilot around late 2024 and
  reached **general availability with Fir Private Spaces in April 2025** (Dev Center
  changelog dated **April 14, 2025**).
  Sources: [Heroku Blog, "The Next Generation of the Heroku Platform"](https://www.heroku.com/blog/next-generation-heroku-platform/);
  [Heroku Blog, "Planting New Platform Roots in Cloud Native with Fir"](https://www.heroku.com/blog/planting-new-platform-roots-cloud-native-fir/);
  [Heroku Dev Center changelog, "Fir: Heroku's next generation platform is now generally available"](https://devcenter.heroku.com/changelog-items/3188);
  [Salesforce Engineering, "Rebuilding Heroku on Kubernetes"](https://engineering.salesforce.com/rebuilding-heroku-on-kubernetes-platform-modernization-operational-complexity-and-technical-debt-resolution/).

### Sustaining engineering and enterprise end-of-sale (February 2026)

- **February 9, 2026** — Salesforce announced Heroku is **transitioning to a
  "sustaining engineering model"** focused on stability, security, reliability, and
  support — i.e., **halting new feature development** and **ending enterprise
  agreements for new customers** (existing customers may continue and renew). SVP
  **Nitin T. Bhat** framed it as concentrating investment on "areas where we can
  deliver the greatest long-term customer value, including helping organizations
  build and deploy enterprise-grade AI." No shutdown/end-of-life date was set.
  Sources: [The Register, "Salesforce puts Heroku out to PaaSture" (Feb 9, 2026)](https://www.theregister.com/2026/02/09/heroku_freeze/);
  [InfoWorld, "Salesforce may be prepping to phase out Heroku"](https://www.infoworld.com/article/4129430/salesforce-may-be-prepping-to-phase-out-heroku.html);
  [DevClass, "Heroku future in doubt as Salesforce freezes features to focus on AI" (Feb 9, 2026)](https://www.devclass.com/development/2026/02/09/heroku-future-in-doubt-as-salesforce-freezes-features-to-focus-on-ai/4090238).
  *(Reporting also tied a February 2026 round of Salesforce layoffs — "under 1,000
  roles" across Agentforce, Heroku, and other groups — to this period, per
  [Salesforce Ben](https://www.salesforceben.com/salesforce-lays-off-nearly-1000-employees-in-early-2026-cuts/).
  The exact Heroku-specific headcount impact is **reported, not company-confirmed** —
  **Could not verify** a precise Heroku layoff number.)*

---

## Key people & teams

The Heroku alumni network ("the diaspora") is itself notable — several founders and
early leaders went on to influential developer-tools, research, and VC roles.

- **Adam Wiggins** — Co-founder and former CTO; **author of The Twelve-Factor App**.
  After Heroku he co-founded the research lab **Ink & Switch** and the thinking-canvas
  app **Muse**; he later joined **The Browser Company**. (His own site and the
  Changelog interview document this trajectory.)
  Sources: [adamwiggins.com](https://adamwiggins.com/);
  [The Changelog #514, "Beyond Heroku to Muse with Adam Wiggins"](https://changelog.com/podcast/514);
  [InfoWorld, "Heroku's Adam Wiggins on making computers better"](https://www.infoworld.com/article/2338215/herokus-adam-wiggins-on-making-computers-better.html).
  *(Ink & Switch co-founding and the Muse role are well documented; the precise
  nature/timing of "GM of Platform at The Browser Company" is per secondary summary —
  treat the Browser Company title as **lightly sourced**.)*

- **James Lindenbaum** — Co-founder; later founded **Heavybit** (founded **2013**), a
  fund/community focused on developer-first / developer-tools startups, where he is a
  General Partner.
  Sources: [Heavybit, "Heavybit's James Lindenbaum on Developer Company Trends"](https://www.heavybit.com/library/article/james-lindenbaum-developer-trends);
  [Crunchbase, "James Lindenbaum"](https://www.crunchbase.com/person/james-lindenbaum).

- **Orion Henry** — Co-founder. Later work is less documented; secondary sources
  describe involvement with a public-health/surgery initiative ("The Right to Heal")
  and decentralization-related projects.
  Sources: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku);
  [Bloomberg profile, "Orion Henry"](https://www.bloomberg.com/profile/person/17644104).
  *(**Could not verify** Orion Henry's specific post-Heroku roles from a strong
  primary source; the "Right to Heal" / decentralization items are secondary and are
  flagged rather than asserted.)*

- **Byron Sebastian** — Joined as **CEO in October 2009** and was CEO at the time of
  the December 2010 Salesforce acquisition.
  Sources: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku);
  [TechCrunch (Dec 8, 2010)](https://techcrunch.com/2010/12/08/breaking-salesforce-buys-heroku-for-212-million-in-cash/).

- **Oren Teich** — A Heroku **General Manager** in the Salesforce era; later left to
  found **Canvas** (a collaborative document startup) and held cloud roles elsewhere.
  Source: [Fortune, "Exclusive: Google Snags Former Salesforce Cloud Exec"](https://fortune.com/2017/04/27/google-cloud-heroku-tech-exec/).
  *(Teich's Heroku GM tenure and his later move are reported by Fortune/secondary
  sources; exact dates/titles were **not** pinned to a single primary source — treat
  as **reported**.)*

- **Bob Wise** — Heroku **General Manager / CEO** (and Salesforce EVP) in the
  2022–2025 period; authored the "Next Chapter" free-plan-removal post and represented
  Heroku in the CNCF Platinum announcement.
  Sources: [Heroku Blog, "Heroku's Next Chapter"](https://www.heroku.com/blog/next-chapter/);
  [CNCF (Jun 27, 2024)](https://www.cncf.io/announcements/2024/06/27/cloud-native-computing-foundation-announces-heroku-joins-as-a-platinum-member/).

- **Yukihiro "Matz" Matsumoto** — Creator of Ruby; joined Heroku as **Chief
  Architect** (~July 2011) as the platform expanded beyond Ruby.
  Source: [Wikipedia, "Heroku"](https://en.wikipedia.org/wiki/Heroku).

- **Peter van Hardenberg** — Early Heroku engineer (associated with the Heroku
  Postgres team) who later became **lab director at Ink & Switch**, an example of the
  Heroku-to-Ink-&-Switch pipeline.
  Source: [The Changelog #514](https://changelog.com/podcast/514).
  *(The Heroku Postgres team association and Ink & Switch role are per the Changelog
  interview/secondary summaries — treat the Postgres-team detail as **reported**.)*

---

## Company & corporate history

- **2007** — Founded in San Francisco by Lindenbaum, Wiggins, and Henry.
  [YC profile](https://www.ycombinator.com/companies/heroku)
- **Winter 2008** — Y Combinator batch; original in-browser Ruby editor pivots to PaaS.
  [YC profile](https://www.ycombinator.com/companies/heroku) ·
  [Changelog #513](https://changelog.com/podcast/513)
- **January 2009** — Rebuilt platform relaunched (the `git push` / dyno era).
  [Wikipedia](https://en.wikipedia.org/wiki/Heroku)
- **October 2009** — Byron Sebastian becomes CEO.
  [Wikipedia](https://en.wikipedia.org/wiki/Heroku)
- **December 8, 2010** — Salesforce.com agrees to acquire Heroku for **~$212M cash**
  (Heroku had raised ~$13M, ~30 staff, 105,000+ apps).
  [TechCrunch](https://techcrunch.com/2010/12/08/breaking-salesforce-buys-heroku-for-212-million-in-cash/) ·
  [Bloomberg](https://www.bloomberg.com/news/articles/2010-12-08/salesforce-com-to-buy-heroku-for-212-million-to-tap-market-for-ruby-apps) ·
  [SEC 8-K](https://www.sec.gov/Archives/edgar/data/0001108524/000119312510276080/d8k.htm)
- **2011–2012** — Polyglot expansion (Node.js, Clojure, etc.); **Cedar** stack GA
  (May 25, 2012); buildpacks; Matz joins as Chief Architect; Twelve-Factor App
  published. [Cedar GA](https://www.heroku.com/blog/cedar_goes_ga/) ·
  [Wikipedia](https://en.wikipedia.org/wiki/Heroku)
- **2018** — Heroku + Pivotal launch **Cloud Native Buildpacks**, donated to CNCF.
  [Heroku Blog](https://www.heroku.com/blog/buildpacks-go-cloud-native/)
- **2010s–2020s** — Operated as a Salesforce subsidiary; reputation for limited
  feature investment (reported "decline/neglect").
  [InfoWorld](https://www.infoworld.com/article/2264177/the-decline-of-heroku.html)
- **April 2022** — OAuth-token security incident; GitHub integration disabled for an
  extended period. [GitHub Blog](https://github.blog/news-insights/company-news/security-alert-stolen-oauth-user-tokens/)
- **August–November 2022** — **End of free plans**: announced Aug 25, 2022; inactive
  accounts deleted from Oct 26; free plans ended Nov 28, 2022.
  [Heroku "Next Chapter"](https://www.heroku.com/blog/next-chapter/) ·
  [TechCrunch](https://techcrunch.com/2022/08/25/heroku-announces-plans-to-eliminate-free-plans-blaming-fraud-and-abuse/)
- **June 2024** — Heroku joins CNCF as a Platinum member.
  [CNCF](https://www.cncf.io/announcements/2024/06/27/cloud-native-computing-foundation-announces-heroku-joins-as-a-platinum-member/)
- **Dec 2024 → Apr 2025** — **"Fir"**, the Kubernetes-based next-generation platform,
  pilots then reaches GA (Apr 14, 2025).
  [Heroku Dev Center changelog](https://devcenter.heroku.com/changelog-items/3188)
- **February 9, 2026** — Salesforce moves Heroku to a **"sustaining engineering
  model"** (feature freeze; enterprise end-of-sale for new customers).
  [The Register](https://www.theregister.com/2026/02/09/heroku_freeze/) ·
  [DevClass](https://www.devclass.com/development/2026/02/09/heroku-future-in-doubt-as-salesforce-freezes-features-to-focus-on-ai/4090238)

---

## Controversies

> Each item separates **established/admitted fact** from **reported claim /
> characterization**, with attribution.

### 1. April 2022 OAuth-token breach and disabled GitHub integration

- **Fact (per GitHub):** Stolen OAuth tokens issued to **Heroku and Travis-CI** were
  abused to download private repos from dozens of orgs; detected ~Apr 12, 2022.
  [GitHub Blog](https://github.blog/news-insights/company-news/security-alert-stolen-oauth-user-tokens/)
- **Fact (per Heroku):** Heroku revoked all GitHub-integration OAuth tokens (Apr 16,
  2022), disabling GitHub deploys for an extended period, and later admitted an
  internal database with hashed/salted customer passwords was accessed.
  [Cycode](https://cycode.com/blog/github-oauth-compromise-affecting-heroku-and-travis-ci-users/) ·
  [BleepingComputer](https://www.bleepingcomputer.com/news/security/heroku-admits-that-customer-credentials-were-stolen-in-cyberattack/amp/)
- **Reported claim/criticism:** Press and users criticized Heroku's disclosure as slow
  and unclear, and the integration outage as lengthy.
  [The Register](https://www.theregister.com/2022/04/21/github-stolen-oauth-tokens-used-in-breaches/)

### 2. End of free plans (2022)

- **Fact:** Heroku ended free Dynos, Postgres, and Data for Redis (announced Aug 25,
  2022; effective Nov 28, 2022) and deleted inactive accounts (from Oct 26, 2022),
  citing fraud/abuse.
  [Heroku "Next Chapter"](https://www.heroku.com/blog/next-chapter/) ·
  [Heroku Help FAQ](https://help.heroku.com/RSBRUH58/removal-of-heroku-free-product-plans-faq)
- **Reported claim/characterization:** Analysts framed this as the end of an era for
  free PaaS, prompting migrations to alternatives.
  [RedMonk](https://redmonk.com/kholterhoff/2022/12/01/the-end-of-herokus-free-tier/)

### 3. Salesforce-era stagnation and 2026 feature freeze

- **Fact:** Salesforce moved Heroku to a "sustaining engineering model" (Feb 9, 2026),
  halting new features and ending enterprise sales to new customers.
  [The Register](https://www.theregister.com/2026/02/09/heroku_freeze/)
- **Reported claim/characterization:** Long-running press/developer narrative that
  Heroku was neglected under Salesforce and is now in "managed decline."
  [InfoWorld, "The decline of Heroku"](https://www.infoworld.com/article/2264177/the-decline-of-heroku.html) ·
  [InfoWorld, "Salesforce may be prepping to phase out Heroku"](https://www.infoworld.com/article/4129430/salesforce-may-be-prepping-to-phase-out-heroku.html)

---

## Items marked "Could not verify"

- **Exact "Winter 2008" YC batch label as a dated primary fact** — consistently
  reported (YC profile, Wiggins interview) but the precise batch tag is from the YC
  profile/secondary retellings rather than a dated press item.
- **Exact date of the first `git push heroku` release / dyno introduction** — the
  Jan 2009 relaunch is sourced, but no dated primary announcement tying that month to
  the first `git push` deploy was located.
- **Precise launch dates of the original add-ons program, Heroku Postgres, and the
  Elements marketplace** — not pinned to single dated primary sources here.
- **Exact original publication date of The Twelve-Factor App** and the date Heroku
  "open-sourced" the definition — authorship (Wiggins) and ~2011 are sourced; exact
  dates were not confirmed in this pass.
- **The April 7, 2022 date for initial Heroku database access** — appears in secondary
  security write-ups attributing it to GitHub/Heroku; treated as secondary-sourced.
- **Heroku-specific layoff headcount in the Feb 2026 round** — reporting cites "under
  1,000" Salesforce-wide; a Heroku-specific number is not company-confirmed.
- **Orion Henry's specific post-Heroku roles** ("Right to Heal," decentralization
  work) — secondary only.
- **Adam Wiggins's exact current title at The Browser Company** — secondary summary.
- **Oren Teich's exact Heroku GM dates/title** — reported, not pinned to a primary
  source.
- **Direct read of the Salesforce acquisition press release** (HTTP 403 to automated
  fetching) — date/price corroborated via TechCrunch, Bloomberg, the YC blog, and the
  SEC 8-K.
