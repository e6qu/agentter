# Nix / NixOS / nixpkgs — A Sourced History

A chronological, fully-sourced history of the Nix purely-functional package
manager, the NixOS Linux distribution, the nixpkgs collection, and the 2024
governance crisis. Every non-trivial claim is linked to a primary or reputable
source. Where sources conflict or could not be confirmed, this is flagged
inline and in the "Could not verify" section at the end.

> Convention: **Fact** = stated by a primary/official source or multiple
> reputable sources. **Allegation / opinion** = a claim made by a specific
> party (open letter authors, a blog, press) that is attributed to that party
> and not independently confirmed here.

---

## Timeline

### 2003 — Origins as PhD research
Nix began **circa 2003** as a research project by **Eelco Dolstra** at
**Utrecht University** (Utrecht, the Netherlands), supervised by **Eelco
Visser**. The core idea: model software deployment as a *purely functional*
process, where packages are built in isolation and stored under
content-addressed paths in a "Nix store," eliminating undeclared dependencies
and configuration drift ("dependency hell").
- Sources: [NixOS — Wikipedia](https://en.wikipedia.org/wiki/NixOS);
  [The Purely Functional Software Deployment Model — researchr](https://researchr.org/publication/Dolstra2006).
- Note: The exact "2003" start year is reported by Wikipedia (secondary). The
  thesis itself (below) is the authoritative artifact.

### January / February 2006 — Dolstra's PhD thesis
Dolstra completed his doctoral thesis, **"The Purely Functional Software
Deployment Model,"** Utrecht University. The thesis describes the Nix package
manager and the declarative/functional deployment model.
- Thesis record (year/title/university): [researchr](https://researchr.org/publication/Dolstra2006).
- The thesis was **defended on Saturday, 18 February 2006**, per the official
  NixOS blog announcement: [PhD thesis defended | Nix & NixOS blog](https://nixos.org/blog/announcements/2006/phd-thesis-defended-2006/).
- Date discrepancy: The researchr record lists the publication **month as
  January 2006**, while the official NixOS blog gives the **defense date as 18
  February 2006**. Both are cited; these likely refer to publication vs.
  defense. Marked: see "Could not verify."

### 2006 — First NixOS prototype
The first **NixOS** prototype was created by **Armijn Hemel** as part of his
Master's thesis, *"NixOS: The Nix Based Operating System"* — extending the Nix
model to manage an entire Linux operating system declaratively.
- Source: [NixOS — Wikipedia](https://en.wikipedia.org/wiki/NixOS) (secondary).

### 2008 — NixOS published academically
Dolstra and Andres Löh presented **"NixOS: A Purely Functional Linux
Distribution"** at ICFP 2008, formalizing the OS-level application of the Nix
model.
- Source: [NixOS: A Purely Functional Linux Distribution (ICFP 2008 PDF)](https://edolstra.github.io/pubs/nixos-icfp2008-final.pdf).

### 2013 — NixOps 1.0 (deployment tool)
**NixOps** (originally codenamed *Charon*) — a tool for deploying NixOS
machines across networks and clouds (EC2, VirtualBox, Hetzner, GCP, Azure,
etc.) — reached **version 1.0**. NixOps separates the *logical* deployment
spec (what a machine should do) from the *physical* spec (where it runs).
- Sources: [NixOps 1.0 released | Nix & NixOS blog](https://nixos.org/blog/announcements/2013/nixops-10/);
  [NixOps repo (NixOS/nixops)](https://github.com/NixOS/nixops).

### December 2013 — First stable NixOS release (13.10)
**NixOS 13.10** was released as **the first stable branch of NixOS**,
intended to give production systems security and bug fixes without unstable
churn.
- Source (primary announcement): [NixOS 13.10 released | Nix & NixOS blog](https://nixos.org/blog/announcements/2013/nixos-1310/)
  — states "released NixOS 13.10, the first stable branch" with date
  **Sunday, 1 December 2013**.
- Date discrepancy: The version number "13.10" and some references to the
  codename "Aardvark" suggest October 2013; one secondary summary cites
  2013-10-31. The **primary blog announcement is dated 1 December 2013**, which
  is used here. Marked: see "Could not verify."

### 2015 — NixOS Foundation established
The **NixOS Foundation** (Stichting NixOS Foundation) was established as a
Dutch non-profit, registered with the Chamber of Commerce (Kamer van
Koophandel) in the Netherlands. It serves as the legal/financial interface for
the community and operates key infrastructure (the binary cache
`cache.nixos.org` and the Hydra build farm `hydra.nixos.org`).
- Sources (founding year 2015 is secondary): [NixOS — Wikipedia](https://en.wikipedia.org/wiki/NixOS);
  [Stichting NixOS Foundation — OpenCorporates (NL)](https://opencorporates.com/companies/nl/63520583);
  [NixOS/foundation repo](https://github.com/NixOS/foundation).
- The "2015" founding year is from Wikipedia; the legal registration exists per
  OpenCorporates. Exact incorporation date not independently pinned here — see
  "Could not verify."

### 2019–2021 — Flakes (RFC 49) and the new CLI
**Flakes** — a feature standardizing the structure of Nix expressions and
adding lock files for reproducible inputs — were proposed in **RFC 49**
(authored by edolstra) and developed through 2019–2020.
- RFC: [\[RFC 0049\] Flakes by edolstra · PR #49 · NixOS/rfcs](https://github.com/nixos/rfcs/pull/49).
- Flakes shipped as an **experimental feature** with **Nix 2.4** (released
  **2021-11-01**) and remain experimental/opt-in.
  - Sources: [Flakes — NixOS Wiki](https://nixos.wiki/wiki/Flakes);
    [nix.dev Flakes concepts](https://nix.dev/concepts/flakes.html).
- Note (process controversy, attributed): Secondary summaries report RFC 49 was
  effectively **withdrawn/merged without formal acceptance**, which later fed
  into broader governance complaints. This is reported by community sources, not
  independently confirmed here — see [\[RFC 0136\] PR #136](https://github.com/NixOS/rfcs/pull/136)
  for the later stabilization plan. Marked: see "Could not verify."

### September 2023 — Anduril dropped as NixCon 2023 sponsor (first flashpoint)
**Fact:** NixCon accepted **Anduril Industries** — a U.S. defense contractor
that builds autonomous/remote-piloted military systems and has reportedly
secured over \$1 billion in Pentagon contracts — as a sponsor, then **dropped
it within ~24 hours** after community backlash on the NixOS Discourse.
- Official statement (via the Foundation, posted to Twitter/X per press):
  "Following internal discussion and community feedback, we decided to drop
  this sponsor. We'll be sure to review our Code of Conduct and sponsorship
  rules to do better in the future."
- Sources (reputable press + forum): [NixCon drops AI war drone maker Anduril as a sponsor — The Register, 8 Sep 2023](https://www.theregister.com/2023/09/08/nixcon_drops_anduril_industries_as/);
  [NixCon 2023 Sponsorship Situation from the NixOS Foundation — NixOS Discourse](https://discourse.nixos.org/t/nixcon-2023-sponsorship-situation-from-the-nixos-foundation/33583).

### Early 2024 — NixCon NA 2024 again sponsored by Anduril
**Fact:** The Anduril sponsorship question returned for **NixCon NA 2024**,
reigniting the dispute on Discourse.
- Source: [NixCon NA 2024 is getting sponsored by Anduril, what to do about it — NixOS Discourse](https://discourse.nixos.org/t/nixcon-na-2024-is-getting-sponsored-by-anduril-what-to-do-about-it/41258).

### Late February 2024 — Lix work begins (privately)
**Fact:** A team of 10+ contributors began work on **Lix**, a fork of the Nix
implementation, beginning **in late February 2024** (publicly revealed later).
- Source: [Announcing Lix 2.90 "Vanilla Ice Cream" — lix.systems, 10 Jul 2024](https://lix.systems/blog/2024-07-10-lix-2.90-release/)
  ("begun in late February 2024").

### 21 April 2024 — The open letter ("Save Nix Together")
**Fact:** An **open letter** (hosted at `save-nix-together.org`) was published
calling for **Eelco Dolstra to resign** from the project. It was authored by a
group including anonymous authors plus named signatories and **gathered 100+
signatures**.
- The letter's core claims (**allegations**, attributed to the letter's
  authors): that Dolstra acted as a **de-facto BDFL** without the Foundation
  charter granting him that authority; that he **repeatedly overruled** boards
  and teams; and that he **pushed for Anduril's inclusion** as a NixCon sponsor
  over the objections of core contributors. The letter demanded he resign from
  the board and step away from the project for at least six months, and stated
  signatories would back a **fork** if he did not.
- Sources: [A leadership crisis in the Nix community — LWN.net, 29 Apr 2024](https://lwn.net/Articles/970824/)
  (LWN attributes these to the letter and quotes it); the letter itself was at
  `https://save-nix-together.org/` (direct fetch failed at time of writing — see
  "Could not verify" for the primary-source caveat).

**Fact (related resignations, per LWN):** LWN reports resignations and
departures around this period, attributing specifics to the events:
- Kamila Borowska resigned (reported 21 April 2024).
- Mario Rodas (a 250+ package contributor) resigned (reported 25 April 2024).
- LWN reports the moderation team was down to four members and that, by its
  count, "24 maintainers have left."
- The moderation team's own statement (quoted by LWN): "Overall we think that
  the letter describes the situation of the moderation team fairly well. We
  have been operating in an emergency mode most of the time for over half a
  year now."
- Source: [LWN.net, A leadership crisis in the Nix community](https://lwn.net/Articles/970824/)
  (these figures are LWN's reporting/attribution, not independently re-counted
  here).

### ~26 April 2024 — Dolstra's response (Determinate Systems blog)
**Fact (attributed):** Per LWN, Dolstra posted a response on the **Determinate
Systems** blog (the company he co-founded with **Graham Christensen**), **not
coordinated with the board**. **His claim (opinion/defense):** "I am just one
member of the five-member Nix team and hold no more formal authority than the
others in determining the direction of the team." He defended Anduril's right
to participate and denied keeping his Determinate Systems role secret.
- LWN reports the remaining board members **publicly distanced themselves**
  from this response, noting it was uncoordinated.
- Source (attribution + quotes): [LWN.net, 29 Apr 2024](https://lwn.net/Articles/970824/).

### 30 April – 1 May 2024 — Dolstra steps down from the Foundation board
**Fact:** The NixOS Foundation board announced that **Eelco Dolstra would step
down from the board**. The board's official statement (posted to NixOS
Discourse, 1 May 2024) framed it as amicable and tied to the BDFL concern:
"Eelco showed no intention to be perceived as or act like the BDFL ... of the
Nix ecosystem ... he has decided to formally step down from the board." The
board committed to **appointing a constitutional assembly within 14 days** to
build a community-run governance structure.
- Sources: [Eelco Dolstra steps down from NixOS Foundation board — LWN.net, 1 May 2024](https://lwn.net/Articles/971973/)
  (board announcement dated 30 April per LWN); official board post:
  [NixOS Foundation board: Giving power to the community — NixOS Discourse](https://discourse.nixos.org/t/nixos-foundation-board-giving-power-to-the-community/44552)
  (signed by edolstra, ron, zimbatm, thufschmitt).

### 5–6 May 2024 — Lix announced publicly
**Fact:** **Lix** — "a modern, delicious implementation of the Nix package
manager, focused on correctness, usability, and growth" — was publicly
revealed as a **fork of Nix** (specifically forking from **CppNix 2.18**).
Public preview began around **5 May 2024**. It is an **independent project, not
under the NixOS Foundation**, and explicitly positions itself around community
ownership and governance — emerging from the dissatisfaction documented in the
open letter.
- Sources: [Lix — official site](https://lix.systems/);
  [Lix is a modern, delicious implementation of the Nix package manager — Hacker News, May 2024](https://news.ycombinator.com/item?id=40271242);
  [Lix - a new fork of Nix — Lemmy.World](https://lemmy.world/post/15081844).

### 16 May 2024 — Constitutional assembly appointed
**Fact:** The NixOS Foundation board appointed a **7-member constitutional
assembly** (from **27 applications**) to design new governance. Appointees:
**Danielle Lancashire, edef, lassulus, Michael Raskin, Ryan Trinkle, Sarah
Novotny, Silvan Mosberger**.
- Source: [NixOS Foundation Board: Constitutional Assembly Appointment — NixOS Discourse](https://discourse.nixos.org/t/nixos-foundation-board-constitutional-assembly-appointment/45504)
  (LWN/press corroborate the 30-April board commitment leading to this).

### 10 July 2024 — Lix 2.90 "Vanilla Ice Cream" (first release)
**Fact:** Lix shipped its **first release, 2.90**, forked from CppNix 2.18 with
reliability fixes, improved error reporting, and **5–20% faster evaluation**
(per the release notes). Lix states longer-term goals including gradual
adoption of **Rust** and a **Meson** build system.
- Sources: [Announcing Lix 2.90 — lix.systems, 10 Jul 2024](https://lix.systems/blog/2024-07-10-lix-2.90-release/);
  [Lix makes its second release — LWN.net](https://lwn.net/Articles/985484/);
  [Announcing Lix 2.91 "Dragon's Breath" — lix.systems, 12 Aug 2024](https://lix.systems/blog/2024-08-12-lix-2.91-release/).

### 2024–2025 — New governance: Steering Committee + constitution
**Fact:** The constitutional assembly's work produced a **Nix Governance
Constitution** and a new structure with an **elected 7-member Steering
Committee** (technical/community decisions) alongside the **Foundation Board**
(legal/financial). Steering Committee members serve two-year terms with annual
elections; elections were held in **2024 and 2025**.
- Sources: [Governance | Nix & NixOS](https://nixos.org/governance/);
  [Nix Governance Constitution (NixOS/org)](https://github.com/NixOS/org/blob/main/doc/constitution.md);
  [Nix Constitutional Assembly repo](https://github.com/NixOS/nix-constitutional-assembly);
  [SC-election-2024](https://github.com/NixOS/SC-election-2024),
  [SC-election-2025](https://github.com/NixOS/SC-election-2025).

---

## Key people & teams

- **Eelco Dolstra** — Creator of Nix; PhD thesis "The Purely Functional
  Software Deployment Model" (Utrecht University, 2006); long the de-facto
  technical leader/"BDFL"; co-founder of **Determinate Systems**; stepped down
  from the NixOS Foundation board in 2024.
  [Thesis](https://researchr.org/publication/Dolstra2006) ·
  [LWN, 1 May 2024](https://lwn.net/Articles/971973/).
- **Eelco Visser** — Dolstra's PhD supervisor at Utrecht University.
  [Wikipedia](https://en.wikipedia.org/wiki/NixOS).
- **Andres Löh** — Co-author of the 2008 ICFP NixOS paper.
  [ICFP 2008 PDF](https://edolstra.github.io/pubs/nixos-icfp2008-final.pdf).
- **Armijn Hemel** — Built the first NixOS prototype (Master's thesis, 2006).
  [Wikipedia](https://en.wikipedia.org/wiki/NixOS).
- **Graham Christensen** — Co-founder of Determinate Systems with Dolstra;
  named in the open letter's Anduril/sponsorship account (per LWN).
  [LWN, 29 Apr 2024](https://lwn.net/Articles/970824/).
- **Théophane Hufschmitt (thufschmitt)**, **zimbatm**, **ron** — NixOS
  Foundation board members co-signing the 2024 governance statements.
  [NixOS Discourse](https://discourse.nixos.org/t/nixos-foundation-board-giving-power-to-the-community/44552).
- **Constitutional assembly (2024)** — Danielle Lancashire, edef, lassulus,
  Michael Raskin, Ryan Trinkle, Sarah Novotny, Silvan Mosberger.
  [NixOS Discourse](https://discourse.nixos.org/t/nixos-foundation-board-constitutional-assembly-appointment/45504).
- **Lix team** — 10+ volunteers (usernames cited in release notes include
  jade, Lunaphied, wiggles, "eldritch horrors"; @ktemkin associated with the
  announcement per Lemmy threads); independent of the NixOS Foundation.
  [Lix 2.90 release](https://lix.systems/blog/2024-07-10-lix-2.90-release/).
- **NixOS Foundation** — Dutch non-profit (Stichting NixOS Foundation), the
  ecosystem's legal/financial entity, operating the binary cache and Hydra.
  [NixOS/foundation](https://github.com/NixOS/foundation) ·
  [OpenCorporates](https://opencorporates.com/companies/nl/63520583).

---

## Governance & controversies

### Pre-2024 structure (fact + attributed opinion)
**Fact:** The NixOS Foundation existed as the legal entity, but technical
direction long rested informally with Dolstra and a small "Nix team."
**Allegation (open letter / LWN reporting):** Critics argued this amounted to
an **undocumented BDFL model** that let Dolstra override formal bodies. The
Foundation board's own 2024 statement implicitly acknowledged the BDFL
perception by stating he had "no intention to be perceived as or act like the
BDFL."
- Sources: [LWN, 29 Apr 2024](https://lwn.net/Articles/970824/);
  [Board statement, NixOS Discourse](https://discourse.nixos.org/t/nixos-foundation-board-giving-power-to-the-community/44552).

### The Anduril / NixCon sponsorship dispute (fact + attribution)
**Fact:** Anduril Industries (defense contractor) was accepted then dropped as
a NixCon **2023** sponsor within ~24 hours after backlash; the issue recurred
for NixCon NA **2024**.
**Allegation (attributed to the open letter, via LWN):** Dolstra "pushed
strongly for the inclusion of Anduril as a sponsor even after it became clear
that many core contributors disagreed." When asked about Determinate Systems'
relationship with Anduril, Christensen reportedly replied (quoted by LWN):
"Did you know this category of question is pretty much impossible to answer
because NDAs are a thing?"
- Sources: [The Register, 8 Sep 2023](https://www.theregister.com/2023/09/08/nixcon_drops_anduril_industries_as/);
  [NixCon NA 2024 Discourse thread](https://discourse.nixos.org/t/nixcon-na-2024-is-getting-sponsored-by-anduril-what-to-do-about-it/41258);
  [LWN, 29 Apr 2024](https://lwn.net/Articles/970824/).
- Note on "SnowflakeOS": The task brief mentioned SnowflakeOS in connection
  with the Anduril/defense controversy. No reliable source connecting
  SnowflakeOS to the Anduril sponsorship dispute was found. Marked: see "Could
  not verify."

### The open letter and resignations (fact + attribution)
**Fact:** The 21 April 2024 open letter (`save-nix-together.org`) demanded
Dolstra's resignation and drew 100+ signatures; multiple maintainers/moderators
resigned in the surrounding weeks (per LWN). Dolstra **did step down from the
Foundation board** (announced 30 April / 1 May 2024).
**Opinion/defense (Dolstra, attributed):** he characterized himself as "just
one member of the five-member Nix team." The remaining board distanced itself
from his uncoordinated response (per LWN).
- Sources: [LWN, 29 Apr 2024](https://lwn.net/Articles/970824/);
  [LWN, 1 May 2024](https://lwn.net/Articles/971973/);
  [Board statement, Discourse](https://discourse.nixos.org/t/nixos-foundation-board-giving-power-to-the-community/44552).

### Outcomes (fact)
1. **Dolstra off the board** (2024).
2. **Constitutional assembly** appointed (16 May 2024) → **Nix Governance
   Constitution** + elected **Steering Committee** (elections in 2024 & 2025).
3. **Lix fork** launched independently (public May 2024; first release 2.90 on
   10 July 2024), explicitly community-governed and outside the Foundation.
- Sources: [Governance | Nix & NixOS](https://nixos.org/governance/);
  [Constitutional assembly appointment](https://discourse.nixos.org/t/nixos-foundation-board-constitutional-assembly-appointment/45504);
  [Lix 2.90 release](https://lix.systems/blog/2024-07-10-lix-2.90-release/).

### Separating fact from opinion (summary)
- **Established facts:** the sequence of public events (Anduril sponsorship
  accepted/dropped; open letter published; resignations occurring; Dolstra
  leaving the board; assembly + Lix formed) is documented by official
  statements and reputable press.
- **Contested / attributed:** characterizations of Dolstra's *intent* and
  whether he "strong-armed" governance bodies are **allegations by the open
  letter's authors** (reported by LWN), countered by **Dolstra's own framing**.
  This document does not adjudicate between them.

---

## Could not verify (flagged per project rules)

- **Could not verify: exact thesis date.** researchr lists **January 2006**
  (publication); the official NixOS blog gives the **defense date as 18 Feb
  2006**. Both cited; not reconciled to a single canonical "thesis date."
- **Could not verify: NixOS 13.10 exact release date.** The primary blog
  announcement is dated **1 December 2013**; the "13.10" version label and a
  secondary "Aardvark / 2013-10-31" reference imply October. Primary blog date
  used.
- **Could not verify: NixOS Foundation exact incorporation date.** Year **2015**
  is from Wikipedia; legal existence confirmed via OpenCorporates, but the
  precise registration date was not pinned to a primary source.
- **Could not verify: the open letter's full primary text.** Direct fetch of
  `https://save-nix-together.org/` failed (connection refused) at time of
  writing; its contents here are sourced via **LWN's** reporting and quotation.
  Recommend re-fetching the primary letter and the web.archive.org snapshot to
  confirm authorship/signature count and exact wording.
- **Could not verify: "SnowflakeOS" connection** to the Anduril/defense
  controversy. No reliable source linking SnowflakeOS to this dispute was
  found. The Anduril controversy concerns **NixCon sponsorship**, not
  SnowflakeOS.
- **Could not verify: the "2003" origin year** as a primary-sourced fact (it is
  reported by Wikipedia; the authoritative artifact is the 2006 thesis).
- **Could not verify (process claim): RFC 49 / Flakes "merged without formal
  acceptance."** Reported by community/secondary sources; flagged as attributed,
  not independently confirmed.
- **Could not verify: exact resignation counts** ("24 maintainers left," etc.)
  are **LWN's reporting**, not independently re-counted here.
