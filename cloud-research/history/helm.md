# Helm: A Sourced History

Helm is the de facto package manager for Kubernetes. It packages Kubernetes
resources into reusable, versioned bundles called **charts**, providing for
Kubernetes roughly what `apt`, `yum`, or Homebrew provide for an operating
system. This document traces its history from a 2015 hackathon project at the
startup Deis through its acquisition by Microsoft, its donation to and
graduation from the CNCF, and the major architectural changes across Helm 2,
3, and 4.

Every non-trivial claim below carries a working source URL. Items that could
not be confirmed are flagged inline with **Could not verify**.

---

## Dated timeline

### 2015 — Origins at Deis

- **Mid-2015** — The startup **Deis** moved its platform-as-a-service from
  CoreOS's `fleet` to Kubernetes. One of the first tools they had to rewrite
  was their installation tool, `deisctl`. This rewrite became the seed of
  Helm. Source: Helm's own history page,
  ["Helm 3 Preview: Charting Our Future – Part 1: A History of Helm"](https://helm.sh/blog/helm-3-preview-pt1/).

- **October 15, 2015** — Helm was, per the project's own account, "officially
  born." It was modeled after package managers like **Homebrew, apt, and
  yum**, with the goal of making it easy to package and install applications
  on Kubernetes. Source: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/)
  and [Helm community history page](https://helm.sh/community/history/).

- **November 2015** — Helm was publicly announced at the **inaugural KubeCon
  in San Francisco** as a package manager for Kubernetes. This first
  generation is retrospectively known as **"Helm Classic"** (sometimes "Helm
  1"). Sources: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/);
  [Helm community history](https://helm.sh/community/history/).
  - **Could not verify:** The exact KubeCon date (the first KubeCon was held
    November 2015 in San Francisco, consistent with the project's "2015 at the
    inaugural KubeCon in San Francisco" claim, but I did not locate an
    independent primary source pinning Helm's announcement to a specific day
    at that event).
  - **Could not verify:** The original Deis blog post announcing Helm. The
    phrasing "the package manager for Kubernetes" is the long-standing
    tagline (it is the GitHub repo description today —
    [github.com/helm/helm](https://github.com/helm/helm)). The "Homebrew for
    Kubernetes" framing is well attested as the design inspiration (Helm
    Classic was modeled on Homebrew per the
    [history page](https://helm.sh/blog/helm-3-preview-pt1/)), but I could not
    locate the specific original announcement post containing that exact phrase.

Helm Classic's design used Kubernetes manifests with YAML front-matter
generators. This approach had significant limitations — hard-coded manifest
file lists and only fixed sequences of operations — which proved impractical
for production. Source: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).

### 2016 — The merge with Google's Deployment Manager → Helm 2

- **Late 2015 / January 2016** — As 2015 wound down, a team from **Google**
  reached out to the Helm team. Google had been building a similar tool,
  **Deployment Manager for Kubernetes**, a port of an existing tool for
  Google Cloud Platform (Google Cloud Storage / GCP "Deployment Manager").
  Source: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).

- **January 2016** — The Helm and Deployment Manager teams met in **Seattle**
  and agreed to merge the projects to create **Helm 2**. Along with Deis and
  Google, the company **SkippBox** joined the development team. The project
  moved under the Kubernetes organization. Sources:
  [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/);
  [Helm community history](https://helm.sh/community/history/).

- **2016** — **Helm 2.0 was released** later that year, after the codebase
  merge. Helm 2 introduced chart templates, in-cluster management, chart
  repositories, a stable package format, and a commitment to semantic
  versioning. Source: [Helm community history](https://helm.sh/community/history/).
  - **Could not verify:** The exact day/month of the Helm 2.0.0 release. The
    project's history pages state "later that year" (2016) without a precise
    date, and I did not confirm a specific release date from a primary source.

- **Tiller introduced.** The merge brought in an in-cluster server-side
  component called **Tiller**, which handled installing and managing charts.
  Per Helm's own account, "Tiller didn't actually originate in the Helm
  project but was added when the codebase for a project called Kubernetes
  Deployment Manager was merged with Helm." Source:
  [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).

### 2017 — Microsoft acquires Deis

- **April 10, 2017** — Microsoft announced it would **acquire Deis** to help
  companies build and deploy containerized workloads on Azure. The deal was
  announced by Scott Guthrie (Microsoft EVP for Cloud and Enterprise). Terms
  were not disclosed. Sources: [Official Microsoft Blog](https://blogs.microsoft.com/blog/2017/04/10/microsoft-acquire-deis-help-companies-innovate-containers/);
  [TechCrunch](https://techcrunch.com/2017/04/10/microsoft-acquires-container-platform-deis/);
  [VentureBeat](https://venturebeat.com/2017/04/10/microosoft-acquires-kubernetes-experts-deis-from-engine-yard/).

- Microsoft acquired Deis from **Engine Yard**, which had itself acquired
  Deis in 2015. At the time of acquisition Deis's open-source portfolio was
  Workflow (a PaaS), **Helm (the Kubernetes package manager)**, and Steward
  (a service broker). Deis's CTO was **Gabe Monroy**. Sources:
  [TechCrunch](https://techcrunch.com/2017/04/10/microsoft-acquires-container-platform-deis/);
  [Official Microsoft Blog](https://blogs.microsoft.com/blog/2017/04/10/microsoft-acquire-deis-help-companies-innovate-containers/).

- **April 21, 2017** — The acquisition was completed (closed). Source:
  [SDxCentral](https://www.sdxcentral.com/articles/news/microsoft-acquires-container-software-company-deis/2017/04/).
  - **Could not verify:** Independent confirmation of the precise close date
    of April 21, 2017 beyond the single secondary source above. The April 10
    announcement is well attested across many outlets.

This acquisition brought the core Deis/Helm team — including Matt Butcher and
colleagues — into Microsoft, where much of Helm's subsequent development (Helm
2 maturation and Helm 3) occurred.

### 2018 — Donation to the CNCF

- **June 1, 2018** — Helm was accepted into the **Cloud Native Computing
  Foundation (CNCF)** at the **Incubating** maturity level, transitioning
  from a Kubernetes sub-project to a standalone CNCF project. Around this
  time related sub-projects (Monocular, Chart Repo / ChartMuseum) were
  absorbed. Sources: [CNCF Helm project page](https://www.cncf.io/projects/helm/);
  [Wikipedia: Helm (software)](https://en.wikipedia.org/wiki/Helm_(software));
  [Helm community history](https://helm.sh/community/history/).

### 2019 — Helm 3 removes Tiller

- **May 2019** — A **Helm 3 alpha** was released and the redesign was
  publicly previewed. Sources:
  [CNCF blog: "Helm 3 preview: Helm 3 Alpha release available and what's next"](https://www.cncf.io/blog/2019/05/16/helm-3-preview-helm-3-alpha-release-available-and-whats-next/);
  [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).

- **November 13, 2019** — **Helm 3.0.0** was released. The headline change
  was the **complete removal of Tiller**. Sources:
  [Helm blog: "Helm 3.0.0 has been released!"](https://helm.sh/blog/helm-3-released/);
  [InfoQ Q&A with Matt Fisher](https://www.infoq.com/news/2019/11/helm3-matt-fisher/).

### 2020 — CNCF graduation

- **April 30, 2020** — The CNCF announced that **Helm graduated** — the CNCF
  Technical Oversight Committee voted to make Helm a top-level (graduated)
  project. It was the **tenth project** to reach CNCF graduated status.
  Sources: [CNCF announcement](https://www.cncf.io/announcements/2020/04/30/cloud-native-computing-foundation-announces-helm-graduation/);
  [Helm blog: "Celebrating Helm's CNCF Graduation"](https://helm.sh/blog/celebrating-helms-cncf-graduation/);
  [Microsoft Open Source Blog](https://opensource.microsoft.com/blog/2020/05/01/helm-package-manager-kubernetes-now-cncf-graduated-project).

- **May 1, 2020** — The CNCF project page and Wikipedia record the graduated
  maturity level taking effect **May 1, 2020** (the announcement was dated
  April 30, 2020). Sources: [Wikipedia: Helm (software)](https://en.wikipedia.org/wiki/Helm_(software));
  [CNCF Helm project page](https://www.cncf.io/projects/helm/).
  - Note: secondary outlets sometimes report the graduation simply as "May
    2020." The April 30 announcement / May 1 effective-date pairing is the
    most precise reading of the primary sources.

### 2020 — Helm Hub → Artifact Hub

- **2020** — Chart discovery moved from the **Helm Hub** (built on the
  **Monocular** project) to **Artifact Hub**, a broader CNCF project for
  finding and publishing Cloud Native packages. The Helm project deferred
  chart discovery to Artifact Hub rather than scaling Monocular itself.
  Source: [Helm blog: "Helm Hub Moving To Artifact Hub"](https://helm.sh/blog/helm-hub-moving-to-artifact-hub/);
  [Artifact Hub](https://artifacthub.io/).
  - **Could not verify:** The exact month of the Helm Hub → Artifact Hub
    cutover. Secondary sources cite "October 2020"; the primary Helm blog
    post announcing the move does not carry a date I could independently
    confirm to the month from a primary source.

### 2025 — Helm 4 and the 10-year mark

- **November 12, 2025** — **Helm 4.0.0** was released at **KubeCon +
  CloudNativeCon North America 2025** (Atlanta), marking Helm's **10th
  anniversary** and the first major version in roughly six years. Notable
  features: an overhauled **plugin system with optional WebAssembly (Wasm)
  plugins** (portable across OS/architecture), Server-Side Apply, and an
  expanded SDK. Sources:
  [CNCF announcement: "Helm Marks 10 Years With Release of Version 4"](https://www.cncf.io/announcements/2025/11/12/helm-marks-10-years-with-release-of-version-4/);
  [Helm blog: "Helm 4 Released"](https://helm.sh/blog/helm-4-released/);
  [InfoQ](https://www.infoq.com/news/2025/11/helm-4/).
  - Note: some project materials reference the release as "November 12, 2025";
    others (and the broader KubeCon week) reference November 12 as the
    announcement at the conference. Treat as on/around November 12, 2025.

---

## Helm 2's Tiller and the security controversy

**What Tiller was.** Helm 2 used a client/server architecture. The `helm` CLI
(client) talked to **Tiller**, a server-side component that ran *inside* the
Kubernetes cluster. Tiller received commands from the client, rendered charts,
and applied the resulting resources to the cluster, also tracking release
state. Tiller arrived via the Deployment Manager merge rather than originating
in Helm itself. Source: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).

**The security problem.** Because Tiller acted on behalf of all users and
talked directly to the Kubernetes API, it needed broad permissions. After
**Kubernetes 1.6 enabled Role-Based Access Control (RBAC) by default**,
properly scoping Tiller became difficult, and the path of least resistance was
to grant Tiller a service account with **cluster-admin** privileges. In many
default installs Tiller also listened without authentication, so any pod that
could reach Tiller's in-cluster endpoint could ask it to perform
cluster-admin-level actions — a straightforward **privilege-escalation /
cluster-takeover** vector if any pod was compromised. Sources:
[ropnop: "Attacking Default Installs of Helm on Kubernetes"](https://blog.ropnop.com/attacking-default-installs-of-helm-on-kubernetes/);
[Helm v2 docs: "Securing your Helm Installation"](https://helm.sh/docs/v2/using_helm/securing_installation/);
[Helm v2 docs: "Tiller and Role-based Access Control"](https://v2.helm.sh/docs/rbac/);
[Kubernetes Goat scenario: "Helm v2 Tiller to PwN the cluster"](https://madhuakula.com/kubernetes-goat/docs/scenarios/scenario-9/helm-v2-tiller-to-pwn-kubernetes-cluster-takeover/welcome/).

**The official position.** Helm's own documentation acknowledged the risk and
gave hardening guidance: Tiller did not *require* cluster-admin; operators
could scope it to a namespace with a `Role`/`RoleBinding` instead of a
cluster-wide `ClusterRole`/`ClusterRoleBinding`, enable TLS between client and
Tiller, and restrict its service account. Source:
[Helm v2 docs: "Securing your Helm Installation"](https://helm.sh/docs/v2/using_helm/securing_installation/)
and [Tiller RBAC docs](https://v2.helm.sh/docs/rbac/).

**Attribution of the criticism.** The strongest "default installs are
dangerous" framing comes from independent security researchers and red-team
material — e.g., the ropnop write-up and the Kubernetes Goat hands-on
scenario cited above — rather than from the Helm maintainers, who framed it as
a configuration/hardening problem. The Helm team ultimately agreed the design
was a liability: removing Tiller was, by their own account, "one of the first
decisions made regarding Helm 3." Source:
[Helm v3 FAQ: "Changes Since Helm 2"](https://helm.sh/docs/v3/faq/changes_since_helm2/).

---

## Helm 3: the architectural change

Helm 3 was a major redesign whose defining feature was the **removal of
Tiller**:

- **No server-side component.** The `helm` client now talks **directly** to
  the Kubernetes API server, using the *user's own* kubeconfig credentials
  and Kubernetes-native RBAC. This eliminated the privileged in-cluster
  daemon and its associated attack surface. Sources:
  [Helm v3 FAQ](https://helm.sh/docs/v3/faq/changes_since_helm2/);
  [InfoQ Q&A](https://www.infoq.com/news/2019/11/helm3-matt-fisher/).

- **Release state moved into the cluster as Secrets, scoped by namespace.**
  Release information is stored in the same namespace as the release (by
  default as Kubernetes Secrets), so the same release name can exist in
  multiple namespaces. Source: [Helm v3 FAQ](https://helm.sh/docs/v3/faq/changes_since_helm2/).

- **Three-way strategic merge patches** on upgrade/rollback — Helm 3
  considers the old manifest, the live cluster state, and the new manifest
  (Helm 2 used a two-way merge), better reconciling out-of-band changes.
  Source: [Helm v3 FAQ](https://helm.sh/docs/v3/faq/changes_since_helm2/).

- **Other changes:** optional **JSON Schema validation** of chart values,
  **library charts**, and experimental **OCI registry** support for storing
  charts. Sources: [Helm v3 FAQ](https://helm.sh/docs/v3/faq/changes_since_helm2/);
  [Helm 3.0.0 release blog](https://helm.sh/blog/helm-3-released/).

The motivation was explicitly the RBAC/security situation described above: by
Helm's own account, with RBAC on by default in Kubernetes 1.6, locking Tiller
down for production became hard, so the team chose to remove it entirely.
Source: [Helm v3 FAQ](https://helm.sh/docs/v3/faq/changes_since_helm2/).

---

## Charts, repositories, and Artifact Hub

- **Charts** are Helm's packaging format: a bundle of templated files that
  describe a related set of Kubernetes resources, with values that customize a
  deployment. Source: [CNCF graduation announcement](https://www.cncf.io/announcements/2020/04/30/cloud-native-computing-foundation-announces-helm-graduation/).

- Charts are distributed via **chart repositories** (HTTP servers serving an
  `index.yaml` plus packaged charts); **ChartMuseum** and the legacy
  `helm/charts` "stable" repo were part of the early ecosystem. Discovery was
  originally provided by the **Helm Hub** (built on **Monocular**).

- **Artifact Hub** (a CNCF project) superseded the Helm Hub as the central
  place to find and publish Helm charts (and other Cloud Native artifacts),
  because Monocular did not scale to the growing number of repositories.
  Sources: [Helm blog: "Helm Hub Moving To Artifact Hub"](https://helm.sh/blog/helm-hub-moving-to-artifact-hub/);
  [Artifact Hub](https://artifacthub.io/).

---

## Current status

Helm is a **CNCF graduated project** (since 2020) and remains the dominant
package manager for Kubernetes. The current major line is **Helm 4** (released
November 2025), with Helm 3 having been the long-lived prior generation.
Sources: [CNCF Helm project page](https://www.cncf.io/projects/helm/);
[CNCF Helm 4 announcement](https://www.cncf.io/announcements/2025/11/12/helm-marks-10-years-with-release-of-version-4/).
The Wikipedia article records a stable release of **v4.1.4 (April 2026)**,
indicating active maintenance on the Helm 4 line. Source:
[Wikipedia: Helm (software)](https://en.wikipedia.org/wiki/Helm_(software)).

---

## Key people & teams

- **The Deis team (2015–2017).** Helm was created by engineers at **Deis**.
  **Matt Butcher** is consistently credited as a/the original creator and
  long-time leader of the project; he later described the project's goals in
  the CNCF graduation announcement as a maintainer at Microsoft. Sources:
  [CNCF graduation announcement](https://www.cncf.io/announcements/2020/04/30/cloud-native-computing-foundation-announces-helm-graduation/)
  (quotes Matt Butcher, Microsoft, as a Helm maintainer);
  [Fermyon team page](https://www.fermyon.com/team) (describes Butcher as one
  of the original creators of Helm).
- **Gabe Monroy** — CTO of Deis at the time of the Microsoft acquisition.
  Source: [Official Microsoft Blog](https://blogs.microsoft.com/blog/2017/04/10/microsoft-acquire-deis-help-companies-innovate-containers/).
- **Google's Deployment Manager team** — merged their Kubernetes Deployment
  Manager effort into Helm in January 2016 to form Helm 2. **SkippBox** also
  joined the development team. Source: [Helm 3 Preview Part 1](https://helm.sh/blog/helm-3-preview-pt1/).
- **Matt Fisher** (Microsoft) — a Helm 3 lead/maintainer who spoke for the
  Helm 3 release. Source: [InfoQ Q&A with Matt Fisher](https://www.infoq.com/news/2019/11/helm3-matt-fisher/).
- **Maintainers named in the 2020 graduation announcement** include Matt
  Butcher and Matt Fisher (Microsoft), **Katie Gamanji** (then American
  Express; CNCF TOC), **Nick Shine** (State Farm), and **Liying Zhang** (JD
  Retail). Source: [CNCF graduation announcement](https://www.cncf.io/announcements/2020/04/30/cloud-native-computing-foundation-announces-helm-graduation/).
  - **Could not verify:** A complete, authoritative roster of Helm's founding
    engineers beyond those named above. Helm's MAINTAINERS file in
    [github.com/helm/helm](https://github.com/helm/helm) is the canonical
    current list, but I did not enumerate it here from a primary source.

---

## Company & corporate history (Deis → Microsoft)

- **Deis** was a container/PaaS startup. It had been **acquired by Engine
  Yard in 2015**, and Helm was created at Deis during that period. Source:
  [TechCrunch](https://techcrunch.com/2017/04/10/microsoft-acquires-container-platform-deis/);
  [VentureBeat](https://venturebeat.com/2017/04/10/microosoft-acquires-kubernetes-experts-deis-from-engine-yard/).
- **Microsoft acquired Deis** (from Engine Yard), announced **April 10,
  2017**, closed **April 21, 2017**, terms undisclosed. This brought the
  Deis/Helm team into Microsoft, which subsequently stewarded Helm 2's
  maturation and Helm 3. Sources:
  [Official Microsoft Blog](https://blogs.microsoft.com/blog/2017/04/10/microsoft-acquire-deis-help-companies-innovate-containers/);
  [TechCrunch](https://techcrunch.com/2017/04/10/microsoft-acquires-container-platform-deis/);
  [SDxCentral](https://www.sdxcentral.com/articles/news/microsoft-acquires-container-software-company-deis/2017/04/).

### The Matt Butcher → Fermyon → Akamai thread

- **2021** — **Matt Butcher** (Helm co-creator) and **Radu Matei** co-founded
  **Fermyon**, a company building serverless computing on **WebAssembly
  (Wasm)**. Per Fermyon's own telling, Butcher and a group of colleagues from
  Microsoft left to pursue a gap they felt containers couldn't fill. Sources:
  [Fermyon team page](https://www.fermyon.com/team);
  [Frontlines podcast profile of Matt Butcher](https://www.frontlines.io/podcasts/matt-butcher/).
  - **Could not verify:** A primary corporate filing or press release pinning
    Fermyon's founding precisely to 2021; the year is attested by secondary
    profiles and Fermyon's own materials, which I treated as consistent.
- Fermyon maintains the **Spin** and **SpinKube** CNCF open-source projects
  and is a member of the Bytecode Alliance. Source:
  [Akamai press release (GlobeNewswire)](https://www.globenewswire.com/news-release/2025/12/01/3196978/0/en/Akamai-Technologies-Announces-Acquisition-of-Function-as-a-Service-Company-Fermyon.html).
- **December 1, 2025** — **Akamai acquired Fermyon** to bolster edge / serverless
  (Wasm function-as-a-service); co-founders Matt Butcher and Radu Matei joined
  Akamai's Cloud Technology Group. Sources:
  [Akamai newsroom](https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon);
  [Akamai press release (GlobeNewswire)](https://www.globenewswire.com/news-release/2025/12/01/3196978/0/en/Akamai-Technologies-Announces-Acquisition-of-Function-as-a-Service-Company-Fermyon.html);
  [Fermyon blog: "Fermyon Joins Akamai"](https://www.fermyon.com/blog/fermyon-joins-akamai).

This thread is relevant because it connects Helm's lineage (Deis → Microsoft)
to a later wave of Wasm-centric infrastructure work — and it loops back to
Helm itself, whose Helm 4 plugin system (November 2025) adopted **WebAssembly
plugins**, the very technology Butcher's post-Helm career has championed.
Sources: [CNCF Helm 4 announcement](https://www.cncf.io/announcements/2025/11/12/helm-marks-10-years-with-release-of-version-4/);
[Helm 4 release blog](https://helm.sh/blog/helm-4-released/).

---

## Summary of "Could not verify" items

1. The exact day of Helm's announcement at the inaugural KubeCon (Nov 2015)
   from an independent primary source.
2. The original Deis blog post announcing Helm and the exact "Homebrew for
   Kubernetes" / "the package manager for Kubernetes" first-use phrasing.
3. The precise Helm 2.0.0 release date (project history says only "later that
   year," 2016).
4. Independent confirmation of the **April 21, 2017** Deis acquisition close
   date (the April 10 announcement is well attested; the close date rests on a
   single secondary source).
5. The exact month of the Helm Hub → Artifact Hub migration (commonly cited as
   October 2020; not pinned from a dated primary source here).
6. A complete authoritative roster of Helm's founding engineers beyond the
   named maintainers.
7. A primary filing confirming Fermyon's founding precisely in 2021 (attested
   by secondary/company materials).
