# CFEngine: A Chronological History (Oslo, 1993 → Northern.tech)

A dated, source-cited history of CFEngine — created by **Mark Burgess** at the
**University of Oslo in 1993** and widely regarded as the first major
configuration-management / "configuration-as-code" tool, predating Puppet,
Chef, SaltStack, and Ansible. Emphasis on its academic roots, **Promise
Theory**, the **CFEngine 3** rewrite, the founding and evolution of the company,
Burgess's departure, and current ownership under **Northern.tech**.

Every factual claim below is followed by an inline source URL. Where a specific
claim could not be confirmed against a primary or reputable secondary source,
it is flagged with **"Could not verify."**

> Note on sourcing: Reported claims (community statements, quotes, opinions) are
> attributed to their speaker/outlet and kept distinct from established facts
> (dates, releases, license terms). Several biographical/origin details come
> from Mark Burgess's own writing (his website and Medium blog); these are
> attributed to him as the source rather than treated as neutral third-party
> fact.

---

## 1. Academic origins (1991–1998)

- **January 1991 — Burgess arrives in Norway.** Mark Burgess (b. 19 February
  1966, Maghull, UK; PhD in theoretical physics / quantum field theory from the
  University of Newcastle upon Tyne) arrived in Norway on a Royal Society
  postdoctoral fellowship, invited by Professor Finn Ravndal at the University
  of Oslo.
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)),
  [markburgess.org/bio.html](http://markburgess.org/bio.html))

- **1993 — CFEngine created at the University of Oslo.** As a Royal Society
  postdoctoral fellow, Burgess wrote CFEngine in 1993 at the University of
  Oslo's physics department, after discussions with the department's system
  administrator about the complexity of the shell and Perl scripts used to
  automate roughly fifty servers across many incompatible Unix variants (SunOS,
  HP-UX, AIX, OSF1, Ultrix). The goal was to replace fragile, per-platform
  scripting full of "exception logic."
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [Mark Burgess, "CFEngine's Star Trek and AI origins," Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

  > **First-mover claim.** CFEngine (1993) predates Puppet (development from
  > 2005), Chef (2009), SaltStack (2011), and Ansible (2012). This makes it the
  > earliest of the major configuration-management tools. Puppet's own author
  > acknowledges starting from CFEngine (see §5).
  > ([Vertical Sysadmin: "Relative Origin of Cfengine, Puppet and Chef"](https://web.archive.org/web/2id_/http://verticalsysadmin.com/blog/relative-origins-of-cfengine-chef-and-puppet/))

- **AI / immune-system motivation (per Burgess).** Burgess describes CFEngine's
  design as inspired by biological self-regulation — the immune system, "swarm
  intelligence," and (by his own account) the Star Trek idea of a computer that
  could run a "diagnostic" and heal itself. He cites Polly Matzinger's "Danger
  Model" of immunology as an influence on the self-healing concept.
  ([Mark Burgess, "CFEngine's Star Trek and AI origins," Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

- **Early publication / first presentation.** CFEngine was first published as an
  internal report and presented at a CERN-related computing conference. Burgess's
  own bio page states he presented it at the **HEPiX conference in Paris**; the
  Wikipedia article refers more generally to a CERN computing conference.
  ([markburgess.org/bio.html](http://markburgess.org/bio.html),
  [Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))
  - **Could not verify:** the exact year and name of that first conference
    presentation (HEPiX Paris vs. a CERN computing conference) — sources differ
    on the venue and do not give a precise date. Added to follow-up.

- **1994 — Registered as free software (GPL).** Burgess registered CFEngine with
  the Free Software Foundation under the GNU General Public License in 1994.
  ([markburgess.org/bio.html](http://markburgess.org/bio.html),
  [Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))

- **1994–2011 — Academic appointment.** After his postdoc, Burgess stayed in
  Oslo and took a lecturing job, becoming senior lecturer and then **Professor
  of Network and System Administration at Oslo University College** — described
  as the first professor with that title. (Wikipedia/his bio give the
  professorship as 2005–2011; he resigned the chair in 2011.)
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)),
  [markburgess.org/bio.html](http://markburgess.org/bio.html))

- **1998 — "Computer Immunology."** Burgess presented "Computer Immunology" at
  the USENIX/LISA98 conference, outlining a vision for self-healing systems that
  informed CFEngine's later direction.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))

---

## 2. CFEngine 2 (1998–2004)

- **CFEngine 2 (developed ~1998–2004).** During the rise of Linux, CFEngine 2
  added features including machine learning / anomaly detection and secure
  communications. This is the version that became widely deployed across Unix
  and Linux fleets through the early-to-mid 2000s.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))

---

## 3. Promise Theory (2004–2005, and later)

- **2004 — Promise Theory introduced.** Burgess introduced **Promise Theory**, a
  model of voluntary cooperation between autonomous agents, originally in the
  context of information science to address problems with obligation-based
  ("you must") logics in policy-based system management. In Promise Theory,
  agents make *promises* about their own behavior rather than being obligated by
  others — a model well-suited to decentralized, convergent configuration.
  ([Wikipedia: Promise theory](https://en.wikipedia.org/wiki/Promise_theory),
  [Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

- **2005 — Formal proposal.** Promise Theory was formally proposed at the
  Distributed Systems, Operations and Management (DSOM) conference in Barcelona.
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

- **2007 / 2014 — Books with Jan Bergstra.** Burgess co-authored a handbook on
  Promise Theory with Jan Bergstra (2007) and later the book *Promise Theory:
  Principles and Applications* (2014). Burgess also published the popular-science
  treatment *Thinking in Promises* (O'Reilly) in 2015.
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

---

## 4. CFEngine 3 and the company (2008–2011)

- **2008 — CFEngine 3, the major rewrite.** After more than five years of
  research, **CFEngine 3** was introduced in 2008 — the most significant rewrite
  of the project to date. It built Promise Theory directly into the language
  (Burgess describing it as a way to make CFEngine "both simpler and more
  powerful at the same time") and added knowledge-management and discovery
  mechanisms aimed at enterprise-scale automation.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [InfoQ: "CFEngine's Decentralized Approach to Configuration Management"](https://www.infoq.com/articles/cfengine-view-on-it-automation/))
  - **Note on year:** Sources cite the CFEngine 3 effort and launch around
    2008, with stabilization through 2008–2009 (early 3.0.x betas appear in the
    CFEngine docs archive). The "2008/2009 rewrite" framing is consistent across
    sources.
    ([CFEngine reference manual, version 3.0.1b4 (archive)](https://docs.cfengine.com/docs/archive.bak/cf-manuals/bup/cf3-reference.html))

- **June 2008 — CFEngine AS founded.** The company **CFEngine AS** was formed in
  June 2008 in Oslo, Norway, as a collaboration between Mark Burgess, Oslo
  University College, and the Oslo Innovation Centre, to support users of
  CFEngine.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))

  > **Burgess's stated motivation (his account):** "In 2007, once again
  > disillusioned with changing politicization and bureaucratization of
  > research… he turned to the success of CFEngine and its appreciative users
  > and decided to form a company to finance future work in the area." Burgess
  > also frames the company partly as a response to Puppet's emergence.
  > ([markburgess.org/bio.html](http://markburgess.org/bio.html),
  > [Mark Burgess, Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

- **2009 — Leave of absence.** Burgess took a leave of absence from his
  university position in 2009 to work full-time with CFEngine users and bring
  research into the software.
  ([markburgess.org/bio.html](http://markburgess.org/bio.html))

- **April 2009 — CFEngine Enterprise launched.** The first commercial version,
  **CFEngine Enterprise** (commercial counterpart to the GPL open-source
  engine), launched in April 2009, with a free tier available for up to 25
  agents.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))

- **February 2011 — Series A funding.** CFEngine received Series A funding from
  **FERD Capital** in February 2011.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))
  - **Could not verify:** the dollar/NOK amount of the FERD round — not stated
    in the sources found.

---

## 5. Influence on later tools: Puppet, Chef, and the lineage

- **Puppet (2005) grew directly out of CFEngine frustration.** Luke Kanies, a
  power CFEngine 2 user, created Puppet out of dissatisfaction with CFEngine 2
  and with Burgess's management of the project. Kanies has described being
  frustrated that CFEngine "still seemed to be too hard," that no one was
  sharing CFEngine code, and that the project's development was "very closed" —
  difficult to contribute to beyond bug fixes. He founded **Reductive Labs** in
  2005 and released Puppet.
  ([Vertical Sysadmin: "Relative Origin of Cfengine, Puppet and Chef"](https://web.archive.org/web/2id_/http://verticalsysadmin.com/blog/relative-origins-of-cfengine-chef-and-puppet/),
  [Open Source Underdogs, Ep. 22: Luke Kanies / Puppet](https://opensourceunderdogs.com/episode-22-puppet-devops-security-and-cloud-automation-with-luke-kanies/),
  [AkitaOnRails: "Chatting with Luke Kanies" (2009)](https://www.akitaonrails.com/2009/11/18/chatting-with-luke-kaines))

  > **Attribution / controversy.** The characterization of Puppet as born from
  > "dissatisfaction with Cfengine 2 and Mark's management of the project" is
  > stated by Aleksey Tsalolikhin (a configuration-management practitioner) on
  > the Vertical Sysadmin blog, and the "too hard / closed development"
  > complaints are Kanies's own as reported in the AkitaOnRails interview. These
  > are opinions/recollections, not neutral fact.
  > ([Vertical Sysadmin](https://web.archive.org/web/2id_/http://verticalsysadmin.com/blog/relative-origins-of-cfengine-chef-and-puppet/),
  > [AkitaOnRails (2009)](https://www.akitaonrails.com/2009/11/18/chatting-with-luke-kaines))

  > **Burgess's side.** Burgess writes that after Puppet and Chef arrived, "Many
  > users went over to using Puppet and Chef… as it was the latest thing," and
  > that he "started to receive abuse online from Puppet users." He also recounts
  > having met Kanies cordially at LISA 2001 (where Burgess was conference
  > chair).
  > ([Mark Burgess, Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

- **Chef (2009) continued the lineage.** Chef was created by Adam Jacob, a power
  Puppet user, out of dissatisfaction with aspects of Puppet — placing CFEngine
  at the root of the CFEngine → Puppet → Chef configuration-management lineage.
  ([Vertical Sysadmin: "Relative Origin of Cfengine, Puppet and Chef"](https://web.archive.org/web/2id_/http://verticalsysadmin.com/blog/relative-origins-of-cfengine-chef-and-puppet/))

---

## 6. Burgess's departure (2014) and later work

- **2014 — Burgess leaves the CFEngine company.** By his own account, Burgess
  decided to move on from the company in 2014, after what he describes as "a
  rough ride with internal struggles and venture capital skullduggery." He
  states that after the company took on venture funding, the "newly imposed
  management removed the knowledge-related and AI-related parts of CFEngine."
  ([Mark Burgess, "CFEngine's Star Trek and AI origins," Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

  > **Date note / discrepancy with the brief.** The research brief asked to
  > verify a **~2015** departure "to focus on writing/research." The best
  > primary source — Burgess's own essay — gives **2014** as the year he decided
  > to move on from the company. His departure from the company is distinct from
  > his earlier **2011** resignation of the Oslo University College
  > professorship. 2015 is the year his book *Thinking in Promises* was
  > published, which may be the source of the "~2015" association. The
  > documented company-departure year is **2014** (per Burgess).
  > ([Mark Burgess, Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b),
  > [Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))
  - **Could not verify:** a precise day/month for the 2014 departure, or an
    official company press statement about it — sources give only the year, from
    Burgess's narrative.

- **2018 — Aljabr and ChiTek-i.** Burgess co-founded **Aljabr Inc.** in 2018
  (with Joseph Jacks and Petar Maymounkov) and founded **ChiTek-i** in 2018. He
  describes himself as an independent researcher and writer.
  ([markburgess.org/bio.html](http://markburgess.org/bio.html),
  [Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

- **Emeritus.** Burgess is Emeritus Professor of Network and System
  Administration (Oslo University College / OsloMet).
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

---

## 7. Northern.tech era (2015–present)

- **2015 — Mender launched.** Northern.tech (then still CFEngine AS) released the
  first version of **Mender.io**, an over-the-air (OTA) software-update solution
  for embedded/IoT devices — a second product line alongside CFEngine.
  ([Northern.tech — company background, via search](https://northern.tech/),
  [Northern.tech blog: "Welcome to Northern.tech"](https://northern.tech/blog/welcome-to-northern-tech))

- **1 July 2017 — CFEngine AS rebrands to Northern.tech.** On 1 July 2017, CEO
  **Thomas Ryd** announced the new corporate name **Northern.tech**, "the company
  behind CFEngine.com… and Mender.io," reflecting that the company now worked on
  multiple software products, not only CFEngine. The existing products kept
  their own brands.
  ([Northern.tech blog: "Welcome to Northern.tech"](https://northern.tech/blog/welcome-to-northern-tech),
  [Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))

- **Ownership clarification.** Northern.tech did **not** acquire CFEngine or
  Mender from third parties — it is the same legal/corporate entity (Norway:
  Northern.tech AS) that developed CFEngine (as CFEngine AS, founded 2008) and
  built Mender in-house (2015), then rebranded in 2017. So "Northern.tech owns
  CFEngine and Mender" is correct in the sense that both are first-party products
  of the same company; it is **not** an acquisition story.
  ([Northern.tech blog: "Welcome to Northern.tech"](https://northern.tech/blog/welcome-to-northern-tech),
  [Northern.tech — Products](https://northern.tech/products),
  [Crunchbase: Northern.tech](https://www.crunchbase.com/organization/northern-tech))

- **Current product portfolio.** Northern.tech today markets **Mender** (OTA
  updates for connected devices), **CFEngine** (server configuration management
  and large-scale compliance automation), and **Alvaldi** (secure remote
  troubleshooting of IoT devices). It cites users including Microsoft Azure,
  Nike, Siemens, LinkedIn, Deutsche Telekom, and Panasonic.
  ([Northern.tech — Products](https://northern.tech/products))

---

## 8. Current status and relevance (2024–2026)

- **Licensing.** CFEngine remains dual-track: an open-source **GPL** community
  edition (the engine has been GPLv3) plus the commercial **CFEngine
  Enterprise**.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine),
  [HandWiki: CFEngine](https://handwiki.org/wiki/CFEngine))

- **Active releases.** CFEngine continues to ship. Wikipedia records stable
  releases including 3.27.1 and a 3.24.4 LTS-style line dated 8 May 2026 (and
  earlier, 3.23.0 / 3.21.4 / 3.18.7 from January 2024), indicating the project
  is still actively maintained with parallel current and long-term-support
  branches.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))
  - **Could not verify:** the precise current "latest" version number at time of
    writing beyond what Wikipedia's infobox states (the infobox is the only
    source consulted for the newest 3.27.x / 3.24.x numbers).

- **Scale claims.** CFEngine is reported (by Wikipedia, echoing the company) to
  manage on the order of **one million+ servers** worldwide, and is consistently
  characterized as the pioneer / earliest of the configuration-management tools.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))
  - **Attribution:** the "one million servers" / "pioneer" framing originates
    with the company's own marketing and should be read as a vendor claim.

---

## Key people & teams

- **Mark Burgess** — Creator of CFEngine (1993, University of Oslo); originator
  of **Promise Theory** (2004–2005); founder, chairman, and CTO of the CFEngine
  company (2008); Professor (later Emeritus) of Network and System
  Administration at Oslo University College. Left the company in 2014 to focus
  on writing and independent research; later co-founded Aljabr (2018) and founded
  ChiTek-i (2018).
  ([markburgess.org/bio.html](http://markburgess.org/bio.html),
  [Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)),
  [Mark Burgess, Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b))

- **Thomas Ryd** — Co-founder of CFEngine AS / CFEngine, Inc. (from 2008) and its
  leader; co-founder and CEO of Northern.tech; announced the 2017 rebrand.
  Previously a programmer at Telenor and Incubator Manager at the Oslo Innovation
  Center.
  ([Northern.tech blog: "Welcome to Northern.tech"](https://northern.tech/blog/welcome-to-northern-tech),
  [Crunchbase: Thomas Ryd](https://www.crunchbase.com/person/thomas-ryd))

- **Jan Bergstra** — Co-author with Burgess of Promise Theory works (2007
  handbook; 2014 *Promise Theory: Principles and Applications*).
  ([Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)))

- **Institutional partners at founding** — Oslo University College and the Oslo
  Innovation Centre (Oslo Innovation Center) co-formed CFEngine AS with Burgess
  in 2008.
  ([Wikipedia: CFEngine](https://en.wikipedia.org/wiki/CFEngine))

- **In the broader lineage** — **Luke Kanies** (Puppet / Reductive Labs, 2005)
  and **Adam Jacob** (Chef, 2009), both downstream of CFEngine. (See §5.)
  ([Vertical Sysadmin](https://web.archive.org/web/2id_/http://verticalsysadmin.com/blog/relative-origins-of-cfengine-chef-and-puppet/))

---

## Company & corporate history

| Date | Event | Source |
|------|-------|--------|
| 1993 | CFEngine created at University of Oslo (Mark Burgess) | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| 1994 | Registered with FSF under the GNU GPL | [markburgess.org](http://markburgess.org/bio.html) |
| ~1998–2004 | CFEngine 2 era | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| 2004–2005 | Promise Theory introduced / formally proposed | [Wikipedia: Promise theory](https://en.wikipedia.org/wiki/Promise_theory) |
| 2008 | CFEngine 3 (major rewrite, Promise-Theory-based) | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| June 2008 | **CFEngine AS** founded (Oslo, Norway) | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| April 2009 | CFEngine Enterprise (commercial) launched | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| Feb 2011 | Series A funding from FERD Capital | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |
| 2011 | Burgess resigns Oslo University College professorship | [Wikipedia: Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist)) |
| 2014 | Burgess leaves the company (per his account) | [Mark Burgess, Medium](https://mark-burgess-oslo-mb.medium.com/cfengines-star-trek-and-ai-origins-e99096fe845b) |
| 2015 | Mender.io launched (second product line) | [Northern.tech blog](https://northern.tech/blog/welcome-to-northern-tech) |
| 1 July 2017 | CFEngine AS rebrands to **Northern.tech** | [Northern.tech blog](https://northern.tech/blog/welcome-to-northern-tech) |
| 2024–2026 | CFEngine still actively released (e.g., 3.24.4 dated 8 May 2026) | [Wikipedia](https://en.wikipedia.org/wiki/CFEngine) |

---

## Summary of "Could not verify" items

1. **Exact first-presentation venue/year** — Burgess's bio says HEPiX (Paris);
   Wikipedia says a CERN computing conference. No precise date confirmed.
2. **FERD Capital Series A amount** — funding confirmed (Feb 2011) but no figure
   found.
3. **Precise date and any official statement for Burgess's 2014 departure** —
   year is from Burgess's own essay; no company press release located, and the
   brief's "~2015" appears to conflate it with his 2015 book.
4. **Newest exact version number** — only Wikipedia's infobox (3.27.1 / 3.24.4,
   8 May 2026) consulted; not cross-checked against the CFEngine release notes
   directly.
5. **"One million+ servers" scale** — a vendor/marketing claim repeated by
   Wikipedia, not independently verified.
