# Gerrit Code Review — A Sourced History

A chronological, fully-cited history of **Gerrit Code Review**, the Git-based
code-review system created at Google to support Android (AOSP) development, and
its lineage back through Rietveld and Mondrian.

Every claim below is attributed to a working source URL. Where a commonly
repeated claim could not be confirmed against a primary or reputable source, it
is explicitly flagged with **Could not verify**.

---

## Timeline

### Internal precursor — Mondrian (pre-2008)

- Google developed an internal, proprietary code-review tool called
  **Mondrian**, used to "facilitate peer-review of changes prior to submission
  to the central code repository." Mondrian was tied to Perforce (Google's main
  commercial SCM at the time) and to proprietary Google infrastructure (e.g.
  Bigtable), which prevented it from being open-sourced directly.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html);
  [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).
- Mondrian is associated with Guido van Rossum (creator of Python), who worked
  on it at Google and later gave a public talk about the code-review process it
  embodied.
  Source: [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).

### May 8, 2008 — Rietveld released by Guido van Rossum

- Guido van Rossum, then on the Google App Engine team, released **Rietveld**, a
  web-based collaborative code-review tool, described as "a code review tool for
  use with Subversion, inspired by Mondrian and (soon to be) released as open
  source." It was built with **Python/Django** and ran on **Google App Engine**.
  Source: [Guido van Rossum releases Mondrian-clone: Rietveld — Google Developers Blog (May 8, 2008)](https://developers.googleblog.com/guido-van-rossum-releases-mondrian-clone-rietveld/).
- Some Rietveld code was directly derived from Mondrian, but most was new; it
  targeted **Subversion** instead of Perforce.
  Source: [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).
- **Name origin (Rietveld):** van Rossum named the tool after **Gerrit
  Rietveld**, the Dutch architect — "one of my favorite Dutch architects and the
  designer of the Zig-Zag chair."
  Source: [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).
- Rietveld is licensed under the Apache License v2.
  Source: [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).

### 2008 — Gerrit begins as a fork of Rietveld for Android

- **Shawn Pearce** joined Google in 2008 and was tasked with adapting a
  code-review tool for the **Android Open Source Project (AOSP)**, which used
  **Git** rather than Subversion/Perforce.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html)
  (states Gerrit "was originally built to service AOSP");
  [Gerrit: Google-style code review meets git — LWN.net (Oct 30, 2009)](https://lwn.net/Articles/359489/)
  ("Shawn Pearce, who previously reimplemented git in Java as JGit, and is now at
  Google, took on the project").
- Gerrit **started as a simple set of patches to Rietveld**, then became a fork:
  "Gerrit Code Review started as a simple set of patches to Rietveld, and was
  originally built to service AOSP. This quickly turned into a fork as Rietveld
  was a technology demo of the AppEngine platform, and access control features
  would complicate the Rietveld code base."
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).
- This first incarnation ("Gerrit 1") was **Python on Google App Engine**,
  inherited from Rietveld.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).

> **Name origin (Gerrit):** The official history states "Gerrit calls back to the
> original namesake of Rietveld, Gerrit Rietveld, a Dutch architect." In other
> words, Gerrit is named after the same Dutch architect that Rietveld was named
> after.
> Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).
>
> **Could not verify:** the popular claim that "Gerrit" is an *anagram or
> wordplay on "Git."* No primary or reputable source confirms this; the
> documented explanation is the Gerrit Rietveld namesake. Treat the anagram
> story as folklore unless a primary source surfaces.

### ~2009 — Gerrit 2.x: complete rewrite in Java

- Gerrit was rewritten as **Gerrit 2.x**: "a complete rewrite of the Gerrit fork,
  changing the implementation from Python on Google App Engine, to Java on a J2EE
  servlet container and a SQL database."
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).
- The Java rewrite is consistent with the October 30, 2009 LWN write-up, which
  describes Pearce taking on the project and notes that, because Android apps are
  written in Java, "writing the new tool in that language should make it more
  accessible." The same article describes the mature change-based workflow
  (Change-Id git hook, `git push` to the Gerrit server, web dashboard review).
  Source: [Gerrit: Google-style code review meets git — LWN.net (Oct 30, 2009)](https://lwn.net/Articles/359489/).

> **Note on "created in 2008 / first released 2009":** Secondary sources (e.g.
> Wikipedia and aggregators) commonly state Gerrit was "developed by Shawn Pearce
> in 2008" and "first publicly released in 2009." The 2008 start and the 2009
> Java-rewrite era are both supported by the official history (fork timing) and
> the Oct 2009 LWN article. An exact "first public release" calendar date for
> Gerrit was **not** pinned to a single primary source here.
> **Could not verify:** a precise first-release date for Gerrit (day/month).

### Underlying technology — JGit

- Gerrit is built on **JGit**, a pure-Java reimplementation of Git. JGit was
  **started by Shawn Pearce in 2006** (initially on repo.or.cz), originally to
  bring Git support to the Eclipse IDE (EGit).
  Source: [Eclipse JGit project page — projects.eclipse.org](https://projects.eclipse.org/projects/technology.jgit);
  [JGit (eclipse-jgit/jgit) — GitHub](https://github.com/eclipse-jgit/jgit);
  [Shawn Pearce — Software Freedom Conservancy blog](https://sfconservancy.org/blog/2018/jan/30/shawn-pearce/)
  (Pearce "wrote JGit, a from-scratch Java re-implementation of Git").
- **Robin Rosenberg** was a major JGit contributor alongside Pearce.
  Source: [Eclipse JGit project page — projects.eclipse.org](https://projects.eclipse.org/projects/technology.jgit).
  **Could not verify (precise framing):** whether Rosenberg should be credited as
  a formal *co-creator* vs. a leading early contributor — sources confirm heavy
  involvement but do not uniformly use the word "co-creator."

### The Gerrit review model (vs. GitHub pull requests)

Gerrit implements a **commit-centric, change/patchset-based** review workflow
that differs from GitHub's branch/PR model:

- **Change-Id footer.** Each commit carries a `Change-Id` trailer (added by a
  git commit-msg hook). Gerrit uses it to decide whether a pushed commit creates
  a new change or a new **patch set** of an existing change; amending/rebasing
  preserves the Change-Id, so the revised commit becomes a new patch set.
  Source: [Gerrit Code Review — Uploading Changes](https://gerrit-review.googlesource.com/Documentation/user-upload.html);
  [Basic Gerrit Walkthrough — For GitHub Users](https://gerrit-review.googlesource.com/Documentation/intro-gerrit-walkthrough-github.html).
- **Push to `refs/for/<branch>`.** Instead of opening a PR in a web UI, you run
  e.g. `git push origin HEAD:refs/for/master`. The `refs/for/` prefix maps the
  Gerrit "push for review" concept onto the git protocol; Gerrit creates changes
  under the `refs/changes/` namespace.
  Source: [Basic Gerrit Walkthrough — For GitHub Users](https://gerrit-review.googlesource.com/Documentation/intro-gerrit-walkthrough-github.html).
- **+2/−2 voting and gated submit.** A change typically requires a **+2** on the
  Code-Review label to be submitted (merged). −1 ≈ "request changes," 0 ≈
  comments only, +1 ≈ "looks good"; **−2 is a veto** that blocks submission and
  cannot be overruled by other reviewers.
  Source: [Basic Gerrit Walkthrough — For GitHub Users](https://gerrit-review.googlesource.com/Documentation/intro-gerrit-walkthrough-github.html).
- **Commit-centric contrast with GitHub:** every commit on a pushed branch
  becomes one change/review in Gerrit, whereas GitHub typically reviews an entire
  pull request (which may contain many commits) as a unit.
  Source: [Basic Gerrit Walkthrough — For GitHub Users](https://gerrit-review.googlesource.com/Documentation/intro-gerrit-walkthrough-github.html).

### 2013 — Gitiles

- **Gitiles**, a simple browser for Git repositories built on JGit (no write
  access, minimal JS), is associated with Shawn Pearce and the Gerrit ecosystem;
  it is hosted alongside Gerrit at gerrit.googlesource.com and mirrored on GitHub.
  Source: [gitiles — Git at Google (gerrit.googlesource.com/gitiles)](https://gerrit.googlesource.com/gitiles/);
  [google/gitiles — GitHub](https://github.com/google/gitiles).
  **Could not verify:** the exact 2013 creation year and sole authorship by
  Pearce from a primary source; the year "2013" appears in secondary write-ups
  but was not confirmed against a commit/primary record here.

### Adopters (Git-based projects using Gerrit)

Gerrit is used by many large open-source projects, including:

- **Android / AOSP** — Gerrit's original target.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html);
  [Shawn Pearce — Software Freedom Conservancy](https://sfconservancy.org/blog/2018/jan/30/shawn-pearce/)
  (Gerrit "is used for all Android development").
- **Chromium** — at `chromium-review.googlesource.com`; all CLs must be reviewed
  on Gerrit (LGTM / Code-Review +1, OWNERS approval).
  Source: [Chromium Review — chromium-review.googlesource.com](https://chromium-review.googlesource.com/);
  [Chromium Docs — Code Reviews](https://chromium.googlesource.com/chromium/src/+/lkgr/docs/code_reviews.md).
- **The Go programming language** — at `go-review.googlesource.com`; each CL needs
  at least one Code-Review +2 from an approver, and authors cannot approve their
  own CLs.
  Source: [Contribution Guide — go.dev/doc/contribute](https://go.dev/doc/contribute);
  [Gerrit — go-review.googlesource.com](https://go-review.googlesource.com/).
- **OpenStack** — Gerrit-based contribution workflow.
  Source: [Gerrit Workflow — OpenStack wiki](https://wiki.openstack.org/wiki/Gerrit_Workflow);
  [Using Gerrit — OpenStack contributor guide](https://docs.openstack.org/contributors/code-and-documentation/using-gerrit.html).
- **LibreOffice** — at `gerrit.libreoffice.org`; the GitHub mirror explicitly
  directs contributors to Gerrit instead of pull requests.
  Source: [Gerrit — gerrit.libreoffice.org](https://gerrit.libreoffice.org/);
  [LibreOffice/core — GitHub](https://github.com/LibreOffice/core).
- **Eclipse and Qt** — listed among Gerrit adopters.
  Source: [Gerrit (software) — Wikipedia](https://en.wikipedia.org/wiki/Gerrit_(software));
  [Gerrit Installations in the Wild — gerrit.googlesource.com](https://gerrit.googlesource.com/homepage/+/md-pages/docs/ShowCases.md).

### January 29, 2018 — Shawn Pearce dies

- Shawn O. Pearce, founder of the Gerrit project and author of JGit, **died on
  January 29, 2018**, after a lung-cancer diagnosis.
  Source: [The Git community mourns Shawn Pearce — LWN.net (Jan 29, 2018 posting)](https://lwn.net/Articles/745802/)
  (the death was announced to the git mailing list that day);
  [Remembering Shawn Pearce — Software Freedom Conservancy (posted Jan 30, 2018)](https://sfconservancy.org/blog/2018/jan/30/shawn-pearce/).
  **Note:** Sources consistently report the announcement/passing around Jan
  29–30, 2018. The Conservancy memorial is dated Jan 30, 2018; the git-list
  announcement is dated Jan 29, 2018. The exact calendar date of death is given
  by multiple secondary sources as January 28, 2018 in some places — **Could not
  verify** a single authoritative day-of-death; the announcement was Jan 29,
  2018.

### 2018+ — Gerrit 3.x: NoteDb and Polymer UI

- **Gerrit 3.x** introduced **NoteDb**, eliminating the relational ReviewDb and
  storing all change/account/group/project metadata **in Git itself**, and moved
  the web UI away from GWT toward **Polymer**.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html);
  [Gerrit Code Review — NoteDb Backend](https://gerrit-review.googlesource.com/Documentation/note-db.html).
- NoteDb is the only supported database format in Gerrit 3.0+; the migration
  tooling lived in Gerrit 2.16, so 2.x→3.x upgrades route through 2.16.
  Source: [Gerrit Code Review — NoteDb Backend](https://gerrit-review.googlesource.com/Documentation/note-db.html).

### Current status (as of 2025–2026)

- The Gerrit Code Review open-source project remains actively developed, hosted
  canonically at `gerrit.googlesource.com` and mirrored at
  [GerritCodeReview/gerrit on GitHub](https://github.com/GerritCodeReview/gerrit).
- Recent release plans published on the project news page:
  - **Gerrit 3.13** — release plan published **Sep 17, 2025**.
  - **Gerrit 3.14** — release plan published **Jan 26, 2026**.
  - The releases page lists **3.15 (in development)** as the current development
    line.
  Source: [News — gerritcodereview.com/news.html](https://www.gerritcodereview.com/news.html);
  [Releases — gerritcodereview.com/releases-readme.html](https://www.gerritcodereview.com/releases-readme.html).
  **Could not verify (here):** exact release dates for 3.10/3.11/3.12 from a
  primary source — secondary reporting cited 3.10 (May 2024) and 3.11 (Nov 2024),
  but these were not confirmed against the official per-release notes in this
  research pass.

---

## Key people & teams

- **Shawn O. Pearce** — creator/founder of **Gerrit Code Review**; author of
  **JGit**; major Git-ecosystem figure. He joined the Git project in **2006** and
  was the **third most prolific contributor to Git by commit count (1200+
  patches)**. Credited with the **Git-over-HTTP (smart HTTP) protocol**,
  **fast-import**, the concept of **reflogs**, and **git-gui** (the first
  graphical Git client). He organized the first **GitTogether (2008)**, helped
  bring Git into Google Summer of Code, and served on Git's leadership committee
  after Git joined the Software Freedom Conservancy (2010). He worked at Google.
  He died on/around **January 29, 2018**.
  Source: [Remembering Shawn Pearce — Software Freedom Conservancy](https://sfconservancy.org/blog/2018/jan/30/shawn-pearce/);
  [The Git community mourns Shawn Pearce — LWN.net](https://lwn.net/Articles/745802/).
  - **Could not verify:** Pearce's specific authorship of Git **pack-protocol /
    bitmap index** work from a primary source in this pass. He is widely credited
    with deep Git transport/packfile work and reachability-bitmap design, but the
    sources fetched here document the HTTP protocol, fast-import, reflogs, and
    git-gui specifically rather than bitmaps by name. Treat bitmap attribution as
    plausible-but-unconfirmed pending a primary citation.

- **Guido van Rossum** — creator of Python; author of **Rietveld** (2008), the
  open-source code-review tool that Gerrit forked from; previously built Google's
  internal **Mondrian**.
  Source: [Guido van Rossum releases Mondrian-clone: Rietveld — Google Developers Blog](https://developers.googleblog.com/guido-van-rossum-releases-mondrian-clone-rietveld/);
  [Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software)).

- **Robin Rosenberg** — leading early contributor to JGit alongside Pearce.
  Source: [Eclipse JGit project page — projects.eclipse.org](https://projects.eclipse.org/projects/technology.jgit).

- **Google / Android team** — institutional home of Mondrian, Rietveld (App
  Engine team), and Gerrit (built for AOSP). Gerrit is hosted on Google's
  `*.googlesource.com` infrastructure.
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).

- **GerritForge** — a company providing commercial Gerrit support and community
  blogging; author of memorial and community content (cited for context, not for
  primary historical dates).
  Source: [Shawn Pearce: a true leader — GerritForge Blog (Jan 30, 2018)](https://gitenterprise.me/2018/01/30/shawn-pearce-a-true-leader/).

---

## Lineage & underlying tech

**Tool lineage (review model):**

```
Mondrian (Google-internal, Perforce, proprietary)
   │  inspiration; some code reused
   ▼
Rietveld (Guido van Rossum, 2008, Python/Django on App Engine, Subversion)
   │  forked + patched for AOSP / Git
   ▼
Gerrit 1.x  (Python on Google App Engine)
   │  complete rewrite (~2009)
   ▼
Gerrit 2.x  (Java, J2EE servlet container, SQL "ReviewDb")
   │  metadata moves into Git; GWT → Polymer UI
   ▼
Gerrit 3.x  (Java, NoteDb = metadata stored in Git)
```

Sources: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html);
[Rietveld (software) — Wikipedia](https://en.wikipedia.org/wiki/Rietveld_(software));
[Gerrit: Google-style code review meets git — LWN.net (2009)](https://lwn.net/Articles/359489/).

**Underlying technology stack:**

- **JGit** — pure-Java implementation of Git; the foundation Gerrit is built on.
  Started by Shawn Pearce (2006), hosted under the Eclipse Foundation.
  Source: [Eclipse JGit project page](https://projects.eclipse.org/projects/technology.jgit);
  [eclipse-jgit/jgit — GitHub](https://github.com/eclipse-jgit/jgit).
- **Gitiles** — JGit-based read-only Git repository browser used alongside
  Gerrit.
  Source: [gitiles — Git at Google](https://gerrit.googlesource.com/gitiles/).
- **NoteDb** — Gerrit's Git-native metadata store (Gerrit 3.x), replacing the
  earlier SQL ReviewDb.
  Source: [Gerrit Code Review — NoteDb Backend](https://gerrit-review.googlesource.com/Documentation/note-db.html).
- **Polymer** — web-component framework adopted for the modern Gerrit UI
  (replacing GWT).
  Source: [Gerrit's History — gerritcodereview.com/about.html](https://www.gerritcodereview.com/about.html).

---

## Sources

- Gerrit's History — https://www.gerritcodereview.com/about.html
- Gerrit News — https://www.gerritcodereview.com/news.html
- Gerrit Releases — https://www.gerritcodereview.com/releases-readme.html
- Gerrit — Uploading Changes — https://gerrit-review.googlesource.com/Documentation/user-upload.html
- Gerrit — Walkthrough for GitHub Users — https://gerrit-review.googlesource.com/Documentation/intro-gerrit-walkthrough-github.html
- Gerrit — NoteDb Backend — https://gerrit-review.googlesource.com/Documentation/note-db.html
- Gerrit — Installations in the Wild — https://gerrit.googlesource.com/homepage/+/md-pages/docs/ShowCases.md
- GerritCodeReview/gerrit (GitHub mirror) — https://github.com/GerritCodeReview/gerrit
- Guido van Rossum releases Rietveld — Google Developers Blog (May 8, 2008) — https://developers.googleblog.com/guido-van-rossum-releases-mondrian-clone-rietveld/
- Rietveld (software) — Wikipedia — https://en.wikipedia.org/wiki/Rietveld_(software)
- Gerrit (software) — Wikipedia — https://en.wikipedia.org/wiki/Gerrit_(software)
- Gerrit: Google-style code review meets git — LWN.net (Oct 30, 2009) — https://lwn.net/Articles/359489/
- The Git community mourns Shawn Pearce — LWN.net (Jan 2018) — https://lwn.net/Articles/745802/
- Remembering Shawn Pearce — Software Freedom Conservancy (Jan 30, 2018) — https://sfconservancy.org/blog/2018/jan/30/shawn-pearce/
- Shawn Pearce: a true leader — GerritForge Blog — https://gitenterprise.me/2018/01/30/shawn-pearce-a-true-leader/
- Eclipse JGit project page — https://projects.eclipse.org/projects/technology.jgit
- eclipse-jgit/jgit — GitHub — https://github.com/eclipse-jgit/jgit
- gitiles — Git at Google — https://gerrit.googlesource.com/gitiles/
- google/gitiles — GitHub — https://github.com/google/gitiles
- Go Contribution Guide — https://go.dev/doc/contribute
- go-review.googlesource.com — https://go-review.googlesource.com/
- Chromium Review — https://chromium-review.googlesource.com/
- Chromium Docs — Code Reviews — https://chromium.googlesource.com/chromium/src/+/lkgr/docs/code_reviews.md
- OpenStack Gerrit Workflow — https://wiki.openstack.org/wiki/Gerrit_Workflow
- OpenStack — Using Gerrit — https://docs.openstack.org/contributors/code-and-documentation/using-gerrit.html
- LibreOffice Gerrit — https://gerrit.libreoffice.org/
- LibreOffice/core — GitHub — https://github.com/LibreOffice/core
