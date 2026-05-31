# "We Wouldn't Have Needed Docker": The Solomon Hykes WASM+WASI Tweet — An Alternate-History and Discourse Analysis

A fully-sourced analysis of the famous 2019 tweet by Docker creator **Solomon
Hykes** asserting that if WebAssembly + WASI had existed in 2008, "we wouldn't
have needed to create Docker" — what it meant, the discourse it triggered, the
companies and projects that have since chased the "server-side WASM as the next
Docker" vision, and the skeptical counter-take (including Hykes's own later
walk-back).

Every non-trivial claim carries a working source link. Opinions and predictions
are attributed to the specific person or outlet that made them. Where a detail
could not be confirmed against a primary or reputable secondary source, it is
explicitly flagged **Could not verify:**. No quotes are paraphrased as if
verbatim; where wording varies across reproductions, the variance is noted.

> Cross-references: `history/docker.md` (Solomon Hykes / Docker history),
> `history/dagger.md` (Hykes's post-Docker company), `history/helm.md` (Matt
> Butcher → Fermyon → Akamai thread, already sourced there).

---

## 1. The actual quote

### Verbatim text

On **March 27, 2019**, Solomon Hykes (@solomonstre) tweeted:

> "If WASM+WASI existed in 2008, we wouldn't have needed to created Docker.
> That's how important it is. Webassembly on the server is the future of
> computing. A standardized system interface was the missing link. Let's hope
> WASI is up to the task!"

- Primary source (tweet): https://x.com/solomonstre/status/1111004913222324225
  — the tweet page is access-restricted to automated fetchers (returned an
  HTTP 402/login wall), but the title/preview text returned by search engines
  reproduces the wording above, and it is reproduced identically by the
  secondary sources below.
- Secondary reproduction (Medium, Tobias Andersen, "Solomon Hykes, author of
  Docker..."): https://medium.com/@ZaradarTR/solomon-hykes-author-of-docker-if-wasm-wasi-existed-in-2008-we-wouldnt-have-needed-to-created-ff049725a0bd
- Secondary reproduction (Hacker News submission of the tweet/topic, item
  19506458): https://news.ycombinator.com/item?id=19506458

**Note on the typo.** The tweet contains the grammatical slip "we wouldn't have
needed to **created** Docker" (not "to create"). This typo is present in the
canonical reproductions of the tweet. Some later articles silently "correct" it
to "needed to **have** created Docker" (e.g., InfoWorld's 2024 retrospective —
see §5), so the exact downstream wording varies. The canonical first-person
wording is the version with "created."

**Date.** The tweet is dated **March 27, 2019**. This is corroborated indirectly
but firmly: it was posted the same day Mozilla published Lin Clark's WASI
announcement blog post, also dated **March 27, 2019** (see §2). The widely
repeated framing — that Hykes was reacting to the Mozilla/Bytecode-Alliance-era
WASI announcement — is consistent with this date.

- Could not verify: the exact UTC timestamp / hour of the tweet (the live tweet
  page would confirm it, but it was not machine-fetchable).

### A same-thread follow-up

Hykes posted a follow-up the next day (March 28, 2019) addressing the immediate
"wasm vs Docker" reaction:

> "For those asking about wasm vs Docker: [link]"

- Source (tweet, not machine-fetched; surfaced via search):
  https://x.com/solomonstre/status/1111140473328984064
- Could not verify: the full text of the linked follow-up content (the tweet
  links out; the linked thread/article body was not retrievable here). Treat the
  follow-up as "exists and signals he was already managing the 'vs Docker'
  misreading," not more.

---

## 2. What it means

### The claim, decoded

Hykes's argument is not that WASM is a container runtime. It is that the *reason*
Docker had to be invented — packaging an application together with enough of an
operating-system userland to run portably and in isolation — is largely
dissolved if you have (a) a portable compilation target and (b) **a standardized
system interface** so that the portable binary can talk to the host OS in a
uniform, sandboxed way. Hykes names that second piece explicitly as "the missing
link," and identifies **WASI** as the candidate to fill it.

### WASI: the "missing link"

**WASI** (the WebAssembly System Interface) was announced by Mozilla on **March
27, 2019**, in a blog post by **Lin Clark**.

- Source: Lin Clark, "Standardizing WASI: A system interface to run WebAssembly
  outside the web," Mozilla Hacks, March 27, 2019:
  https://hacks.mozilla.org/2019/03/standardizing-wasi-a-webassembly-system-interface/

Key ideas from that post, which directly underpin the Hykes thesis:

- The core problem statement, in Clark's words: *"Code outside of a browser
  needs a way to talk to the system — a system interface."* (Mozilla Hacks,
  ibid.)
- **Portable binaries / "compile once, run anywhere."** Clark: *"We need to be
  able to compile once and run across a whole bunch of different machines. We
  need portable binaries."* WASI defines *"a single conceptual operating system
  interface, which can be implemented by multiple, actual operating systems."*
  (Mozilla Hacks, ibid.)
- **Capability-based security.** Instead of a program being able to open any
  path on the filesystem, it must be *handed* a capability. Clark: *"With WASI,
  if you're calling a function that needs to access a file, you have to pass in
  a file descriptor, which has permissions attached to it."* (Mozilla Hacks,
  ibid.) This is the security argument: a WASM module is deny-by-default and only
  gets the host capabilities it is explicitly granted — a stronger isolation
  posture than a container that inherits a broad Linux syscall surface.

The other commonly cited advantages — near-instant cold starts and small
artifact size — flow from the fact that a WASM module is a sandboxed bytecode
unit that does not need to boot an OS userland. (These are real but
context-dependent; the cold-start advantage applies to *native* WASM runtimes,
not to the Docker+Wasm hybrid path — see the skeptics' section §5.)

### The standardization machinery: Bytecode Alliance, wasmtime, the WASI arc (P1 → P2), Component Model + WIT

**The Bytecode Alliance.** The institutional backbone of the server-side vision.

- **Founding (Nov 2019).** Announced by **Mozilla, Fastly, Intel, and Red Hat**
  to build a "secure by default, composable future for WebAssembly."
  - Source: "Announcing the Bytecode Alliance," Mozilla Hacks, Nov 13, 2019:
    https://hacks.mozilla.org/2019/11/announcing-the-bytecode-alliance/
  - Mission language ("secure by default... where security, efficiency, and
    modularity can all coexist across the widest possible range of devices"):
    Mozilla Press Center, Nov 13, 2019:
    https://blog.mozilla.org/press/2019/11/new-bytecode-alliance-brings-the-security-ubiquity-and-interoperability-of-the-web-to-the-world-of-pervasive-computing/
- **Microsoft was NOT a founding member.** This is a common error. Microsoft
  joined when the Alliance **incorporated as a 501(c)(6) nonprofit in April
  2021**, alongside the original four — at which point the "incorporating
  members" were listed as **Fastly, Intel, Microsoft, and Mozilla**.
  - Source: "Growing the Bytecode Alliance," The Mozilla Blog, 2021:
    https://blog.mozilla.org/en/mozilla/growing-the-bytecode-alliance/
  - Correction note for this doc's history: the 2019 founders are Mozilla,
    Fastly, Intel, Red Hat; Microsoft is a 2021 incorporating member.

**wasmtime** is the Alliance's reference WASM/WASI runtime; Fastly's earlier
**Lucet** runtime was folded into wasmtime in mid-2020 (see §4, Fastly).

- Source (repo): https://github.com/bytecodealliance/wasmtime

**The WASI standardization arc (Preview 1 → Preview 2).** WASI did not arrive
fully formed in 2019; it evolved through two milestone releases, "0.1/Preview 1"
and "0.2/Preview 2."

- **WASI 0.1 / "Preview 1" (P1).** The first widely-used iteration, with APIs
  defined in the **`witx`** IDL — a lower-level format derived from the
  WebAssembly text format, heavily influenced by **POSIX** and **CloudABI**.
  P1 is what `GOOS=wasip1`, TinyGo's `wasip1`, and most early tooling target.
  - Source (WASI repo, P1 vs P2 history): https://github.com/WebAssembly/WASI
  - Source (wasi.dev intro): https://wasi.dev/
- **WASI 0.2 / "Preview 2" (P2).** Released **January 25, 2024**, when the WASI
  Subgroup voted to declare its APIs stable. P2 re-bases all of WASI on the
  **WebAssembly Component Model**, replacing `witx` with **WIT** (the WebAssembly
  Interface Types IDL), and incorporates lessons from P1: more source languages,
  modularity, a richer type system, and *virtualizability* (interfaces can be
  satisfied by host *or* by another component).
  - Source: Bytecode Alliance, "WASI 0.2 Launched," Jan 25, 2024:
    https://bytecodealliance.org/articles/WASI-0.2
  - Source (WIT as the IDL; "five-phase" standardization process; 0.1 vs 0.2
    framing): https://wasi.dev/ and https://github.com/WebAssembly/WASI
- **WASI APIs are individual proposals**, each moving through a **five-phase**
  standardization process (proposal → description → implementation →
  standardization → final). As of this writing the P2 core APIs — `wasi-clocks`,
  `wasi-random`, `wasi-filesystem`, `wasi-sockets`, `wasi-cli`, and
  **`wasi-http`** — are at **Phase 3 (implementation)**, while **`wasi-nn`**
  (machine-learning inference, see §9) sits earlier at **Phase 2**.
  - Source (interface list + phases): https://wasi.dev/interfaces

**The Component Model + WIT** is the piece many proponents call the *real*
"missing link" for the server vision: a language-agnostic ABI for *composing*
WASM modules (a Rust component calling a Go component calling a JS component),
with shared-nothing isolation between them and typed interfaces described in WIT
"worlds."

- Source: The WebAssembly Component Model docs, Bytecode Alliance:
  https://component-model.bytecodealliance.org/
- Source (FAQ: Preview 1 was `witx`-based and is deprecated; Preview 2 uses WIT):
  https://component-model.bytecodealliance.org/reference/faq.html
- Source (an accessible explainer): Fermyon, "WebAssembly, WASI, and the
  Component Model": https://www.fermyon.com/blog/webassembly-wasi-and-the-component-model

**Key early proposals worth naming** (each a real WASI subgroup proposal):

- **`wasi-http`** — outbound/inbound HTTP for WASM components; a P2 core world.
  Source: https://wasi.dev/interfaces
- **`wasi-nn`** — a host-provided neural-network *inference* API (graphs +
  tensors), so a guest module can run ML on the host's CPU/GPU/TPU via backends
  like OpenVINO or ONNX. Inference only, not training. (Revisited in §9, the AI
  frontier.)
  - Source (proposal repo): https://github.com/WebAssembly/wasi-nn
  - Source (wasmtime implementation writeup): https://bytecodealliance.org/articles/implementing-wasi-nn-in-wasmtime

---

## 3. The discourse

This is opinion-heavy territory; takes below are attributed to the specific
commenter or outlet.

### The original 2019 Hacker News thread

The Mozilla WASI announcement was submitted to Hacker News on **March 27, 2019**
(item 19506458). In that thread the top-voted comment surfaced the Hykes tweet
and set the framing that dominated discussion for years afterward:

- **hathawsh:** *"Solomon Hykes, co-founder of Docker, believes WASM+WASI could
  take the place of Docker."*
- **talkingtab:** *"This. I don't have a clear enough mental model for either
  docker or wasm+wasi, but I immediately thought of docker."* and, elsewhere in
  the thread, *"What is docker except a bunch of purpose built operating system
  instances? And why do we need Linux installations when we could just run on
  WASI?"*
- **59nadir** (a concrete, bullish data point): *"WASI would give me near-native
  performance for this one without any additional work... Even a 2x performance
  cost from native would mean a massive boost in performance and management in
  comparison to running it through Docker Desktop."*
- **pjmlp** (drawing the unikernel parallel): *"This is the same reason that
  things like unikernels have been built for. They haven't taken off because of
  how difficult it is to rebuild your application to also contain its kernel,
  but this kind of sandboxing with WASM and WASI doesn't require that..."*

Source for all four: https://news.ycombinator.com/item?id=19506458
(Comment text retrieved via the HN/Algolia comment API; usernames as shown.)

- Could not verify: the precise points/comment-count of the 2019 submission (the
  HN item page and Algolia item endpoint did not return the root story's
  points/created_at fields cleanly to the fetcher). The thread's existence,
  title topic (the WASI blog post), 2019 date, and the quoted comments are
  verified.

### Later HN threads continuing the debate

- **"Why WebAssembly is innovative even outside the browser"** (HN item
  28109699, Aug 8, 2021). The tweet was re-surfaced; skeptic **junon** pushed
  back hard: *"WASM can't handle half the things Docker needs to run. I'm
  genuinely confused as to how he can say the two are equivalent in any way,"*
  and *"WASI doesn't support arbitrary syscalls, so running containers would not
  work in WASM."* Bullish commenter **sitkack** countered that *"Wasm is two
  things, CFI and capabilities, everything else is an implementation detail,"*
  arguing critics were misreading the isolation claim.
  - Source: https://news.ycombinator.com/item?id=28109699
- **"WASM will replace containers"** (HN item 43020684, **325 points, ~356
  comments, Feb 12, 2025**) — the largest and most recent of the recurring
  threads, kicked off by a bullish blog post of the same name by **hpincket**
  (Creston Bunch, creston.blog). Named takes from the thread:
  - **hardwaresofton** (bullish): argued WASM's combination of sandboxing,
    startup time and execution speed is "near unmatched," and that WASM "will
    silently and usefully be everywhere later... much more desirable than
    building a container."
  - **yencabulator / trescenzi** (nuanced, the most-cited counter): containers
    serve *two* goals — reproducibility *and* encapsulation — and "WASM could
    replace the reproducibility but it can't replace the encapsulation."
  - **pjmlp** (skeptical, the unikernel-parallel commenter again): "Yet another
    bytecode based runtime, but being sold as if it is the very first of its
    kind, despite prior history."
  - **funcDropShadow** (skeptical): "All of this sounds too good to be true...
    The track record of attempts to build the one true solution for all our
    problems is quite bad."
  - **titzer** (skeptical, *and notable* — this is **Ben Titzer**, co-creator of
    WebAssembly and a V8/Wizard-engine author): pushed back on the "WASI is
    trivial to implement everywhere" framing, noting a conformant WASI
    implementation is on the order of "~2000 lines of C code" per engine.
  - Source (thread): https://news.ycombinator.com/item?id=43020684
  - Source (the blog post it discusses): https://creston.blog/wasm-will-replace-containers/
- **"What happened to WebAssembly"** (HN item 46551044, **Jan 9, 2026**) — a
  fresh, post-WASI-0.2 re-litigation of the whole premise. Named takes:
  - **azakai** (bullish-but-measured — this is **Alon Zakai**, creator of
    **Emscripten**): defended WASM's raison d'être on *performance and
    portability* for "huge, complex applications" (Unity, Photoshop), conceding
    "JS can be as fast as wasm, but generally isn't on huge, complex
    applications."
  - **mike_hearn** (skeptical): "WASI is just a very small subset of POSIX but
    with stuff renamed so nothing works on it."
  - **torginus** (skeptical, historical): argued Google's earlier **Native
    Client** "was already almost as fast as native code, started up almost
    instantly," and that WASM hasn't clearly beaten its own predecessor after a
    decade.
  - Source: https://news.ycombinator.com/item?id=46551044
- **"Here's a tweet from Solomon Hykes..."** (HN item 30020855) — another
  re-surfacing of the tweet.
  - Source: https://news.ycombinator.com/item?id=30020855

### lobste.rs threads (named, lower-volume but higher signal)

- **"webassembly: the new kubernetes?"** — the lobste.rs community pushed back on
  the framing, with the consensus that WASM is positioned as a replacement for
  *OCI containers* (a packaging + isolation unit), **not** for Kubernetes (a
  fleet orchestrator) — a useful disambiguation of the "replace Docker" meme.
  - Source: https://lobste.rs/s/bthzfk/webassembly_new_kubernetes
- **"WebAssembly: A promising technology that is quietly being sabotaged"**
  (May 18, 2025) — a widely-shared **skeptical** essay by **Sylvain Kerkour**
  arguing that WASI 0.2 / the Component Model have grown *more* complex than the
  problem they set out to solve, and that the standards process is the bottleneck.
  It was independently amplified by **Baldur Bjarnason** and re-debated on HN
  ("...quietly being enshitified," item 40439681).
  - Source (essay): https://web.archive.org/web/2id_/https://kerkour.com/webassembly-wasi-preview2
  - Source (lobste.rs): https://lobste.rs/s/u1izmf/webassembly_promising_technology_is
  - Source (Baldur Bjarnason's note): https://notes.baldurbjarnason.com/2024/05/22/webassembly-a-promising.html
  - Source (HN re-debate): https://news.ycombinator.com/item?id=40439681

### Conference-stage takes (WasmCon, Wasm I/O, KubeCon)

The server-side vision has its own conference circuit; the keynotes are where the
named proponents lay out the *real* "missing link" argument (the Component Model,
not WASM-the-bytecode).

- **WasmCon 2023** (Linux Foundation, Sept 2023, Bellevue WA). Two keynotes set
  the tone, both bullish on *components* as the unlock:
  - **Luke Wagner** (Fastly; original co-designer of WebAssembly and lead of the
    Component Model proposal), keynote **"What is a Component (and Why)?"** — the
    motivation/principles talk for the Component Model.
  - **Bailey Hayes** (then Cosmonic CTO; WASI Subgroup co-chair), keynote **"Are
    We Componentized Yet?"** — a "state of the program" survey of what remained
    before a stable Component Model could ship.
  - Source (schedule): https://wasmcon2023.sched.com/
  - Source (Fermyon/Akamai recap): https://www.akamai.com/blog/developers (the
    original Fermyon recap "WasmCon 2023: The Rise and Realization of the
    WebAssembly Component Model" now redirects here after the Akamai acquisition)
- **WasmCon 2024** (Salt Lake City, co-located with KubeCon NA). **Luke Wagner**
  keynote **"Incrementally Extending WASI 0.2 to 0.3 and Beyond"**; **Bailey
  Hayes** gave closing remarks and joined a security panel ("Playing Safely in
  the Sandbox") with Wagner.
  - Source (schedule): https://wasmcon24.sched.com/
- **Wasm I/O 2024** (Barcelona, Mar 14–15, 2024). A components-heavy program; a
  notable panel featured **Bailey Hayes** (Cosmonic / WASI co-chair) with
  **Daniel Caballero** (Fastly), **Oscar Spencer** (Principal Engineer at F5
  NGINX; co-created the **Grain** WASM-first language with Philip Blair) and
  **Saúl Cabrera** (Shopify, creator of **Javy**) on components in cloud-native
  computing.
  - Source (sessions): https://2024.wasm.io/sessions/ ; speakers:
    https://2024.wasm.io/speakers/

### Vendor / practitioner blog discourse

- **Docker's own framing** ("Wasm vs. Docker"): Docker published a post arguing
  the two are complementary, not a zero-sum replacement.
  - Source: https://www.docker.com/blog/wasm-vs-docker/
- **Matt Butcher / Fermyon** ("third wave of cloud computing"): Butcher frames
  server-side WASM as the start of a new wave of cloud computing, distinct from
  VMs and containers.
  - Source (InfoQ podcast, "Matt Butcher on Web Assembly as the Next Wave of
    Cloud Computing"): https://www.infoq.com/podcasts/cloud-computing-web-assembly/
  - Source (Insight Partners profile): https://www.insightpartners.com/ideas/fermyon-ceo-matt-butcher-on-building-serverless-cloud-platform/
- **Bill Doerrfeld** (InfoWorld / personal site) — a balanced practitioner
  survey, "Can Wasm replace containers?", which both quotes Hykes's original
  tweet *and* his later walk-back (see §5).
  - Sources: https://www.infoworld.com/article/3600287/can-wasm-replace-containers.html
    and https://www.doerrfeld.io/can-wasm-replace-containers

### Hykes's own later position: from "wouldn't have needed Docker" to "containerize the agents"

The most important later "clarification" is not just the 2024 walk-back quoted in
§5 — it is the *direction* Hykes himself took. His post-Docker company **Dagger**
(cross-ref `history/dagger.md`) and its 2025 **Container Use** project answer the
"how do you safely run untrusted/AI-generated code" question with **containers**,
not WASM:

- **Container Use** is an open-source MCP server that gives coding agents
  isolated, *containerized* environments so multiple agents don't interfere with
  each other.
  - Source (project): https://github.com/dagger/container-use
  - Source (Hykes interview, "Agentic CI/CD," Agentic DevOps podcast):
    https://agenticdevops.fm/episodes/agentic-ci-cd-with-solomon-hykes-of-dagger
  - Source (Hykes, "Open Source Ready" ep. 17, AI-native software factories):
    https://www.heavybit.com/library/podcasts/open-source-ready/ep-17-ai-native-software-factories-with-solomon-hykes
- The throughline is consistent with his 2024 "containers will always be there"
  stance: the man who once mused WASM could have obviated Docker now ships a
  *container*-based isolation layer for the hottest new untrusted-code workload
  (AI agents). This is itself the strongest attributed evidence against the
  literal "WASM replaces containers" reading — from the author of the tweet.

### Additional bullish/skeptical takes (attributed)

- **CNCF (bullish, ecosystem framing).** In Sept 2023 the CNCF published a "Wasm
  landscape," explicitly positioning server-side WASM as a category worth
  tracking alongside cloud-native — a signal the foundation behind Kubernetes
  took the server vision seriously.
  - Source: https://www.cncf.io/blog/2023/09/06/introducing-the-wasm-landscape/
- **The WASIX schism (Akbary vs. Schneidereit) — a named standards fight.** In
  May 2023 Wasmer's **Syrus Akbary** shipped **WASIX**, a POSIX-flavored superset
  of WASI (adding threads, processes, `fork`, sockets) so that "Bash, Nginx,
  Redis, Curl" could run on WASM. **Till Schneidereit** (Bytecode Alliance
  co-founder, TSC member) publicly called it a fragmenting fork, grouping it with
  "non-standard system interfaces... such as the Emscripten ABI... or WASIX," and
  argued the Component Model + WASI is "the better approach." This is the
  sharpest *named* disagreement inside the server-WASM camp itself — not
  WASM-vs-Docker, but two visions of *how* server WASM should reach POSIX-grade
  capability.
  - Source (Akbary's WASIX announcement): https://wasmer.io/posts/announcing-wasix
  - Source (the dispute, both sides quoted, InfoWorld): https://www.infoworld.com/article/2338660/wasix-undermines-webassembly-system-interface-spec-bytecode-alliance-says.html
- **Frank Denis (skeptic-leaning, empirical).** A widely-cited independent
  benchmark of WASM runtimes ("Performance of WebAssembly runtimes in 2023")
  pushed back on hand-wavy "near-native" claims by actually measuring runtime
  spread — useful ballast against marketing numbers.
  - Source: https://00f.net/2023/01/04/webassembly-benchmark-2023/
- **"WASM will replace containers" (HN item 43020684)** and **"Here's a tweet
  from Solomon Hykes..." (HN item 30020855)** — recurring re-surfacings showing
  the meme's half-life (already listed in §3 below).

---

## 4. The companies and projects pursuing the vision

### Runtimes and platform startups

- **Fermyon** — founded **2021** by **Matt Butcher** (Helm/Deis co-creator) and
  **Radu Matei**, after ~10 colleagues left Microsoft to start it. Open-source
  flagship: **Spin** (a developer tool for building WASM/WASI serverless
  microservices), first released March 31, 2022; **Spin 1.0** released March 22,
  2023. **Akamai acquired Fermyon on December 1, 2025** (Butcher and Matei
  joined Akamai's Cloud Technology Group).
  - Founding / "next wave": https://www.insightpartners.com/ideas/fermyon-ceo-matt-butcher-on-building-serverless-cloud-platform/
  - Spin 1.0 release: https://www.globenewswire.com/news-release/2023/03/22/2632499/0/en/Fermyon-Releases-Spin-1-0-the-Easiest-Way-for-Developers-to-Build-WebAssembly-Serverless-Functions.html
  - Akamai acquisition: https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon
    and https://www.fermyon.com/blog/fermyon-joins-akamai
  - (Already sourced in `history/helm.md`, §"The Matt Butcher → Fermyon → Akamai
    thread.")
- **Cosmonic / wasmCloud** — wasmCloud is a CNCF-hosted WebAssembly application
  orchestrator; Cosmonic (the company behind it) donated the runtime to the
  CNCF.
  - Source: https://devops.com/cosmonic-contributes-webassembly-runtime-to-cncf/
  - Source: https://wasmcloud.com/ ; project home: https://cosmonic.com/
- **Wasmer** — founded **2018** by **Syrus Akbary**; a "universal" WASM runtime
  with the goal of running software "safely and at native speeds" outside the
  browser; reached general availability (Wasmer 1.0) in January 2021. Y
  Combinator company.
  - Source (GA / 1.0): https://www.infoq.com/news/2021/01/wasmer-generally-available/
  - Source (YC profile): https://www.ycombinator.com/companies/wasmer
  - Could not verify here: specific 2019 funding-round figures for Wasmer (not
    found in primary sources during this pass).
- **WasmEdge** (originally from **Second State**) — a lightweight,
  high-performance WASM runtime targeting cloud-native, edge, and decentralized
  apps; a CNCF sandbox project. It is the runtime Docker partnered with for the
  first Docker+Wasm preview.
  - Source (repo / CNCF): https://github.com/WasmEdge/WasmEdge
- **Suborbital** — founded by **Connor Hicks**; raised $1.6M (Nov 2021) for a
  WASM extensibility/edge-compute platform; **acquired by F5 in July 2023**
  (team and tech folded into F5 Distributed Cloud).
  - Source (funding): https://techcrunch.com/2021/11/23/suborbital-raises-1-6m-for-its-webassembly-platform/
  - Source (F5 acquisition, company page): https://www.linkedin.com/company/suborbital-software-systems
  - Could not verify: a standalone press release with the exact F5 acquisition
    terms/date beyond the "acquired by F5" attribution on the company's own
    LinkedIn page; treat "July 2023, undisclosed, folded into F5 Distributed
    Cloud" as reported-not-primary.
- **Lunatic** — an Erlang-inspired runtime for WebAssembly (actor model,
  process isolation).
  - Source: https://lunatic.solutions/ and https://github.com/lunatic-solutions/lunatic
- **Extism** — a "universal plug-in system" built on WASM: make any app
  extensible with sandboxed WASM plugins, with a common host interface across
  servers, edge, CLIs, IoT and browsers. An open-source product from the
  **Dylibso** team. (Now verified against primary sources; revisited in §8.)
  - Source (site): https://extism.org/
  - Source (repo): https://github.com/extism/extism
  - Source (Dylibso product page): https://dylibso.com/products/extism/

### Edge / serverless platforms running WASM in production

- **Fastly Compute@Edge** — built first on Fastly's **Lucet** runtime (announced
  **March 28, 2019** — one day after the WASI announcement), which was open
  sourced and later **merged into wasmtime in mid-2020**.
  - Source (Lucet announcement): https://www.fastly.com/blog/announcing-lucet-fastly-native-webassembly-compiler-runtime
  - Source (Lucet → wasmtime, repo): https://github.com/bytecodealliance/lucet
- **Cloudflare Workers** — runs primarily on **V8 isolates**, and *also* supports
  compiling/running **WASM** modules inside Workers. (Notable: Cloudflare's
  primary isolation boundary is V8 isolates, *not* WASM — a point the skeptics
  use; see §5.)
  - Source: https://developers.cloudflare.com/workers/runtime-apis/webassembly/
  - Source: https://blog.cloudflare.com/webassembly-on-cloudflare-workers/
- **Shopify Functions** — every function runs as a **WASI module**; Shopify built
  **Javy**, a JavaScript-to-WebAssembly toolchain (by Saúl Cabrera), so that JS
  authors can target WASM.
  - Source: https://shopify.engineering/javascript-in-webassembly-for-shopify-functions

### The container world's embrace

- **Docker + Wasm** — announced as a **technical preview in October 2022** at
  Cloud Native Wasm Day (KubeCon NA 2022), in partnership with **WasmEdge**;
  **Technical Preview 2** (March 2023) added more runtimes.
  - Source (preview): https://www.docker.com/blog/docker-wasm-technical-preview/
  - Source (TP2): https://www.docker.com/blog/announcing-dockerwasm-technical-preview-2/
  - Source (InfoQ): https://www.infoq.com/news/2022/11/docker-webassembly/
- **runwasi / containerd-wasm-shims** — `runwasi` is a Rust library (originally
  from Microsoft DeisLabs) for writing **containerd shims** that run WASM
  workloads; later donated to the CNCF **containerd** org. The
  `containerd-wasm-shims` repo provides the shims for Spin/WasmEdge/etc.
  - Source: https://github.com/deislabs/containerd-wasm-shims
- **SpinKube** — a CNCF Sandbox project (accepted **Jan 21, 2025**) from the
  Fermyon/Spin lineage, with heavy Microsoft involvement (Ralph Squillace, David
  Justice) and SUSE/Liquid Reply, for running Spin WASM apps on Kubernetes.
  (Fully sourced in §8.5.2; also referenced in `history/helm.md`.)
- **Krustlet** — Microsoft DeisLabs' Rust **kubelet** that ran WASM/WASI pods on
  Kubernetes (announced April 2020). It was an early-but-superseded approach:
  it marked a whole node as a "special" WASM node, an architecture the ecosystem
  largely moved past in favor of containerd shims (runwasi).
  - Source (announcement): https://opensource.microsoft.com/blog/2020/04/07/announcing-krustlet-kubernetes-rust-kubelet-webassembly-wasm
  - Could not verify (precisely): the GitHub "archived" status/date of
    `deislabs/krustlet`. Secondary coverage indicates the *approach* was
    superseded by runwasi-style shims; the repo's archived flag itself was not
    confirmed in this pass. Flag as **verify archived status**.
- **Bytecode Alliance** — the standards/runtime backbone (Mozilla, Fastly, Intel,
  Red Hat; wasmtime; WASI/Component Model) — see §2.

---

## 5. Skeptical / reality-check views (attributed)

The single most important skeptic is **Hykes himself**, who later disowned the
"replace Docker" reading of his own tweet.

- **Solomon Hykes (2024 clarification):** *"That tweet of mine was widely
  misunderstood. It was interpreted as WebAssembly is going to replace Docker
  containers. I did not think then that it would happen, and lo and behold, it
  did not happen, and in my opinion, will never happen."* He added that
  *"Containers are now a core feature of Linux... They will always be there,"*
  and that server-side WASM is *"missing a mainstream use case, a reason everyone
  must use it on the server."*
  - Source (InfoWorld, Bill Doerrfeld, "Can Wasm replace containers?", Nov 11,
    2024): https://www.infoworld.com/article/3600287/can-wasm-replace-containers.html
  - The discussion this clarification came from is Hykes's LinkedIn post "Can
    Wasm replace containers?":
    https://www.linkedin.com/posts/solomonhykes_can-wasm-replace-containers-activity-7261844467496665088-_g97
  - Could not verify: the *exact* verbatim transcript and the precise venue
    (panel vs. interview) where Hykes spoke these words; InfoWorld presents them
    as a quote but does not name the originating event in the fetched text.
    Treat the wording as InfoWorld's reported quotation.

- **The "complementary, not replacement" consensus.** InfoWorld's survey
  concludes Wasm will *not* replace containers wholesale; rather, *"use Docker
  containers when you need a full OS environment or have legacy apps, use
  WebAssembly when you need lightweight safe extension and speed."* WASM's
  strongholds are edge, serverless, and IoT; *"stateful, long-running compute and
  appliances like databases are unlikely to be replaced with Wasm."*
  - Source: https://www.infoworld.com/article/3600287/can-wasm-replace-containers.html

- **Cold-start nuance.** Reality-check reporting notes the sub-millisecond
  cold-start claim applies to *native* runtimes (wasmtime, Spin), and that the
  **Docker+Wasm hybrid path can actually be slower than plain containers** for
  startup, because you pay both container *and* WASM-init overhead. (Reported in
  2026 retrospective coverage; treat the specific 65–325 ms figure as that
  outlet's benchmark claim, not an independently verified number.)
  - Source: Java Code Geeks, "WebAssembly in 2026: Three Years of 'Almost
    Ready'": https://www.javacodegeeks.com/2026/04/webassembly-in-2026-three-years-of-almost-ready.html
  - Could not verify independently: the exact "65–325 ms slower" and "1.1–1.3×
    CPU overhead" figures (single-outlet benchmark claims).

- **Ecosystem / maturity gaps.** Multiple 2024–2025 surveys flag that mass
  adoption has not arrived; the gating items include the Component Model
  finalization, multi-language and multi-threading support, and a maturing WASI
  networking stack.
  - Source (TechTarget, "Server-side Wasm to-do list lengthens for 2024"):
    https://www.techtarget.com/searchitoperations/news/366564235/Server-side-Wasm-to-do-list-lengthens-for-2024
  - Source (HN skeptic junon, 2021): WASI "doesn't support arbitrary syscalls,
    so running containers would not work in WASM" —
    https://news.ycombinator.com/item?id=28109699

- **The "still almost ready" critique.** A 2026 retrospective argues the
  server-side story has spent years "borrowing the browser's credibility" without
  delivering: *"'In production somewhere' and 'a serious consideration for your
  next backend service' are two very different things. The first is true. The
  second keeps failing to arrive."*
  - Source (Java Code Geeks, opinion): https://www.javacodegeeks.com/2026/04/webassembly-in-2026-three-years-of-almost-ready.html
  - This is one outlet's opinion piece; attribute accordingly.

---

## 6. Verdict (as of 2025–2026)

What can be stated with confidence and sourcing:

1. **The tweet was real, dated March 27, 2019, and is accurately quoted above**
   (including its "needed to created" typo). It coincided with Mozilla's WASI
   announcement the same day.
2. **The "missing link" Hykes named — a standardized system interface — did get
   built.** WASI reached a *stable* 0.2 ("Preview 2") on **January 25, 2024**,
   now grounded in the Component Model + WIT. (Bytecode Alliance.)
3. **A real industry has formed around the vision** — Fermyon/Spin (now Akamai),
   wasmCloud/Cosmonic (CNCF), Wasmer, WasmEdge (CNCF), plus production WASM at
   **Fastly Compute@Edge** and **Shopify Functions**, and WASM support inside
   **Cloudflare Workers** and **Docker+Wasm / runwasi / SpinKube**.
4. **But the strong reading of the tweet — WASM replacing containers — has not
   happened, and the tweet's own author publicly says it never will.** The
   sourced consensus (InfoWorld; Docker; Hykes himself) is *complementary, not
   replacement*: WASM wins at edge/serverless/plugin/extensibility workloads;
   containers remain the default for full-OS, stateful, and legacy workloads.
5. **Several first-wave startups consolidated:** Suborbital → F5 (2023), Fermyon →
   Akamai (2025), early K8s approaches like Krustlet superseded by
   containerd-shim (runwasi) designs — a sign the space is maturing/consolidating
   rather than exploding into a container-displacing mainstream.

Net: the tweet was directionally prescient about *why* a standardized WASM system
interface matters, and it catalyzed a genuine ecosystem — but as a literal
"Docker killer" prediction it remains unrealized, a fact its author now states
plainly.

---

# Part II — What you can leverage TODAY (2026)

Everything below is shipping technology you can pull and use now. The
organizing thesis: the "wouldn't have needed Docker" debate has resolved into a
*two-track* reality. **WebAssembly** won the lightweight, deny-by-default,
portable-bytecode track (plugins, edge functions, embedding). **MicroVMs**
(Firecracker and kin) won the "run an arbitrary, untrusted *OS* workload with
hardware isolation" track (serverless, AI-agent sandboxes, dev environments).
The most interesting frontier (§9) is where they meet.

Each named technology, project, person, or company below carries a working URL.

## 7. The building blocks

### 7.1 WASM runtimes (host engines you can embed or run)

- **wasmtime** — the Bytecode Alliance reference runtime (Rust, Cranelift JIT;
  leads on Component Model + WASI 0.2 conformance). Best default for
  standards-tracking server-side WASM.
  - https://github.com/bytecodealliance/wasmtime
- **WasmEdge** — CNCF runtime (originally **Second State**), C++; strong on
  AI/edge with TensorFlow/PyTorch plugins and `wasi-nn`. The runtime Docker
  partnered with for the first Docker+Wasm preview.
  - https://github.com/WasmEdge/WasmEdge ; https://wasmedge.org/
- **Wasmer** — "universal" runtime (Rust); founded **2018** by **Syrus Akbary**;
  pluggable backends; promotes its own **WASIX** extension of WASI.
  - https://wasmer.io/ ; https://github.com/wasmerio/wasmer
- **wazero** — pure-**Go** runtime with **zero CGO** (Tetrate); the pragmatic
  pick when you want to embed WASM in a Go program without a C toolchain.
  - https://wazero.io/ ; https://github.com/tetratelabs/wazero
- **WAMR / WebAssembly Micro Runtime** — Bytecode Alliance, C; tiny footprint
  (AOT-only builds ~50 KB), multiple execution modes, Intel SGX support — the
  IoT/embedded choice. Originally from Intel.
  - https://github.com/bytecodealliance/wasm-micro-runtime
- **wasm3** — a fast WASM *interpreter* (no JIT), notable for the quickest cold
  start and running where JITs are disallowed.
  - https://github.com/wasm3/wasm3
- (Context for the spread above: an independent 2023 benchmark by **Frank
  Denis** — https://00f.net/2023/01/04/webassembly-benchmark-2023/ — and an
  ongoing comparison matrix — https://github.com/wasmruntime-io/wasm-runtime-comparison.)

### 7.2 Compile-to-WASM languages (what you can author guests in)

- **Rust** — best-in-class WASM/WASI/Component-Model support; the lingua franca
  of the ecosystem (the proxy-wasm, Spin, Extism, Zed-extension SDKs are
  Rust-first). https://www.rust-lang.org/what/wasm
- **C / C++** — via the **WASI SDK** (Clang/LLVM + `wasi-libc`, Bytecode
  Alliance) for WASI targets, or **Emscripten** for the browser (asm.js → WASM
  lineage). https://github.com/WebAssembly/wasi-sdk ;
  https://github.com/WebAssembly/wasi-libc ; https://emscripten.org/
- **Go** — *native* WASI since **Go 1.21** (Sept 13, 2023): `GOOS=wasip1
  GOARCH=wasm`, plus the `go:wasmimport` directive. https://go.dev/blog/wasi
  - **TinyGo** — LLVM-based Go compiler for "small places"; supports both
    `wasip1` and `wasip2` and can emit **WASI P2 components**.
    https://tinygo.org/docs/guides/webassembly/wasi/ and
    https://cosmonic.com/blog/engineering/compile-go-directly-to-webassembly-components-with-tinygo-and-wasi-p2
- **AssemblyScript** — TypeScript-like language that compiles to WASM. (Note:
  it *once* supported WASI but dropped first-class WASI support — verify current
  status before relying on it for server-side.)
  https://www.assemblyscript.org/
- **Zig** — first-class `wasm32-wasi` target in its compiler.
  https://ziglang.org/
- **Grain** — a functional language "built solely for the Wasm ecosystem,"
  leaning on WASM GC. https://grain-lang.org/
- **MoonBit** — newer language/toolchain aimed at cloud+edge WASM, "Rust-like
  with GC," optimized for very compact WASM output.
  https://www.moonbitlang.com/
- **Swift** — **SwiftWasm** (community org) brings Swift to WASM; includes
  **WasmKit** (a WASM runtime written in Swift). https://swiftwasm.org/ ;
  https://github.com/swiftwasm/WasmKit
- **Kotlin/Wasm** — official Kotlin target compiling to WASM (incl. Compose
  Multiplatform for the browser); uses the WASM GC proposal.
  https://kotlinlang.org/docs/wasm-overview.html
- **.NET / Blazor** — **Blazor WebAssembly** runs .NET in the browser on a
  WASM-based runtime. https://learn.microsoft.com/aspnet/core/blazor/
- **Python**:
  - **Pyodide** — CPython ported to WASM/Emscripten (browser & Node); created
    2018 by Michael Droettboom at Mozilla. https://pyodide.org/ ;
    https://github.com/pyodide/pyodide
  - **componentize-py** — produce a **WASI 0.2 component** from Python (Bytecode
    Alliance). https://github.com/bytecodealliance/componentize-py
- **JavaScript**:
  - **Javy** — compile JS to a single WASM module by embedding QuickJS
    (originally by **Saúl Cabrera** at Shopify; now Bytecode Alliance). Powers
    **Shopify Functions**. https://github.com/bytecodealliance/javy
  - **ComponentizeJS / StarlingMonkey** — turn JS into a WASI 0.2 *component*;
    **StarlingMonkey** is a SpiderMonkey-based JS runtime optimized for WASM
    components, used in production by **Fastly's JS Compute** and **Fermyon
    Spin's JS SDK**. https://github.com/bytecodealliance/StarlingMonkey ;
    https://github.com/bytecodealliance/ComponentizeJS
- **Ruby** — **ruby.wasm**: official CRuby ports to WASM, runnable in browsers
  and WASI runtimes. https://github.com/ruby/ruby.wasm
- (Cross-cut reference: CNCF's "Wasm landscape" and the community
  `awesome-wasm-langs` list track the full set —
  https://github.com/appcypher/awesome-wasm-langs.)

### 7.3 MicroVM / sandbox technologies (the Firecracker track)

- **Firecracker** — AWS's KVM-based VMM, **open-sourced Nov 2018**; powers **AWS
  Lambda** and **Fargate**. MicroVMs boot user code in **~125 ms**, run at
  **<5 MiB** memory overhead, and create at up to **150 microVMs/sec/host**. A
  companion process, the **Jailer**, adds a second user-space security barrier.
  - Source (AWS open-source announcement): https://aws.amazon.com/blogs/opensource/firecracker-open-source-secure-fast-microvm-serverless/
  - Source (project): https://firecracker-microvm.github.io/ ;
    https://github.com/firecracker-microvm/firecracker
  - Source (NSDI '20 paper, Agache et al.): https://www.usenix.org/conference/nsdi20/presentation/agache
- **gVisor** — Google's user-space *application kernel*: it intercepts guest
  syscalls in a sandbox process (the **Sentry**) instead of passing them to the
  host kernel. Software isolation without a full VM; the model **Modal** uses.
  - https://gvisor.dev/ ; https://github.com/google/gvisor
- **Kata Containers** — OCI/Kubernetes-native runtime that wraps each pod in a
  lightweight VM with its **own guest kernel**; pluggable VMM backends (Cloud
  Hypervisor default, also Firecracker and QEMU).
  - https://katacontainers.io/ ; https://github.com/kata-containers/kata-containers
- **Cloud Hypervisor** — modern Rust VMM (Intel-led, now Linux Foundation /
  CNCF-adjacent) that **shares code with Firecracker** via the **rust-vmm**
  project. rust-vmm itself began (Dec 2018) as a way for Amazon, Google, Intel,
  and Red Hat to share crates between **Firecracker** and **crosvm**.
  - https://www.cloudhypervisor.org/ ; https://github.com/cloud-hypervisor/cloud-hypervisor
  - rust-vmm: https://github.com/rust-vmm/community
- **firecracker-containerd** — lets **containerd** manage workloads as
  Firecracker microVMs (OCI image → microVM), bridging the container UX and VM
  isolation. https://github.com/firecracker-microvm/firecracker-containerd
- **Weaveworks Ignite** — a "Docker-like" CLI for Firecracker microVMs with
  built-in GitOps; **now deprecated/unmaintained** (Weaveworks itself wound down
  in 2024), with **Flintlock** named as the successor. Listed for the historical
  record. https://github.com/weaveworks/ignite ;
  https://github.com/weaveworks-liquidmetal/flintlock
- **Unikernels** (the "compile the app *with* its kernel into one tiny VM image"
  approach — the parallel HN commenter **pjmlp** drew in 2019, §3):
  - **MirageOS** — OCaml library OS; one of the original unikernel projects.
    https://mirage.io/
  - **NanoVMs / OPS** — runs ordinary ELF binaries as **Nanos** unikernels via
    the **OPS** tool. https://nanovms.com/ ;
    https://github.com/nanovms/ops
  - **Unikraft** — modular unikernel build system (Xen Project / Linux
    Foundation); in **Nov 2025** added a backend to run **MirageOS** unikernels.
    https://unikraft.org/ ;
    https://tarides.com/blog/2025-11-13-announcing-unikraft-support-for-mirageos-unikernels/

### 7.4 The defense-in-depth tradeoff: WASM sandbox vs microVM isolation

These are *not* substitutes; they sit at different points on a security/overhead
curve. A useful sourced ranking (strongest isolation → weakest):

1. **Hardware virtualization** (Firecracker, Kata) — each workload gets its own
   guest kernel behind a KVM boundary. Strongest isolation; ~125 ms cold start;
   the right tool for *hostile, arbitrary* code.
2. **User-space kernel** (gVisor) — syscalls intercepted in a sandbox process;
   medium isolation, no separate guest kernel, some syscall-compat and overhead
   cost.
3. **Shared-kernel containers** — fastest/lightest, but a single host-kernel CVE
   can cross every container on the box.
4. **WASM runtime sandbox** — **capability-based**, deny-by-default, microsecond
   instantiation, tiny memory — but it is a *language-VM* sandbox, not a full OS;
   it lacks a persistent filesystem and broad OS integration unless explicitly
   granted, and won't run arbitrary native/OS workloads.

- Sources for this framing:
  - SoftwareSeni, "Firecracker, gVisor, Containers, and WebAssembly — Comparing
    Isolation Technologies for AI Agents":
    https://www.softwareseni.com/firecracker-gvisor-containers-and-webassembly-comparing-isolation-technologies-for-ai-agents/
    (notes the Linux kernel takes "300+ CVEs annually," motivating
    hardware-isolated microVMs for untrusted code; and that WASM is "not
    suitable for AI workloads needing persistent filesystem and full OS
    integration").
  - Northflank, "Kata vs Firecracker vs gVisor":
    https://northflank.com/blog/kata-containers-vs-firecracker-vs-gvisor
  - The Firecracker NSDI '20 paper's own framing of the dilemma — that the
    "virtualization = strong security + high overhead vs. containers = weak
    security + low overhead" tradeoff was "unacceptable" and Firecracker exists
    to break it: https://www.usenix.org/conference/nsdi20/presentation/agache
- The **defense-in-depth** synthesis (attributable to the SoftwareSeni/Northflank
  analyses above, and the design intent of Firecracker's Jailer): the layers
  *compose*. You can run a **WASM** sandbox **inside** a **Firecracker** microVM
  to get capability-based deny-by-default *and* a hardware boundary — relevant
  precisely for untrusted, AI-generated code (§9). The Firecracker Jailer is
  itself an in-product example of "two lines of defense."

## 8. Platforms and live use cases built on these

### 8.1 WASM edge / serverless platforms (in production)

- **Fastly Compute** (formerly Compute@Edge) — built first on Fastly's **Lucet**
  runtime (announced **Mar 28, 2019**, one day after WASI), which **merged into
  wasmtime in mid-2020**. Production edge WASM.
  - https://www.fastly.com/blog/announcing-lucet-fastly-native-webassembly-compiler-runtime ;
    https://github.com/bytecodealliance/lucet
- **Cloudflare Workers** — primary isolation is **V8 isolates**; *also* runs
  **WASM** modules inside Workers. (Skeptics correctly note the boundary is V8,
  not WASM — §5.) https://developers.cloudflare.com/workers/runtime-apis/webassembly/
- **Shopify Functions** — every function is a **WASI module**; Shopify built
  **Javy** so JS authors can target WASM. https://shopify.engineering/javascript-in-webassembly-for-shopify-functions
- **Fermyon Spin / Fermyon Cloud / SpinKube** — Spin is the developer tool for
  WASM/WASI serverless apps; **SpinKube** is the CNCF project for running Spin
  apps on Kubernetes. (Fermyon → **Akamai**, Dec 2025; see §4 and
  `history/helm.md`.) https://www.fermyon.com/ ; https://www.spinkube.dev/
- **wasmCloud / Cosmonic** — CNCF WASM application orchestrator (wasmCloud) and
  the company behind it (Cosmonic). https://wasmcloud.com/ ; https://cosmonic.com/
- **Wasmer Edge** — Wasmer's own edge/serverless platform for deploying WASM
  (and more) globally. https://wasmer.io/products/edge

### 8.2 MicroVM-based platforms (in production)

- **AWS Lambda / AWS Fargate** — the original Firecracker users; every function
  invocation / Fargate task runs in a Firecracker microVM.
  https://aws.amazon.com/blogs/aws/firecracker-lightweight-virtualization-for-serverless-computing/
- **Fly.io** — runs apps as Firecracker microVMs globally; its **Fly Machines**
  / "Sprites" expose fast checkpoint/restore for sandbox use cases.
  https://fly.io/docs/machines/
- **e2b** — open-source sandboxes *purpose-built for AI agents*; each execution
  gets its own **Firecracker** microVM/kernel; Python + JS SDKs, pause/resume.
  (The e2b SDK repo describes "secure isolated sandboxes in the cloud"; the
  Firecracker detail is documented in its infra repo `e2b-dev/infra` and
  multiple comparison write-ups.)
  https://e2b.dev/ ; https://github.com/e2b-dev/E2B ;
  https://github.com/e2b-dev/infra
- **Modal** — serverless AI/ML platform; **Modal Sandboxes** run on **gVisor**
  (not Firecracker) for running untrusted/agent code. https://modal.com/ ;
  https://modal.com/docs/guide/sandbox
- **Northflank** and **Koyeb** — app/compute platforms offering microVM-isolated
  workloads and code sandboxes (Northflank documents Firecracker/gVisor/Kata/
  Cloud-Hypervisor backends; Koyeb is a global serverless platform).
  https://northflank.com/ ; https://www.koyeb.com/
- **CodeSandbox** — cloud dev environments where each branch/sandbox runs in its
  own **Firecracker VM**, with fast clone/fork via VM memory snapshots.
  https://codesandbox.io/blog/introducing-codesandbox-cde
- **CI / dev-env sandboxes on microVMs**:
  - **Depot** — remote container builds / GitHub Actions runners on fast
    isolated infra. https://depot.dev/
  - **Namespace** — high-performance build/CI and **Devboxes**.
    https://namespace.so/
  - **Blacksmith** — CI runners and **agent sandboxes** described as Firecracker
    "fVMs" that run "like in CI." https://www.blacksmith.sh/sandboxes

### 8.3 Plugin & embedding use cases (live today)

This is, empirically, where server-side WASM has *delivered* — as a safe,
language-agnostic plugin ABI inside a host application.

- **Envoy / Istio proxy-wasm filters** — extend the Envoy proxy with sandboxed
  WASM filters (the **proxy-wasm** ABI; Istio's `WasmPlugin` distributes them),
  written in Rust/Go/C++. Replaced Istio's old Mixer extension model.
  - https://istio.io/latest/docs/reference/config/proxy_extensions/wasm-plugin/ ;
    https://github.com/proxy-wasm/spec
- **Extism** — the "universal plug-in system": make any app extensible with
  sandboxed WASM plugins via a common host SDK (servers, edge, CLIs, IoT,
  browsers). From **Dylibso**. https://extism.org/ ;
  https://github.com/extism/extism
- **Redpanda Data Transforms** — run **WASM** transform functions *inside the
  broker* on each record of a topic (write in Rust/Go/C++…), avoiding extra
  stream-processing hops. https://docs.redpanda.com/current/develop/data-transforms/ ;
  https://www.redpanda.com/blog/wasm-architecture
- **Database WASM UDFs / extensions** — e.g., Extism used to bring WASM
  user-defined functions into **PostgreSQL**. https://dylibso.com/blog/pg-extism/
- **Editor / terminal plugins**:
  - **Zed** extensions compile to **WASM components** and run in **wasmtime**
    with WIT interfaces. https://zed.dev/blog/zed-decoded-extensions
  - **Zellij** (terminal multiplexer) runs plugins as sandboxed WASM (now on the
    `wasmi` interpreter, migrated from wasmtime), any-language-to-WASM.
    https://zellij.dev/documentation/plugins.html
- **Figma** — its rendering engine is **C++ compiled to WASM via Emscripten**;
  Figma reported switching from asm.js to WASM **cut load time ~3×** regardless
  of document size. (Browser-side WASM, but a landmark "real app on WASM" proof
  point.) https://www.figma.com/blog/webassembly-cut-figmas-load-time-by-3x/

## 8.5 Who is building on this vision (the people, not just the logos)

The "wouldn't have needed Docker" thesis has a *cast*. Below maps the actual
builders — companies AND the named individuals driving them — across three
camps: server-WASM companies, the platform vendors investing in WASM/microVM
isolation, and the microVM / ephemeral-compute / AI-agent-sandbox builders. Each
person carries a sourced role. Where a person's specific claim or talk is cited,
it is labeled **bullish / skeptical / nuanced**.

### 8.5.1 Server-WASM companies and their founders

- **Fermyon — Matt Butcher (CEO) & Radu Matei (CTO).** Butcher (Helm/Brigade/Deis
  co-creator) is the most vocal "WASM is the **third wave of cloud computing**"
  advocate (**bullish**); Fermyon ships **Spin** and donated **SpinKube** to
  CNCF. Acquired by **Akamai, Dec 1, 2025**.
  - Butcher's "third wave" framing (InfoQ podcast): https://www.infoq.com/podcasts/cloud-computing-web-assembly/
  - Founder/role: https://www.insightpartners.com/ideas/fermyon-ceo-matt-butcher-on-building-serverless-cloud-platform/
  - Akamai acquisition: https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon
  - (Deep-dived in `history/helm.md`, §"Matt Butcher → Fermyon → Akamai.")
- **Cosmonic / wasmCloud — Liam Randall, Kevin Hoffman, Bailey Hayes, Taylor
  Thomas.** **Liam Randall** (Cosmonic founder/CEO) and **Kevin Hoffman** created
  **wasmCloud** while at a top-10 US bank (Hoffman also wrote the early O'Reilly
  WASM book). **Bailey Hayes** is Cosmonic CTO *and* a Bytecode Alliance TSC
  member / WASI Subgroup co-chair — she now leads wasmCloud. **Taylor Thomas**
  (Cosmonic) chaired the CNCF Wasm Working Group. wasmCloud was **accepted to the
  CNCF Incubator in Nov 2024** (graduating from Sandbox) — a real maturity
  signal. (**bullish**, components-first camp.)
  - CNCF incubation: https://www.cncf.io/blog/2024/11/12/cncf-welcomes-wasmcloud-to-the-cncf-incubator/
  - Project / company: https://wasmcloud.com/ ; https://cosmonic.com/
  - Liam Randall: https://github.com/liamrandall
- **Wasmer — Syrus Akbary (founder/CEO).** Founded **2018**; Wasmer 1.0 reached
  **GA on Jan 5, 2021**. Akbary is the standards-contrarian of the group: he
  shipped **WASIX** (May 30, 2023) as a POSIX-superset of WASI, drawing public
  Bytecode-Alliance pushback (§5). (**bullish on server WASM, skeptical of the BA
  standards path.**)
  - Wasmer 1.0 GA: https://www.infoworld.com/article/2261627/server-side-webassembly-runtime-reaches-ga-status.html
  - WASIX: https://wasmer.io/posts/announcing-wasix
  - Profile: https://wasmer.io/syrusakbary ; YC: https://www.ycombinator.com/companies/wasmer
- **Dylibso / Extism — Steve Manuel (co-founder/CEO), Benjamin Eckel, Zach
  Shipko.** Dylibso productizes **Extism**, the "universal plug-in system" (make
  any app extensible with sandboxed WASM plugins). Raised **$6.6M (Mar 2023,
  TechCrunch — primary)**. Manuel's tagline is making all software "squishy"
  (extensible) via WASM. (**bullish, plugin-ABI camp** — the camp that has
  actually *shipped*.)
  - Funding (primary): https://techcrunch.com/2023/03/24/dylibso-raises-6-6m-to-help-developers-take-webassembly-to-production/
  - Extism: https://extism.org/ ; https://github.com/extism/extism
  - Dylibso: https://dylibso.com/
- **Second State / WasmEdge — Michael Yuan.** **Michael Yuan** leads Second State,
  whose **WasmEdge** runtime (CNCF) is strong on AI/edge (`wasi-nn`,
  TensorFlow/PyTorch plugins) and was Docker's first Docker+Wasm partner.
  (**bullish, AI-at-the-edge camp.**)
  - WasmEdge: https://github.com/WasmEdge/WasmEdge ; https://wasmedge.org/
- **Suborbital — Connor Hicks (founder) → F5.** Built a WASM extensibility/edge
  platform; raised **$1.6M (Nov 2021)**; **team & tech joined F5 in July 2023**
  (folded into F5 Distributed Cloud). Hicks announced the move himself.
  (Consolidation data point.)
  - Funding: https://techcrunch.com/2021/11/23/suborbital-raises-1-6m-for-its-webassembly-platform/
  - F5 acquisition (Hicks's own announcement, now the primary): https://www.linkedin.com/posts/connor-hicks-05044166_im-excited-to-share-that-suborbitals-team-activity-7090013360406040577-HiX4
- **Lunatic — Bernard Kolobara (founder).** An Erlang/BEAM-inspired WASM runtime
  (lightweight processes, supervision trees, capability-based security);
  launched via **YC W21** ("Launch HN: Lunatic," HN item 26367029). (**bullish,
  actor-model niche.**)
  - https://lunatic.solutions/ ; https://github.com/lunatic-solutions/lunatic
  - Launch HN: https://news.ycombinator.com/item?id=26367029

### 8.5.2 Platform vendors investing in WASM / microVM isolation

- **Fastly — Luke Wagner, Lin Clark, Pat Hickey, Till Schneidereit.** Fastly is
  arguably the *deepest* corporate investor in the server-WASM *standards*:
  - **Luke Wagner** — co-creator of WebAssembly and lead of the **Component
    Model** proposal; the person most associated with "components are the real
    missing link." (**bullish, standards.**) Talks: WasmCon 2023 "What is a
    Component (and Why)?", WasmCon 2024 "Incrementally Extending WASI 0.2 to 0.3."
    https://wasmcon24.sched.com/
  - **Lin Clark** — Senior Principal Engineer; author of the **WASI announcement**
    (Mar 27, 2019, the post Hykes was reacting to) and the **nanoprocess**
    "secure-by-default outside the browser" model; famous for "code cartoon"
    explainers. (**bullish, security/DX framing.**)
    https://hacks.mozilla.org/2019/03/standardizing-wasi-a-webassembly-system-interface/
    ; author archive: https://hacks.mozilla.org/author/lclarkmozilla-com/
  - **Pat Hickey** — long-time wasmtime/WASI engineer (Fastly, ex-Bytecode
    Alliance), a core implementer of `wasi-common` and the Wasmtime embedding
    APIs. https://github.com/pchickey
  - **Till Schneidereit** — Bytecode Alliance co-founder & TSC member (ex-Mozilla,
    ex-Fermyon); co-laid-out the server-side / nanoprocess vision and publicly
    defended the WASI/Component-Model path against WASIX (§5). (**bullish,
    standards-orthodox.**)
  - Fastly's product, **Fastly Compute**, ran first on **Lucet** (Mar 28, 2019),
    later merged into wasmtime. https://www.fastly.com/blog/announcing-lucet-fastly-native-webassembly-compiler-runtime
- **Cloudflare — Workers.** Runs primarily on **V8 isolates** and *also* runs WASM
  modules; the isolate (not WASM) is its isolation boundary — a point skeptics
  use (§5). https://developers.cloudflare.com/workers/runtime-apis/webassembly/
- **Shopify — Functions (Saúl Cabrera).** Every Shopify Function is a **WASI
  module**; Shopify engineer **Saúl Cabrera** created **Javy** (JS→WASM via
  QuickJS, now a Bytecode Alliance project) so JS authors can target WASM.
  https://shopify.engineering/javascript-in-webassembly-for-shopify-functions ;
  https://github.com/bytecodealliance/javy
- **Microsoft — the biggest platform bet (Hyperlight, Hyperlight Wasm, SpinKube).**
  Microsoft is now arguably the most significant *vendor* investor in the
  WASM-meets-microVM convergence:
  - **Hyperlight** (announced **Nov 7, 2024**) — an open-source **Rust library
    that runs small functions each inside its own hypervisor-backed micro-VM
    (Hyper-V or KVM) with *no guest OS kernel***, spinning up in **1–2 ms**.
    Authored/announced by **Yosh Wuyts** (Sr. Developer Advocate) and **Ralph
    Squillace** (Principal PM). Quote: *"Hypervisors have been the battle-tested
    wall between untrusted code and trusted applications for more than 20 years."*
    Submitted to CNCF Sandbox. **VERIFIED.**
    https://opensource.microsoft.com/blog/2024/11/07/introducing-hyperlight-virtual-machine-based-security-for-functions-at-scale/
  - **Hyperlight Wasm** (announced **Mar 26, 2025**) — Hyperlight + **wasmtime**
    compiled in as a `no_std` guest, so *any* `wasm32-wasip2` workload (Rust, Go,
    C, Python, JS, C#) runs inside a hardware-isolated micro-VM with **two layers
    of sandbox** (WASM sandbox *inside* the VM boundary). Authored by **Yosh
    Wuyts** and **Lucy Menon**. Onboarded to the **CNCF Sandbox in Feb 2025**.
    This is the single clearest product embodiment of the §7.4 defense-in-depth
    thesis. **VERIFIED.** Quote: *"One layer of sandboxing is good. But having two
    layers is even better."*
    https://opensource.microsoft.com/blog/2025/03/26/hyperlight-wasm-fast-secure-and-os-free/
  - **SpinKube** — donated to CNCF; **Ralph Squillace** (Microsoft Principal PM)
    and **David Justice** (Microsoft) were, per Fermyon, "absolute champions for
    Spin and SpinKube." Contributions from **SUSE, Liquid Reply, Microsoft,
    Fermyon**. Accepted to **CNCF Sandbox Jan 21, 2025**.
    https://www.fermyon.com/blog/announcing-spinkube-contribution-to-cncf ;
    https://www.cncf.io/projects/spinkube/
  - (Microsoft also originated **runwasi** and **Krustlet** via DeisLabs — §4.)

### 8.5.3 MicroVM / ephemeral-compute & AI-agent-sandbox builders

The live "people building on it" story in 2025–2026 is **AI-agent sandboxes**:
LLM coding agents emit untrusted code at volume, which is exactly the "strong
isolation + fast cold start" problem Firecracker was built for. This camp mostly
chose **microVMs/gVisor over WASM** — an instructive datapoint for the thesis.

- **Fly.io — microVMs + "Sprites."** Runs apps as **Firecracker** microVMs
  globally; **Fly.io Sprites** (launched **Jan 2026**) are stateful,
  checkpoint/restore sandbox environments aimed squarely at AI coding agents.
  https://fly.io/docs/machines/ (No `history/fly-io.md` exists in this repo to
  cross-reference; flag if one is added later.)
- **e2b — Vasek Mlejnsky & Tomáš Valenta (co-founders).** Open-source cloud
  sandboxes *purpose-built for AI agents*; each run gets its own **Firecracker**
  microVM, booting **<200 ms**. Founded **2023**; raised a **$21M Series A
  (July 2025, led by Insight Partners)**; Mlejnsky says they're "building the
  open-source cloud for AI agents." (**bullish — microVM, not WASM.**)
  - https://e2b.dev/ ; https://github.com/e2b-dev/E2B ; infra (Firecracker):
    https://github.com/e2b-dev/infra
  - Funding / founder quotes: https://venturebeat.com/ai/how-e2b-became-essential-to-88-of-fortune-100-companies-and-raised-21-million
- **Modal — Erik Bernhardsson (founder/CEO), Akshat Bubna (CTO).** Serverless
  AI/ML platform (founded **Jan 2021**); **Modal Sandboxes** run untrusted/agent
  code on **gVisor** (Google's user-space kernel), *not* Firecracker — the §7.4
  tradeoff made concrete. Bernhardsson is ex-Spotify (creator of **Annoy** and
  **Luigi**). (**pragmatic — gVisor.**)
  - https://modal.com/docs/guide/sandbox ; founder: https://erikbern.com/about.html
  - Modal's own sandbox-comparison writeups (gVisor rationale): https://modal.com/resources/best-code-execution-sandboxes-ai-agents
- **CodeSandbox — Ives van Hoorne (co-founder).** Cloud dev environments where
  each branch runs in its own **Firecracker** VM; pioneered **2-second live VM
  clone** via copy-on-write memory snapshots (a much-cited engineering writeup).
  Acquired by **Together AI (Dec 12, 2024)**, now also a sandbox SDK provider.
  - https://codesandbox.io/blog/how-we-clone-a-running-vm-in-2-seconds ;
    https://codesandbox.io/blog/introducing-codesandbox-cde
  - Together AI acquisition (primary, with van Hoorne quote): https://www.prnewswire.com/news-releases/together-ai-acquires-codesandbox-to-launch-first-of-its-kind-code-interpreter-for-generative-ai-302330074.html
- **Northflank, Koyeb, Depot, Namespace, Blacksmith** — the broader microVM/CI/
  dev-env-sandbox layer:
  - **Northflank** — app/compute platform with microVM-isolated sandboxes
    (documents **Kata / Firecracker / gVisor** backends per workload); publishes
    the most thorough public **e2b vs Modal vs Fly Sprites** comparisons.
    https://northflank.com/ ; https://northflank.com/blog/e2b-vs-modal-vs-fly-io-sprites
  - **Koyeb** — global serverless platform with microVM-isolated workloads.
    https://www.koyeb.com/
  - **Depot** — fast remote container builds & GitHub Actions runners.
    https://depot.dev/
  - **Namespace** — high-performance build/CI and **Devboxes**.
    https://namespace.so/
  - **Blacksmith** — CI runners and **agent sandboxes** built on Firecracker
    "fVMs." https://www.blacksmith.sh/sandboxes

### 8.5.4 Standards / advocacy people (the connective tissue)

These individuals span the companies above and define what "server WASM" even
means; each carries a sourced role.

- **Bailey Hayes** — Cosmonic CTO; **WASI Subgroup co-chair** and Bytecode
  Alliance TSC member; keynoted WasmCon 2023 ("Are We Componentized Yet?") and
  led the Component-Model push. https://wasmcon2023.sched.com/ ;
  https://www.cncf.io/blog/2024/11/12/cncf-welcomes-wasmcloud-to-the-cncf-incubator/
- **Luke Wagner** — Fastly; **co-creator of WebAssembly** and lead of the
  **Component Model** proposal. https://wasmcon24.sched.com/
- **Lin Clark** — Fastly Sr. Principal Engineer; author of the 2019 WASI
  announcement and the nanoprocess model; "code cartoonist."
  https://hacks.mozilla.org/2019/03/standardizing-wasi-a-webassembly-system-interface/
- **Till Schneidereit** — Bytecode Alliance co-founder & TSC member; public
  defender of the WASI/Component-Model standards path (vs. WASIX, §5).
  https://www.infoworld.com/article/2338660/wasix-undermines-webassembly-system-interface-spec-bytecode-alliance-says.html
- **Ben Titzer** (skeptical ballast) — WebAssembly co-creator, author of the
  Wizard research engine; surfaces in the HN debates (§3) as the voice reminding
  proponents that WASI conformance is real engineering work per engine, not free.
  https://news.ycombinator.com/item?id=43020684

## 9. The AI-agent frontier (the live convergence)

The hottest current use of *both* tracks is running **untrusted, LLM-generated
code** safely. An LLM coding agent emits code you did not write and cannot fully
trust; you need to execute it with isolation strong enough for adversarial input.
This is exactly the "strong security + low overhead" problem Firecracker was
built for — and where the WASM-vs-microVM tradeoff (§7.4) becomes a live
engineering decision rather than a debate.

- **e2b** and **Modal** are the canonical "agent sandbox" providers, and they
  picked *different* isolation primitives: **e2b → Firecracker microVMs**,
  **Modal → gVisor**. The split is itself the §7.4 tradeoff made concrete.
  - https://e2b.dev/ ; https://modal.com/docs/guide/sandbox
  - Comparison context (multiple outlets): https://modal.com/resources/best-code-execution-sandboxes-coding-agents
    and https://northflank.com/blog/e2b-vs-modal-vs-fly-io-sprites
- **Dagger "Container Use"** — **Solomon Hykes's** own answer (cross-ref
  `history/dagger.md`): give each coding agent an isolated *containerized*
  environment via an MCP server. Notably this is **containers, not WASM** — the
  Docker creator reaching for containers again for the newest untrusted-code
  workload. https://github.com/dagger/container-use
- **`wasi-nn`** — the WASI inference API (§2) is the WASM track's bet on AI:
  let a sandboxed guest call host ML backends (OpenVINO/ONNX, CPU/GPU/TPU)
  without leaving the capability sandbox. Still Phase 2.
  https://github.com/WebAssembly/wasi-nn
- **llamafile** — **Justine Tunney** (with Mozilla) packages an entire LLM +
  server into a *single executable that runs on six OSes* using her
  **Cosmopolitan Libc**. Important clarification: this is **"run anywhere" but
  NOT WebAssembly** — it is a fat native binary (Actually Portable Executable),
  a *different* answer to the same portability itch Hykes named in 2019.
  - https://github.com/mozilla-ai/llamafile ; https://justine.lol/cosmopolitan/ ;
    https://simonwillison.net/2023/Nov/29/llamafile/
- **Microsoft Hyperlight Wasm** — the clearest *shipping* embodiment of the
  defense-in-depth convergence (§7.4, §8.5.2): wasmtime compiled as a `no_std`
  guest inside a hypervisor-backed micro-VM, so any `wasm32-wasip2` workload runs
  with **two** isolation layers (WASM sandbox *plus* hardware VM boundary),
  spinning up in **1–2 ms**. This is precisely the "WASM capabilities *inside* a
  microVM" stack the speculative §10 anticipated — and it exists today, from a
  major vendor. (Microsoft, Mar 2025; CNCF Sandbox.)
  - https://opensource.microsoft.com/blog/2025/03/26/hyperlight-wasm-fast-secure-and-os-free/
- Why this is *the* convergence point: untrusted AI code wants **both** the WASM
  sandbox's deny-by-default capability model **and** a microVM's hardware
  boundary (§7.4 defense-in-depth). The market is currently buying the microVM
  side (e2b, Fly, CodeSandbox) and the gVisor side (Modal); the WASM side bets the
  Component Model + `wasi-nn` will make *composable, capability-scoped* AI tooling
  compelling; and **Hyperlight Wasm** is the first productized "both layers by
  default." All three bets are live.

## 10. Speculative futures (clearly labeled, ideas are the author's)

> **Speculative.** The following are this document's own extrapolations. Any
> named technology/company below is sourced above; the *predictions* are not
> attributed to those entities and should not be read as their positions.

- **Components as universal "lego bricks" (post-container packaging).** If the
  **Component Model + WIT** (§2) matures, the unit of reuse on the server could
  shift from "an OCI image of an app" to "a typed, capability-scoped component"
  composable across languages — the thing Hykes arguably *meant* in 2019. The
  honest counterweight is the §5 skeptics: this has been "almost ready" for
  years.
- **WASM + microVM as the default AI-agent sandbox.** The §7.4 defense-in-depth
  stack (WASM capabilities *inside* a Firecracker/Kata microVM) is a plausible
  convergence: capability-scoped tool access for the *expected* behavior, plus a
  hardware boundary for the *adversarial* case. Today e2b/Modal/Dagger each pick
  one layer — but the "both layers, by default" gap is *already closing*:
  Microsoft's **Hyperlight Wasm** (§8.5.2, §9) ships exactly this stack today. The
  open question is whether agent-sandbox platforms adopt it over the
  microVM-only / gVisor-only designs they currently run.
- **Edge-everywhere split by workload.** A likely steady state, consistent with
  the sourced "complementary not replacement" consensus (§5): WASM owns
  edge/plugin/extensibility and short-lived capability-scoped functions;
  microVMs own untrusted-but-stateful and full-OS workloads; plain containers
  remain the default for trusted internal services. The interesting motion is at
  the seams (containerd shims like **runwasi**, Kata's pluggable VMMs), not a
  single winner.
- **Unikernels as a dark-horse third path.** Mostly dormant for a decade, but
  the Nov 2025 **Unikraft-runs-MirageOS** work hints at renewed "compile the app
  with its kernel" interest for tiny, fast, single-purpose edge images — a niche,
  not a mainstream bet.

(None of the above should be cited as fact; they are explicitly speculative.)

---

## Appendix: claims that could NOT be fully verified

- **Exact UTC timestamp** of the March 27, 2019 tweet (page not machine-fetchable;
  date verified, hour not).
- **Full text of the March 28, 2019 "wasm vs Docker" follow-up tweet** — its
  existence is confirmed via the tweet URL/search preview; the linked content was
  not retrievable.
- **Root-story points/comment-count and exact created_at** for HN item 19506458
  (the 2019 WASI submission). Thread existence, 2019 date, topic, and quoted
  comments are verified; the metadata counts are not.
- **Venue/transcript** of Hykes's 2024 "will never happen" clarification — quoted
  by InfoWorld and tied to his "Can Wasm replace containers?" LinkedIn post, but
  the originating panel/interview was not independently named/transcribed here.
- **Krustlet's GitHub "archived" flag/date** — the *approach* is documented as
  superseded; the repo-archived status itself is unconfirmed (**verify**).
- **Wasmer 2019 funding-round figures** — third-party trackers (Tracxn) report a
  small **$150K** seed in 2019 with a larger 2021 round; not confirmed against a
  Wasmer primary announcement, so treat the 2019 figure as tracker-reported.
- **Single-outlet benchmark numbers** (Docker+Wasm "65–325 ms slower"; "1.1–1.3×
  CPU overhead") — attributed to one opinion/retrospective outlet, not
  independently verified.
- **Suborbital→F5 acquisition exact terms** — date now confirmed (**July 2023**,
  via Connor Hicks's own announcement post) but the financial terms remain
  undisclosed; F5 issued no standalone press release with terms.

### Newly resolved in this revision (previously flagged, now sourced)

- **Extism primary citation** — RESOLVED: https://extism.org/ ,
  https://github.com/extism/extism , and the Dylibso product page
  https://dylibso.com/products/extism/ now cited directly (§4, §8.3).
- **Bytecode Alliance membership timeline** — RESOLVED/CORRECTED: 2019 founders
  were Mozilla, Fastly, Intel, Red Hat; **Microsoft** joined as an incorporating
  member at the **April 2021 incorporation** (Mozilla Blog,
  https://blog.mozilla.org/en/mozilla/growing-the-bytecode-alliance/). Earlier
  loose phrasings that lumped Microsoft into the founders are corrected in §2.

### Newly resolved / added in the THIRD pass

- **Microsoft Hyperlight & Hyperlight Wasm** — VERIFIED against the two primary
  Microsoft Open Source blog posts (Nov 7, 2024 and Mar 26, 2025), with named
  authors (Yosh Wuyts, Ralph Squillace, Lucy Menon), the 1–2 ms spin-up claim,
  the wasmtime/`wasm32-wasip2` + two-layer-sandbox design, and CNCF Sandbox
  onboarding (Feb 2025). This is the doc's strongest new "building on the vision"
  primary source (§8.5.2, §9).
- **SpinKube CNCF dates & Microsoft sponsors** — confirmed: submitted Mar 2024,
  accepted to **CNCF Sandbox Jan 21, 2025**; Ralph Squillace and David Justice
  named as Microsoft champions (Fermyon blog; CNCF project page).
- **wasmCloud CNCF maturity** — confirmed **CNCF Incubator (Nov 12, 2024)**, with
  founders Liam Randall + Kevin Hoffman and current lead Bailey Hayes (CNCF blog).
- **Dylibso funding** — confirmed **$6.6M (Mar 2023)** via primary TechCrunch
  report (replaces the prior "adjacent coverage only" flag).
- **e2b / Modal / CodeSandbox founders & primitives** — confirmed: e2b (Vasek
  Mlejnsky & Tomáš Valenta, Firecracker, $21M Series A July 2025); Modal (Erik
  Bernhardsson, Jan 2021, gVisor); CodeSandbox (Ives van Hoorne, Firecracker,
  acquired by Together AI 2024).
- **Suborbital→F5 date** — confirmed **July 2023** via Connor Hicks's own
  announcement (terms still undisclosed).
- **Named discourse expanded** — added attributed HN takes (hpincket/Creston
  Bunch, hardwaresofton, yencabulator, pjmlp, funcDropShadow, **Ben Titzer**,
  **Alon Zakai/azakai**, mike_hearn, torginus), lobste.rs threads, the
  **Sylvain Kerkour** "quietly being sabotaged" essay + Baldur Bjarnason
  amplification, and the **Akbary vs. Schneidereit** WASIX standards fight.
- **Conference attributions** — WasmCon 2023/2024 and Wasm I/O 2024 keynote/panel
  talks now tied to named speakers (Luke Wagner, Bailey Hayes, Saúl Cabrera,
  Oscar Spencer, Daniel Caballero) with schedule URLs.

### Still could-not-verify after the third pass

- **Exact verbatim wording of some HN comments** — comment text was retrieved via
  the HN/Algolia API and a summarizing fetch; usernames and substance are
  verified, but treat any in-line quotation as close paraphrase unless it is in
  quotation marks AND you re-check the live comment.
- **Fastly's Pat Hickey current title/employer** — role as a long-time
  wasmtime/WASI engineer is well-documented via his GitHub and commits; the exact
  current employer/title was not freshly confirmed this pass.
- **Kerkour essay full text** — the kerkour.com page was not directly machine-
  fetchable (404 to the fetcher); author, title, date (May 18, 2025) and thesis
  are confirmed via search previews, the lobste.rs submission, and Baldur
  Bjarnason's note. Treat its specific wording as not quoted verbatim here.
- **Fermyon's original WasmCon 2023 recap post** — the Fermyon URL now 301-
  redirects to akamai.com/blog/developers post-acquisition; the WasmCon schedule
  (wasmcon2023.sched.com) is the durable primary for talk titles/speakers.

### Newly flagged in the Part II / III additions

- **AssemblyScript WASI status** — multiple secondary sources state AssemblyScript
  "once supported WASI but no longer does." Treat its server-side/WASI viability
  as **verify against current AssemblyScript docs** before relying on it; the
  language's WASM (non-WASI) support is not in doubt.
- **Zellij runtime detail** — secondary sources say Zellij migrated its plugin
  engine **from wasmtime to the `wasmi` interpreter** (around v0.44). The
  WASM-plugin fact is well-sourced (https://zellij.dev/documentation/plugins.html);
  the *exact* runtime/version of the migration is single-/secondary-sourced —
  **verify against Zellij release notes** if the engine detail matters.
- **Per-platform cold-start / boot numbers** (e.g., Firecracker "~125 ms,"
  "<5 MiB," "150 microVMs/sec") — these come from **AWS's own** Firecracker
  announcement and NSDI '20 paper and are vendor/author figures for specific
  configs, not independently re-benchmarked here. Cited to source; treat as
  "as reported by AWS."
- **Modal = gVisor, e2b/Fly = Firecracker** — sourced to comparison write-ups
  (Modal's own docs/blog; Northflank) rather than, in every case, a single
  first-party "we use X" page. The Firecracker/gVisor split is consistently
  reported across multiple outlets; treat the *specific vendor → primitive*
  mapping as well-reported but secondary where a first-party page wasn't fetched.
- **Weaveworks Ignite deprecation / Flintlock succession** — sourced to the
  Ignite repo's own "no longer maintained" notice pointing to Flintlock; the
  broader "Weaveworks wound down in 2024" context is widely reported but not
  re-verified to a primary Weaveworks notice in this pass.
- **`wasi-nn` / `wasi-http` phase numbers** — taken from wasi.dev/interfaces at
  fetch time (wasi-http et al. Phase 3, wasi-nn Phase 2). Phases advance over
  time; **re-check wasi.dev** for the current phase before quoting.
