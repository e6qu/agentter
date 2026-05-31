# Ruby on Rails (and 37signals / DHH): A Sourced History

A chronological, fully-sourced history of **Ruby on Rails** — the web framework
**David Heinemeier Hansson (DHH)** extracted from **Basecamp** at **37signals** and
open-sourced in **July 2004** — from its origins through the Merb merge, the
"fail-whale" Twitter scaling lore, the founding of the **Rails Foundation (2022)**,
and the controversies that have surrounded DHH and 37signals (the 2021 Basecamp
"changes," the 2022–2023 cloud exit, the 2023 TypeScript-in-Turbo fight). Every
dated claim links to a primary or reputable secondary source. **Fact and opinion are
kept separate, and controversies/opinions are attributed to the person or outlet that
voiced them.** Where a claim could not be confirmed, it is marked
**"Could not verify."**

> **Peer frameworks (cross-reference, not duplicated here):** see
> [`fastapi.md`](fastapi.md) (Python / Sebastián Ramírez) and
> [`spring.md`](spring.md) (Java / Rod Johnson → Pivotal/VMware) for the contemporary
> web-framework lineages this document deliberately does not re-cover. Rails'
> "convention over configuration" stance is the foil that Spring's heavy XML
> configuration era is usually contrasted against, and FastAPI inherits the
> "developer-happiness / great docs" ethos that Rails popularized. *(Those two docs
> are companion files in this `history/` set; if not yet present, treat these as
> forward references.)*

---

## Timeline

### 1993–1995 — Ruby (the language Rails rides on)

- The name **"Ruby"** was chosen in an online chat between **Yukihiro "Matz"
  Matsumoto** and Keiju Ishitsuka on **24 February 1993**, before any code was
  written; Matsumoto says Ruby was *conceived* in 1993.
  - Source: [Yukihiro Matsumoto — Wikipedia](https://en.wikipedia.org/wiki/Yukihiro_Matsumoto)
- **21 December 1995** — Matsumoto announced the first public release (**Ruby 0.95**)
  on Japanese domestic newsgroups. Ruby drew on Perl, Smalltalk, Eiffel, Ada, BASIC,
  and Lisp.
  - Source: [Yukihiro Matsumoto — Wikipedia](https://en.wikipedia.org/wiki/Yukihiro_Matsumoto);
    [About Ruby — ruby-lang.org](https://www.ruby-lang.org/en/about/)
- **Interpretation (widely held, attributable):** Ruby was a niche language outside
  Japan until Rails arrived; the common framing is that **"Rails made Ruby
  mainstream"** in the West. This is an interpretation, not a metric; it is asserted in
  retrospectives such as
  [The History of the Web, "Making a Framework for the Web"](https://thehistoryoftheweb.com/ruby-on-rails/).

### 2003–2004 — Extracted from Basecamp at 37signals

- Rails was **extracted from the codebase of Basecamp**, the project-management app
  built by the Chicago design firm **37signals** (later renamed Basecamp), where
  Danish programmer **David Heinemeier Hansson (DHH)** was building the application in
  Ruby. The framework was, in the standard phrasing, "extracted" rather than designed
  in the abstract.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails);
    [David Heinemeier Hansson — Wikipedia](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson)
- **July 2004** — Hansson **released Rails as open source**. He did **not** share
  commit rights to the project until **February 2005**.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)
  - **Could not verify** the exact *day* in July 2004 from a single primary source;
    Wikipedia and secondary histories give the month but the original announcement
    thread is not linked from those sources.

### 2005 — The "blog in 15 minutes" screencast and Rails 1.0

- **2005** — DHH recorded the famous **"How to build a blog in 15 minutes with
  Rails"** demo. The widely cited version was recorded at **FISL (Fórum Internacional
  Software Livre)** in Brazil and uploaded to YouTube on **8 November 2005**; DHH
  himself later linked it as "the original… aka the wups video."
  - Sources: [DHH on X/Twitter, linking the original 2005 screencast (#RailsTurns10)](https://x.com/dhh/status/492706473936314369);
    [Avo glossary, "The 15 Minute Blog in Rails"](https://avohq.io/glossary/15-minute-blog)
  - **Interpretation (attributed):** the Avo writeup and community lore credit this
    screencast as "potentially responsible for most of Rails' ongoing success" by
    showing scaffolding/Active Record productivity in a digestible form. That is an
    opinion about impact, attributed to the source, not a measured fact.
- **13 December 2005** — **Rails 1.0** released.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)
- **Core principles** Rails popularized and codified: **MVC** (Model-View-Controller),
  **Convention over Configuration (CoC)**, **Don't Repeat Yourself (DRY)**, and the
  **Active Record** pattern (one of the original gems bundled with Rails).
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)
- **Recognition:** DHH was named **Google–O'Reilly "Hacker of the Year" in 2005** for
  Rails.
  - Source: [David Heinemeier Hansson — Wikipedia](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson)

### 2007 — Rails 2.0

- **7 December 2007** — **Rails 2.0** released.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)

### 2008–2011 — Twitter, the "Fail Whale," and the JVM migration

- This is **scaling lore** that is frequently mis-told, so it is attributed carefully.
  Twitter was famously built on Rails and became the canonical "Rails doesn't scale"
  cautionary tale during the **"Fail Whale"** era of frequent outages. The migration
  off Ruby was **gradual and back-end-first**, not a wholesale rewrite:
  - **2008–2009** — Twitter began moving **back-end** components (message queue,
    tweet-storage/"back-end message queue") off Ruby, choosing **Scala** (a JVM
    language) rather than stock Java initially.
  - **2010** — the search team began rewriting search storage (MySQL → a Lucene-based
    store).
  - **April 2011** — Twitter announced it had replaced the **Ruby-on-Rails front-end
    for search** with a Java service called **Blender**, reporting a ~3× drop in search
    latency.
  - Sources: [InfoQ, "Twitter's Shift from Ruby to Java Helps it Survive US Election" (Nov 2012)](https://www.infoq.com/news/2012/11/twitter-ruby-to-java/);
    [The Register, "Twitter survives election after Ruby-to-Java move" (8 Nov 2012)](https://www.theregister.com/2012/11/08/twitter_epic_traffic_saved_by_java/)
  - **Opinion vs fact:** That Twitter moved performance-critical services from Ruby to
    the JVM is **fact** (Twitter/engineering and press reporting). The broader claim
    that this *proves* "Rails can't scale" is **contested opinion** — defenders argue
    Twitter outgrew any single-language monolith, not Rails specifically; see the
    contemporaneous debate captured in
    [Hacker News, "Twitter jilts Ruby for Scala"](https://news.ycombinator.com/item?id=542716).
    Do not assert the causal claim as fact.

### 2008 — The Merb merge announced

- **23 December 2008** — The Rails and **Merb** teams announced they would **merge
  Merb's best ideas into Rails 3**. Merb was a lighter, more modular Ruby framework
  created by **Ezra Zygmuntowicz** and **Yehuda Katz**. DHH framed it as a Christmas
  present; Katz announced the same on his own blog.
  - Sources: [rubyonrails.org, "Merb gets merged into Rails 3!" (23 Dec 2008)](https://rubyonrails.org/2008/12/23/merb-gets-merged-into-rails-3);
    [Yehuda Katz, "Rails and Merb Merge" (23 Dec 2008)](https://yehudakatz.com/2008/12/23/rails-and-merb-merge/);
    [InfoQ, "Merb Will Be Merged Into Rails 3.0"](https://www.infoq.com/news/2008/12/merb-merged-in-rails-30/)
  - The stated goal: bring Merb's traits to Rails — a **defined public API**, a
    bare-bones **rails-core** runnable with plugins, and **performance improvements** —
    so that Merb users' use cases would be served by Rails 3.
    - Source: [Merb — Wikipedia](https://en.wikipedia.org/wiki/Merb);
      [Yehuda Katz, "Rails and Merb Merge"](https://yehudakatz.com/2008/12/23/rails-and-merb-merge/)
  - As part of the merge, **Yehuda Katz joined the Rails core team**, and Carl Lerche
    and Daniel Neighman were named to lead bringing Merb ideas across.
    - Source: [InfoQ, "Merb Will Be Merged Into Rails 3.0"](https://www.infoq.com/news/2008/12/merb-merged-in-rails-30/)

### 2010 — Rails 3.0 (the Merb merge ships)

- **29 August 2010** — **Rails 3.0** released, incorporating the Merb merge
  (modularity, a cleaner public API, Active Relation/Arel-based query layer).
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)
- **31 August 2011** — **Rails 3.1**: reversible migrations, the **Asset Pipeline**,
  streaming; jQuery as default; **CoffeeScript** and **Sass** introduced.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)

### 2012 — A Rails-core alumnus creates Elixir

- **José Valim**, a Rails Core team member (on the core team **c. 2010–2014**),
  shifted focus to concurrency problems Ruby didn't address and created the **Elixir**
  programming language (built on the Erlang VM). Elixir's first commits/public emergence
  are dated to **2011–2012**.
  - Sources: [José Valim on GitHub](https://github.com/josevalim);
    [Yehuda Katz on X: "The Rails 3 crew was pretty cool. @josevalim created Elixir…"](https://x.com/wycats/status/1225817596378796034)
  - **Could not verify** Valim's exact core-team start/end years from a single
    authoritative primary page; the "2010–2014" range and "created Elixir to explore
    concurrency beyond Ruby" framing come from secondary profiles and Katz's tweet, not
    an official Rails roster with dates.

### 2013–2019 — Major versions 4 → 6

- **25 June 2013** — **Rails 4.0**: Russian-Doll caching, **Turbolinks**, live
  streaming.
- **30 June 2016** — **Rails 5.0**: **Action Cable** (WebSockets), **API-only mode**,
  Turbolinks 5.
- **16 August 2019** — **Rails 6.0**: Webpack as default JS bundler, Action Mailbox
  (inbound mail routing), parallel testing.
  - Source (all three): [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)

### 2021 — Rails 7 and Hotwire ("No Build")

- **15 December 2021** — **Rails 7.0** released. It replaced Webpacker/Turbolinks/UJS
  with **import maps** plus **Hotwire** (**Turbo** + **Stimulus**) as defaults — the
  "**No Build**" path that runs modern JS in the browser without Webpack/Node tooling
  by default, while still offering a bundler path (esbuild/Webpack) and a strict-API
  path.
  - Sources: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails);
    [DHH, "Rails 7 will have three great answers to JavaScript in 2021+"](https://world.hey.com/dhh/rails-7-will-have-three-great-answers-to-javascript-in-2021-8d68191b)

### 2022 — The Rails Foundation

- **14 November 2022** — The **Rails Foundation** launched with **$1,000,000** in seed
  funding from **eight founding "core" members: Cookpad, Doximity, Fleetio, GitHub,
  Intercom, Procore, Shopify, and 37signals.** Each member sits on the board, which is
  **chaired by DHH**. Stated mission: improve **documentation, education, marketing,
  and events** for the Rails ecosystem.
  - Source: [rubyonrails.org, "The Rails Foundation kicks off with one million dollars" (14 Nov 2022)](https://rubyonrails.org/2022/11/14/the-rails-foundation)
- Later expansion: **1Password** joined as a Core member.
  - Source: [rubyonrails.org, "The Rails Foundation welcomes 1Password as Core member" (2 Dec 2024)](https://rubyonrails.org/2024/12/2/rails-foundation-welcomes-1password-as-core-member)

### 2024 — Rails 8 ("the one-person framework")

- **8 November 2024** — **Rails 8.0** released under the banner **"No PaaS Required."**
  Headline changes:
  - **Solid Queue**, **Solid Cache**, and **Solid Cable** — database-backed adapters
    that let jobs, caching, and WebSocket pub/sub run on the SQL database, **dropping
    the hard dependency on Redis** (and on Resque/Sidekiq/Memcached) for a default
    install. (37signals reports Solid Queue running ~20M jobs/day for **HEY**.)
  - **Kamal 2** preconfigured for deploys to a cloud VM or bare metal; a new **Thruster**
    proxy in front of Puma for asset caching/compression and X-Sendfile.
  - Sources: [rubyonrails.org, "Rails 8.0: No PaaS Required" (7 Nov 2024)](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required);
    [Rails 8.0 Release Notes — guides.rubyonrails.org](https://guides.rubyonrails.org/8_0_release_notes.html)
  - **"The one-person framework"** is **DHH's slogan/marketing** for the idea that one
    developer can build and run a full production app with Rails' batteries-included
    stack; it is a positioning claim, attributed to 37signals/DHH, not an independent
    measurement.
- **24 October 2025** — **Rails 8.1.0** released (Active Job Continuations, structured
  event reporting, local CI), per the version history.
  - Source: [Ruby on Rails — Wikipedia](https://en.wikipedia.org/wiki/Ruby_on_Rails)
  - **Could not verify** the 8.1.0 date against the official release blog post directly;
    the date here is from the Wikipedia version table and should be re-checked against
    `rubyonrails.org` before being treated as primary.

**Current status (as of this writing, 2026):** Rails is on the 8.x line, governed by
the Rails Foundation, with development heavily backed by Shopify, GitHub, and 37signals
(see *Ecosystem* below).

---

## Key people & teams

- **David Heinemeier Hansson (DHH)** — creator of Rails; partner/CTO at **37signals**
  (Basecamp); chairs the **Rails Foundation** board. Also the most visible — and most
  polarizing — voice in the community (see *Controversies*).
  - Source: [David Heinemeier Hansson — Wikipedia](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson);
    [rubyonrails.org Foundation announcement](https://rubyonrails.org/2022/11/14/the-rails-foundation)
- **Aaron Patterson ("tenderlove")** — member of **both** the Ruby and Rails core
  teams; long at **GitHub**, then joined **Shopify's** Ruby & Rails Infrastructure team
  in **April 2020**. Known for GC and performance work on Ruby.
  - Sources: [Aaron Patterson on X, announcing his first day at Shopify (Apr 2020)](https://x.com/tenderlove/status/1254891862906638339);
    [Shopify Engineering, "Year in Review 2022: Tenderlove's Ruby and Rails Reflections"](https://shopify.engineering/ruby-rails-year-in-review-2022)
- **Yehuda Katz** — joined Rails core via the **Merb** merge; later co-created
  **Ember.js**, and authored build tools across ecosystems — **Bundler** (Ruby),
  **Yarn** (JS), and co-created **Cargo** (Rust). (He attributes Cargo's co-creation,
  alongside his own, partly to Carl Lerche, also a Rails-3-era contributor.)
  - Sources: [Yehuda Katz, "Rails and Merb Merge"](https://yehudakatz.com/2008/12/23/rails-and-merb-merge/);
    [Yehuda Katz on X, listing the Rails-3 crew's later work (Elixir, Cargo/Tokio, Rust compiler)](https://x.com/wycats/status/1225817596378796034)
- **José Valim** — Rails core alumnus who created **Elixir** (see 2012 entry).
  - Source: [José Valim on GitHub](https://github.com/josevalim)
- **Eileen Uchitelle** — Rails Core team member **since 2017**; Senior Staff Engineer
  on **Shopify's** Ruby & Rails Infrastructure team; led **multiple-database support**
  in Active Record; joined the **Ruby** core committers in **2024**.
  - Sources: [eileencodes.com (her site)](https://eileencodes.com/);
    [Rails World 2024 speaker page — Eileen Uchitelle](https://rubyonrails.org/world/2024/speakers/eileen-uchitelle)
- **Other long-standing core members** named in the brief — **Jeremy Kemper**,
  **Xavier Noria**, **Rafael França** — are well-known Rails core contributors.
  - **Could not verify** precise individual tenure dates/role specifics for Kemper,
    Noria, and França from primary roster pages in this pass; they are correctly
    identified as core-team contributors, but specific dated claims about each were not
    sourced and should be added to `DO_NEXT.md` if needed.
- **Ezra Zygmuntowicz** — co-creator of **Merb** (and of the Engine Yard / early Ruby
  PaaS world); his framework's ideas folded into Rails 3.
  - Source: [Merb — Wikipedia](https://en.wikipedia.org/wiki/Merb)

**Companies heavily invested in Rails:** **Shopify** (one of the largest Rails
monoliths; employs multiple core members), **GitHub** (a flagship Rails app; Eileen
Uchitelle's work on multi-DB came partly out of GitHub's 30-database monolith),
**Heroku** (the Rails-friendly PaaS that defined a generation of deploys), and
**Basecamp/37signals** (the origin). All four are reflected in the Rails Foundation's
founding membership and core-team employers.
- Sources: [The Rails Foundation announcement](https://rubyonrails.org/2022/11/14/the-rails-foundation);
  [Superhighway, Q&A with Eileen Uchitelle (GitHub's multi-database monolith)](https://superhighway.dev/eileen-uchitelle-q-and-a)

---

## The ecosystem & influence

- **The Rails Doctrine.** DHH codified the project's values into **"The Rails
  Doctrine"** — nine pillars: *Optimize for programmer happiness; Convention over
  Configuration; The menu is omakase; No one paradigm; Exalt beautiful code; Provide
  sharp knives; Value integrated systems; Progress over stability; Push up a big tent.*
  - Source: [The Ruby on Rails Doctrine — rubyonrails.org/doctrine](https://rubyonrails.org/doctrine)
- **Convention over Configuration** as a paradigm export. Rails' CoC stance became the
  reference point that other ecosystems defined themselves for or against — most
  notably as the antithesis of Java/**Spring**'s historically heavy XML configuration
  (see [`spring.md`](spring.md)), and as an ancestor of the "great defaults + great
  docs + developer happiness" ethos later carried into Python by **FastAPI** (see
  [`fastapi.md`](fastapi.md)).
- **Tooling lineage out of Rails core.** The Rails-3-era cohort seeded tools far beyond
  Ruby: **Elixir** (Valim), **Cargo/Tokio** (Lerche, Rust), **Ember.js / Bundler /
  Yarn** (Katz). This "diaspora" is itself part of Rails' influence.
  - Source: [Yehuda Katz on X, "The Rails 3 crew was pretty cool…"](https://x.com/wycats/status/1225817596378796034)
- **Deploy tooling.** 37signals' cloud exit (below) produced **Kamal**, an open-source
  Docker-based deploy tool now shipped with Rails 8, plus **Thruster** — extending
  Rails' "batteries-included" reach to deployment.
  - Source: [rubyonrails.org, "Rails 8.0: No PaaS Required"](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required)

---

## Controversies

> Each item below separates **what happened (fact, sourced)** from **who said what
> (opinion, attributed)**. DHH is an unusually outspoken figure, and several of these
> are as much about his public conduct as about technology.

### 2021 — "Changes at Basecamp" and the employee exodus

- **Fact (sourced):** On **26 April 2021**, Basecamp CEO **Jason Fried** published a
  post titled **"Changes at Basecamp"** announcing, among other things: **a ban on
  political and societal discussion** on company Basecamp accounts; ending peer/"360"
  performance reviews; replacing some benefits with profit-sharing; and **dissolving
  employee committees** (including a DEI committee).
  - Sources: [The Register, "Basecamp CEO issues apology…" (5 May 2021)](https://www.theregister.com/2021/05/05/basecamp_political_discussion_apology/);
    [NPR, "Basecamp Blowup: Banning Politics At Work Prompts Over A Dozen Employees To Quit" (7 May 2021)](https://www.npr.org/2021/05/07/994812274/basecamp-blowup-banning-politics-at-work-prompts-over-a-dozen-employees-to-quit)
- **Fact (sourced):** Basecamp offered **buyouts** (six months' salary for 3+ years'
  tenure; three months otherwise). **The Verge / The Register** reported **18 of 57
  employees** took the package — **roughly a third of the company.** Casey Newton
  (then at The Verge, now Platformer) reported "at least 20" departures including the
  head of strategy.
  - Sources: [The Register, "Basecamp CEO issues apology…"](https://www.theregister.com/2021/05/05/basecamp_political_discussion_apology/)
    (18 of 57); [Platformer / Casey Newton, "How Basecamp blew up"](https://www.platformer.news/-how-basecamp-blew-up/);
    [Casey Newton on X, "…leaving along with at least 20 others"](https://x.com/caseynewton/status/1389369715638767619)
  - *Reconciling the numbers:* "18 of 57" (The Register/Verge) and "about a third" and
    "at least 20" (Newton) are consistent — all describe roughly one-third of a
    ~57-person company. The brief's "~20 of ~60" is within this range.
- **Fact (sourced):** The trigger included an internal thread referencing a long-running
  "funny customer names" list and an employee invoking the Anti-Defamation League's
  "pyramid of hate"; Fried and DHH closed the thread and disbanded the DEI committee.
  At a subsequent all-hands, the head of strategy questioned the existence of white
  supremacy at the company and was suspended, then resigned.
  - Source: [Platformer / Casey Newton, "How Basecamp blew up"](https://www.platformer.news/-how-basecamp-blew-up/)
- **Opinion (attributed):** On **4 May 2021**, **Fried apologized**, writing "Last week
  was terrible… it blew things up culturally in ways we never anticipated," and DHH
  said "David and I completely own the consequences." Fried's *original* rationale —
  that workplace political discussion is "not healthy" and "a major distraction" — is
  his stated opinion, as is the widespread criticism that the policy and its rollout
  were mishandled.
  - Source: [The Register, "Basecamp CEO issues apology…"](https://www.theregister.com/2021/05/05/basecamp_political_discussion_apology/)

### 2022–2023 — "Leaving the cloud" / cloud repatriation

- **Fact (sourced):** On **19 October 2022**, DHH published **"Why We're Leaving the
  Cloud,"** announcing 37signals would move its apps off **AWS and Google Cloud** onto
  its own hardware. 37signals later reported ordering ~**$600,000** of Dell servers and
  completing the **compute** migration around **mid-2023**, then exiting **S3** storage
  (to Pure Storage) by 2025.
  - Sources: [37signals / DHH, "Leaving the Cloud" hub — basecamp.com/cloud-exit](https://basecamp.com/cloud-exit);
    [The Register, "37signals on-prem migration to save millions, abandon AWS" (9 May 2025)](https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/);
    [37signals Dev, "Moving Mountains of Data off S3"](https://dev.37signals.com/moving-mountains-of-data-off-s3/)
  - **Could not verify** the *exact publication date* of "Why We're Leaving the Cloud"
    (19 Oct 2022) from the primary post itself in this pass; the date is from secondary
    coverage and should be confirmed against the original `world.hey.com`/`37signals`
    URL before being treated as primary.
- **Opinion / disputed claims (attributed):** The **savings figures are 37signals'
  own** — DHH's projection of **>$10M saved over five years** (and ~$2M saved in 2024,
  ~$1.3M/yr from the S3 exit). DHH has also called cloud computing **"mostly a scam"**
  / referred to cloud vendors as **"merchants of complexity"** — these are his
  rhetorical claims, reported by the press, not independently audited numbers.
  - Sources: [The Register, "37signals on-prem migration to save millions…"](https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/);
    [The New Stack, "'Merchants of Complexity': Why 37Signals Abandoned the Cloud"](https://thenewstack.io/merchants-of-complexity-why-37signals-abandoned-the-cloud/)
- **Outputs:** The exit produced **Kamal** (deploy tool, now in Rails 8) and the
  **ONCE** product line (sell-once, self-host software). *(The ONCE specifics are
  37signals product marketing; see basecamp.com/once for primary claims.)*
  - **Could not verify** specific ONCE details from a primary URL in this pass — added
    as a follow-up item.

### 2023 — Removing TypeScript from Turbo

- **Fact (sourced):** On **6 September 2023**, DHH published **"Turbo 8 is dropping
  TypeScript,"** announcing that the next major release of **Turbo** (the Hotwire
  front-end library) would remove TypeScript. The change was implemented in
  [hotwired/turbo PR #971](https://github.com/hotwired/turbo/pull/971).
  - Sources: [DHH, "Turbo 8 is dropping TypeScript" (6 Sep 2023)](https://world.hey.com/dhh/turbo-8-is-dropping-typescript-70165c01);
    [hotwired/turbo PR #971 "Remove TypeScript"](https://github.com/hotwired/turbo/pull/971)
  - *(Note: the brief dates this to "2024"; the primary post and PR are dated
    **September 2023**. The corrected date is used above.)*
- **Opinion (attributed to DHH):** His stated reasons — TypeScript's compile step is
  unwanted friction; type annotations are "type gymnastics" that reduce "joy"; hard
  things "become `any`"; modern JS runs in the browser without tooling. He wrote he'd
  "never been a fan… not after giving it five minutes, not after giving it five years."
  - Source: [DHH, "Turbo 8 is dropping TypeScript"](https://world.hey.com/dhh/turbo-8-is-dropping-typescript-70165c01)
- **Opinion (attributed to the community):** Significant backlash followed — that an
  open-source library's contributors and downstream ecosystem (typed packages, open
  PRs, IDE autocompletion) were disregarded, and that the change was rushed past PR
  feedback. Press covered it as a community rift.
  - Sources: [DEVCLASS, "Ruby on Rails creator removes TypeScript from Turbo framework, upsets community" (7 Sep 2023)](https://devclass.com/2023/09/07/ruby-on-rails-creator-removes-typescript-from-turbo-framework-upsets-community/);
    [Slashdot, "Ruby on Rails Creator Removes TypeScript From Turbo Framework, Upsets Community"](https://developers.slashdot.org/story/23/09/07/2026202/ruby-on-rails-creator-removes-typescript-from-turbo-framework-upsets-community);
    [hotwired/turbo issue #982, "TypeScript is great, delete that PR"](https://github.com/hotwired/turbo/issues/982)

---

## Sources (master list)

Primary / official:
[rubyonrails.org Merb-merge post](https://rubyonrails.org/2008/12/23/merb-gets-merged-into-rails-3) ·
[Yehuda Katz "Rails and Merb Merge"](https://yehudakatz.com/2008/12/23/rails-and-merb-merge/) ·
[The Rails Doctrine](https://rubyonrails.org/doctrine) ·
[The Rails Foundation launch](https://rubyonrails.org/2022/11/14/the-rails-foundation) ·
[1Password joins Foundation](https://rubyonrails.org/2024/12/2/rails-foundation-welcomes-1password-as-core-member) ·
[Rails 8.0: No PaaS Required](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required) ·
[Rails 8.0 Release Notes](https://guides.rubyonrails.org/8_0_release_notes.html) ·
[DHH "Rails 7 / three answers to JavaScript"](https://world.hey.com/dhh/rails-7-will-have-three-great-answers-to-javascript-in-2021-8d68191b) ·
[DHH "Turbo 8 is dropping TypeScript"](https://world.hey.com/dhh/turbo-8-is-dropping-typescript-70165c01) ·
[hotwired/turbo PR #971](https://github.com/hotwired/turbo/pull/971) ·
[37signals "Leaving the Cloud" hub](https://basecamp.com/cloud-exit) ·
[ruby-lang.org About](https://www.ruby-lang.org/en/about/)

Press / secondary:
[Wikipedia: Ruby on Rails](https://en.wikipedia.org/wiki/Ruby_on_Rails) ·
[Wikipedia: DHH](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson) ·
[Wikipedia: Matsumoto](https://en.wikipedia.org/wiki/Yukihiro_Matsumoto) ·
[Wikipedia: Merb](https://en.wikipedia.org/wiki/Merb) ·
[InfoQ Merb-merge](https://www.infoq.com/news/2008/12/merb-merged-in-rails-30/) ·
[InfoQ Twitter Ruby→Java](https://www.infoq.com/news/2012/11/twitter-ruby-to-java/) ·
[The Register Twitter Ruby→Java](https://www.theregister.com/2012/11/08/twitter_epic_traffic_saved_by_java/) ·
[The Register Basecamp apology](https://www.theregister.com/2021/05/05/basecamp_political_discussion_apology/) ·
[The Register 37signals on-prem](https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/) ·
[NPR Basecamp blowup](https://www.npr.org/2021/05/07/994812274/basecamp-blowup-banning-politics-at-work-prompts-over-a-dozen-employees-to-quit) ·
[Platformer "How Basecamp blew up"](https://www.platformer.news/-how-basecamp-blew-up/) ·
[The New Stack "Merchants of Complexity"](https://thenewstack.io/merchants-of-complexity-why-37signals-abandoned-the-cloud/) ·
[DEVCLASS Turbo/TypeScript](https://devclass.com/2023/09/07/ruby-on-rails-creator-removes-typescript-from-turbo-framework-upsets-community/) ·
[The History of the Web: Rails](https://thehistoryoftheweb.com/ruby-on-rails/)
