# Google Cloud Deployment Manager, Config Connector (KCC) & Infrastructure Manager — A Sourced History

A chronological, fully-sourced history of Google's *native* infrastructure-as-code
(IaC) story: from Deployment Manager (Google's CloudFormation analogue) through
its deprecation, and Google's pragmatic pivot to Terraform-based tooling
(Config Connector / KCC and Infrastructure Manager).

> Scope note: this doc focuses on Google's *first-party* IaC services and their
> relationship to Terraform. Every dated claim links to a primary or reputable
> secondary source. Claims that could not be pinned down are flagged inline as
> **Could not verify**.

---

## Timeline

### 2014 — Deployment Manager beta

- **December 2014** — Google released a **beta** of Cloud Deployment Manager, a
  declarative configuration tool for creating, testing, and staging cloud
  environments. Chris Crall (technical program manager, Google cloud platform
  group) described it as letting developers "deploy the environment of their
  choice simply by describing it," using **declarative** syntax ("you declare
  the desired outcome of your deployment, rather than the steps the system needs
  to take").
  - Source: eWeek, "Google Releases Beta Version of Cloud Deployment Manager"
    — https://www.eweek.com/cloud/google-releases-beta-version-of-cloud-deployment-manager/
  - **Could not verify the exact day in December 2014**: the eWeek article
    confirms the beta and the Crall quote, but WebFetch on that URL returned
    HTTP 403, so the precise publication date was read only from search-result
    snippets. The Deployment Manager release notes list an entry dated
    **January 21, 2015** as their earliest item (Container Engine cluster
    support), consistent with a late-2014 / very-early-2015 beta window.
    Release notes: https://docs.cloud.google.com/deployment-manager/docs/release-notes

### 2015 — Deployment Manager GA

- **July 22, 2015** — Cloud Deployment Manager reached **General Availability**,
  shipping with the v2 API. This is recorded both in Google's official release
  notes and announced on the Google Cloud Platform blog.
  - Release notes (GA + v2 API entry, July 22, 2015):
    https://docs.cloud.google.com/deployment-manager/docs/release-notes
  - GCP Blog, "Deployment Manager is Generally Available - Deployments Made
    Easy" (post dated **August 6, 2015**):
    https://cloudplatform.googleblog.com/2015/08/Deployment-Manager-is-Generally-Available-Deployments-Made-Easy.html
  - **Note on the two dates**: the *release notes* mark GA on July 22, 2015;
    the *blog announcement* is dated August 6, 2015. Both are cited above so the
    discrepancy is visible. **Could not verify** the full body text of the blog
    post — WebFetch returned only the page's header/nav, so the publication date
    (Aug 6, 2015) is confirmed but the article body (feature details, quotes)
    was not retrievable.

- **Model**: Deployment Manager configurations are **YAML** files describing the
  desired resources, optionally parameterized with **Jinja2** or **Python**
  templates. This is Google's structural analogue to AWS CloudFormation
  (declarative templates managed as a first-party service). It was always
  GCP-only and, in practice, never achieved the popularity Terraform did on GCP
  (see the Terraform/Magic Modules thread below).
  - DM Convert docs describe the inputs it converts: "Deployment Manager
    configuration YAML files and Jinja or Python template files":
    https://docs.cloud.google.com/deployment-manager/docs/dm-convert

### 2014–2018 — Google's parallel embrace of Terraform (context for the later pivot)

Even while Deployment Manager existed as Google's "official" IaC, Google leaned
increasingly on **HashiCorp Terraform** as the de-facto IaC tool on GCP, and
invested heavily in the Terraform Google provider rather than in Deployment
Manager. Key milestones (from HashiCorp's retrospective):

- **August 2014** — The Google provider was created as the seventh Terraform
  provider.
- **January 2015** — First Google-employee commit to the provider.
- **June 2017** — Provider split out of the main Terraform repo for independent
  releases.
- **October 2017** — Terraform Google provider v1.0.
- **February 2018** — **Magic Modules** resources first shipped (provider
  v1.6.0). Magic Modules is Google's internal code generator that produces the
  `google` and `google-beta` Terraform providers from a single source of truth,
  generating roughly ~90% of provider resource implementations (CRUD, schema,
  tests, docs).
  - HashiCorp, "The Magic of Friendship: The Google Provider's New Approach to
    Terraform": https://www.hashicorp.com/en/resources/google-provider-new-terraform
  - Magic Modules repo (GoogleCloudPlatform/magic-modules):
    https://github.com/GoogleCloudPlatform/magic-modules
  - Magic Modules docs (generator + CI for TPG/TPGB):
    https://googlecloudplatform.github.io/magic-modules/
  - **Cross-reference**: this is the same Magic Modules / `terraform-provider-google`
    machinery documented in this project's broader codegen research. Google
    maintaining a generated Terraform provider — rather than doubling down on
    Deployment Manager — is the structural reason Deployment Manager was
    eventually deprecated in favor of Terraform-based services.

### 2019 — Config Connector (KCC) emerges

- **2019** — Config Connector (KCC) — a **Kubernetes add-on / operator** that
  manages Google Cloud resources as Kubernetes objects (via CRDs) — was
  introduced. The open-source repo `GoogleCloudPlatform/k8s-config-connector`
  describes it as "a Kubernetes add-on that allows customers to manage GCP
  resources, such as Cloud Spanner or Cloud Storage, through your cluster's
  API," following "the same resource model as the basis of Istio, Knative,
  Kubernetes."
  - Repo: https://github.com/GoogleCloudPlatform/k8s-config-connector
  - **Could not verify** an exact 2019 launch/announcement *date* or a 2019
    Google blog post. The public GA announcement is dated January 29, 2020 (next
    entry). Secondary sources state KCC "was launched in 2019," and the GA post
    in Jan 2020 implies a prior beta/launch in 2019, but a primary-source 2019
    announcement with a specific date was not located. **Flagged for follow-up.**

### 2020 — Config Connector GA

- **January 29, 2020** — Google announced the **General Availability** of Config
  Connector. At GA it could manage **60+ GCP services** (Bigtable, BigQuery, IAM
  policies, service accounts, Pub/Sub, Redis, Spanner, Cloud SQL, Cloud Storage,
  Compute Engine, networking, Cloud Load Balancer, etc.). It can be installed
  standalone on any Kubernetes cluster and is also integrated into Anthos Config
  Management for hybrid/multi-cloud.
  - Google Cloud Blog, "Config Connector bridges Kubernetes, GCP resources"
    (Jan 29, 2020):
    https://cloud.google.com/blog/products/containers-kubernetes/config-connector-bridges-kubernetes-gcp-resources
  - Customer quote in that post: Gregg Donovan, Senior Staff Software Engineer
    at Etsy, on collapsing two CI/CD pipelines (app code + infra) into one.

- **Relationship to Crossplane's approach**: Config Connector and Crossplane
  occupy the same conceptual space — both expose cloud control-plane APIs as
  Kubernetes Custom Resources and use a reconciliation loop to drive real
  infrastructure toward declared state. The key contrast:
  - Cloud-provider add-ons (Config Connector, plus Azure Service Operator and
    AWS Controllers for Kubernetes) expose **low-level provider APIs more or less
    1:1** as custom resources.
  - **Crossplane** adds a **Composition** layer so platform teams can build
    higher-level, opinionated abstractions on top of the low-level managed
    resources, and is explicitly **multi-cloud** (Config Connector is GCP-only).
  - Crossplane blog, "Crossplane vs Cloud Provider Infrastructure Addons"
    (Feb 2, 2021):
    https://blog.crossplane.io/crossplane-vs-cloud-infrastructure-addons/
  - Crossplane's note that it supports multi-cloud and surfaces most
    Terraform-provider resources is corroborated in third-party comparisons,
    e.g. https://northflank.com/blog/crossplane-alternatives

### 2023 — Infrastructure Manager (managed Terraform) and KCC positioning

- **June 1, 2023** — Google published "How Config Connector compares for
  infrastructure management," framing Config Connector as **"Configuration as
  Data"** (Kubernetes Resource Model) versus Terraform's **Infrastructure as
  Code** (HCL), and emphasizing KCC's continuous **reconciliation** to keep
  infra "as close to the declared configuration as possible in real time."
  - https://cloud.google.com/blog/products/devops-sre/how-config-connector-compares-for-infrastructure-management/

- **September 13, 2023** — Google announced **Infrastructure Manager**
  ("Infra Manager") as **Generally Available** — a Google-managed service that
  runs **HashiCorp Terraform** as the IaC engine. It applies Terraform
  configurations ("blueprints") from Cloud Storage, Git, or local dirs, with
  managed state, deployments/revisions, and preview deployments — i.e. Google's
  own managed-Terraform offering rather than a homegrown IaC engine. Authored by
  Danny Hammo (Product Manager) and Vlad Ouzienko (Engineering Manager).
  - Google Cloud Blog, "Infrastructure Manager: Provision Cloud with HashiCorp
    Terraform" (Sept 13, 2023):
    https://cloud.google.com/blog/products/management-tools/introducing-infrastructure-manager-powered-by-terraform
  - Overview docs: https://docs.cloud.google.com/infrastructure-manager/docs/overview
  - "Infra Manager leverages Terraform to create infrastructure deployments
    using infrastructure as code (IaC)":
    https://docs.cloud.google.com/deployment-manager/docs/deprecations

### 2024–2025 — Deployment Manager deprecation and end of support

- Google has **deprecated Cloud Deployment Manager** and steers users to
  **Infrastructure Manager** (managed Terraform), with **Terraform** and
  **Config Connector / KRM** as the broader alternatives. The official
  deprecation page states: "Over the past years, we've focused our efforts on
  modernizing the Google Cloud deployment experience through Infrastructure
  Manager," and directs users to "migrate to Infra Manager or an alternative
  deployment technology."
  - Deprecation page: https://docs.cloud.google.com/deployment-manager/docs/deprecations
    (canonical `cloud.google.com/deployment-manager/docs/deprecations` 301-redirects here)

- **End-of-support date — note the shift:**
  - **Originally December 31, 2025.** Third-party deprecation trackers that
    captured the earlier wording still show this date:
    - hackingnote "GCP - Deprecations": "December 31, 2025: Cloud Deployment
      Manager will reach end of support." — https://www.hackingnote.com/en/gcp/deprecations/
  - **Now March 31, 2026** on Google's current official page: "Cloud Deployment
    Manager will reach end of support on March 31, 2026... migrate to
    Infrastructure Manager or an alternative deployment technology by March 31,
    2026."
    - https://docs.cloud.google.com/deployment-manager/docs/deprecations
    - InvGate ITDB also reflects the March 31, 2026 date:
      https://invgate.com/itdb/deployment-manager
  - **Interpretation**: the end-of-support deadline appears to have been
    **extended from Dec 31, 2025 to March 31, 2026.** The user's prompt cited
    "~Dec 31 2025," which matches the *original* announced date now superseded
    by the official March 31, 2026 date.
  - **Could not verify** the exact *announcement date* of the deprecation
    (i.e., the day Google first declared Deployment Manager deprecated). The
    Deployment Manager release-notes content reachable via WebFetch only goes
    through April 2020 (the mirror appears stale), and neither the deprecation
    page nor InvGate states an announcement date. **Flagged for follow-up.**

- **Migration tooling — DM Convert**: Google ships **DM Convert** to convert
  Deployment Manager YAML + Jinja/Python templates into **Terraform** or
  **Kubernetes Resource Model (KRM)** config. Caveat documented by Google: some
  Deployment Manager concepts are not supported by Terraform and cannot be
  exported.
  - https://docs.cloud.google.com/deployment-manager/docs/dm-convert
  - Convert walkthrough: https://docs.cloud.google.com/deployment-manager/docs/dm-convert/convert

### 2026 — Current state

- **Deployment Manager**: deprecated; **end of support March 31, 2026** (per
  official docs as of this writing). Recommended exits: Infrastructure Manager,
  Terraform, or Config Connector/KRM (via DM Convert).
  - https://docs.cloud.google.com/deployment-manager/docs/deprecations
- **Config Connector (KCC)**: actively developed and released. The OSS repo
  shows 216 releases, with v1.151.0 dated **May 18, 2026** observed on the repo
  at fetch time.
  - https://github.com/GoogleCloudPlatform/k8s-config-connector
  - Releases: https://github.com/GoogleCloudPlatform/k8s-config-connector/releases
  - **Could not verify** the v1.151.0 / May 18, 2026 detail beyond the GitHub
    landing-page summary returned by WebFetch (the releases page itself was not
    separately fetched and parsed). Treat the exact latest version as
    approximate.
- **Infrastructure Manager**: GA, Google's managed-Terraform service, positioned
  as the primary successor to Deployment Manager.
  - https://docs.cloud.google.com/infrastructure-manager/docs/overview

---

## The throughline: Google chose Terraform over its own IaC

The defining theme of this history is Google's **pragmatic embrace of Terraform
over Deployment Manager**:

- Deployment Manager (GA 2015) was Google's homegrown, GCP-only declarative IaC
  (YAML + Jinja2/Python), structurally analogous to AWS CloudFormation, but it
  never matched Terraform's adoption on GCP.
- In parallel, Google poured engineering into the **Terraform Google provider**
  via **Magic Modules** (code-generating ~90% of `google`/`google-beta`), making
  Terraform the de-facto IaC tool on GCP. (Same generator stack tracked in this
  project's broader codegen research — see Magic Modules / `terraform-provider-google`.)
- Google's *newer* first-party services then doubled down on Terraform rather
  than reviving Deployment Manager: **Infrastructure Manager** (2023) is literally
  managed Terraform, and **Config Connector** offers a Kubernetes-native
  ("Configuration as Data") alternative whose closest external analogue is
  **Crossplane**.
- Deployment Manager's deprecation (end of support **March 31, 2026**, extended
  from an originally announced **Dec 31, 2025**) closes the loop: Google formally
  retired its CloudFormation-analogue in favor of Terraform-based tooling.

---

## Key people & teams

- **Chris Crall** — Technical Program Manager, Google cloud platform group;
  public face of the 2014 Deployment Manager beta.
  - https://www.eweek.com/cloud/google-releases-beta-version-of-cloud-deployment-manager/
- **Gregg Donovan** — Senior Staff Software Engineer, Etsy; customer quoted in
  Google's Config Connector GA announcement (Jan 2020).
  - https://cloud.google.com/blog/products/containers-kubernetes/config-connector-bridges-kubernetes-gcp-resources
- **Danny Hammo** (Product Manager) and **Vlad Ouzienko** (Engineering Manager)
  — authors of Google's Infrastructure Manager GA announcement (Sept 2023).
  - https://cloud.google.com/blog/products/management-tools/introducing-infrastructure-manager-powered-by-terraform
- **Dana Hoffman** (Google, Cloud Graph Team) and **Paddy Carver** (HashiCorp,
  ecosystem team) — named as primary maintainers of the Terraform Google
  provider in HashiCorp's retrospective on the Google/HashiCorp collaboration.
  - https://www.hashicorp.com/en/resources/google-provider-new-terraform
- **Config Connector / KCC engineering team** — `GoogleCloudPlatform/k8s-config-connector`
  (no specific individuals identified from primary sources during this pass).
  - https://github.com/GoogleCloudPlatform/k8s-config-connector
  - **Could not verify** specific team leads/eng managers for Deployment Manager
    or Config Connector by name from primary sources.

---

## Could-not-verify list (for DO_NEXT follow-up)

1. **Exact day of the Deployment Manager beta announcement (Dec 2014).** eWeek
   confirms the beta + Crall quote, but the article URL returned HTTP 403 to
   WebFetch; only search snippets were available. Earliest release-notes entry is
   Jan 21, 2015.
2. **Body text of the Aug 6, 2015 GA blog post.** Date confirmed; article body
   (feature details/quotes) not retrievable via WebFetch (page returned
   header/nav only).
3. **GA-vs-blog date mismatch for GA**: release notes say July 22, 2015; blog is
   dated Aug 6, 2015. Both cited; not reconciled to a single canonical date.
4. **Config Connector's exact 2019 launch/announcement date.** No primary 2019
   Google blog post with a specific date located; only the Jan 29, 2020 GA post
   plus secondary "launched in 2019" claims.
5. **Exact announcement date of Deployment Manager's deprecation.** The
   deprecation page and trackers give the end-of-support date but not when the
   deprecation was first announced. The reachable release-notes mirror stops at
   April 2020 (stale).
6. **End-of-support date change Dec 31, 2025 → March 31, 2026.** Strongly implied
   by the conflict between hackingnote (Dec 31, 2025) and the official page +
   InvGate (March 31, 2026), but the *date of the extension* / a Google changelog
   entry documenting it was not found.
7. **Current latest KCC release (v1.151.0, May 18, 2026).** Read only from the
   GitHub repo landing-page summary; not independently confirmed via the releases
   page.
8. **Named individuals/teams** for Deployment Manager and Config Connector
   engineering leadership beyond those listed above.
