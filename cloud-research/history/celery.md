# Celery — A Sourced History

**Celery** is an open-source **distributed task queue** (asynchronous job /
background-task processing system) for Python. It is **based on distributed
message passing**: a producer (your application) sends a "task" message to a
**message broker**, and one or more **worker** processes consume those messages
and execute the tasks — either asynchronously (in the background) or, optionally,
synchronously. Tasks can run concurrently using multiprocessing, eventlet, or
gevent.

> Celery is "an open source asynchronous task queue or job queue which is based
> on distributed message passing."
> — Wikipedia, *Celery (software)*, https://en.wikipedia.org/wiki/Celery_(software)

> "Celery is a simple, flexible, and reliable distributed system to process vast
> amounts of messages, while providing operations with the tools required to
> maintain such a system. It's a task queue with focus on real-time processing,
> while also supporting task scheduling."
> — Celery README, https://github.com/celery/celery

Celery was created by **Ask Solem** (GitHub: **`ask`**, handle "asksol") and
first released on **2009-04-24** (version **0.1.0**). It is written in Python and
licensed under the **New BSD License**. Its message-broker abstraction is provided
by the companion library **Kombu**; its process-pool execution layer is provided
by **Billiard**, a fork of the Python `multiprocessing` package. Ask Solem stepped
back from active maintenance around 2017, and the project has since been carried
forward by community maintainers (notably **Omer Katz**). As of this writing the
current line is **Celery 5.x** (latest **5.6.3**, released 2026-03-26 per PyPI).

### Cross-references (not duplicated here)

- **RabbitMQ** — the default and most fully-supported broker for Celery, and an
  AMQP message broker. For RabbitMQ's own history (Rabbit Technologies, Erlang,
  AMQP, Pivotal/VMware), see `history/rabbitmq.md`. This document covers only how
  Celery *uses* a broker, not RabbitMQ internals.
- **Redis** — the other first-class, actively-maintained Celery broker (and a
  popular result backend). For Redis's own history (Salvatore Sanfilippo / antirez,
  Redis Labs / Redis Inc., the license saga), see `history/redis.md`. Here we cover
  only Redis's role as a Celery transport / result store.

---

## Timeline

### 2009 — Origins: Carrot, then Celery

- **May 2009 (and earlier)** — Before Celery rose to prominence, Ask Solem wrote
  **Carrot**, an AMQP messaging-queue framework for Python (built on `amqplib`).
  Carrot was the messaging foundation that Celery initially used and the direct
  ancestor of **Kombu**.
  Sources: https://pypi.org/project/carrot/0.3.6/ ,
  https://github.com/celery/kombu (Kombu notes it can port projects "already using
  carrot" via a compatibility layer)
- **2009-04-24** — **Celery 0.1.0** is released by Ask Solem. The changelog entry
  reads: *"0.1.0 — 2009-04-24 11:28 a.m. CET — Initial release."* This is the
  **verified first release** of Celery.
  Source: https://docs.celeryq.dev/en/stable/history/changelog-1.0.html
- A rapid burst of point releases followed in spring 2009, all authored by Ask
  Solem: 0.1.6 (2009-04-28), 0.1.7 (2009-04-30), 0.1.8 (2009-05-07), 0.1.10
  (2009-05-11) … 0.2.0 (2009-05-20), 0.3.0 (2009-06-08).
  Source: https://docs.celeryq.dev/en/stable/history/changelog-1.0.html
- Celery was originally created to give **Django** web applications a robust
  background-task mechanism, then quickly generalized into a framework usable by
  any Python project.
  Source (secondary): https://grokipedia.com/page/Celery_(software)
  *(Marked secondary — see "Could not verify" below regarding the precise Django-origin
  framing.)*

### 2010 — Celery 1.0

- **2010-02-10** — **Celery 1.0.0** is released, the first major-version milestone.
  Source: https://docs.celeryq.dev/en/stable/history/changelog-1.0.html

### Early–mid 2010s — Maturation and the supporting libraries

- **Kombu** is established as Celery's broker-abstraction layer, superseding Carrot.
  Kombu provides "an idiomatic high-level interface for the AMQ protocol" and a
  **pluggable transport** system so the same API works across RabbitMQ, Redis,
  Amazon SQS, and others. Kombu explicitly "fixed several annoyances with amqplib"
  (timeouts, waiting on multiple channels) and offered a Carrot compatibility layer.
  Sources: https://github.com/celery/kombu ,
  https://docs.celeryq.dev/projects/kombu/en/stable/introduction.html
- **Billiard** is maintained as Celery's process-pool layer — a **fork of the
  Python 2.7 `multiprocessing` package** (which itself was a renamed/updated version
  of R. Oudkerk's `pyprocessing`). Billiard carries Celery-specific pool
  improvements and the "no-execv" patch, and is maintained by the Celery team.
  Sources: https://github.com/celery/billiard , https://pypi.org/project/billiard/
- **django-celery** (and later the split-out **django-celery-results**,
  **django-celery-beat**) provide deep Django integration — e.g. storing task
  results via the Django ORM or cache framework, and database-backed periodic-task
  schedules.
  Sources: https://github.com/celery/django-celery-results ,
  https://docs.celeryq.dev/en/stable/django/first-steps-with-django.html

### 2017 — Maintenance transition: Ask Solem steps back

- **Celery 4.1 ("latentcall")** is "the first time we release without Ask Solem as
  an active contributor." The release notes thank him and announce a new release
  manager:
  > "This is the first time we release without Ask Solem as an active contributor.
  > We'd like to thank him for his hard work in creating and maintaining Celery over
  > the years." … "For the time being, I, Omer Katz will be the release manager."
  Source: https://github.com/celery/celery/blob/main/docs/history/whatsnew-4.1.rst
  (rendered: https://docs.celeryq.dev/en/stable/history/whatsnew-4.1.html)

### 2018 — Ask Solem's next act: Faust at Robinhood

- **2018-08** — **Faust**, a Python stream-processing library, is released by
  **Robinhood**. Simon Willison's link blog (dated 6 August 2018) describes it as
  "A new open source stream processing system released by Robinhood … created by
  **Vineet Goel and Celery creator Ask Solem**," noting the "initial release requires
  Kafka but they plan to support multiple backends."
  Source: https://simonwillison.net/2018/Aug/6/faust/
- Faust is described by its own repository as "a stream processing library, porting
  the ideas from **Kafka Streams** to Python," "used at Robinhood to build high
  performance distributed systems," for "data analysis, risk, fraud and security in
  real time."
  Source: https://github.com/robinhood/faust
- Ask Solem discussed Faust and his Celery background in public talks/podcasts in
  2018, including *Software Engineering Daily* ("Faust: Streaming at Robinhood with
  Ask Solem", 2018-09-05) and *Podcast.__init__* (episode 176).
  Sources:
  https://softwareengineeringdaily.com/2018/09/05/faust-streaming-at-robinhood-with-ask-solem/ ,
  https://www.pythonpodcast.com/fast-stream-processing-in-python-using-faust-with-ask-solem-episode-176/
- **Later** — Robinhood's original `robinhood/faust` repository was deprecated; an
  active community fork lives at **`faust-streaming/faust`**.
  > "This library has been deprecated and no longer managed or supported. The
  > current active community project can be found at
  > https://github.com/faust-streaming/faust"
  Source: https://github.com/robinhood/faust

### 2020 — Celery 5.0: Python 3 only

- **Celery 5.0.0 ("Singularity")** is released as a new major version. It **drops
  Python 2.7** and supports only **Python 3.6+** (officially CPython 3.6/3.7/3.8 and
  PyPy3 at release). The CLI was rewritten using **Click**; the deprecated AMQP
  result backend was removed; minimum dependencies became **Kombu 5.0.0** and
  **Billiard 3.6.3**. (Per the project, 5.x releases are codenamed after songs by
  Jon Hopkins.)
  Source: https://docs.celeryq.dev/en/main/history/whatsnew-5.0.html

### 2025–2026 — Current 5.x line

- **5.5.3** is dated **2025-06-01** on the Wikipedia infobox; the Celery changelog
  and PyPI show the line continuing through **5.6.x**.
  Sources: https://en.wikipedia.org/wiki/Celery_(software) ,
  https://docs.celeryq.dev/en/stable/changelog.html
- **5.6.3** is the latest version on **PyPI**, released **2026-03-26**, requiring
  **Python >=3.9**.
  Source: https://pypi.org/project/celery/

---

## Key people & teams

- **Ask Solem** (Ask Solem Hoel; GitHub **`ask`**, handle "asksol") — **creator of
  Celery** (first release 2009) and author of its supporting libraries (Carrot →
  Kombu, Billiard). Listed as Celery's original author on PyPI and in the Wikipedia
  infobox.
  Sources: https://github.com/ask , https://pypi.org/project/celery/ ,
  https://en.wikipedia.org/wiki/Celery_(software)
  - **Ask Solem's arc beyond Celery:** he co-created **Faust** at **Robinhood**
    (with Vineet Goel), porting Kafka-Streams ideas to Python (2018).
    Sources: https://simonwillison.net/2018/Aug/6/faust/ ,
    https://github.com/robinhood/faust
  - Search-result summaries (LinkedIn / aggregator profiles) describe him as having
    worked at **Opera Software** (early Celery era), later **VMware / VMware Tanzu
    Labs**, and **Robinhood** as a principal/senior engineer.
    Sources (secondary): https://www.linkedin.com/in/asksol/ ,
    https://news.ycombinator.com/item?id=16599637
    *(Marked secondary — full employment history could not be verified from a
    primary source; LinkedIn cannot be fetched directly. See "Could not verify.")*

- **Omer Katz** (GitHub **`thedrow`**) — became Celery's **release manager** at the
  4.1 transition and is described as a primary maintainer / core contributor of
  Celery; he runs **Katz Consulting Group**, which offers Celery-related consulting.
  Sources: https://github.com/celery/celery/blob/main/docs/history/whatsnew-4.1.rst ,
  https://github.com/thedrow , https://www.kcg.tech/celery-2
  - Omer Katz appeared on *Software Engineering Radio* episode 502 (2022-03)
    discussing distributed task queues using Celery.
    Source: https://se-radio.net/2022/03/episode-502-omer-katz-on-distributed-task-queues-using-celery/

- **Other maintainers** — PyPI lists the verified Celery maintainers as **`ask`,
  `auvipy`, `mher`, `Nusnus`, and `smorin`** (handles). "auvipy" (Asif Saif Uddin)
  and "mher" (Mher Movsisyan, also known for the **Flower** monitoring tool) are
  long-standing contributors in the Celery ecosystem.
  Source: https://pypi.org/project/celery/

---

## Architecture & ecosystem (brokers, Kombu, Billiard)

Celery is composed of a small family of libraries developed under the
**`celery` GitHub organization**, plus broker/back-end systems it talks to:

**Core moving parts**
- **Producer / client** — your application calls a task (e.g. `task.delay(...)`),
  which serializes a message and hands it to the broker.
- **Broker (transport)** — the message-queue middleware that routes task messages
  to workers. Celery does **not implement its own broker**; it relies on external
  systems.
- **Worker** — long-running process(es) that consume messages and execute task code,
  using a concurrency pool (multiprocessing/Billiard, or eventlet/gevent).
- **Result backend** (optional) — where task state and return values are stored so
  callers can poll/retrieve them.

> "Celery requires a message transport to send and receive messages."
> The README features **RabbitMQ and Redis** as the primary transports.
> — https://github.com/celery/celery

**Brokers (transports)**
- **RabbitMQ** — the default and most fully-supported broker (AMQP). *(Cross-ref:
  `history/rabbitmq.md`.)*
- **Redis** — also "supported and actively maintained and monitored." *(Cross-ref:
  `history/redis.md`.)*
- **Amazon SQS** — supported and maintained, but does not support worker inspection.
- **Zookeeper / Kafka / Google Pub/Sub** — experimental.
  Source: https://en.wikipedia.org/wiki/Celery_(software) ,
  https://github.com/celery/celery

**Kombu — the broker abstraction**
- **Kombu** is "a messaging library for Python" that gives Celery a single,
  broker-agnostic API via **pluggable transports** (RabbitMQ, Redis, SQS, and more),
  with multiple serializers (JSON, pickle, YAML, msgpack), compression, connection
  pooling, and reconnection handling. It is the **successor to Carrot** and fixes
  `amqplib` limitations.
  Sources: https://github.com/celery/kombu ,
  https://docs.celeryq.dev/projects/kombu/en/stable/introduction.html
- Celery 5.0 requires **Kombu 5.0.0+**.
  Source: https://docs.celeryq.dev/en/main/history/whatsnew-5.0.html

**Billiard — the process pool**
- **Billiard** is a **fork of the Python 2.7 `multiprocessing` package** (itself a
  descendant of R. Oudkerk's `pyprocessing`), carrying Celery-specific pool
  improvements, the no-execv patch, and bug fixes drawn from Python trunk. It is
  used as Celery's default worker pool and is maintained by the Celery team.
  Sources: https://github.com/celery/billiard , https://pypi.org/project/billiard/
- Other companion dependencies of the development version include **`amqp`** (AMQP
  protocol implementation) and **`vine`** (promises/utilities).
  Source: https://github.com/celery/celery

**Result backends**
- Celery can store results in **AMQP** (removed in 5.0), **Redis**, **memcached**,
  **SQLAlchemy/Django ORM**, **Cassandra**, and cloud storage, among others.
  Sources: https://github.com/celery/celery ,
  https://en.wikipedia.org/wiki/Celery_(software)
- For Django specifically, **django-celery-results** stores results via the Django
  ORM or cache framework.
  Source: https://github.com/celery/django-celery-results

**Scheduling — Celery Beat**
- **Celery beat** is a scheduler that periodically kicks off tasks (a "lightweight
  cron replacement"), supporting interval and **crontab**-style schedules; workers
  then execute the enqueued tasks. **django-celery-beat** adds DB-backed dynamic
  schedules.
  Source: https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html

**Ubiquity / typical use cases**
- Celery is one of the most widely used asynchronous-task systems in the Python
  world. Common use cases: offloading **background jobs** from web requests (email
  sending, image/file processing, API calls), and **scheduled/periodic tasks** via
  celery beat (cleanup, syncs, reports, reminders).
  Sources: https://docs.celeryq.dev/en/stable/userguide/periodic-tasks.html ,
  https://www.fullstackpython.com/task-queues.html
- Wikipedia notes Celery has been used at scale, citing **Instagram** processing
  "millions of tasks every day."
  Source: https://en.wikipedia.org/wiki/Celery_(software)

---

## Governance

- **License / nature** — Celery is a **community open-source project** under the
  **New BSD License**, developed in the open under the **`celery` GitHub
  organization** (which also hosts Kombu, Billiard, Flower, the django-celery-*
  packages, etc.).
  Sources: https://github.com/celery/celery , https://pypi.org/project/celery/
- **Maintainership** — After Ask Solem stepped back at the 4.1 release (2017),
  governance shifted to **community maintainers**, with **Omer Katz** as release
  manager and a maintainer group (`ask`, `auvipy`, `mher`, `Nusnus`, `smorin` per
  PyPI). There is no single corporate owner.
  Sources: https://github.com/celery/celery/blob/main/docs/history/whatsnew-4.1.rst ,
  https://pypi.org/project/celery/
- **Funding / sponsorship** — Celery is funded through community and commercial
  channels rather than a sponsoring company:
  - **Open Collective** — community-powered donations ("Celery" collective).
    Source: https://opencollective.com/celery
  - **Tidelift** — pays maintainers to meet security/maintenance/licensing standards
    and offers Celery as part of the Tidelift Subscription (commercial support).
    Source: https://pypi.org/project/celery/ (README links) ; see also
    https://github.com/celery/celery
  - Corporate sponsors listed in the README include CloudAMQP, Upstash, Dragonfly,
    and Blacksmith.
    Source: https://github.com/celery/celery
  - The project openly describes itself as having **"minimal funding,"** which it
    cites as a reason for, e.g., limited Windows support.
    Source: https://github.com/celery/celery

---

## Alternatives & context

Celery is the de-facto heavyweight, but a family of lighter / more specialized
Python task queues exists. (Descriptions below are from secondary comparison
sources and reflect those authors' characterizations, not benchmarked claims.)

- **RQ (Redis Queue)** — minimalist task queue using **Redis** as both broker and
  storage; often cited as the simplest option, but Redis-only.
- **Dramatiq** — task queue focused on simplicity, reliability, and performance;
  supports **RabbitMQ and Redis**; "similar to Celery, but intentionally smaller
  feature set."
- **Huey** — lightweight queue, typically Redis-backed, aimed at small-to-medium
  apps.
- **arq** — modern **asyncio**-native task queue using Redis, aimed at async/await
  apps (e.g. FastAPI).
  Sources: https://judoscale.com/blog/choose-python-task-queue ,
  https://www.fullstackpython.com/task-queues.html ,
  https://www.bithost.in/blog/tech-3/how-to-run-fastapi-background-tasks-arq-vs-celery-11
- **Temporal** — a separate category (durable workflow / orchestration engine,
  polyglot) rather than a Python broker-based task queue, often discussed as an
  alternative for complex long-running workflows.
  *(Could not verify a Celery-specific primary comparison here — see below.)*
- **Faust** — by Ask Solem & Vineet Goel; not a task queue but a **stream-processing**
  library (Kafka-based), notable because it is the Celery creator's later project.
  Source: https://github.com/robinhood/faust , https://simonwillison.net/2018/Aug/6/faust/

**Current status** — Celery is on the **5.x** line (Python 3 only since 5.0;
latest 5.6.3 on PyPI, 2026-03-26), actively maintained by the community.
Sources: https://docs.celeryq.dev/en/main/history/whatsnew-5.0.html ,
https://pypi.org/project/celery/

---

## Could not verify / caveats

- **Ask Solem's full employment history** (Opera Software → VMware / VMware Tanzu
  Labs → Robinhood, and exact titles/dates) comes only from **secondary aggregator
  and LinkedIn summaries**; LinkedIn cannot be fetched directly, so dates and the
  ordering are **not confirmed from a primary source**. The Opera connection
  (`askh@opera.com`) appears in third-party write-ups only.
  Sources (secondary): https://www.linkedin.com/in/asksol/ ,
  https://news.ycombinator.com/item?id=16599637 , https://grokipedia.com/page/Celery_(software)
- **The precise "created specifically for Django" origin framing** is from secondary
  sources (Grokipedia and tutorial blogs); the *primary* changelog confirms the date
  and authorship but not the motivation. Treat the Django-origin claim as **likely
  but not primary-sourced**.
- **The exact date Ask Solem "stepped back"** is anchored to the **Celery 4.1**
  release notes (which state it was the first release without him as an active
  contributor) rather than a dated announcement; Celery 4.1's exact calendar date
  was not independently pinned here.
- **A direct, Celery-vs-Temporal primary comparison** was not located; Temporal is
  included as widely-known context, characterized from general task-queue/workflow
  discussion rather than a single authoritative source.
- **Carrot's exact first-release date** is approximate ("~May 2009" per a PyPI
  release page and third-party notes); not pinned to a precise day from a primary
  changelog.
