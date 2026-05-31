# Argo CD, Flux, and the GitOps Movement: A Sourced History

A chronological, fully-cited history of the two leading GitOps tools — **Flux**
(Weaveworks) and **Argo CD** (Applatix → Intuit) — and the broader GitOps
movement they anchored. Every non-trivial claim links to a working source.
Items that could not be confirmed from a reputable source are marked
**"Could not verify."**

---

## Timeline

### 2014
- **2014** — **Weaveworks is founded** by Alexis Richardson (and co-founders).
  The company would later coin "GitOps" and create Flux.
  Source: [TechCrunch, "Cloud native container management platform Weaveworks
  shuts its doors" (Feb 5, 2024)](https://techcrunch.com/2024/02/05/cloud-native-container-management-platform-weaveworks-shuts-its-doors/)
  ("Founded in 2014"); [SD Times, "State of GitOps now in Flux as Weaveworks
  shuts down"](https://sdtimes.com/softwaredev/state-of-gitops-now-in-flux-as-weaveworks-shuts-down/).

### 2016
- **July 2016** — **Flux is created** by engineers at Weaveworks, originally as
  an internal tool to guarantee predictable deployments.
  Source: [Flux blog, "Flux is a CNCF Graduated project" (Nov 30, 2022)](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/)
  ("July 2016: Flux was originally built by engineers at Weaveworks");
  corroborated by [Platform9, "An introduction to Flux - Part 1: History and
  features"](https://platform9.com/blog/an-introduction-to-flux-part-1-history-and-features/).

### 2017
- **The term "GitOps" is coined by Alexis Richardson**, Weaveworks CEO, in
  **2017**. The widely-cited origin is his Weaveworks blog post
  "GitOps - Operations by Pull Request" (the Weaveworks blog dates it to early
  2017; the company's own domain `weave.works` is now defunct — see note below).
  Source: [SiliconANGLE, "How Weaveworks pioneered GitOps and brought containers
  into the mainstream"](https://siliconangle.com/2022/01/20/weaveworks-pioneered-gitops-brought-containers-mainstream-awsshowcases2e1/)
  ("In 2017, Alexis Richardson of Weaveworks coined the term GitOps").
  - **Nuance / attribution:** In a later interview, Richardson himself said he
    could not pin down the exact moment, recalling "a sunny spring day maybe
    2016 maybe 2017, I can't remember when" he "suddenly realized that one word
    we could use to describe all of this was GitOps." The term described
    practices his team was *already* using, rather than a planned invention.
    Source: [Schlomo Schapiro, "How did GitOps get started? An interview with
    Alexis Richardson" (Feb 2021)](https://schlomo.schapiro.org/2021/02/gitops-interview-alexis-richardson.html).
  - **Could not verify (exact date):** The precise publication date of the
    original "GitOps - Operations by Pull Request" post on weave.works. The
    weave.works domain no longer serves the blog (it now redirects to an
    unrelated parked/spam page), so the original article could not be fetched
    live. Secondary sources place it in 2017; one secondary blog claims
    "March 02, 2017" but this could not be confirmed against a primary source.
- **January 27, 2017** — Weaveworks releases Flux **v0.1.0**, declaring it ready
  for public use. **Could not verify** against a primary Weaveworks/GitHub
  source in this research; reported by [Platform9, "An introduction to Flux -
  Part 1"](https://platform9.com/blog/an-introduction-to-flux-part-1-history-and-features/).
- **August 2017** — The **Applatix** team launches **Argo** (the project now
  known as **Argo Workflows**) on GitHub; in October 2017 they re-implement the
  workflow engine as a Kubernetes CRD.
  Source: [CNCF blog, "Four lessons that took Argo from first commit to GitOps
  darling" (Sep 21, 2022)](https://www.cncf.io/blog/2022/09/21/four-lessons-that-took-argo-from-first-commit-to-gitops-darling/);
  [CNCF Argo graduation announcement (Dec 6, 2022)](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/)
  ("created and open sourced in 2017 by Applatix").
- **KubeCon Austin (Dec 2017)** — Applatix exhibits Argo; the Argo Workflows
  open-source project was released shortly before the Intuit acquisition.
  Source: [Kubernetes Podcast, Episode 172 - "Argo, with Jesse Suen"](https://kubernetespodcast.com/episode/172-argo/).

### 2018
- **January 2018** — **Intuit acquires Applatix.** Argo's three founding
  engineers — Hong Wang, Jesse Suen, and Alexander Matyushentsev — join Intuit.
  Source: [Akuity company page](https://akuity.io/company)
  ("founding engineers at Applatix (acquired by Intuit)"); acquisition timing
  per [CNCF "Four lessons" blog](https://www.cncf.io/blog/2022/09/21/four-lessons-that-took-argo-from-first-commit-to-gitops-darling/).
- **2018** — At Intuit, **Jesse Suen and Alexander Matyushentsev start the
  Argo CD project** — a Kubernetes-native declarative GitOps continuous-delivery
  tool — and open-source it. Argo CD was *built at Intuit* (not at Applatix).
  Source: [Akuity company page](https://akuity.io/company)
  (Alexander "led the development of Argo CD" at Intuit; Jesse was "technical
  lead for the Argo team at Intuit");
  GitHub: [argoproj/argo-cd](https://github.com/argoproj/argo-cd).
- **2018** — **Flagger** is created as a Weaveworks companion project to Flux for
  progressive delivery.
  Source: [Flux blog, "Flux is a CNCF Graduated project"](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/).

### 2019
- **2019** — **Weaveworks donates Flux (and Flagger) to the CNCF.** After the
  donation, adoption grew rapidly.
  Source: [Platform9, "An introduction to Flux - Part 1"](https://platform9.com/blog/an-introduction-to-flux-part-1-history-and-features/)
  ("In 2019, Weaveworks decided to donate the project to CNCF"); CNCF acceptance
  context in [Flux blog](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/).

### 2020
- **April 7, 2020** — The **CNCF Technical Oversight Committee accepts Argo as a
  CNCF incubation-level project.** At incubation, Argo comprised four
  subprojects: **Argo Workflows, Argo Events, Argo CD, and Argo Rollouts.**
  BlackRock contributed Argo Events.
  Source: [CNCF blog, "TOC welcomes Argo into the CNCF incubator"
  (Apr 7, 2020)](https://www.cncf.io/blog/2020/04/07/toc-welcomes-argo-into-the-cncf-incubator/);
  [Intuit blog, "CNCF Accepts Argo as an Incubator Project"](https://www.intuit.com/blog/news-social/cloud-native-computing-foundation-accepts-argo-as-an-incubator-project/).
- **April–May 2020** — The Flux team decides to **rewrite Flux from scratch**
  using modern Kubernetes tooling (controller-runtime, CRDs), splitting it into
  specialized controllers/APIs branded the **GitOps Toolkit**. Flux v2 is
  launched and the original Flux ("Flux v1") moves toward maintenance mode.
  Source: [Flux blog, "Flux is a CNCF Graduated project"](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/)
  (decision to "rewrite Flux from scratch, using modern tooling such as
  controller-runtime"); [Platform9 history](https://platform9.com/blog/an-introduction-to-flux-part-1-history-and-features/)
  ("April 2020 ... GitOps Toolkit"; "May 2020, the Flux v2 project was
  launched"); GitHub: [fluxcd/flux2](https://github.com/fluxcd/flux2),
  legacy [fluxcd/flux](https://github.com/fluxcd/flux).

### 2021
- **January 26, 2021** — **OpenGitOps** is accepted into the CNCF at **Sandbox**
  maturity level. It is the home for "lasting programs, documents and code"
  from the **GitOps Working Group (GWG)**, which sits under the CNCF App
  Delivery SIG/TAG.
  Source: [CNCF OpenGitOps project page](https://www.cncf.io/projects/opengitops/);
  [OpenGitOps "About"](https://opengitops.dev/about/).
- **March 2021** — **Flux joins the CNCF Incubator** (promoted from Sandbox).
  Source: [CNCF, "Flux Graduates from the CNCF Incubator" (Nov 30, 2022)](https://www.cncf.io/announcements/2022/11/30/flux-graduates-from-cncf-incubator/)
  ("Since joining the CNCF Incubator in March 2021").
- **November 8, 2021** — The GitOps Working Group releases the
  **OpenGitOps Principles v1.0.0**, formalizing the four GitOps principles:
  (1) **Declarative**, (2) **Versioned and Immutable**, (3) **Pulled
  Automatically**, (4) **Continuously Reconciled.** The effort was launched by
  Amazon, Azure (Microsoft), Codefresh, GitHub, Red Hat, and Weaveworks.
  Source: [OpenGitOps blog, "OpenGitOps 1.0 is finally here and why you should
  care"](https://opengitops.dev/blog/1.0-announcement/);
  [GitHub: open-gitops/documents PRINCIPLES.md @ v1.0.0](https://github.com/open-gitops/documents/blob/v1.0.0/PRINCIPLES.md);
  [release v1.0.0 tag](https://github.com/open-gitops/documents/releases/tag/v1.0.0).

### 2022
- **November 30, 2022** — **Flux graduates** from the CNCF Incubator (the 18th
  CNCF project to graduate), together with its subproject Flagger. CNCF cited
  200–500% growth since entering the incubator and a top CLO-monitor compliance
  score among graduated projects.
  Source: [CNCF announcement (Nov 30, 2022)](https://www.cncf.io/announcements/2022/11/30/flux-graduates-from-cncf-incubator/);
  [Flux blog](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/).
- **December 6, 2022** — **Argo graduates** from the CNCF Incubator. CNCF noted
  Argo grew ~250% since entering the incubator, with contributions from ~2,300
  companies and ~8,000 individuals, and adopters including Adobe, BlackRock,
  Capital One, Google, Intuit, Peloton, Tesla, and Ticketmaster.
  Source: [CNCF announcement (Dec 6, 2022)](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/);
  [Red Hat blog, "The Argo Project Graduates at the CNCF"](https://www.redhat.com/en/blog/the-argo-project-graduates-at-the-cncf).

### 2024 — The Weaveworks shutdown (the big controversy)
- **February 5, 2024** — **Weaveworks announces it is shutting down**, confirmed
  by CEO **Alexis Richardson** in a LinkedIn post ("Hi everyone, I am very sad
  to announce ... Weaveworks is closing its doors"). The company that coined
  "GitOps" and created Flux went out of business.
  Source: [Alexis Richardson LinkedIn post](https://www.linkedin.com/posts/richardsonalexis_hi-everyone-i-am-very-sad-to-announce-activity-7160295096825860096-ZS67);
  [TechCrunch (Feb 5, 2024)](https://techcrunch.com/2024/02/05/cloud-native-container-management-platform-weaveworks-shuts-its-doors/);
  [The New Stack, "End of an Era: Weaveworks Closes Shop Amid Cloud Native
  Turbulence"](https://thenewstack.io/end-of-an-era-weaveworks-closes-shop-amid-cloud-native-turbulence/);
  [The Register (Feb 6, 2024)](https://www.theregister.com/2024/02/06/weaveworks_folds/).
  - **Reasons (per Richardson / TechCrunch):** despite double-digit growth in
    2023 and reported revenue over $10M, sales were uneven ("lumpy"), capital
    was running short, and a pending acquisition fell through; competition from
    better-capitalized rivals (e.g., Harness, CircleCI) is cited. Weaveworks had
    raised over $61M total, with a final $36M round at the end of 2020.
    Source: [TechCrunch](https://techcrunch.com/2024/02/05/cloud-native-container-management-platform-weaveworks-shuts-its-doors/);
    [SD Times](https://sdtimes.com/softwaredev/state-of-gitops-now-in-flux-as-weaveworks-shuts-down/).
- **Fate of Flux after Weaveworks:** Flux survived because it was already a
  CNCF-owned project. Richardson said he was working with several large
  organizations to keep CNCF Flux healthy, and CNCF CTO Chris Aniszczyk noted
  many Flux maintainers had already been hired elsewhere.
  Source: [The New Stack, "Why Flux Isn't Dying after Weaveworks"](https://thenewstack.io/why-flux-isnt-dying-after-weaveworks/);
  [Fierce Network, "Weaveworks unravels. Here's what that means for CNCF and the
  Flux project"](https://www.fierce-network.com/automation/weaveworks-unravels-heres-what-means-flux).
- **ControlPlane steps in as steward:** Security firm **ControlPlane** employed
  Flux's core maintainers to sustain the project and later created an enterprise
  edition, ensuring continued open-source development.
  Source: [ControlPlane, "ControlPlane backs the CNCF Flux Project by Employing
  Maintainers"](https://control-plane.io/posts/controlplane-backs-the-cncf-flux-project-by-employing-maintainers/);
  [The New Stack, "Celebrating a Year of Commitment to CNCF Flux"](https://thenewstack.io/celebrating-a-year-of-commitment-to-cncf-flux-sustainability-innovation-and-growth/);
  [IT Pro, "Why Flux CD's survival is another major victory for the open source
  community"](https://www.itpro.com/software/open-source/why-flux-cds-survival-is-another-major-victory-for-the-open-source-community).

---

## Key people & teams

- **Alexis Richardson** — Co-founder and CEO of Weaveworks (founded 2014).
  Coined the term **"GitOps" (2017)**; announced Weaveworks' shutdown on
  **Feb 5, 2024**. Was also involved in CNCF leadership (chaired the CNCF TOC in
  its early years). TOC-chair detail **could not verify** in this research and
  is excluded from claims above.
  Sources: [SiliconANGLE](https://siliconangle.com/2022/01/20/weaveworks-pioneered-gitops-brought-containers-mainstream-awsshowcases2e1/);
  [LinkedIn shutdown post](https://www.linkedin.com/posts/richardsonalexis_hi-everyone-i-am-very-sad-to-announce-activity-7160295096825860096-ZS67).

- **The Argo founders — Hong Wang, Jesse Suen, Alexander Matyushentsev** —
  Founding engineers at **Applatix**, which open-sourced Argo (Workflows) in
  2017. After Intuit's acquisition (Jan 2018), **Jesse Suen** was technical lead
  for the Argo team at Intuit and **Alexander Matyushentsev** led development of
  **Argo CD**. In 2021 the three co-founded **Akuity**, a commercial company
  built around Argo.
  Sources: [Akuity company page](https://akuity.io/company);
  [VentureBeat, "Enterprise Argo company Akuity raises $20M"](https://venturebeat.com/business/enterprise-argo-company-akuity-raises-20m-to-power-kubernetes-app-delivery);
  [Kubernetes Podcast Ep. 172](https://kubernetespodcast.com/episode/172-argo/).

- **Flux maintainers (incl. Stefan Prodan)** — Core Flux/Flagger maintainers at
  Weaveworks who drove the Flux v2 / GitOps Toolkit rewrite and graduation; post
  Weaveworks they were employed by ControlPlane to keep the project going.
  Sources: [Stefan Prodan's blog, "Flux project graduates from the CNCF
  incubator"](https://stefanprodan.com/blog/2022/flux-project-graduates-from-the-cncf-incubator/);
  [ControlPlane](https://control-plane.io/posts/controlplane-backs-the-cncf-flux-project-by-employing-maintainers/).
  - **Could not verify:** A complete, authoritative roster of every Flux core
    maintainer (and exactly which companies hired which individuals) from a
    single primary source.

- **GitOps Working Group (GWG) / OpenGitOps** — A vendor-neutral consortium
  under the CNCF App Delivery SIG/TAG that defined the GitOps principles.
  Launching organizations: **Amazon, Azure (Microsoft), Codefresh, GitHub,
  Red Hat, and Weaveworks.**
  Source: [OpenGitOps "1.0" announcement](https://opengitops.dev/blog/1.0-announcement/);
  [OpenGitOps "About"](https://opengitops.dev/about/).

---

## Company & corporate history

### Weaveworks (Flux)
- **Founded:** 2014 by Alexis Richardson and co-founders.
- **Funding:** Raised **over $61M total**; final round **$36M at the end of
  2020**.
- **Product/market:** Originated and commercialized GitOps; built Flux and
  Flagger; sold the "Weave GitOps" platform and an enterprise Flux UI.
- **Shutdown:** Announced **Feb 5, 2024**. Cited "lumpy" sales, capital
  shortfall, a failed acquisition, and well-funded competition.
- **Legacy / aftermath:** Flux (CNCF-owned) survived; **ControlPlane** employed
  the maintainers and now offers an enterprise edition. The shutdown was widely
  covered as a cautionary tale about open-source commercialization and "cloud
  native turbulence."
  Sources: [TechCrunch](https://techcrunch.com/2024/02/05/cloud-native-container-management-platform-weaveworks-shuts-its-doors/);
  [The New Stack "End of an Era"](https://thenewstack.io/end-of-an-era-weaveworks-closes-shop-amid-cloud-native-turbulence/);
  [The Register](https://www.theregister.com/2024/02/06/weaveworks_folds/);
  [SD Times](https://sdtimes.com/softwaredev/state-of-gitops-now-in-flux-as-weaveworks-shuts-down/);
  [ControlPlane](https://control-plane.io/posts/controlplane-backs-the-cncf-flux-project-by-employing-maintainers/).

### Applatix → Intuit → Akuity (Argo)
- **Applatix:** Startup that created and open-sourced Argo (Workflows) in 2017;
  built a platform for running containerized workloads in the public cloud.
- **Intuit acquisition (Jan 2018):** Intuit acquired Applatix to deepen its
  developer/GitOps capabilities. **Argo CD was built at Intuit**, and Argo grew
  to four subprojects (Workflows, CD, Rollouts, Events). BlackRock contributed
  Argo Events and became a major co-maintainer.
- **Akuity (2021):** The three Argo co-founders left Intuit to found Akuity, a
  commercial company offering an enterprise Argo platform; raised a $20M round.
- Argo remains a **CNCF Graduated** project (Dec 6, 2022) with broad
  multi-vendor governance.
  Sources: [CNCF "Four lessons"](https://www.cncf.io/blog/2022/09/21/four-lessons-that-took-argo-from-first-commit-to-gitops-darling/);
  [Intuit blog](https://www.intuit.com/blog/news-social/cloud-native-computing-foundation-accepts-argo-as-an-incubator-project/);
  [CNCF Argo graduation](https://www.cncf.io/announcements/2022/12/06/the-cloud-native-computing-foundation-announces-argo-has-graduated/);
  [Akuity company page](https://akuity.io/company);
  [VentureBeat](https://venturebeat.com/business/enterprise-argo-company-akuity-raises-20m-to-power-kubernetes-app-delivery);
  [Red Hat & Intuit joint Argo press release](https://www.redhat.com/en/about/press-releases/red-hat-and-intuit-join-forces-argo-project-extending-gitops-community-innovation-better-manage-multi-cluster-cloud-native-applications-scale).

### CNCF (steward of both projects)
- Both Flux (donated by Weaveworks, 2019) and Argo (Applatix/Intuit lineage,
  incubator 2020) are CNCF projects, which is precisely why **both survived
  their originating companies' commercial turbulence**. CNCF also hosts
  OpenGitOps, the vendor-neutral standards effort.
  Sources: [CNCF Flux project page](https://www.cncf.io/projects/flux/);
  [CNCF Argo project page](https://www.cncf.io/projects/argo/);
  [CNCF OpenGitOps](https://www.cncf.io/projects/opengitops/).

---

## "Could not verify" summary

1. **Exact publication date of the original "GitOps - Operations by Pull
   Request" Weaveworks blog post.** The weave.works domain is defunct (redirects
   to a parked/spam page), so the primary article could not be fetched. Sources
   agree on **2017**; a "March 2, 2017" date appears in one secondary blog but
   is unconfirmed by a primary source. Richardson himself says he can't recall
   the exact date.
2. **Flux v0.1.0 release on Jan 27, 2017** — reported by a third-party history
   (Platform9), not confirmed against a primary Weaveworks/GitHub source here.
3. **Alexis Richardson's CNCF TOC chairmanship** — commonly stated elsewhere but
   not confirmed against a primary CNCF source in this research; excluded from
   the factual claims above.
4. **Complete authoritative roster of Flux core maintainers** and exactly which
   employers hired each after the Weaveworks shutdown — only partially sourced
   (ControlPlane employed the core maintainers; specific individual-to-employer
   mappings beyond that not fully verified).
