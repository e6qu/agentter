# n8n and the Low-Code / No-Code / Automation Landscape — A Sourced History

A chronological, fully-sourced history of **workflow automation, iPaaS, and
low-code/no-code app building** — centered on **n8n** (the source-available,
self-hostable automation tool that became a breakout star of the AI-agent era),
and the wider field of players it competes with and learned from: Zapier,
Make/Integromat, Microsoft Power Automate, Workato, Tray, Pipedream, IFTTT,
Boomi, MuleSoft, Retool, Bubble, Webflow, Airtable, Appsmith/Budibase/ToolJet,
OutSystems, and Mendix.

> **Sourcing standard.** Every non-trivial claim carries a real, working URL —
> company blogs, the license texts themselves, reputable press (TechCrunch,
> Bloomberg, etc.), funding announcements, SEC filings, GitHub, and Wikipedia
> (used as an index, with primary sources preferred for load-bearing facts).
> Opinions and predictions are attributed to the person/outlet that made them.
> Anything not confirmable against a primary or reputable secondary source is
> flagged **Could not verify:** rather than asserted.

> **Cross-references (not duplicated here):**
> - `history/WASM_DOCKER_alternate_history.md` — the broader AI-agent / "next
>   platform" wave and the source-available-vs-open-source licensing tension
>   (Commons Clause, BSL) that the same debate shows up in for n8n's "fair-code."
> - `history/airflow.md` — **data/workflow orchestration** (Apache Airflow,
>   DAG-based scheduling). That doc covers the *engineering-pipeline*
>   orchestration lineage; this doc covers the *business/app-glue* automation
>   lineage. They converge in the AI-agent era but come from different worlds.
>   **Could not verify:** `history/airflow.md` does not currently exist in this
>   repo's `history/` directory as of this writing — the cross-reference is
>   forward-looking; if/when that doc is written, the orchestration-vs-automation
>   distinction below is the intended hand-off.

---

## Dated timeline

| Date | Event | Source |
|------|-------|--------|
| 2001 | **OutSystems** founded by Paulo Rosado in Lisbon, Portugal | [Wikipedia: OutSystems](https://en.wikipedia.org/wiki/OutSystems) |
| 2005 | **Mendix** founded in Rotterdam, Netherlands | [Wikipedia: Mendix](https://en.wikipedia.org/wiki/Mendix) |
| 2010 | **IFTTT** founded (project; public launch 2011) by Linden Tibbets et al. | [IFTTT: 15 years](https://ifttt.com/explore/celebrating-15-years-ifttt) |
| 2011 | **Zapier** begins as a side project in Columbia, Missouri (Foster, Helmig, Knoop) | [Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier) |
| 2012 | Zapier joins **Y Combinator** (Summer 2012); public beta May 2012 | [Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier) |
| 2012 | **Integromat** (later **Make**) launched in Czechia | [BusinessWire: Integromat → Make](https://www.businesswire.com/news/home/20220222005231/en/Integromat-Evolves-to-Make-Expanding-Its-Vision-to-Empower-Creators-to-Innovate-Without-Limits) |
| 2012 | **Airtable** founded (Howie Liu, Andrew Ofstad, Emmett Nicholas) | [Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable) |
| 2012 | **Bubble** founded (Emmanuel Straschnov, Joshua Haas) | [Wikipedia: Emmanuel Straschnov](https://en.wikipedia.org/wiki/Emmanuel_Straschnov) |
| 2012 | **Tray.io** founded (Russell, Lewis, Waldron), San Francisco | [Tray.io — Golden](https://golden.com/wiki/Tray.io-4N958ZX) |
| 2013 | **Webflow** founded (Vlad Magdalin, Sergie Magdalin, Chris Schleifer) | [Wikipedia is not used here; see Webflow funding source below] |
| Apr 27, 2016 | **Microsoft Flow** (later Power Automate) announced | [Microsoft Power Platform blog](https://www.microsoft.com/en-us/power-platform/blog/2016/04/27/welcome-to-microsoft-flow/) |
| Nov 1, 2016 | Microsoft Flow becomes generally available | [Wikipedia: Power Automate](https://en.wikipedia.org/wiki/Microsoft_Power_Automate) |
| 2017 | **Retool** founded (David Hsu) | [Sequoia: David Hsu / Retool](https://sequoiacap.com/article/david-hsu-retool-spotlight/) |
| Mar 20, 2018 | **Salesforce** to acquire **MuleSoft** for ~$6.5B | [Wilson Sonsini](https://www.wsgr.com/en/insights/mulesoft-to-be-acquired-by-salesforce-for-6-5-billion.html) |
| Aug 2018 | **Siemens** to acquire **Mendix** for ~$730M (€0.6B) | [Mendix blog](https://www.mendix.com/blog/siemens-to-acquire-mendix/) |
| Oct 1, 2018 | Siemens closes Mendix acquisition | [Schnitger Corp.](https://schnitgercorp.com/2018/10/01/siemens-closes-mendix-acquisition-heres-why-it-matters/) |
| 2019 | **n8n** founded by **Jan Oberhauser** in Berlin; v1 launched Oct 2019 | [Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n) |
| Mar 2020 | n8n **Seed** ~$1.5M, co-led by **Sequoia** + firstminute capital | [Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n) |
| Oct 14, 2020 | **Celonis** acquires **Integromat** (>$100M) | [TechCrunch](https://techcrunch.com/2020/10/14/celonis-acquires-czech-startup-integromat-to-accelerate-move-to-process-automation/) |
| Jan 2021 | **Zapier** valued at **$5B** in a secondary share sale (Sequoia, Steadfast) | [Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier) |
| Feb 17, 2021 | **OutSystems** raises $150M at **$9.5B** valuation | [TechCrunch](https://techcrunch.com/2021/02/17/low-code-focused-outsystems-raises-150m-at-a-9-5b-valuation/) |
| Apr 2021 | n8n **Series A** $12M, led by **Felicis** | [Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n) |
| May 2, 2021 | **Dell** sells **Boomi** to Francisco Partners + TPG for **$4B** | [TechCrunch](https://techcrunch.com/2021/05/03/dell-dumps-another-big-asset-moving-boomi-to-francisco-partners-and-tpg-for-4b/) |
| 2021 | **Webflow** raises $140M at a **$4B** valuation | [WeAreFounders](https://www.wearefounders.uk/from-zero-to-4-billion-how-vlad-magdalin-built-webflow-into-a-no-code-empire/) |
| Nov 2021 | **Workato** Series E $200M at **$5.7B** valuation | [Contrary Research: Workato](https://research.contrary.com/company/workato) |
| Dec 2021 | **Airtable** Series F $735M at **$11B** valuation | [Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable) |
| Feb 2022 | Integromat rebrands to **Make** | [BusinessWire](https://www.businesswire.com/news/home/20220222005231/en/Integromat-Evolves-to-Make-Expanding-Its-Vision-to-Empower-Creators-to-Innovate-Without-Limits) |
| Mar 2022 | n8n relicenses to the **Sustainable Use License** ("fair-code"), replacing Apache-2.0 + Commons Clause | [Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n); [faircode.io](https://faircode.io/) |
| Jul 2022 | **Retool** raises $45M at **$3.2B** valuation (Sequoia-backed) | [Yahoo/TechCrunch](https://finance.yahoo.com/news/retool-raises-45m-3-2b-130328028.html) |
| Jun 2024 | **Mike Knoop** (Zapier co-founder) launches the **ARC Prize** (AGI benchmark) | [Sequoia podcast](https://sequoiacap.com/podcast/training-data-mike-knoop/) |
| Mar 24, 2025 | n8n **Series B** **€55M**, led by **Highland Europe** | [Highland Europe](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/) |
| Oct 9, 2025 | n8n **Series C** **$180M** at **$2.5B**; led by **Accel**, **NVIDIA** (NVentures) participates | [Bloomberg](https://www.bloomberg.com/news/articles/2025-10-09/ai-agent-startup-n8n-nets-2-5-billion-valuation-with-backing-from-nvidia); [n8n blog](https://blog.n8n.io/series-c/) |
| Nov 19, 2025 | **Workday** acquires **Pipedream** | [Reworked](https://www.reworked.co/talent-management/workday-buys-low-code-ai-integration-platform-pipedream/) |

---

## n8n

### Origins and what it is

**n8n** (pronounced "n-eight-n," short for "nodemation") was **founded in 2019
by Jan Oberhauser** in **Berlin, Germany**, with the first version of the
platform launched in **October 2019**
([Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n)). It is a **node-based
workflow-automation tool** — a visual canvas on which you wire together
"nodes" (triggers, app integrations, logic, code) into executable workflows.
Its core positioning is as a **self-hostable alternative to Zapier and Make**:
you can run it on your own infrastructure rather than only as someone else's
SaaS. Oberhauser describes the goal as combining "AI, code, and humans in the
same process, on the same platform" and has framed the product as building "the
Excel of AI" ([Accel "Spotlight On"
podcast](https://www.accel.com/podcast-episodes/bonus-n8ns-jan-oberhauser-on-building-the-excel-of-ai)).

By April 2021, the community had grown to roughly **16,000** developers and
"citizen developers" ([Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n)). By
the March 2025 raise, n8n reported having **surpassed 230,000 active users** and
serving **over 3,000 enterprises**, with ARR up **5×** year-over-year and the
user base having tripled in the prior three months ([Highland
Europe](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/)).

### The "fair-code" / Sustainable Use License — source-available, NOT OSI-open

This is the licensing angle that makes n8n notable in the broader
open-source-relicensing debates (the same family of tensions documented for
Commons Clause / BSL in
`history/WASM_DOCKER_alternate_history.md` and the Terraform→OpenTofu and other
relicensing stories elsewhere in this repo).

- n8n **originally** used **Apache 2.0 + the Commons Clause** — i.e., a
  permissive open-source license with a rider that forbade *selling* the
  software ([Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n)).
- In **March 2022**, n8n **relicensed** to its own **Sustainable Use License
  (SUL)**, which it brands as **"fair-code"**
  ([Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n);
  [n8n docs: Sustainable Use License](https://docs.n8n.io/sustainable-use-license/)).
- **fair-code** is a model — explicitly created by **Jan Oberhauser and Kenneth
  Malac** ([faircode.io](https://faircode.io/)) — under which software is
  "generally free to use and can be distributed by anybody," with source code
  "openly available" and extensible by anyone, **but commercially restricted by
  its authors**: only the creators may monetize it commercially; third parties
  must negotiate a commercial license. fair-code's own site states it is
  **"not the same as open-source or OSI-approved"** and positions itself as an
  alternative addressing developer-compensation/sustainability concerns
  ([faircode.io](https://faircode.io/)).

The practical effect: n8n is **source-available** (you can read, self-host, and
modify it for internal business purposes) but is **not OSI-licensed open
source**. This is the recurring industry fault line — the same "we want the
benefits of open source without letting hyperscalers resell our work" motivation
behind Commons Clause, the BSL, the SSPL, and the relicensing waves covered
elsewhere in this collection.

> **Opinion, attributed:** Whether "fair-code" is a legitimate category or a
> marketing euphemism for "not open source" is a contested framing. This doc
> does not adjudicate it; n8n/faircode.io assert it is a distinct, better model
> ([faircode.io](https://faircode.io/)), while the OSI's definition of open
> source (not cited inline here) would by construction exclude SUL because it
> restricts commercial use.

### Funding history (verified)

| Round | Date | Amount | Valuation | Lead / notable investors |
|-------|------|--------|-----------|--------------------------|
| Seed | Mar 2020 | ~$1.5M | — | **Sequoia Capital** + firstminute capital (co-led) |
| Series A | Apr 2021 | $12M | — | **Felicis Ventures** (Sequoia, firstminute, Harpoon also participated) |
| Series B | Mar 24, 2025 | **€55M** (~$60M) | not disclosed | **Highland Europe** (HV Capital, Sequoia, Felicis, Harpoon) |
| Series C | Oct 9, 2025 | **$180M** | **$2.5B** | **Accel** (lead); **NVentures/NVIDIA**, Meritech, Redpoint, T.Capital, Visionaries Club; prior backers followed on |

Sources: [Wikipedia: n8n](https://en.wikipedia.org/wiki/N8n) (seed, Series A,
Series B); [Highland Europe](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/)
(Series B €55M, March 24 2025); [n8n blog: Series C](https://blog.n8n.io/series-c/)
and [Bloomberg](https://www.bloomberg.com/news/articles/2025-10-09/ai-agent-startup-n8n-nets-2-5-billion-valuation-with-backing-from-nvidia)
(Series C $180M at $2.5B, NVIDIA participation, Oct 9 2025). The n8n blog states
total funding reached **$240M** after the Series C ([n8n blog](https://blog.n8n.io/series-c/)).

**Correction to common shorthand:** The 2020 Sequoia round was a **seed**
(~$1.5M), and the **Series A** (April 2021) was **led by Felicis**, with Sequoia
participating — so "2020 Series A led by Sequoia" conflates the two. Sequoia's
involvement is real, but as seed co-lead and ongoing backer, not as Series A
lead.

- **Could not verify:** A separate, *larger* "multi-billion-dollar" 2025 round
  beyond the **$180M Series C at $2.5B**. The largest verified 2025 raise is the
  Accel-led Series C; reporting describing n8n as a "multi-billion valuation"
  refers to the **$2.5B** post-money valuation, not a multi-billion *raise*. If
  a still-larger round closed after October 2025, it is not confirmed by the
  sources consulted here.

The Series C was widely framed by the press as an **AI-agent story** — Bloomberg
headlined it "**AI Agent Startup n8n**" and emphasized NVIDIA's backing
([Bloomberg](https://www.bloomberg.com/news/articles/2025-10-09/ai-agent-startup-n8n-nets-2-5-billion-valuation-with-backing-from-nvidia)).
n8n's own framing: by the March 2025 raise, LLM integrations represented **over
75% of workflows** on the platform ([Highland Europe](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/)).

---

## The automation / iPaaS players

"iPaaS" = **integration platform as a service**: cloud services that connect
SaaS apps and automate cross-app workflows. n8n's most direct comparison set.

### Zapier (2011/2012)

- **Founders:** Wade Foster, Bryan Helmig, Mike Knoop — University of Missouri
  ([Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier)).
- **Founding date nuance:** began as a **side project in 2011** in Columbia,
  Missouri; **company launched** (public beta) in **2012**; joined **Y
  Combinator's Summer 2012** batch ([Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier)).
- **Bootstrapped to scale:** famously capital-efficient and remote-first. In
  **January 2021**, **Sequoia Capital and Steadfast Financial** bought shares
  from early investors in a **secondary transaction valuing Zapier at ~$5B**;
  none of the founders sold, and terms (amount/participants) were not disclosed
  ([Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier)).
- **Could not verify (precisely):** ARR figures. Podcast/press summaries cite
  figures like "$140M ARR" alongside the $5B valuation
  ([20VC summary via Deciphr](https://www.deciphr.ai/podcast/20vc-scaling-zapier-to-140m-arr-and-a-5bn-valuation-on-14m-of-funding-what-founders-misunderstand-about-fundraising--how-founders-should-think-about-secondaries-today-with-wade-foster-founder--ceo--zapier)),
  but Wikipedia carries no ARR figure and this could not be confirmed against a
  primary source — treat ARR numbers as reported-but-unverified.

### Make (formerly Integromat) (2012)

- **Integromat** launched in **2012** in **Czechia**; pitched as a more powerful,
  "enterprise Zapier"-style scenario builder.
- **Acquired by Celonis** (the German/US process-mining company) on **October
  14, 2020** for **">$100M"** per Celonis's CEO; at acquisition Integromat had
  ~11,000 customers ([TechCrunch](https://techcrunch.com/2020/10/14/celonis-acquires-czech-startup-integromat-to-accelerate-move-to-process-automation/)).
- **Rebranded to Make** in **February 2022** ([BusinessWire](https://www.businesswire.com/news/home/20220222005231/en/Integromat-Evolves-to-Make-Expanding-Its-Vision-to-Empower-Creators-to-Innovate-Without-Limits)).
- For context: **Celonis** itself was founded in **2011** by Alex Rinke, Bastian
  Nominacher, and Martin Klenk as a TUM spin-off ([Wikipedia: Celonis](https://en.wikipedia.org/wiki/Celonis)).

### Microsoft Power Automate (2016)

- Launched as **Microsoft Flow**, **announced April 27, 2016** ([Power Platform
  blog](https://www.microsoft.com/en-us/power-platform/blog/2016/04/27/welcome-to-microsoft-flow/))
  and **generally available November 1, 2016** ([Wikipedia: Power
  Automate](https://en.wikipedia.org/wiki/Microsoft_Power_Automate)).
- Explicitly positioned as Microsoft's answer to IFTTT and Zapier; later renamed
  **Power Automate** and folded into the **Power Platform** (alongside Power
  Apps, Power BI) ([Wikipedia: Power Automate](https://en.wikipedia.org/wiki/Microsoft_Power_Automate)).

### Tray.io / Tray.ai (2012)

- **Founded 2012** by **Alistair Russell, Dominic Lewis, and Rich Waldron** in
  San Francisco ([Tray.io — Golden](https://golden.com/wiki/Tray.io-4N958ZX)).
- Enterprise-focused, "general-purpose automation" iPaaS; has rebranded toward
  **Tray.ai** in the AI era ([Tray.ai about](https://tray.io/about)).

### Workato (founded 2013)

- Enterprise iPaaS / "integration-led automation." Raised a **$200M Series E**
  in **November 2021** at a **$5.7B** valuation (Battery Ventures, Altimeter,
  Insight, Tiger Global, Redpoint), bringing total funding to ~$421M
  ([Contrary Research: Workato](https://research.contrary.com/company/workato)).
- **Could not verify:** Reports that Workato's **secondary-market valuation fell
  toward ~$1.7B by mid-2025** appear in
  [Sacra](https://sacra.com/c/workato/) and aggregators, but this is
  secondary-market estimation, not a primary round, and is flagged as
  unconfirmed against a primary source.

### Pipedream (founded ~2018)

- Developer-centric "workflow + integration" platform (code-first, serverless
  steps). Raised a **$20M Series A** led by True Ventures (~$22.4M total)
  ([Crunchbase: Pipedream](https://www.crunchbase.com/organization/pipedream)).
- **Acquired by Workday** on **November 19, 2025** ([Reworked](https://www.reworked.co/talent-management/workday-buys-low-code-ai-integration-platform-pipedream/)).
- **Could not verify:** The exact founding year (sources give **2018 or 2019**)
  and the founders' names (aggregators disagree). Flagged.

### IFTTT (2010 project / 2011 launch)

- **"If This Then That"** — the consumer-facing automation pioneer. Founded
  ~**2010**, launched publicly **2011**; founders include **Linden Tibbets**
  (CEO) with Alexander Tibbets, Jesse Tane, and Scott Tong
  ([IFTTT: 15 years](https://ifttt.com/explore/celebrating-15-years-ifttt);
  [Wikipedia: IFTTT](https://en.wikipedia.org/wiki/IFTTT)).
- Distinct from the others in being **consumer/smart-home oriented** (applets
  connecting apps, devices, social services) rather than enterprise iPaaS.

### Boomi (Dell → private equity)

- iPaaS originally **Dell Boomi**. On **May 2/3, 2021**, **Dell** agreed to sell
  **Boomi** to **Francisco Partners and TPG** for **$4B** in cash
  ([TechCrunch](https://techcrunch.com/2021/05/03/dell-dumps-another-big-asset-moving-boomi-to-francisco-partners-and-tpg-for-4b/);
  [Dell 8-K, SEC](https://www.sec.gov/Archives/edgar/data/0001571996/000157199621000010/pressreleaseforboomi.htm)).

### MuleSoft (→ Salesforce)

- API/integration platform. **Salesforce agreed to acquire MuleSoft on March 20,
  2018** for an enterprise value of **~$6.5B**; MuleSoft shares stopped trading
  before market open on **May 2, 2018**
  ([Wilson Sonsini](https://www.wsgr.com/en/insights/mulesoft-to-be-acquired-by-salesforce-for-6-5-billion.html);
  [MuleSoft 8-K, SEC](https://www.sec.gov/Archives/edgar/data/0001374684/000119312518089357/d554902dex991.htm)).
- One of the largest software acquisitions of its era and the anchor of
  Salesforce's "Integration Cloud."

---

## Low-code app builders

Distinct from iPaaS: these build **applications/UIs** (internal tools, websites,
databases-as-apps) with little or no code, rather than wiring app-to-app
workflows.

### Retool (2017)

- **Founded 2017** by **David Hsu**; builds **internal tools / admin panels /
  dashboards** fast by composing pre-built components over your data sources
  ([Sequoia: Retool spotlight](https://sequoiacap.com/article/david-hsu-retool-spotlight/)).
- Raised a **$45M round in July 2022 at a $3.2B valuation**, **Sequoia-backed**,
  with angels including Stripe's Collison brothers, Nat Friedman, and Elad Gil
  ([Yahoo/TechCrunch](https://finance.yahoo.com/news/retool-raises-45m-3-2b-130328028.html)).

### Bubble (2012)

- **Founded 2012** by **Emmanuel Straschnov and Joshua (Josh) Haas**; a
  **no-code** platform to build full web apps visually
  ([Wikipedia: Emmanuel Straschnov](https://en.wikipedia.org/wiki/Emmanuel_Straschnov);
  [Bubble origin story](https://bubble.io/blog/about-bubble/)).
- Notably **bootstrapped for ~7 years** before raising; a **$100M Series A**
  came later ([Built In NYC](https://www.builtinnyc.com/articles/bubble-raises-100m-series-a-hiring)).
- **Could not verify:** The precise date of the $100M Series A from a primary
  source (Built In reports it; year not independently confirmed here). Flagged.

### Webflow (2013)

- **Founded 2013** by **Vlad Magdalin, Sergie Magdalin, and Chris Schleifer**;
  a **visual web-design / no-code website builder** (drag-and-drop responsive
  design, hosting, CMS, e-commerce).
- Vlad Magdalin was reportedly **rejected ~60 times** pitching it; in **2021**
  Webflow raised **$140M at a $4B valuation**
  ([WeAreFounders](https://www.wearefounders.uk/from-zero-to-4-billion-how-vlad-magdalin-built-webflow-into-a-no-code-empire/)).
- **Could not verify:** the exact 2013 month and the $140M round's exact close
  date from a primary (company/SEC) source — the founding year and $4B/$140M
  figures come from the secondary source above. Flagged for precision.

### Airtable (2012)

- **Founded 2012** by **Howie Liu, Andrew Ofstad, and Emmett Nicholas**; a
  **spreadsheet-database hybrid** that became a low-code app/database platform
  ([Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable)).
- **December 2021: Series F $735M at $11B valuation**; >$1.3B raised total
  ([Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable)).
- Liu previously co-founded **Etacts** (2009), acquired by Salesforce in 2010
  ([Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable)).

### Open-source Retool alternatives: Appsmith, Budibase, ToolJet

A cohort of **open-source low-code internal-tool builders** positioned as
alternatives to Retool:

- **Appsmith** — widely adopted open-source drag-and-drop internal-tool builder
  (dashboards, admin panels, CRUD apps, with JavaScript).
- **Budibase** — open-source low-code platform focused on generating internal
  tools from your data.
- **ToolJet** — open-source builder for complex workflows / AI-powered internal
  tools, supporting Python, SQL, and JavaScript.

Source (comparison, vendor-authored — note bias): [ToolJet blog: Appsmith vs
Budibase vs ToolJet](https://blog.tooljet.com/appsmith-vs-budibase-vs-tooljet/).
- **Could not verify:** Founding years/funding for Appsmith, Budibase, and
  ToolJet were not independently confirmed in this pass — only their existence
  and positioning as open-source Retool alternatives is sourced. Flagged for a
  follow-up if exact dates/rounds are needed.

---

## Enterprise low-code

The "big platform" end of low-code, sold to enterprise IT for line-of-business
app development.

### OutSystems (2001)

- **Founded 2001** by **Paulo Rosado** in **Lisbon, Portugal**
  ([Wikipedia: OutSystems](https://en.wikipedia.org/wiki/OutSystems)).
- **February 17, 2021: raised $150M at a ~$9.5B valuation** (round led by Abdiel
  Capital and Tiger Global) — a landmark valuation for the category
  ([TechCrunch](https://techcrunch.com/2021/02/17/low-code-focused-outsystems-raises-150m-at-a-9-5b-valuation/);
  [OutSystems press](https://www.outsystems.com/news/modern-application-platform-investment/)).
- **Could not verify (fully):** Reports that the **$9.5B valuation was later cut
  roughly in half** in a subsequent round appear in
  [ISVWorld](https://www.isvworld.com/search/news/1279951), but the specifics
  (date, new figure) were not confirmed against a primary source here. Flagged.
- In **2025**, OutSystems appointed **Woodson Martin** as CEO, with Rosado moving
  to chairman ([per search aggregation — see OutSystems search results;
  primary press release not fetched]). **Could not verify** the exact date.

### Mendix (2005 → Siemens 2018)

- Dutch enterprise low-code platform. **Siemens agreed to acquire Mendix in
  August 2018** for **~$730M (€0.6B)** plus a multi-year R&D investment; deal
  **closed October 1, 2018**
  ([Mendix blog](https://www.mendix.com/blog/siemens-to-acquire-mendix/);
  [Schnitger Corp.](https://schnitgercorp.com/2018/10/01/siemens-closes-mendix-acquisition-heres-why-it-matters/);
  [Siemens press](https://press.siemens.com/global/en/pressrelease/siemens-strengthens-its-digital-enterprise-leadership-acquisition-mendix)).
- Described at the time as the **largest-ever investment in the low-code
  category** ([PRNewswire](https://www.prnewswire.com/news-releases/mendixs-hyper-growth-continued-in-2018-with-150-year-over-year-us-revenue-increase-siemens-acquisition-marks-largest-ever-investment-in-low-code-category-300795472.html)).

---

## Key people, companies & funding (consolidated)

| Person | Company | Role | Source |
|--------|---------|------|--------|
| **Jan Oberhauser** | n8n / fair-code | Founder & CEO; co-created fair-code | [n8n press](https://n8n.io/press/); [faircode.io](https://faircode.io/) |
| Kenneth Malac | fair-code | Co-creator of the fair-code model | [faircode.io](https://faircode.io/) |
| **Wade Foster** | Zapier | Co-founder & CEO | [Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier) |
| Bryan Helmig | Zapier | Co-founder (CTO) | [Wikipedia: Zapier](https://en.wikipedia.org/wiki/Zapier) |
| **Mike Knoop** | Zapier; ARC Prize; Ndea | Co-founder; later launched ARC Prize (2024) and AI lab Ndea | [Sequoia podcast](https://sequoiacap.com/podcast/training-data-mike-knoop/) |
| **Linden Tibbets** | IFTTT | Co-founder & CEO | [IFTTT: 15 years](https://ifttt.com/explore/celebrating-15-years-ifttt) |
| **David Hsu** | Retool | Founder | [Sequoia: Retool](https://sequoiacap.com/article/david-hsu-retool-spotlight/) |
| **Emmanuel Straschnov** & Joshua Haas | Bubble | Co-founders | [Wikipedia](https://en.wikipedia.org/wiki/Emmanuel_Straschnov) |
| **Vlad Magdalin** (+ Sergie Magdalin, Chris Schleifer) | Webflow | Co-founders | [WeAreFounders](https://www.wearefounders.uk/from-zero-to-4-billion-how-vlad-magdalin-built-webflow-into-a-no-code-empire/) |
| **Howie Liu** (+ Ofstad, Nicholas) | Airtable | Co-founders | [Wikipedia: Airtable](https://en.wikipedia.org/wiki/Airtable) |
| **Paulo Rosado** | OutSystems | Founder & (then) CEO | [Wikipedia: OutSystems](https://en.wikipedia.org/wiki/OutSystems) |

**Funding/exit headline figures (verified above):** n8n $2.5B (Oct 2025);
Zapier $5B secondary (Jan 2021); Make/Integromat acquired by Celonis >$100M
(2020); OutSystems $9.5B (Feb 2021); Mendix → Siemens ~$730M (2018); MuleSoft →
Salesforce ~$6.5B (2018); Boomi → Francisco Partners/TPG $4B (2021); Retool $3.2B
(2022); Airtable $11B (2021); Webflow $4B (2021); Workato $5.7B (2021); Pipedream
→ Workday (2025).

---

## The AI-agent automation wave (2024–2025)

The defining shift of this period: tools that spent a decade perfecting
**trigger-action workflows** repositioned as **AI-agent platforms** — "agentic
automation." (For the broader AI-agent platform wave and its
"next-Docker"-style hype dynamics, see
`history/WASM_DOCKER_alternate_history.md`.)

**Why automation tools, specifically.** LLM-based agents need (a) a library of
integrations to *act* in the world and (b) an orchestration substrate with
memory, branching, and human-in-the-loop checkpoints — which is precisely what
iPaaS/workflow tools already had. So the automation vendors were unusually
well-placed to ride the agent wave.

- **n8n** became the poster child. It shipped deep AI/agent tooling (LangChain
  integration, agent nodes, RAG/vector-DB integrations, persistent memory,
  human-in-the-loop patterns), and by early 2025 **LLM integrations made up >75%
  of workflows** on the platform ([Highland Europe](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/)).
  The **$180M Series C at $2.5B with NVIDIA backing** (Oct 2025) was explicitly
  an AI-agent narrative — Bloomberg literally called it an "**AI Agent
  Startup**" ([Bloomberg](https://www.bloomberg.com/news/articles/2025-10-09/ai-agent-startup-n8n-nets-2-5-billion-valuation-with-backing-from-nvidia)).
  Oberhauser's framing: n8n sits "in between" full autonomy and full control,
  "giving flexible control over where your agents sit on this spectrum"
  ([n8n blog: Series C](https://blog.n8n.io/series-c/)).

- **Zapier** launched **Zapier Agents** for autonomous task execution across its
  large app catalog and added an AI "Copilot" to build automations from natural
  language. Per
  [Composio's analysis](https://composio.dev/content/outgrowing-make-zapier-n8n-ai-agents),
  Zapier's edge is integration breadth (thousands of pre-built connectors).
  - **Could not verify (precisely):** specific dates ("May 2025") and the exact
    "8,000+ apps" count for Zapier Agents — these come from third-party
    summaries ([AutomationAtlas](https://automationatlas.io/guides/ai-agents-in-automation-2026/);
    [DigitalApplied](https://www.digitalapplied.com/blog/marketing-automation-ai-agents-make-zapier-n8n-2026))
    rather than a Zapier primary source fetched here. Treat the existence of
    Zapier Agents/Copilot as sourced, but specific dates/counts as
    reported-but-unverified.

- **Make** introduced **"Maia,"** an AI assistant that builds scenarios from
  natural language ([AI Multiple](https://research.aimultiple.com/no-code-ai-agent-builders/)).
  - **Could not verify:** Maia's launch date / a Make primary-source
    announcement — flagged.

- **The macro trend, attributed:** Market-research aggregators describe
  explosive demand for multi-agent systems — e.g.,
  [AutomationAtlas](https://automationatlas.io/guides/ai-agents-in-automation-2026/)
  cites the AI-agent market growing from ~$7.84B (2025) to a projected ~$52.62B
  (2030) at ~46% CAGR, and a 1,445% surge in multi-agent-system inquiries Q1
  2024→Q2 2025. **Could not verify:** these specific market-sizing numbers
  against the underlying primary research firm; they are presented as the
  aggregator's claims, not as established fact.

**A telling personal data point on the wave:** Zapier co-founder **Mike Knoop**
pivoted personally into frontier AI — launching the **ARC Prize** (an
AGI-progress benchmark, with François Chollet) in **June 2024** and co-founding
the AI lab **Ndea** — a signal that even the automation founders saw the center
of gravity moving to AI/agents
([Sequoia podcast](https://sequoiacap.com/podcast/training-data-mike-knoop/)).
- **Could not verify:** the exact founding date/details of **Ndea** from a
  primary source — flagged.

---

## Sources (primary / load-bearing)

- n8n: [Wikipedia](https://en.wikipedia.org/wiki/N8n) ·
  [Series C blog](https://blog.n8n.io/series-c/) ·
  [Bloomberg Series C](https://www.bloomberg.com/news/articles/2025-10-09/ai-agent-startup-n8n-nets-2-5-billion-valuation-with-backing-from-nvidia) ·
  [Highland Europe Series B](https://www.highlandeurope.com/n8n-raises-e55-million-from-highland-europe-to-transform-workflow-automation-for-technical-teams-by-unifying-ai-code-and-human-building-blocks/) ·
  [n8n press](https://n8n.io/press/) ·
  [Sustainable Use License docs](https://docs.n8n.io/sustainable-use-license/) ·
  [faircode.io](https://faircode.io/)
- Zapier: [Wikipedia](https://en.wikipedia.org/wiki/Zapier) ·
  [Sequoia/ARC — Mike Knoop](https://sequoiacap.com/podcast/training-data-mike-knoop/)
- Make/Integromat/Celonis: [TechCrunch (acquisition)](https://techcrunch.com/2020/10/14/celonis-acquires-czech-startup-integromat-to-accelerate-move-to-process-automation/) ·
  [BusinessWire (rebrand)](https://www.businesswire.com/news/home/20220222005231/en/Integromat-Evolves-to-Make-Expanding-Its-Vision-to-Empower-Creators-to-Innovate-Without-Limits)
- Power Automate: [Microsoft blog](https://www.microsoft.com/en-us/power-platform/blog/2016/04/27/welcome-to-microsoft-flow/) ·
  [Wikipedia](https://en.wikipedia.org/wiki/Microsoft_Power_Automate)
- MuleSoft: [Wilson Sonsini](https://www.wsgr.com/en/insights/mulesoft-to-be-acquired-by-salesforce-for-6-5-billion.html) ·
  [SEC 8-K](https://www.sec.gov/Archives/edgar/data/0001374684/000119312518089357/d554902dex991.htm)
- Boomi: [TechCrunch](https://techcrunch.com/2021/05/03/dell-dumps-another-big-asset-moving-boomi-to-francisco-partners-and-tpg-for-4b/) ·
  [Dell SEC 8-K](https://www.sec.gov/Archives/edgar/data/0001571996/000157199621000010/pressreleaseforboomi.htm)
- Retool: [Sequoia](https://sequoiacap.com/article/david-hsu-retool-spotlight/) ·
  [Yahoo/TechCrunch funding](https://finance.yahoo.com/news/retool-raises-45m-3-2b-130328028.html)
- Bubble: [Wikipedia: Straschnov](https://en.wikipedia.org/wiki/Emmanuel_Straschnov) ·
  [Bubble origin](https://bubble.io/blog/about-bubble/)
- Webflow: [WeAreFounders](https://www.wearefounders.uk/from-zero-to-4-billion-how-vlad-magdalin-built-webflow-into-a-no-code-empire/)
- Airtable: [Wikipedia](https://en.wikipedia.org/wiki/Airtable)
- OutSystems: [Wikipedia](https://en.wikipedia.org/wiki/OutSystems) ·
  [TechCrunch](https://techcrunch.com/2021/02/17/low-code-focused-outsystems-raises-150m-at-a-9-5b-valuation/) ·
  [OutSystems press](https://www.outsystems.com/news/modern-application-platform-investment/)
- Mendix: [Mendix blog](https://www.mendix.com/blog/siemens-to-acquire-mendix/) ·
  [Siemens press](https://press.siemens.com/global/en/pressrelease/siemens-strengthens-its-digital-enterprise-leadership-acquisition-mendix) ·
  [Schnitger](https://schnitgercorp.com/2018/10/01/siemens-closes-mendix-acquisition-heres-why-it-matters/)
- IFTTT: [IFTTT 15 years](https://ifttt.com/explore/celebrating-15-years-ifttt) ·
  [Wikipedia](https://en.wikipedia.org/wiki/IFTTT)
- Workato: [Contrary Research](https://research.contrary.com/company/workato)
- Pipedream: [Crunchbase](https://www.crunchbase.com/organization/pipedream) ·
  [Reworked (Workday acq.)](https://www.reworked.co/talent-management/workday-buys-low-code-ai-integration-platform-pipedream/)
- AI-agent wave (aggregators, attributed as such): [Composio](https://composio.dev/content/outgrowing-make-zapier-n8n-ai-agents) ·
  [AutomationAtlas](https://automationatlas.io/guides/ai-agents-in-automation-2026/) ·
  [AI Multiple](https://research.aimultiple.com/no-code-ai-agent-builders/)
