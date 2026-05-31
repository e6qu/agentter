# Jsonnet, Tanka, and Ksonnet: A Sourced History

A chronological, fully-sourced history of the **Jsonnet** data-templating
language and the **Tanka** Kubernetes configuration tool built on it, with the
cautionary tale of **Ksonnet** along the way.

Every claim below links to a primary or reputable source. Where a detail could
not be confirmed, it is explicitly marked **"Could not verify"**.

---

## Timeline

### 2014 — Jsonnet is born at Google

- **Early 2014:** Jsonnet "began life early 2014 as a 20% project." It was
  created at Google by **Dave Cunningham**.
  - Source: [jsonnet.org — "It began life early 2014 as a 20% project and was launched on Aug 6."](https://jsonnet.org/)
- **The design was influenced by Google's internal configuration languages.**
  The official site states: "The design is influenced by several configuration
  languages internal to Google, and embodies years of experience configuring
  some of the world's most complex IT systems."
  - Source: [jsonnet.org](https://jsonnet.org/)
  - The internal language most often cited as the lineage is **GCL** (Google
    Configuration Language), itself a generalization of **BCL** (Borg
    Configuration Language). This specific lineage is widely discussed by Google
    engineers but is **not named explicitly on jsonnet.org or the Google blog**.
    - Source (community/engineer discussion, not an official Jsonnet doc):
      [Hacker News thread "Finally a public version of GCL/Borgcfg"](https://news.ycombinator.com/item?id=19657866)
    - Source (Brian Grant, Kubernetes/Borg history, on BCL→GCL):
      [threadreaderapp mirror of @bgrant0607 thread](https://threadreaderapp.com/thread/1123620689930358786.html)
  - **Could not verify** from an official Google/Jsonnet source the explicit
    statement "Jsonnet was inspired by GCL." Official wording is only the
    generic "several configuration languages internal to Google." Treat the
    GCL/BCL attribution as well-supported community knowledge rather than an
    official primary-source claim.

- **2014-08-06:** Jsonnet was "launched on Aug 6" (first public release).
  - Source: [jsonnet.org](https://jsonnet.org/)
  - Corroborating: the earliest tagged release on GitHub, `v0.5.0-beta`, is
    dated **2014-08-26**. (The Aug 6 launch predates the earliest surviving
    GitHub release tag.)
    - Source: [github.com/google/jsonnet releases API — v0.5.0-beta, 2014-08-26](https://github.com/google/jsonnet/releases)

- **2014-11-14:** `v0.6.0-beta` released.
  - Source: [github.com/google/jsonnet/releases](https://github.com/google/jsonnet/releases)
- **2014-12-23:** Earliest commit visible on the public master branch is
  authored by **Dave Cunningham**.
  - Source: github.com/google/jsonnet commit history (GitHub API,
    `commits?until=2014-12-31` → `2014-12-23T14:00:49Z — Dave Cunningham`).
  - Note: the public GitHub history starts later than the Aug 6 launch, so this
    is the earliest *visible* commit, not the literal first commit.

### 2015 — Jsonnet introduced to the wider world

- **2015-04-20:** Google publishes the Open Source Blog post **"Jsonnet: a more
  elegant language for composing JSON,"** authored by **Dave Cunningham** of the
  New York Technical Infrastructure team. Key claims:
  - "From day one, Jsonnet was designed as a coherent programming language,
    benefitting from both academic techniques and our experience implementing
    production languages."
  - "Any valid JSON is also a valid Jsonnet program that simply emits that JSON
    unchanged." (i.e., Jsonnet is a superset of JSON.)
  - The name is "a portmanteau combining JSON and 'sonnet.'"
  - Source: [Google Open Source Blog, 2015-04-20](https://opensource.googleblog.com/2015/04/jsonnet-more-elegant-language-for.html)
  - **Note on date:** some secondary sources say "April 2015"; the blog page
    itself is dated **April 20, 2015**.

### 2017 — Ksonnet: Jsonnet meets Kubernetes

- **2017-05-24:** **Ksonnet** is announced as an open-source tool for
  configuring Kubernetes applications, "based on the jsonnet templating
  library," built "in collaboration with our friends from **Box, Microsoft and
  Heptio**." Bitnami's blog also lists "Red Hat, CoreOS, Box and Microsoft"
  among active contributors.
  - Source: [Bitnami Blog, "Introducing ksonnet," 2017-05-24](https://blog.bitnami.com/2017/05/ksonnet-open-source.html)
  - Corroborating coverage: [GeekWire, "Kubernetes backers unveil ksonnet"](https://www.geekwire.com/2017/folks-brought-kubernetes-now-want-make-easier-use/)
  - **Heptio** (the company co-founded by Kubernetes co-creators Joe Beda and
    Craig McLuckie) became the primary steward of ksonnet. Heptio's own intro
    post: [blog.heptio.com — "ksonnet: Simplify working with Kubernetes configurations" by Joe Beda](https://blog.heptio.com/ksonnet-intro-43f6183a97a6)
- **2017-10-16:** The `ksonnet/ksonnet` GitHub repository is created (the
  consolidated CLI/framework repo).
  - Source: github.com/ksonnet/ksonnet repo metadata (GitHub API,
    `created_at: 2017-10-16`).

### 2018 — Heptio acquired by VMware

- **2018-11 / 2018-12:** VMware acquires Heptio; the acquisition **closed on
  December 11, 2018** (referenced by VMware's own ksonnet sunset post).
  - Source: [VMware Tanzu blog, "Welcoming Heptio Open Source Projects to VMware"](https://blogs.vmware.com/tanzu/welcoming-heptio-open-source-projects-to-vmware)
    (references the Dec 11, 2018 acquisition-close post).
  - Background on the deal: [Madrona, "The Difficult Decision For Heptio To Sell to VMware"](https://www.madrona.com/the-difficult-decision-for-heptio-to-sell-to-vmware/)

### 2019 — The cautionary tale: Ksonnet is killed

- **2019-02-05:** VMware (post-Heptio) announces that **ksonnet is being
  discontinued**. Authored by Ross Kukulinski (Product Line Manager) and Tim
  Hinderliter (Senior Engineering Manager):
  - "As a result, work on ksonnet will end and the GitHub repositories will be
    archived."
  - The reasons given: community feedback was that "the purpose of ksonnet was
    meaningful, but the language and concepts could be intimidating for new and
    casual users," and that "ksonnet has not yet resonated with its intended
    audience."
  - The VMware acquisition was cited as the moment to "rethink our investment in
    ksonnet."
  - Source: [VMware Tanzu blog, 2019-02-05](https://blogs.vmware.com/tanzu/welcoming-heptio-open-source-projects-to-vmware)
- **2019-02-21:** Last push to the `ksonnet/ksonnet` repo before archival.
  - Source: github.com/ksonnet/ksonnet repo metadata (GitHub API,
    `pushed_at: 2019-02-21`, `archived: true`).
- The abandonment stranded downstream users — most notably **Kubeflow** and the
  **kube-prometheus / prometheus-operator** ecosystem, which had to migrate off
  ksonnet-lib.
  - Source: [kubeflow/kubeflow issue #2412, "Heptio is discontinuing ksonnet."](https://github.com/kubeflow/kubeflow/issues/2412)
  - Source: [prometheus-operator/kube-prometheus issue #99, "Move away from ksonnet-lib since it is deprecated"](https://github.com/prometheus-operator/kube-prometheus/issues/99)

**The cautionary tale:** Ksonnet pioneered the idea of using Jsonnet for
Kubernetes and attracted multiple corporate backers, but it was killed roughly
two years after launch and ~3 months after the Heptio acquisition closed —
because the acquirer (VMware) chose to redirect resources, and because the
tool's bespoke conceptual model (Components, Prototypes, Parts, Packages,
Parameters) never gained broad traction. Teams who had bet on it had to migrate.
This is the direct backdrop against which Grafana built Tanka.

### 2019 — Grafana Labs builds Tanka

- **2019-07-31:** First tagged Tanka release, **`v0.1.0`**, on GitHub.
  - Source: github.com/grafana/tanka release `v0.1.0` (GitHub API,
    `published_at: 2019-07-31`); [grafana/tanka releases](https://github.com/grafana/tanka/releases)
- Grafana Labs had relied on ksonnet to manage the Jsonnet config underpinning
  their Kubernetes stack; ksonnet's discontinuation prompted them to build Tanka
  as a from-scratch successor. (See the Jan 2020 announcement below for the
  primary statement.)

### 2020 — Tanka announced publicly

- **2020-01-10:** Grafana Labs publishes **"Introducing Tanka, Our Way of
  Deploying to Kubernetes,"** authored by **Tom Braack**:
  - "Tanka is very similar to `ksonnet`; however, it is not a fork, but a
    rewrite from scratch."
  - "The now discontinued [`ksonnet`] project pioneered the idea of using
    Jsonnet for Kubernetes, inspiring us to take this even further."
  - Tanka removes ksonnet's heavy conceptual model: "The conceptual overhead of
    `Components`, `Prototypes`, `Parts`, `Packages`, and `Parameters` are gone in
    favor of plain Jsonnet `import` and deep-merging."
  - Motivation framed against YAML (repetition, boilerplate, static nature) and
    Helm (fragile string templating, weak abstraction).
  - Source: [Grafana Labs blog, "Introducing Tanka," 2020-01-10](https://grafana.com/blog/introducing-tanka-our-way-of-deploying-to-kubernetes/)
  - **Note on date:** secondary sources sometimes say Tanka was "announced to
    the Kubernetes community in January 2020"; the announcement blog post is
    dated **January 10, 2020**.
- **2020-03-11:** Follow-up deep-dive, "How the Jsonnet-based project Tanka
  improves Kubernetes usage."
  - Source: [Grafana Labs blog, 2020-03-11](https://grafana.com/blog/2020/03/11/how-the-jsonnet-based-project-tanka-improves-kubernetes-usage/)

### 2026 — Current status

- **Jsonnet** is actively maintained by Google. The C++ implementation's latest
  release is **v0.22.0 (2026-03-24)**, and a Go implementation (`go-jsonnet`) is
  recommended for many uses.
  - Source: [github.com/google/jsonnet](https://github.com/google/jsonnet)
  - **Maintainer note:** Multiple secondary sources report that after Dave
    Cunningham left Google, day-to-day Jsonnet maintenance passed to others
    inside Google (one source names "Rohit Jangid").
    - **Could not verify** this maintainer-handoff claim against an official
      Google/Jsonnet primary source; it appears only in secondary search
      summaries. Treat as unconfirmed.
- **Tanka** is actively maintained by Grafana Labs. Latest release is
  **v0.37.2 (2026-05-14)**. It remains **pre-1.0** (no stable v1 milestone as of
  this writing).
  - Source: [github.com/grafana/tanka/releases](https://github.com/grafana/tanka/releases)
  - Source: [grafana.com/oss/tanka](https://grafana.com/oss/tanka/)
- **Ksonnet** remains **archived and dead** since February 2019.
  - Source: github.com/ksonnet/ksonnet (`archived: true`).

---

## How Jsonnet/Tanka compare to Helm and Kustomize

This is the conceptual context for why these tools exist; sourced where claims
are non-obvious.

- **Helm** is a package manager for Kubernetes that renders manifests via **Go
  text/template string templating** over YAML, packaged as "charts." Its
  strength is a large ecosystem of shareable charts; its weakness (as argued by
  the Tanka authors) is fragile string-level templating and weak abstraction —
  you template text, not data.
  - Source (Tanka authors' critique of Helm's "string templating fragility,
    limited extensibility, weak abstraction"): [Grafana "Introducing Tanka"](https://grafana.com/blog/introducing-tanka-our-way-of-deploying-to-kubernetes/)
- **Kustomize** takes a template-free, overlay/patch approach: you keep plain
  YAML "bases" and apply declarative "overlays" (strategic-merge / JSON patches)
  per environment. It is built into `kubectl` (`kubectl apply -k`).
  - Source: [kubernetes.io docs — Declarative Management of Kubernetes Objects Using Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/)
- **Jsonnet/Tanka** sit in a third camp: a real **data-templating programming
  language**. Instead of templating strings (Helm) or patching static YAML
  (Kustomize), you compute the config *as data* with functions, variables,
  imports, and deep-merge — then Jsonnet emits the JSON/YAML manifests. Tanka
  adds the Kubernetes-specific workflow (`tk diff`, `tk apply`, environment
  management, a Kubernetes Jsonnet library).
  - Source: [tanka.dev](https://tanka.dev/) and [Grafana "Introducing Tanka"](https://grafana.com/blog/introducing-tanka-our-way-of-deploying-to-kubernetes/)
  - Trade-off (widely observed): Jsonnet/Tanka offer the most power and reuse
    (full language, libraries) but the steepest learning curve — the very
    "intimidating language and concepts" critique that VMware cited when killing
    ksonnet applies, in milder form, to the whole Jsonnet-for-k8s approach.
    - Source for the "intimidating" framing: [VMware Tanzu ksonnet sunset post](https://blogs.vmware.com/tanzu/welcoming-heptio-open-source-projects-to-vmware)

---

## Key people & teams

- **Dave Cunningham** — Creator of Jsonnet at Google (New York Technical
  Infrastructure team). Started it as a 20% project in early 2014; authored the
  2015 Google Open Source Blog announcement. Later left Google.
  - Sources: [Google Open Source Blog, 2015](https://opensource.googleblog.com/2015/04/jsonnet-more-elegant-language-for.html);
    [jsonnet.org](https://jsonnet.org/); github.com/google/jsonnet commit history.
- **Google (New York Technical Infrastructure team)** — Owns and maintains
  Jsonnet. Note: "Jsonnet is not an official Google product ... it is just code
  that happens to be owned by Google."
  - Source: [jsonnet.org](https://jsonnet.org/)
- **Rohit Jangid (Google)** — Reported as a current/subsequent Jsonnet
  maintainer after Cunningham's departure. **Could not verify** against an
  official source; secondary only.
- **Heptio** — Kubernetes services startup (co-founded by **Joe Beda** and
  **Craig McLuckie**, Kubernetes co-creators) that stewarded ksonnet. Acquired
  by VMware (deal closed Dec 11, 2018).
  - Sources: [blog.heptio.com — Joe Beda on ksonnet](https://blog.heptio.com/ksonnet-intro-43f6183a97a6);
    [Madrona on the Heptio→VMware deal](https://www.madrona.com/the-difficult-decision-for-heptio-to-sell-to-vmware/)
- **Bitnami, Box, Microsoft (and Red Hat/CoreOS)** — Collaborators/contributors
  on the original ksonnet project alongside Heptio.
  - Source: [Bitnami Blog, "Introducing ksonnet," 2017](https://blog.bitnami.com/2017/05/ksonnet-open-source.html)
- **Ross Kukulinski & Tim Hinderliter (VMware, ex-Heptio)** — Authors of the
  Feb 2019 ksonnet discontinuation announcement.
  - Source: [VMware Tanzu blog, 2019](https://blogs.vmware.com/tanzu/welcoming-heptio-open-source-projects-to-vmware)
- **Tom Braack (Grafana Labs)** — Author of the Jan 2020 "Introducing Tanka"
  announcement; an early Tanka author/maintainer.
  - Source: [Grafana Labs blog, 2020](https://grafana.com/blog/introducing-tanka-our-way-of-deploying-to-kubernetes/)
- **Grafana Labs** — Creator and maintainer of Tanka; built it as a from-scratch
  successor to ksonnet for their own Kubernetes/Jsonnet stack.
  - Sources: [grafana/tanka](https://github.com/grafana/tanka);
    [grafana.com/oss/tanka](https://grafana.com/oss/tanka/)

---

## Could-not-verify items (summary)

1. **Explicit "Jsonnet inspired by GCL/BCL" from an official source.** Official
   Jsonnet wording is only "several configuration languages internal to Google."
   The GCL/BCL lineage is well-supported by Google engineers in community
   forums but not stated in an official Jsonnet primary source.
2. **Rohit Jangid as current Jsonnet maintainer.** Appears in secondary search
   summaries only; no official Google/Jsonnet page confirmed.
3. **Exact first-commit / literal first release artifacts for the Aug 6, 2014
   launch.** The Aug 6 launch date comes from jsonnet.org; the earliest
   surviving public GitHub release tag is v0.5.0-beta (2014-08-26) and the
   earliest visible commit is 2014-12-23. The pre-Aug-26 history is not visible
   in the public repo.
