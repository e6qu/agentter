# BitKeeper: the proprietary DVCS that gave us Git and Mercurial

A chronological, fully-sourced history of **BitKeeper** — the distributed
version control system (DVCS) built by Larry McVoy's company **BitMover, Inc.**
— and its pivotal role in triggering the creation of **Git** and **Mercurial**
in April 2005.

> Scope note: this episode is genuinely contested. Larry McVoy (BitMover),
> Andrew Tridgell, Linus Torvalds, and the Free Software Foundation all
> describe it differently. Where accounts conflict, claims are attributed to
> their source rather than asserted as settled fact.

---

## Timeline

### 1998–2000 — Origins

- **1998** — Larry McVoy (who had earlier designed Sun's *TeamWare* SCM) sees
  the strain that thousands of contributors place on Linux kernel development
  and begins thinking about a distributed SCM to address it.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))
- **2000** — McVoy founds **BitMover, Inc.** (Los Gatos, California) to build
  and sell BitKeeper.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))
- **May 1999** — Early-access betas of BitKeeper become available.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))
- **May 4, 2000** — First public release of BitKeeper.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))

BitKeeper popularized the **distributed** model years before Git: there is no
single central repository; each developer keeps one or more fully independent
trees, and changes (with full revision history) are *pulled* between trees.
([LWN, "The kernel and BitKeeper part ways"](https://lwn.net/Articles/130746/);
[Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))

### 2002 — Linux kernel adoption (and the first controversy)

- **February 2002** — Linus Torvalds begins using BitKeeper for Linux kernel
  development, during the rocky early **2.5** development series (patches being
  dropped, maintainers complaining). BitKeeper measurably improved kernel
  development throughput.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper);
  [InfoWorld, "Linus Torvalds' BitKeeper blunder"](https://www.infoworld.com/article/2211030/linus-torvalds-bitkeeper-blunder.html))
- The choice was **controversial because BitKeeper was proprietary**, used on
  the flagship free-software project. **Richard Stallman / the FSF** objected.
  A "Petition Against Official Endorsement of BitKeeper by Linux Maintainers"
  was circulated on LKML in March 2002; McVoy and others responded on-list.
  ([LKML thread, McVoy reply, 2002-03-05](https://lkml.org/lkml/2002/3/5/252)
  — *note: lkml.org currently returns an access-denied/Anubis page, so the
  message body could not be re-verified directly at fetch time; the thread's
  existence and date are corroborated by search indexing.*)

**The "free use" license restrictions.** BitMover offered a *gratis*
"community" license for use on open-source/free projects, but with a
**non-compete clause**: while using BitKeeper, a developer could **not
participate in developing a competing SCM tool** (CVS, GNU arch, Subversion,
ClearCase were named), and could **not reverse-engineer** the software. This is
the clause at the heart of the 2005 blow-up.
([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper);
[InfoWorld](https://www.infoworld.com/article/2211030/linus-torvalds-bitkeeper-blunder.html))

### 2005 — The crisis (see detailed section below)

- **Feb 23, 2005** — By McVoy's account, Torvalds tells him that Andrew
  Tridgell is working to pull data out of BitKeeper trees without agreeing to
  the BK license. ([LWN](https://lwn.net/Articles/130746/) and search-indexed
  McVoy statements; *exact wording attributed to McVoy*.)
- **April 6, 2005** — LWN reports **"The kernel and BitKeeper part ways"**:
  BitMover will withdraw the free version. ([LWN](https://lwn.net/Articles/130746/))
- **April 7, 2005** — Git's first commit (self-hosting). (See below.)
- **April 19, 2005** — Matt (now Olivia) Mackall announces **Mercurial**.
  ([Wikipedia: Matt Mackall / Mercurial](https://en.wikipedia.org/wiki/Matt_Mackall))
- **April 21, 2005** — Tridgell publicly demonstrates the method and releases
  **SourcePuller**. ([LWN, "How Tridge reverse engineered BitKeeper"](https://lwn.net/Articles/132938/);
  [Wikipedia: SourcePuller](https://en.wikipedia.org/wiki/SourcePuller))
- **April 22, 2005** — The Register, "Tridgell drops BitKeeper bombshell."
  ([The Register](https://www.theregister.com/2005/04/22/tridgell_releases_sourcepuller/))
- **July 1, 2005** — Official end-of-support for the "Free Use" version of
  BitKeeper; community users had to buy the commercial version or move off it.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))

### 2005 (continued) — Git matures and takes over the kernel

- **June 16, 2005** — Git manages the kernel **2.6.12** release.
  ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git))
- **July 26, 2005** — Torvalds hands Git maintainership to **Junio Hamano**.
  ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git);
  [GitHub Blog, "Git turns 20"](https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/))
- **December 21, 2005** — Git **1.0** released (under Hamano).
  ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git))

### 2016 — BitKeeper open-sourced (too late)

- **May 9, 2016** — BitKeeper released as **open source under Apache-2.0**
  (version 7.2ce), eleven years after the crisis that birthed Git.
  ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper);
  [LWN, "BitKeeper's open source release"](https://lwn.net/Articles/686896/);
  [LWN, "BitKeeper goes open source"](https://lwn.net/Articles/686986/))
- BitMover subsequently wound down its commercial business; McVoy framed the
  open-sourcing as a last-ditch move while the company "still had money in the
  bank." (See retrospective below.)

---

## Key people & teams

- **Larry McVoy** — Founder/owner of **BitMover, Inc.**; creator of BitKeeper;
  previously designed Sun TeamWare. The decision-maker who withdrew the free
  license in 2005 and who open-sourced BitKeeper in 2016.
  ([Wikipedia: Larry McVoy](https://en.wikipedia.org/wiki/Larry_McVoy))
- **BitMover, Inc.** — Privately held company, Los Gatos, CA; sole vendor of
  BitKeeper. ([Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))
- **Linus Torvalds** — Linux creator; adopted BitKeeper in 2002 and wrote Git
  in April 2005 after the license was pulled.
  ([GitHub Blog Q&A](https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/))
- **Andrew "Tridge" Tridgell** — Samba creator; at the time employed by **OSDL
  (Open Source Development Lab)** on an unrelated project. Built the client
  (later **SourcePuller**) that interoperated with BitKeeper, triggering the
  dispute. ([Wikipedia: Andrew Tridgell](https://en.wikipedia.org/wiki/Andrew_Tridgell);
  [LWN](https://lwn.net/Articles/132938/))
- **Matt Mackall** (now **Olivia Mackall**) — Kernel developer who started
  **Mercurial** in April 2005 for the same reason Git was started.
  ([Wikipedia: Matt Mackall](https://en.wikipedia.org/wiki/Matt_Mackall))
- **Junio Hamano** — Took over Git maintainership on July 26, 2005, and has led
  it since. ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git))
- **Richard Stallman / Free Software Foundation** — Long-standing critics of
  using proprietary BitKeeper on the kernel; RMS later wrote "Thank You, Larry
  McVoy." ([GNU/FSF](https://www.gnu.org/philosophy/mcvoy.en.html))

---

## The 2005 crisis (→ Git & Mercurial)

### What happened, mechanically

Andrew Tridgell wanted a **free-software client** that could read data out of
BitKeeper repositories. His method, demonstrated live at **linux.conf.au** and
reported by LWN on **April 21, 2005**, was strikingly simple: connect to the
BitKeeper server's port (5000) with **telnet**, type **`help`** to get the list
of server commands, then issue **`clone`**, which returned SCCS files. At the
talk, Tridgell had the audience call out the commands; hundreds reproduced it in
about two minutes. ([LWN, "How Tridge reverse engineered BitKeeper"](https://lwn.net/Articles/132938/))

The resulting tool was named **SourcePuller**, written in C and released under
GPLv2-or-later, first published **April 21, 2005**.
([Wikipedia: SourcePuller](https://en.wikipedia.org/wiki/SourcePuller))

### Three perspectives (presented fairly)

**McVoy / BitMover's view.** McVoy held that Tridgell's work amounted to
reverse-engineering BitKeeper's protocols — a violation of the community
license's non-compete / no-reverse-engineering terms — and that the repository
**metadata belonged to BitMover, not to the community**. When OSDL (Tridgell's
employer) declined to stop him, BitMover **withdrew the free license** entirely.
McVoy characterized the underlying problem as open-source people who "simply
don't want to play with non-open source."
([LWN](https://lwn.net/Articles/130746/);
[The Register](https://www.theregister.com/2005/04/22/tridgell_releases_sourcepuller/))

**Tridgell's view.** Tridgell maintained he **never agreed to the BitKeeper
license** and **never used the `bk` client** — he only observed the server's
publicly documented protocol. As he put it, BK servers expose **online protocol
help reachable by typing `help` into a telnet session**, which he took as
intended for people implementing new clients: *"I don't think it is unreasonable
to assume that this help was intended for people like myself who wished to
implement new clients."* He said his code "was written without using bk," that
SourcePuller was "not intended to be a full replacement for BitKeeper," and that
he was "disappointed at how BitMover has portrayed some of my actions."
([LWN](https://lwn.net/Articles/132938/);
[The Register](https://www.theregister.com/2005/04/22/tridgell_releases_sourcepuller/);
[Wikipedia: Andrew Tridgell](https://en.wikipedia.org/wiki/Andrew_Tridgell))

**Torvalds's view.** Torvalds was caught between the two and, by his own later
account, frustrated with both sides — "no solution coming up." He publicly
criticized Tridgell at the time, but he also valued BitKeeper highly,
describing it as "light years ahead of anything else," while acknowledging its
proprietary nature was a real problem for the community. Rather than adopt an
existing SCM, he resolved to build something new: "how do I do something that
does even better than BitKeeper does, but doesn't do it the way BitKeeper does
it." His immediate framing was pragmatic: "I'll do something that works for me,
and I won't care about anybody else."
([GitHub Blog, "Git turns 20: A Q&A with Linus Torvalds"](https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/);
[LWN](https://lwn.net/Articles/130746/))

> On the precise sequence of who-did-what-when in February–April 2005,
> accounts differ in emphasis and tone. The dates above (Feb 23 conversation,
> April 6 LWN report, April 21 demo) are documented; the *characterizations*
> (whether it was "reverse engineering," whether a license even applied to
> Tridgell) remain disputed between the parties and are attributed accordingly.

**The FSF / Stallman view.** RMS argued the deeper harm was never just
BitKeeper itself but the message its kernel adoption sent — *"freedom-denying
software is acceptable as long as it's convenient."* In *"Thank You, Larry
McVoy"* he ironically thanks McVoy: by withdrawing BitKeeper, McVoy freed the
kernel community from a proprietary dependency and demonstrated the FSF's point
that *"nonfree programs are dangerous to you and to your community."*
([GNU/FSF, "Thank You, Larry McVoy"](https://www.gnu.org/philosophy/mcvoy.en.html))

### The aftermath: Git is born (10 days)

With BitKeeper gone, Torvalds wrote his own DVCS:

- He had spent roughly **four months conceptualizing** the design before
  writing code, then implemented Git fast. By his own account, **after about a
  week** he had something good for applying patches, and Git **self-hosted in
  roughly 10 days** — the popular "Git in 10 days" framing.
  ([GitHub Blog Q&A](https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/))
- Per Wikipedia, **development began April 3, 2005**; Torvalds **announced it
  April 6** and achieved **self-hosting April 7**.
  ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git))
- The **first commit** is dated **Thu Apr 7 15:13:13 2005 -0700**:
  `e83c5163316f89bfbde7d9ab23ca2e25604af29` — *"Initial revision of 'git', the
  information manager from hell."*
  ([GitLab, "Journey through Git's 20-year history"](https://about.gitlab.com/blog/journey-through-gits-20-year-history/);
  corroborated by [GitHub Blog Q&A](https://github.blog/open-source/git/git-turns-20-a-qa-with-linus-torvalds/))
- Git hit milestones quickly: first merge **April 18, 2005**; managing the
  kernel **2.6.12** release on **June 16, 2005**.
  ([Wikipedia: Git](https://en.wikipedia.org/wiki/Git))

### The aftermath: Mercurial is born (same cause, days later)

Independently and for the same reason, **Matt (Olivia) Mackall announced
Mercurial on April 19, 2005** — explicitly prompted by BitMover's withdrawal of
the free BitKeeper version following SourcePuller. Mercurial started a few days
after Git, with similar goals; the kernel chose Git, but Mercurial went on to be
adopted by many other projects. The **name "Mercurial"** was chosen after Olivia
Mackall read an article describing **Larry McVoy as "mercurial"** (in the sense
of *fickle*).
([Wikipedia: Matt Mackall / Mercurial](https://en.wikipedia.org/wiki/Matt_Mackall))

---

## Epilogue: 2016 open-sourcing and McVoy's retrospective

On **May 9, 2016**, BitMover released BitKeeper as **open source under the
Apache-2.0 license**, eleven years after Git was born from the BitKeeper
breakup. ([LWN, "BitKeeper's open source release"](https://lwn.net/Articles/686896/);
[Wikipedia: BitKeeper](https://en.wikipedia.org/wiki/BitKeeper))

In his retrospective (largely on Hacker News, covered by LWN), McVoy was candid
about market reality rather than re-litigating 2005:

- *"Git/Github has all the market share. Trying to compete with that just
  proved to be too hard."*
- *"Rather than wait until we were about to turn out the lights, we decided to
  open source it while we still had money in the bank."* (He said the company
  had roughly two years of runway.)
- On the license: *"all the lawyers at all the big companies liked that one"* —
  with a note that they'd relicense to GPL "if everyone yells."
- On BitKeeper vs Git, defending his design: *"You need to understand how Git
  works to use it properly; BK is more like a car, you just get in and drive."*

([LWN, "BitKeeper goes open source"](https://lwn.net/Articles/686986/);
[Slashdot, "11 Years After Git, BitKeeper Is Open-Sourced"](https://news.slashdot.org/story/16/05/10/1840255/11-years-after-git-bitkeeper-is-open-sourced))

---

## Cross-references (not duplicated here)

Modern code-hosting and review platforms — **GitHub**, **GitLab**, and
**Gerrit** — are all built **on top of Git**, which exists only because of the
2005 BitKeeper crisis. For their own architecture and code-generation/workflow
documentation, see those projects' docs directly rather than this file:

- GitHub — https://docs.github.com/
- GitLab — https://docs.gitlab.com/
- Gerrit — https://gerrit-review.googlesource.com/Documentation/

---

## Could not verify / caveats

- **Could not verify (primary text):** The exact body of the 2002 LKML "Petition
  Against Official Endorsement of BitKeeper" thread and McVoy's reply
  (`lkml.org/lkml/2002/3/5/252`) — the lkml.org page currently returns an
  Anubis access-denied page. The thread's existence, author (McVoy), and date
  (2005-03-05 per the URL/index) are corroborated by search results, but the
  message wording itself was not re-read at fetch time.
- **Could not verify (exact date):** The publication date of RMS's "Thank You,
  Larry McVoy" essay is not stated on the GNU page as fetched; its content and
  argument are verified, the date is not.
- **Attributed, not adjudicated:** "Reverse engineering" vs. "using documented
  protocol," and whether any BitKeeper license bound Tridgell at all, are
  contested between McVoy and Tridgell. Both positions are quoted from their
  respective sources above; this document does not declare a winner.
- **"Feb 23, 2005" conversation:** This specific date is reported as McVoy's
  account of when Torvalds told him about Tridgell's work; treat as McVoy's
  framing rather than independently confirmed.
- **"10 days" for Git:** This is the widely repeated figure and is consistent
  with Torvalds's own "after the first week… / self-hosting" description and the
  April 3 (start) → April 7 (self-host) Wikipedia dates, but "10 days" is a
  round characterization, not a single sourced timestamp.
