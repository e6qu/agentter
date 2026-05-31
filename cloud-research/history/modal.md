# Modal (Modal Labs) — A Sourced History

A chronological, fully-sourced history of **Modal** (legal entity **Modal Labs**) —
the **serverless, Python-first cloud compute platform** for AI/ML and data
workloads, where a developer attaches a decorator to an ordinary Python function
and Modal runs it (including on GPUs) in the cloud on a custom container stack
engineered for **sub-second cold starts**.

Every non-trivial claim below carries a working source link. Primary sources
(Modal's blog/press, founder **Erik Bernhardsson's** own writing and the
co-founders' posts, funding announcements) are preferred, with reputable outlets
(TechCrunch, SiliconANGLE, Bloomberg/Reuters-derived coverage, etc.) as
corroboration. Where a detail could not be confirmed against a primary or
reputable secondary source, it is explicitly flagged with **Could not verify:**.
Opinions and characterizations are attributed to their sources.

> **Cross-references (not duplicated here):**
> - For how **gVisor** compares to **Firecracker**, Kata, and WASM as isolation
>   primitives, and where Modal sits in the broader microVM/sandbox landscape
>   (alongside Fly.io, e2b, CodeSandbox), see
>   `history/WASM_DOCKER_alternate_history.md` and `history/fly-io.md`. Modal uses
>   **gVisor**, not Firecracker (see Technology below); the two are sometimes
>   conflated in casual coverage.

---

## Timeline

### 2021 — Founding

- **2021 — Modal founded by Erik Bernhardsson.** Multiple sources date the
  company's founding to **2021**, after Bernhardsson left Better.com (where he
  was CTO). TechCrunch: Bernhardsson "founded Modal Labs ... in 2021" after
  departing Better in 2021.
  - Source: [Modal Labs lands $16M to abstract away big data workload infrastructure — TechCrunch (Oct 10, 2023)](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/)
  - Bernhardsson's own résumé lists his **Better** tenure (CTO, New York City) as
    **Feb 2015 – Jan 2021**, consistent with starting Modal in 2021.
    - Source: [Work experience — Erik Bernhardsson](https://erikbern.com/resume.html)
  - **Could not verify** an exact founding *month/day* against a first-party
    Modal document. Secondary profiles commonly state **January 2021** for the
    founding and **August 2021** for when the second co-founder joined (see
    next item), but these specific months are secondary-sourced.

- **Co-founder: Akshat Bubna (CTO).** Bernhardsson recruited **Akshat Bubna** as
  co-founder roughly six months into the project; Bubna posted "I joined Erik
  Bernhardsson in 2021 ..." Bubna is described as an early engineer at **Scale
  AI** with a competitive-programming background (an **IOI** medalist) and an MIT
  math/CS background.
  - Source (Bubna's own framing): [Akshat Bubna's post — LinkedIn](https://www.linkedin.com/posts/akshat-bubna-188885103_i-joined-erik-bernhardsson-in-2021-when-activity-7282101112839528448-xiF5)
  - Source (co-founders Bernhardsson (CEO) and Bubna (CTO)): [Serverless AI infrastructure startup Modal Labs seals $355M funding round — SiliconANGLE (May 21, 2026)](https://siliconangle.com/2026/05/21/serverless-ai-infrastructure-startup-modal-labs-seals-355m-funding-round/)
  - **Could not verify** Bubna's exact join date (the "August 2021" month is
    secondary-sourced) or the specific IOI medal/MIT details against a primary
    Modal source; LinkedIn confirms only "2021."

- **The pre-Modal thesis: "Software infrastructure 2.0."** Before Modal was
  public, Bernhardsson published an influential essay, **"Software infrastructure
  2.0: a wishlist"** (**April 19, 2021**), arguing for "truly serverless" systems
  with no upfront provisioning, fast ephemeral cloud resources, and code-based
  (not config-based) interfaces — a wishlist Modal would go on to build. The post
  notes the author is "the founder of Modal Labs."
  - Source: [Software infrastructure 2.0: a wishlist — Erik Bernhardsson (Apr 19, 2021)](https://erikbern.com/2021/04/19/software-infrastructure-2.0-a-wishlist.html)

### 2022 — Seed round; the public "what I've been working on" reveal

- **2022 — Seed round (~$7M, Amplify Partners).** Modal's later Series A press
  release describes **Amplify Partners** as the **"Series Seed lead."** TechCrunch
  reports a **$7 million** seed round in **early 2022**, with total raised
  reaching **$23M** by the Series A.
  - Source (Amplify as seed lead; total $23M): [Press Release: Modal Labs Announces Series A Financing Round — Modal (Oct 10, 2023)](https://modal.com/blog/general-availability-and-series-a-press-release)
  - Source ($7M seed, early 2022): [TechCrunch (Oct 10, 2023)](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/)
  - **Could not verify** the exact **$7M** seed figure or its date against a
    first-party Modal announcement; the $7M/early-2022 detail is from TechCrunch
    (secondary). Modal's own press release confirms only that Amplify led the seed
    and that total raised through Series A was $23M.
  - **Note on the task brief's "~$16M 2022 round led by a16z":** This is **not
    supported.** The 2022 round was a **~$7M seed led by Amplify Partners**, and
    the **$16M** figure is the **2023 Series A led by Redpoint Ventures**. **No
    a16z (Andreessen Horowitz) lead is documented** for any Modal round in the
    sources reviewed. Marked **Could not verify: a16z-led Modal round.**

- **December 7, 2022 — "What I have been working on: Modal."** Bernhardsson
  publicly described Modal for the first time in a widely-read blog post. He
  framed the goal as: "I wanted to build something that takes code on a user's
  computer and launches it in the cloud within a second." The post introduces
  Modal's defining abstraction — a **decorator**: "The foundational building block
  in Modal is a decorator that takes any Python function and moves its execution
  to the cloud." It shows GPU usage (`@stub.function(gpu=modal.gpu.A100())`),
  scheduled functions, and image-building in code
  (`Image.debian_slim().pip_install([...])`).
  - Source: [What I have been working on: Modal — Erik Bernhardsson (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)
  - The post is also the source for the **custom Rust stack** and the **team's
    competitive-programming density** (see Technology and Culture sections):
    "We decided to not build this on top of tools like Docker/Kubernetes because
    we want infrastructure to be _fast_," building instead "a container runner, an
    image builder, and our own filesystem. Most of this in Rust for performance
    and safety."

### 2023 — General availability and the Series A

- **October 10, 2023 — General availability + Series A: $16M, led by Redpoint
  Ventures.** Modal exited beta to general availability and announced a **$16
  million Series A** led by **Redpoint Ventures**, with **Amplify Partners**
  (seed lead), **Lux Capital**, and **Definition Capital** participating. The
  press release states Modal is building "an end-to-end technology stack for data
  teams" enabling developers to "run code in the cloud, without the need for owned
  infrastructure," with usage-based pricing. Bernhardsson: "I started Modal
  because I believe that data teams deserve better."
  - Source (primary): [Press Release: Modal Labs Announces Series A Financing Round — Modal (Oct 10, 2023)](https://modal.com/blog/general-availability-and-series-a-press-release)
  - Source (coverage): [TechCrunch (Oct 10, 2023)](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/)
  - TechCrunch adds the early-customer roster (**Ramp, Substack**), team size
    (**14 employees**, growing toward 17), and the technical description: a
    "custom-built container system coded in Rust" that can "scale to hundreds of
    GPUs in as little as seconds."

### 2025 — Series B at a $1.1B valuation; the AI-inference pivot in framing

- **September 29, 2025 — Series B: ~$87M, led by Lux Capital; $1.1B valuation.**
  Modal announced a Series B (the post says "more than $80M"; widely reported as
  **$87M**) led by **Lux Capital**, at a **$1.1 billion** post-money valuation,
  bringing total raised to **$111M**. The post emphasizes **"sub-second container
  startup times"** and the ability to "aggregate GPUs and CPUs around the world,"
  and lists products: **Inference, Sandboxes, Batch, Training, Notebooks**.
  Named customers/quotes include **Scale**, **Substack**, **Lovable.dev**, and
  **Meta** (used for "Code World Models" research).
  - Source (primary): [Announcing our $87M Series B — Modal (Sep 29, 2025)](https://modal.com/blog/announcing-our-series-b)
  - Source (coverage): [Modal Labs raises $80M to simplify cloud AI infrastructure with programmable building blocks — SiliconANGLE (Sep 29, 2025)](https://siliconangle.com/2025/09/29/modal-labs-raises-80m-simplify-cloud-ai-infrastructure-programmable-building-blocks/)
  - **Note:** The round is variously reported as "$80M+" and "$87M"; Modal's own
    headline says **$87M** while the body says "more than $80M." Treat **$87M** as
    Modal's stated figure.

### 2026 — Talks at $2.5B, then the $355M Series C at $4.65B

- **February 11, 2026 — Reported in talks to raise at a ~$2.5B valuation.**
  TechCrunch reported Modal was in early discussions to raise at a **$2.5 billion**
  valuation (General Catalyst reported as a prospective lead), framing Modal as an
  **AI-inference** company ("optimizing inference, the process of running trained
  AI models"). TechCrunch reported an annualized revenue run-rate of roughly
  **$50 million** at the time, and noted Bernhardsson pushed back on being
  "actively fundraising," calling the interactions "general conversations." The
  piece situates Modal among inference rivals (Baseten, Fireworks AI).
  - Source: [AI inference startup Modal Labs in talks to raise at $2.5B valuation, sources say — TechCrunch (Feb 11, 2026)](https://techcrunch.com/2026/02/11/ai-inference-startup-modal-labs-in-talks-to-raise-at-2-5b-valuation-sources-say/)
  - **Attribution:** the $2.5B figure and $50M ARR are **reported by TechCrunch
    from unnamed sources**, not company-confirmed at that date. The $2.5B figure
    later resurfaces as the **first tranche** of the Series C (next item).

- **May 21, 2026 — Series C: $355M, led by General Catalyst and Redpoint
  Ventures; $4.65B valuation.** Modal announced a **$355 million Series C** at a
  **$4.65 billion** post-money valuation, **co-led by General Catalyst and
  Redpoint**, with **Menlo Ventures**, **Bain Capital Ventures**, and **Accel**
  joining as new investors. Modal's own post and coverage describe the raise as
  closing in **two tranches** — an earlier tranche at a **$2.5B** valuation, then
  a larger one at **$4.65B**. Modal reported **over $300M in annualized revenue**
  (up from ~$60M in September 2025), **over 1 billion sandboxes** launched, with
  **sandboxes driving more than a third of revenue**.
  - Source (primary): [Modal's Series C: Raising $355M at a $4.65B valuation — Modal Blog (May 21, 2026)](https://modal.com/blog/modal-series-c)
  - Source (coverage): [Serverless AI infrastructure startup Modal Labs seals $355M funding round — SiliconANGLE (May 21, 2026)](https://siliconangle.com/2026/05/21/serverless-ai-infrastructure-startup-modal-labs-seals-355m-funding-round/)
  - Source (valuation/tranches/revenue): [Modal Labs raises $355M, quadrupling valuation to $4.65B as AI infrastructure demand surges — Tech Startups (May 21, 2026)](https://techstartups.com/2026/05/21/modal-labs-raises-355m-quadrupling-valuation-to-4-65b-as-ai-infrastructure-demand-surges/)
  - The Series C post pitches Modal as **"a cloud built for AI ... not a
    single-purpose GPU cloud, but a platform with the right primitives"** spanning
    inference, agents, reinforcement learning, and batch. Named customers/use
    cases include **DoorDash**, **Cognition** (RL + inference), **Decagon**
    ("p90 latency of 342ms"), **Physical Intelligence** (real-time robotic
    control), **Chai Discovery** (drug discovery), **Suno** (millions of songs/day),
    and **Ramp** (coding agents authoring "70% of merged PRs").
  - **Note on the task brief's "~$80M+ at ~$1B+ valuation Series A/B (2024)":**
    The closest match is the **Sep 2025 Series B (~$87M at $1.1B)**, not 2024.
    **Could not verify** any 2024 Modal funding round; the documented sequence is
    Seed (2022) → Series A (2023) → Series B (2025) → Series C (2026).
  - **Revenue caveat:** ARR figures vary sharply across coverage and time
    ($50M in Feb 2026 per TechCrunch's sources; $60M "in September" and $300M+ by
    May 2026 per the Series C coverage). These are **company-stated growth claims**
    relayed by the press; treat exact ARR numbers as **reported, not audited**.

---

## Technology (custom container stack, gVisor, cold starts)

Sourced to Bernhardsson's own write-up, the Latent Space interview, and Modal's
docs. The throughline is that Modal **rebuilt the container stack from scratch**
rather than wrapping Docker/Kubernetes, in pursuit of speed.

- **Python decorator → cloud execution.** Modal's core abstraction is a decorator
  that "takes any Python function and moves its execution to the cloud," including
  GPU selection in code. Infrastructure (images, GPUs, schedules) is expressed in
  Python rather than YAML.
  - Source: [What I have been working on: Modal — Erik Bernhardsson (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)

- **Custom stack in Rust; no Docker/Kubernetes.** Modal built "a container runner,
  an image builder, and our own filesystem. Most of this in Rust for performance
  and safety," explicitly avoiding Docker/Kubernetes "because we want
  infrastructure to be _fast_." The filesystem is a **FUSE**-based,
  **content-addressed** virtual filesystem that exposes files over the network
  rather than downloading whole images — enabling claims like building "a 100GB
  container, and then booting up 100 of those containers ... in a few seconds."
  - Source: [What I have been working on: Modal — Erik Bernhardsson (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)
  - In the Latent Space interview, Bernhardsson describes going "a layer deeper"
    than Docker to **runc**, building a Rust container runtime on top of it, plus a
    virtual filesystem and **CPU/memory checkpointing** to restore containers from
    snapshots.
    - Source: [Truly Serverless Infra for AI Engineers — with Erik Bernhardsson of Modal — Latent Space](https://www.latent.space/p/modal)

- **Isolation = gVisor (not Firecracker).** Modal's security docs state: "Compute
  jobs at Modal are containerized and virtualized using **gVisor**, the sandboxing
  technology developed at Google and used in their Google Cloud Run and Google
  Kubernetes Engine cloud services." Bernhardsson confirms the same in interview
  ("a Google product that provides pretty strong isolation").
  - Source (primary, docs): [Security and privacy at Modal — Modal Docs](https://modal.com/docs/guide/security)
  - Source (founder, interview): [Latent Space — Modal](https://www.latent.space/p/modal)
  - **Clarification:** The task brief's "gVisor/Firecracker-style isolation"
    should be read as **gVisor specifically**. Modal's documented isolation
    primitive is **gVisor**; **Firecracker is not** cited in Modal's own
    materials reviewed here. (Firecracker is Fly.io's primitive — see
    `history/fly-io.md`.)

- **Sub-second cold starts.** Modal markets "**sub-second container startup
  times**," achieved via the custom filesystem (no full image download) plus
  **memory snapshotting/checkpointing**.
  - Source (sub-second framing): [Announcing our $87M Series B — Modal (Sep 29, 2025)](https://modal.com/blog/announcing-our-series-b)
  - Source (snapshotting/filesystem mechanics): [Latent Space — Modal](https://www.latent.space/p/modal)

- **Sandboxes for AI-generated code.** Beyond functions, Modal exposes
  **Sandboxes** — isolated environments to run untrusted/AI-generated code — which
  by the 2026 Series C accounted for **over 1 billion launches** and **>1/3 of
  revenue**. SiliconANGLE describes Modal providing "sandbox environments for
  developers to test newly generated AI code before running it in production."
  - Source: [Modal's Series C — Modal Blog (May 21, 2026)](https://modal.com/blog/modal-series-c)
  - Source: [SiliconANGLE (May 21, 2026)](https://siliconangle.com/2026/05/21/serverless-ai-infrastructure-startup-modal-labs-seals-355m-funding-round/)

---

## Key people & teams

- **Erik Bernhardsson** — co-founder and **CEO**. Career (per his own résumé and
  about page):
  - **Spotify** (~2009–2015): one of Spotify's early hires; engineering manager in
    Stockholm (Feb 2009 – Feb 2011) and New York (Oct 2011 – Feb 2015); built up
    the core of Spotify's **music recommendation system** and its analytics/ML
    teams.
  - **Better** (Feb 2015 – Jan 2021): **CTO**, where he grew engineering "from 1 to
    300."
  - Creator of two widely-used open-source projects: **Luigi** (a Python workflow/
    pipeline manager) and **Annoy** (Approximate Nearest Neighbors Oh Yeah, a
    library for approximate nearest-neighbor search).
  - A prolific blogger on data infrastructure and "build-vs-buy"/vendor economics.
  - Sources: [Work experience — Erik Bernhardsson](https://erikbern.com/resume.html);
    [About — Erik Bernhardsson](https://erikbern.com/about.html);
    [Leaving Spotify — Erik Bernhardsson (Feb 11, 2015)](https://erikbern.com/2015/02/11/leaving-spotify.html);
    [erikbern on GitHub](https://github.com/erikbern)
  - **Could not verify** the often-repeated claim that "80% of Spotify's current
    recommendation system is still his algorithms" against a primary source; it is
    a secondary-profile assertion. The Spotify tenure itself is primary-sourced via
    his résumé and "Leaving Spotify" post.

- **Akshat Bubna** — co-founder and **CTO**; joined in 2021. Earlier an early
  engineer at **Scale AI**; competitive-programming (IOI) background. (Some
  details secondary; see founding section.)
  - Source: [Akshat Bubna's post — LinkedIn](https://www.linkedin.com/posts/akshat-bubna-188885103_i-joined-erik-bernhardsson-in-2021-when-activity-7282101112839528448-xiF5);
    [SiliconANGLE (May 21, 2026)](https://siliconangle.com/2026/05/21/serverless-ai-infrastructure-startup-modal-labs-seals-355m-funding-round/)

- **Engineering team — competitive-programming density (culture).** In the Dec
  2022 reveal, Bernhardsson noted a 7-person team with **"5 IOI gold medals,"**
  illustrating a deliberate emphasis on competitive-programming talent and high
  hiring bar ("talent density is very important").
  - Source: [What I have been working on: Modal — Erik Bernhardsson (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html);
    [Latent Space — Modal](https://www.latent.space/p/modal)
  - **Could not verify** the precise medal count over time against a primary
    source beyond the 2022 snapshot above.

---

## Company & corporate history

- **2021** — Founded by **Erik Bernhardsson** (later joined by co-founder **Akshat
  Bubna**), after Bernhardsson's CTO stint at Better. Legal entity: **Modal Labs**.
  - [TechCrunch (Oct 10, 2023)](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/) ·
    [Work experience — Erik Bernhardsson](https://erikbern.com/resume.html)

- **Funding (verified figures):**

  | Round | Date | Amount | Lead | Valuation | Notes |
  |---|---|---|---|---|---|
  | Seed | early 2022 | ~$7M | Amplify Partners | — | $7M/date per [TechCrunch](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/); Amplify-as-seed-lead per [Modal press release](https://modal.com/blog/general-availability-and-series-a-press-release) |
  | Series A | Oct 10, 2023 | $16M | Redpoint Ventures | undisclosed | + Amplify, Lux Capital, Definition Capital; total raised $23M ([Modal](https://modal.com/blog/general-availability-and-series-a-press-release), [TechCrunch](https://techcrunch.com/2023/10/10/modal-labs-lands-16m-to-abstract-away-big-data-workload-infrastructure/)) |
  | Series B | Sep 29, 2025 | ~$87M | Lux Capital | $1.1B post | total raised $111M ([Modal](https://modal.com/blog/announcing-our-series-b), [SiliconANGLE](https://siliconangle.com/2025/09/29/modal-labs-raises-80m-simplify-cloud-ai-infrastructure-programmable-building-blocks/)) |
  | Series C | May 21, 2026 | $355M | General Catalyst & Redpoint | $4.65B post | two tranches ($2.5B → $4.65B); + Menlo, Bain Capital Ventures, Accel ([Modal](https://modal.com/blog/modal-series-c), [SiliconANGLE](https://siliconangle.com/2026/05/21/serverless-ai-infrastructure-startup-modal-labs-seals-355m-funding-round/), [Tech Startups](https://techstartups.com/2026/05/21/modal-labs-raises-355m-quadrupling-valuation-to-4-65b-as-ai-infrastructure-demand-surges/)) |

  - **Corrections to the task brief's funding framing:**
    - "~$16M 2022 round led by a16z" — **not supported**. 2022 was a **~$7M seed
      led by Amplify**; **$16M was the 2023 Series A led by Redpoint**; **no a16z
      lead documented**.
    - "2023 ~$16M" — **correct** (Series A, Redpoint).
    - "2024 Series A/B (~$80M+) at ~$1B+ valuation" — the matching round is the
      **Sep 2025 Series B (~$87M, $1.1B)**, not 2024.

- **Trajectory: from "data teams" to "a cloud built for AI."** Modal's public
  positioning shifted over time: the 2022–2023 messaging centered on **data
  teams** running code in the cloud; by the 2025–2026 rounds the framing became
  explicitly **AI infrastructure / inference / agents / RL / batch** ("a cloud
  built for AI"). This is a framing/positioning evolution evident across the
  primary posts, not a claimed pivot of the underlying technology.
  - Sources: [Modal Series A press release (2023)](https://modal.com/blog/general-availability-and-series-a-press-release);
    [Series B (2025)](https://modal.com/blog/announcing-our-series-b);
    [Series C (2026)](https://modal.com/blog/modal-series-c)

---

## Culture & notable characterizations

> Items here separate **fact** from **reported characterization**, with attribution.

- **The Bernhardsson blog as a recruiting/positioning asset.** Modal's origin and
  positioning are unusually tied to its founder's writing: the 2021 "Software
  infrastructure 2.0" wishlist effectively pre-announced the product thesis, and
  the Dec 2022 "What I've been working on" post served as the public unveiling.
  - Sources: [Software infrastructure 2.0 (Apr 19, 2021)](https://erikbern.com/2021/04/19/software-infrastructure-2.0-a-wishlist.html);
    [What I've been working on: Modal (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)
  - That these posts are influential/widely-read is **observation**; the **fact**
    is that Bernhardsson published the thesis publicly before and at launch.

- **"Rebuild the stack" as a deliberate, contrarian bet.** Building a custom
  Rust container runtime, image builder, and filesystem rather than using
  Docker/Kubernetes is a strategic choice Bernhardsson states explicitly; whether
  it is over-engineering or the source of Modal's speed advantage is a matter of
  opinion. The **fact** is the custom stack and its stated speed rationale.
  - Source: [What I've been working on: Modal (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)

- **High hiring bar / competitive-programming density.** Reported by Bernhardsson
  himself ("5 IOI gold medals" on a 7-person team; "talent density is very
  important"). Whether this is admirable or elitist is opinion; the snapshot
  figure is the founder's own statement.
  - Source: [Latent Space — Modal](https://www.latent.space/p/modal);
    [What I've been working on: Modal (Dec 7, 2022)](https://erikbern.com/2022/12/07/what-ive-been-working-on-modal.html)

- **No major public controversy located.** Unlike some peers, no significant
  security incident, outage postmortem, or pricing controversy specific to Modal
  surfaced in this research pass. **Could not verify** the existence of any such
  event; absence of a finding is **not** proof of absence.

---

## Items marked "Could not verify"

- **Exact founding month/day (2021)** and the **exact date Akshat Bubna joined**
  ("January 2021" founding / "August 2021" co-founder join are secondary-sourced;
  primary sources confirm only "2021").
- **The ~$7M seed amount and early-2022 date** — from TechCrunch (secondary);
  Modal's own press release confirms only that **Amplify led the seed** and that
  total-through-Series-A was **$23M**.
- **Task brief's "a16z-led ~$16M 2022 round"** — **not supported**; **no a16z
  lead** is documented for any Modal round in the sources reviewed.
- **Task brief's "2024 Series A/B (~$80M+) at ~$1B+ valuation"** — no **2024**
  round located; the matching raise is the **Sep 2025 Series B (~$87M, $1.1B)**.
- **Series B size** — Modal's headline says **$87M**; its own body and some
  coverage say "$80M+." Treated as $87M (Modal's stated figure).
- **Revenue/ARR figures** ($50M in Feb 2026 per TechCrunch sources; $60M→$300M+
  by May 2026 per Series C coverage) — **company-stated growth claims relayed by
  the press**, not audited.
- **"80% of Spotify's recommendation system is still Erik's algorithms"** —
  secondary-profile claim; not primary-sourced.
- **Firecracker** — the task brief's "gVisor/Firecracker-style isolation" is only
  partly supported: Modal's documented primitive is **gVisor**; **Firecracker is
  not** referenced in Modal's own materials reviewed here.
- **Any Modal-specific controversy** — none located; could not be verified either
  way.
