# Earthly — A Sourced History

A chronological, fully-sourced history of **Earthly** (the build-automation tool /
Earthfile) and **Earthly Technologies**, the company behind it.

Scope note: This document covers the open-source build tool (`earthly` / Earthfile),
the company's commercial products (Earthly CI, Satellites, Earthly Cloud), the
licensing history, funding, key people, and the 2023–2025 strategic pivots that ended
in the wind-down of the build business and the launch of "Earthly Lunar."

Every non-trivial claim is followed by a source URL. Where a claim could not be
confirmed from a primary or reputable source, it is marked **"Could not verify."**
Opinions and analysis are attributed to their source.

---

## Timeline

### 2020

- **April 16, 2020 — Earthly is publicly introduced.** Founder **Vlad A. Ionescu**
  publishes "Introducing Earthly: build automation for the container era." Earthly is
  described as having "a familiar Dockerfile-like syntax" — likened to what you'd get
  if "Dockerfile and Makefile had a baby" — and it leverages existing build systems
  rather than replacing them, running containerized builds with layer caching and
  parallelization.
  Source: <https://earthly.dev/blog/introducing-earthly-build-automation-for-the-container-era/>
  (post is dated April 16, 2020; "Updated July 11, 2023").
  - The company's own About page lists "2020 Earthly founded."
    Source: <https://earthly.dev/about/>
  - Profiles list the company founding / Vlad's start as **February 2020**.
    Source: <https://theorg.com/org/earthly-technologies/org-chart/vlad-a-ionescu>
    (states Founder & CEO "since February 2020"). Treat the exact month as
    approximate — the public launch blog post is dated April 16, 2020.

- **2020 — Adam Gordon Bell joins.** Per his own bio, Adam Gordon Bell was "Director of
  Developer Relations at Earthly Technologies (2020–2023)."
  Source: <https://adamgordonbell.com/bio/>

- **October 8, 2020 — $2M seed round announced.** "Top Dev Entrepreneurs Invest $2M in
  Earthly, Build Tooling for the Post-Container Era" (BusinessWire press release dated
  October 8, 2020).
  Source: <https://www.businesswire.com/news/home/20201008005205/en/Top-Dev-Entrepreneurs-Invest-%242M-in-Earthly-Build-Tooling-for-the-Post-Container-Era>
  - Round was **led by 468 Capital**, joined by Uncorrelated Ventures, Bessemer Venture
    Partners, Hack VC, and founders of developer platforms including Datadog, DigitalOcean,
    Cockroach Labs, Instana, Sentry.io, and Envoy Proxy.
    Sources: <https://www.finsmes.com/2020/10/earthly-raises-2m-in-seed-funding.html> ;
    <https://web.archive.org/web/2id_/https://www.vcbay.news/2020/10/11/earthly-technologies-raised-us-2m-seed-funding/>
  - **Could not verify:** Whether Docker co-founder **Solomon Hykes** personally invested
    in the 2020 seed round. He is an active developer-tools angel, but no primary source
    in this research explicitly names him as an Earthly investor.

### 2021

- **February 2, 2021 — Earthly moves to the Business Source License (BSL).** In "Every
  open-core company should be a source-available company," Earthly explains it is
  adopting the Business Source License starting with **Earthly v0.5**. Under this BSL
  configuration, the code is available for free immediately and automatically converts
  to open source (**Mozilla Public License 2.0**) after **three years**.
  Source: <https://earthly.dev/blog/every-open-core-company-should-be-a-source-available-company/>
  (post is dated February 2, 2021).

- **2021 — $6.5M Seed+ round closes (announced later, in 2023).** Earthly's later
  announcement and press confirm the **$6.5M Seed+ round actually closed in 2021** but
  was not publicly announced until February 2023. (See February 23, 2023 entry for
  details and investors.)
  Source: <https://earthly.dev/blog/new-fundings-at-earthly/> ;
  press framing of "previously unannounced" round:
  <https://techcrunch.com/2023/02/23/earthly-wants-to-reinvent-continuous-integration-to-make-it-faster-and-cheaper/>

### 2022

- **April 20, 2022 — Earthly switches from BSL to open source (MPL 2.0).** In "Earthly
  Switches to Open-source," the company announces: "Today, we are proud to announce that
  Earthly switches to an open-source license, Mozilla Public License Version 2.0." The
  post recounts that the BSL had been adopted "some time ago" to create a competitive
  moat, but that user feedback and advice from open-source CEOs convinced them to go
  fully open source.
  Source: <https://earthly.dev/blog/earthly-open-source/>
  (post is dated April 20, 2022; "Updated July 24, 2023").

### 2023

- **February 23, 2023 — $6.5M Seed+ announced; SaaS CI/CD platform unveiled.** Earthly
  publicly announces its (2021-closed) **$6.5M Seed+** round and a new SaaS CI/CD platform.
  - Round **led by Davis Treybig of Innovation Endeavors**, with participation from
    **Florian Leibert (468 Capital)** and **Salil Deshpande (Uncorrelated Ventures)**.
  - Brought **total raised to $8.6M**.
  - Investor roster cited as including founders from Cockroach Labs, DigitalOcean, Datadog,
    and creators of Docker, Elixir, and VS Code.
  Sources (company): <https://earthly.dev/blog/new-fundings-at-earthly/> ;
  (press release): <https://www.businesswire.com/news/home/20230223005033/en/With-%246.5M-in-New-Funding-Earthly-Introduces-Fast-Repeatable-Easy-to-Use-SaaS-CICD-Platform> ;
  (press): <https://techcrunch.com/2023/02/23/earthly-wants-to-reinvent-continuous-integration-to-make-it-faster-and-cheaper/> ;
  <https://siliconangle.com/2023/02/23/earthly-bags-6-5m-continuous-integration-delivery-platform/> ;
  <https://www.finsmes.com/2023/02/earthly-technologies-raises-6-5m-in-funding.html>

- **2023 — Adam Gordon Bell departs Earthly.** His bio lists his Earthly tenure as
  "2020–2023," and states he later joined Pulumi as a Community Engineer "since late 2024."
  Source: <https://adamgordonbell.com/bio/> ;
  Pulumi team page: <https://www.pulumi.com/community/team/adam-gordon-bell/>
  - Throughout, Adam Gordon Bell remained host of the **CoRecursive** podcast (launched
    January 2018). Source: <https://corecursive.com/host/> ;
    <https://adamgordonbell.com/bio/>

- **September 12, 2023 — Earthly announces it is shutting down Earthly CI.** In "We built
  the fastest CI in the world. It failed. Here's what we learned," Earthly says it shut
  down **Earthly CI on October 1, 2023**. Stated reasons: prospects perceived high
  migration cost/risk; existing users valued build *consistency* over speed; Satellite
  customers already got most CI benefits without a full migration; and "People will buy a
  developer tool, but you can't sell it." The company refocused on the **Earthly build
  tool** and **Earthly Satellites** (remote build runners that work with *any* CI).
  Source: <https://earthly.dev/blog/shutting-down-earthly-ci/>
  (post dated September 12, 2023; "Updated October 6, 2023").
  - Note: This 2023 post is about killing the bundled CI product, **not** the later
    company-wide wind-down. At this point Earthly was still pushing its build tool and
    Satellites/Cloud commercially.

### 2024

- **2024 — Pivot research underway; Lunar conceived.** Earthly's About page lists "2025
  100+ enterprise interviews conducted" and "2026 Lunar launches" — internal milestones,
  not external launch dates — while the public Lunar launch post (below) is dated April
  2025. The strategic-pivot work (user-needs study invalidating the build-tool business
  model, ~100+ enterprise interviews) spanned roughly 2024–2025.
  Source: <https://earthly.dev/about/> ;
  third-party analysis of the pivot: <https://biru.sh/en/blog/earthly-lunar-an-example-of-strategic-pivot/>
  - **Could not verify:** A specific *2024* public announcement of "Earthly Lunar." The
    research found Lunar publicly launched/announced on **April 16, 2025** (see below).
    The prompt's framing of a "2024" Lunar pivot is **not confirmed**; the verifiable
    public launch date is April 16, 2025. The pivot *direction* (away from the build
    business) was decided in this period but announced in April 2025.

### 2025

- **April 16, 2025 — The company-wide wind-down of the build business, and Earthly Lunar
  launch.** Two coordinated posts on the same date:
  1. **"A message about Earthly"** announces the phase-out of commercial build offerings.
     The company is discontinuing **Earthly Satellite commercial services** (Earthly Cloud
     Satellites, Self-Hosted Satellites, and BYOC Satellites, and their free tiers) and
     phasing out **Earthly Cloud Secrets and Logs**. **"Earthly Cloud, including
     Satellites, will stop working on July 16th, 2025."** On open source: "we will no
     longer be contributing actively to the Earthly open-source project other than
     critical bug fixes... we are no longer accepting PRs." The company supported a
     community fork effort, asking interested parties to register by **April 30, 2025**.
     Stated reasons: slow infrastructure-tech adoption, and the open-source offering
     cannibalizing the commercial product.
     Source: <https://earthly.dev/blog/shutting-down-earthfiles-cloud/>
     (post dated April 16, 2025; sunset date July 16, 2025).
  2. **"We Interviewed 100 Eng Teams... It's Chaos."** introduces **Earthly Lunar**,
     described as "a platform for monitoring engineering practices at scale. It's like
     production monitoring, except it targets everything that happens before production."
     Source: <https://earthly.dev/blog/lunar-launch/> (post dated April 16, 2025).

- **July 16, 2025 — Earthly Cloud / Satellites stop working; final OSS release.** The
  GitHub repository's latest release is **v0.8.16, released July 16, 2025** — the same
  date Earthly Cloud was sunset.
  Source: <https://github.com/earthly/earthly> (release v0.8.16, July 16, 2025).

### Current status (as of this writing, 2026)

- **Open-source build tool:** The `earthly/earthly` repo is **no longer actively
  maintained** (critical bug fixes only; not accepting PRs). It carries an explicit
  notice: "Please note that Earthly is no longer actively maintained," linking to the
  shutdown post. Licensed **MPL-2.0**, ~12,000 stars. The repo is **not marked archived**
  on GitHub but is effectively in maintenance-only/abandoned state.
  Source: <https://github.com/earthly/earthly>
  - **Could not verify:** Whether an independent community fork has taken over active
    maintenance. Earthly invited fork registrations by April 30, 2025, but this research
    did not confirm the existence or activity level of a successor fork.

- **Company / product:** Earthly Technologies pivoted the business to **Earthly Lunar**,
  now positioned as "Guardrails for the AI Era" — SDLC monitoring/governance that
  instruments existing CI/CD pipelines and repos to enforce engineering standards
  (including for AI-generated code). Earthly Technologies appears to be **operating as
  Lunar**, not defunct, but the original build-tool business is wound down.
  Source: <https://earthly.dev/> ; <https://earthly.dev/how-lunar-works/>
  - **Could not verify:** Any later (post-2025) funding for the Lunar pivot, current
    headcount, or whether the company has formally ceased operations. No source in this
    research indicates Earthly Technologies itself shut down — the *build product* did.

---

## Key people & teams

- **Vlad A. Ionescu — Founder & CEO of Earthly Technologies.** Per the company's About
  page, he has "15+ years of cloud infrastructure experience," authored Earthfiles
  ("12K GitHub stars"), and was an early core member working on **RabbitMQ** (co-author
  of the RabbitMQ Erlang client). Prior roles include engineering at **Google** (Search
  and Ads) and **VMware**, and founding **ShiftLeft / Qwiet AI** (the About page states
  Qwiet AI was "acquired by Harness").
  Sources: <https://earthly.dev/about/> ;
  <https://theorg.com/org/earthly-technologies/org-chart/vlad-a-ionescu> ;
  <https://earthly.dev/blog/introducing-earthly-build-automation-for-the-container-era/>
  - Cross-reference on ShiftLeft: a Software Engineering Daily profile/interview describes
    him as founder of Earthly with a ShiftLeft background.
    Source: <https://softwareengineeringdaily.com/2021/03/01/earthly-with-vlad-ionescu/>
  - **Note / partial verification:** The "ex-Google" and ShiftLeft (Qwiet AI) background
    is supported by the company's own About page and profiles. The exact Google tenure
    years (one search summary cited 2014–2015) come from a secondary profile aggregator
    (theorg.com) and were **not** independently confirmed against a primary source.

- **Adam Gordon Bell — Director of Developer Relations (2020–2023).** A well-known
  developer-podcaster, creator and host of the **CoRecursive** podcast (launched January
  2018). He led developer relations / content at Earthly. After Earthly he joined
  **Pulumi** (Community Engineer, "since late 2024").
  Sources: <https://adamgordonbell.com/bio/> ; <https://corecursive.com/host/> ;
  <https://earthly.dev/blog/authors/adam/> ;
  <https://www.pulumi.com/community/team/adam-gordon-bell/>

- **Could not verify:** A fuller roster of the engineering/founding team beyond Vlad
  Ionescu. The About page describes the team only as "small, focused" and does not list
  additional named members.

---

## Company & corporate history

- **Earthly Technologies** is a San Francisco–based company founded in **2020** (the
  public launch post is April 16, 2020; profiles cite a February 2020 founding) by
  **Vlad A. Ionescu** to "reinvent software build tooling for the post-container era."
  Sources: <https://earthly.dev/about/> ;
  <https://www.businesswire.com/news/home/20201008005205/en/Top-Dev-Entrepreneurs-Invest-%242M-in-Earthly-Build-Tooling-for-the-Post-Container-Era>

- **What Earthly is:** A build-automation tool centered on the **Earthfile**, whose
  syntax deliberately combines **Dockerfile** and **Makefile** concepts ("like Dockerfile
  and Makefile had a baby"). Builds are **containerized, reproducible, isolated, and
  cacheable**, and run the same way locally and in any CI system. It is built on top of
  **BuildKit** (Docker's build engine) and acts as an integration layer above
  language-specific tooling.
  Sources: <https://earthly.dev/blog/introducing-earthly-build-automation-for-the-container-era/> ;
  <https://earthly.dev/about/>
  - **Could not verify (from a single primary source in this research):** An explicit
    BuildKit citation line. BuildKit as the underlying engine is widely reported and
    consistent with Earthly's containerized-build design, but the specific source pages
    fetched here did not quote the word "BuildKit." Treat the BuildKit dependency as
    well-established but flagged for a primary citation.

- **Licensing history (verified):**
  - **Feb 2, 2021:** Adopted the **Business Source License (BSL 1.1)** starting with
    **v0.5**, with automatic conversion to **MPL 2.0 after three years**.
    Source: <https://earthly.dev/blog/every-open-core-company-should-be-a-source-available-company/>
  - **April 20, 2022:** Switched fully to open source under **Mozilla Public License 2.0
    (MPL-2.0)**, abandoning the BSL approach.
    Source: <https://earthly.dev/blog/earthly-open-source/>
  - The repo remains **MPL-2.0** today.
    Source: <https://github.com/earthly/earthly>

- **Funding history (verified):**
  - **$2M seed** — announced **Oct 8, 2020**, led by **468 Capital** (with Uncorrelated
    Ventures, Bessemer, Hack VC, and developer-platform founder angels).
    Source: <https://www.businesswire.com/news/home/20201008005205/en/...> ;
    <https://www.finsmes.com/2020/10/earthly-raises-2m-in-seed-funding.html>
  - **$6.5M Seed+** — **closed 2021**, announced **Feb 23, 2023**, led by **Innovation
    Endeavors (Davis Treybig)**, with 468 Capital (Florian Leibert) and Uncorrelated
    Ventures (Salil Deshpande). Total raised to date: **$8.6M**.
    Sources: <https://earthly.dev/blog/new-fundings-at-earthly/> ;
    <https://www.businesswire.com/news/home/20230223005033/en/...> ;
    <https://techcrunch.com/2023/02/23/earthly-wants-to-reinvent-continuous-integration-to-make-it-faster-and-cheaper/>

- **Commercial products and their fate:**
  - **Earthly CI** — launched as "the fastest CI in the world"; **shut down October 1,
    2023** after failing to find market traction (post Sept 12, 2023).
    Source: <https://earthly.dev/blog/shutting-down-earthly-ci/>
  - **Earthly Satellites / Earthly Cloud** — remote build runners + cloud; **sunset July
    16, 2025**; commercial services and free tiers phased out.
    Source: <https://earthly.dev/blog/shutting-down-earthfiles-cloud/>
  - **Open-source Earthly build tool** — active maintenance ended April 16, 2025
    (critical bug fixes only, no PRs); a community fork was invited.
    Source: <https://earthly.dev/blog/shutting-down-earthfiles-cloud/> ;
    <https://github.com/earthly/earthly>
  - **Earthly Lunar** — the pivot product; SDLC monitoring/governance "guardrails,"
    publicly launched **April 16, 2025**, later repositioned as "Guardrails for the AI Era."
    Sources: <https://earthly.dev/blog/lunar-launch/> ; <https://earthly.dev/>

- **Third-party analysis (attributed opinion):** An independent write-up frames the move
  to Lunar as a textbook **strategic pivot** — abandoning the open-source Earthfiles
  build product after failing to find a viable business model, validated by a user-needs
  study that "invalidated the initial assumptions" and surfaced a different pain point in
  the target audience. This is **analysis by the blog's author (biru.sh)**, not an Earthly
  statement.
  Source: <https://biru.sh/en/blog/earthly-lunar-an-example-of-strategic-pivot/>

---

## Summary of what could NOT be verified

1. **Solomon Hykes (Docker) as a 2020 seed investor** — not confirmed by any primary
   source found.
2. **A "2024" public launch/announcement of Earthly Lunar** — the verifiable public
   launch is **April 16, 2025**. The pivot decision/research spanned ~2024–2025, but no
   2024 public Lunar announcement was confirmed. (The prompt's "2024 Lunar pivot" framing
   is corrected to 2025 here.)
3. **Vlad Ionescu's exact Google tenure dates** (a secondary aggregator cited 2014–2015)
   — not confirmed against a primary source. His ex-Google / ShiftLeft (Qwiet AI)
   background *is* supported by Earthly's About page.
4. **Explicit BuildKit citation** — BuildKit as the underlying engine is well-established
   but was not quoted verbatim in the specific pages fetched here.
5. **Existence/activity of a community fork** taking over active maintenance of the OSS
   build tool after April 2025.
6. **Current corporate status of Earthly Technologies** beyond the Lunar pivot — no
   source indicates the *company* is defunct (it operates as Lunar); the *build business*
   is wound down. Post-2025 funding/headcount for Lunar not found.
7. **Exact founding month** — public launch April 16, 2020; profiles cite February 2020.
