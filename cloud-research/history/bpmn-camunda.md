# BPMN, Camunda & Business-Process Orchestration — A Sourced History

This document traces the lineage of **business-process modeling and execution**:
the **standards** (BPMN, BPEL, DMN, CMMN), the **open-source engine family tree**
(jBPM → Activiti → Camunda BPM / Flowable), the **company Camunda** (consultancy →
product vendor → cloud-native process-orchestration platform), and the surrounding
landscape (Bonita, Drools, and the "visual BPMN vs. code-first" convergence).

Every non-trivial claim below is linked to a primary or reputable secondary source.
Where a date or fact could not be confirmed against a working source, it is marked
**"Could not verify: X"** rather than guessed. Opinions are attributed to whoever
voiced them.

### Cross-references (not duplicated here)

- **Workflow-orchestration landscape / Temporal / durable-execution.** The broader
  story of *code-first* workflow orchestration — Apache Airflow, Cadence, and
  **Temporal** (workflow-as-code, durable execution) — lives in
  `history/airflow.md`. This document covers the *BPMN / visual process-model*
  branch of orchestration and only touches Temporal at the point where the two
  worlds converge (see **The orchestration convergence**, below). If
  `history/airflow.md` is not yet present in this repo, treat that file as the
  intended home for the Temporal/Cadence/Airflow narrative.
- **Drools / business rules** appear here only as they relate to process/decision
  automation (DMN, jBPM's sibling project at JBoss/Red Hat).

---

## Timeline

### 2000–2003 — Origins of the standards and the first open-source engine

- **Late 2000** — The **Business Process Management Initiative (BPMI)** is formed; it
  begins by developing an XML process-execution language (BPML). Stephen White recalls
  BPMI "formed in late 2000." — Stephen A. White interview,
  https://blog.leonardo.com.au/the-origins-of-bpmn-interview-with-stephen-white
- **2001** — **BPMI Notation Working Group** convenes. **Stephen A. White (IBM)**:
  "I attended the early BPMI meeting in 2001 and volunteered to chair the notation
  working group when that was formed." White says he "ended up writing the majority of
  that first BPMN 1.0 specification." — Stephen A. White interview,
  https://blog.leonardo.com.au/the-origins-of-bpmn-interview-with-stephen-white
- **2001** — Separately, the **Drools** rules engine is started by **Bob McWhirter** as
  a SourceForge project (later relevant to the JBoss/Red Hat process+rules stack). —
  Wikipedia, *Drools*, https://en.wikipedia.org/wiki/Drools ; KIE community blog,
  https://blog.kie.org/2009/06/drools-a-reflection-on-5-years.html
- **July 2002** — **BPEL4WS 1.0** (Business Process Execution Language for Web Services)
  is published as a joint effort of **IBM, Microsoft, and BEA Systems**, merging IBM's
  **WSFL** and Microsoft's **XLANG**. — Wikipedia, *Business Process Execution Language*,
  https://en.wikipedia.org/wiki/Business_Process_Execution_Language
- **~2002–2003** — **Tom Baeyens** (based in Belgium) begins the **jBPM** open-source
  workflow engine. **jBPM 1.0** is released around **December 2003** under the GPL. —
  LinuxInsider (Oct 2004), https://www.linuxinsider.com/story/jboss-introduces-workflow-engine-for-bpm-37407.html
- **May 2003** — **BPEL4WS 1.1**, with additional contributors (SAP, Siebel), is
  released and gains broad vendor support. — Wikipedia, *Business Process Execution
  Language*, https://en.wikipedia.org/wiki/Business_Process_Execution_Language

### 2004–2007 — BPMN 1.0, jBPM joins JBoss, BPEL becomes an OASIS standard

- **3 May 2004** — **BPMN 1.0** is released to the public by **BPMI**, the product of
  the Notation Working Group chaired by Stephen A. White. — OMG-hosted spec PDF,
  https://www.omg.org/bpmn/Documents/BPMN_V1-0_May_3_2004.pdf ; Trisotech, *BPMN
  Introduction and History*, https://www.trisotech.com/bpmn-introduction-and-history/
- **October 2004** — **JBoss hires Tom Baeyens** and launches **jBPM 2.0**, relicensing
  from GPL to the more business-friendly **LGPL**. — LinuxInsider,
  https://www.linuxinsider.com/story/jboss-introduces-workflow-engine-for-bpm-37407.html
- **June 2005** — **BPMI merges into the OMG (Object Management Group)**, which assumes
  maintenance of BPMN. — Trisotech, https://www.trisotech.com/bpmn-introduction-and-history/ ;
  Wikipedia, *Business Process Model and Notation*,
  https://en.wikipedia.org/wiki/Business_Process_Model_and_Notation
- **2005** — Drools is "federated into JBoss" (briefly rebranded *JBoss Rules*). — KIE
  blog, https://blog.kie.org/2009/06/drools-a-reflection-on-5-years.html
- **February 2006** — OMG releases the first **BPMN specification document** under its
  own banner. — Trisotech, https://www.trisotech.com/bpmn-introduction-and-history/
- **2006** — **Red Hat acquires JBoss** (carrying jBPM and Drools into Red Hat). — KIE
  blog, https://blog.kie.org/2009/06/drools-a-reflection-on-5-years.html
- **April 2007** — **WS-BPEL 2.0** is approved as an **OASIS Standard**, the product of
  the OASIS WSBPEL Technical Committee (active April 2003 – May 2007), with 37+
  contributing organizations. — Wikipedia, *Business Process Execution Language*,
  https://en.wikipedia.org/wiki/Business_Process_Execution_Language ; OASIS WSBPEL TC,
  https://www.oasis-open.org/committees/wsbpel/ipr.php

### 2008 — Camunda the consultancy is founded; BPMN 1.1

- **January 2008** — **BPMN 1.1** is published (adds choreography modeling; refines
  events into "catching"/"throwing"). — Wikipedia, *Business Process Model and Notation*,
  https://en.wikipedia.org/wiki/Business_Process_Model_and_Notation
- **2008** — **Camunda** is founded in **Berlin, Germany** (as *Camunda Services GmbH*)
  by **Jakob Freund** and **Bernd Rücker** — initially a **BPM consulting firm**. —
  Wikipedia, *Camunda*, https://en.wikipedia.org/wiki/Camunda

### 2009–2010 — BPMN 1.2; the Activiti fork; Bonitasoft

- **January 2009** — **BPMN 1.2** (editorial/bug-fix revision). — Wikipedia, *Business
  Process Model and Notation*, https://en.wikipedia.org/wiki/Business_Process_Model_and_Notation
- **2009** — **Bonitasoft** is founded in France by **Miguel Valdés Faura**, **Charles
  Souillard**, and **Rodrigue Le Gall** to commercialize the **Bonita** open-source BPM
  project (originally created ~2001 at **INRIA**, France's national CS research
  institute, by Valdés Faura and a team led by François Charoy). — Wikipedia, *Bonita
  BPM*, https://en.wikipedia.org/wiki/Bonita_BPM ; Open Source Underdogs (Ep. 55),
  https://opensourceunderdogs.com/episode-55-bonitasoft-miguel-valdes-faura/
- **March 2010** — **Tom Baeyens and Joram Barrez leave Red Hat/JBoss** to start
  **Activiti** at **Alfresco**. — Wikipedia, *Activiti (software)*,
  https://en.wikipedia.org/wiki/Activiti_(software)
- **17 May 2010** — Alfresco announces the **Activiti** project: an **Apache 2.0–licensed**
  BPMN 2.0 engine, with Baeyens as Chief Architect. The Apache license was the explicit
  motivation — OEMs were wary of jBPM's LGPL ("any open source license with the letter
  G in it"). — InfoQ, https://www.infoq.com/news/2010/05/tom_baeyens_and_alfresco_activit/ ;
  Alfresco & Share blog,
  https://alfrescoshare.wordpress.com/2010/05/17/alfresco-is-doing-strong-investment-in-workflow-and-bpm-apache-licensed-activiti-open-source-project/
- **December 2010** — **Activiti 5.0 GA** ships. The "5.0" version number signals
  continuity with "jBPM 1 through 4," though Activiti is **a new codebase, not derived
  from jBPM code**. — Wikipedia, *Activiti (software)*,
  https://en.wikipedia.org/wiki/Activiti_(software) ; InfoQ,
  https://www.infoq.com/news/2010/12/activiti_5_released/

### 2011 — BPMN 2.0: the executable standard

- **January 2011** — **BPMN 2.0** is published by the OMG. This is the watershed: it adds
  **execution semantics** and a standard **XML serialization**, so a BPMN diagram becomes
  an *executable* artifact, not just documentation. The name was amended from "Business
  Process Modeling Notation" to **"Business Process Model *and* Notation"** to reflect
  this. — Wikipedia, *Business Process Model and Notation*,
  https://en.wikipedia.org/wiki/Business_Process_Model_and_Notation ; OMG BPMN 2.0 spec
  page, https://www.omg.org/spec/BPMN/2.0/
  - This is the standard the entire Activiti/Camunda/Flowable engine family executes.

### 2012–2013 — Camunda becomes a product vendor and forks Activiti

- **2012** — Camunda (already with a 250+ customer consulting base built over ~4 years)
  enters the BPM vendor market with its **camunda fox** BPM platform (built on Activiti).
  — Camunda blog, *Camunda forks Activiti and launches*,
  https://camunda.com/blog/2013/03/camunda-forks-activiti-and-launches/
- **18 March 2013** — **Camunda forks Activiti and launches Camunda BPM**, a developer-
  centric, open-source BPMN 2.0 platform (engine + REST API + Modeler + Cockpit +
  Tasklist). The announcement (by Daniel Meyer) frames the split as a divergence of
  vision after years contributing to Activiti. — Camunda blog,
  https://camunda.com/blog/2013/03/camunda-forks-activiti-and-launches/ ; analysis by
  Sandy Kemsley, *Column 2*,
  https://column2.com/2013/03/stick-a-open-source-fork-in-it-camunda-bpm-splits-from-activiti/

### 2014–2015 — The OMG "triple crown": +CMMN, +DMN

- **May 2014** — OMG publishes **CMMN 1.0** (Case Management Model and Notation), for
  less-structured, knowledge-worker "case" work that pure BPMN flows model poorly. — OMG
  CMMN 1.0 PDF, https://www.omg.org/spec/CMMN/1.0/PDF ; OMG *Triple Crown* overview,
  https://www.omg.org/intro/TripleCrown.pdf
- **December 2014** — Camunda 7.2 adds **CMMN** support (an early commercial CMMN
  implementation). — *Column 2*,
  https://column2.com/2014/12/bpm-cyber-monday-camunda-7-2-adds-tasklist-and-cmmn/
- **September 2015** — OMG publishes **DMN 1.0** (Decision Model and Notation), the
  standard for modeling decisions/decision tables (with the **FEEL** expression
  language), designed to sit alongside BPMN. — OMG DMN 1.0 spec page,
  https://www.omg.org/spec/DMN/1.0/About-DMN ; OMG DMN intro,
  https://www.omg.org/intro/DMN.pdf

  Together BPMN + CMMN + DMN form the OMG "triple crown" of process/case/decision
  standards. — OMG, https://www.omg.org/intro/TripleCrown.pdf

### 2016 — The second fork: Flowable splits from Activiti

- **October 2016** — Core Activiti developers **Joram Barrez** (a co-founder of Activiti)
  and **Tijs Rademakers** (author of *Activiti in Action*), with others, **leave Alfresco
  and fork Activiti to create Flowable**. Their stated reason: "the only way to continue
  evolving our ideas was to fork." — *ECM Architect* (Jeff Potts),
  https://ecmarchitect.com/archives/2016/10/15/4192 ; *Column 2*,
  https://column2.com/2016/10/another-rift-in-the-open-source-bpm-market-flowablebpm-forks-from-alfresco-activiti/
- **February 2017** — Alfresco's remaining commercial Activiti is rebranded **Alfresco
  Process Services**. — Wikipedia, *Activiti (software)*,
  https://en.wikipedia.org/wiki/Activiti_(software)

  Net result of the lineage: one root (**jBPM**), one re-implementation
  (**Activiti**), and two surviving forks of Activiti — **Camunda** (2013) and
  **Flowable** (2016).

### 2018–2021 — Funding, then Zeebe / Camunda 8

- **December 2018** — Camunda raises a **Series A of €25 million (~$28M)** led by
  **Highland Europe** — notable as a then-rare large round into a profitable, bootstrapped
  open-source company. — Highland Europe,
  https://www.highlandeurope.com/workflow-automation-innovator-camunda-secures-e25-million-in-series-a-funding/ ;
  TechCrunch, https://techcrunch.com/2021/03/22/camunda-snares-98m-series-b-as-process-automation-continues-to-flourish/
- **17 July 2019** — Camunda announces the first **production-ready release of Zeebe**, a
  **cloud-native, horizontally scalable** workflow engine for microservices that executes
  BPMN, replicates for fault tolerance, and runs **without a traditional database** (event
  streaming, Kubernetes/Kafka/Elasticsearch-native). — Camunda press release,
  https://camunda.com/press_release/camunda-releases-industrys-first-horizontally-scalable-cloud-native-workflow-engine-for-microservices/ ;
  GlobeNewswire,
  https://www.globenewswire.com/news-release/2019/07/17/1884001/0/en/Camunda-Releases-Industry-s-First-Horizontally-Scalable-Cloud-Native-Workflow-Engine-for-Microservices.html
- **22 March 2021** — Camunda raises a **Series B of €82 million (~$98M)** led by
  **Insight Partners** with Highland Europe — bringing total funding to ~**$126M**. —
  TechCrunch,
  https://techcrunch.com/2021/03/22/camunda-snares-98m-series-b-as-process-automation-continues-to-flourish/ ;
  Camunda press release,
  https://camunda.com/press_release/camunda-closes-100-million-series-b-funding-round/

### 2022–2025 — Camunda 8, $100M ARR, AI/agentic, Camunda 7 EoL

- **April 2022** — **Camunda 8** (formerly *Camunda Cloud*) is released — a re-architected
  platform built on **Zeebe** and offered as **SaaS** plus self-managed, distinct from the
  embeddable Camunda 7 Java engine. — Wikipedia, *Camunda*,
  https://en.wikipedia.org/wiki/Camunda
- **September 2024** — Camunda announces it has **crossed $100M ARR**. — Camunda blog,
  https://camunda.com/blog/2024/09/camunda-crosses-100m-arr-threshold/
- **2024** — Camunda reports revenues "over €100 million." — Wikipedia, *Camunda*,
  https://en.wikipedia.org/wiki/Camunda
- **2024–2025** — Camunda pushes into **AI / agentic process orchestration** (e.g.,
  "Camunda Copilot," agentic orchestration). — Wikipedia, *Camunda*,
  https://en.wikipedia.org/wiki/Camunda
- **14 October 2025** — Final feature release of the **Camunda 7** line (**v7.24**);
  Camunda 7 **Community Edition reaches end of life**, while 7.24 becomes an LTS release
  for Enterprise customers with maintenance through **April 2030** (extended support
  available to **April 2032**). The strategic direction is migration to Camunda 8. —
  Camunda blog, *Camunda 7 Enterprise EoL Extension*,
  https://camunda.com/blog/2025/02/camunda-7-enterprise-end-of-life-extension/ ; Camunda,
  *Migrating Solutions from Camunda 7 to Camunda 8*,
  https://camunda.com/blog/2025/02/migrating-solutions-camunda-7-camunda-8-strategy-update/

---

## The standards (BPMN, BPEL, DMN, CMMN)

**BPMN (Business Process Model and Notation).** Created inside **BPMI**'s Notation Working
Group, primary author **Stephen A. White of IBM**; **BPMN 1.0** released **3 May 2004**.
BPMI **merged into the OMG (June 2005)**, which has maintained BPMN ever since (first
OMG-branded spec Feb 2006). The crucial release is **BPMN 2.0 (January 2011)**: it added
**execution semantics** and a portable **XML format**, turning BPMN from a drawing
notation into an *executable* language — and prompting the rename from "…Modeling…" to
"…**Model and Notation**." 2.0 is what Activiti/Camunda/Flowable/jBPM all execute, and the
2.0.2 maintenance revision is published by ISO/IEC as **19510**.
Sources: OMG spec PDF https://www.omg.org/bpmn/Documents/BPMN_V1-0_May_3_2004.pdf ;
OMG BPMN 2.0 https://www.omg.org/spec/BPMN/2.0/ ;
Wikipedia https://en.wikipedia.org/wiki/Business_Process_Model_and_Notation ;
Stephen White interview https://blog.leonardo.com.au/the-origins-of-bpmn-interview-with-stephen-white

**WS-BPEL (Business Process Execution Language).** The earlier, *XML-only* (non-graphical)
execution language for orchestrating web services. **BPEL4WS 1.0 (July 2002)** was a joint
**IBM / Microsoft / BEA** spec merging IBM's WSFL and Microsoft's XLANG; **1.1 (May 2003)**
added SAP/Siebel; **WS-BPEL 2.0** became an **OASIS Standard in April 2007**. BPEL was the
SOA-era standard for service orchestration; **Apache ODE (Orchestration Director Engine)**
is the best-known open-source BPEL engine.
Note: the search pass for this doc did not retrieve a primary Apache ODE page, so specific
**Apache ODE** version/date claims are intentionally omitted. **Could not verify: precise
Apache ODE founding/release dates from a primary source.**
Sources: Wikipedia *BPEL* https://en.wikipedia.org/wiki/Business_Process_Execution_Language ;
OASIS WSBPEL TC https://www.oasis-open.org/committees/wsbpel/ipr.php

> Conceptually, BPEL is the *predecessor* idea (orchestrate SOAP services via XML), while
> BPMN 2.0 is the *successor* that won mindshare because it unified a human-readable diagram
> with an executable model. Many BPMN engines effectively displaced BPEL engines for new
> work. (This framing is the author's synthesis of the cited timeline, not a quote from any
> single source.)

**CMMN (Case Management Model and Notation), OMG, May 2014.** For *unstructured*,
knowledge-worker "case" work where the path isn't a fixed flowchart. Camunda shipped CMMN
support in 7.2 (Dec 2014). Sources: OMG https://www.omg.org/spec/CMMN/1.0/PDF ;
*Column 2* https://column2.com/2014/12/bpm-cyber-monday-camunda-7-2-adds-tasklist-and-cmmn/

**DMN (Decision Model and Notation), OMG, September 2015.** Standardizes decision logic
(decision tables + the **FEEL** expression language) so decisions can be factored out of
process flows. Sources: OMG https://www.omg.org/spec/DMN/1.0/About-DMN ;
OMG intro https://www.omg.org/intro/DMN.pdf

Together, **BPMN + CMMN + DMN** are marketed by OMG as the **"triple crown"** of
process/case/decision modeling. — https://www.omg.org/intro/TripleCrown.pdf

---

## The engine lineage (jBPM → Activiti → Camunda / Flowable)

```
                jBPM  (Tom Baeyens, ~2003; → JBoss 2004; → Red Hat 2006)
                  │   open source, GPL→LGPL; later jBPM 5/6 rebuilt on Drools/BPMN2
                  │
   Baeyens + Barrez leave Red Hat (Mar 2010), re-implement from scratch
                  ▼
              Activiti  (Alfresco, announced 17 May 2010; Apache 2.0; v5.0 GA Dec 2010)
                  │   "new code base, not based on any previous jBPM code"
        ┌─────────┴───────────────────────────┐
        ▼ (fork, 18 Mar 2013)                  ▼ (fork, Oct 2016)
   Camunda BPM                            Flowable
   (Camunda, Berlin)                      (Barrez + Rademakers et al.)
   → Camunda 7 (embeddable Java)
   → Zeebe / Camunda 8 (2019/2022, cloud-native)
```

Key facts that make this lineage precise:
- **jBPM** is the root: **Tom Baeyens**'s engine (~2003), absorbed by **JBoss (2004)** then
  **Red Hat (2006)**. (Later jBPM versions were re-architected on top of **Drools** and
  BPMN 2.0; jBPM and Drools today live under Red Hat's KIE community.) — LinuxInsider
  https://www.linuxinsider.com/story/jboss-introduces-workflow-engine-for-bpm-37407.html ;
  KIE https://blog.kie.org/2009/06/drools-a-reflection-on-5-years.html
- **Activiti** is a **clean re-implementation** (not a jBPM code fork) by the same lead
  developers, done for license reasons (Apache vs LGPL). — InfoQ
  https://www.infoq.com/news/2010/05/tom_baeyens_and_alfresco_activit/ ; Wikipedia
  https://en.wikipedia.org/wiki/Activiti_(software)
- **Camunda BPM is a *code* fork of Activiti (Mar 2013)**. — Camunda
  https://camunda.com/blog/2013/03/camunda-forks-activiti-and-launches/
- **Flowable is a *code* fork of Activiti (Oct 2016)** by Activiti's own core team. — ECM
  Architect https://ecmarchitect.com/archives/2016/10/15/4192

So Camunda and Flowable are *sibling* forks of Activiti, while Activiti itself is a
*successor* (not a fork) of jBPM.

---

## Camunda the company

- **Founded 2008, Berlin** (Camunda Services GmbH) by **Jakob Freund** and **Bernd Rücker**
  as a **BPM consultancy**. — Wikipedia https://en.wikipedia.org/wiki/Camunda
- **~2012**: enters the product market with the **camunda fox** platform (on Activiti),
  having built a **250+ customer** consulting base. — Camunda
  https://camunda.com/blog/2013/03/camunda-forks-activiti-and-launches/
- **18 Mar 2013**: **forks Activiti → Camunda BPM**, an open-source, developer-first BPMN
  platform (engine, REST API, Modeler, Cockpit, Tasklist). — Camunda
  https://camunda.com/blog/2013/03/camunda-forks-activiti-and-launches/
- **Camunda 7**: the embeddable **Java/Spring** engine model (process engine runs inside
  your app/JVM).
- **Zeebe (production-ready 17 Jul 2019) → Camunda 8 (Apr 2022)**: a re-architected,
  **cloud-native, horizontally scalable** engine, offered primarily as **SaaS**, designed
  for microservices orchestration at scale. — Camunda press release
  https://camunda.com/press_release/camunda-releases-industrys-first-horizontally-scalable-cloud-native-workflow-engine-for-microservices/ ;
  Wikipedia https://en.wikipedia.org/wiki/Camunda
- **Funding**:
  - **Series A — €25M (~$28M), Dec 2018, Highland Europe**. — Highland Europe
    https://www.highlandeurope.com/workflow-automation-innovator-camunda-secures-e25-million-in-series-a-funding/
  - **Series B — €82M (~$98M), 22 Mar 2021, Insight Partners (with Highland Europe)**;
    total ~**$126M**. — TechCrunch
    https://techcrunch.com/2021/03/22/camunda-snares-98m-series-b-as-process-automation-continues-to-flourish/ ;
    Camunda https://camunda.com/press_release/camunda-closes-100-million-series-b-funding-round/
  - **Could not verify** any *later* priced equity round from a primary source as of this
    writing; multiple trackers (e.g., Tracxn, getLatka) list only the two rounds above.
    Treat any post-2021 round as unconfirmed.
    https://tracxn.com/d/companies/camunda/__Rm5nb66MT3Ie8xcekft8rU8btRpglT0cn0liJs6uSmU/funding-and-investors
- **Scale**: **$100M ARR crossed Sep 2024**; 2024 revenue reported "over €100 million." —
  Camunda https://camunda.com/blog/2024/09/camunda-crosses-100m-arr-threshold/ ; Wikipedia
  https://en.wikipedia.org/wiki/Camunda
- **Camunda 7 sunset**: final feature release **7.24 on 14 Oct 2025**; CE end-of-life,
  Enterprise LTS maintenance to **April 2030** (extended support to **2032**). — Camunda
  https://camunda.com/blog/2025/02/camunda-7-enterprise-end-of-life-extension/

---

## Related / the landscape

**Bonita / Bonitasoft (France).** Open-source BPM, commercialized **2009** by **Miguel
Valdés Faura**, Charles Souillard, and Rodrigue Le Gall, productizing the **Bonita**
project that originated ~2001 at **INRIA**. — Wikipedia
https://en.wikipedia.org/wiki/Bonita_BPM ; Open Source Underdogs
https://opensourceunderdogs.com/episode-55-bonitasoft-miguel-valdes-faura/

**Drools (Red Hat).** Business **rules** engine (Rete-based), started by **Bob McWhirter
(2001)**, led from ~2.0 by **Mark Proctor**; into JBoss (2005) then Red Hat (2006). Pairs
with jBPM under Red Hat's KIE umbrella, and underpins DMN-style decisioning. — Wikipedia
https://en.wikipedia.org/wiki/Drools ; KIE https://blog.kie.org/2009/06/drools-a-reflection-on-5-years.html

**Flowable.** The other surviving Activiti fork (2016), maintained by Activiti's original
core team (Joram Barrez, Tijs Rademakers). Competes head-to-head with Camunda in
open-source/embeddable BPMN/CMMN/DMN. — ECM Architect
https://ecmarchitect.com/archives/2016/10/15/4192

### The orchestration convergence

By the late 2010s two "orchestration" worlds were converging on the same problems
(reliable long-running, stateful, multi-step workflows):

1. **Visual / model-first (BPMN):** Camunda, Flowable, Bonita, jBPM — a *standardized
   diagram* (BPMN 2.0) is the source of truth; business and IT share the model.
2. **Code-first / durable-execution:** **Temporal** (and its predecessor **Cadence**),
   plus the data-pipeline world of **Apache Airflow** — *application code* is the source of
   truth, with the platform providing durability/retries/state. **This branch is covered in
   `history/airflow.md` and is not duplicated here.**

Camunda's own move from the embeddable **Camunda 7** to the cloud-native, horizontally
scalable **Zeebe/Camunda 8** is essentially the BPMN camp adopting the
distributed-systems/event-streaming properties (fault tolerance, horizontal scale,
microservice orchestration) that the code-first camp championed — i.e., the two worlds
meeting in the middle. (Framing is the author's synthesis of the cited Zeebe/Camunda 8
sources, not a quote.)
— Zeebe press release
https://camunda.com/press_release/camunda-releases-industrys-first-horizontally-scalable-cloud-native-workflow-engine-for-microservices/

### Where the founders went

- **Tom Baeyens** (jBPM → Activiti) later founded the cloud BPM startup **Effektif** (Berlin,
  Dec 2012), which was **acquired by Signavio**. — Signavio
  https://www.signavio.com/news/effektif-bpm-veteran-tom-baeyens/
- **Could not verify** from a primary source the exact Effektif→Signavio acquisition date in
  this pass; the Signavio page confirms the relationship but the precise transaction date was
  not extracted.

---

## Current status (as of this writing, 2026)

- **BPMN 2.0** remains the dominant *executable* process-modeling standard; **DMN** and
  **CMMN** are its OMG companions (CMMN with notably weaker adoption than BPMN/DMN — see the
  triple-crown caveat). — https://www.omg.org/intro/TripleCrown.pdf
- **Camunda** is the commercial leader of the BPMN-engine lineage: **>$100M ARR (2024)**,
  centered on **Camunda 8** (Zeebe), with **Camunda 7** in managed sunset (CE EoL Oct 2025;
  Enterprise LTS to 2030/2032). — https://camunda.com/blog/2024/09/camunda-crosses-100m-arr-threshold/ ;
  https://camunda.com/blog/2025/02/camunda-7-enterprise-end-of-life-extension/
- **Flowable**, **Bonita**, and Red Hat's **jBPM/Drools (KIE)** continue as the other
  open-source poles of the BPMN/decision space.
- The **visual-BPMN vs. code-first** distinction is blurring: Camunda 8 brings cloud-native
  scale to the BPMN world, while Camunda and others increasingly add **AI/agentic**
  orchestration. — https://en.wikipedia.org/wiki/Camunda

### Items explicitly NOT verified (do not treat as fact)

- **Apache ODE** specific founding/release dates (no primary source fetched).
- Any **Camunda funding round after the 2021 Series B** (trackers show only two rounds).
- Exact **Effektif → Signavio** acquisition date.
- Precise **jBPM 1.0** release *day* (sourced only as "~December 2003" via a 2004 press
  account, not a primary release note).
