# Cloudflare and the CDN / Edge Landscape: A Sourced History

A chronological, fully-sourced history of **content delivery networks (CDNs)** and
the **edge** that grew out of them — from Akamai's 1998 MIT origins through
Cloudflare, Fastly, the cloud providers' CDNs, the JAMstack/edge-functions wave,
and the convergence of CDN → edge compute → security → storage into "everything
platforms."

Every non-trivial claim carries an inline source link. Opinions, predictions, and
controversy framings are **attributed to the specific person or outlet** that
made them, and kept separate from fact. Where a detail could not be confirmed
against a primary or reputable secondary source, it is flagged
**Could not verify:**. No quotes are paraphrased as if verbatim.

> **Cross-references (not duplicated here):**
> - Edge-compute runtimes and the "server-side WASM as the next Docker" thread —
>   Cloudflare Workers (V8 isolates), **Fastly Compute@Edge** (Lucet → wasmtime),
>   the Bytecode Alliance, and **Akamai → Fermyon (2025)** — are covered in depth
>   in [`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md).
>   This doc states the product/market facts and points there for the runtime
>   internals.
> - **Cloudflare R2 as an S3-compatible, zero-egress object store** is set in the
>   broader object-storage story in
>   [`s3-object-storage.md`](./s3-object-storage.md). This doc covers R2's launch
>   and positioning; the S3-API-compatibility-as-a-standard story lives there.

---

## Timeline

### 1995 — The problem Akamai was built to solve

Akamai's origin is usually traced to a challenge **Tim Berners-Lee** posed at MIT
in the mid-1990s: find a fundamentally better way to deliver content as the Web's
"flash crowd" traffic problem worsened. MIT applied-math professor **Tom Leighton**
and graduate student **Daniel (Danny) Lewin** worked on consistent-hashing and
distributed-caching algorithms that became the basis of the company.
- Akamai corporate history / FundingUniverse: https://www.fundinguniverse.com/company-histories/akamai-technologies-inc-history/
- MIT Alumni, "MIT Alumnus Daniel Lewin, the First Man to Die on 9/11, Transformed the Internet": https://alum.mit.edu/slice/mit-alumnus-daniel-lewin-first-man-die-911-transformed-internet

### 1998-08-20 — Akamai Technologies founded at MIT

Akamai was founded in 1998 (commonly dated **August 20, 1998**) by **Tom Leighton**
and **Danny Lewin**, joined by co-founders including **Jonathan Seelig**,
**Preetish Nijhawan**, and **Randall Kaplan**.
- FundingUniverse company history: https://www.fundinguniverse.com/company-histories/akamai-technologies-inc-history/
- **Could not verify** the exact August 20, 1998 founding date against a primary
  Akamai/SEC document in this research pass; the year (1998) and the MIT/Leighton/Lewin
  facts are firmly sourced above, and the IPO S-1 (below) confirms the company and
  founders.

### 1999-10-29 — Akamai IPO

Akamai went public on the Nasdaq in 1999. Akamai's own SEC registration documents
from FY1999 are the primary source for the offering.
- SEC, Akamai Form 424B1 (FY1999): https://www.sec.gov/Archives/edgar/data/0001086222/000095013599004929/0000950135-99-004929.txt
- SEC, Akamai Form S-1/A (FY1999): https://www.sec.gov/Archives/edgar/data/0001086222/000095013599004906/0000950135-99-004906.txt
- The widely reported detail that the **Oct 29, 1999** IPO priced at **$26** and
  closed its first day around **$145** is reported by FundingUniverse and
  secondary press; **Could not verify** the exact first-day close against a
  primary filing here. Treat the $26→~$145 pop as reported, not as a primary-sourced fact.

### 2001-09-11 — Danny Lewin killed aboard American Airlines Flight 11

Akamai co-founder and CTO **Danny Lewin** was a passenger on **American Airlines
Flight 11**, the first plane hijacked on September 11, 2001. He is widely
believed to have been the **first victim of the 9/11 attacks**, stabbed by a
hijacker (Satam al-Suqami) as he apparently attempted to intervene; the plane
struck the World Trade Center's North Tower at 8:46 a.m. Lewin, an American-Israeli,
had served as an officer in the IDF's Sayeret Matkal special-operations unit.
- Wikipedia, "Daniel Lewin": https://en.wikipedia.org/wiki/Daniel_Lewin
- MIT Alumni profile: https://alum.mit.edu/slice/mit-alumnus-daniel-lewin-first-man-die-911-transformed-internet
- CNN Business, "The legacy of Danny Lewin, the first man to die on 9/11" (2013): https://www.cnn.com/2013/09/09/tech/innovation/danny-lewin-9-11-akamai
- Tablet, "Remembering Danny Lewin": https://www.tabletmag.com/sections/news/articles/fighting-genius-on-flight-11

Akamai survived both the loss of its co-founder and the dot-com crash; Leighton
later became CEO. (See **## Akamai** below for the later acquisition history.)

### 2004 — Project Honey Pot (Cloudflare's seed)

**Matthew Prince** and **Lee Holloway**, working under Unspam Technologies, built
**Project Honey Pot** (2004) — a distributed system letting any website owner track
how spammers harvested email addresses. The question "where does email spam come
from?" and the data Project Honey Pot collected later seeded Cloudflare.
- Cloudflare, "Our Story": https://www.cloudflare.com/our-story/

### 2008-11-18 — Amazon CloudFront launches (the cloud's own CDN)

AWS launched **Amazon CloudFront**, "a self-service, pay-as-you-go content
delivery service," on **November 18, 2008**, integrated with Amazon S3 and
starting with 14 edge locations.
- AWS press release (Nov 2008): https://press.aboutamazon.com/2008/11/amazon-web-services-launches-amazon-cloudfront-a-self-service-pay-as-you-go-content-delivery-service
- TechCrunch, "Amazon Web Services Launches CloudFront" (Nov 17, 2008): https://techcrunch.com/2008/11/17/amazon-web-services-launches-cloudfront/
- AWS 15th-anniversary retrospective: https://aws.amazon.com/blogs/aws/happy-anniversary-amazon-cloudfront-15-years-of-evolution-and-internet-advancements/

### 2009-07-26 — Cloudflare founded

**Cloudflare** was founded (commonly dated **July 26, 2009**) by **Matthew Prince**,
**Michelle Zatlyn**, and **Lee Holloway**. Prince and Zatlyn met as Harvard
Business School students (HBS '09); the concept won the HBS business-plan
competition before launch. Holloway and Prince came from the Project Honey Pot work.
- Wikipedia, "Cloudflare": https://en.wikipedia.org/wiki/Cloudflare
- Cloudflare, "Our Story": https://www.cloudflare.com/our-story/

### 2010-09-27 — Cloudflare launches at TechCrunch Disrupt

Cloudflare publicly launched at **TechCrunch Disrupt** in September 2010 (commonly
dated **September 27, 2010**), pitching CDN + security (DDoS mitigation) + DNS as a
single, easy-on-ramp service.
- Wikipedia, "Cloudflare": https://en.wikipedia.org/wiki/Cloudflare
- Cloudflare, "Our Story": https://www.cloudflare.com/our-story/
- **Could not verify** the exact September 27, 2010 date against a primary
  TechCrunch Disrupt article in this pass; the 2010 Disrupt launch is sourced via
  Cloudflare's own story page and Wikipedia.

### 2011 — Fastly founded

**Fastly** was founded in **2011** by **Artur Bergman**, previously CTO of **Wikia**
(now Fandom). Fastly's pitch: a real-time CDN built on a small number of powerful
POPs running a heavily optimized **Varnish**-based stack, exposing the **Varnish
Configuration Language (VCL)** to customers and offering **instant cache purge**.
- Wikipedia, "Fastly": https://en.wikipedia.org/wiki/Fastly

### 2017-09-29 — Cloudflare Workers announced (edge compute on V8 isolates)

Cloudflare announced **Workers** on **September 29, 2017**: deploy JavaScript to
Cloudflare's edge, "written against an API similar to Service Workers," run via
**Google's V8 JavaScript engine** so multiple customers' scripts share a process
the way Chrome runs scripts from many sites — i.e., **V8 isolates** rather than a
container or VM per customer.
- Cloudflare blog, "Introducing Cloudflare Workers" (Sept 29, 2017): https://blog.cloudflare.com/introducing-cloudflare-workers/
- Workers reached open beta in 2018: https://blog.cloudflare.com/cloudflare-workers-is-now-on-open-beta/
- **Runtime internals / WASM-in-Workers and the isolate-vs-container debate are
  cross-referenced in [`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md) §4.**

### 2018-04-01 — Cloudflare launches the 1.1.1.1 public DNS resolver

Cloudflare launched its **1.1.1.1** public DNS resolver on **April 1, 2018**
(chosen because the service has "four ones," so 4/1) — pitched as the fastest,
privacy-first consumer resolver, committing to delete resolver logs within 24
hours and not to store client IPs. The 1.1.1.1 / 1.0.0.1 addresses were provided
via a research arrangement with **APNIC**.
- Cloudflare blog, "Announcing 1.1.1.1: the fastest, privacy-first consumer DNS service": https://blog.cloudflare.com/announcing-1111/
- Cloudflare blog, "Introducing DNS Resolver, 1.1.1.1 (not a joke)": https://blog.cloudflare.com/dns-resolver-1-1-1-1/
- Internet Society coverage (Apr 2018): https://www.internetsociety.org/blog/2018/04/cloudflare-launches-enhanced-dns-service/

### 2019-05-21 — Fastly IPO (NYSE: FSLY)

Fastly completed its IPO, selling **12,937,500 shares of Class A common stock at
$16.00/share** (per its own filings; the offering is commonly dated **May 17, 2019**
pricing / **May 21, 2019** close — see filing). Ticker **FSLY** (NYSE).
- SEC, Fastly Form 8-K (FY2019, press release): https://www.sec.gov/Archives/edgar/data/0001517413/000151741319000008/ex992-fslypressrelease63019.htm
- Wikipedia, "Fastly": https://en.wikipedia.org/wiki/Fastly

### 2019-08-04/05 — Cloudflare terminates 8chan

After the **El Paso** mass shooting, whose alleged gunman posted a screed to
**8chan**, Cloudflare announced it would stop providing service to the site. CEO
**Matthew Prince**, in the blog post "Terminating Service for 8Chan," wrote: *"The
rationale is simple: they have proven themselves to be lawless and that
lawlessness has caused multiple tragic deaths."* (Attribution: Prince/Cloudflare.)
- Cloudflare blog, "Terminating Service for 8Chan": https://blog.cloudflare.com/terminating-service-for-8chan/
- TechCrunch (Aug 4, 2019): https://techcrunch.com/2019/08/04/cloudflare-will-stop-service-to-8chan-which-ceo-matthew-prince-describes-as-a-cesspool-of-hate/

### 2019-09-13 — Cloudflare IPO (NYSE: NET)

Cloudflare went public on the **NYSE under ticker NET**, with Class A shares priced
at **$15.00** and **35,000,000 shares** offered — **~$525 million** in gross
proceeds at the offer price. First trade was **September 13, 2019**.
- SEC, Cloudflare Form 424B4 (FY2019, final prospectus): https://www.sec.gov/Archives/edgar/data/0001477333/000119312519244325/d735023d424b4.htm
- SEC, Cloudflare Form S-1/A (FY2019): https://www.sec.gov/Archives/edgar/data/0001477333/000119312519235734/d735023ds1a.htm
- Wikipedia, "Cloudflare" (Sept 13, 2019 first trade, ticker NET): https://en.wikipedia.org/wiki/Cloudflare

### 2020-04 — ZEIT rebrands to Vercel; 2020 — Cloudflare Pages

ZEIT (the company behind **Next.js**) rebranded to **Vercel** in **April 2020**
(see **## Other CDNs & platforms**). Cloudflare also launched **Pages** (static-site
hosting / JAMstack on its edge) in **2020**.
- Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel
- Wikipedia, "Cloudflare" (Pages, 2020): https://en.wikipedia.org/wiki/Cloudflare

### 2020-08-27 / 2020-10-01 — Fastly acquires Signal Sciences (~$775M)

Fastly agreed (Aug 27, 2020) to acquire web-app/API security firm **Signal Sciences**
for **~$775M** (~$200M cash + ~$575M stock); the deal **closed Oct 1, 2020**. It
became Fastly's Next-Gen WAF and core of its security portfolio.
- SEC, Fastly Form 8-K (FY2020, "Project Griffon" press release): https://www.sec.gov/Archives/edgar/data/0001517413/000151741320000194/projectgriffon-pressre.htm
- Fastly press release: https://www.fastly.com/press/press-releases/fastly-announces-agreement-acquire-signal-sciences

### 2021-06-08 — The Fastly global outage

On **June 8, 2021**, a single customer's valid configuration change tripped a
**latent software bug** Fastly had introduced in a **May 12, 2021** deployment,
causing **85% of Fastly's network to return errors** and taking down major sites
(per press: Amazon, Reddit, The New York Times, The Guardian, Twitch, the UK
government's gov.uk, and others) for roughly an hour. Fastly says it detected the
disruption within ~1 minute and had ~95% of the network recovered within ~49 minutes.
- Fastly, "Summary of June 8 outage": https://www.fastly.com/blog/summary-of-june-8-outage
- NPR (Jun 9, 2021): https://www.npr.org/2021/06/09/1004684932/fastly-tuesday-internet-outage-down-was-caused-by-one-customer-changing-setting
- CBS News: https://www.cbsnews.com/news/fastly-says-widespread-outage-of-top-websites-triggered-by-software-bug/

### 2021-09-28 — Cloudflare R2 announced (S3-compatible, no egress fees)

Cloudflare announced **R2** object storage on **September 28, 2021** — **S3 API
compatible** with **zero egress bandwidth charges**, explicitly positioned against
AWS S3's egress pricing, with a migrator to incrementally copy objects from
S3-compatible sources.
- Cloudflare blog, "Announcing Cloudflare R2 Storage: Rapid and Reliable Object Storage, minus the egress fees": https://blog.cloudflare.com/introducing-r2-object-storage/
- **The S3-API-as-a-standard angle is cross-referenced in [`s3-object-storage.md`](./s3-object-storage.md).**

### 2022-02-15 / 2022 Q1 — Akamai acquires Linode (~$900M)

Akamai announced (**Feb 15, 2022**) it would acquire IaaS/cloud-hosting provider
**Linode** for **~$900 million**, marrying Linode's developer-friendly compute with
Akamai's distributed edge/CDN/security footprint. The deal closed in Q1 2022.
- Akamai press release, "Akamai To Acquire Linode": https://www.akamai.com/newsroom/press-release/akamai-to-acquire-linode
- Akamai press release (completion): https://www.akamai.com/newsroom/press-release/akamai-completes-acquisition-of-linode
- Philadelphia Inquirer (Feb 16, 2022): https://www.inquirer.com/business/technology/akamai-linode-microsoft-amazon-cloud-philadelphia-20220216.html

### 2022-05-19 — Fastly acquires Glitch

Fastly acquired the developer/IDE-in-the-browser platform **Glitch** (announced
**May 19, 2022**) — "yes-code at the edge." Glitch CEO **Anil Dash** joined Fastly
as VP of developer experience. Price not disclosed.
- Fastly blog, "Fastly acquires Glitch...": https://www.fastly.com/blog/fastly-announces-acquisition-of-glitch-a-future-of-yes-code-at-the-edge
- The Register (May 19, 2022): https://www.theregister.com/2022/05/19/fastly_buys_glitch/

### 2022 — Cloudflare D1 (SQLite at the edge) announced

Cloudflare announced **D1**, an edge SQL database built on **SQLite**, in **2022**
(at "Platform Week"), alongside **Durable Objects** (single-instance stateful
coordination for Workers, which had entered beta in **2020**).
- Wikipedia, "Cloudflare" (D1 announced 2022): https://en.wikipedia.org/wiki/Cloudflare
- Cloudflare blog, "Workers Durable Objects Beta: A New Approach to Stateful Serverless" (2020): https://blog.cloudflare.com/introducing-workers-durable-objects/
- **Could not verify** the exact D1 announcement date (month/day) against the
  original Cloudflare blog post in this pass; the year (2022) is sourced.

### 2022-06-16 — Limelight + Edgecast become Edgio

**Limelight Networks** completed its acquisition of **Edgecast** (~$300M; agreement
Mar 7, 2022) on **June 16, 2022** and rebranded the combined company **Edgio**.
Edgecast had earlier been a Verizon asset (Verizon acquired Edgecast in 2013).
- SEC, Limelight Form 8-K (FY2022, acquisition press release): https://www.sec.gov/Archives/edgar/data/0001391127/000119312522067019/d298634dex991.htm
- SEC, Edgio Form 8-K (FY2022, rebrand): https://www.sec.gov/Archives/edgar/data/0001391127/000119312522175232/d339796dex991.htm
- Wikipedia, "Edgecast": https://en.wikipedia.org/wiki/Edgecast
- Wikipedia, "Edgio": https://en.wikipedia.org/wiki/Edgio

### 2022-09-03 — Cloudflare blocks Kiwi Farms

Cloudflare blocked the harassment forum **Kiwi Farms** on **September 3, 2022**.
In "Blocking Kiwifarms," Prince cited *"an unprecedented emergency and immediate
threat to human life"* after threats escalated over ~48 hours, called it *"an
extraordinary decision for us to make"* that he was *"not comfortable with,"* and
noted Cloudflare had never been the site's hosting provider. (Attribution:
Prince/Cloudflare.)
- Cloudflare blog, "Blocking Kiwifarms": https://blog.cloudflare.com/kiwifarms-blocked/
- Washington Post (Sept 3, 2022): https://www.washingtonpost.com/technology/2022/09/03/cloudflare-drops-kiwifarms/

### 2024-09-09 — Edgio files Chapter 11

**Edgio** filed for voluntary **Chapter 11 bankruptcy on September 9, 2024**. In the
court-supervised process, **Akamai** acquired select Edgio customer contracts/assets,
and **DigitalOcean** acquired certain assets as well; the Edgecast technology was
later sold separately (reported to Lynrock Lake / Parler-affiliated buyers in 2025).
- Wikipedia, "Edgio" (Chapter 11, Sept 9, 2024; asset sales): https://en.wikipedia.org/wiki/Edgio
- **Could not verify** the precise per-buyer Edgio asset allocations (Akamai vs.
  DigitalOcean vs. Lynrock Lake / Parler) against primary court/press documents in
  this pass; the bankruptcy filing and the existence of Akamai/DigitalOcean asset
  purchases are sourced via Wikipedia. Treat the dollar figures (~$110M to Lynrock
  Lake) and the Edgecast→Parler detail as reported, not primary-verified.

### 2025-12-01 — Akamai acquires Fermyon (WASM FaaS)

Akamai announced (**December 1, 2025**) it had acquired serverless-WebAssembly
function-as-a-service startup **Fermyon** (co-founders **Matt Butcher** and **Radu
Matei**, maintainers of the CNCF **Spin** / **SpinKube** projects), to push
WASM-based edge compute / edge-AI inference. Akamai said no material impact to 2025
guidance.
- Akamai press release: https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon
- Fermyon blog, "Fermyon Joins Akamai": https://www.fermyon.com/blog/fermyon-joins-akamai
- SiliconANGLE (Dec 1, 2025): https://siliconangle.com/2025/12/01/akamai-acquires-webassembly-function-service-startup-fermyon/
- **Fermyon / Spin / the WASM-FaaS thread is covered in
  [`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md);
  the Matt Butcher → Fermyon → Akamai line is also tracked in `helm.md`.**

---

## Cloudflare

**Founded:** July 26, 2009 by **Matthew Prince**, **Michelle Zatlyn**, and **Lee
Holloway**, out of the **Project Honey Pot** spam-tracking project; launched at
**TechCrunch Disrupt 2010**.
- Cloudflare, "Our Story": https://www.cloudflare.com/our-story/
- Wikipedia, "Cloudflare": https://en.wikipedia.org/wiki/Cloudflare

**Core business:** a reverse-proxy edge sitting in front of customer sites,
bundling **CDN caching + DDoS mitigation + DNS + WAF**, famously with a generous
free tier as the on-ramp. The strategy of being a "boring infrastructure company"
that nonetheless takes high-profile content stances is the framing **Inc.** used in
its 2019 profile (opinion/analysis, attributed to Inc./Christine Lagorio-Chafkin):
"Cloudflare Wanted to Be a Boring Infrastructure Company..."
- Inc. profile (2019): https://www.inc.com/christine-lagorio-chafkin/cloudflare-el-paso-8chan-matthew-prince-michelle-zatlyn.html

**Product expansion (developer platform):**
- **Workers** — edge compute on **V8 isolates** (Sept 29, 2017): https://blog.cloudflare.com/introducing-cloudflare-workers/
- **1.1.1.1** public DNS resolver (Apr 1, 2018): https://blog.cloudflare.com/announcing-1111/
- **Durable Objects** beta (2020): https://blog.cloudflare.com/introducing-workers-durable-objects/
- **Pages** (2020) and **R2** (Sept 28, 2021, S3-compatible, no egress): https://blog.cloudflare.com/introducing-r2-object-storage/
- **D1** (SQLite at the edge, 2022): https://en.wikipedia.org/wiki/Cloudflare

**IPO:** NYSE **NET**, first trade **Sept 13, 2019**, $15.00/share, ~$525M gross.
- SEC 424B4: https://www.sec.gov/Archives/edgar/data/0001477333/000119312519244325/d735023d424b4.htm

### Content-moderation / de-platforming controversies (fact vs. attributed opinion)

Cloudflare's role sits at internet *infrastructure*, not hosting, which is exactly
why its three high-profile terminations became debates about who should have the
power to make a site unreachable. The **facts** (dates, actions, the company's own
stated rationales) are sourced below; the **framings** are attributed.

**The Daily Stormer (Aug 16, 2017).** Cloudflare terminated the neo-Nazi site
**The Daily Stormer**. Its **public** blog post, "Why We Terminated Daily Stormer"
(Aug 16, 2017), argues the *opposite* of a celebratory stance — Prince frames it as
a dangerous precedent, writing "**Freedom of Speech < Due Process**" and warning
that no infrastructure company should unilaterally decide who exists online.
- Cloudflare blog (public post): https://blog.cloudflare.com/why-we-terminated-daily-stormer/

The widely quoted line **"Literally, I woke up in a bad mood and decided someone
shouldn't be allowed on the Internet. No one should have that power"** is from
Prince's **internal email to staff**, *not* the public blog post — it was obtained
and reported by **Gizmodo** (Kate Conger), and amplified by CNBC and others.
Attribution matters: it is Prince's self-critical internal reflection, reported by
Gizmodo, not a line he published.
- Gizmodo (Kate Conger), "Cloudflare CEO on Terminating Service to Neo-Nazi Site": https://gizmodo.com/cloudflare-ceo-on-terminating-service-to-neo-nazi-site-1797915295
- CNBC (Aug 17, 2017), framing it as Prince acknowledging a "slippery slope": https://www.cnbc.com/2017/08/17/cloudflare-ceo-says-removing-the-daily-stormer-is-slippery-slope.html

**8chan (Aug 2019).** Terminated after the El Paso shooting; Prince's stated
rationale: the site had "proven themselves to be lawless." (See timeline.)
- https://blog.cloudflare.com/terminating-service-for-8chan/

**Kiwi Farms (Sept 3, 2022).** Blocked citing an "unprecedented emergency and
immediate threat to human life"; Prince called it an "extraordinary decision" he
was "not comfortable with." (See timeline.)
- https://blog.cloudflare.com/kiwifarms-blocked/

**The recurring tension (attributed):** across all three, Prince's essays argue
that infrastructure-layer censorship is a worse mechanism than
application/host-layer moderation, because terminating a proxy doesn't remove
content — it only makes it slower and more exposed — and concentrates unaccountable
power in a few companies. That is **Prince's/Cloudflare's stated position**; outlets
like Inc., Fortune, and the Columbia Journalism Review have debated whether the
company's "principled neutrality" is sustainable.
- Fortune (Sept 6, 2022): https://fortune.com/2022/09/06/cloudflare-kiwi-farms-doxxing-trans-security-service/
- Columbia Journalism Review, "Cloudflare, Kiwi Farms, and the challenges of deplatforming": https://www.cjr.org/the_media_today/cloudflare-kiwi-farms-and-the-challenges-of-deplatforming.php

---

## Akamai (the original CDN)

**Founded:** 1998 at **MIT** by math professor **Tom Leighton** and grad student
**Danny Lewin**, from their consistent-hashing / distributed-caching CDN algorithms;
**IPO 1999** (Nasdaq). Akamai survived the dot-com crash and the **9/11 death of
Danny Lewin** (the first 9/11 victim; see timeline) to become the incumbent
enterprise CDN/security vendor. Leighton later became CEO.
- FundingUniverse history: https://www.fundinguniverse.com/company-histories/akamai-technologies-inc-history/
- SEC Akamai S-1/A (FY1999): https://www.sec.gov/Archives/edgar/data/0001086222/000095013599004906/0000950135-99-004906.txt
- Daniel Lewin (Wikipedia): https://en.wikipedia.org/wiki/Daniel_Lewin

**Notable acquisitions (sourced):**
- **Prolexic (2014)** — large-scale DDoS/volumetric mitigation. **Could not verify**
  the Prolexic acquisition against a primary Akamai/SEC document in this pass;
  reported as 2014 by secondary sources. (Flagged for follow-up.)
- **Guardicore (Oct 2021, ~$600M)** — micro-segmentation / zero-trust security.
  **Could not verify** the $600M figure against a primary Akamai filing in this
  pass; reported by secondary press.
- **Linode (2022, ~$900M)** — IaaS/cloud compute (primary-sourced; see timeline).
  - https://www.akamai.com/newsroom/press-release/akamai-to-acquire-linode
- **Fermyon (Dec 1, 2025)** — serverless WASM FaaS (primary-sourced; see timeline
  and the WASM cross-ref).
  - https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon
- In the **Edgio** Chapter 11 (2024), Akamai acquired select Edgio assets/contracts
  (see timeline; per-buyer detail not fully primary-verified).

The arc — Prolexic (DDoS) → Guardicore (segmentation) → Linode (compute) → Fermyon
(WASM edge functions) — shows the incumbent CDN deliberately moving up into
**compute + security**, the same convergence Cloudflare and Fastly are racing on.

---

## Fastly

**Founded:** 2011 by **Artur Bergman** (ex-**Wikia** CTO). Differentiator: a
**real-time CDN** with **instant cache purge** and customer-programmable edge logic
via **VCL** (Varnish Configuration Language), on a small number of high-capacity POPs.
- Wikipedia, "Fastly": https://en.wikipedia.org/wiki/Fastly

**Compute@Edge:** Fastly's serverless edge-compute product, built first on its own
**Lucet** WebAssembly compiler/runtime (open-sourced; **merged into wasmtime in
mid-2020**). The full Lucet → wasmtime / Bytecode Alliance story is in the WASM
cross-ref doc.
- **See [`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md) §4
  (Lucet announcement and Lucet→wasmtime merge are sourced there).**

**IPO:** NYSE **FSLY**, **2019** (priced ~May 17, $16.00/share).
- SEC Fastly 8-K (FY2019): https://www.sec.gov/Archives/edgar/data/0001517413/000151741319000008/ex992-fslypressrelease63019.htm

**The June 8, 2021 global outage:** one customer's valid config change tripped a
latent bug from a May 12 deploy, erroring **85% of the network** and downing
Amazon/Reddit/NYT/Guardian/Twitch/gov.uk-class sites for ~1 hour. (See timeline for
primary Fastly post-mortem + NPR/CBS.)
- https://www.fastly.com/blog/summary-of-june-8-outage

**Acquisitions:**
- **Signal Sciences (2020, ~$775M)** — WAF / API security (→ Fastly Next-Gen WAF).
  - https://www.fastly.com/press/press-releases/fastly-announces-agreement-acquire-signal-sciences
- **Glitch (May 19, 2022)** — browser IDE / developer community ("yes-code at the
  edge"); Anil Dash joined Fastly.
  - https://www.fastly.com/blog/fastly-announces-acquisition-of-glitch-a-future-of-yes-code-at-the-edge

---

## The edge-compute wave

CDNs all evolved the same way: from caching static bytes near users, to running
**customer code** near users. The major players (cross-referenced to the WASM doc
for runtime internals):

- **Cloudflare Workers** (2017) — V8 isolates; also runs WASM. https://blog.cloudflare.com/introducing-cloudflare-workers/
- **Fastly Compute@Edge** — Lucet → wasmtime (WASM). See WASM cross-ref §4.
- **AWS Lambda@Edge** and **CloudFront Functions** — two flavors of code at AWS
  edge locations: Lambda@Edge is a fuller Lambda environment with higher latency/cost;
  **CloudFront Functions** are lightweight, sub-millisecond JS for simple
  request/response manipulation.
  - AWS docs, "Differences between CloudFront Functions and Lambda@Edge": https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/edge-functions-choosing.html
- **Deno Deploy** — edge runtime from the **Deno** team (TypeScript/JS, V8); also the
  infrastructure powering **Netlify Edge Functions**.
  - Deno blog, "Netlify Edge Functions on Deno Deploy": https://deno.com/blog/netlify-edge-functions-on-deno-deploy
- **Vercel Edge Functions** and **Netlify Edge Functions** — the JAMstack platforms'
  edge-compute layers. Netlify Edge Functions run on **Deno**; Vercel's edge runtime
  is its own (Web-standard) runtime.
  - Netlify blog, "Netlify Edge Functions: Serverless Compute Powered by Deno": https://www.netlify.com/blog/announcing-serverless-compute-with-edge-functions/

**The "next Docker?" framing** for server-side WASM that runs through this wave
(Solomon Hykes's 2019 tweet, the bullish and skeptical takes, and Hykes's own later
walk-back) is the subject of
[`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md) and is not
repeated here.

---

## Other CDNs & platforms

**Cloud-provider CDNs:**
- **Amazon CloudFront** (Nov 18, 2008) — see timeline. https://press.aboutamazon.com/2008/11/amazon-web-services-launches-amazon-cloudfront-a-self-service-pay-as-you-go-content-delivery-service
- **Google Cloud CDN** and **Azure Front Door** — the GCP and Azure edge/CDN
  offerings. **Could not verify** their exact GA launch dates against primary
  Google/Microsoft announcements in this pass (flagged for follow-up).

**Limelight Networks → Edgio (and Verizon EdgeCast):**
- **Limelight Networks** (an early Akamai rival) acquired **Edgecast** and rebranded
  as **Edgio** in **2022**; Edgecast had been a **Verizon** asset (Verizon acquired
  Edgecast in 2013, later folded into Verizon Digital Media Services / Oath / Verizon
  Media). **Edgio filed Chapter 11 in Sept 2024**, with assets going to **Akamai**
  and **DigitalOcean** (and the Edgecast tech sold separately). (See timeline.)
  - https://en.wikipedia.org/wiki/Edgio , https://en.wikipedia.org/wiki/Edgecast

**JAMstack platforms:**
- **Netlify** — founded **2014** by **Mathias Biilmann** (Danish; ex-Webpop), joined
  by co-founder **Christian Bach** (2015). Biilmann **coined the term "JAMstack"**
  (JavaScript/APIs/Markup); the term is dated to **2015** by Netlify, popularized via
  Biilmann's **2016 SmashingConf** talk.
  - Wikipedia, "Netlify": https://en.wikipedia.org/wiki/Netlify
  - Wikipedia, "JAMstack": https://en.wikipedia.org/wiki/JAMstack
  - **Note on the date:** sources split between "coined 2015" (Netlify) and "introduced
    at SmashingConf 2016." Both are reported; the 2015 coinage vs. 2016 public
    introduction distinction is preserved rather than collapsed.
- **Vercel** — founded **2015** by **Guillermo Rauch** as **ZEIT**; creator of
  **Next.js** (2016) and earlier **Socket.IO**. **ZEIT rebranded to Vercel in April
  2020.**
  - Wikipedia, "Vercel": https://en.wikipedia.org/wiki/Vercel

**Image / media CDNs:**
- **Cloudinary** — founded **2012** (Israel) by **Itai Lahan**, **Tal Lev-Ami**, and
  **Nadav Soferman**. https://en.wikipedia.org/wiki/Cloudinary
- **imgix** — founded **2011** by **Chris Zacharias** (ex-YouTube), San Francisco.
  - Y Combinator company page: https://www.ycombinator.com/companies/imgix
  - imgix "About": https://www.imgix.com/about

**Newer / independent CDNs:**
- **bunny.net** (formerly **BunnyCDN**) — founded **2015** in **Ljubljana, Slovenia**
  by **Dejan Grofelnik Pelzel** (with Borut Dagarin and Lovrenc Gregorčič); raised a
  $6M round in 2022.
  - TechCrunch (Oct 4, 2022): https://techcrunch.com/2022/10/04/slovenias-bunny-net-raises-a-6m-round-to-offer-a-developer-friendly-cdn/
- **StackPath** — launched **2015** (consolidated several edge/security assets,
  including the former MaxCDN). **Could not verify** founder/exact-founding details
  against a primary source here.
- **KeyCDN**, **CDN77**, **Gcore** — established independent CDN/edge providers.
  **Could not verify** their founders / exact founding years against primary sources
  in this research pass (KeyCDN ~Switzerland; CDN77 commonly dated 2011 / DataCamp
  Limited; Gcore commonly dated ~2014, Luxembourg). These are flagged for follow-up
  rather than asserted, per the no-guessing rule.

---

## Key people, companies & acquisitions

**People:**
- **Matthew Prince** — co-founder & CEO, Cloudflare (also founded Project Honey Pot
  with Holloway). https://www.cloudflare.com/our-story/
- **Michelle Zatlyn** — co-founder & President/COO, Cloudflare (HBS '09). https://en.wikipedia.org/wiki/Michelle_Zatlyn
- **Lee Holloway** — co-founder, Cloudflare; Project Honey Pot. https://www.cloudflare.com/our-story/
- **Tom Leighton** — co-founder & later CEO, Akamai; MIT applied-math professor. https://www.fundinguniverse.com/company-histories/akamai-technologies-inc-history/
- **Danny (Daniel) Lewin** — co-founder & CTO, Akamai; first 9/11 victim. https://en.wikipedia.org/wiki/Daniel_Lewin
- **Artur Bergman** — founder & (long-time) CEO, Fastly; ex-Wikia CTO. https://en.wikipedia.org/wiki/Fastly
- **Mathias Biilmann** & **Christian Bach** — co-founders, Netlify; "JAMstack." https://en.wikipedia.org/wiki/Netlify
- **Guillermo Rauch** — founder & CEO, Vercel (ZEIT); Next.js, Socket.IO. https://en.wikipedia.org/wiki/Vercel
- **Chris Zacharias** — founder & CEO, imgix (ex-YouTube). https://www.ycombinator.com/companies/imgix
- **Itai Lahan / Tal Lev-Ami / Nadav Soferman** — co-founders, Cloudinary. https://en.wikipedia.org/wiki/Cloudinary
- **Matt Butcher** & **Radu Matei** — co-founders, Fermyon (→ Akamai, 2025). https://www.fermyon.com/blog/fermyon-joins-akamai
- **Anil Dash** — CEO of Glitch (→ Fastly, 2022). https://www.fastly.com/blog/fastly-announces-acquisition-of-glitch-a-future-of-yes-code-at-the-edge

**Selected acquisitions (primary-sourced unless flagged):**

| Acquirer | Target | Date | Notes |
|---|---|---|---|
| Verizon | Edgecast | 2013 | Reported; later folded into Verizon Media. ([Edgecast/Wikipedia](https://en.wikipedia.org/wiki/Edgecast)) |
| Akamai | Prolexic | 2014 | DDoS mitigation. **Could not verify** vs. primary source. |
| Fastly | Signal Sciences | 2020 (~$775M) | WAF/API security. ([Fastly](https://www.fastly.com/press/press-releases/fastly-announces-agreement-acquire-signal-sciences)) |
| Akamai | Guardicore | 2021 (~$600M) | Micro-segmentation. **$600M figure not primary-verified.** |
| Limelight | Edgecast | 2022 (~$300M) → Edgio | ([SEC 8-K](https://www.sec.gov/Archives/edgar/data/0001391127/000119312522067019/d298634dex991.htm)) |
| Akamai | Linode | 2022 (~$900M) | IaaS/compute. ([Akamai](https://www.akamai.com/newsroom/press-release/akamai-to-acquire-linode)) |
| Fastly | Glitch | 2022 | Dev IDE/community. ([Fastly](https://www.fastly.com/blog/fastly-announces-acquisition-of-glitch-a-future-of-yes-code-at-the-edge)) |
| Akamai / DigitalOcean | Edgio assets | 2024 (Ch.11) | Per-buyer split not primary-verified. ([Edgio/Wikipedia](https://en.wikipedia.org/wiki/Edgio)) |
| Akamai | Fermyon | 2025 | WASM FaaS. ([Akamai](https://www.akamai.com/newsroom/press-release/akamai-announces-acquisition-of-function-as-a-service-company-fermyon)) |

---

## Current status: the "everything platform" convergence

The throughline is convergence. Every major player started in one box and grew to
cover the others:
- **Akamai**: CDN → security (Prolexic, Guardicore) → **compute** (Linode) → **WASM
  edge functions** (Fermyon). (Sources above.)
- **Cloudflare**: CDN/DDoS/DNS → **edge compute** (Workers) → **storage** (R2) →
  **databases** (D1, Durable Objects) → **DNS-as-product** (1.1.1.1) — explicitly a
  developer "everything platform." (Sources above.)
- **Fastly**: real-time CDN → **edge compute** (Compute@Edge / WASM) → **security**
  (Signal Sciences) → **developer experience** (Glitch). (Sources above.)
- **AWS / cloud CDNs**: CloudFront + Lambda@Edge / CloudFront Functions integrate the
  CDN into the broader cloud. (Sources above.)
- **JAMstack platforms (Netlify, Vercel)** approached the same edge from the
  *frontend-developer* side, adding edge functions (Vercel's runtime; Netlify on
  Deno Deploy). (Sources above.)

The four-way merger — **CDN + edge compute + security + storage** — is now the
shared strategy, with WASM (Fastly, Akamai/Fermyon) and V8 isolates (Cloudflare) as
the competing edge-runtime bets. The runtime side of that bet is analyzed in
[`WASM_DOCKER_alternate_history.md`](./WASM_DOCKER_alternate_history.md); R2 vs. S3
in [`s3-object-storage.md`](./s3-object-storage.md).

---

## Summary of what could NOT be fully verified (primary-source gaps)

- **Akamai founding date** August 20, 1998 (exact day) and the **IPO $26→~$145**
  first-day pop — year/IPO sourced; exact day and first-day numbers reported, not
  primary-verified.
- **Cloudflare TechCrunch Disrupt launch** exact date (Sept 27, 2010) — 2010 Disrupt
  launch sourced via Cloudflare's own story page + Wikipedia, not a primary TC article.
- **Cloudflare D1** exact announcement month/day in 2022 — year sourced.
- **Akamai Prolexic (2014)** and the **Guardicore ~$600M** figure — reported by
  secondary press, not primary-verified.
- **Edgio Chapter 11 asset split** (Akamai vs. DigitalOcean vs. Lynrock Lake / Parler;
  ~$110M figure; Edgecast→Parler) — bankruptcy + Akamai/DigitalOcean purchases
  sourced via Wikipedia; per-buyer detail not primary-verified.
- **Google Cloud CDN** and **Azure Front Door** GA dates — not verified to primary.
- **KeyCDN, CDN77, Gcore, StackPath** founders/founding years — not primary-verified
  (left flagged rather than asserted).
