# Apache Airflow — A Sourced History

**Apache Airflow** is an open-source platform to **programmatically author,
schedule, and monitor workflows**. Its defining idea is *"configuration as
code"*: data pipelines are expressed as **Directed Acyclic Graphs (DAGs)**
written in **Python**, rather than in static YAML/JSON or a clickable UI. It was
created at **Airbnb** by **Maxime Beauchemin** in 2014, open-sourced in 2015,
donated to the **Apache Software Foundation** in 2016, and graduated to a
**top-level project** in 2019. It has become, in the ASF's own words, "the
de-facto standard for workflow orchestration."

> "Airflow was started in October 2014 by Maxime Beauchemin at Airbnb. It was
> open source from the very first commit and officially brought under the Airbnb
> GitHub and announced in June 2015. The project joined the Apache Software
> Foundation's Incubator program in March 2016 and the Foundation announced
> Apache Airflow as a Top-Level Project in January 2019."
> — Apache Airflow docs, *Project* page,
> https://airflow.apache.org/docs/apache-airflow/stable/project.html

> "Configuration as code ... pipelines are defined as code ... [this] allows for
> dynamic pipeline generation ... [and lets you] use [Python's] introspection
> and metaprogramming."
> — Maxime Beauchemin, *Airflow: a workflow management platform*, Airbnb
> Engineering, 2015-06-02,
> https://medium.com/airbnb-engineering/airflow-a-workflow-management-platform-46318b977fd8

### Cross-references (not duplicated here)

- **Celery** — Airflow's **CeleryExecutor** distributes task execution across a
  pool of worker processes using the Celery distributed task queue (with a
  broker such as RabbitMQ or Redis). For Celery's own history (Ask Solem, Kombu,
  Billiard) see `history/celery.md`. This document covers only how Airflow *uses*
  Celery as an executor backend.
- **PostgreSQL** — one of the two primary backends (with MySQL) for Airflow's
  **metadata database**, which stores DAG/run/task state. For PostgreSQL's own
  history see `history/postgresql.md`. Here we cover only the role of the
  metadata DB in Airflow's architecture.
- **Kubernetes** — Airflow's **KubernetesExecutor** runs each task in its own
  Kubernetes pod. For Kubernetes' own history see `history/kubernetes.md`. Here
  we cover only the executor and the KubernetesPodOperator.
- **Argo Workflows** — a *container-native*, Kubernetes-CRD-based workflow
  engine that competes with Airflow in the Kubernetes-native space. For its
  history (Applatix, Intuit, CNCF) see `history/argocd.md`.
- **Modal / Erik Bernhardsson** — Bernhardsson, creator of Spotify's **Luigi**
  (an Airflow predecessor, below), later founded **Modal**. For Modal see
  `history/WASM_DOCKER_alternate_history.md`.

---

## Timeline

### 2014 — Origins at Airbnb

- **2014-10-26** — The **oldest commit** in the `apache/airflow` Git history is
  by **Maxime Beauchemin** (GitHub `mistercrunch`), SHA
  `02b0a24b65ee2138bfbf62afa5d9b7d9b8988da8`, message *"Implementing run method
  in presto_hook (for view creation)"*, dated `2014-10-26T16:33:15Z`. The
  repository was originally `github.com/mistercrunch/Airflow` (visible in early
  merge-commit messages).
  Source (GitHub API):
  https://api.github.com/repos/apache/airflow/commits?until=2014-10-31T21:00:00Z
  - Note: the project's own docs date the start to **"October 2014"** without a
    specific day. Could not verify a single canonical "first commit" date beyond
    the Git history's oldest commit of 2014-10-26 (the project history was later
    imported into the ASF repo, so the very first private commit's date is not
    independently confirmable). The frequently-cited month "October 2014" is
    consistent with this.
- Airflow was conceived to manage Airbnb's "increasingly complex" batch data
  workflows. Beauchemin's stated motivation: existing internal/open-source
  workflow systems "grow reactively ... and [are] at least one generation behind
  the company's need."
  Source: Airbnb Engineering blog (2015), link above.

### 2015 — Open-sourced

- **2015-06-02** — Maxime Beauchemin publishes *"Airflow: a workflow management
  platform"* on the **Airbnb Engineering** blog, the public announcement of the
  open-source project. It lays out the core architecture still recognizable
  today: **DAGs in Python**, a **metadata repository** (MySQL or Postgres), a
  **scheduler**, pluggable **executors** (Sequential / Local / Celery), and
  **operators / sensors / hooks**, plus a Flask web UI.
  Source:
  https://medium.com/airbnb-engineering/airflow-a-workflow-management-platform-46318b977fd8
- **Summer 2015** — In a separate but related thread of Beauchemin's work, he
  builds **Caravel** (later **Superset**) as a hackathon project at Airbnb — a
  data-exploration/BI visualization tool (see *Key people* below).
  Source: Preset, *From Airflow to Superset*,
  https://preset.io/blog/from-airflow-to-superset-how-one-data-engineers-mission-became-an-open/

### 2016 — Apache Incubator

- **March 2016** — Airflow enters the **Apache Software Foundation Incubator**.
  Sources: ASF top-level-project announcement (2019-01-08),
  https://news.apache.org/foundation/entry/the-apache-software-foundation-announces44 ;
  Airflow docs *Project* page (link above).

### 2018 — Managed services arrive; the Kubernetes executor

- **2018-05-01** — **Google Cloud** announces **Cloud Composer**, a managed
  Apache Airflow service on Google Cloud Platform (initially in beta), the first
  hyperscaler-managed Airflow.
  - Could not fully verify the exact GA date from a primary Google source via
    the searches run. Secondary sources (Grokipedia, gcpweekly) place the
    **announcement/beta at 2018-05-01** and **GA around 2018-07-19** (Google
    Cloud Next '18). Marked: **Could not verify GA date from a Google primary
    source.** Cloud Composer is today branded "Managed Service for Apache
    Airflow."
    Sources (secondary): https://grokipedia.com/page/Google_Cloud_Composer ;
    Google Cloud Composer docs, https://docs.cloud.google.com/composer/docs
- **2018-06-28** — **Daniel Imberman** (Bloomberg LP) and collaborators publish
  *"Airflow on Kubernetes (Part 1): A Different Kind of Operator"* on the
  Kubernetes blog, introducing the **KubernetesExecutor** and the
  **KubernetesPodOperator** (each task runs in its own pod). This shipped in the
  **Airflow 1.10** line.
  Source: https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/
  (cross-ref `history/kubernetes.md`)
- **2018** — **Astronomer** commits to building its commercial platform on top
  of Apache Airflow (see *Company & ecosystem*). Per Astronomer's CEO letter the
  company "started driving that project in 2018."
  Source: https://www.astronomer.io/blog/letter-from-the-ceo-our-story-so-far/

### 2019 — Apache Top-Level Project

- **2019-01-08** — The **Apache Software Foundation announces Apache Airflow as a
  Top-Level Project (TLP)**, graduating from the Incubator. The announcement
  lists adopters including Adobe, Airbnb, Etsy, Google, ING, Lyft, PayPal,
  Reddit, Square, Twitter, and United Airlines, and quotes **Bolke de Bruin**
  (then VP of Apache Airflow): *"Since its inception, Apache Airflow has quickly
  become the de-facto standard for workflow orchestration."*
  Sources:
  https://www.globenewswire.com/news-release/2019/01/08/1681851/0/en/The-Apache-Software-Foundation-Announces-Apache-Airflow-as-a-Top-Level-Project.html ;
  https://news.apache.org/foundation/entry/the-apache-software-foundation-announces44

### 2020 — Airflow 2.0 and AWS MWAA

- **2020-11-24** — **AWS** launches **Amazon Managed Workflows for Apache Airflow
  (MWAA)** (author Danilo Poccia), available across nine regions at launch.
  Source: https://aws.amazon.com/blogs/aws/introducing-amazon-managed-workflows-for-apache-airflow-mwaa/
- **2020-12-17** — **Airflow 2.0** is released (announcement by **Ash
  Berlin-Taylor**). Headline changes:
  - **High-Availability scheduler**: *"It's now possible and supported to run
    more than a single scheduler instance"* (resiliency + performance), plus
    dramatically faster task scheduling.
  - **TaskFlow API**: a more Pythonic, decorator-based way to author DAGs with
    cleaner dependency handling and easier XCom.
  - **Full, stable REST API** with an OpenAPI specification (no longer
    "experimental").
  - **Task Groups** (replacing SubDAGs for UI grouping), **Smart Sensors**
    (early-access), a redesigned **KubernetesExecutor**, and the split of the
    monolith into **core + ~61 provider packages**.
  Source: https://airflow.apache.org/blog/airflow-two-point-oh-is-here/
  - Astronomer credits 2.0 with lifting monthly downloads "from an average of
    600,000 to over 3 million."
    Source: https://www.astronomer.io/blog/letter-from-the-ceo-our-story-so-far/

### 2022 — Astronomer Series C; Astro

- **2022-03-23** — **Astronomer raises a $213M Series C** led by **Insight
  Partners** (with Meritech, Salesforce Ventures, J.P. Morgan, K5 Global, Sutter
  Hill, Venrock, Sierra) and **acquires Datakin** (data lineage, from the
  founders of the OpenLineage / Marquez projects).
  Sources:
  https://www.prnewswire.com/news-releases/astronomer-raises-213-million-series-c-and-acquires-datakin-scales-operations-amid-booming-growth-and-global-demand-301508408.html ;
  https://techcrunch.com/2022/03/23/astronomer-ready-for-its-next-mission-after-datakin-acquisition-213m-series-c/
- **June 2022** — Astronomer's managed product **Astro** is announced as a "data
  orchestration platform powered by Apache Airflow," running on AWS and Google
  Cloud.
  Source: https://www.prnewswire.com/news-releases/astronomer-announces-astro-a-data-orchestration-platform-powered-by-apache-airflow-on-aws-and-google-cloud-301562263.html

### 2023 — Azure managed Airflow; Astronomer CEO change

- **February 2023** — **Microsoft** introduces managed Apache Airflow inside
  **Azure Data Factory** (later branded **Workflow Orchestration Manager**).
  Microsoft has since announced its deprecation in favor of **Apache Airflow jobs
  in Microsoft Fabric** (no new instances after 2026-01-01).
  Source: https://techcommunity.microsoft.com/blog/azuredatafactoryblog/introducing-workflow-orchestration-manager-powered-by-apache-airflow-in-azure-da/3730151
- **July 2023** — **Andy Byron** (formerly President at Lacework) becomes
  Astronomer CEO.
  Source: https://www.astronomer.io/press-releases/astronomer-revenue-jumps-more-than-200-percent-in-h1-2023/
  (CEO start month) and press coverage below.

### 2025 — Airflow 3.0; the Coldplay incident

- **2025-04-22** — **Airflow 3.0** is released — the first major release since
  2.0 (2020). Headline features: **DAG Versioning** (the most-requested feature
  in the annual Airflow survey; a run completes on the version it started with),
  a **new React-based UI** (with a **FastAPI** backend), a **Task Execution
  Interface / Task API** enabling tasks to run as standalone processes (and in
  other languages), and expanded **event-driven / asset-based scheduling**
  (datasets renamed to **assets**).
  Source (canonical Apache GA announcement, dated **2025-04-22**, by **Kaxil
  Naik and Vikram Koka**): https://airflow.apache.org/blog/airflow-three-point-oh-is-here/
- **2025-07-19** — **Andy Byron resigns as Astronomer CEO** after a viral
  "kiss-cam" clip at a **Coldplay** concert in Boston (filmed with Chief People
  Officer Kristin Cabot). The board accepted his resignation; **co-founder and
  Chief Product Officer Pete DeJoy** was named **interim CEO**. (Included as a
  matter of public record about the leading commercial Airflow company; it is
  not a technical event.)
  Sources: https://www.cnn.com/2025/07/19/business/andy-byron-astronomer-ceo-resigns ;
  https://www.cnbc.com/2025/07/19/astronomer-ceo-andy-byron-resigns-after-viral-coldplay-kiss-cam-controversy.html

---

## Key people & teams

- **Maxime Beauchemin** (GitHub `mistercrunch`) — **creator of Apache Airflow**
  (at Airbnb, 2014) and **creator of Apache Superset** (originally **Caravel**, a
  2015 Airbnb hackathon project; a BI/visualization tool). He previously worked
  at Facebook and Ubisoft, and authored the influential essay *"The Rise of the
  Data Engineer."* In **2019** he founded **Preset**, the commercial company
  behind Superset, where he is CEO.
  - Sources: Preset, *From Airflow to Superset*,
    https://preset.io/blog/from-airflow-to-superset-how-one-data-engineers-mission-became-an-open/ ;
    Preset *About*, https://preset.io/about/ ; GitHub
    https://github.com/mistercrunch
  - Preset funding (verified): **$35.9M Series B** (Aug 2021), led by **Redpoint
    Ventures** with **a16z** participation; the company reports ~$48.4M raised
    since 2019.
    Sources: https://preset.io/blog/preset-raises-usd35-9m-series-b-to-democratize-business-intelligence/ ;
    https://siliconangle.com/2021/08/18/open-source-business-intelligence-startup-preset-nabs-35-9m-funding/
    - **Opinion attributed:** Superset/Preset's framing that Beauchemin's
      open-source work amounts to "an open source revolution" is Preset's own
      marketing characterization (source: the Preset blog title above).
- **Ash Berlin-Taylor** — long-time Airflow committer; announced the **Airflow
  2.0** release; an early Astronomer engineer.
  Source: https://airflow.apache.org/blog/airflow-two-point-oh-is-here/
- **Bolke de Bruin** — VP of Apache Airflow at the time of the 2019 TLP
  announcement.
  Source: https://news.apache.org/foundation/entry/the-apache-software-foundation-announces44
- **Kaxil Naik**, **Jarek Potiuk**, **Fokko Driesprong**, **Daniel Imberman**,
  **Vikram Koka**, and others — prominent Airflow PMC members / committers. The
  project lists 96 committers on its *Project* page.
  Source: https://airflow.apache.org/docs/apache-airflow/stable/project.html
  - **Daniel Imberman** (Bloomberg, later Astronomer) drove the
    KubernetesExecutor (2018). Source:
    https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/

---

## Architecture (DAGs, scheduler, executors, metadata DB)

The architecture below is as described in Beauchemin's 2015 Airbnb post and the
Apache docs.

- **DAGs (Directed Acyclic Graphs) in Python.** A pipeline is a Python file that
  instantiates tasks and declares dependencies between them; the graph must be
  acyclic. Because DAGs are *code*, they can be generated dynamically from
  configuration and benefit from Python's introspection/metaprogramming. This is
  Airflow's "configuration as code" thesis.
  Source: https://medium.com/airbnb-engineering/airflow-a-workflow-management-platform-46318b977fd8

- **Operators / Sensors / Hooks** (the task layer):
  - **Operators** "generate a certain type of task" (e.g. `BashOperator`,
    `PythonOperator`, `KubernetesPodOperator`).
  - **Sensors** are operators that "keep running until a certain criteria is
    met" (e.g. wait for a file/partition).
  - **Hooks** are "external systems abstraction[s]" — reusable connection logic
    for databases, cloud APIs, etc.
  Source: Airbnb Engineering blog (link above).

- **Scheduler.** Long-running process(es) that parse DAGs, evaluate schedules and
  dependencies, and "fire up the task instances that are ready to run." Prior to
  2.0 a single scheduler was a bottleneck/SPOF; **Airflow 2.0 introduced the
  High-Availability scheduler** (multiple active schedulers).
  Sources: Airbnb blog; https://airflow.apache.org/blog/airflow-two-point-oh-is-here/

- **Executors** (how/where tasks actually run). The scheduler hands ready tasks
  to a pluggable executor:
  - **SequentialExecutor** — runs one task at a time (default with SQLite; for
    testing only).
  - **LocalExecutor** — runs tasks as subprocesses on a single machine.
  - **CeleryExecutor** — distributes tasks across a fleet of **Celery** workers
    via a message broker (RabbitMQ/Redis). **Cross-ref `history/celery.md`.**
  - **KubernetesExecutor** — launches each task in its own **Kubernetes** pod
    (contributed by Bloomberg, 2018). **Cross-ref `history/kubernetes.md`.**
    (Airflow 3.0 also adds an **Edge Executor** for remote/distributed workers.)
  Sources: Airbnb blog (Sequential/Local/Celery);
  https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/ ;
  https://airflow.apache.org/blog/airflow-three-point-oh-is-here/

- **Metadata database.** A relational DB (**PostgreSQL** or **MySQL** in
  production; SQLite only for local testing) is the system of record for DAG
  definitions' state, task instances, runs, connections, variables, and XComs.
  Beauchemin's original post names it the "metadata repository" backed by
  "MySQL or Postgres." **Cross-ref `history/postgresql.md`.**
  Source: https://medium.com/airbnb-engineering/airflow-a-workflow-management-platform-46318b977fd8

- **Webserver / UI.** A web application (Flask historically; **React + FastAPI**
  from Airflow 3.0) to visualize DAG dependencies (Graph/Grid views), monitor
  runs, browse logs, and manage connections/variables.
  Sources: Airbnb blog; https://airflow.apache.org/blog/airflow-three-point-oh-is-here/

---

## Company & ecosystem (Astronomer, managed services)

### Astronomer

**Astronomer** is the principal commercial company built around Apache Airflow.

- **Founding & pivot to Airflow.** Astronomer was founded in **Cincinnati,
  Ohio** by **Ry Walker** (co-founder and early CEO) with co-founders including
  **Greg Neiheisel**, and the broader early team named by Astronomer's own CEO
  letter: Walker, Neiheisel, **Brad Kirn, Viraj Parekh, Paola Peraza Calderon,
  Pete DeJoy, Ash Berlin-Taylor, and Kaxil Naik**.
  - **Founding year — sources conflict.** Multiple secondary sources say
    Astronomer was **founded in 2015** (originally a data-engineering services /
    "data router" company) and **committed to building on Apache Airflow in
    2018**; some sources label it "founded 2018." Astronomer's own CEO letter
    dates the seed round to **early 2019** and says the team "started driving
    that [Airflow] project in 2018." **Marked: "Could not verify a single
    canonical founding year"** — the most consistent reading is *company started
    ~2015, pivoted to/standardized on Airflow in 2018, raised its first priced
    round (seed) in 2019.*
    Sources: https://www.astronomer.io/blog/letter-from-the-ceo-our-story-so-far/ ;
    https://research.contrary.com/company/astronomer ;
    https://grandvcp.com/astronomer/
  - **Ry Walker** was CEO during the startup phase and later stepped back; per
    secondary sources he "was CEO ... from 2015–2019" and hired **Joe Otto** as
    CEO (2018). **Marked: the precise CEO-handoff date (2018 vs 2019) could not
    be verified from a primary source** — Joe Otto authored Astronomer's
    2022-03-23 "Our Story" letter as CEO.
    Sources: https://research.contrary.com/company/astronomer ;
    https://www.astronomer.io/blog/letter-from-the-ceo-our-story-so-far/
- **Funding (verified milestones, per Astronomer's CEO letter and press):**
  Seed (early 2019, led by Sierra Ventures' Tim Guleri) → Series A (2020,
  Venrock) → Series B (2020, Sutter Hill) → **Series C $213M (2022-03-23, Insight
  Partners)** with the Datakin acquisition.
  Sources: https://www.astronomer.io/blog/letter-from-the-ceo-our-story-so-far/ ;
  https://www.prnewswire.com/news-releases/astronomer-raises-213-million-series-c-and-acquires-datakin-scales-operations-amid-booming-growth-and-global-demand-301508408.html
- **Product: Astro** — Astronomer's managed Airflow platform (announced June
  2022), running on AWS and Google Cloud.
  Source: https://www.prnewswire.com/news-releases/astronomer-announces-astro-a-data-orchestration-platform-powered-by-apache-airflow-on-aws-and-google-cloud-301562263.html
- **Leadership:** Ry Walker (founding CEO) → Joe Otto (CEO, ~2018, stepped down
  Jan 2023 after a workforce reduction per secondary reporting) → **Andy Byron**
  (CEO, July 2023) → resigned **2025-07-19**; **Pete DeJoy** named **interim
  CEO**.
  - The "Joe Otto stepped down Jan 2023 / co-CEO Scott Yara" details come from
    secondary reporting (Contrary Research). **Marked: not verified from a
    primary Astronomer source.**
  Sources: https://research.contrary.com/company/astronomer ;
  https://www.cnn.com/2025/07/19/business/andy-byron-astronomer-ceo-resigns

### Hyperscaler-managed Airflow

- **Google Cloud Composer** (May 2018; managed Airflow on GCP; now "Managed
  Service for Apache Airflow"). GA date not verified from a primary source (see
  timeline).
  Source: https://docs.cloud.google.com/composer/docs
- **Amazon MWAA — Managed Workflows for Apache Airflow** (2020-11-24).
  Source: https://aws.amazon.com/blogs/aws/introducing-amazon-managed-workflows-for-apache-airflow-mwaa/
- **Azure Data Factory — Workflow Orchestration Manager** (managed Airflow, Feb
  2023; being deprecated in favor of Microsoft Fabric).
  Source: https://techcommunity.microsoft.com/blog/azuredatafactoryblog/introducing-workflow-orchestration-manager-powered-by-apache-airflow-in-azure-da/3730151

---

## The orchestration landscape (alternatives)

Airflow sits at the center of the "modern data stack" orchestration layer, but it
has many notable peers and predecessors. Each entry below is founder/company/year
sourced.

- **Luigi (Spotify).** Created mainly by **Erik Bernhardsson** and **Elias
  Freider** at **Spotify**, open-sourced **late 2012**. A Python pipeline library
  (Hadoop-oriented) that predates Airflow and is widely cited as an inspiration
  for the "pipelines as Python code" idea. Bernhardsson later founded **Modal**
  (serverless compute; cross-ref `history/WASM_DOCKER_alternate_history.md`).
  Sources: https://github.com/spotify/luigi ;
  https://erikbern.com/2012/10/21/luigi-build-complex-pipelines-of-tasks.html
  - (Spotify later moved much of its orchestration from Luigi to **Flyte**;
    source: https://validio.io/blog/why-spotify-moved-from-luigi-to-flyte-to-power-their-daily-workflows)

- **Prefect.** Founded **2018** by **Jeremiah Lowin** (himself an Apache Airflow
  PMC member). Prefect popularized the framing of **"negative engineering"** —
  the defensive code engineers write to make sure their "positive" code actually
  runs reliably. Pythonic flows/tasks via decorators.
  Sources: https://www.prefect.io/blog/how-jeremiah-lowin-turned-a-life-long-question-into-an-industry-leading-startup ;
  https://future.com/negative-engineering-and-the-art-of-failing-successfully/
  - **Opinion attributed:** the "negative engineering" framing is Lowin's /
    Prefect's own positioning (sources above).

- **Dagster.** Created **2018** by **Nick Schrock** at **Elementl** (renamed
  **Dagster Labs**, Aug 2023). Schrock is a former Facebook principal engineer
  and **co-creator of GraphQL**. Dagster centers on **software-defined assets**
  and strong typing / testability for data pipelines. **Pete Hunt** became CEO in
  November 2022. Dagster Labs has raised ~$49M (Sequoia, Index, Amplify, etc.).
  Sources: https://opensourceunderdogs.com/episode-65-scaling-data-pipelines-with-nick-schrock-founder-cto-of-dagster-labs/ ;
  https://dagster.io/blog/elementl-series-b ;
  https://github.com/schrockn

- **Temporal.** Founded **2019** by **Maxim Fateev** and **Samar Abbas**, the
  technical leads behind Uber's open-source **Cadence** workflow engine (and,
  earlier, Amazon Simple Workflow / Azure Durable Task Framework). Temporal is a
  **durable-execution** engine (code-first workflows with automatic
  state/retry/replay) — broader than data orchestration, used heavily for
  microservice/transactional workflows. Today Samar Abbas is CEO, Maxim Fateev
  CTO.
  Sources: https://temporal.io/temporal-versus/cadence ;
  https://www.amplifypartners.com/blog-posts/our-investment-in-temporal

- **Flyte (Lyft).** Born at **Lyft** (its origins trace to late 2016, powering
  Lyft's ETA models) and **open-sourced 2020-01-07**. A Kubernetes-native,
  strongly-typed orchestrator for ML/data. It joined **LF AI & Data** (incubation
  Feb 2021; graduated Jan 2022). The commercial company is **Union.ai**,
  co-founded by **Ketan Umare** (ex-Lyft).
  Sources: https://flyte.org/blog/flyte-joins-lf-ai-and-data ;
  https://lfaidata.foundation/blog/2022/01/20/lf-ai-data-foundation-announces-graduation-of-flyte-project/ ;
  https://www.geekwire.com/2023/workflow-orchestration-startup-union-ai-which-created-flyte-lands-19-1m/

- **Mage (Mage AI).** A newer open-source data-pipeline tool positioned as a more
  notebook-friendly, "purpose-built for data pipelines" alternative to Airflow
  (modular, testable steps in Python/SQL/R).
  Source: https://github.com/mage-ai/mage-ai
  - Could not verify a precise founding year/founder for Mage from a primary
    source in the searches run. Marked: **Could not verify Mage's founding
    date/founders.**

- **Kestra.** Founded **2019** in **Paris** by **Emmanuel Darras** (CEO) and
  **Ludovic Dehon** (CTO, also creator of the AKHQ Kafka UI). A **declarative,
  YAML-based**, event-driven orchestration platform (an explicit contrast to
  Airflow's Python-as-config approach). Reached **1.0 in Sept 2025**; raised
  **$25M** (reported by TNW).
  Sources: https://thenextweb.com/news/orchestration-platform-kestra-raises-25m ;
  https://www.prnewswire.com/news-releases/kestra-launches-1-0--an-enterprise-ready-orchestration-platform-built-for-the-declarative-agentic-future-302547952.html

- **Argo Workflows.** A **container-native**, Kubernetes-CRD-based workflow
  engine (originally from Applatix, then Intuit; a CNCF project). It competes
  with Airflow specifically in the Kubernetes-native batch/CI space. **Cross-ref
  `history/argocd.md`.**

### The "modern data stack" context

Airflow's rise (2015–2020) coincided with — and helped define — the **"modern
data stack"**: cloud data warehouses (Snowflake/BigQuery), ELT tooling
(Fivetran/dbt), and a dedicated **orchestration** layer to schedule and sequence
it all. Airflow became the default orchestrator of that stack; Prefect, Dagster,
Mage, and Kestra all position themselves (explicitly) as next-generation
alternatives addressing Airflow's perceived ergonomics, testability, or
deployment pain points. The framing of these tools as "modern data stack"
orchestrators is industry/vendor positioning rather than a formal taxonomy.

---

## Open questions / "Could not verify"

- Exact **first-commit date** beyond the Git history's oldest commit
  (2014-10-26); docs say only "October 2014."
- **Google Cloud Composer GA date** from a primary Google source (secondary
  sources say announced 2018-05-01, GA ~2018-07-19).
- **Astronomer's canonical founding year** (2015 vs 2018) and the exact
  **CEO-handoff date** from Ry Walker to Joe Otto (2018 vs 2019); the "Joe Otto
  stepped down Jan 2023 / Scott Yara co-CEO" detail is from secondary reporting
  only.
- **Mage AI** founding year and founders (no primary source confirmed here).
- (Resolved) **Airflow 3.0** GA day is **2025-04-22** per the canonical Apache
  blog post (authors Kaxil Naik & Vikram Koka).
