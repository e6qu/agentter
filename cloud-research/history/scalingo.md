# Scalingo — A Sourced History

A chronological, fully-sourced history of **Scalingo**, the Strasbourg-based,
git-driven **Platform-as-a-Service (PaaS)** positioned as a **European, sovereignty-focused
alternative to Heroku** — `git push` deployment, Heroku-compatible buildpacks, managed
databases/add-ons, hosted on French sovereign infrastructure (3DS Outscale) with ISO 27001,
HDS, and SecNumCloud credentials.

Every non-trivial claim below carries a working source link. Primary sources (Scalingo's
own blog and press releases, plus Outscale's) are preferred, corroborated by reputable
outlets — much of which is **French-language** (Le Monde Informatique, LeMagIT, Le Journal
des Entreprises, CFNEWS), quoted and translated carefully. Where a detail could not be
confirmed against a primary or reputable secondary source, it is flagged with
**"Could not verify."** This is a smaller, bootstrapped company than Heroku or Platform.sh,
so the record is proportionately thinner; gaps are flagged rather than padded.

---

## Timeline

### Origins: Novelys and "AppsDeck" (2005–2014)

- **Founders' background — Novelys (Strasbourg, Ruby on Rails).** Before Scalingo, **Yann
  Klis** ran **Novelys**, a Strasbourg web-development services firm working with web
  startups/entrepreneurs; he also taught web development, Ruby on Rails, and startup topics
  at the **University of Strasbourg** and **ENSIIE**. The future Scalingo team came out of
  this Novelys orbit.
  - Sources: [Yann Klis (Novelys) — Viadeo / Journal du Net](https://viadeo.journaldunet.com/p/yann-klis-24517);
    [Kevin Soltysiak, "Scalingo" project page (ksol.fr)](https://ksol.fr/projects/scalingo/)
    — "I knew Yann (CEO of Scalingo) and Leo (CTO of Scalingo) from my time at Novelys,
    where I have worked with both of them."
  - **Could not verify** an exact founding year for Novelys from a primary source (a
    secondary profile gives 2005; treat as **secondary-sourced**).

- **Development began ≈April 2014.** Work on the Scalingo product (then named **AppsDeck**)
  and its Ember.js dashboard began **at the beginning of April 2014**, per the contractor
  who built the dashboard.
  - Source: [Kevin Soltysiak, "Scalingo" project page (ksol.fr)](https://ksol.fr/projects/scalingo/)
    — "started working with them at the beginning of April 2014."

### "AppsDeck" becomes "Scalingo" and goes commercial (2015)

- **January 18, 2015 — AppsDeck renamed Scalingo.** In a post titled "Appsdeck is now
  Scalingo," the company announced it was **officially renamed from Appsdeck to Scalingo**,
  moving from the **`appsdeck.eu`** domain to **`scalingo.io`** (old URLs kept until June
  2015 during the transition).
  - Source: [Scalingo blog, "Appsdeck is now Scalingo" (Jan 18, 2015)](https://scalingo.com/blog/appsdeck-is-now-scalingo)
  - **Could not verify** a stated *reason* for the rename — the post announces it without
    explaining the motivation.

- **Founded 2015 in Strasbourg by Yann Klis and Léo Unbekandt.** Scalingo is consistently
  dated to **2015**, founded in **Strasbourg (Grand Est / Alsace)** by **Yann Klis**
  (co-founder & CEO) and **Léo Unbekandt** (co-founder & CTO).
  - Sources: [Scalingo, "About"](https://scalingo.com/about);
    [Le Journal des Entreprises, "Scalingo … lève 3,5 millions" (2024)](https://www.lejournaldesentreprises.com/article/scalingo-la-plateforme-dhebergement-cloud-alsacienne-annonce-une-levee-de-fonds-de-35-millions-2100299);
    [CFNEWS, "Scalingo héberge une série A" (Jul 11, 2024)](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537)
    — "Yann Klis and Leo Unbekandt established the company in 2015."
  - **Note on founders / a possible third co-founder:** Some secondary aggregators list a
    third co-founder, **Jean-Christophe Gay**, alongside Klis and Unbekandt; other profiles
    list Gay as **VP Sales** rather than co-founder.
    - Sources: [MyFrenchStartup — Scalingo](https://www.myfrenchstartup.com/fr/startup-france/120745/scalingo);
      [Jean-Christophe Gay, VP Sales, Scalingo — Topio Networks](https://www.topionetworks.com/people/jean-christophe-gay-563d942cb289a8dc5600078d)
    - **Could not verify** Jean-Christophe Gay's co-founder status from a primary source; the
      two consistently-sourced founders are **Klis (CEO)** and **Unbekandt (CTO)**. Treat the
      "third co-founder" as **secondary/uncertain**.
  - **Note on "founded year":** as with many startups there's mild ambiguity — development
    started in 2014 (as AppsDeck) and the company is dated to 2015 (rename / commercial
    phase). Treat 2015 as the standard "founded" year.

### The product: Heroku-style PaaS, European edition

Scalingo's pitch is to reproduce **the Heroku developer experience** — push code with git,
let the platform build and run it — while keeping data in Europe under European/French law.

- **`git push` deployment + Heroku-compatible buildpacks.** Deployment is via
  `git push scalingo master`; Scalingo is **fully compatible with Heroku's buildpacks**, so
  apps that run on Heroku run on Scalingo, with migrations commonly described as taking
  "under five minutes" with no code/config changes. Supported runtimes include Ruby on
  Rails, PHP, Node.js, Python, Java, and Go.
  - Sources: [Scalingo blog, "Scalingo, meilleure alternative européenne à Heroku"](https://scalingo.com/blog/scalingo-alternative-heroku);
    [Scalingo, "About"](https://scalingo.com/about)
  - **Attribution/caveat:** "If your code works on Heroku, it will work on Scalingo" and the
    "under five minutes" migration figure are **Scalingo's own marketing claims**, not
    independently benchmarked here.

- **Container/Docker-based architecture; managed databases as add-ons.** Scalingo is a
  **container-based (Docker) PaaS**; it offers managed databases — PostgreSQL, MySQL,
  MongoDB, Redis, Elasticsearch/OpenSearch, InfluxDB — as add-ons.
  - Sources: [LeMagIT, "Scalingo sur Outscale : tout sur le PaaS français « à la Heroku »" (Jun 2, 2023)](https://www.lemagit.fr/actualites/365535469/Scalingo-sur-Outscale-tout-sur-le-PaaS-francais-a-la-Heroku);
    [Scalingo, "About"](https://scalingo.com/about)
  - CEO **Yann Klis**, on the deliberate Heroku-standard alignment (paraphrased/translated
    from LeMagIT): the company adopted "certain de facto standards … those that make sense
    for customers" — i.e., Heroku-inspired API and conventions.
    - Source: [LeMagIT (Jun 2, 2023)](https://www.lemagit.fr/actualites/365535469/Scalingo-sur-Outscale-tout-sur-le-PaaS-francais-a-la-Heroku)

### The sovereignty pivot: moving onto 3DS Outscale (2019)

- **July 1, 2019 — Scalingo opens its `osc-fr1` region on 3DS Outscale (Paris).** Scalingo
  announced a new **Paris region built on 3DS Outscale** (Dassault Systèmes' cloud
  subsidiary), becoming — per its own framing — the **first containerized PaaS available on
  3DS Outscale**. The prior infrastructure was **Agora Calycé** (the `agora-fr1` region),
  which remained available to existing customers. Authentication/billing were centralized in
  Paris under GDPR, with each region run as an isolated, independent unit.
  - Source: [Scalingo blog, "Scalingo is now available on 3DS Outscale Paris" (Jul 1, 2019)](https://scalingo.com/blog/new-osc-fr1-region)

- **The sovereignty rationale (Outscale press release).** A corresponding announcement framed
  the move around **data sovereignty** — citing "business secrets, economic intelligence,
  American protectionism" as reasons French companies wanted French-hosted cloud — and chose
  **3DS Outscale** (ISO 27001 / 27017 / 27018 certified) as a French "pure player" IaaS.
  - Sources: [Scalingo press release, "Scalingo renforce la souveraineté de sa plateforme cloud en s'appuyant sur 3DS OUTSCALE" (Jul 1, 2019)](https://scalingo.com/fr/press-releases/20190701-outscale);
    [3DS Outscale press release, "Scalingo s'appuie sur le Cloud de 3DS OUTSCALE …"](https://fr.outscale.com/communiques-de-presse/archives/scalingo-sappuie-sur-le-cloud-de-3ds-outscale-pour-offrir-fiabilite-et-securite/)
  - **Caveat:** the Scalingo `/fr/press-releases/20190701-outscale` URL now resolves to the
    press hub (which surfaces only the most recent releases to automated fetching); the
    release's existence, date, and content are corroborated by the Outscale press release and
    search indexing.

### Public-sector reach: UGAP referencing (January 2020)

- **January 2020 — Scalingo referenced on UGAP.** Scalingo announced its solutions became
  available via **UGAP** (the French public-procurement central purchasing body), easing
  adoption by French public-sector buyers.
  - Source: [Scalingo press release, "Les solutions de Scalingo maintenant disponibles à l'UGAP" (Jan 15, 2020)](https://web.archive.org/web/2id_/https://scalingo.com/fr/press-releases/20200115-scalingo-reference-ugap)
  - **Could not verify** the precise day from the live page (press-hub redirect issue, as
    above); the URL slug encodes **2020-01-15** and the "January 2020" timing is consistent
    across Scalingo's press listing.

### SecNumCloud region: first PaaS in a SecNumCloud datacenter (June 2020)

- **June 23, 2020 — Scalingo becomes the first PaaS to host apps/data in a SecNumCloud
  datacenter.** Scalingo announced it was the **"1er PaaS"** to offer hosting of applications
  and data in a **datacenter compliant with the SecNumCloud framework** (ANSSI, the French
  national cybersecurity agency), via 3DS Outscale's SecNumCloud-qualified IaaS — the
  `osc-secnum-fr1` region. The transport authority **Île-de-France Mobilités** is cited as an
  early user of this offering.
  - Source: [Scalingo press release, "Scalingo devient le 1er PaaS à proposer l'hébergement … dans un datacentre conforme au référentiel SecNumCloud" (Jun 23, 2020)](https://scalingo.com/fr/press-releases/20200623-secnumcloud)
  - **Important distinction (the platform vs the datacenter):** This milestone is about
    Scalingo **running on SecNumCloud-qualified IaaS (Outscale's `osc-secnum-fr1`)** — it is
    **not** the same as **Scalingo's own PaaS layer being SecNumCloud-qualified**. As of the
    most recent sources, Scalingo's **own** SecNumCloud qualification was still **in
    progress** (see below).
    - Sources: [Scalingo blog, "SecNumCloud Qualification (ANSSI): Complete Guide"](https://scalingo.com/blog/secnumcloud-qualification-anssi-guide)
      — "our provider, Outscale, already provides us access to an Infrastructure as a Service
      (IaaS) that is already SecNumCloud-qualified … customers [can] deploy on the
      SecNumCloud-compliant `osc-secnum-fr1` region," while "our teams are actively working on
      preparing our application … we can't pinpoint a specific date for now";
      [Scalingo, "SecNumCloud Qualification" product page](https://scalingo.com/qualification-secnumcloud)

### ISO 27001 and HDS certifications (2022–2023)

- **October 4, 2022 — ISO 27001 and HDS certified.** Scalingo announced **ISO 27001** and
  **HDS** (*Hébergeur de Données de Santé* — French health-data hosting) certifications for
  its PaaS, positioning itself (per its own framing) as among the first French/European PaaS
  to hold both.
  - Sources: [Scalingo press releases hub](https://scalingo.com/press-releases)
    (listing the **Oct 4, 2022** ISO 27001 / HDS certification release);
    [Scalingo blog, "Scalingo maintains ISO 27001 and HDS certifications! Next step: SecNumCloud"](https://scalingo.com/blog/scalingo-iso27001-hds-certifications-next-secnumcloud)

- **September 12, 2023 — certifications maintained; UGAP Cloud integration.** Scalingo
  re-confirmed its ISO 27001 / HDS certifications and announced UGAP Cloud integration.
  - Source: [Scalingo press releases hub](https://scalingo.com/press-releases)
    (listing the **Sep 12, 2023** release).
  - **Could not verify** the full body text of the 2022/2023 certification releases via
    automated fetching (the hub surfaces headlines + dates and links out); the dates above
    are read from the press hub listing.

### Series A: €3.5M and the end of pure bootstrapping (July 2024)

- **July 11, 2024 — €3.5M Series A; first external round after years of self-financing.**
  Scalingo raised **€3.5 million** in a round labeled **Series A** ("1er tour" / first
  round) from **Side Angels**, the **CAJUBA** investor community, **NEO Founders**,
  **Bpifrance**, **Caisse d'Épargne**, and **BNP Paribas**. CFNEWS notes the company had
  **until then been financed from its own funds** ("Jusque-là financée sur fonds propres").
  - Sources: [Scalingo press release, "Scalingo … secures €3.5 Million to accelerate growth" (Jul 11, 2024)](https://scalingo.com/press-releases/scalingo-fundraising-announcement-2024);
    [CFNEWS, "Scalingo héberge une série A" (Jul 11, 2024)](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537);
    [Le Monde Informatique, "PaaS : le strasbourgeois Scalingo lève 3,5 M€"](https://www.lemondeinformatique.fr/actualites/lire-paas-le-strasbourgeois-scalingo-leve-3-5-meteuro-94261.html);
    [Le Journal des Entreprises (2024)](https://www.lejournaldesentreprises.com/article/scalingo-la-plateforme-dhebergement-cloud-alsacienne-annonce-une-levee-de-fonds-de-35-millions-2100299)
  - **On "bootstrapped / profitable":** That Scalingo was **self-financed ("sur fonds
    propres")** until this 2024 round is sourced directly to **CFNEWS**. A specific claim that
    it was also **profitable/rentable** prior to the round appears in secondary
    summaries/community write-ups but was **not** confirmed in a primary or named reputable
    source in this pass — **Could not verify: Scalingo's pre-2024 profitability.** Likewise no
    revenue figure was disclosed in any source reviewed.
  - **Stated metrics at the round:** ~**35 employees** (targeting ~**70 by 2026**, ~15 hires
    in 2024); **35,000+ developers**; **1,000+ clients** (~70% French, ~30% international).
    - Sources: [Le Journal des Entreprises (2024)](https://www.lejournaldesentreprises.com/article/scalingo-la-plateforme-dhebergement-cloud-alsacienne-annonce-une-levee-de-fonds-de-35-millions-2100299);
      [Le Monde Informatique](https://www.lemondeinformatique.fr/actualites/lire-paas-le-strasbourgeois-scalingo-leve-3-5-meteuro-94261.html)
  - **Use of funds / positioning.** CEO **Yann Klis**: "The time for sovereign cloud solutions
    is now! French and European businesses are ready to assert control over their
    technological destiny, moving away from dominant American solutions towards greater
    sovereignty and security." (Scalingo press release.) Elsewhere Klis tempered the
    sovereignty pitch with product realism (translated from LeMagIT/Le Monde Informatique):
    *"Être souverain c'est bien mais pas suffisant, il faut une surface fonctionnelle et de
    l'expérience"* — "Being sovereign is good but not enough; you need functional breadth and
    experience."
    - Sources: [Scalingo press release (Jul 11, 2024)](https://scalingo.com/press-releases/scalingo-fundraising-announcement-2024);
      [Le Monde Informatique](https://www.lemondeinformatique.fr/actualites/lire-paas-le-strasbourgeois-scalingo-leve-3-5-meteuro-94261.html)

### Heroku's free-tier exit as tailwind (2022 onward)

- **Migration positioning.** Scalingo actively courts Heroku refugees with migration guides
  ("De Heroku à Scalingo," "Comment Scalingo facilite la migration depuis Heroku") and an
  explicit "European alternative to Heroku" pitch — leaning on Heroku-buildpack compatibility.
  This positioning sharpened around Heroku's end of free plans (Nov 2022).
  - Sources: [Scalingo blog, "Scalingo, meilleure alternative européenne à Heroku"](https://scalingo.com/blog/scalingo-alternative-heroku);
    [Scalingo blog, "De Heroku à Scalingo : migrez vers un PaaS européen"](https://scalingo.com/fr/blog/migration-heroku-scalingo-paas-europeen);
    [LeMagIT (Jun 2, 2023)](https://www.lemagit.fr/actualites/365535469/Scalingo-sur-Outscale-tout-sur-le-PaaS-francais-a-la-Heroku)
  - **Caveat:** the strength of any Heroku-exit "exodus" benefit to Scalingo specifically is a
    **marketing/narrative framing**, not a quantified, independently verified migration figure.

### Current footprint (regions)

- **Regions (via 3DS Outscale).** Scalingo's production regions run on **3DS Outscale**:
  **`osc-fr1`** (Paris; ISO 27001 + HDS) and **`osc-secnum-fr1`** (Paris; ISO 27001 + HDS +
  **SecNumCloud-qualified IaaS**). Additional regions (US East/New York, US West/San
  Francisco, Asia/Tokyo) are listed as available on demand.
  - Source: [Scalingo, "Datacenters / Regions"](https://scalingo.com/datacenters)

---

## Key people & teams

- **Yann Klis** — **co-founder and CEO** (President). Strasbourg-based; previously ran the web
  agency **Novelys** and taught Ruby on Rails / web development at the University of Strasbourg
  and ENSIIE. The public face of Scalingo's funding and sovereignty messaging.
  - Sources: [Scalingo, "About"](https://scalingo.com/about);
    [Yann Klis (Novelys) — Viadeo / JDN](https://viadeo.journaldunet.com/p/yann-klis-24517);
    [CFNEWS (Jul 11, 2024)](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537)

- **Léo Unbekandt** — **co-founder and CTO**; builds Scalingo's software infrastructure.
  (Online handle "soulou.")
  - Sources: [Léo Unbekandt — Co-founder & CTO @ Scalingo (YouTube)](https://www.youtube.com/watch?v=yhawaTwJoPo);
    [Léo Unbekandt — Crunchbase](https://www.crunchbase.com/person/l%C3%A9o-unbekandt)

- **Jean-Christophe Gay** — listed by some sources as a third **co-founder**, by others as
  **VP Sales**. Role/standing **uncertain** (see founders note above).
  - Sources: [MyFrenchStartup — Scalingo](https://www.myfrenchstartup.com/fr/startup-france/120745/scalingo);
    [Jean-Christophe Gay, VP Sales, Scalingo — Topio Networks](https://www.topionetworks.com/people/jean-christophe-gay-563d942cb289a8dc5600078d)

---

## Company & corporate history

- **≈2005** — Yann Klis runs **Novelys** (Strasbourg Ruby/Rails web agency); future Scalingo
  team forms here.
  [Viadeo/JDN](https://viadeo.journaldunet.com/p/yann-klis-24517) ·
  [ksol.fr](https://ksol.fr/projects/scalingo/) *(Novelys founding year secondary-sourced)*
- **April 2014** — Development of the product (as **AppsDeck**) begins.
  [ksol.fr](https://ksol.fr/projects/scalingo/)
- **January 18, 2015** — **AppsDeck renamed Scalingo** (`appsdeck.eu` → `scalingo.io`);
  company dated to 2015, Strasbourg, founders **Yann Klis (CEO)** and **Léo Unbekandt (CTO)**.
  [Scalingo blog](https://scalingo.com/blog/appsdeck-is-now-scalingo) ·
  [CFNEWS](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537)
- **July 1, 2019** — Opens **`osc-fr1`** on **3DS Outscale** (sovereignty pivot; prior infra
  was Agora Calycé).
  [Scalingo blog](https://scalingo.com/blog/new-osc-fr1-region) ·
  [Outscale press release](https://fr.outscale.com/communiques-de-presse/archives/scalingo-sappuie-sur-le-cloud-de-3ds-outscale-pour-offrir-fiabilite-et-securite/)
- **January 15, 2020** — Solutions referenced on **UGAP** (public procurement).
  [Scalingo press release](https://web.archive.org/web/2id_/https://scalingo.com/fr/press-releases/20200115-scalingo-reference-ugap)
- **June 23, 2020** — First PaaS to host in a **SecNumCloud-compliant datacenter** (via
  Outscale `osc-secnum-fr1`).
  [Scalingo press release](https://scalingo.com/fr/press-releases/20200623-secnumcloud)
- **October 4, 2022** — **ISO 27001** and **HDS** certified.
  [Scalingo press hub](https://scalingo.com/press-releases)
- **September 12, 2023** — Certifications maintained; UGAP Cloud integration.
  [Scalingo press hub](https://scalingo.com/press-releases)
- **July 11, 2024** — **€3.5M Series A** (first external round; previously self-financed) from
  Side Angels, CAJUBA, NEO Founders, Bpifrance, Caisse d'Épargne, BNP Paribas; ~35 staff,
  35,000+ developers, 1,000+ clients.
  [Scalingo press release](https://scalingo.com/press-releases/scalingo-fundraising-announcement-2024) ·
  [CFNEWS](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537)

### Funding (summary)

| Round | Date | Amount | Investors | Sourcing |
|---|---|---|---|---|
| Self-financed | 2015–2024 | — (fonds propres) | Founders | [CFNEWS](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537) |
| Series A | Jul 11, 2024 | €3.5M | Side Angels, CAJUBA, NEO Founders, Bpifrance, Caisse d'Épargne, BNP Paribas | [Scalingo press release](https://scalingo.com/press-releases/scalingo-fundraising-announcement-2024) · [CFNEWS](https://www.cfnews.net/L-actualite/Capital-innovation/Operations/1er-tour/Scalingo-heberge-une-serie-A-492537) (primary + reputable) |

---

## Controversies & characterizations

> Scalingo has a **low-controversy public profile** — no major breach, free-tier-removal, or
> shutdown saga of the kind seen at Heroku. The items below are **characterizations**, with
> fact separated from reported claim.

### 1. "Sovereign cloud" positioning

- **Fact:** Scalingo hosts on **French infrastructure (3DS Outscale / Dassault Systèmes)**,
  holds **ISO 27001 + HDS**, and offers a region on **SecNumCloud-qualified IaaS**.
  [Scalingo datacenters](https://scalingo.com/datacenters) ·
  [Scalingo SecNumCloud page](https://scalingo.com/qualification-secnumcloud)
- **Reported/characterization:** Scalingo markets itself as a **sovereign European
  alternative to American hyperscalers and to Heroku**. CEO Klis himself cautions that
  sovereignty alone is insufficient without product breadth.
  [Scalingo press release (2024)](https://scalingo.com/press-releases/scalingo-fundraising-announcement-2024) ·
  [LeMagIT](https://www.lemagit.fr/actualites/365535469/Scalingo-sur-Outscale-tout-sur-le-PaaS-francais-a-la-Heroku)

### 2. SecNumCloud — platform vs IaaS (a common confusion)

- **Fact:** Scalingo runs on a **SecNumCloud-qualified IaaS** (Outscale) and was the **first
  PaaS to host in a SecNumCloud datacenter (2020)**; its **own PaaS-layer SecNumCloud
  qualification** was still **in progress** as of the latest sources, with **no committed
  date**.
  [Scalingo SecNumCloud guide](https://scalingo.com/blog/secnumcloud-qualification-anssi-guide) ·
  [Scalingo press release (2020)](https://scalingo.com/fr/press-releases/20200623-secnumcloud)
- **Characterization:** Marketing emphasizing "SecNumCloud" should be read with this
  IaaS-vs-PaaS distinction in mind.

### 3. Heroku-compatibility / migration claims

- **Characterization (company marketing):** "If your code works on Heroku, it will work on
  Scalingo" and "migrate in under five minutes" are **Scalingo's positioning**, not
  independently benchmarked here; the underlying mechanism (Heroku-compatible buildpacks +
  `git push` deploys) is documented in first-party material.
  [Scalingo blog](https://scalingo.com/blog/scalingo-alternative-heroku)

---

## Items marked "Could not verify"

- **A stated reason for the 2015 AppsDeck → Scalingo rename** — the rename and date
  (Jan 18, 2015) are sourced; no motivation is given in the post.
- **Jean-Christophe Gay as a co-founder** — listed by aggregators (MyFrenchStartup) but as
  "VP Sales" elsewhere; not confirmed as co-founder by a primary source. The two confidently
  sourced founders are **Klis (CEO)** and **Unbekandt (CTO)**.
- **Scalingo's pre-2024 profitability** — that it was **self-financed ("sur fonds propres")**
  until the 2024 round is sourced (CFNEWS); a specific **profitability/rentability** claim and
  any **revenue figure** were **not** confirmed in primary/named reputable sources here.
- **Full body text and exact days of the 2019 Outscale, 2020 UGAP, and 2022/2023 ISO/HDS
  press releases** — these `scalingo.com` press URLs now redirect to a press **hub** that
  surfaces only recent items to automated fetching; existence, titles, and dates are
  corroborated via the hub listing, URL slugs, and (for Outscale 2019) Outscale's own press
  release and search indexing.
- **Novelys founding year (≈2005)** — secondary-sourced (Viadeo/JDN profile), not a primary
  document.
- **Any quantified "Heroku exodus" benefit to Scalingo** — migration positioning is sourced;
  a quantified migration count is not.
