# Dagger: A Sourced History

Dagger is a programmable CI/CD and automation engine founded by Docker creator
Solomon Hykes together with two longtime Docker colleagues. This document is a
chronological, fully-sourced history. Every non-trivial claim links to a
working source. Where a fact could not be confirmed from a primary or reputable
source, it is explicitly marked **"Could not verify."** Opinions and analysis
are attributed to their source.

---

## Timeline

### March 28, 2018 — Solomon Hykes leaves Docker

Solomon Hykes — who created Docker (which grew out of the PaaS company dotCloud,
later renamed Docker, Inc.) — announced he was leaving the company he founded.
He had stepped down as CTO the previous September to become chief architect and
vice chairman of the board, and framed the March 2018 departure as the "natural
moment to move on" after roughly 10 years, citing the company's need for an
enterprise-focused CTO.

- TechCrunch, "Solomon Hykes leaves Docker, the company he founded" (Mar 28, 2018): https://techcrunch.com/2018/03/28/solomon-hykes-leaves-docker-the-company-he-founded/
- The Register, "What a Docker shocker: Founder, CTO Solomon Hykes takes a hike" (Mar 28, 2018): https://www.theregister.com/2018/03/28/docker_shocker_solomon_hykes_take_a_hike/
- GeekWire, "Docker founder Solomon Hykes leaving company, cites need for enterprise-focused CTO" (2018): https://www.geekwire.com/2018/docker-co-founder-solomon-hykes-leaving-company-cites-need-enterprise-focused-cto/

### ~2018–2019 — Dagger is founded

Dagger, Inc. was founded by Solomon Hykes and two former Docker colleagues,
**Sam Alba** (former Docker VP of Engineering) and **Andrea Luzzardi** (former
Docker lead architect). The exact founding date is reported inconsistently
across sources, so it is given here as a range:

- TechCrunch's March 2022 launch coverage describes the trio as having "spent
  nearly a decade working together at Docker" and frames Dagger as a stealth
  effort that predated the public launch by several years.
  TechCrunch (Mar 30, 2022): https://techcrunch.com/2022/03/30/docker-founder-launches-dagger-a-new-devops-platform/
- InfoWorld's launch-day article states Dagger was founded "nearly three years
  ago" relative to March 2022, which points to roughly **2019**.
  InfoWorld (Mar 30, 2022): https://www.infoworld.com/article/2334699/solomon-hykes-dagger-raises-20m-and-launches-public-beta.html

**Could not verify:** A single authoritative founding date. Sources span late
2018 to 2020. The CLAUDE.md brief's "~2020" is plausible but not confirmed by a
primary source; the strongest reputable signal (InfoWorld) implies ~2019. Treat
the founding as **2018–2019**, with stealth operation until the 2022 public
launch.

### 2021 — First public prototype: a CUE frontend to BuildKit

Dagger's first public prototype (2021) was, in the company's own words,
"essentially a CUE frontend to BuildKit." Pipelines were authored in **CUE**
("Configure, Unify, Execute") and executed as DAGs by a BuildKit-based engine
running in containers.

- Dagger Blog, "Ending Support for the Dagger CUE SDK" (Dec 18, 2023) — the
  company's own retrospective on the 2021 prototype: https://dagger.io/blog/ending-cue-support/

Background on the engine lineage: **BuildKit** is the container build engine
that originated within the Docker/Moby project. It was created by **Tõnis Tiigi**
and lives under the Moby (Docker) brand; the Dagger Engine is built on top of it.

- Docker, "Tonis Tiigi" contributor page (creator of BuildKit): https://www.docker.com/contributors/tonis-tiigi/
- Changelog Ship It! #23, "A universal deployment engine with Sam Alba &
  Solomon Hykes" — Dagger founders discuss using BuildKit as the runtime: https://changelog.com/shipit/23

> Note on attribution: The CLAUDE.md brief characterizes BuildKit as "the build
> engine Hykes's team created at Docker." More precisely, BuildKit was created by
> Tõnis Tiigi at Docker; Hykes and Luzzardi were senior Docker
> engineers/leadership during that era, and Dagger builds *on* BuildKit. The
> claim that BuildKit was authored specifically by "Hykes's team" **could not be
> verified** as stated; the verifiable fact is that BuildKit came out of
> Docker/Moby and Dagger's engine is BuildKit-based.

### March 30, 2022 — Dagger comes out of stealth, public beta + $20M Series A

Dagger launched publicly into beta on March 30, 2022, simultaneously announcing
a **$20 million Series A led by Redpoint Ventures**. At launch, pipelines were
written declaratively in **CUE**, and Hykes described the vision as a "DevOps
operating system."

Funding history disclosed at launch:
- **Pre-seed: $3M**, **Seed: $7M led by New Wave** (TechCrunch reports the two
  prior rounds; the Dagger blog and InfoWorld emphasize the $7M seed led by New
  Wave). Total raised by launch: **~$30M**.
- **Series A: $20M led by Redpoint Ventures.** Additional named investors:
  Y Combinator, Nat Friedman (former GitHub CEO), Brian Stevens (former Google
  Cloud / Red Hat CTO), Idit Levine (solo.io founder/CEO), Julius Volz
  (Prometheus creator), Ellen Pao (former Reddit CEO), and Daniel Lopez
  (Bitnami co-founder).

Sources:
- Dagger Blog, "Announcing our $20M Series A from Redpoint Ventures" (Mar 30, 2022): https://dagger.io/blog/series-a/
- Dagger Blog, "Introducing Dagger: a new way to create CI/CD pipelines" (Mar 30, 2022): https://dagger.io/blog/public-launch-announcement
- TechCrunch, "Docker founder Solomon Hykes launches Dagger" (Mar 30, 2022): https://techcrunch.com/2022/03/30/docker-founder-launches-dagger-a-new-devops-platform/
- InfoWorld, "Solomon Hykes' Dagger raises $20M and launches public beta" (Mar 30, 2022): https://www.infoworld.com/article/2334699/solomon-hykes-dagger-raises-20m-and-launches-public-beta.html
- PR Newswire, "Dagger launches devops operating system with $20M Series A led by Redpoint Ventures" (Mar 30, 2022): https://www.prnewswire.com/news-releases/dagger-launches-devops-operating-system-with-20m-series-a-led-by-redpoint-ventures-301513656.html

> Attributed quote (Hykes, via InfoWorld): "Solving this problem is the holy
> grail of devops, and we believe we have solved it." Hykes also told The New
> Stack / TechCrunch the goal was a real software-development experience for
> pipelines rather than YAML/shell scripts.

**Could not verify:** Exact dates of the pre-seed and seed rounds. They are
reported as having preceded the March 2022 Series A, but no source pins them to
a specific month/year.

### 2022 — The CUE → SDK pivot begins (GraphQL engine + language SDKs)

After launch, Dagger reworked its core: it introduced a **GraphQL-powered
engine** and shipped native **language SDKs (Go, Python, Node.js/TypeScript)**
so engineers could write pipelines in languages they already knew, rather than
learning CUE. The SDKs don't execute pipelines themselves; they send pipeline
definitions to the Dagger GraphQL API, which drives the BuildKit-based Engine.
This is the pivotal architectural shift in Dagger's history — from a
CUE-configured tool to an **engine + API + multi-language SDK** model.

- Dagger Blog, "Develop your pipelines as code with the Dagger Python SDK": https://dagger.io/blog/python-sdk
- Dagger docs, "Using Dagger SDKs": https://docs.dagger.io/getting-started/api/sdk/
- Dagger Blog, "Ending Support for the Dagger CUE SDK" (the retrospective that
  documents the 2021→2022 pivot): https://dagger.io/blog/ending-cue-support/

> Company's stated rationale (Dagger blog): "engineers are tired of building
> CI/CD pipelines with shell scripts and YAML, what they really want is to write
> code in a language they already know."

### September 26, 2023 — Dagger Cloud: first commercial product (Early Access)

Dagger announced **Early Access to Dagger Cloud**, its first commercial product:
a centralized control plane that complements the open-source, decentralized
Dagger Engine. It provides Pipeline Visualization, Operational Insights, and
Distributed Caching, and runs on a "bring your own compute" model.

- Dagger Blog, "Dagger Cloud Early Access" (Sep 26, 2023): https://dagger.io/blog/dagger-cloud
- Dagger Cloud product page: https://dagger.io/cloud/

### December 14, 2023 — CUE SDK support officially discontinued

Having grown Go/Python/Node adoption, Dagger formally ended support for the
original CUE SDK on **December 14, 2023**, completing the pivot away from CUE as
the authoring language. The announcement post was published **December 18, 2023**.

- Dagger Blog, "Ending Support for the Dagger CUE SDK" (Dec 18, 2023): https://dagger.io/blog/ending-cue-support/
- GitHub discussion, "CUE SDK - Current state + potential futures" (dagger/dagger #4086): https://github.com/dagger/dagger/discussions/4086

### April 23, 2025 — The AI/agents pivot: the LLM primitive

Dagger repositioned toward AI/LLM agent workflows. On **April 23, 2025** it
announced a native **`LLM` primitive** in the Dagger Engine: LLMs become
programmable building blocks that can be chained with containers, Git repos, and
other Dagger objects. Crucially, any Dagger object added to an environment
automatically exposes its **Dagger Functions as tools** the LLM can call,
running inside a containerized sandbox — turning Dagger into an **agent runtime**
for building autonomous, containerized AI workflows. Supported providers include
OpenAI, Anthropic, Google, and Ollama.

- Dagger Blog, "Agents in your Software Factory: Introducing the LLM Primitive in Dagger" (Apr 23, 2025): https://dagger.io/blog/llm/
- Dagger docs, "LLM Integration": https://docs.dagger.io/features/llm/
- The New Stack, "AI Dev Tools: How To Containerize Agents Using Dagger": https://thenewstack.io/ai-dev-tools-how-to-containerize-agents-using-dagger/

> Company framing (Dagger blog): Dagger "lets you treat LLMs as programmable
> primitives that could be chained with other software primitives to build
> powerful, autonomous, and containerized workflows."

### June 14, 2025 — Container Use released

Dagger released **Container Use** (`container-use` / CLI `cu`), an open-source
**MCP (Model Context Protocol) server** that gives each AI coding agent its own
isolated, containerized development environment backed by a dedicated Git branch.
This lets multiple coding agents (e.g., Claude Code, Cursor, other MCP-compatible
agents) run in parallel on the same codebase without conflicting, with real-time
visibility (`cu watch`) and the ability to drop into an agent's terminal
(`cu terminal`). The project was described as early-stage at release.

- Dagger Blog, "Containing Agent Chaos: Run Coding Agents in Parallel without Destroying Everything" (Jun 14, 2025): https://dagger.io/blog/agent-container-use/
- GitHub, dagger/container-use: https://github.com/dagger/container-use
- InfoQ, "Container Use: a New Tool for Isolated, Parallel Coding Agents" (Aug 2025): https://www.infoq.com/news/2025/08/container-use/

### Current status (as of 2026)

- The **Dagger Engine and SDKs remain open source under Apache-2.0**. The
  dagger/dagger README describes Dagger as "a platform for automating software
  delivery" that "runs locally, in your CI server, or directly in the cloud,"
  with **native SDKs for Go, Python, TypeScript, PHP, Java, .NET, Elixir, and
  Rust**.
  GitHub, dagger/dagger: https://github.com/dagger/dagger
- **Dagger Cloud** remains the commercial offering (observability / control
  plane for delivery workflows), with updated pricing (free for individuals,
  flat-rate team plans).
  Dagger Blog, "New Dagger Cloud Pricing": https://dagger.io/blog/new-dagger-cloud-pricing/
  Dagger Cloud: https://dagger.io/cloud/
- Hykes has continued promoting an **"agentic CI/CD" / AI-native software
  factory** direction in 2025–2026 talks and podcasts.
  Agentic DevOps, "Agentic CI/CD with Solomon Hykes of Dagger": https://agenticdevops.fm/episodes/agentic-ci-cd-with-solomon-hykes-of-dagger
  Heavybit Open Source Ready #17, "AI Native Software Factories with Solomon Hykes": https://www.heavybit.com/library/podcasts/open-source-ready/ep-17-ai-native-software-factories-with-solomon-hykes

**Could not verify:** Any funding round after the March 2022 Series A. No
reputable source was found announcing a Series B or later raise; Tracxn/Crunchbase
aggregators list total funding around ~$30M, consistent with no major round since
2022. If a later round exists, it was not confirmed here.

---

## Key people & teams

- **Solomon Hykes** — Co-founder & CEO of Dagger. Creator of Docker (built out of
  dotCloud → Docker, Inc.); left Docker in March 2018. The public face and
  primary spokesperson for Dagger.
  TechCrunch (2018 departure): https://techcrunch.com/2018/03/28/solomon-hykes-leaves-docker-the-company-he-founded/
  Open Source Underdogs Ep. 68, "Solomon Hykes, Co-Founder / CEO Dagger": https://opensourceunderdogs.com/episode-68-solomon-hykes-co-founder-ceo-dagger/

- **Sam Alba (Samuel Alba)** — Co-founder of Dagger. Former **VP of Engineering
  at Docker**; longtime early Docker employee. Frequent co-presenter on Dagger
  company culture and engineering.
  TechCrunch (2022): https://techcrunch.com/2022/03/30/docker-founder-launches-dagger-a-new-devops-platform/
  Developing Leadership Ep. 13 (with Sam Alba): https://www.developingleadership.co/episode/episode-13-building-a-company-culture-that-makes-sense-with-sam-alba-from-dagger

- **Andrea Luzzardi** — Co-founder of Dagger. Former **lead architect at Docker**;
  credited as one of the earliest Docker engineers.
  TechCrunch (2022): https://techcrunch.com/2022/03/30/docker-founder-launches-dagger-a-new-devops-platform/

- **Tõnis Tiigi** (context, not a Dagger founder) — Creator of **BuildKit** at
  Docker/Moby, the engine technology the Dagger Engine is built on.
  Docker contributor page: https://www.docker.com/contributors/tonis-tiigi/

> Gossip/unverified-adjacent note: Web aggregators (Y Combinator, Blaxel blog)
> indicate that Sam Alba and Andrea Luzzardi later co-founded a separate venture,
> **Mendral** ("AI DevOps engineer"). This is reported by startup directories and
> a vendor blog rather than a primary Dagger or major-press source, so treat it
> as **unverified by a primary source**. If relevant, verify directly.
> Y Combinator (Mendral): https://www.ycombinator.com/companies/mendral

---

## Company & corporate history

- **Entity:** Dagger, Inc. Founded by Solomon Hykes, Sam Alba, and Andrea
  Luzzardi — all formerly of Docker. Founding date best dated to **2018–2019**
  (sources disagree; InfoWorld implies ~2019; the brief's "~2020" is unconfirmed).
  Operated in stealth until the March 2022 public launch.
  InfoWorld (2022): https://www.infoworld.com/article/2334699/solomon-hykes-dagger-raises-20m-and-launches-public-beta.html

- **Funding (verified):**
  - Pre-seed **$3M** and seed **$7M (led by New Wave)** — disclosed at the 2022
    launch; exact dates not sourced.
  - **Series A: $20M led by Redpoint Ventures**, March 30, 2022 (with YC, Nat
    Friedman, Brian Stevens, Idit Levine, Julius Volz, Ellen Pao, Daniel Lopez).
  - Total ~**$30M**. No later round verified.
  Dagger Blog (Series A): https://dagger.io/blog/series-a/
  PR Newswire: https://www.prnewswire.com/news-releases/dagger-launches-devops-operating-system-with-20m-series-a-led-by-redpoint-ventures-301513656.html

- **Product/strategy arc:**
  1. CUE-frontend-to-BuildKit prototype (2021) →
  2. GraphQL engine + Go/Python/Node SDKs (2022) →
  3. Dagger Cloud commercial control plane, Early Access (Sep 2023) →
  4. CUE SDK discontinued (Dec 2023) →
  5. AI/agents pivot: LLM primitive (Apr 2025) and Container Use (Jun 2025).

- **Licensing/OSS:** The Dagger Engine and language SDKs are **Apache-2.0**
  open source; **Dagger Cloud** is the commercial product. This open-core split
  remains current.
  GitHub, dagger/dagger (Apache-2.0): https://github.com/dagger/dagger
  Dagger Cloud: https://dagger.io/cloud/

---

## Summary of what could NOT be verified

1. **Exact founding date** of Dagger, Inc. Sources range from late 2018 to 2020;
   InfoWorld's "nearly three years ago" (from Mar 2022) implies ~2019. The
   brief's "~2020" is not confirmed by a primary source.
2. **Dates of the pre-seed ($3M) and seed ($7M, New Wave) rounds** — disclosed
   only retroactively at the 2022 launch.
3. **BuildKit authorship attribution.** BuildKit was created by Tõnis Tiigi at
   Docker/Moby; the claim that it was built by "Hykes's team" specifically is not
   supported. Verifiable: Dagger's engine is BuildKit-based and BuildKit came out
   of Docker.
4. **Any funding round after the March 2022 Series A** (e.g., a Series B). None
   found; aggregator totals (~$30M) are consistent with no later major raise.
5. **Mendral** (the reported later venture of Alba and Luzzardi) — sourced only
   to startup directories / a vendor blog, not a primary or major-press source.
