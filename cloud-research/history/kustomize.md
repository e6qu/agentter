# Kustomize: A Sourced History

Kustomize is a **template-free** tool for customizing Kubernetes object
configuration. The official Kubernetes blog describes it as providing "a new,
purely declarative approach to configuration customization that adheres to and
leverages the familiar and carefully designed Kubernetes API."
([Kubernetes blog, 2018-05-29](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))

It originated at **Google** as a subproject of the Kubernetes **SIG-CLI**
(the kubectl team), and today lives in
[kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize).

> Note on sourcing: tag dates below were read directly from the GitHub API
> (annotated-tag `tagger.date` on `kubernetes-sigs/kustomize`). Narrative
> claims are cited to the Kubernetes blog, KEPs in `kubernetes/enhancements`,
> GitHub issues/PRs, the public SIG mailing-list / sig-architecture threads,
> and (where noted) reputable secondary press.

---

## Timeline

### 2017–early 2018 — Origins inside kubectl, then a standalone repo
Kustomize began life inside the kubectl codebase before SIG subprojects were
formalized, then moved to its own repository and was "published as an
independent CLI" with later integration into `kubectl apply` via `-k`.
KEP-2377 states: "kustomize was implemented in the kubectl repo before
subprojects became a first class thing," after which it "was moved to its own
repo."
([KEP-2377 README](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cli/2377-Kustomize/README.md))
- *Could not verify:* the precise month/quarter when the first standalone code
  landed in `kubernetes-sigs/kustomize`. The earliest released tag is below.

### 2018-05-21 — First tagged release `v1.0.0`
The annotated tag `v1.0.0` is dated **2018-05-21T21:45:38Z**.
(GitHub API: `git/tags` for `kubernetes-sigs/kustomize`, tag `v1.0.0`,
sha `70b31b8fc08e45a454603c722bc48f7a862e1114`. Browse:
[v1.0.0 tag](https://github.com/kubernetes-sigs/kustomize/tree/v1.0.0))

### 2018-05-29 — Public announcement on the Kubernetes blog
"Introducing kustomize; Template-free Configuration Customization for
Kubernetes," authored by **Jeff Regan (Google)** and **Phil Wittrock
(Google)**, announced kustomize as "a command-line tool" and "a subproject of
SIG-CLI."
([Kubernetes blog, 2018-05-29](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))

The post lays out the **template-free philosophy** and explicitly contrasts it
with templating tools (the implicit foil being Helm-style templates + values
files). It argues that with templating "the templates and value files are not
specifications of Kubernetes API resources. They are, necessarily, a new
thing, a new language, that wraps the Kubernetes API ... the value sets get
large, since all parameters (that don't have trusted defaults) must be
specified for replacement." Kustomize instead reads native, unmodified
Kubernetes YAML plus a `kustomization.yaml` that declares overlays, patches,
and cross-cutting transforms (e.g. `commonLabels`), leaving the original YAML
"untouched and usable as is."
([Kubernetes blog, 2018-05-29](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))

### 2018-10-24 — `v1.0.9`
Annotated tag dated **2018-10-24T21:23:54Z**.
(GitHub API, sha `990585782cbef75dd6730ee309436a912f61ffad`;
[v1.0.9 release](https://github.com/kubernetes-sigs/kustomize/releases/tag/v1.0.9))

### 2018-10-24 — Enhancement issue #633: "integrate Kustomize into kubectl"
Opened by **Liujingfang1** (Jingfang Liu, Google), targeting milestone
**v1.14** as a stable release, responsible SIG **sig-cli**, with reviewers/
approvers **pwittrock** (Phillip Wittrock) and **soltysh** (Maciej Szulik).
([kubernetes/enhancements #633](https://github.com/kubernetes/enhancements/issues/633))

### 2018-12-19 — The `-k` integration PR merges into kubectl
The pull request adding the kustomize build flow to `cli-runtime`/kubectl
(`kubectl apply -k` / `kubectl kustomize`) was merged. Per the
sig-architecture discussion thread, "the PR merged December 19, 2018."
([sig-architecture thread "kustomize in kubectl"](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ);
implementation PR
[kubernetes/kubernetes #74140](https://github.com/kubernetes/kubernetes/pull/74140))
- *Could not verify (cleanly):* the exact PR number/sequence — issue #633
  references related PR `kubernetes/kubernetes #73033`, the search-surfaced
  `-k` flag PR is `#74140`, and Wittrock states the PR "was sent Nov 7"; the
  full chain of PRs was not individually confirmed in this pass.

### 2018-12-31 → 2019-01-07 — The kubectl-integration controversy ("KEP Kerfuffle")
A public dispute followed the merge, carried out largely on the
**kubernetes-sig-architecture** mailing list over the year-end break.
Participants and positions, per that thread:
- **Matt Farina** initiated the objection: the KEP metadata wasn't properly
  updated, graduation criteria were too weak (dogfooding "one or more of our
  own services" was a "low bar"), the process felt opaque ("back room deal"),
  and he asked why kustomize wasn't shipped via kubectl's **plugin** mechanism
  instead of being merged into core.
- **Brendan Burns** (Kubernetes co-founder) echoed the plugin question:
  "Given that kubectl already has a built in plugin system I'm curious why the
  existing plugin mechanism wasn't used."
- **Phillip Wittrock** (SIG-CLI) defended the process, noting the PR "was sent
  Nov 7 and discussed on the PR for over a month before it was merged," cc'd to
  sig-cli, and reviewed at multiple SIG-CLI meetings.
- **Maciej Szulik** and **Gerred Dillon** also participated.

([sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ);
secondary narrative:
[Teleport blog, "The Kubernetes Kustomize KEP Kerfuffle"](https://goteleport.com/blog/kubernetes-kustomize-kep-kerfuffle/);
[Hacker News discussion](https://news.ycombinator.com/item?id=19030607))

On **Brian Grant**: per the threads and the Teleport write-up, Grant is
associated with the broader *declarative application management* design
thinking that motivated kustomize (his design doc was referenced by Wittrock),
**but he was not identified as a direct participant** in this specific
sig-architecture thread.
- *Could not verify:* a specific statement by Brian Grant in the 1.14
  integration KEP/threads. Attribute the controversy to Farina, Burns, and
  Wittrock as above; do not attribute it to Grant without a direct quote.

#### Security concern that surfaced after the merge
The Teleport account states that weeks after the merge a security worry was
raised: kustomize's "program callout and local file access features," now
inside kubectl, could potentially be used to trick users into "silently
sharing their secrets," and the change was reworked.
([Teleport blog](https://goteleport.com/blog/kubernetes-kustomize-kep-kerfuffle/))
- *Could not verify:* the primary issue/CVE link for this specific security
  concern (Teleport is secondary press here). Marked for follow-up.

The episode is credited with prompting Kubernetes SIGs to tighten KEP
graduation/governance processes; the reworked KEP added commitments to
"data-driven usage measurements and surveys."
([Teleport blog](https://goteleport.com/blog/kubernetes-kustomize-kep-kerfuffle/))

### 2019-02-05 — `v2.0.0`
Annotated tag dated **2019-02-05T20:45:15Z**.
(GitHub API, sha `1dc8d37a999578f6feb83962c465f941d639680c`)

### 2019-03-05 — `v2.0.3` (the version that shipped in kubectl)
Annotated tag dated **2019-03-05T20:36:15Z**.
(GitHub API, sha `85945ce5571d3526a9690a22178c918b706342ab`)

### 2019-03-25 — Kubernetes 1.14 ships `kubectl apply -k`
Kubernetes 1.14 was released on **2019-03-25**, making the kustomize build flow
a first-class kubectl feature (`apply -k`, `kubectl kustomize`). The bundled
kustomize was **v2.0.3**.
([Kubernetes Releases](https://kubernetes.io/releases/);
[Kubernetes docs: Declarative Management ... Using Kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/) —
"Since 1.14, kubectl also supports the management of Kubernetes objects using a
kustomization file.")

### 2019-07-03 — `v3.0.0`
Annotated tag dated **2019-07-03T18:20:36Z**.
(GitHub API, sha `87784eee15f3c7305bffbe6c61b4f5f06369c8a3`)

### 2019–2021 — The version-lag complaints
After integration, kubectl's *vendored* kustomize lagged the standalone
releases, producing recurring user confusion and behavioral divergence:
- The embedded build flow remained **frozen at v2.0.3** from kubectl v1.14
  until **kubectl v1.21**, which bumped it to **v4.0.5**. This v2.0.3→v4.0.5
  mapping is widely reported across community/secondary sources surfaced in
  search (e.g. ArgoCD/Flux docs and tutorials).
  - *Could not verify (primary):* I did not locate the authoritative
    kubectl↔kustomize version table on a kubernetes.io / SIG-CLI page in this
    pass; the official docs page only states "Since 1.14." Treat the exact
    "frozen until v1.21 → v4.0.5" figures as **reported but not yet verified
    against a first-party table** — added to follow-ups.
- Behavioral divergence was filed as real bugs, e.g.
  [kubernetes/kubectl #955](https://github.com/kubernetes/kubectl/issues/955)
  (opened 2020-10-14 by `rdxmb`): `kubectl apply -k` rejected a relative
  `../base` path that standalone `kustomize build` accepted (kubectl v1.19.2
  vs kustomize v3.8.5).
- The version reported by `kubectl version` for the embedded kustomize has also
  been flagged as inaccurate:
  [kubernetes/kubectl #1495](https://github.com/kubernetes/kubectl/issues/1495).

### 2024-06-10 — KEP-4706 proposes deprecating/removing kustomize from kubectl
KEP-4706, "Deprecate and remove kustomize from kubectl" (responsible SIG:
sig-cli), proposed decoupling the two projects. Stated motivations:
1. **Version lag** — "current kubernetes release cycle doesn't match that of
   kustomize," risking outdated embedded versions;
2. **Maintenance/dependency burden** — kustomize's deps "have already been
   problematic to the core kubernetes project," and removal would "minimize the
   dependency graph and the size of kubectl binary";
3. **Project independence** — both should "move at separate pace" rather than
   "promoting one tool over the other."
The proposed phasing ran from a v1.31 deprecation warning toward removal around
v1.36.
([KEP-4706 README](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cli/4706-deprecate-and-remove-kustomize/README.md);
[tracking issue #4706](https://github.com/kubernetes/enhancements/issues/4706))

### 2024-10-17 — sig-architecture decides to RETAIN kustomize in kubectl
After discussion at the **sig-architecture meeting on 2024-10-17**, the KEP-4706
README records: "it was decided not to pursue this topic further, and retain
kustomize as part of kubectl," citing widespread community adoption and the
risk to user trust of removing it.
([KEP-4706 README](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cli/4706-deprecate-and-remove-kustomize/README.md))

### Current status (as of 2026-05)
Kustomize remains an active project under
[kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize),
maintained by SIG-CLI, released as both a standalone binary and embedded in
kubectl (`apply -k`). Recent standalone releases are in the `v5.x` line
(e.g. `kustomize/v5.8.1`, dated Feb 9 per the GitHub releases listing).
([Releases](https://github.com/kubernetes-sigs/kustomize/releases))
- *Could not verify:* exact day/year of `kustomize/v5.8.1` from the listing
  excerpt (showed "February 9" without a confirmed year). Minor; flagged.

---

## Philosophy: overlays/patches vs. Helm templating

- **Kustomize (overlays/patches):** operates on *real*, valid Kubernetes
  manifests. A `kustomization.yaml` declaratively layers changes — a `base`
  plus `overlays` that apply strategic-merge/JSON patches and cross-cutting
  transforms (labels, name prefixes, image tags). No new templating language;
  the inputs are themselves deployable Kubernetes API objects.
  ([Kubernetes blog, 2018-05-29](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))
- **Helm (templating):** parameterizes manifests with a templating language
  (Go templates) plus `values.yaml`, so chart source is *not* itself a valid
  Kubernetes resource until rendered. The kustomize announcement's critique of
  templating — "a new language, that wraps the Kubernetes API" with large value
  sets — is precisely the contrast with this model.
  ([Kubernetes blog, 2018-05-29](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))
  - *Note:* The blog does not name Helm explicitly in the quoted passages;
    "templating tool" is the foil. The Helm contrast is the widely understood
    reading but is partly editorial synthesis here.

---

## Key people & teams

- **SIG-CLI (Kubernetes Special Interest Group – CLI / the kubectl team):**
  owns kustomize as a subproject; responsible SIG on the integration and
  deprecation KEPs.
  ([Kubernetes blog](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/),
  [KEP-2377](https://github.com/kubernetes/enhancements/blob/master/keps/sig-cli/2377-Kustomize/README.md))
- **Jeff Regan (Google)** — co-author of the 2018 announcement blog.
  ([blog](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/))
- **Phil / Phillip Wittrock (Google, SIG-CLI; `pwittrock`)** — co-author of the
  announcement; reviewer/approver on the kubectl-integration enhancement;
  defended the integration in the sig-architecture thread.
  ([blog](https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/),
  [#633](https://github.com/kubernetes/enhancements/issues/633),
  [sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ))
- **Jingfang Liu (Google; `Liujingfang1`)** — opened enhancement #633 to
  integrate kustomize into kubectl; assignee/author of integration PR(s).
  ([#633](https://github.com/kubernetes/enhancements/issues/633))
- **Maciej Szulik (`soltysh`)** — reviewer/approver on the integration; SIG-CLI;
  participated in the sig-architecture thread.
  ([#633](https://github.com/kubernetes/enhancements/issues/633),
  [sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ))
- **Matt Farina** — lead critic in the integration controversy (process,
  graduation criteria, plugin-vs-core).
  ([sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ),
  [Teleport blog](https://goteleport.com/blog/kubernetes-kustomize-kep-kerfuffle/))
- **Brendan Burns** (Kubernetes co-founder) — questioned why the kubectl plugin
  mechanism wasn't used instead of merging into core.
  ([sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ))
- **Gerred Dillon** — participant in the sig-architecture thread.
  ([sig-architecture thread](https://groups.google.com/g/kubernetes-sig-architecture/c/lw8AJXGrEW8/m/Y3BiTYMFFQAJ))
- **Brian Grant** — associated with the broader declarative-application-
  management design philosophy behind kustomize; **not verified** as a direct
  participant in the 1.14 integration thread (see Could-not-verify list).
  ([Teleport blog](https://goteleport.com/blog/kubernetes-kustomize-kep-kerfuffle/))

---

## Could not verify (open items)

1. **Brian Grant's direct role in the integration KEP/decision.** Sources tie
   him to the overarching declarative-config design vision, not to a specific
   quote/vote in the 1.14 integration thread. Need a primary source (KEP review
   comment, sig-cli/sig-architecture post) to attribute anything to him.
2. **Authoritative kubectl↔kustomize version table.** The "embedded kustomize
   frozen at v2.0.3 until kubectl v1.21 → v4.0.5" figures are consistent across
   secondary sources but were not confirmed against a first-party kubernetes.io
   / SIG-CLI table in this pass.
3. **Primary link for the post-merge security concern** (program-callout / local
   file access → secret exfiltration). Currently sourced only to Teleport's
   secondary account; need the original issue/thread/CVE.
4. **Exact early-history dates** for kustomize's first standalone code landing
   before v1.0.0 (the in-kubectl → standalone repo move). Earliest *released*
   tag verified is v1.0.0 (2018-05-21).
5. **Full PR chain for integration** (#73033 vs #74140 vs the "sent Nov 7" PR);
   the merge date (2018-12-19) is sourced from the sig-architecture thread, but
   the individual PRs were not each confirmed.
6. **Authorship of KEP-4706.** Listed under SIG-CLI; an individual author name
   was not confirmed.
7. **Year of `kustomize/v5.8.1`** from the releases listing excerpt ("February
   9", year not shown).
