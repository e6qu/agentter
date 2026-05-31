# Dokku — A Sourced History

A chronological, sourced history of **Dokku**, billed by its creator as *"the
smallest PaaS implementation you've ever seen"* — an open-source, self-hosted,
Docker-powered Heroku clone that lets you deploy applications by `git push` to
your own server, building them with Heroku-compatible buildpacks and running
them in containers. This document traces its 2013 creation by **Jeff Lindsay**,
its long-running stewardship by lead maintainer **Jose Diaz-Gonzalez**, the
plugin ecosystem, the Herokuish → Cloud Native Buildpacks build story, and its
renewed relevance after Heroku ended its free tier in 2022.

Every non-trivial claim links to a working source. For an open-source project,
the GitHub repository history, README, release tags, official docs, and the
creator's own posts are treated as primary sources, with reputable secondary
outlets as corroboration. Items that could not be confirmed are marked
**"Could not verify."**

> Cross-reference: Heroku's own history — including the `git push` / dyno model,
> buildpacks, and the August–November 2022 end of free plans — is covered in
> `history/heroku.md`. Docker's history is in `history/docker.md`. Both are only
> summarized here to avoid duplication.

---

## Timeline

### Creation: "the smallest PaaS implementation you've ever seen" (June 2013)

- **June 19, 2013 — Dokku announced.** Jeff Lindsay (GitHub handle **progrium**)
  published the announcement post **"Dokku: The smallest PaaS implementation
  you've ever seen."** He described it as **"a mini-Heroku powered by Docker
  written in less than 100 lines of Bash."** Once set up on a host, you could
  **"push Heroku-compatible applications to it via Git. They'll build using
  Heroku buildpacks and then run in isolated containers,"** yielding **"your own,
  single-host version of Heroku."**
  Source: [Jeff Lindsay, "Dokku: The smallest PaaS implementation you've ever seen" (June 19, 2013)](https://progrium.github.io/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/).

- **Built from existing components.** The "under 100 lines" claim hinged on Dokku
  being glue over several independently useful building blocks. Per the
  announcement, Dokku leaned on **Docker** ("a container runtime for Linux" that
  "provides the heart of Dokku"), **Buildstep** (which "uses Heroku's open source
  buildpacks" to produce the application image), and **gitreceive** (which
  "provides you with a git user that you can push repositories to" and triggers a
  deploy script). Buildstep and gitreceive were also Jeff Lindsay projects.
  Source: [Jeff Lindsay, announcement post (June 19, 2013)](https://progrium.github.io/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/).

- **Repository and first release (June 2013).** The `dokku` GitHub repository was
  created on **June 8, 2013** (`created_at` per the GitHub API). The first tagged
  release, **v0.1.0**, is dated **June 15, 2013**, and the earliest commit
  reachable from that tag is dated **June 15, 2013** — both authored by **Jeff
  Lindsay**.
  Sources: [GitHub API — dokku/dokku repository metadata](https://api.github.com/repos/dokku/dokku) (`"created_at": "2013-06-08T10:26:57Z"`);
  [GitHub API — dokku/dokku v0.1.0 tag object](https://api.github.com/repos/dokku/dokku/git/tags/8cd1c3f97b64396001029f3a3fa242f98814fe6d) (`"date": "2013-06-15T22:12:27Z"`).
  *(The repo originally lived at **github.com/progrium/dokku** — Jeff Lindsay's
  personal namespace — and now redirects to **github.com/dokku/dokku**; the
  `progrium/dokku` URLs still resolve via redirect, e.g.
  [github.com/progrium/dokku/wiki](https://github.com/progrium/dokku/wiki). A
  precise dated announcement of the move to the `dokku` org was **not** located
  — see "Could not verify.")*

- **"The first killer app for Docker."** In his own later retrospective, Lindsay
  characterized Dokku's impact: **"Dokku was quite a hit as it was the first
  killer app for Docker. Before most even knew what Docker was, Dokku gave you a
  single host Heroku that was extremely hackable and extensible. It was
  originally only 100 lines of Bash."** (Docker had itself only been publicly
  revealed at PyCon on March 15, 2013 — three months before Dokku — see
  `history/docker.md`.)
  Source: [Jeff Lindsay, "Hi, I'm Jeff Lindsay" — DEV Community](https://dev.to/progrium/hi-im-jeff-lindsay).

### Maintainer transition: Jose Diaz-Gonzalez takes the lead (≈2014–2015)

- **Jose Diaz-Gonzalez becomes the long-time lead maintainer.** Jeff Lindsay
  created Dokku but moved on to other Docker tooling (founding the **Glider Labs**
  consultancy and projects like Registrator and Logspout); day-to-day stewardship
  of Dokku passed to **Jose Diaz-Gonzalez** (GitHub handle **josegonzalez**), who
  has been its principal maintainer for the bulk of the project's life. On the
  project's Open Collective, the maintainer roster lists **Jeff Lindsay (Core
  Contributor), Jose Diaz-Gonzalez (Admin), and Michael Hobbs (Core
  Contributor)**, and Jose Diaz-Gonzalez is listed as a member of the **dokku**
  GitHub organization.
  Sources: [Dokku — Open Collective](https://opencollective.com/dokku);
  [dokku organization members — GitHub](https://github.com/orgs/dokku/people);
  [Jeff Lindsay, "Hi, I'm Jeff Lindsay" — DEV Community](https://dev.to/progrium/hi-im-jeff-lindsay) (Glider Labs).

- **Timing of the handoff (sourced via commit history).** Jose Diaz-Gonzalez's
  earliest commits to the `dokku/dokku` repository are dated **December 29,
  2014** (per the GitHub API), and he was editing the project's wiki by **October
  13, 2015** — consistent with him taking over active maintenance in the
  2014–2015 window. Dokku's own published documentation (the long-form docs PDF)
  is authored by **"Jose Diaz-Gonzalez."**
  Sources: [GitHub API — dokku/dokku commits by josegonzalez before 2015](https://api.github.com/repos/dokku/dokku/commits?author=josegonzalez&per_page=1&until=2015-01-01T00:00:00Z) (`"date": "2014-12-29T21:56:00Z"`);
  [Dokku documentation PDF (authored by Jose Diaz-Gonzalez)](https://dokku-docs.readthedocs.io/_/downloads/en/latest/pdf/).
  *(The exact date on which maintainership formally transferred from Lindsay to
  Diaz-Gonzalez was **not** found in a single dated primary announcement; the
  December 2014 first-commit and October 2015 wiki-edit datapoints are used as
  the sourced anchors — treat the precise handoff date as **inferred**.)*

### The plugin ecosystem and "own your PaaS"

- **Plugins in any language.** A defining feature of Dokku is its **plugin
  architecture**: core functionality (databases, SSL/Let's Encrypt, domains,
  proxies, etc.) is delivered as plugins, and users can **"write dokku plugins in
  any language"** and **"share them online with others, and extend those already
  available."** The project's positioning is **"Own Your PaaS … Powered by Docker,
  you can install Dokku on any hardware,"** with **"Easy Git Deploys"** and an
  **"Extensible Platform."**
  Sources: [dokku.com (homepage)](https://dokku.com/);
  [Dokku — Open Collective](https://opencollective.com/dokku).

- **Repository tagline and license.** The GitHub repository describes Dokku as
  **"A docker-powered PaaS that helps you build and manage the lifecycle of
  applications,"** is **MIT-licensed**, and is tagged with `heroku`, `docker`,
  `kubernetes`, `devops`, `containers`, `self-hosted`, and `paas`. As of this
  writing the repo had **~31,900 GitHub stars**.
  Sources: [dokku/dokku — GitHub](https://github.com/dokku/dokku);
  [GitHub API — dokku/dokku repository metadata](https://api.github.com/repos/dokku/dokku) (`"stargazers_count": 31910`, MIT license).

### Build story: Buildstep → Herokuish → Cloud Native Buildpacks

- **Herokuish (from late 2014).** Dokku's Heroku-compatibility layer evolved from
  the original **Buildstep** into **Herokuish**, a utility for **"emulating Heroku
  build and runtime tasks in containers."** The `gliderlabs/herokuish` repository
  was created on **November 22, 2014** (per the GitHub API); Herokuish runs Heroku
  buildpacks inside Docker so that pushed apps build and run as they would on
  Heroku. Herokuish was authored by **Jose Diaz-Gonzalez**.
  Sources: [gliderlabs/herokuish — GitHub](https://github.com/gliderlabs/herokuish);
  [GitHub API — gliderlabs/herokuish metadata](https://api.github.com/repos/gliderlabs/herokuish) (`"created_at": "2014-11-22T00:50:55Z"`);
  [Herokuish by Jose Diaz-Gonzalez — FLOSS/Fund](https://dir.floss.fund/view/project/@dokku.com/herokuish).

- **Cloud Native Buildpacks support added (≈2020).** Dokku later added support for
  **Cloud Native Buildpacks (CNB)** — the CNCF buildpacks spec generalized out of
  Heroku/Pivotal's buildpacks idea (see `history/heroku.md`). In a 2020 blog post,
  the project framed CNB as the future and stated **"Long-term, the plan is to
  deprecate and eventually remove gliderlabs/herokuish support,"** with
  **"Herokuish to become unsupported once `pack` hits a stable release."**
  Source: [Dokku Blog, "Comparing Cloud Native Buildpacks to Herokuish" (2020)](https://dokku.com/blog/2020/comparing-buildpack-v3-to-herokuish/).

- **Current CNB builder (docs).** Dokku's documentation describes CNB as **"an
  evolution over the Buildpacks technology provided by the Herokuish builder."**
  CNB builds use the **`pack` CLI** from the Cloud Native Buildpacks project (the
  `pack` CLI **"is not included by default with Dokku or as a dependency [and]
  must also be installed"**), the builder is auto-detected when a `project.toml`
  file exists in the app repo, and the default stack builder is based on
  **`heroku/builder:24`**.
  Source: [Dokku Documentation, "Cloud Native Buildpacks"](https://dokku.com/docs/deployment/builders/cloud-native-buildpacks/).
  *(As of this writing, Dokku still ships the Herokuish builder alongside CNB and
  Dockerfile builders; the current CNB docs page describe coexistence and
  builder-switching rather than restating a hard deprecation date — treat the
  "remove Herokuish" plan as a stated long-term intention, per the 2020 blog
  post, not a completed step.)*

### Renewed relevance after Heroku kills its free tier (2022)

- **Heroku ended free plans (Nov 28, 2022).** Heroku stopped offering free
  product plans starting **November 28, 2022** (announced August 25, 2022), ending
  free dynos, Postgres, and Redis — the tier that had made it the default home for
  hobby apps, prototypes, and MVPs (full detail in `history/heroku.md`).
  Source: [Heroku Blog, "Heroku's Next Chapter"](https://www.heroku.com/blog/next-chapter/).

- **Dokku as the canonical self-hosted Heroku.** The free-tier removal drove
  renewed interest in self-hosted Heroku-style PaaS, and Dokku — as the oldest and
  most mature option, with direct Heroku-buildpack support — was repeatedly cited
  among the leading replacements (alongside CapRover, Coolify, and others).
  Sources: [Sliplane, "Dokku: The Self-Hosted Heroku Alternative"](https://sliplane.io/blog/dokku-self-hosted-heroku-alternative);
  [DigitalOcean, "Top Heroku Alternatives for Cloud Deployment"](https://www.digitalocean.com/resources/articles/heroku-alternatives);
  [Encore, "The End of Heroku: What It Means for Your Apps"](https://encore.dev/articles/end-of-heroku).
  *(The "surge in interest after the free-tier cut" is a reported/secondary
  characterization carried by these outlets and developer write-ups, not a
  metric published by the Dokku project — treat it as **reported perception**.)*

---

## Key people & teams

- **Jeff Lindsay** (GitHub: **progrium**) — **Creator of Dokku** (announced June
  19, 2013). A prolific Docker-era open-source builder; he authored the
  supporting projects **Buildstep** and **gitreceive** that Dokku was built on,
  and co-founded the **Glider Labs** consultancy (home of `gliderlabs/herokuish`,
  Registrator, Logspout). He calls Dokku "the first killer app for Docker."
  Sources: [progrium (Jeff Lindsay) — GitHub](https://github.com/progrium);
  [Jeff Lindsay, "Hi, I'm Jeff Lindsay" — DEV Community](https://dev.to/progrium/hi-im-jeff-lindsay);
  [Jeff Lindsay, Dokku announcement (June 19, 2013)](https://progrium.github.io/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/).

- **Jose Diaz-Gonzalez** (GitHub: **josegonzalez**) — **Long-time lead maintainer
  / Admin** of Dokku; author of **Herokuish** and of the official Dokku
  documentation. Listed as Admin on the Dokku Open Collective and a member of the
  `dokku` GitHub org; active in the repo since at least December 2014.
  Sources: [Dokku — Open Collective](https://opencollective.com/dokku);
  [dokku organization members — GitHub](https://github.com/orgs/dokku/people);
  [Herokuish by Jose Diaz-Gonzalez — FLOSS/Fund](https://dir.floss.fund/view/project/@dokku.com/herokuish).

- **Michael Hobbs** (GitHub: **michaelshobbs**) — Listed as a **Core Contributor**
  on the Dokku Open Collective and a member of the `dokku` GitHub organization.
  Sources: [Dokku — Open Collective](https://opencollective.com/dokku);
  [dokku organization members — GitHub](https://github.com/orgs/dokku/people).

- **Other org members.** The `dokku` GitHub organization also lists
  **decentral1se (d1)** and **Leopold Talirz (ltalirz)** as members.
  Source: [dokku organization members — GitHub](https://github.com/orgs/dokku/people).

---

## Company & corporate history

Dokku is **not a company** — it is a community-run, MIT-licensed open-source
project. Rather than a corporate funding history, its "organizational" history is
about code ownership and a transparent funding collective.

- **June 2013** — Created by Jeff Lindsay; first release v0.1.0 (June 15, 2013);
  repo originally at `github.com/progrium/dokku`.
  [Announcement](https://progrium.github.io/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/) ·
  [v0.1.0 tag (GitHub API)](https://api.github.com/repos/dokku/dokku/git/tags/8cd1c3f97b64396001029f3a3fa242f98814fe6d)
- **≈2014–2015** — Maintainership transitions to Jose Diaz-Gonzalez; project moves
  to the `dokku/dokku` GitHub organization.
  [Open Collective](https://opencollective.com/dokku) ·
  [GitHub org members](https://github.com/orgs/dokku/people)
- **Late 2014 onward** — Herokuish (`gliderlabs/herokuish`, created Nov 22, 2014)
  becomes the Heroku-compatibility build layer.
  [herokuish (GitHub API)](https://api.github.com/repos/gliderlabs/herokuish)
- **≈2020** — Cloud Native Buildpacks support added; stated long-term plan to
  deprecate Herokuish in favor of the `pack` CLI.
  [Dokku Blog (2020)](https://dokku.com/blog/2020/comparing-buildpack-v3-to-herokuish/)
- **2022 onward** — Heroku ends free plans (Nov 28, 2022); Dokku is widely cited
  as the canonical self-hosted Heroku replacement.
  [Heroku "Next Chapter"](https://www.heroku.com/blog/next-chapter/) ·
  [DigitalOcean](https://www.digitalocean.com/resources/articles/heroku-alternatives)
- **Funding model** — Funded transparently via **Open Collective** (fiscal host:
  Open Source Collective), with recurring backers and sponsors rather than venture
  capital.
  [Dokku — Open Collective](https://opencollective.com/dokku)

---

## Controversies / contested points

> Dokku is a small, community OSS project and has not been the subject of the kind
> of high-profile controversies seen with commercial vendors. The items below are
> contested or nuance-worthy points rather than scandals, with fact separated from
> characterization.

1. **"Under 100 lines of Bash" framing.**
   - *Fact:* The original 2013 Dokku was, by the creator's own account, **"less
     than 100 lines of Bash"** — but only because it delegated the heavy lifting to
     Docker, Buildstep, and gitreceive.
     [Announcement (June 19, 2013)](https://progrium.github.io/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/)
   - *Nuance:* Modern Dokku is a substantial, plugin-rich codebase far beyond 100
     lines; the "smallest PaaS" tagline persists as branding (it is still the
     site's tagline), not a literal current line count.
     [dokku.com](https://dokku.com/)

2. **Herokuish deprecation vs. reality.**
   - *Fact (stated intent):* In 2020 the project said it planned to **deprecate and
     eventually remove** Herokuish once the CNB `pack` CLI stabilized.
     [Dokku Blog (2020)](https://dokku.com/blog/2020/comparing-buildpack-v3-to-herokuish/)
   - *Nuance:* As of this writing Dokku still ships and documents the Herokuish
     builder alongside CNB; the removal is a long-term plan, not a completed
     transition.
     [Dokku CNB docs](https://dokku.com/docs/deployment/builders/cloud-native-buildpacks/) ·
     [Dokku Herokuish docs](https://dokku.com/docs/deployment/builders/herokuish-buildpacks/)

3. **"Renewed relevance after Heroku's free-tier cut."**
   - *Reported characterization:* Multiple outlets and developer write-ups position
     Dokku as a top self-hosted Heroku replacement following the November 28, 2022
     free-plan removal. This is reported perception/recommendation, not a
     project-published adoption metric.
     [Sliplane](https://sliplane.io/blog/dokku-self-hosted-heroku-alternative) ·
     [DigitalOcean](https://www.digitalocean.com/resources/articles/heroku-alternatives) ·
     [Encore](https://encore.dev/articles/end-of-heroku)

---

## Items marked "Could not verify"

- **Exact date Dokku's repository moved from `progrium/dokku` to the `dokku`
  GitHub organization.** The move is evident (the old URLs redirect to
  `dokku/dokku`, and Jose Diaz-Gonzalez is an org member), but no dated primary
  announcement of the org transfer was located.
- **Precise date maintainership formally transferred from Jeff Lindsay to Jose
  Diaz-Gonzalez.** Anchored here to Diaz-Gonzalez's first commit (Dec 29, 2014)
  and a wiki edit (Oct 13, 2015); the exact handoff is **inferred**, not stated in
  a single dated source.
- **Whether Herokuish has actually been removed/deprecated yet.** The 2020 blog
  post states the *intent*; current docs still ship Herokuish. The completion
  status of that deprecation was not confirmed to a dated source.
- **A project-published metric quantifying a post-2022 surge in Dokku adoption.**
  The "renewed relevance after Heroku killed the free tier" claim rests on
  secondary outlets/recommendations, not on Dokku-published usage numbers.
- **Michael Hobbs's and other contributors' specific roles/tenure.** Confirmed as
  Core Contributor / org member via Open Collective and GitHub, but detailed
  role history was not separately sourced.
