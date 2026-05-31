# FastAPI: A Sourced History

A chronological, fully-sourced history of **FastAPI** — the modern, type-hint-driven
Python web framework created by **Sebastián Ramírez ("tiangolo")** that
auto-generates an **OpenAPI** schema and interactive API docs from your code.

Every non-trivial claim below carries a working source link. Where a detail could
not be confirmed against a primary or reputable secondary source, it is explicitly
flagged with **Could not verify:**. Opinions are attributed to their source.

> **Cross-references (not duplicated here):**
> - The **Swagger → OpenAPI** specification lineage (Tony Tam at Wordnik, 2010;
>   SmartBear acquisition 2015; OpenAPI Initiative under the Linux Foundation,
>   2015-11-05; rename to "OpenAPI Specification" 2016-01-01) is in
>   `history/cloud-apis.md` (Part 6). This doc does **not** re-tell that story; it
>   picks up the thread at the point where FastAPI *emits* OpenAPI from Python code.
> - How an OpenAPI/Swagger document drives **client-SDK code generation** at
>   industrial scale (AWS Smithy, Azure AutoRest → TypeSpec, OCI's internal
>   `OracleSDKGenerator`, OpenAPI-based SDKs like Stripe/Twilio) is the subject of
>   `../CODE_GENERATION.md`. FastAPI sits on the *producer* side of that pipeline:
>   it generates the OpenAPI document that such generators *consume*. See the
>   "OpenAPI tie-in" section below.

---

## Timeline

### 2017-05-03 — Pydantic begins (a prerequisite)

The **Pydantic** data-validation library — one of FastAPI's two pillars — predates
FastAPI by about 18 months. The `pydantic/pydantic` GitHub repository was created on
**May 3, 2017**.
- Live repo metadata (`created_at: 2017-05-03T21:23:58Z`):
  https://api.github.com/repos/pydantic/pydantic
- Its author **Samuel Colvin**, a London-based developer, "created Pydantic as an
  experimental project in 2017."
  - TechCrunch, "Sequoia backs open source data-validation framework Pydantic…"
    (Feb 16, 2023): https://techcrunch.com/2023/02/16/sequoia-backs-open-source-data-validation-framework-pydantic-to-commercialize-with-cloud-services/

### 2018 (mid) — Starlette and the ASGI toolkit it sits on

FastAPI's other pillar, **Starlette**, is "a lightweight ASGI framework/toolkit"
created by **Tom Christie** — who is best known as the creator of **Django REST
Framework** — under his **Encode** open-source organization. Christie also created
**Uvicorn**, the ASGI server recommended for both Starlette and FastAPI.
- FastAPI's own "Alternatives, Inspiration and Comparisons" page describes Starlette
  as "a lightweight ASGI framework/toolkit… ideal for building high-performance
  asyncio services," and says the `FastAPI` class "inherits directly from the class
  `Starlette`… basically Starlette on steroids":
  https://fastapi.tiangolo.com/alternatives/
- Tom Christie as creator of Django REST Framework, Starlette and Uvicorn, under
  Encode OSS — see the Python Podcast __init__ episode "APIs, Sustainable Open
  Source and The Async Web With Tom Christie":
  https://www.pythonpodcast.com/apis-sustainable-open-source-and-the-async-web-with-tom-christie/
- **Could not verify:** an exact first-release *date* for Starlette from a primary
  source in the searches performed; it is dated to 2018 by Encode's own 2018 reports
  (https://www.encode.io/reports/october-2018) but the precise initial-release day
  was not pinned down.

FastAPI's docs explicitly credit the now-defunct **APIStar** (also Tom Christie's,
later pivoted away from being a server) as the framework that "Inspired FastAPI to
Exist," calling FastAPI a "spiritual successor to APIStar"; **Hug** and **Requests**
are also credited as design inspirations.
- https://fastapi.tiangolo.com/alternatives/

### 2018-12-08 — FastAPI's first release (0.1.0)

FastAPI's first public release, **version 0.1.0**, was published to PyPI on
**December 8, 2018**. The `fastapi/fastapi` GitHub repository was created the same
day.
- PyPI release history (earliest release 0.1.0, Dec 8, 2018):
  https://pypi.org/project/fastapi/#history
- Live repo metadata (`created_at: 2018-12-08T08:21:47Z`):
  https://api.github.com/repos/fastapi/fastapi
- **Note / discrepancy:** Wikipedia states FastAPI was "first released" on
  **December 5, 2018** (https://en.wikipedia.org/wiki/FastAPI). The primary
  PyPI/GitHub records both point to **December 8, 2018**, which this doc treats as
  authoritative; the Dec 5 figure could not be confirmed against a primary source.

FastAPI is created by **Sebastián Ramírez Montaño** ("tiangolo"), a Colombian
developer.
- GitHub profile: https://github.com/tiangolo
- Real Python bio (Colombian; creator of FastAPI, Typer, SQLModel):
  https://realpython.com/team/sramirez/

What it is, per Wikipedia and FastAPI's own docs: a web framework for building HTTP
APIs in Python (3.8+) that is built on an **ASGI** foundation (Starlette), uses
Python **type hints** plus **Pydantic** to validate/serialize data, and
**automatically generates OpenAPI documentation** served as interactive Swagger UI
(`/docs`) and ReDoc (`/redoc`). License is **MIT**.
- https://en.wikipedia.org/wiki/FastAPI
- https://fastapi.tiangolo.com/alternatives/

### 2019-02-04 — "Introducing FastAPI" (the launch essay)

Ramírez published the "Introducing FastAPI" post on Medium on **February 4, 2019**,
laying out the motivation: after years of trying to get the features he wanted out of
existing tools, "at some point, there was no other option than creating something
that provided all these features," leveraging modern Python type hints. The post
claims FastAPI can "increase the speed to develop features by about 200% to 300%" and
reduce human-induced errors "by about 40%" — these are **the author's own
claims/opinions**, not independent measurements.
- Sebastián Ramírez, "Introducing FastAPI" (Medium, Feb 4, 2019):
  https://tiangolo.medium.com/introducing-fastapi-fdc1206d453f

The same post emphasizes that automatic documentation is "based on OpenAPI standards,"
and notes it "enables both human developers and automated client code generation
across multiple programming languages" — the explicit tie to SDK codegen (see below).

### 2019-12-20 — Typer's first release

Ramírez released **Typer**, a library for building command-line interfaces from
Python type hints (the "FastAPI of CLIs"), with first version **0.0.1 on December 20,
2019**.
- PyPI history (earliest release 0.0.1, Dec 20, 2019): https://pypi.org/project/typer/#history
- Project site: https://typer.tiangolo.com/

### 2021-08 — SQLModel released

Ramírez released **SQLModel**, a library that combines Pydantic and SQLAlchemy for
SQL databases in Python, around **August 2021**. He described it as "the biggest
thing I've built since FastAPI & Typer."
- SQLModel project site: https://sqlmodel.tiangolo.com/
- Quote / timing from Ramírez's LinkedIn release announcement (Aug 2021):
  https://www.linkedin.com/posts/junaidahmed361_github-tiangolosqlmodel-sql-databases-activity-6836050401675083776-MleX
- **Could not verify:** an exact day-of-month first-release date for SQLModel from a
  primary PyPI page in the searches performed; "August 2021" is the best-supported
  figure.

### 2023-02-16 — Pydantic becomes a company (Pydantic Inc / Pydantic Services)

Samuel Colvin's Pydantic raised a **$4.7 million seed round led by Sequoia Capital**
(with Partech, Irregular Expressions, and angels including Zapier's Bryan Helmig, dbt
Labs' Tristan Handy, and Sentry's David Cramer), to commercialize the open-source
library with cloud services. Colvin had gone full-time on Pydantic in **March 2022**,
funded by savings and sponsorships (GitHub, AWS, Salesforce) before the round.
- TechCrunch, "Sequoia backs open source data-validation framework Pydantic to
  commercialize with cloud services" (Feb 16, 2023):
  https://techcrunch.com/2023/02/16/sequoia-backs-open-source-data-validation-framework-pydantic-to-commercialize-with-cloud-services/
- Sequoia, "Partnering with Pydantic: No More Steel Seats for Developers":
  https://sequoiacap.com/article/partnering-with-pydantic-no-more-steel-seats-for-developers/

> **Note on the prompt's $12.5M / 2023 figure.** The **seed** round was **$4.7M in
> Feb 2023**, *not* $12.5M. Pydantic's **$12.5M figure is a later Series A, led by
> Sequoia, in October 2024** — a separate, later event.
> - TechCrunch, "Sequoia backs Pydantic to expand beyond its open source
>   data-validation framework" (Oct 1, 2024):
>   https://techcrunch.com/2024/10/01/sequoia-backs-pydantic-to-expand-beyond-its-open-source-data-validation-framework/

### 2023 — Ramírez named Sequoia's inaugural Open Source Fellow

Ramírez was the **inaugural (2023) recipient** of Sequoia Capital's Open Source
Fellowship.
- Sequoia, "Partnering with FastAPI Labs" (May 5, 2025) — states he was "the
  inaugural 2023 recipient":
  https://sequoiacap.com/article/partnering-with-fastapi-labs-simplified-app-deployment/
- Sequoia founder spotlight, "Keeping an Open-Source Mind":
  https://sequoiacap.com/article/sebastian-ramirez-spotlight/

### 2024 (mid) — GitHub-stars milestone

FastAPI crossed a widely-cited popularity milestone. A community report records FastAPI
at roughly **74k stars (July 30, 2024)** growing toward parity with Django, becoming
"the most starred [web/backend] framework" in Python.
- Latenode community thread, "FastAPI reaches GitHub star count parity with Django":
  https://community.latenode.com/t/fastapi-reaches-github-star-count-parity-with-django/8575
- Live repo metadata at time of writing shows **~98.7k stars**
  (`stargazers_count: 98682`): https://api.github.com/repos/fastapi/fastapi
- **Attribution caveat:** "most starred backend framework" claims originate largely
  from FastAPI's own marketing and community posts; treat the *ranking* as a
  community/first-party claim rather than an independent audit. The raw star count is
  verifiable via the GitHub API above.

### 2025-05-05 — FastAPI Labs / FastAPI Cloud + $4.2M seed (Sequoia)

Ramírez announced **FastAPI Labs**, the company he founded around FastAPI, and its
first product **FastAPI Cloud** (one-command deploy: `fastapi deploy`, with HTTPS,
autoscaling, and scale-to-zero). The company raised a **$4.2M seed round led by
Sequoia Capital**, with angels from the Python/AI community (creators of Pydantic,
NumPy, Ruff, Flask, and figures from Google DeepMind, Hugging Face, MongoDB).
- FastAPI Cloud blog, "FastAPI Cloud — By The Same Team Behind FastAPI" (May 5, 2025):
  https://fastapicloud.com/blog/fastapi-cloud-by-the-same-team-behind-fastapi/
- Sequoia, "Partnering with FastAPI Labs: Simplified App Deployment" (May 5, 2025):
  https://sequoiacap.com/article/partnering-with-fastapi-labs-simplified-app-deployment/
- Sequoia company page: https://sequoiacap.com/companies/fastapi-labs/

Ramírez's own framing (his opinion/motivation): "there are so many app ideas I've had
over the years that I never built because deploying them was so complex," with the
tagline "You code. We cloud."
- https://fastapicloud.com/blog/fastapi-cloud-by-the-same-team-behind-fastapi/

> **Note on the prompt's ~$12.5M / Sequoia-involved figure for FastAPI.** The FastAPI
> Labs **seed** is **$4.2M (May 2025), led by Sequoia** — Sequoia involvement is
> confirmed; the amount is $4.2M, not ~$12.5M (the $12.5M figure belongs to
> **Pydantic's** Series A, see above).

### 2025–2026 — Continued growth

By the **2025 Stack Overflow Developer Survey** (published March 2026), FastAPI
adoption had risen markedly — reported as jumping **from 29% (2023) to 38% (2025)**
among surveyed developers.
- Adoption-trend figure: https://byteiota.com/python-adoption-jumps-7-points-stack-overflow-2025-survey/
- Primary survey portal (technology section): https://survey.stackoverflow.co/2025/technology
- **Attribution caveat:** the precise 29%→38% deltas are reported by a secondary
  analysis; the underlying survey data is at the Stack Overflow link. The exact
  per-year percentages could not all be cross-checked against the primary survey
  tables in the searches performed — **Could not verify** each number independently.

FastAPI continues active releases (e.g., Wikipedia records a 0.136.x stable build in
May 2026). Pydantic v2 (a Rust-core rewrite) and the broader tiangolo ecosystem
(Typer, SQLModel, Asyncer) remain in active development.
- https://en.wikipedia.org/wiki/FastAPI

---

## Key people & teams

- **Sebastián Ramírez Montaño ("tiangolo")** — Colombian developer; creator of
  FastAPI (2018), Typer (2019), SQLModel (2021), Asyncer, and the project-generator
  templates; founder/CEO of **FastAPI Labs**. Spent years as an
  independent/sponsored OSS maintainer before founding the company; inaugural Sequoia
  Open Source Fellow (2023).
  - https://github.com/tiangolo · https://realpython.com/team/sramirez/ ·
    https://sequoiacap.com/founder/sebastian-ramirez/
- **Tom Christie** — creator of **Django REST Framework**, **Starlette**, and
  **Uvicorn** (and the earlier **APIStar**), under the **Encode** OSS org. His ASGI
  work is the substrate FastAPI is built on.
  - https://www.pythonpodcast.com/apis-sustainable-open-source-and-the-async-web-with-tom-christie/
- **Samuel Colvin** — creator of **Pydantic** (2017), founder of **Pydantic**
  (the company), London-based.
  - https://techcrunch.com/2023/02/16/sequoia-backs-open-source-data-validation-framework-pydantic-to-commercialize-with-cloud-services/
- **FastAPI Labs team (per the FastAPI Cloud launch)** — alongside Ramírez:
  **Patrick Arminio**, **Alejandra Sánchez**, and **Sofie Van Landeghem**.
  - https://fastapicloud.com/blog/fastapi-cloud-by-the-same-team-behind-fastapi/

---

## Built on (Starlette, Pydantic) & the OpenAPI tie-in

**The dependency stack.** FastAPI is deliberately thin: it composes two
well-established libraries rather than reimplementing them. Per FastAPI's own
docs (https://fastapi.tiangolo.com/alternatives/):

1. **Starlette** (Tom Christie / Encode) — the **ASGI** framework/toolkit underneath.
   The `FastAPI` application class *inherits directly from* Starlette's `Starlette`
   class; FastAPI docs call it "basically Starlette on steroids." Starlette handles
   routing, middleware, requests/responses, WebSockets, background tasks — "all the
   core web parts."
2. **Pydantic** (Samuel Colvin) — handles "all the data validation, data
   serialization and automatic model documentation (based on **JSON Schema**)." Python
   type hints on request/response models become runtime validation + JSON Schema.
3. **Uvicorn** (Tom Christie / Encode) — the recommended **ASGI server** (built on
   uvloop + httptools) that actually runs the app in production.

So the runtime stack is, roughly: **Uvicorn (ASGI server) → Starlette (ASGI
framework) → FastAPI (type-hint + validation + OpenAPI layer) → Pydantic (data
models/validation/JSON Schema)**.

**The OpenAPI tie-in (the connection to this project's SDK-codegen theme).** This is
the part that links FastAPI to `../CODE_GENERATION.md`. FastAPI's standout feature is
that it derives an **OpenAPI schema automatically from the code** — specifically:
Pydantic turns your type-hinted models into **JSON Schema**, and (in FastAPI's own
words) "FastAPI then takes that JSON Schema data and puts it in **OpenAPI**"
(https://fastapi.tiangolo.com/alternatives/). The result is served as interactive
Swagger UI and ReDoc.

That auto-generated OpenAPI document is exactly the kind of artifact that the
**client-SDK generators** surveyed in `../CODE_GENERATION.md` consume:

- The **Swagger → OpenAPI** standard FastAPI emits is the same lineage traced in
  `history/cloud-apis.md` Part 6 (Tony Tam → SmartBear → OpenAPI Initiative).
- OpenAPI-described APIs are the basis for SDK code generation across the industry —
  including the **Stripe** and **Twilio** style OpenAPI-driven SDKs referenced in
  `../CODE_GENERATION.md`, and Azure's **AutoRest** (and its TypeSpec successor),
  which consume OpenAPI/Swagger to emit multi-language clients.

The notable inversion: the cloud providers in `../CODE_GENERATION.md` mostly author a
*spec first* (Smithy, Protobuf, TypeSpec, hand-written Swagger) and generate *both*
server stubs and client SDKs from it. **FastAPI flips the direction** — you write
ordinary Python with type hints, and the **spec is generated from the
implementation**. The OpenAPI document is an *output* of the running server, which can
then be fed *into* the same downstream SDK generators. FastAPI's docs explicitly call
out that the generated docs support "automated client code generation across multiple
programming languages" (https://tiangolo.medium.com/introducing-fastapi-fdc1206d453f).

---

## Company & corporate history

- **FastAPI Labs** — founded by Sebastián Ramírez around FastAPI; building **FastAPI
  Cloud** (one-command deploy for FastAPI/Python apps: HTTPS, autoscaling,
  scale-to-zero). Announced publicly **May 5, 2025** with a **$4.2M seed round led by
  Sequoia Capital** plus Python/AI-community angels.
  - https://fastapicloud.com/blog/fastapi-cloud-by-the-same-team-behind-fastapi/
  - https://sequoiacap.com/article/partnering-with-fastapi-labs-simplified-app-deployment/
  - https://sequoiacap.com/companies/fastapi-labs/
  - **Could not verify:** the exact legal-entity name/incorporation date of "FastAPI
    Labs," and whether "FastAPI Cloud" is a product brand vs. a separate entity, from
    a primary corporate filing. The names are used as above by Sequoia and the
    company's own blog.

- **Pydantic** (the company, Samuel Colvin) — separate company, relevant as
  cross-context because Pydantic is a FastAPI pillar. **$4.7M seed (Feb 2023, led by
  Sequoia)**; **$12.5M Series A (Oct 2024, led by Sequoia)**; commercializing via
  cloud/observability products (Pydantic Logfire).
  - https://techcrunch.com/2023/02/16/sequoia-backs-open-source-data-validation-framework-pydantic-to-commercialize-with-cloud-services/
  - https://techcrunch.com/2024/10/01/sequoia-backs-pydantic-to-expand-beyond-its-open-source-data-validation-framework/

- **Encode** (Tom Christie) — the OSS organization behind Starlette and Uvicorn;
  funded via OSS sponsorship/consulting rather than venture capital (per the Tom
  Christie podcast episode). Not a venture-backed company in the FastAPI/Pydantic
  sense.
  - https://www.pythonpodcast.com/apis-sustainable-open-source-and-the-async-web-with-tom-christie/
  - **Could not verify:** Encode's precise legal/funding structure from a primary
    source.

---

## Current status (as of mid-2026)

- FastAPI is one of the most popular Python web frameworks — **~98.7k GitHub stars**
  (live API at time of writing), MIT-licensed, repo at `fastapi/fastapi`, with active
  releases (0.136.x in May 2026 per Wikipedia). Heavily used for ML/AI model serving
  and microservices; cited as in use at BMW, American Express, Roche, NASA's STScI,
  and the Red Cross (per Sequoia).
  - https://api.github.com/repos/fastapi/fastapi · https://en.wikipedia.org/wiki/FastAPI ·
    https://sequoiacap.com/article/partnering-with-fastapi-labs-simplified-app-deployment/
- **FastAPI Labs** is an early-stage, Sequoia-seed-funded company building FastAPI
  Cloud; **Pydantic** is a separately-funded (Sequoia seed + Series A) company; both
  share Sequoia as lead investor, which is a notable structural fact about how the
  modern FastAPI/Pydantic ecosystem is being commercialized.

---

### Summary of unverifiable / corrected items

- **First-release date:** primary sources (PyPI + GitHub) give **Dec 8, 2018**;
  Wikipedia's **Dec 5, 2018** could not be confirmed and is treated as an error here.
- **FastAPI Labs round:** **$4.2M** (not ~$12.5M); the ~$12.5M figure is **Pydantic's
  Series A (Oct 2024)**. Sequoia *is* the lead for both FastAPI Labs and Pydantic.
- **Pydantic seed:** **$4.7M (Feb 2023)**, not "$12.5M in 2023" as the prompt
  suggested.
- **Could not verify:** exact Starlette and SQLModel first-release *days*; Encode and
  FastAPI Labs legal-entity/incorporation details; each individual Stack Overflow
  survey percentage against the primary survey tables.
