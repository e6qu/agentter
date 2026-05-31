# Fly.io: A Sourced History

A chronological, fully-sourced history of **Fly.io** — the developer-focused
public cloud that runs applications as **Firecracker microVMs** ("Fly Machines")
on a global **Anycast** network.

Every non-trivial claim below carries a working source link. Where a detail
could not be confirmed against a primary or reputable secondary source, it is
explicitly flagged with **Could not verify:**. Controversies and opinions are
attributed to their sources, with fact separated from reported claim.

> **Cross-references (not duplicated here):**
> - Firecracker as a microVM isolation primitive, the broader microVM /
>   sandbox landscape (e2b, Modal, CodeSandbox, etc.), and Fly.io's place in it
>   are covered in `history/WASM_DOCKER_alternate_history.md` (§7.3 and the
>   "Who's using what" list). This doc focuses on Fly.io the company and its
>   own architecture; see that doc for how Firecracker compares to gVisor, Kata,
>   and WASM.
> - Docker's history (dotCloud → Docker, Inc., the OCI image format that Fly.io
>   consumes) is in `history/docker.md`. Fly.io unpacks **Docker/OCI images**
>   and runs them inside microVMs; it is a *consumer* of the Docker image
>   ecosystem, not a container-runtime project.

---

## Timeline

### 2017 — Founding

- **2017 — Fly.io founded.** Fly.io's own "About us" page states: "We've been
  hammering on this thing since 2017."
  - Source: [About us — Fly](https://fly.io/about/)
  - TechCrunch corroborates "Founded in 2017."
    - Source: [Fly.io wants to change the way companies deploy apps at the edge — TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)
  - **Could not verify** a single authoritative primary-source founding *date*
    (month/day) or the exact legal entity name "Fly.io, Inc." against a
    first-party document. Secondary profiles also cite 2016 in at least one
    case; 2017 is the year Fly.io itself and TechCrunch use.

- **Founders.** Secondary sources (Crunchbase-derived profiles, startup
  databases) list the founders as **Kurt Mackey**, **Jerome Gravel-Niquet**,
  **Michael Dwan**, and **Thomas Ptacek**.
  - Source (founder list): [Fly.io: Funding, Team & Investors — startupintros](https://startupintros.com/orgs/fly-io)
  - **Attribution / caveat:** Mackey (CEO) and Gravel-Niquet (CTO) appear
    consistently as founders; Fly.io's own About page lists Gravel-Niquet as
    "Developer + CTO."
    - Source: [About us — Fly](https://fly.io/about/)
  - **Could not verify** the *complete* four-person founder list against a
    first-party Fly.io source. Thomas Ptacek's relationship is described
    inconsistently across sources: some list him as a co-founder, while his own
    bio and Fly's blog describe him as a "developer"/security researcher at the
    company (see his entry under **Key people** below). Treat "Dwan and Ptacek
    as co-founders" as **reported, not first-party-confirmed**.

- **Kurt Mackey's background.** Mackey previously founded **MongoHQ**, later
  renamed **Compose**, a database-hosting company **acquired by IBM in 2015**.
  TechCrunch: "Mackey ... previously founded MongoHQ (which he renamed Compose),
  a company that IBM acquired in 2015." The a16z announcement adds he also
  "helped build Ars Technica."
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)
  - Source: [Investing in Fly.io — Andreessen Horowitz (July 28, 2022)](https://a16z.com/announcement/investing-in-fly-io/)

- **Original product: an edge application platform.** Fly.io's founding thesis
  was that the traditional CDN model is the wrong abstraction — instead of
  caching at the edge in front of a centralized app, you should run the *whole
  app* close to users. TechCrunch quotes Mackey: "a CDN is kind of a
  misfeature for most developers."
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)

### 2018–2020 — Edge JavaScript runtime, and the first "we were wrong"

- **2018 — Fly Edge Apps.** Fly.io's early product was a **JavaScript edge
  runtime** built on V8 — effectively "build your own CDN" with JS running at
  the edge. The launch was discussed on Hacker News as "Introducing Fly Edge
  Apps" (HN item dated to 2018).
  - Source: [Introducing Fly Edge Apps — Hacker News (item 16758525, 2018)](https://news.ycombinator.com/item?id=16758525)
  - The legacy JavaScript product documentation still lives at
    [js.fly.io/docs](https://web.archive.org/web/2id_/https://js.fly.io/docs/).

- **The first pivot — away from edge JavaScript, toward containers.** Fly.io
  later concluded the JS-runtime bet was wrong: developers didn't want a new
  JavaScript runtime, they wanted their existing code to run. Fly.io itself
  frames this as a prior mistake in its 2025 GPU retrospective, drawing an
  explicit parallel: it made "an earlier miscalculation about edge JavaScript
  runtimes."
  - Source (Fly's own framing of the earlier JS miscalculation): [We Were Wrong About GPUs — The Fly Blog (Feb 14, 2025)](https://fly.io/blog/wrong-about-gpu/)
  - **Could not verify** an exact date for the JS→containers transition; the
    pivot was gradual rather than a single dated announcement.

- **Winter 2020 — Y Combinator.** Mackey and co-founders went through **Y
  Combinator's Winter 2020 batch**, despite Mackey being a repeat founder.
  TechCrunch notes he "attended Y Combinator ... in Winter 2020."
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)
  - Source: [Jobs at Fly.io (W20) — Y Combinator Work at a Startup](https://www.workatastartup.com/companies/fly-io)

### 2021 — Series A; the engineering-blog reputation forms

- **August 2021 — Series A: $12M, led by Intel Capital.** Per TechCrunch, the
  Series A ($12M, led by Intel Capital) closed in **August 2021** and was first
  publicly disclosed in the July 2022 Series B coverage.
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)
  - Source (Intel Capital, both rounds): [Fly.io Raises $12 Million Series A ... and $25M Series B — Intel Capital](https://www.intelcapital.com/fly-io-raises-12-million-series-a-funding-led-by-intel-capital-and-25m-series-b-funding-led-by-andreessen-horowitz-to-revolutionize-the-distributed-cloud/)
    - **Note:** This Intel Capital URL returned HTTP 403 when fetched directly;
      its title (which encodes both round amounts and leads) appears in search
      indexes, and the same figures are independently confirmed by TechCrunch.

### 2022 — Fly Machines, the Series B, and the Heroku moment

- **May 24, 2022 — Fly Machines announced.** Fly.io introduced **Fly Machines**:
  "an API for fast-booting VMs." Machines are Firecracker microVMs exposed
  directly via a REST API and `flyctl`, one abstraction level below Fly's
  managed orchestration. The post emphasizes Firecracker's boot speed
  ("Firecracker is pretty darn fast to boot a given executable on a given
  host"), ~300ms create / ~10–150ms start latencies, and a "scale to zero by
  exiting when idle" model.
  - Source: [Fly Machines: an API for fast-booting VMs — The Fly Blog (May 24, 2022)](https://fly.io/blog/fly-machines/)
  - Machines became the basis of the **Apps V2** platform; Fly's docs
    distinguish **Apps V1** (managed) from **V2 / Machines** (low-level control).
    - Source: [Fly Machines — Fly Docs](https://fly.io/docs/machines/)

- **June 2022 — Series B: $25M, led by Andreessen Horowitz** (announced July 28,
  2022). Co-investors included Intel Capital, Dell Technologies Capital,
  Initialized Capital, and PlanetScale CEO Sam Lambert. TechCrunch reports the
  round "closed in June" and brought total raised to **$37M**.
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)
  - Source: [Investing in Fly.io — a16z (July 28, 2022)](https://a16z.com/announcement/investing-in-fly-io/)
  - **Correction to a common framing:** The Series B was **$25M**, not ~$1B,
    and **no $1B valuation** is documented for Fly.io in 2022–2023. The a16z
    post does **not** state an amount or valuation. **Could not verify** any
    "~$1B valuation" claim; the highest documented valuation in this window is
    **$467M** at the 2023 Series C (below).

- **September 21, 2022 — LiteFS introduced** (see **LiteFS / distributed
  SQLite** below).

- **November 28, 2022 — Heroku kills its free tier (context, not a Fly.io
  event).** Salesforce-owned Heroku ended free dynos/Postgres/data, effective
  **Nov 28, 2022**, triggering a migration wave. Fly.io (alongside Render)
  became a prominent destination.
  - Source (Fly's Heroku-migration guide): [Migrate from Heroku — Fly Docs](https://fly.io/docs/elixir/getting-started/migrate-from-heroku/)
  - **Could not verify** the exact Heroku free-tier shutdown date against
    Heroku's own announcement here; Nov 28, 2022 is the widely-reported date in
    secondary coverage. (Cross-reference Heroku timeline if a `heroku.md`
    exists.)

- **The Phoenix/Elixir embrace.** Fly.io became closely associated with the
  Elixir/Phoenix community. **Chris McCord**, the creator of the **Phoenix**
  framework, joined Fly.io (he is listed on Fly's About page as "Developer").
  Fly's `fly launch` detects Phoenix and generates a working Dockerfile/release.
  - Source (McCord on the team): [About us — Fly](https://fly.io/about/)
  - Source (Fly's own LiveView/Phoenix retrospective): [How We Got to LiveView — The Fly Blog](https://fly.io/blog/how-we-got-to-liveview/)
  - Source (community framing of McCord joining): [Thinking Elixir Podcast 62: Chris McCord joins Fly.io and Phoenix 1.6](https://podcast.thinkingelixir.com/62)

### 2023 — The reliability reckoning; Series C

- **March 6, 2023 — "Reliability: It's Not Great."** Kurt Mackey published an
  unusually candid post (on the Fly community forum) acknowledging "The last
  four months have been rough. We've had more issues than we're OK with." He
  attributed problems to rapid growth outpacing the platform: global service
  discovery built on **HashiCorp Consul** proved unsuitable for a global role;
  Fly's in-house gossip-based replacement, **Corrosion**, was new and immature
  ("gossip based consistency is a difficult problem"), leading to corrupted
  service-discovery state. He also wrote, strikingly for a CEO: "I'm fighting a
  debilitating feeling of failure. Fear, too. If we don't improve, our company
  ceases to exist."
  - Source (primary, the post): [Reliability: It's Not Great — Fly.io community](https://community.fly.io/t/reliability-its-not-great/11253)
  - Source (press coverage, Mar 7, 2023): [Fly.io CEO says reliability 'not great' as platform suffers scaling issues — DevClass (Mar 7, 2023)](https://devclass.com/2023/03/07/fly-io-ceo-says-reliability-not-great-as-platform-suffers-scaling-issues/)
  - See **Controversies & culture** for the community reaction.

- **June 28, 2023 — Series C: $70M, led by EQT Ventures; ~$467M valuation.**
  With participation from existing investors a16z, Dell Technologies Capital,
  and Intel Capital. Multiple outlets report the round and a **$467M
  post-money valuation**.
  - Source: [Cloud Startup Fly.io Raises $70 Million in EQT-Led Round — Bloomberg (June 28, 2023)](https://www.bloomberg.com/news/articles/2023-06-28/public-cloud-startup-fly-io-raises-70-million-in-eqt-led-round)
  - Source: [Fly.io raises $70M to help developers launch apps closer to users — SiliconANGLE (June 28, 2023)](https://siliconangle.com/2023/06/28/fly-io-raises-70m-help-developers-launch-apps-closer-users/)
  - Source (valuation figure): [Series C — Fly.io — Crunchbase](https://www.crunchbase.com/funding_round/fly-io-series-c--7c30f282)
  - **Could not verify** the exact $467M figure against a first-party Fly.io
    statement; it comes from Crunchbase/secondary reporting. The $70M / EQT-led
    / June 28, 2023 facts are confirmed by Bloomberg and SiliconANGLE.

### 2023–2025 — GPUs/AI, and the second "we were wrong"

- **December 13, 2023 — "Fly.io has GPUs now."** Fly added GPU Machines (Nvidia
  A100 40G/80G, later L40S) aimed at **AI inference at the edge** — "recognize
  speech, segment text, summarize articles, synthesize images ... at speeds
  that would make your homelab blush" — with the same scale-to-zero,
  pay-per-request model as regular Machines.
  - Source: [Fly.io has GPUs now — The Fly Blog (Dec 13, 2023)](https://fly.io/blog/fly-io-has-gpus-now/)

- **February 14, 2025 — "We Were Wrong About GPUs."** Mackey published a
  retrospective: developer demand for raw GPUs didn't materialize — "developers
  don't want GPUs. They don't even want AI/ML models. They want LLMs" (i.e.,
  hosted LLM APIs like OpenAI/Anthropic). Fly scaled back GPU ambitions but
  explicitly **did not deprecate** the offering ("we're not getting rid of
  them"), keeping the L40S tier for active users. He framed it as a strategic
  bet that didn't pay off, comparable to the earlier edge-JavaScript misstep.
  - Source: [We Were Wrong About GPUs — The Fly Blog (Feb 14, 2025)](https://fly.io/blog/wrong-about-gpu/)

- **AI agent sandboxes / ephemeral compute.** Fly Machines' fast Firecracker
  boot plus checkpoint/restore make them a natural fit for **AI agent
  sandboxes** and ephemeral per-request compute. Chris McCord's **`phoenix.new`**
  ("the remote AI runtime for Phoenix") is a Fly-built product in this space.
  - Source: [Phoenix.new – The Remote AI Runtime for Phoenix — The Fly Blog](https://fly.io/blog/phoenix-new-the-remote-ai-runtime/)
  - For Fly.io's role in the broader microVM-for-AI-agents landscape (vs. e2b,
    Modal, CodeSandbox), see `history/WASM_DOCKER_alternate_history.md` §7.3
    and its "Who's using what" list, which cites Fly Machines' fast
    checkpoint/restore for sandbox use cases.

---

## Technology (Firecracker / Fly Machines / Anycast)

Sourced primarily to Fly.io's own architecture reference and the Fly Machines
launch post.

- **Compute = Firecracker microVMs.** Fly runs app code in **Firecracker
  microVMs** — "lightweight, secure virtual machines based on strong hardware
  virtualization" — on dedicated physical servers (8–32 cores, 32–256GB RAM),
  multi-tenant but VM-isolated.
  - Source: [The Fly.io Architecture — Fly Docs](https://fly.io/docs/reference/architecture/)
  - (Firecracker itself — AWS's KVM-based VMM, open-sourced Nov 2018, also
    powering Lambda/Fargate — is covered in
    `history/WASM_DOCKER_alternate_history.md` §7.3.)

- **Docker/OCI images → microVM filesystems.** Fly unpacks Docker/OCI images
  (via containerd) into filesystems mounted onto Firecracker microVMs — i.e.,
  it consumes the Docker image ecosystem (`history/docker.md`) but runs it on a
  hypervisor rather than a container runtime.
  - Source (Fly's own description of containerd → Firecracker): [Fly Machines — Fly Docs](https://fly.io/docs/machines/) and the architecture reference above.

- **Fly Machines = the low-level VM API.** A REST API (and `flyctl`/`fly`) to
  create, start, stop, and destroy individual microVMs fast. ~300ms to create
  (image download dominated), ~10–150ms to start a pre-created machine near the
  user; "exit when idle" enables safe scale-to-zero.
  - Source: [Fly Machines: an API for fast-booting VMs — The Fly Blog (May 24, 2022)](https://fly.io/blog/fly-machines/)

- **Networking = BGP Anycast + a Rust proxy.** Fly announces its IP ranges from
  every datacenter via **BGP Anycast**; connections land at the nearest edge,
  where a per-server **Rust-based Fly Proxy** terminates TLS, identifies the
  target app, and proxies the TCP connection to the nearest healthy microVM.
  For geographically distant deployments it **backhauls** over a WireGuard
  tunnel.
  - Source: [The Fly.io Architecture — Fly Docs](https://fly.io/docs/reference/architecture/)

- **Service discovery: Consul → Corrosion.** Global service-discovery state
  originally used HashiCorp Consul; Fly replaced it with an in-house
  gossip-based system, **Corrosion**, after Consul's centralized design proved
  unsuitable globally (see the reliability post).
  - Source: [Reliability: It's Not Great — Fly.io community (Mar 6, 2023)](https://community.fly.io/t/reliability-its-not-great/11253)

### LiteFS / distributed SQLite

- **Ben Johnson joined Fly.io** to work on server-side SQLite. Johnson is the
  author of **BoltDB** (the pure-Go embedded key/value store used by **etcd**,
  **HashiCorp Consul**, **Prometheus**, and **Docker**, among others) and of
  **Litestream** (streaming SQLite backup/replication to object stores like S3).
  He is now listed as Fly.io's **VP of Product**.
  - Source (Johnson on the Fly team / VP of Product): [About us — Fly](https://fly.io/about/)
  - Source (Litestream "missing disaster recovery system" framing, and Johnson
    as author): [I'm All-In on Server-Side SQLite — The Fly Blog](https://fly.io/blog/all-in-on-sqlite-litestream/)
  - **Could not verify** Johnson's exact Fly.io start date against a primary
    source; his Litestream/LiteFS work at Fly is dated by the blog posts below.

- **September 21, 2022 — LiteFS introduced.** Authored by Ben Johnson, **LiteFS**
  is an open-source **distributed file system for SQLite**. It extends
  Litestream with "fine-grained transactional control": where Litestream copies
  the raw SQLite WAL file, LiteFS uses a **FUSE** filesystem to intercept and
  ship individual *transactions* (in a format Fly calls **LTX**), enabling live
  multi-node replication for unmodified SQLite apps. Fly emphasizes it is
  "completely open source" and not locked to Fly.io.
  - Source: [Introducing LiteFS — The Fly Blog (Sep 21, 2022)](https://fly.io/blog/introducing-litefs/)
  - Source: [LiteFS - Distributed SQLite — Fly Docs](https://fly.io/docs/litefs/)
  - **Note on irony, attribution = observation from sources:** Johnson's BoltDB
    backs **Consul**, the very system Fly replaced for global service discovery
    (per the reliability post). This is an observation drawn from the two cited
    sources, not a claim by Fly.io.

---

## Key people & teams

- **Kurt Mackey** — co-founder and **CEO**. Previously founded **MongoHQ /
  Compose** (acquired by IBM, 2015); earlier "helped build Ars Technica."
  Author of the candid reliability and GPU retrospectives.
  - Sources: [a16z (July 28, 2022)](https://a16z.com/announcement/investing-in-fly-io/);
    [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/);
    [We Were Wrong About GPUs — Fly Blog (Feb 14, 2025)](https://fly.io/blog/wrong-about-gpu/)

- **Jerome Gravel-Niquet** — co-founder; **CTO** ("Developer + CTO" on the
  About page).
  - Source: [About us — Fly](https://fly.io/about/)

- **Thomas Ptacek** ("tqbf") — high-profile security researcher; co-founder of
  **Matasano Security** (acquired by NCC Group) and **Latacora**; co-creator of
  the **Matasano/Cryptopals** challenges; prolific writer and one of the most
  prominent **Hacker News** figures. At Fly.io he is a key voice behind the
  company's famously well-written engineering blog and hiring posts.
  - Sources (his own bio + Fly blog presence): [sockpuppet.org/me](https://sockpuppet.org/me/);
    [Profile: tptacek — Hacker News](https://news.ycombinator.com/user?id=tptacek)
  - **Attribution / caveat on role:** Ptacek's title at Fly is described
    inconsistently across sources — variously "developer," "security
    researcher," "principal," and in some startup databases "co-founder." His
    own bio frames him as a developer/security researcher. **Could not verify**
    a single authoritative title; the safest claim is that he is a prominent
    engineer and the public face of Fly's writing/hiring culture, not
    necessarily a confirmed founder.

- **Michael Dwan** — listed as a co-founder in secondary databases.
  - Source: [Fly.io: Funding, Team & Investors — startupintros](https://startupintros.com/orgs/fly-io)
  - **Could not verify** against a first-party Fly.io source.

- **Ben Johnson** (@benbjohnson) — **VP of Product**; creator of **BoltDB** and
  **Litestream**; built **LiteFS** at Fly. (See LiteFS section.)
  - Source: [About us — Fly](https://fly.io/about/)

- **Chris McCord** — creator of the **Phoenix** framework (Elixir); listed as a
  Fly.io "Developer"; later launched **`phoenix.new`** (AI runtime for Phoenix)
  at Fly. Anchors Fly's Elixir/Phoenix community ties.
  - Sources: [About us — Fly](https://fly.io/about/);
    [Phoenix.new — The Fly Blog](https://fly.io/blog/phoenix-new-the-remote-ai-runtime/)

---

## Company & corporate history

- **Founded 2017** as an edge application platform; the legal-entity name and
  exact founding date could not be first-party-verified (see Timeline).
  - Source: [About us — Fly](https://fly.io/about/)

- **Funding (verified figures):**
  | Round | Date | Amount | Lead | Notes |
  |---|---|---|---|---|
  | Series A | Aug 2021 (disclosed Jul 2022) | $12M | Intel Capital | [TechCrunch](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/) |
  | Series B | Closed Jun 2022, announced Jul 28 2022 | $25M | Andreessen Horowitz | co: Intel Capital, Dell Tech Capital, Initialized, Sam Lambert; total raised $37M ([TechCrunch](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/), [a16z](https://a16z.com/announcement/investing-in-fly-io/)) |
  | Series C | Jun 28 2023 | $70M | EQT Ventures | ~$467M valuation (secondary); a16z/Dell/Intel participated ([Bloomberg](https://www.bloomberg.com/news/articles/2023-06-28/public-cloud-startup-fly-io-raises-70-million-in-eqt-led-round), [SiliconANGLE](https://siliconangle.com/2023/06/28/fly-io-raises-70m-help-developers-launch-apps-closer-users/)) |

  - **No ~$1B valuation is documented.** The task brief's "~$1B valuation,
    a16z-led Series B/C" framing is **not supported**: a16z led the **$25M**
    Series B (2022); the **$70M** Series C (2023, ~$467M valuation) was
    **EQT-led**. Marked **Could not verify: $1B valuation**.

- **Scale (2022 snapshot):** ~35 employees and "hundreds of thousands" of
  deployed apps at the time of the Series B.
  - Source: [TechCrunch (July 28, 2022)](https://techcrunch.com/2022/07/28/fly-io-wants-to-change-the-way-companies-deploy-apps-at-the-edge/)

---

## Controversies & culture

- **Radical transparency about reliability (2022–2023).** Fly.io is widely
  noted for unusually candid public postmortems and status writing. The
  flagship example is Mackey's **"Reliability: It's Not Great"** (Mar 6, 2023),
  which openly admitted months of instability, named the failing internal
  systems (Consul, then the immature Corrosion), and included a CEO confessing
  "a debilitating feeling of failure."
  - Source (primary): [Reliability: It's Not Great — Fly.io community](https://community.fly.io/t/reliability-its-not-great/11253)
  - Source (coverage): [DevClass (Mar 7, 2023)](https://devclass.com/2023/03/07/fly-io-ceo-says-reliability-not-great-as-platform-suffers-scaling-issues/)

- **Community reaction — split (attributed).** Per DevClass's reporting, the
  post drew both praise and criticism:
  - *Praise:* some users called Fly "one of the most well designed and tasteful
    cloud offerings to date" and appreciated the honesty.
  - *Criticism:* others questioned production-readiness and "spottiness."
    DevClass paraphrases concerns about a company that had years and tens of
    millions in funding still missing "basic fundamentals."
  - Attribution: these reactions are reported by **DevClass** (and the linked
    Fly.io community thread), not endorsed here.
  - Source: [DevClass (Mar 7, 2023)](https://devclass.com/2023/03/07/fly-io-ceo-says-reliability-not-great-as-platform-suffers-scaling-issues/)
  - **Could not verify** specific quoted reactions beyond what DevClass and the
    community thread attribute.

- **The engineering-blog "voice."** Fly's blog (heavily associated with Thomas
  Ptacek) is frequently cited as best-in-class developer marketing; Fly itself
  jokes about "The downside of Thomas writing job postings." Hacker News
  commenters have remarked on the distinctive tone of Fly.io blog posts.
  - Source (HN discussion of the blog's tone): [Hacker News item 31497767](https://news.ycombinator.com/item?id=31497767)
  - This is **culture/opinion**, attributed to the cited HN discussion and Fly's
    own self-deprecating framing — not a factual claim about quality.

- **"We were wrong" as a recurring posture.** Fly has twice publicly declared a
  strategic bet wrong — edge JavaScript runtimes (early), and GPUs (Feb 2025) —
  framing both as honest course-corrections. Whether this is admirable candor
  or a pattern of mis-bets is a matter of opinion; the **primary fact** is that
  Fly published both retrospectives itself.
  - Source: [We Were Wrong About GPUs — The Fly Blog (Feb 14, 2025)](https://fly.io/blog/wrong-about-gpu/)

---

## Open items / "Could not verify" summary

- Exact founding date (month/day) and legal entity name ("Fly.io, Inc.").
- The complete four-person founder list, specifically whether **Michael Dwan**
  and **Thomas Ptacek** are co-founders vs. early/principal employees
  (first-party Fly.io confirmation lacking; secondary sources conflict).
- **Thomas Ptacek's** precise title at Fly.io.
- **Ben Johnson's** exact start date at Fly.io.
- The **~$1B valuation** in the task brief — **not supported**; documented
  valuations top out at ~$467M (2023 Series C, secondary sourcing).
- Heroku free-tier shutdown date (Nov 28, 2022) against Heroku's own
  announcement (used secondary sourcing).
