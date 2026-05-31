# Docker: A Sourced History

A chronological, fully-sourced history of **Docker** — the company (dotCloud →
Docker, Inc.) and the technology — and its outsized role in the cloud,
container, and IaC era.

Every non-trivial claim below carries a working source link. Where a detail
could not be confirmed against a primary or reputable secondary source, it is
explicitly flagged with **Could not verify:**. Controversies and opinions are
attributed to their sources, with fact separated from reported claim.

> Cross-reference: Solomon Hykes' post-Docker company **Dagger** is covered in
> `history/dagger.md` (not yet written at time of writing) and is only
> summarized here to avoid duplication.

---

## Timeline

### Origins: dotCloud (2008/2010–2013)

- **2008 / 2010 — dotCloud founded.** dotCloud, a Platform-as-a-Service (PaaS)
  startup, was established by **Solomon Hykes**, **Sebastien Pahl**, and **Kamel
  Founadi**. Per Wikipedia, the company was "established in 2008 ... in Paris,
  then incorporated in the United States in 2010."
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
  - **Note on founding year:** Sources differ. Wikipedia gives 2008 (Paris) /
    2010 (US incorporation). Secondary coverage frequently cites "founded ~2010."
    **Could not verify a single authoritative primary-source founding date**;
    the 2008-Paris / 2010-US-incorporation split is Wikipedia's framing.

- **Summer 2010 — Y Combinator.** dotCloud went through Y Combinator's Summer
  2010 batch. Per Y Combinator's own blog (interview with Hykes), the company
  was a YC startup; secondary coverage adds that YC alumnus James Lindenbaum
  (Heroku co-founder) vouched for them after earlier rejections.
  - Source: [Why Docker's Pivot Worked — Y Combinator blog](https://blog.ycombinator.com/solomon-hykes-docker-dotcloud-interview/)
  - **Could not verify** the "earlier rejections / Lindenbaum vouched" anecdote
    against a primary source; it appears in secondary recountings (e.g.,
    [Founders Network](https://foundersnetwork.com/fnmentoring-solomon-hykes-founder-ceo-dotcloud/)).

- **Docker built internally at dotCloud.** Docker began as the internal
  container technology that powered dotCloud's PaaS. Docker's own retrospective:
  Docker "was a product used internally at Solomon's company dotCloud to power
  their PaaS solution," later open-sourced.
  - Source: [The Docker project turns 10! — Snyk blog](https://snyk.io/blog/the-docker-project-turns-10/)

### 2013 — Docker revealed and open-sourced

- **March 15, 2013 — the PyCon lightning talk.** At PyCon US 2013 in Santa
  Clara, Solomon Hykes gave a 5-minute lightning talk, **"The future of Linux
  Containers,"** publicly revealing Docker for the first time. PyVideo records
  the talk as **"Fri 15 March 2013."**
  - Source: [Lightning Talk - The future of Linux Containers — PyVideo (Fri 15 March 2013)](https://pyvideo.org/pycon-us-2013/the-future-of-linux-containers.html)
  - Docker's own framing: "Eleven years ago, Solomon Hykes walked onto the stage
    at PyCon 2013 and revealed Docker to the world for the first time."
    - Source: [11 Years of Docker — Docker blog](https://www.docker.com/blog/docker-11-year-anniversary/)
  - Snyk's retrospective marks **March 15, 2023** as the 10-year anniversary of
    the talk, corroborating the March 15, 2013 date.
    - Source: [The Docker project turns 10! — Snyk blog](https://snyk.io/blog/the-docker-project-turns-10/)

- **March 2013 — Docker open-sourced.** Docker was open-sourced shortly after
  the PyCon talk. Per Snyk and Docker's anniversary posts, the Docker project
  "officially got started in March 2013."
  - Source: [The Docker project turns 10! — Snyk blog](https://snyk.io/blog/the-docker-project-turns-10/)

- **October 29, 2013 — dotCloud renamed to Docker.** Per Wikipedia (citing the
  company's announcement): "On October 29, 2013, dotCloud was renamed Docker."
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)

- **July 2013 — Ben Golub becomes CEO.** Benjamin Golub became CEO in July 2013.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)

### 2014 — Engine maturity, Docker 1.0, dotCloud sold off

- **March 2014 — libcontainer replaces LXC (Docker 0.9).** With the 0.9 release,
  Docker dropped LXC as its default execution environment, replacing it with its
  own Go library, **libcontainer**, giving Docker direct access to Linux
  namespaces, cgroups, capabilities, AppArmor, and networking without depending
  on LXC.
  - Source: [Docker drops LXC as default execution environment — InfoQ (March 2014)](https://www.infoq.com/news/2014/03/docker_0_9/)
  - Context (libcontainer → later repackaged as runc under OCI):
    [Evolution of Docker from Linux Containers — Baeldung](https://www.baeldung.com/linux/docker-containers-evolution)

- **June 9–10, 2014 — Docker 1.0 at the first DockerCon.** Docker 1.0, the first
  "production-ready" release, was announced at the inaugural DockerCon in San
  Francisco, alongside Docker Hub. Docker described it as the first
  production-quality version with commercial support and documentation. The
  conference reportedly sold out (~550 registered, ~400 on a waitlist).
  - Source: [Docker Inc. Launches Release 1.0, Docker Hub At DockerCon14 — TechCrunch (June 9, 2014)](https://techcrunch.com/2014/06/09/docker-inc-launches-release-1-0-docker-hub-at-dockercon14/)
  - Source: [Docker 1.0 Released at DockerCon — InfoQ](https://www.infoq.com/news/2014/06/docker_1.0)
  - Source (Docker's own announcement): [It's Here: Docker 1.0 — Docker blog](https://blog.docker.com/2014/06/its-here-docker-1-0/)

- **June 2014 — Kubernetes announced at DockerCon.** Google announced Kubernetes
  around the time of the first DockerCon (June 2014), seeding what became the
  orchestration rivalry below. (See `history/kubernetes.md` for the full
  Kubernetes timeline.)
  - Source: [Kubernetes — Wikipedia](https://en.wikipedia.org/wiki/Kubernetes)

- **September 2014 — $40M Series C (Sequoia).** Docker raised a $40M Series C led
  by Sequoia Capital.
  - Source: [Docker Secures $40M in Series C Funding — Business Wire (Sept 16, 2014)](https://www.businesswire.com/news/home/20140916005327/en/Docker-Secures-40M-in-Series-C-Funding-to-Drive-the-Future-of-Distributed-Applications)
  - Source: [Docker Raises $40M in Sequoia-Led Series C — Data Center Knowledge](https://www.datacenterknowledge.com/investing/docker-raises-40m-in-sequoia-led-series-c)

- **August 4, 2014 — dotCloud (the PaaS) sold to cloudControl.** Docker, Inc.
  sold its legacy dotCloud PaaS business and brand to German PaaS vendor
  **cloudControl** to focus on its container business; proceeds were to be
  reinvested into Docker.
  - Source: [Docker Sells dotCloud To cloudControl To Focus On Core Container Business — TechCrunch (Aug 4, 2014)](https://techcrunch.com/2014/08/04/docker-sells-dotcloud-to-cloudcontrol-to-focus-on-core-container-business/)
  - Source: [cloudControl Signs Definitive Agreement to Acquire dotCloud PaaS Business — Business Wire](https://www.businesswire.com/news/home/20140804005199/en/cloudControl-Signs-Definitive-Agreement-Acquire-dotCloud-PaaS)
  - Source (Register): [CloudControl to major chum: We'll gobble Docker's dotCloud — The Register](https://www.theregister.com/2014/08/04/docker_sells_dotcloud_to_cloudcontrol)
  - **Aftermath:** dotCloud (under cloudControl) later shut down. cloudControl
    itself went insolvent; Data Center Knowledge reported dotCloud setting a 2016
    closing date.
    - Source: [dotCloud, PaaS Firm that Birthed Docker, Shutting Down — Data Center Knowledge (Jan 2016)](https://www.datacenterknowledge.com/cloud/dotcloud-paas-firm-that-birthed-docker-shutting-down)

### Dec 2014 — The format wars begin (CoreOS rkt / appc)

- **December 2014 — CoreOS launches rkt and the appc spec.** CoreOS announced
  **rkt** ("Rocket"), a rival container runtime, plus the **App Container
  (appc)** specification and image format — explicitly positioned against
  Docker's direction.
  - Source: [CoreOS's rkt Container Engine Hits 1.0 — TechCrunch (Feb 2016, recounting the Dec 2014 launch)](https://techcrunch.com/2016/02/04/coreoss-rkt-container-engine-10/)
  - Source: [CoreOS' Docker rival, Rocket, gets 1.0 release — Data Center Dynamics](https://www.datacenterdynamics.com/en/news/coreos-docker-rival-rocket-gets-10-release/)
- **Reported claim (attributed):** CoreOS CEO **Alex Polvi** criticized Docker
  as having drifted from a simple, reusable component into "one monolithic binary
  running primarily as root on your server." This is Polvi's stated opinion as
  reported in coverage of the rkt launch.
  - Source: [Docker vs the container world — The Register (recounting CoreOS's position)](https://www.theregister.com/2015/05/05/coreos_fest_roundtable/)
  - **Could not verify** the exact original wording against CoreOS's primary
    launch blog post; the "monolithic binary" quote circulates widely in
    secondary coverage of the December 2014 announcement.

### 2015 — Standardization truce (OCI) and unicorn status

- **April 14, 2015 — $95M Series D; unicorn.** Docker raised a $95M Series D led
  by Insight Venture Partners (with Goldman Sachs, Coatue, Northern Trust, and
  others), reaching a ~$1.07B valuation.
  - Source: [Goldman Sachs invests $95 million in Docker — CNBC (Apr 14, 2015)](https://www.cnbc.com/2015/04/14/goldman-sachs-invests-95-million-in-docker.html)
  - Source: [New Unicorn: Docker Valued at $1.07B After $95M Raise — PitchBook](https://pitchbook.com/newsletter/new-unicorn-docker-valued-at-107b-after-95m-raise)

- **June 22, 2015 — Open Container Initiative (OCI) launched.** At DockerCon, an
  industry truce formed the **Open Container Initiative** under the Linux
  Foundation, with Docker, CoreOS, and others. **Docker donated its container
  format and runtime, runC, to the OCI** as the cornerstone reference
  implementation (runC being libcontainer repackaged to the OCI runtime spec).
  - Source (primary): [About the Open Container Initiative — opencontainers.org](https://opencontainers.org/about/overview/) ("launched on June 22nd 2015 by Docker, CoreOS and other leaders ... Docker is donating its container format and runtime, runC, to the OCI")
  - Source: [Open Container Initiative — Wikipedia](https://en.wikipedia.org/wiki/Open_Container_Initiative)
  - The OCI now maintains the runtime-spec, image-spec, and distribution-spec.

### 2017 — Orchestration wars, the Moby rebrand, and "give in" to Kubernetes

- **April 2017 — the Moby Project rename.** At DockerCon 2017 (Austin), Docker
  announced **Moby** as the new name for the open-source upstream project from
  which the commercial Docker products (Docker CE / EE) are assembled — intended
  to separate the open-source project from the "Docker" product/brand.
  - Source: [Wait – we can explain, says Moby, er, Docker amid rebrand meltdown — The Register (Apr 21, 2017)](https://www.theregister.com/2017/04/21/docker_renames_open_source_code_moby/)
  - **Reported backlash (attributed):** The Register and others reported the move
    "sparked more confusion than clarity." The Register reported that the GitHub
    issue/post by co-founder Solomon Hykes drew far more negative than positive
    reactions (reported as ~461 thumbs-down / ~377 confused vs ~73 thumbs-up).
    Years later, community members still debated reverting the name.
    - Source: [Moby or not Moby. That is the question — The Register (Nov 22, 2019)](https://www.theregister.com/2019/11/22/moby_docker_naming/)
    - Source: [Rename moby to docker · Issue #40222 · moby/moby — GitHub](https://github.com/moby/moby/issues/40222)
    - **Could not verify** the exact reaction-count figures against a live
      GitHub snapshot; they are as reported by The Register.

- **May 2017 — Ben Golub out; Steve Singh becomes CEO.** Docker replaced CEO Ben
  Golub with **Steve Singh** (Concur co-founder/CEO, then at SAP), who had become
  Docker's chairman in late 2016. Golub remained on the board.
  - Source: [Docker gets a new CEO — TechCrunch (May 2, 2017)](https://techcrunch.com/2017/05/02/docker-gets-a-new-ceo/)
  - Source: [Ben Golub Steps Down as Docker Inc. CEO; Concur Veteran Steve Singh to Take Over — The New Stack](https://thenewstack.io/ben-golub-steps-docker-inc-ceo-concur-veteran-steve-singh-take/)

- **March 2017 — containerd donated to CNCF.** Docker announced (Dec 2016) it
  would spin out its core runtime **containerd** to a neutral foundation; on
  **March 29, 2017** the CNCF accepted containerd as an incubating project.
  - Source (primary, CNCF): [containerd joins the Cloud Native Computing Foundation — CNCF (Mar 29, 2017)](https://www.cncf.io/announcements/2017/03/29/containerd-joins-cloud-native-computing-foundation/)
  - Source (Docker blog): [Docker donates containerd to CNCF — Docker blog](https://blog.docker.com/2017/03/docker-donates-containerd-to-cncf/)
  - containerd reached 1.0 in December 2017.
    - Source: [General availability of containerd 1.0 is here! — CNCF](https://www.cncf.io/blog/2017/12/05/general-availability-containerd-1-0/)

- **October 17, 2017 — Docker adds native Kubernetes support (DockerCon EU,
  Copenhagen).** Docker announced native Kubernetes support in Docker EE and
  Docker for Mac/Windows, letting users choose Kubernetes or Swarm as the
  orchestrator — widely read as Docker conceding the orchestration war to
  Kubernetes (TechCrunch headline: "Docker gives into inevitable").
  - Source: [Docker gives into inevitable and offers native Kubernetes support — TechCrunch (Oct 17, 2017)](https://techcrunch.com/2017/10/17/docker-gives-into-invevitable-and-offers-native-kubernetes-support/)
  - Source: [DockerCon Europe 2017: Docker EE and CE to Include Kubernetes Integration — InfoQ](https://www.infoq.com/news/2017/10/docker-kubernetes-integration/)
  - Attributed: Solomon Hykes (then founder/CTO) stated the integrated
    Kubernetes would be "the vanilla Kubernetes that everyone is familiar with,
    direct from the CNCF ... not a fork, nor an outdated version, nor wrapped or
    limited in any way" (as reported in the InfoQ / TechCrunch coverage above).

- **2017 — Series E (~$92M) and ~$1.3B valuation (reported).** Secondary sources
  report a 2017 Series E of ~$91.9M and a ~$1.3B valuation.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
  - **Could not verify** the exact Series E size/valuation against a primary
    funding announcement; figures are from aggregator/secondary sources.

### 2018 — Solomon Hykes leaves

- **March 28, 2018 — Solomon Hykes leaves Docker.** Hykes announced his
  departure. Per the coverage, he had stepped down as CTO "last September"
  (Sept 2017) to become chief architect / vice chairman; in March 2018 he
  announced leaving day-to-day involvement, saying Docker needed a CTO with
  decades of enterprise software experience. He said he'd remain a board member
  and major shareholder.
  - Source: [Solomon Hykes leaves Docker, the company he founded — TechCrunch (Mar 28, 2018)](https://techcrunch.com/2018/03/28/solomon-hykes-leaves-docker-the-company-he-founded/)
  - Source: [Docker co-founder Solomon Hykes leaving company — GeekWire](https://www.geekwire.com/2018/docker-co-founder-solomon-hykes-leaving-company-cites-need-enterprise-focused-cto/)
  - Source (Register): [What a Docker shocker: Founder, CTO Solomon Hykes takes a hike — The Register](https://www.theregister.com/2018/03/28/docker_shocker_solomon_hykes_take_a_hike/)

### 2019 — Business crunch and the split

- **May 2019 — Rob Bearden becomes CEO.** Rob Bearden (ex-Hortonworks)
  took over as CEO from Steve Singh.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
  - **Could not verify** an exact day in May 2019 from a primary announcement;
    month/year is per Wikipedia.

- **September 27, 2019 — Docker seeks cash amid "significant challenges."** CNBC
  reported Docker told employees it was trying to raise money, citing
  "significant challenges," following Bearden's arrival — illustrating the weak
  business model despite heavy VC funding.
  - Source: [Docker, once worth over $1 billion, tells employees it's trying to raise cash amid 'significant challenges' — CNBC (Sept 27, 2019)](https://www.cnbc.com/2019/09/27/docker-is-trying-to-raise-money-following-arrival-of-ceo-rob-bearden.html)

- **November 13, 2019 — the split: Mirantis buys Docker Enterprise; Docker
  refinances; Scott Johnston becomes CEO.** Docker sold its **Docker Enterprise**
  business to **Mirantis** (Docker Enterprise Technology Platform + IP, ~300 of
  ~400 employees, ~750 enterprise customers; terms confidential). Docker, Inc.
  kept developer tools (Docker Desktop, Docker Hub), raised **$35M** in fresh
  funding (Benchmark and Insight Partners), and installed **Scott Johnston**
  (former head of product) as CEO, pivoting to a "developer-focused" company.
  - Source (primary, Mirantis): [Mirantis Acquires Docker Enterprise Platform Business — Mirantis (Nov 13, 2019)](https://www.mirantis.com/company/press-center/company-news/mirantis-acquires-docker-enterprise/)
  - Source: [Mirantis acquires Docker Enterprise — TechCrunch (Nov 13, 2019)](https://techcrunch.com/2019/11/13/mirantis-acquires-docker-enterprise/)
  - Source: [Container shakeup: Docker sells enterprise business to Mirantis, appoints new CEO — SiliconANGLE](https://siliconangle.com/2019/11/13/container-shakeup-docker-sells-enterprise-business-mirantis-appoints-new-ceo/)
  - Source (Register): [Just Docker room talk: Container upstart's enterprise wing sold to Mirantis, CEO out, Swarm support faces ax — The Register](https://www.theregister.com/2019/11/13/docker_enterprise_mirantis/)
  - **"Broke in half" framing (attributed):** InfoWorld later analyzed the split
    as "How Docker broke in half" — the open-source success that never became a
    durable business.
    - Source: [How Docker broke in half — InfoWorld](https://www.infoworld.com/article/2269272/how-docker-broke-in-half.html)

### 2020 — Docker Hub rate limits

- **November 2020 — Docker Hub pull rate limits.** Docker introduced rate limits
  on Docker Hub image pulls: **100 pulls / 6 hours for anonymous** users and
  **200 pulls / 6 hours for authenticated free** users; Pro/Team accounts exempt.
  Sources note the limits phased in starting early November and took broad effect
  around **November 20, 2020**.
  - Source: [Advice for customers dealing with Docker Hub rate limits — AWS Containers blog](https://aws.amazon.com/blogs/containers/advice-for-customers-dealing-with-docker-hub-rate-limits-and-a-coming-soon-announcement/)
  - Source: [Updates on Hub rate limits, partners and customer exemptions — Docker blog](https://www.docker.com/blog/updates-on-hub-rate-limits-partners-and-customer-exemptions/)
  - **Backlash (attributed / documented):** Open-source and CI/CD communities
    raised alarm that ephemeral CI and Kubernetes/OpenShift re-scheduling could
    exhaust the quotas, risking broken builds and outages. Documented in
    upstream issue trackers and vendor guidance.
    - Source: [DockerHub Pull Rate Limit ... might break our CI builds · Issue #2294 (keptn) — GitHub](https://github.com/keptn/keptn/issues/2294)
    - Source: [Docker Hub pull rate limits · Issue #3099 (testcontainers-java) — GitHub](https://github.com/testcontainers/testcontainers-java/issues/3099)
    - Source: [How to make Docker Hub rate limit monitoring a breeze — GitLab blog](https://about.gitlab.com/blog/2020/11/18/docker-hub-rate-limit-monitoring/)

### 2021 — Docker Desktop licensing change; rise of alternatives

- **August 31, 2021 — Docker Desktop becomes paid for larger orgs.** Docker
  updated its subscription terms: Docker Desktop now requires a **paid
  subscription (Pro/Team/Business)** for use in larger companies — defined as
  **>250 employees OR >$10M annual revenue** — while remaining free for personal
  use, small businesses, education, and non-commercial open source. A grace
  period ran to **January 31, 2022**.
  - Source (primary, Docker): [Docker Updates Product Subscriptions ... — Docker press release](https://www.docker.com/press-release/docker-updates-product-subscriptions/)
  - Source (primary, terms): [Docker Desktop license agreement — Docker Docs](https://docs.docker.com/subscription/desktop-license/)
  - Source: [Docker Desktop is no longer free for enterprise users — InfoWorld](https://www.infoworld.com/article/2268969/docker-desktop-is-no-longer-free-for-enterprise-users.html)
  - Source (critical framing, attributed): [Docker Abruptly Starts Charging Many Users for Docker Desktop — ServeTheHome](https://www.servethehome.com/docker-abruptly-starts-charging-many-users-for-docker-desktop/)
  - **Note:** Reported entry pricing varies by source ($5 vs $9 per user/month
    for Pro); the Business tier was reported around $21/user/month. The exact tier
    pricing changed over time — see Docker's pricing pages for current numbers.

- **2021–2022 — rise of Docker Desktop alternatives.** The licensing change
  accelerated adoption of alternatives: **Podman** (daemonless), **Rancher
  Desktop** (SUSE; k3s-based local Kubernetes), and **Colima/Lima** (lightweight
  macOS/Linux container runtimes). All are open source.
  - Source: [Top Alternatives to Docker Desktop in 2022: Licensing and Pricing — ModLogix](https://modlogix.com/blog/docker-desktop-alternatives-changes-in-licensing-and-new-pricing-policy/)
  - Source: [Docker Desktop Alternatives: OrbStack vs Colima vs Rancher Desktop — DEV](https://dev.to/pickuma/docker-desktop-alternatives-orbstack-vs-colima-vs-rancher-desktop-2af1)

### 2022 — Funding under the new model

- **March 2022 — $105M Series C; ~$2.1B+ valuation (reported).** Under the
  refinanced developer-tools company, Docker raised a reported $105M (often
  labeled "Series C" of the new entity).
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
  - **Could not verify** the precise round size/valuation against a primary
    Docker press release; figures here are from Wikipedia/aggregators.

### 2023–2024 — Developer-tools company: Scout, Build Cloud, AI

- **2023 — Docker Scout and AI direction (DockerCon 2023).** Docker leaned into
  developer security and AI: **Docker Scout** (image/supply-chain analysis
  against policies) and a containerized **GenAI Stack** were introduced.
  - Source: [Highlights from DockerCon 2023 — Docker blog](https://www.docker.com/blog/highlights-from-dockercon-2023/)
  - Source: [Docker debuts new tools for developing container applications — SiliconANGLE](https://siliconangle.com/2023/10/04/docker-debuts-new-tools-developing-container-applications/)

- **March 2024 — Docker Build Cloud.** Docker launched **Docker Build Cloud**,
  offloading builds to cloud servers with shared caching (Docker claimed large
  speedups).
  - Source: [Docker supports Build Cloud to save developers time (KubeCon EU) — SiliconANGLE](https://siliconangle.com/2024/03/21/docker-supports-build-dloud-save-developers-time-kubeconeu/)

### 2025 — CEO handoff to Don Johnson

- **February 12, 2025 — Don Johnson becomes CEO; Scott Johnston departs.** Docker
  named **Don Johnson** (founder of Oracle Cloud Infrastructure; earlier at AWS)
  as CEO, succeeding Scott Johnston, who had led Docker since late 2019 (~5 years
  as CEO, ~11 years total at the company). Some analysts read the swap as
  potentially presaging a sale.
  - Source (primary, Docker): [Docker Announces Don Johnson as New CEO, Succeeding Scott Johnston — Docker press release (Feb 12, 2025)](https://www.docker.com/press-release/docker-announces-don-johnson-as-new-ceo-succeeding-scott-johnston/)
  - Source: [Docker's new CEO is former Oracle Cloud exec Don Johnson — TechCrunch (Feb 13, 2025)](https://techcrunch.com/2025/02/13/former-oracle-cloud-exec-don-johnson-takes-over-as-dockers-new-ceo/)
  - Source (analyst framing, attributed): [Docker Inc. CEO swap has analysts anticipating a sale — TechTarget](https://www.techtarget.com/searchsoftwarequality/news/366619297/Docker-Inc-CEO-swap-has-analysts-anticipating-a-sale)

---

## Key people & teams

- **Solomon Hykes** — co-founder of dotCloud/Docker; creator of Docker; gave the
  March 15, 2013 PyCon reveal. Stepped down as CTO (Sept 2017) to chief
  architect / vice chairman, then left day-to-day involvement March 28, 2018,
  remaining a board member/shareholder. Later founded **Dagger** (see
  `history/dagger.md`).
  - Source: [Solomon Hykes leaves Docker — TechCrunch (2018)](https://techcrunch.com/2018/03/28/solomon-hykes-leaves-docker-the-company-he-founded/)
- **Sebastien Pahl** and **Kamel Founadi** — dotCloud co-founders.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
- **Ben (Benjamin) Golub** — CEO July 2013–May 2017.
  - Source: [Docker gets a new CEO — TechCrunch (2017)](https://techcrunch.com/2017/05/02/docker-gets-a-new-ceo/)
- **Steve Singh** — CEO May 2017–~2019 (Concur co-founder; prior Docker chairman).
  - Source: [Ben Golub Steps Down ... Steve Singh to Take — The New Stack](https://thenewstack.io/ben-golub-steps-docker-inc-ceo-concur-veteran-steve-singh-take/)
- **Rob Bearden** — CEO ~May–Nov 2019 (ex-Hortonworks).
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
- **Scott Johnston** — CEO Nov 2019–Feb 2025; led the developer-tools pivot
  (Hub, Desktop, Scout, Build Cloud, AI).
  - Source: [Container shakeup ... appoints new CEO — SiliconANGLE (2019)](https://siliconangle.com/2019/11/13/container-shakeup-docker-sells-enterprise-business-mirantis-appoints-new-ceo/)
- **Don Johnson** — CEO from Feb 12, 2025 (founder of Oracle Cloud
  Infrastructure; ex-AWS).
  - Source: [Docker Announces Don Johnson as New CEO — Docker (2025)](https://www.docker.com/press-release/docker-announces-don-johnson-as-new-ceo-succeeding-scott-johnston/)
- **Alex Polvi** — CoreOS CEO; led the rkt/appc challenge and public critique of
  Docker's "monolithic" direction (Dec 2014).
  - Source: [Docker vs the container world — The Register (2015)](https://www.theregister.com/2015/05/05/coreos_fest_roundtable/)

---

## Company & corporate history

- **dotCloud (2008/2010):** PaaS startup, YC Summer 2010, built Docker internally
  to run its platform.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
- **Renamed Docker (Oct 29, 2013)** after the open-source project's explosive
  early traction.
  - Source: [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
- **Funding (heavy VC, weak business model):** $10M Series A (Mar 2011), $15M
  Series B led by Greylock (Jan 2014), $40M Series C led by Sequoia (Sept 2014),
  $95M Series D (Apr 2015, ~$1.07B unicorn valuation), reported ~$92M Series E
  (2017). Wikipedia/aggregators put cumulative pre-split funding in the
  low-hundreds of millions; **total reported figures vary by source** (e.g., one
  aggregator cites ~$435.9M lifetime across all rounds incl. post-split).
  - Sources: [Series C — Business Wire](https://www.businesswire.com/news/home/20140916005327/en/Docker-Secures-40M-in-Series-C-Funding-to-Drive-the-Future-of-Distributed-Applications);
    [Series D / unicorn — PitchBook](https://pitchbook.com/newsletter/new-unicorn-docker-valued-at-107b-after-95m-raise);
    [Docker, Inc. — Wikipedia](https://en.wikipedia.org/wiki/Docker,_Inc.)
  - **Could not verify** the Series A ($10M, Mar 2011) and Series E figures
    against primary announcements; they are from Wikipedia/aggregators.
- **The 2019 split:** sold Docker Enterprise to Mirantis; refinanced $35M;
  pivoted to developer tools (Hub, Desktop). Mirantis later reported a >$100M run
  rate two years on.
  - Source: [Mirantis on run rate over $100M two years after buying Docker Enterprise — TechCrunch (2022)](https://techcrunch.com/2022/02/09/mirantis-on-run-rate-over-100m-two-years-after-buying-docker-enterprise-assets/)
- **Post-split monetization:** Docker Hub rate limits (2020) and Docker Desktop
  paid licensing (2021) were the two pillars of monetizing the developer-tools
  business — both controversial (below).

---

## Controversies

Each item separates documented fact from reported claim/opinion, with attribution.

1. **CoreOS rkt / "monolithic Docker" critique (Dec 2014).**
   - *Fact:* CoreOS launched rkt and the appc spec in December 2014 as a Docker
     rival. (Sources above.)
   - *Reported opinion (attributed to Alex Polvi/CoreOS):* that Docker had grown
     into a "monolithic binary running primarily as root." This is CoreOS's
     stated critique as relayed in press coverage, not a neutral finding.
     - Source: [The Register — CoreOS Fest roundtable](https://www.theregister.com/2015/05/05/coreos_fest_roundtable/)

2. **The Moby rebrand (2017).**
   - *Fact:* Docker renamed the open-source upstream to "Moby" at DockerCon 2017.
   - *Reported claim:* widespread community confusion/backlash; The Register
     characterized it as a "rebrand meltdown," and reported lopsided negative
     GitHub reactions to Hykes' announcement. Years later the community still
     debated reverting the name (moby/moby#40222).
     - Sources: [The Register (Apr 2017)](https://www.theregister.com/2017/04/21/docker_renames_open_source_code_moby/);
       [The Register (Nov 2019)](https://www.theregister.com/2019/11/22/moby_docker_naming/);
       [moby/moby#40222 — GitHub](https://github.com/moby/moby/issues/40222)
     - **Could not verify** exact GitHub reaction counts independently.

3. **Docker Hub rate limits (Nov 2020).**
   - *Fact:* Docker imposed 100 (anon) / 200 (free auth) pulls per 6 hours.
   - *Documented impact/criticism:* CI/CD and Kubernetes/OpenShift users feared
     broken pipelines and outages; documented in multiple upstream issues and
     vendor mitigation guides (AWS, GitLab, Red Hat).
     - Sources: [AWS Containers blog](https://aws.amazon.com/blogs/containers/advice-for-customers-dealing-with-docker-hub-rate-limits-and-a-coming-soon-announcement/);
       [keptn#2294](https://github.com/keptn/keptn/issues/2294);
       [GitLab blog](https://about.gitlab.com/blog/2020/11/18/docker-hub-rate-limit-monitoring/)

4. **Docker Desktop paid licensing (Aug 31, 2021).**
   - *Fact:* Docker Desktop became paid (Pro/Team/Business) for orgs >250
     employees or >$10M revenue, grace period to Jan 31, 2022.
   - *Reported reaction:* described by some outlets as abrupt and disruptive for
     enterprise developers (e.g., ServeTheHome's "Docker Abruptly Starts Charging
     Many Users"); drove adoption of Podman, Rancher Desktop, and Colima/Lima.
     - Sources: [Docker press release](https://www.docker.com/press-release/docker-updates-product-subscriptions/);
       [InfoWorld](https://www.infoworld.com/article/2268969/docker-desktop-is-no-longer-free-for-enterprise-users.html);
       [ServeTheHome](https://www.servethehome.com/docker-abruptly-starts-charging-many-users-for-docker-desktop/)

5. **Business-model critique / "broke in half" (2019).**
   - *Reported analysis (attributed):* InfoWorld and others framed Docker's saga
     as a landmark open-source technology that never converted into a durable
     standalone business, culminating in the Enterprise sale. This is analysis,
     not a single objective fact.
     - Sources: [InfoWorld — How Docker broke in half](https://www.infoworld.com/article/2269272/how-docker-broke-in-half.html);
       [CNBC — Docker tells employees it's trying to raise cash (2019)](https://www.cnbc.com/2019/09/27/docker-is-trying-to-raise-money-following-arrival-of-ceo-rob-bearden.html)

---

## Solomon Hykes' arc (brief; see `history/dagger.md`)

After leaving Docker (2018), Solomon Hykes went on to found **Dagger**, a
programmable CI/CD / "DevOps as code" engine. To avoid duplication, Dagger's
own history, funding, and technical design are covered in `history/dagger.md`.
- Source (departure): [Solomon Hykes leaves Docker — TechCrunch (2018)](https://techcrunch.com/2018/03/28/solomon-hykes-leaves-docker-the-company-he-founded/)

---

## Current status (as of early 2025 / writing)

Docker, Inc. is a **developer-tools company** centered on Docker Desktop, Docker
Hub, Docker Scout (security/supply chain), Docker Build Cloud, and an AI
direction (GenAI Stack, Docker AI, GitHub Copilot extension). Leadership passed
from Scott Johnston (the architect of the developer-focused pivot) to **Don
Johnson** in February 2025; some analysts read the change as possibly presaging
a sale. The container *runtime* layer Docker created (runc, containerd, the OCI
specs) now lives in neutral foundations (OCI, CNCF) and underpins essentially
the entire cloud-native stack, including Kubernetes.
- Sources: [Highlights from DockerCon 2023 — Docker blog](https://www.docker.com/blog/highlights-from-dockercon-2023/);
  [Docker Build Cloud — SiliconANGLE](https://siliconangle.com/2024/03/21/docker-supports-build-dloud-save-developers-time-kubeconeu/);
  [Don Johnson CEO — Docker (2025)](https://www.docker.com/press-release/docker-announces-don-johnson-as-new-ceo-succeeding-scott-johnston/);
  [Analyst framing — TechTarget](https://www.techtarget.com/searchsoftwarequality/news/366619297/Docker-Inc-CEO-swap-has-analysts-anticipating-a-sale)
