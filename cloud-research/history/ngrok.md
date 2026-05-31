# ngrok — A Sourced History

A chronological history of **ngrok**, the secure-tunnels / ingress developer
tool, and **ngrok (the company)** founded by **Alan Shreve** (online handle
**"inconshreveable"**).

Every factual claim below is followed by a source link. Where a commonly
repeated claim could not be confirmed against a primary or reputable source,
it is flagged with **"Could not verify."** Opinions and characterizations are
attributed to whoever made them.

---

## Timeline

### 2013 — Origin: ngrok 1.x, an open-source Go tool

- **June 13, 2013 — ngrok announced.** Alan Shreve announced ngrok publicly on
  Twitter: *"ngrok is a new open-source tool I built to help you develop and
  debug web sites/services."* The tweet is dated to mid-2013.
  Source: [Alan Shreve on X (status 345363135680630784)](https://x.com/inconshreveable/status/345363135680630784)
  (note: the live tweet page returned HTTP 402 on direct fetch; the date and
  text are taken from the search-indexed snapshot of that status URL).

- **Why it was built.** In a later interview Shreve explained ngrok began as a
  project to learn the Go language and was a port of an existing tool: *"Ngrok
  was originally a project built to learn Go, that was about it."* and *"Ngrok
  was essentially that, it was a port of Jeff's tool, localtunnel, actually"*
  — Jeff Lindsay's **localtunnel**, which was written in Python. Shreve had
  worked at **Twilio**, where testing webhook-driven applications was painful
  (you had to repeatedly trigger callbacks), which motivated the introspectable
  tunnel.
  Source: [The Changelog #210, "ngrok and Go with Alan Shreve" (published July 9, 2016)](https://changelog.com/podcast/210)
  and the [episode transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md).

- **What it solved.** ngrok created **secure, introspectable tunnels to
  localhost** — exposing a local server to the public internet for webhook
  testing, demos, and remote debugging. Its differentiator over localtunnel was
  **traffic introspection** (inspecting/replaying requests flowing through the
  tunnel).
  Source: [The Changelog #210 transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md).

- **Written in Go.** Shreve chose Go for its concurrency model: *"This looks
  like it's the Gevent model, but not a hack on top of some other language."*
  ngrok became one of the notable early public Go projects.
  Source: [The Changelog #210](https://changelog.com/podcast/210).

- **Predecessors / peers.** **localtunnel** (Jeff Lindsay, Python) was the direct
  predecessor ngrok was ported from (sourced above). **PageKite** is frequently
  cited as a contemporaneous peer in the local-tunneling space.
  **Could not verify** a primary ngrok/Shreve source explicitly naming PageKite
  as an influence or comparison — treat the PageKite link as "same problem
  space, independently developed," not a documented relationship.

- **Open source, 2013–2016.** The original ngrok ("v1") GitHub repository was
  *"actively developed from 2013-2016"* and is now archived: *"This repository
  is archived: ngrok v1 is no longer developed, supported or maintained."*
  Source: [github.com/inconshreveable/ngrok README](https://github.com/inconshreveable/ngrok).

### 2013–2015 — Shreve's Go OSS heritage (libraries that grew up alongside ngrok)

- **muxado (announced December 2, 2013).** Shreve announced muxado to the
  golang-nuts list as *"a new open-source generic stream multiplexing library
  for Go"* — an implementation of the HTTP/2 (SPDY) framing protocol stripped of
  the HTTP-specific parts, letting an application multiplex many independent
  full-duplex streams over a single connection.
  Source: [[ANN] muxado, golang-nuts (Dec 2, 2013)](https://groups.google.com/g/golang-nuts/c/6nY9XLWR56g/m/OVvaNZayzKMJ)
  and the [muxado README](https://github.com/inconshreveable/muxado).
  - **muxado powers ngrok's tunnels.** Shreve confirmed in the Changelog
    interview that muxado is *"the actual network player that does stream
    multiplexing to actually run a whole bunch of virtual connections over a
    single TCP connection. That ended up being open source as well, it's a
    project called 'muxado'."*
    Source: [The Changelog #210 transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md).
    (Note: the muxado README itself does **not** mention ngrok; the link between
    the two comes from Shreve's interview, not the repo.)

- **go-update.** Shreve's library *"Build self-updating Golang programs."* Its
  v2 API was published **Aug 9, 2015**, with a further `Options`-by-value change
  on **Sept 3, 2015** (the v0 API predates these).
  Source: [github.com/inconshreveable/go-update](https://github.com/inconshreveable/go-update)
  and [go-update doc.go history](https://github.com/inconshreveable/go-update/blob/master/doc.go).

- **Other notable Shreve Go libraries** (from his GitHub profile): **log15**
  (structured logging for Go), **mousetrap** (detect launch from Windows
  Explorer — widely used as a Cobra CLI dependency), and the Python project
  **sqltap**.
  Source: [github.com/inconshreveable](https://github.com/inconshreveable).

### ~2016 — ngrok 2.0: rewrite into a multi-tenant cloud service; goes closed-source

- **Full rewrite.** ngrok 2.0 was a ground-up rewrite with essentially no shared
  code with v1: *"There was almost zero code that's shared across them."* It
  turned ngrok from a single-server tool into a service *"distributed across many
  machines"* with multi-region / HA data-center deployments.
  Source: [The Changelog #210](https://changelog.com/podcast/210)
  and its [transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md).

- **The transition to closed-source / commercial.** v1 was open source; the v2
  product was not. The supporting libraries stayed open, but the product itself
  did not get open-sourced — Shreve: *"The actual product that was built on top
  of those libraries is kind [of what] didn't [get open sourced]."* The archived
  v1 repo confirms v1 was the open one and that ngrok continues to ship *other*
  open-source projects (agent SDKs, the Kubernetes operator) while the core
  cloud service is proprietary.
  Source: [The Changelog #210 transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md);
  [inconshreveable/ngrok README](https://github.com/inconshreveable/ngrok).
  - **Community reaction:** The Changelog interview (July 2016) is itself the
    primary discussion of the open-to-closed shift, where Shreve frames it as
    making ngrok *"a sustainable business."* **Could not verify** a single
    canonical source quantifying broader community backlash; the open→closed
    move is documented, but characterizations of "community reaction" should not
    be overstated beyond what the interview supports.

- **Exact ngrok 2.0 GA date: Could not verify** a precise release date from a
  primary source. v1 development is documented as ending in **2016**
  ([v1 README](https://github.com/inconshreveable/ngrok)), and the Changelog
  episode (**July 2016**) discusses v2 as the then-current direction, so v2
  landed in roughly the **2016** timeframe — but treat any specific day/month as
  unverified.

### 2022 — First outside capital: $50M Series A

- **December 13, 2022 — ngrok raised a $50M Series A** led by **Lightspeed
  Venture Partners**, with participation from **Coatue**. (Note: this is *not*
  Andreessen Horowitz — a16z was not the lead.) It was the company's **first
  fundraise** after roughly **seven years bootstrapped**.
  Sources: [ngrok press release (Dec 13, 2022)](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service);
  [TechCrunch, "Ngrok … raises $50M" (Dec 13, 2022)](https://techcrunch.com/2022/12/13/ngrok-a-service-to-help-devs-deploy-sites-services-and-apps-raises-50m/).

- **Metrics disclosed at the raise** (per ngrok / TechCrunch): **5 million+
  developers**, **30,000+ paying customers** (named: Databricks, Zendesk, Copado,
  Klaviyo, SonarSource), revenue doubling year-over-year, and **59 employees**
  across San Francisco, Seattle, and remote; the team *"tripled in size over the
  past 12 months."* HQ: **San Francisco**.
  Sources: [ngrok press release](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service);
  [TechCrunch](https://techcrunch.com/2022/12/13/ngrok-a-service-to-help-devs-deploy-sites-services-and-apps-raises-50m/).

- **Positioning (attributed to Shreve).** Shreve described ngrok as *"an
  application's front door"* and said ngrok *"is redefining application
  connectivity and control with a simplified, API-first approach to ingress."*
  Source: [ngrok press release](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service);
  [TechCrunch](https://techcrunch.com/2022/12/13/ngrok-a-service-to-help-devs-deploy-sites-services-and-apps-raises-50m/).

### 2023 — Evolution: from dev tunnels to ingress platform / Kubernetes

- **April 13, 2023 — ngrok launches a Kubernetes Ingress Controller.** It packages
  ngrok's ingress into standard cloud-native APIs. Shreve (per the release):
  *"Other ingress controllers require operators to perform complex networking
  setup bespoke to each underlying environment … ngrok, by contrast, delivers a
  plug-and-play experience to any Kubernetes cluster."*
  Sources: [ngrok press release (Apr 13, 2023)](https://ngrok.com/press-releases/ngrok-launches-kubernetes-ingress-controller);
  [GlobeNewswire](https://www.globenewswire.com/news-release/2023/04/13/2646359/0/en/ngrok-Launches-Kubernetes-Ingress-Controller.html).

- **June 26, 2023 — ngrok Kubernetes Operator reaches GA.** Announced on the
  ngrok blog (by ngrok infrastructure engineer Alex Bezek), it delivers
  *"secure internet access to Kubernetes workloads by offloading network ingress
  and middleware execution to ngrok's global points of presence,"* and is open
  source. The earlier **ingress-controller** repo was later archived as work
  consolidated into the **ngrok-operator**.
  Sources: [ngrok blog, "Introducing the ngrok Kubernetes Operator"](https://ngrok.com/blog/ngrok-k8s);
  [github.com/ngrok/kubernetes-ingress-controller](https://github.com/ngrok/kubernetes-ingress-controller).

### Product evolution: API gateway / "unified ingress" / Traffic Policy

- ngrok's GitHub tagline for the (archived) v1 repo is now **"Unified ingress for
  developers,"** reflecting the repositioning from a tunneling tool toward a
  **unified ingress / API-gateway** platform.
  Source: [github.com/inconshreveable/ngrok](https://github.com/inconshreveable/ngrok).

- **Traffic Policy** (with **Endpoints**) is ngrok's expressive traffic-control
  configuration that moves the product from simple ingress toward a full **API
  gateway** (auth, IP allowlists, rate limiting, webhook verification, etc.).
  ngrok itself describes it as roughly *"nginx configuration for the ngrok
  cloud"* plus ngrok features, and the company has blogged about dogfooding it to
  replace nginx on its own site.
  Sources: [ngrok docs: "Front Door" pattern](https://ngrok.com/docs/universal-gateway/examples/front-door-pattern);
  [DEV: "From nginx to ngrok: Dogfooding our own website with Traffic Policy"](https://dev.to/ngrok/from-nginx-to-ngrok-dogfooding-our-own-website-with-traffic-policy-417i).
  - **Could not verify** a single dated launch announcement for Traffic Policy /
    Endpoints from a primary ngrok press release; the feature is documented but a
    precise GA date was not confirmed here.

- **Embeddable ingress SDKs.** ngrok ships `ngrok-go` (*"Embed ngrok secure
  ingress into your Go apps as a net.Listener with a single line of code"*) and
  other-language SDKs, extending ingress from the CLI agent into application code.
  Source: [github.com/ngrok/ngrok-go](https://github.com/ngrok/ngrok-go).

### 2025–2026 — AI / agent ingress

- ngrok now markets itself as an **"AI & API Gateway"** and runs a dedicated
  property, **ngrok.ai**, for *"the next generation of AI-aware networking
  infrastructure,"* including routing/securing LLM traffic.
  Sources: [ngrok.com](https://ngrok.com/);
  [ngrok.ai](https://ngrok.ai/).

- **MCP / agent ingress.** ngrok documents using ngrok as an **MCP (Model
  Context Protocol) gateway** and for exposing local servers behind agent and
  webhook workflows (e.g., proxying a local MCP server for Claude).
  Sources: [ngrok docs: "Using ngrok as your MCP gateway"](https://ngrok.com/docs/using-ngrok-with/using-mcp);
  [ngrok blog: "What are AI gateways in 2026…"](https://ngrok.com/blog/ai-gateways-2026).

---

## Key people & teams

- **Alan Shreve** — founder and CEO of ngrok; online handle **"inconshreveable."**
  Creator of ngrok and of the Go libraries muxado, go-update, log15, and
  mousetrap; previously an engineer at **Twilio** (where the webhook-testing pain
  point that motivated ngrok originated). On his own site: *"I'm the founder and
  CEO of ngrok."*
  Sources: [inconshreveable.com/about](https://inconshreveable.com/about);
  [github.com/inconshreveable](https://github.com/inconshreveable);
  [The Changelog #210](https://changelog.com/podcast/210).

- **Jeff Lindsay** — author of **localtunnel** (Python), the tool ngrok was
  originally ported from; a former colleague of Shreve's.
  Source: [The Changelog #210 transcript](https://github.com/thechangelog/transcripts/blob/master/podcast/the-changelog-210.md).

- **Alex Bezek** — ngrok infrastructure engineer credited as author of the
  Kubernetes Operator GA announcement.
  Source: [ngrok blog: "Introducing the ngrok Kubernetes Operator"](https://ngrok.com/blog/ngrok-k8s).

- **Investors / board (post-2022):** Lightspeed Venture Partners (lead) and Coatue.
  Source: [ngrok press release](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service).
  **Could not verify** named board seats from a primary source.

---

## Company & corporate history

- **Origins as a side project → business.** ngrok started in 2013 as Shreve's
  Go-learning project and a port of localtunnel; it grew organically into a
  business. Shreve has described bootstrapping it cheaply (running it on a small
  paid instance that quickly paid for itself with early customers) and growing to
  millions of users before taking outside money.
  Sources: [The Changelog #210](https://changelog.com/podcast/210);
  [Frontlines.io: "From Bootstrapping to Scaling: Alan Shreve's Journey with Ngrok"](https://www.frontlines.io/from-bootstrapping-to-scaling-alan-shreves-journey-with-ngrok/)
  (note: Frontlines.io is a founder-interview/marketing podcast site, secondary
  source — used here only for the bootstrapping narrative, not for hard dates).

- **Bootstrapped & profitable for years.** ngrok operated **~7 years without
  outside capital** before its 2022 raise; the company press release calls it
  *"an outlier in the software industry"* that *"achieved massive, worldwide
  adoption prior to raising any capital."*
  Source: [ngrok press release (Dec 13, 2022)](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service).

- **Founding/incorporation year of ngrok, Inc.: Could not verify** a precise
  incorporation date from a primary source. "Seven years bootstrapped" before
  the December 2022 raise implies roughly **2015**, but no first-party document
  reviewed here states an exact incorporation year. Treat **~2015** as inferred,
  not confirmed.

- **Funding:** **$50M Series A, December 13, 2022**, led by **Lightspeed Venture
  Partners** with **Coatue** participating — the company's first fundraise.
  Sources: [ngrok press release](https://ngrok.com/press-releases/ngrok-raises-50m-for-ingress-as-a-service);
  [TechCrunch](https://techcrunch.com/2022/12/13/ngrok-a-service-to-help-devs-deploy-sites-services-and-apps-raises-50m/).

- **HQ & headcount (as of the 2022 raise):** San Francisco HQ; **59 employees**
  across San Francisco, Seattle, and remote.
  Source: [TechCrunch](https://techcrunch.com/2022/12/13/ngrok-a-service-to-help-devs-deploy-sites-services-and-apps-raises-50m/).

- **Leadership:** Alan Shreve remains **founder and CEO**.
  Source: [inconshreveable.com/about](https://inconshreveable.com/about).

- **Current status:** ngrok positions itself as a **unified ingress / AI & API
  gateway** ("the front door to your applications"), ships an open-source
  Kubernetes Operator and embeddable language SDKs while keeping the core cloud
  service proprietary, and is pushing into **AI/agent ingress and MCP gateway**
  use cases. Shreve's site cites *"Over 8 million developers"* having used ngrok.
  Sources: [ngrok.com](https://ngrok.com/);
  [inconshreveable.com/about](https://inconshreveable.com/about);
  [ngrok docs: MCP gateway](https://ngrok.com/docs/using-ngrok-with/using-mcp).

---

## Could-not-verify summary

1. **Exact ngrok 1.0 announcement tweet text/date** — strongly indicated as
   **June 13, 2013** via the indexed status URL, but the live tweet returned
   HTTP 402 and could not be fetched directly for byte-exact confirmation.
2. **PageKite as a named ngrok influence/peer** — same problem space, but no
   first-party ngrok/Shreve source explicitly cites PageKite.
3. **Precise ngrok 2.0 GA release date** — only bounded to ~2016 (v1 dev ended
   2016; Changelog discussed v2 in July 2016).
4. **Scale/specifics of "community reaction"** to the open→closed transition —
   the transition is documented; broad backlash claims are not substantiated by
   the sources reviewed.
5. **Traffic Policy / Endpoints exact launch date** — feature documented, no
   dated primary launch announcement confirmed.
6. **ngrok, Inc. exact incorporation year** — inferred ~2015 from "seven years
   bootstrapped before Dec 2022," not stated in a primary source.
7. **Board seats / governance terms** of the 2022 round — beyond lead investor
   identity, not confirmed.
