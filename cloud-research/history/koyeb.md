# Koyeb — A Sourced History

A chronological, sourced history of **Koyeb**, the Paris-based "deploy anywhere"
serverless platform that runs applications, APIs, and AI inference workloads as
**Firecracker microVMs on bare-metal servers**, founded by ex-Scaleway engineers
and **acquired by Mistral AI in February 2026**.

Every non-trivial claim below links to a working source. Primary sources (Koyeb's
own blog and funding announcements, founders' statements) are preferred, with
reputable outlets (TechCrunch, SiliconANGLE, InfoWorld) as corroboration. Items
that could not be confirmed, or where sources conflict, are flagged with
**"Could not verify."** This is a comparatively small company; sourcing is
thinner than for the larger PaaS/cloud histories in this corpus, and gaps are
flagged rather than padded.

> **Cross-references (not duplicated here):**
> - Firecracker as a microVM isolation primitive, and the broader
>   microVM-for-AI-agents landscape, are covered in `history/fly-io.md` and
>   `history/WASM_DOCKER_alternate_history.md`. Koyeb is, like Fly.io, a
>   *consumer* of AWS's Firecracker rather than its author.
> - Heroku's `git push` deploy model and end-of-free-tier migration wave (which
>   Koyeb, like Fly.io and Render, positioned against) are in `history/heroku.md`.

---

## Timeline

### 2020 — Founding in Paris

- **2020 — Koyeb founded in Paris by three ex-Scaleway engineers.** TechCrunch's
  first coverage (July 7, 2020) describes Koyeb as "a serverless startup that
  helps you manipulate data in different ways without worrying about your server
  infrastructure," founded by **Yann Léger, Édouard Bonlieu, and Bastien
  Chatelard**, who "have previously worked at Scaleway for many years."
  - Source: [Koyeb is a serverless startup that ingests, processes and stores data from multiple cloud providers — TechCrunch (July 7, 2020)](https://techcrunch.com/2020/07/07/koyeb-is-a-serverless-startup-that-ingests-processes-and-stores-data-from-multiple-cloud-providers/)
  - The "founded in 2020 by three former employees of French cloud provider
    Scaleway" framing is repeated in the February 2026 acquisition coverage.
    - Source: [Mistral AI buys Koyeb in first acquisition to back its cloud ambitions — TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)
  - **Conflict on the founding year — flagged.** Koyeb's own About page and its
    acquisition blog post say the company was "founded in 2021," while TechCrunch
    (2020 and 2026), SiliconANGLE, and the seed-round coverage say **2020** /
    "established in Paris in 2020." Most likely the company was incorporated/
    operating from 2020 (first TC coverage is July 2020) with 2021 used loosely
    elsewhere. **Could not verify** the exact incorporation date; this doc uses
    2020 as the year of first public existence and flags the 2021 figure.
    - Source (Koyeb "founded in 2021"): [About — Koyeb](https://www.koyeb.com/about)
    - Source (2020): [French serverless platform startup Koyeb raises $7M — SiliconANGLE (Nov 2, 2023)](https://siliconangle.com/2023/11/02/french-serverless-platform-startup-koyeb-raises-7m/)

- **Founders' backgrounds — the Scaleway / iliad heritage.** All three founders
  came from **Scaleway**, the cloud arm of French telecom group **iliad / Free**
  (the Xavier Niel–controlled group). Léger's profile lists senior Scaleway roles
  (Managing Director and Vice President) and prior core-engineering work at Free /
  Groupe iliad; the founders themselves describe "10 years building and operating
  large-scale cloud platforms."
  - Source (founders' "10 years building... large-scale cloud platforms"): [About — Koyeb](https://www.koyeb.com/about)
  - Source (Léger's Scaleway VP/MD background): [Yann Léger — Co-Founder and CEO @ Koyeb — Crunchbase](https://www.crunchbase.com/person/yann-l%C3%A9ger)
  - **Could not verify** the exact titles/dates of each founder's Scaleway tenure
    against a first-party Scaleway or Koyeb source; the Scaleway heritage itself
    is confirmed by TechCrunch (2020 and 2026) and is repeated across coverage.

- **Original product — multi-cloud serverless data workflows.** The 2020 product
  was not yet the container PaaS Koyeb became. As first described, it offered
  "dozens of integrations with data sources... and ready-to-use processing APIs"
  for chaining cloud services (e.g., importing video, re-encoding, re-uploading;
  or pulling data, running it through another provider's speech-to-text, storing
  the result), configurable via web UI, CLI, or API, with automatic scaling and
  billing that stopped when a workflow completed. Docker-container and custom-
  function support were stated as *future* plans at that time.
  - Source: [TechCrunch (July 7, 2020)](https://techcrunch.com/2020/07/07/koyeb-is-a-serverless-startup-that-ingests-processes-and-stores-data-from-multiple-cloud-providers/)

- **October 15, 2020 — €1.4M pre-seed.** Koyeb announced a **€1.4M pre-seed**
  round. The investor list is notably angel-heavy and cloud-pedigreed, including
  **ISAI**, **Xavier Niel's Kima Ventures**, **Zachary Smith** (co-founder of
  bare-metal cloud **Packet**), **Alexis Lê-Quôc** (Datadog co-founder), Index
  Ventures' Dominique Vidal, Theodo's Fabrice Bernhard, and Plug and Play
  Ventures, with French public-investment partners BPI and Wilco.
  - Source: [Koyeb raises €1.4M pre-seed to support your serverless journey — Koyeb Blog (Oct 15, 2020)](https://www.koyeb.com/blog/koyeb-raises-eur-1-4m-pre-seed-to-support-your-serverless-journey)

### 2022 — The serverless platform public preview (the pivot to containers)

- **May 17, 2022 — Koyeb serverless platform enters public preview.** Koyeb
  opened its rebuilt platform to all developers, reporting it had already drawn
  "over 10,000 developers" and 3,000+ applications during private preview. This
  is the version that matches Koyeb's mature identity: a Git-driven and
  container-driven PaaS, not the 2020 data-workflow tool.
  - Source: [Koyeb Serverless Platform Public Preview — Koyeb Blog (May 17, 2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview)
  - **Stated architecture:** **Firecracker microVMs running on bare-metal
    servers** (for "the security and performance" of VMs at container-like
    density), a serverless **Nomad**-based engine, and a global edge network
    described as "over 250 locations" for traffic acceleration, with plans to
    expand to "10 global core locations by year-end." Features included
    **`git push`-style Git-driven deploys**, container deployment from any
    registry, native TLS/custom domains, built-in load-balancing and horizontal
    scaling, and a service mesh.
    - Source: [Koyeb Serverless Platform Public Preview — Koyeb Blog (May 17, 2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview)
  - **Scale-to-zero was a roadmap item, not yet shipped.** At public preview,
    Koyeb explicitly listed "autoscaling," "scale-to-zero," and "native worker
    support" as committed-but-not-yet-available features. (Scale-to-zero recurs
    as a stated focus area in later GPU posts below.)
    - Source: [Koyeb Serverless Platform Public Preview — Koyeb Blog (May 17, 2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview)

### 2023 — The $7M seed

- **November 2, 2023 — Seed round: $7M, led by Serena.** Koyeb raised **$7M in
  seed funding** led by **Serena** (partners Bertrand Diard and Floriane de
  Maupeou), with participation from **ISAI**, **Samsung Next**, and **MongoDB**,
  plus angels including Datadog's Alexis Lê-Quôc, Snyk's Udi Nachmany, and
  Packet's Zachary Smith.
  - Source (primary): [We raised $7M to Simplify App Deployment with our Global Serverless Platform — Koyeb Blog (Nov 2, 2023)](https://www.koyeb.com/blog/we-raised-7m-to-simplify-app-deployment-with-our-global-serverless-platform)
  - Source (press): [French serverless platform startup Koyeb raises $7M — SiliconANGLE (Nov 2, 2023)](https://siliconangle.com/2023/11/02/french-serverless-platform-startup-koyeb-raises-7m/)
  - Léger's framing: "We provide an easy way to deploy full-stack applications
    and databases in production, everywhere, in minutes."
    - Source: [SiliconANGLE (Nov 2, 2023)](https://siliconangle.com/2023/11/02/french-serverless-platform-startup-koyeb-raises-7m/)
  - The seed post also describes Koyeb's stack as "Dockerfile deployment on
    high-performance microvms," built on "Nomad, Firecracker and Kuma" — i.e.,
    Koyeb migrated its workload-scheduling layer **off Kubernetes** onto a
    custom Nomad + Firecracker + Kuma stack.
    - Source: [We raised $7M... — Koyeb Blog (Nov 2, 2023)](https://www.koyeb.com/blog/we-raised-7m-to-simplify-app-deployment-with-our-global-serverless-platform)
  - **Total raised.** Secondary funding trackers put Koyeb's total raised across
    the pre-seed and seed at roughly **$8.6M**. **Could not verify** this total
    against a first-party Koyeb statement; the two individual rounds (€1.4M
    pre-seed, $7M seed) are each primary-sourced above.

### 2024–2025 — Serverless GPUs and the AI-inference pivot

- **June 18, 2024 — Serverless GPUs in public preview.** Koyeb launched
  **serverless GPUs** for AI workloads, offering **H100, A100, L40S, L4, and RTX
  4000 SFF ADA** cards (20GB–80GB vRAM), "always billed by the second" at "prices
  ranging from $0.50/hr to $3.30/hr," targeting "training, fine-tuning, and
  inference workloads" and "generative AI processes including large language
  models, recommendation models, and video and image generation." Autoscaling
  was offered on requests/sec, concurrent connections, P95 latency, and CPU/memory.
  - Source: [Serverless GPUs Public Preview: Run AI workloads on H100, A100, L40S, and more — Koyeb Blog (June 18, 2024)](https://www.koyeb.com/blog/serverless-gpus-public-preview-run-ai-workloads-on-h100-a100-l40s-and-more)
  - **Scale-to-zero for GPUs was still forthcoming at this launch:** the post
    names enabling "scale-to-zero" for GPUs as "a key focus... in the coming
    weeks," offering manual GPU-instance pausing in the interim.
    - Source: [Serverless GPUs Public Preview — Koyeb Blog (June 18, 2024)](https://www.koyeb.com/blog/serverless-gpus-public-preview-run-ai-workloads-on-h100-a100-l40s-and-more)

- **November 19, 2025 — Koyeb Sandboxes (AI-agent isolation).** Koyeb announced
  **Koyeb Sandboxes** in public preview — "a new way to effortlessly spin up
  fully isolated, secure environments to safely execute AI-generated and
  untrusted code at scale," with Python and JavaScript SDKs, multi-region CPU/GPU
  support, and per-second pricing from **$0.000001/second ($0.0036/hr)**. This is
  Koyeb's entry into the AI-agent sandbox space (the same Firecracker-microVM
  isolation use case discussed for Fly.io and e2b in this corpus).
  - Source: [Koyeb Sandboxes: Fast, Scalable, Fully Isolated Environments for AI Agents and More — Koyeb Blog (Nov 19, 2025)](https://www.koyeb.com/blog/koyeb-sandboxes-fast-scalable-fully-isolated-environments-for-ai-agents)

### February 2026 — Acquisition by Mistral AI

- **February 17, 2026 — Mistral AI acquires Koyeb (Mistral's first acquisition).**
  Koyeb announced it had "entered into a definitive agreement to join Mistral AI."
  This was **Mistral AI's first-ever acquisition**, made to accelerate **Mistral
  Compute**, the AI-cloud infrastructure offering Mistral had announced in mid-2025.
  All three founders — **Yann Léger, Édouard Bonlieu, and Bastien Chatelard** —
  joined Mistral's engineering team.
  - Source (primary, Koyeb): [Koyeb is Joining Mistral AI to Build the Future of AI Infrastructure — Koyeb Blog (Feb 17, 2026)](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure)
  - Source (press): [TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)
  - Source (analyst context): [Mistral AI deepens compute ambitions with Koyeb acquisition — InfoWorld](https://www.infoworld.com/article/4133757/mistral-ai-deepens-compute-ambitions-with-koyeb-acquisition.html)
  - **Terms:** undisclosed. "Mistral did not reveal financial terms."
    - Source: [TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)
  - **Scale at acquisition:** TechCrunch reports Koyeb had **13 employees**;
    Koyeb's own post says the platform ran "tens of thousands of applications
    across bare metal servers in 10 worldwide locations."
    - Sources: [TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/); [Koyeb Blog (Feb 17, 2026)](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure)
  - **Continuity:** Koyeb said its platform "will continue operating" without
    disruption, with no changes for Pro/Scale/Enterprise customers, and would
    "transition to become a core component of Mistral Compute," doubling down on
    **Inference, Sandboxes, and serverless capabilities for MCP Servers**.
    - Source: [Koyeb Blog (Feb 17, 2026)](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure)
  - **Mistral CTO Timothée Lacroix** (per TechCrunch): "Koyeb's product and
    expertise will accelerate our development on the Compute front, and contribute
    to building a true AI cloud."
    - Source: [TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)

---

## Technology (Firecracker microVMs / Nomad / bare metal)

Sourced primarily to Koyeb's own platform-preview and seed-round posts.

- **Compute = Firecracker microVMs on bare metal.** Koyeb runs workloads in
  **Firecracker microVMs** on its own **bare-metal servers**, citing VM-grade
  isolation/security at container-like density/latency. Like Fly.io, Koyeb is a
  *consumer* of AWS's open-source Firecracker, not its author.
  - Source: [Koyeb Serverless Platform Public Preview — Koyeb Blog (May 17, 2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview)

- **Scheduler: Kubernetes → Nomad + Firecracker + Kuma.** Koyeb's seed post
  describes its engine as built on "Nomad, Firecracker and Kuma," and coverage
  describes a deliberate move **off Kubernetes** to this custom stack for the
  serverless control plane and service mesh (Kuma).
  - Source: [We raised $7M... — Koyeb Blog (Nov 2, 2023)](https://www.koyeb.com/blog/we-raised-7m-to-simplify-app-deployment-with-our-global-serverless-platform)

- **Deploy model = Git-driven + container/Dockerfile.** `git push`-style deploys
  and container/Dockerfile deployment from any registry, with built-in
  load-balancing, horizontal autoscaling, and (later) scale-to-zero.
  - Source: [Koyeb Serverless Platform Public Preview — Koyeb Blog (May 17, 2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview)

- **Global positioning.** Koyeb positions as a "deploy anywhere"/global serverless
  platform; at acquisition it reported bare-metal servers in **10 worldwide
  locations** (down-to-earth from the "over 250 [edge] locations" traffic-
  acceleration figure cited in 2022, which referred to the edge network rather
  than compute regions).
  - Sources: [Koyeb Serverless Platform Public Preview (2022)](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview); [Koyeb Blog (Feb 17, 2026)](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure)

- **GPU / AI inference.** From June 2024, Koyeb added serverless GPUs (H100/A100/
  L40S/L4/RTX 4000), billed per second, for inference, fine-tuning, and small-
  scale training — the basis of its later AI-cloud positioning and the strategic
  rationale Mistral cited.
  - Source: [Serverless GPUs Public Preview — Koyeb Blog (June 18, 2024)](https://www.koyeb.com/blog/serverless-gpus-public-preview-run-ai-workloads-on-h100-a100-l40s-and-more)

---

## Key people & teams

- **Yann Léger** — co-founder and **CEO**. Ex-**Scaleway** (senior roles incl.
  Managing Director / Vice President per his profile) and prior engineering work
  at **Free / Groupe iliad**. Joined Mistral AI's engineering team in Feb 2026.
  - Sources: [Crunchbase — Yann Léger](https://www.crunchbase.com/person/yann-l%C3%A9ger); [About — Koyeb](https://www.koyeb.com/about); [TechCrunch (Feb 17, 2026)](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)
  - **Could not verify** the precise titles/dates of Léger's Scaleway tenure
    against a first-party source (his senior-Scaleway background is corroborated;
    the specific MD/VP date ranges come from secondary profile aggregators).

- **Édouard Bonlieu** — co-founder; listed as **CPO** (Chief Product Officer) on
  Koyeb's About page. Ex-Scaleway. Joined Mistral AI (Feb 2026).
  - Sources: [About — Koyeb](https://www.koyeb.com/about); [Koyeb Blog (Feb 17, 2026)](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure)

- **Bastien Chatelard** — co-founder; listed as **CTO** on Koyeb's About page.
  Ex-Scaleway. Joined Mistral AI (Feb 2026). (Chatelard is named as the third
  co-founder by TechCrunch in 2020, alongside Léger and Bonlieu.)
  - Sources: [About — Koyeb](https://www.koyeb.com/about); [TechCrunch (July 7, 2020)](https://techcrunch.com/2020/07/07/koyeb-is-a-serverless-startup-that-ingests-processes-and-stores-data-from-multiple-cloud-providers/)
  - **Note:** The 2020 TechCrunch piece names three co-founders (Léger, Bonlieu,
    Chatelard). The Oct 2020 pre-seed post refers to "a team of three cloud
    veterans" but only bylines Léger. The three-founder roster (with CPO/CTO/CEO
    titles) is confirmed by the About page and the 2023 + 2026 coverage.

---

## Company & corporate history

- **2020** — Founded in **Paris** by three ex-Scaleway engineers (Léger, Bonlieu,
  Chatelard); first product was a multi-cloud serverless data-workflow tool.
  ([TechCrunch, July 7, 2020](https://techcrunch.com/2020/07/07/koyeb-is-a-serverless-startup-that-ingests-processes-and-stores-data-from-multiple-cloud-providers/))
  *(Koyeb's own pages say "2021"; conflict flagged above.)*
- **October 15, 2020** — **€1.4M pre-seed** (ISAI, Kima Ventures/Xavier Niel,
  Zachary Smith, Alexis Lê-Quôc, others).
  ([Koyeb Blog](https://www.koyeb.com/blog/koyeb-raises-eur-1-4m-pre-seed-to-support-your-serverless-journey))
- **May 17, 2022** — Serverless platform (Firecracker microVMs on bare metal,
  Nomad engine, Git-driven deploys) enters **public preview**.
  ([Koyeb Blog](https://www.koyeb.com/blog/koyeb-serverless-platform-public-preview))
- **November 2, 2023** — **$7M seed**, led by **Serena** (ISAI, Samsung Next,
  MongoDB participating); total raised ≈ $8.6M (secondary).
  ([Koyeb Blog](https://www.koyeb.com/blog/we-raised-7m-to-simplify-app-deployment-with-our-global-serverless-platform) ·
  [SiliconANGLE](https://siliconangle.com/2023/11/02/french-serverless-platform-startup-koyeb-raises-7m/))
- **June 18, 2024** — **Serverless GPUs** (H100/A100/L40S/L4/RTX 4000) launch.
  ([Koyeb Blog](https://www.koyeb.com/blog/serverless-gpus-public-preview-run-ai-workloads-on-h100-a100-l40s-and-more))
- **November 19, 2025** — **Koyeb Sandboxes** (AI-agent isolated environments).
  ([Koyeb Blog](https://www.koyeb.com/blog/koyeb-sandboxes-fast-scalable-fully-isolated-environments-for-ai-agents))
- **February 17, 2026** — **Acquired by Mistral AI** (Mistral's first acquisition;
  ~13 employees; terms undisclosed) to power **Mistral Compute**.
  ([Koyeb Blog](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure) ·
  [TechCrunch](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/))

### Funding (verified figures)

| Round | Date | Amount | Lead | Notes |
|---|---|---|---|---|
| Pre-seed | Oct 15, 2020 | €1.4M | ISAI (+ angels) | Kima/Xavier Niel, Z. Smith, A. Lê-Quôc, Index's D. Vidal ([Koyeb](https://www.koyeb.com/blog/koyeb-raises-eur-1-4m-pre-seed-to-support-your-serverless-journey)) |
| Seed | Nov 2, 2023 | $7M | Serena | ISAI, Samsung Next, MongoDB participating ([Koyeb](https://www.koyeb.com/blog/we-raised-7m-to-simplify-app-deployment-with-our-global-serverless-platform), [SiliconANGLE](https://siliconangle.com/2023/11/02/french-serverless-platform-startup-koyeb-raises-7m/)) |
| Acquisition | Feb 17, 2026 | undisclosed | (acquired by Mistral AI) | Mistral's first acquisition; ~13 staff ([Koyeb](https://www.koyeb.com/blog/koyeb-is-joining-mistral-ai-to-build-the-future-of-ai-infrastructure), [TechCrunch](https://techcrunch.com/2026/02/17/mistral-ai-buys-koyeb-in-first-acquisition-to-back-its-cloud-ambitions/)) |

---

## Controversies & characterizations

> Koyeb is a small company and generated comparatively little controversy. The
> one notable *characterization* concerns the framing of its acquisition.

- **The Mistral deal as a "bargain acquihire" (reported analysis, not fact).**
  At least one trade outlet framed the undisclosed-terms Mistral acquisition as a
  **"bargain acquihire"** — i.e., a deal motivated more by acquiring the ~13-person
  team than by a large cash exit — noting it as Mistral's first M&A and the union
  of two Paris-based ("hometown favorite") startups. This is **opinion/analysis**,
  attributed to the outlet; the deal's actual price was not disclosed, so the
  "bargain" framing cannot be independently confirmed.
  - Source (analysis, partly paywalled): [Breaking Down Mistral AI's Bargain Acquihire of Koyeb — French Tech Journal](https://www.frenchtechjournal.com/breaking-down-mistral-ais-bargain-acquihire-of-koyeb/)
  - **Could not verify** any acquisition price; **could not verify** the
    "acquihire" characterization beyond the cited outlet's framing.

- **Sovereign-AI framing (reported).** Analysts (per InfoWorld) framed the deal in
  terms of Mistral's "European roots" and "sovereign AI" positioning rather than
  any Koyeb-specific controversy. This is analyst commentary, attributed to the
  cited sources.
  - Source: [InfoWorld — Mistral AI deepens compute ambitions with Koyeb acquisition](https://www.infoworld.com/article/4133757/mistral-ai-deepens-compute-ambitions-with-koyeb-acquisition.html)

---

## Items marked "Could not verify"

- **Exact founding/incorporation date.** Koyeb's own pages say "2021"; TechCrunch
  (2020 & 2026), SiliconANGLE, and the seed coverage say 2020. First public
  evidence is July 2020. The discrepancy is flagged; an authoritative incorporation
  date was not located.
- **Each founder's precise Scaleway titles/dates.** The Scaleway heritage of all
  three founders is confirmed; the specific MD/VP date ranges for Léger come from
  secondary profile aggregators, not a first-party source.
- **Total funding raised (~$8.6M).** Secondary trackers only; the two individual
  rounds (€1.4M, $7M) are each primary-sourced.
- **Acquisition price / "acquihire" framing.** Terms were undisclosed by Mistral;
  the "bargain acquihire" label is one outlet's analysis.
- **Whether scale-to-zero ever reached GA across all instance types.** It was a
  roadmap item in 2022 and a "coming weeks" GPU focus in June 2024; a single dated
  GA announcement was not located in this pass.
- **The "250+ edge locations" vs "10 compute locations" figures.** Both appear in
  Koyeb's own posts at different dates and refer to different things (edge traffic
  acceleration vs. bare-metal compute regions); reconciled here by context, not by
  a single source stating both.
