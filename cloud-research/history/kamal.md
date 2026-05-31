# Kamal (formerly MRSK) — A Sourced History

A chronological, sourced history of **Kamal** — the open-source deployment tool
**37signals** and **David Heinemeier Hansson (DHH)** built to deploy containerized
web apps to your own bare servers (Docker + SSH + a reverse proxy). It was
originally released as **MRSK** in early **2023**, **renamed Kamal in August 2023**
after a trademark claim, reached **2.0** in **September 2024** (replacing Traefik
with the in-house **kamal-proxy**), and is shipped as a **Rails 8 default**. Kamal is
the deploy-tooling output of 37signals' **"cloud exit,"** so this document is a
companion to the cloud-exit thread in [`rails.md`](rails.md) (see its 2022–2023
"Leaving the cloud" section) and the PaaS lineage in [`heroku.md`](heroku.md) — the
`git push` deploy model Kamal positions itself against. Every dated claim links to a
primary or reputable source. **Fact and opinion are kept separate**, with opinions
attributed to whoever voiced them. Items that could not be confirmed are marked
**"Could not verify."**

> **Cross-references (not re-covered here):** see [`rails.md`](rails.md) for Rails 8
> ("No PaaS Required"), the Solid trio, Thruster, and the 2022–2023 37signals cloud
> exit; and [`heroku.md`](heroku.md) for the PaaS deploy model (`git push`, dynos,
> buildpacks) that Kamal's "deploy anywhere, no PaaS required" pitch reacts against.

---

## Timeline

### February 2023 — MRSK introduced

- **28 February 2023** — DHH publicly introduced **MRSK**, 37signals' new
  container-deployment tool, in a tweet: "Introducing MRSK: Deploy web apps
  anywhere." The accompanying 37signals blog post (later retitled after the rename and
  now living at the "Introducing Kamal" URL) framed MRSK as a replacement for
  **Capistrano**, 37signals' own deploy tool from 2005: "It's been a trusty companion
  for many years, but its time is up, and the game has moved on."
  - Sources: [DHH on X/Twitter, "Introducing MRSK: Deploy web apps…" (28 Feb 2023)](https://twitter.com/dhh/status/1630570247760510976);
    [DHH / 37signals, "Introducing Kamal" (originally "Introducing MRSK", 28 Feb 2023)](https://world.hey.com/dhh/introducing-kamal-9330a267)
  - The pitch: bring "the cloud advantages of containerization on our own bare-metal
    hardware" without the complexity of Kubernetes. The post claimed 37signals could
    "deploy a new version of HEY in as little as 20 seconds" with the tool, versus
    minutes under their previous Kubernetes-based approach, and said v1.0 was expected
    once their last app left the cloud in summer 2023.
    - Source: [DHH / 37signals, "Introducing Kamal" (28 Feb 2023)](https://world.hey.com/dhh/introducing-kamal-9330a267)
  - **What MRSK actually is (fact):** essentially "Capistrano for containers" — it
    provisions a bare Ubuntu (or similar) server with Docker over SSH, pulls your app's
    Docker image, and runs it behind a reverse proxy, with zero-downtime rollovers. It
    is **intentionally imperative** (command-driven, like Capistrano) rather than
    declarative like Kubernetes.
    - Source: [Evil Martians, "Kamal: hot deployment tool to watch—or a total game changer?"](https://evilmartians.com/chronicles/mrsk-hot-deployment-tool-or-total-game-changer)
  - The earliest tagged MRSK release on GitHub is **v0.6.3 (11 February 2023)**, i.e.
    development was already public shortly before the announcement.
    - Source: [basecamp/kamal releases (GitHub API; earliest tags)](https://github.com/basecamp/kamal/releases)
  - **Opinion (attributed):** Hacker News commentary on the introduction framed MRSK as
    "basically scp for docker containers" and as suiting teams who want simplicity over
    full orchestration ("most people don't need a spaceship; a plane will work just
    fine"). These are commenter opinions, not 37signals claims.
    - Source: [Hacker News, "Introducing MRSK – 37signals way to deploy"](https://news.ycombinator.com/item?id=34969862)

### Spring 2023 — Central to the "de-cloud, de-k8s" migration

- **21 March 2023** — 37signals SRE **Farah Schüller** published **"De-cloud and
  de-k8s — bringing our apps back home,"** describing MRSK as "the center paradigm
  around our new de-clouding and de-k8sing strategy." The team reported deployment
  times dropping from several minutes to roughly one minute and migrating its first
  apps (Tadalist, Writeboard, Backpack) off the cloud.
  - Source: [37signals Dev, "De-cloud and de-k8s — bringing our apps back home" (21 Mar 2023)](https://dev.37signals.com/bringing-our-apps-back-home/)
  - This ties directly into the broader 37signals **cloud exit** documented in
    [`rails.md`](rails.md): DHH's 2022 "Why We're Leaving the Cloud" and the subsequent
    repatriation. Kamal/MRSK is the deploy-tool half of that thesis — the mechanism
    that made running containers on owned hardware ergonomic enough to abandon AWS and
    Kubernetes.

### August 2023 — Renamed to Kamal (trademark claim)

- **22 August 2023** — With release **v0.16.0**, the project was **renamed from MRSK to
  Kamal**. The release notes (the rename PR, #423, authored by DHH) state: "Due to a
  trademark claim, we've renamed the project to Kamal after the ancient Arab
  navigational tool. The new executable is now `kamal` and all env variables are
  prefixed with `KAMAL_*`. The new website going forward will live at
  https://kamal-deploy.org."
  - Sources: [basecamp/kamal release v0.16.0 (22 Aug 2023)](https://github.com/basecamp/kamal/releases/tag/v0.16.0);
    [basecamp/kamal PR #423, "Rename project to Kamal"](https://github.com/basecamp/kamal/pull/423)
  - **The name:** Kamal is named after the **kamal**, an ancient Arab celestial
    navigation instrument used to determine latitude from the Pole Star — fitting the
    "keep your apps on course, deploy anywhere" framing.
    - Sources: [Kamal homepage, kamal-deploy.org](https://kamal-deploy.org/);
      [Mariners' Museum, "Kamal" object page (linked from the release notes)](https://exploration.marinersmuseum.org/object/kamal/)
  - The rename was widely noted in the community (Hacker News: "MRSK is renamed to Kamal
    due to a trademark claim").
    - Source: [Hacker News, "MRSK is renamed to Kamal due to a trademark claim"](https://news.ycombinator.com/item?id=37227647)
  - **Could not verify** who held the conflicting "MRSK" trademark or the legal
    specifics of the claim; 37signals stated only that a trademark claim forced the
    rename and did not name the claimant in the release notes.

### September 2023 — Kamal 1.0

- **19 September 2023** — **Kamal 1.0.0** was released, the first stable version, landing
  roughly on the "after our last app leaves the cloud in summer 2023" schedule DHH had
  set in February.
  - Source: [basecamp/kamal release v1.0.0 (19 Sep 2023)](https://github.com/basecamp/kamal/releases/tag/v1.0.0)
  - In the 1.x line, Kamal used **Traefik** as its bundled reverse proxy for routing and
    zero-downtime rollovers.
    - Source: [Kamal docs, "Kamal 2: Continuing to use Traefik" (upgrade guide)](https://kamal-deploy.org/docs/upgrading/continuing-to-use-traefik/)

### September 2024 — Kamal 2.0 and kamal-proxy

- **26 September 2024** — **Kamal 2.0.0** was released. The headline change: **Traefik
  was dropped as the default proxy** in favor of **kamal-proxy**, a small HTTP proxy
  37signals built from scratch.
  - Sources: [basecamp/kamal release v2.0.0 (26 Sep 2024)](https://github.com/basecamp/kamal/releases/tag/v2.0.0);
    [37signals Dev, "Kamal 2.0 released" by Donal McBreen (26 Sep 2024)](https://dev.37signals.com/kamal-2/)
  - **Why replace Traefik (37signals' stated reasoning):** Traefik's "declarative
    discovery model made it a poor match for Kamal's imperative design," and its own
    domain language (Routers, Services, EntryPoints) made failures hard to diagnose
    because errors were disconnected from what Kamal was doing. kamal-proxy gives a
    "1-1 mapping between kamal commands and proxy commands," enabling new features like
    maintenance mode, request pausing, and canary deployments.
    - Source: [37signals Dev, "Kamal 2.0 released" (26 Sep 2024)](https://dev.37signals.com/kamal-2/)
  - **kamal-proxy** is a separate Go project. Its repository's first commit is dated
    **30 August 2024**, and **v0.1.0** is tagged **16 September 2024**. It is described
    upstream as "a tiny HTTP proxy, designed to make it easy to coordinate zero-downtime
    deployments" — running apps behind it lets you "deploy changes to them without
    interrupting any of the traffic that's in progress."
    - Source: [basecamp/kamal-proxy (GitHub repo and README)](https://github.com/basecamp/kamal-proxy)
  - **New in 2.0 (fact):** kamal-proxy makes it straightforward to run **multiple web
    apps on a single server** and to provision **automatic TLS via Let's Encrypt**
    without hand-writing Traefik config. Kamal 2 also marketed simpler first-time setup
    ("deploy from your laptop to a fresh server"). On the "deploy without downtime to
    one server" framing: the 37signals announcement emphasizes zero-downtime version
    switching and single-server multi-app deploys, though it frames this as scaling
    flexibility rather than using a specific "deploy without downtime to one server"
    marketing slogan.
    - Sources: [37signals Dev, "Kamal 2.0 released" (26 Sep 2024)](https://dev.37signals.com/kamal-2/);
      [Kamal docs, "Kamal 2: Proxy Changes"](https://kamal-deploy.org/docs/upgrading/proxy-changes/)
  - **Backward compatibility (fact):** kamal-proxy is *not* a drop-in Traefik
    replacement — it deliberately omits Traefik's middleware and advanced features. Teams
    that want Traefik can still run it as a Kamal "accessory."
    - Source: [Kamal docs, "Kamal 2: Continuing to use Traefik"](https://kamal-deploy.org/docs/upgrading/continuing-to-use-traefik/)

### November 2024 — Bundled as a Rails 8 default

- **8 November 2024** — **Rails 8.0** shipped under the banner "No PaaS Required," and
  the release notes state plainly: **"Rails now comes preconfigured with Kamal 2 for
  deploying your application."** A new Rails app generates a Kamal config out of the box.
  Separately, the Rails 8 Dockerfile gained **Thruster**, a proxy that sits in front of
  Puma for X-Sendfile acceleration, asset caching, and compression.
  - Sources: [Rails 8.0 Release Notes — guides.rubyonrails.org](https://guides.rubyonrails.org/8_0_release_notes.html);
    [rubyonrails.org, "Rails 8.0: No PaaS Required" (7 Nov 2024)](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required)
  - This extends Rails' "batteries-included" reach all the way to deployment — the
    framework now ships an opinionated path to run a production app on a plain VM or bare
    metal, deliberately positioned against PaaS lock-in (cf. [`heroku.md`](heroku.md)).
    Note: **Thruster (in-app, in front of Puma)** and **kamal-proxy (on the host, in
    front of containers)** are distinct components that can coexist.

**Current status (as of this writing, 2026):** Kamal is on the 2.x line; the latest
tagged release is **v2.11.0 (18 March 2026)**. It remains a 37signals/Basecamp-stewarded
open-source project and the default Rails 8 deploy tool.
- Source: [basecamp/kamal releases (GitHub)](https://github.com/basecamp/kamal/releases)

---

## Key people & teams

- **David Heinemeier Hansson (DHH)** — creator/announcer of MRSK/Kamal; authored the
  introduction post and the rename PR (#423). Partner/CTO at **37signals**; the public
  face of the cloud-exit thesis that produced Kamal.
  - Sources: [DHH / 37signals, "Introducing Kamal"](https://world.hey.com/dhh/introducing-kamal-9330a267);
    [basecamp/kamal PR #423](https://github.com/basecamp/kamal/pull/423)
- **Donal McBreen** — 37signals programmer; authored the official **"Kamal 2.0
  released"** announcement and is a recurring Kamal/kamal-proxy contributor (appears in
  release notes as `@djmb`).
  - Sources: [37signals Dev, "Kamal 2.0 released" (26 Sep 2024)](https://dev.37signals.com/kamal-2/);
    [basecamp/kamal release v0.16.0 (PRs by @djmb)](https://github.com/basecamp/kamal/releases/tag/v0.16.0)
- **Farah Schüller** — 37signals Senior Site Reliability Engineer; wrote the "De-cloud
  and de-k8s" post that put MRSK at the center of the migration strategy.
  - Source: [37signals Dev, "De-cloud and de-k8s — bringing our apps back home" (21 Mar 2023)](https://dev.37signals.com/bringing-our-apps-back-home/)
- **Other contributors named in early release notes** — Igor Alexandrov, Bruno Prietog,
  and Manas Tyretskyi appear among v0.16.0 contributors; the project is community-augmented,
  not solely 37signals staff.
  - Source: [basecamp/kamal release v0.16.0](https://github.com/basecamp/kamal/releases/tag/v0.16.0)
  - **Could not verify** precise employer/role for each external contributor from a
    primary source in this pass; they are correctly identified as Kamal contributors via
    the release notes, but individual affiliations were not separately confirmed.

---

## Company & corporate history

Kamal has no separate corporate existence — it is a 37signals/Basecamp open-source
project, developed in service of the company's own infrastructure and released under
the `basecamp/` GitHub org. Its history is the history of 37signals' cloud exit.

- **11–28 February 2023** — MRSK appears on GitHub (earliest tag v0.6.3, 11 Feb) and is
  publicly introduced by DHH (28 Feb).
  [DHH tweet](https://twitter.com/dhh/status/1630570247760510976) ·
  [Introducing Kamal post](https://world.hey.com/dhh/introducing-kamal-9330a267)
- **21 March 2023** — MRSK declared "the center paradigm" of 37signals' de-cloud/de-k8s
  migration. [37signals Dev](https://dev.37signals.com/bringing-our-apps-back-home/)
- **22 August 2023** — Renamed **MRSK → Kamal** (v0.16.0) after a trademark claim.
  [v0.16.0](https://github.com/basecamp/kamal/releases/tag/v0.16.0)
- **19 September 2023** — **Kamal 1.0.0** (Traefik-based).
  [v1.0.0](https://github.com/basecamp/kamal/releases/tag/v1.0.0)
- **16–26 September 2024** — **kamal-proxy** v0.1.0 tagged (16 Sep); **Kamal 2.0.0**
  released (26 Sep), replacing Traefik.
  [v2.0.0](https://github.com/basecamp/kamal/releases/tag/v2.0.0) ·
  [kamal-proxy](https://github.com/basecamp/kamal-proxy)
- **8 November 2024** — Bundled as a **Rails 8** default ("preconfigured with Kamal 2").
  [Rails 8.0 release notes](https://guides.rubyonrails.org/8_0_release_notes.html)
- **18 March 2026** — Latest tagged release v2.11.0 (as of this writing).
  [Releases](https://github.com/basecamp/kamal/releases)

### The broader anti-cloud thesis (context, attributed)

Kamal is inseparable from DHH/37signals' "cloud exit" and the **ONCE** product line —
two prongs of the same anti-cloud argument: run software on hardware you own.

- **Fact (sourced):** 37signals' cloud spend reached ~$3.2M/year before the exit;
  after a ~$600,000 hardware purchase, the company reported its compute migration
  complete around mid-2023. On **17 October 2024**, DHH published **"Our cloud-exit
  savings will now top ten million over five years,"** projecting **"well over ten
  million dollars over five years,"** with near-term annual savings stated in the
  ~$1.3M–$2M range and a plan to "literally delete our AWS account come this summer."
  - Sources: [DHH, "Our cloud-exit savings will now top ten million over five years" (17 Oct 2024)](https://world.hey.com/dhh/our-cloud-exit-savings-will-now-top-ten-million-over-five-years-c7d9b5bd);
    [The Register, "37signals on-prem migration to save millions, abandon AWS" (9 May 2025)](https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/)
  - **Opinion / disputed (attributed):** The savings figures are 37signals' own
    projections, reported by the press but not independently audited; DHH's broader
    rhetoric (cloud as a poor deal, "merchants of complexity") is his argument, not a
    neutral finding. See the fuller treatment in [`rails.md`](rails.md).
- **ONCE (related, attributed):** Parallel to the deploy tool, 37signals launched
  **ONCE** — "pay one time, own forever" self-hosted software (Campfire, then
  Writebook), explicitly pitched as helping lead the industry "out" of the SaaS model
  37signals helped pioneer. Kamal and ONCE share the "host it yourself" worldview but
  are distinct: Kamal is the open deploy tool; ONCE is a commercial product line.
  - Sources: [DHH, "ONCE (Again)"](https://world.hey.com/dhh/once-again-3e99f755);
    [DHH, "Campfire is ONCE #1"](https://world.hey.com/dhh/campfire-is-once-1-d2cebd12);
    [ONCE — Campfire (once.com)](https://once.com/campfire)
  - **Could not verify** a direct technical dependency between ONCE's installer/app
    server and Kamal from a primary source in this pass; they are presented here as
    thematically related (the same anti-cloud thesis), not as the same codebase.

---

## Controversies / debates

> Kamal is far less controversy-laden than DHH's other projects (see the Turbo/TypeScript
> and Basecamp episodes in [`rails.md`](rails.md)). The debates around it are mostly
> technical positioning, attributed below.

### "Just enough orchestration" vs. Kubernetes (debate, attributed)

- **Opinion (attributed):** Kamal's entire pitch is that most teams don't need
  Kubernetes — that an imperative, SSH-driven Docker deploy is "just enough
  orchestration." Critics counter that Kamal deliberately omits what orchestrators
  provide (auto-scaling, self-healing, node-failure handling, scheduling), so it suits
  small-to-mid deployments rather than large clusters. Both framings appeared in the
  earliest community reaction.
  - Sources: [Hacker News, "Introducing MRSK – 37signals way to deploy"](https://news.ycombinator.com/item?id=34969862);
    [Evil Martians, "Kamal: hot deployment tool to watch—or a total game changer?"](https://evilmartians.com/chronicles/mrsk-hot-deployment-tool-or-total-game-changer)

### The Traefik → kamal-proxy switch (debate, attributed)

- **Fact:** Kamal 2.0 replaced a mature, widely used proxy (Traefik) with 37signals'
  own younger kamal-proxy, which intentionally lacks Traefik's middleware/advanced
  features. 37signals' rationale was diagnosability and a clean 1-1 command mapping.
  - Source: [37signals Dev, "Kamal 2.0 released"](https://dev.37signals.com/kamal-2/)
- **Opinion (attributed):** Some operators view building a bespoke proxy as reinventing
  a solved problem and a feature regression for advanced setups; 37signals' position is
  that the simpler, purpose-built proxy better matches Kamal's imperative model and
  enables new deploy features. The upgrade path keeps Traefik available as an accessory,
  which the docs frame as a deliberate escape hatch.
  - Source: [Kamal docs, "Kamal 2: Continuing to use Traefik"](https://kamal-deploy.org/docs/upgrading/continuing-to-use-traefik/)

---

## Items marked "Could not verify"

- **The holder of the "MRSK" trademark / the legal specifics of the claim** — 37signals
  stated only that a trademark claim forced the August 2023 rename and did not name the
  claimant; no primary source identifying the claimant was located.
- **Exact "first public commit" date of MRSK** — the earliest *tagged release* is
  v0.6.3 (11 Feb 2023) per the GitHub releases API; an earlier untagged
  initial-commit date was not separately pinned in this pass.
- **A specific "deploy without downtime to one server" marketing slogan for Kamal 2** —
  37signals' announcement emphasizes zero-downtime version switching and single-server
  multi-app deploys, but the exact phrasing in the brief was not found verbatim in the
  primary post; treat it as a paraphrase of the zero-downtime/single-server framing.
- **A direct technical dependency between ONCE (the installer / app server) and Kamal** —
  the two share the anti-cloud / self-host thesis, but no primary source establishing a
  shared codebase or runtime dependency was confirmed here.
- **Individual affiliations/roles of external Kamal contributors** (beyond their
  appearance in release notes) — not separately sourced.
- **The DHH MRSK-introduction tweet text** — the tweet URL resolves and is cited;
  automated fetching of X/Twitter is unreliable, so the quoted title ("Introducing MRSK:
  Deploy web apps anywhere") is corroborated by the contemporaneous 37signals post and
  press, not solely the live tweet render.

---

## Sources (master list)

Primary / official:
[DHH / 37signals "Introducing Kamal" (orig. "Introducing MRSK")](https://world.hey.com/dhh/introducing-kamal-9330a267) ·
[DHH tweet introducing MRSK](https://twitter.com/dhh/status/1630570247760510976) ·
[37signals Dev "De-cloud and de-k8s"](https://dev.37signals.com/bringing-our-apps-back-home/) ·
[37signals Dev "Kamal 2.0 released"](https://dev.37signals.com/kamal-2/) ·
[basecamp/kamal release v0.16.0 (rename)](https://github.com/basecamp/kamal/releases/tag/v0.16.0) ·
[basecamp/kamal PR #423 (rename)](https://github.com/basecamp/kamal/pull/423) ·
[basecamp/kamal release v1.0.0](https://github.com/basecamp/kamal/releases/tag/v1.0.0) ·
[basecamp/kamal release v2.0.0](https://github.com/basecamp/kamal/releases/tag/v2.0.0) ·
[basecamp/kamal releases](https://github.com/basecamp/kamal/releases) ·
[basecamp/kamal-proxy](https://github.com/basecamp/kamal-proxy) ·
[Kamal homepage](https://kamal-deploy.org/) ·
[Kamal docs: Proxy Changes](https://kamal-deploy.org/docs/upgrading/proxy-changes/) ·
[Kamal docs: Continuing to use Traefik](https://kamal-deploy.org/docs/upgrading/continuing-to-use-traefik/) ·
[Rails 8.0 Release Notes](https://guides.rubyonrails.org/8_0_release_notes.html) ·
[rubyonrails.org "Rails 8.0: No PaaS Required"](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required) ·
[DHH "Our cloud-exit savings will now top ten million over five years"](https://world.hey.com/dhh/our-cloud-exit-savings-will-now-top-ten-million-over-five-years-c7d9b5bd) ·
[DHH "ONCE (Again)"](https://world.hey.com/dhh/once-again-3e99f755) ·
[DHH "Campfire is ONCE #1"](https://world.hey.com/dhh/campfire-is-once-1-d2cebd12) ·
[ONCE — Campfire](https://once.com/campfire) ·
[Mariners' Museum "Kamal" object](https://exploration.marinersmuseum.org/object/kamal/)

Press / secondary:
[Evil Martians "Kamal: hot deployment tool…"](https://evilmartians.com/chronicles/mrsk-hot-deployment-tool-or-total-game-changer) ·
[Hacker News "Introducing MRSK"](https://news.ycombinator.com/item?id=34969862) ·
[Hacker News "MRSK is renamed to Kamal…"](https://news.ycombinator.com/item?id=37227647) ·
[The Register "37signals on-prem migration to save millions, abandon AWS"](https://www.theregister.com/2025/05/09/37signals_cloud_repatriation_storage_savings/)
