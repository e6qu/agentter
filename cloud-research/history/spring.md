# Spring Framework & Spring Boot: A Sourced History

The **Spring Framework** is an open-source application framework and
inversion-of-control (IoC) container for the Java platform. It began as the
infrastructure code published with Rod Johnson's 2002 book *Expert One-on-One
J2EE Design and Development*, and grew into the de-facto standard for building
enterprise Java applications. **Spring Boot** (2014) layered
convention-over-configuration and auto-configuration on top of it and became the
accelerant that cemented Spring's dominance in the cloud era.

> Scope note: This doc traces Spring's technical evolution and the corporate
> lineage that carried it — **Interface21 → SpringSource → VMware → Pivotal →
> VMware → Broadcom**. Every dated claim links to a working source (Spring's own
> blog, Rod Johnson's writing, SEC filings, reputable press). Where sourcing was
> thin or conflicting, the item is flagged **"Could not verify."** Opinions are
> attributed to whoever expressed them.
>
> Cross-references (not duplicated here):
> - **`history/rabbitmq.md`** — SpringSource acquired Rabbit Technologies
>   (RabbitMQ) in April 2010; see that doc for RabbitMQ's own arc.
> - **`history/bosh.md`** — Cloud Foundry / Pivotal lineage; the
>   VMware → Pivotal → VMware → Broadcom corporate thread is shared with this
>   doc and covered in depth there from the Cloud Foundry side.

---

## Dated timeline

### October 2002 — *Expert One-on-One J2EE Design and Development*
Rod Johnson published *Expert One-on-One J2EE Design and Development* (Wrox).
The book shipped with roughly **30,000 lines of framework code** — the
"Interface21 framework" — that became the seed of Spring. In his own words:

> "Spring originated in late 2002, when I published the code that was to become
> the foundation of Spring … with my book *Expert One-on-One J2EE Design and
> Development* (published November 2002, although it was available from late
> October)."
> — Rod Johnson, [Spring Framework: The Origins of a Project and a Name (spring.io blog, 2006-11-09)](https://spring.io/blog/2006/11/09/spring-framework-the-origins-of-a-project-and-a-name/)

The book was positioned as a lightweight reaction against the complexity of
contemporary **J2EE / EJB** practice; Johnson's follow-up book made the thesis
explicit in its title: *Expert One-on-One J2EE Development without EJB* (Wrox,
2004).
- [Rod Johnson (programmer) — Wikipedia](https://en.wikipedia.org/wiki/Rod_Johnson_(programmer))

### February–June 2003 — the open-source project starts; the name "spring"
After the book's release, **Yann Caroff** persuaded Johnson to turn the book's
code into an open-source project, and **Juergen Hoeller** joined as a co-founder
and the long-term lead. It was Caroff who proposed the name:

> "It was Yann who came up with the name 'spring' … The two ideas Yann had in
> mind were the association with nature … and the fact that Spring represented a
> fresh start after the 'winter' of traditional J2EE."
> — Rod Johnson, [The Origins of a Project and a Name (spring.io, 2006-11-09)](https://spring.io/blog/2006/11/09/spring-framework-the-origins-of-a-project-and-a-name/)

The project went public in **June 2003** under the **Apache 2.0** license.
Caroff stopped contributing early on (he later left software to pursue music)
and is the least-documented of the three co-founders.
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework)
- Caroff's later career path is described in secondary write-ups but **could not
  verify** from a primary source beyond Johnson's own blog noting he "moved on."

### 24 March 2004 — Spring Framework 1.0 Final
Spring Framework **1.0 Final** was released, announced on the project blog by
Thomas Risberg. The release described Spring as "a complete Java/J2EE
application framework" providing a lightweight IoC container, AOP interception,
declarative transaction management (applicable "to any POJO, with JTA or a local
transaction strategy"), JDBC abstraction, Hibernate support, a web MVC
framework, and remoting. The announcement noted Spring was already in production
at large banks and healthcare organizations, and in projects like Matt Raible's
AppFuse and Atlassian's Confluence.
- [Spring Framework 1.0 Final Released (spring.io, 2004-03-24)](https://spring.io/blog/2004/03/24/spring-framework-1-0-final-released/)
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework) (corroborates the 24 March 2004 date and the Apache 2.0 / June 2003 facts)

The two defining features established here:
- **Dependency injection / IoC container** — externalized wiring and lifecycle
  management of plain Java objects (POJOs).
- **AOP** — aspect-oriented programming for cross-cutting concerns (notably the
  declarative transaction model).

### Late 2003 → 2008 — the security project that became Spring Security
**Acegi Security System for Spring** was started by **Ben Alex** in late 2003,
first released under the Apache License in **March 2004**, reaching **1.0.0** in
**May 2006**. It became an official Spring Portfolio project around the end of
2007 and was rebranded **Spring Security**, with the first release under the new
name, **2.0.0**, in **April 2008**.
- [Spring Security — Wikipedia](https://en.wikipedia.org/wiki/Spring_Security)

### August 2004 — Interface21 (the company) founded
Johnson, Hoeller, and others incorporated **Interface21** to provide Spring
consulting, training, and support. The name reflected Johnson's belief that
Spring was "the framework for the 21st Century."
- [Spring (company) — Wikipedia](https://en.wikipedia.org/wiki/Spring_(company))
- [Interface21 becomes SpringSource (spring.io, 2007-11-19)](https://spring.io/blog/2007/11/19/interface21-becomes-springsource/)

> Note on exact founding date: secondary sources commonly cite **August 2004**
> for the co-founding of Interface21 (with Johnson, Hoeller, Keith Donald, and
> Colin Sampaleanu). The company's own blog and Wikipedia say "2004" but do not
> pin the month; the August figure is **"Could not verify"** from a primary
> source.

### October 2006 — Spring 2.0
Spring Framework **2.0** shipped (October 2006), adding (among other things) XML
configuration namespaces and expanded AOP. Spring 1.2.6 had won a Jolt
productivity award and a JAX Innovation Award that year.
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework)

### May 2007 — $10M Series A from Benchmark
Interface21 raised a **$10 million Series A** led by **Benchmark Capital** to
expand product, sales, and support around Spring.
- [Interface21 (Spring) gets 10M VC Funding (InfoQ, 2007-05)](https://www.infoq.com/news/2007/05/interface21-gets-funding/)
- [Interface21 Gets $10M in Funding (phys.org, 2007-05)](https://phys.org/news/2007-05-interface21-10m-funding.html)

A **Series B** (Benchmark plus **Accel Partners**) followed in 2008.
- [Spring (company) — Wikipedia](https://en.wikipedia.org/wiki/Spring_(company)) — corroborates Accel/Benchmark involvement; exact amount/date **could not verify** from a primary source.

### 19 November 2007 — Interface21 → SpringSource
Johnson announced the company would rename from Interface21 to **SpringSource**:

> "It's simply confusing to have a name that's unnaturally distanced from the
> product we created."
> — Rod Johnson, [Interface21 becomes SpringSource (spring.io, 2007-11-19)](https://spring.io/blog/2007/11/19/interface21-becomes-springsource/)

### 2008–2009 — SpringSource's acquisition spree
- **29 January 2008 — Covalent Technologies**, a leading Apache Tomcat
  contributor.
  [Spring (company) — Wikipedia](https://en.wikipedia.org/wiki/Spring_(company))
- **November 2008 — G2One**, the company behind the **Groovy** language and the
  **Grails** web framework (founders Guillaume Laforge, Graeme Rocher, Alex
  Tkachman). Johnson framed it as "more weapons for the war on complexity."
  [More Weapons for the War on Complexity: SpringSource Acquires Groovy/Grails Leader (spring.io, 2008-11-11)](https://spring.io/blog/2008/11/11/more-weapons-for-the-war-on-complexity-springsource-acquires-groovy-grails-leader/);
  [SpringSource Embraces Groovy and Grails (InfoQ, 2008-11)](https://www.infoq.com/news/2008/11/springsource-g2one/)
- **May 2009 — Hyperic**, an open-source application/systems monitoring vendor
  (Hyperic had been spun out of Covalent).
  [SpringSource Acquires Hyperic (InfoQ, 2009-05)](https://www.infoq.com/news/2009/05/springsource_hyperic/)

### 10 August 2009 — VMware agrees to acquire SpringSource (~$420M)
**VMware** announced a definitive agreement to acquire SpringSource for
approximately **$420 million** — about $362M in cash and equity plus assumption
of ~$58M in unvested stock and options. The deal **closed 16 September 2009**.
- [VMware Form 8-K / press release (SEC, 2009)](https://www.sec.gov/Archives/edgar/data/0001124610/000119312509170650/dex991.htm)
- [VMware reaches for the clouds with $420 million SpringSource acquisition (InfoWorld)](https://www.infoworld.com/article/2278388/vmware-reaches-for-the-clouds-with-420-million-springsource-acquisition.html)
- [VMware Acquires SpringSource (TechCrunch, 2009-08-10)](https://techcrunch.com/2009/08/10/vmware-acquires-springsource/)

After the deal, SpringSource's commercial products were rebadged into the
**vFabric Application Suite**.
- [Spring (company) — Wikipedia](https://en.wikipedia.org/wiki/Spring_(company))

### 13 April 2010 — SpringSource (a VMware division) acquires Rabbit Technologies
Now operating as a VMware division, SpringSource acquired UK-based **Rabbit
Technologies, Ltd.**, makers of **RabbitMQ**, adding open-source messaging to
the portfolio. (See **`history/rabbitmq.md`** for RabbitMQ's own story.)
- [SpringSource Hops On Cloud Messaging with RabbitMQ (spring.io, 2010-04-13)](https://spring.io/blog/2010/04/13/springsource-hops-on-cloud-messaging-with-rabbitmq/)
- [SpringSource Acquires UK-based Open Source Company Rabbit Technologies (TechCrunch, 2010-04-13)](https://techcrunch.com/2010/04/13/springsource-rabbit/)

### December 2009 — Spring 3.0
Spring Framework **3.0** shipped (December 2009), introducing the Spring
Expression Language (SpEL), a REST-capable MVC, and Java-based `@Configuration`.
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework)

### 2008–2011 — the portfolio fans out
- **Spring Batch 1.0** — first public release **March 2008**.
  [Spring Batch (spring.io project page)](https://spring.io/projects/spring-batch/);
  release tag [spring-batch-1.0.0.FINAL (GitHub)](https://github.com/spring-projects/spring-batch/releases/tag/spring-batch-1.0.0.FINAL)
- **Spring Integration 1.0** — **1.0.x** released around **January 2009**
  (1.0.1.RELEASE dated 2009-01-20 in Maven Central).
  [spring-integration-core 1.0.1.RELEASE (Maven Central)](https://repo1.maven.org/maven2/org/springframework/integration/spring-integration-core/1.0.1.RELEASE/)
- **Spring Data** — the umbrella began in 2011; **Spring Data JPA 1.0 GA**
  shipped **21 July 2011** (Spring Data Graph/Neo4j came slightly earlier).
  [Spring Data JPA 1.0 GA released (spring.io, 2011-07-21)](https://spring.io/blog/2011/07/21/spring-data-jpa-1-0-ga-released/)

### July 2012 — Rod Johnson leaves VMware/SpringSource
Johnson announced he was leaving his role (SVP/GM of VMware's SpringSource
division) to "pursue other interests." The timing lined up with the end of the
typical 3-year acquisition lock-up after the 2009 VMware deal.
- [Spring Creator Rod Johnson Leaves VMware (ADTmag, 2012-07)](https://adtmag.com/blogs/watersworks/2012/07/rod-johnson-leaves-vmware.aspx)
- [With Johnson Leaving VMware, What are the Priorities for the Spring Framework? (InfoQ, 2012-07)](https://www.infoq.com/news/2012/07/johnson-leaves-vmware/)

(After Johnson's departure, **Juergen Hoeller** remained the long-time lead of
the Spring Framework — he is still the announcing author of major releases years
later; see Spring 6 below.)

### 24 April 2013 — Pivotal spun out of EMC/VMware
**EMC** (VMware's parent) and **VMware** spun their application-platform and
big-data assets into a new joint company, **Pivotal Software** (briefly
"GoPivotal"), officially announced **24 April 2013** and operating from
**1 April 2013**. **Paul Maritz** (former VMware CEO) led it as CEO. The combined
assets included **Greenplum**, **Cloud Foundry**, the **Spring** portfolio,
**Pivotal Labs**, **GemFire**, and other vFabric pieces. **General Electric**
invested **$105 million** for ~10% equity on 24 April 2013.
- [EMC Form 8-K (SEC, 2013)](https://www.sec.gov/Archives/edgar/data/0000790070/000079007013000032/exhibit991.htm)
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)
- [EMC launches its cloudy Federation with Pivotal big data spinoff (The Register, 2013-03-13)](https://www.theregister.com/2013/03/13/emc_vmware_pivotal_spinoff/)

(Maritz became Chairman on 18 August 2015, with **Rob Mee** taking over as CEO.
[Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software).)
See **`history/bosh.md`** for the Cloud Foundry side of the Pivotal story.

### December 2013 — Spring 4.0
Spring Framework **4.0** shipped (December 2013), adding full Java 8 support, a
WebSocket/STOMP stack, and (a year later) Spring Boot integration.
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework)

### 1 April 2014 — Spring Boot 1.0 GA
**Spring Boot 1.0** reached general availability, announced by **Phil Webb**.
Its goal was to "improve containerless web application architectures" with
**convention over configuration**, auto-configuration based on the classpath,
"starter" dependencies, and opinionated defaults that "back off" when you define
your own beans. The 1.0 release reflected ~18 months of work: 1,720 commits from
54 contributors. **Phil Webb** and **Dr. David (Dave) Syer** are the
co-founders/co-leads of Spring Boot.
- [Spring Boot 1.0 GA Released (spring.io, 2014-04-01)](https://spring.io/blog/2014/04/01/spring-boot-1-0-ga-released/)
- [A Bootiful Podcast: Spring Boot cofounders Phil Webb and Dr. David Syer … 10th Anniversary of Spring Boot 1.0 (spring.io, 2024-05-09)](https://spring.io/blog/2024/05/09/a-bootiful-podcast-spring-boot-cofounders-phil-webb-and-dr-david-syer-on-the/)

Spring Boot became the accelerant that made Spring the default way to build Java
microservices.

### 4 March 2015 — Spring Cloud 1.0
**Spring Cloud 1.0.0** shipped, bringing patterns for distributed systems
(config, service discovery, circuit breakers, routing) on top of Spring Boot.
- [Spring Cloud 1.0.0 Available Now (spring.io, 2015-03-04)](https://spring.io/blog/2015/03/04/spring-cloud-1-0-0-available-now/)

### 2017 — Spring 5.0 and reactive WebFlux
Spring Framework **5.0** (2017) introduced **Spring WebFlux**, a fully
non-blocking reactive web stack built on Reactive Streams (running on Netty or
Servlet 3.1+ containers), alongside the traditional Spring MVC.
- [Spring Framework — Wikipedia](https://en.wikipedia.org/wiki/Spring_Framework)
- [Spring WebFlux (Spring Framework reference docs)](https://docs.spring.io/spring-framework/reference/web/webflux.html)

### 20 April 2018 — Pivotal IPO (NYSE: PVTL)
**Pivotal Software** went public on the **NYSE** under ticker **PVTL** on
**20 April 2018**, pricing at **$15/share** and raising roughly **$555 million**.
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)

### 22 August → 30 December 2019 — VMware re-acquires Pivotal (~$2.7B)
VMware signed a **definitive agreement on 22 August 2019** to acquire Pivotal at
a blended **~$11.71/share** (Class A holders received $15/share cash; Dell
Technologies' Class B was exchanged for VMware stock), an enterprise value of
**~$2.7 billion**. The deal **closed 30 December 2019**, making Pivotal a
wholly-owned VMware subsidiary; its offerings folded into **VMware Tanzu**.
- [VMware Form 8-K, merger consideration (SEC, 2019)](https://www.sec.gov/Archives/edgar/data/0001124610/000119312519226899/d778820dex991.htm)
- [VMware Completes Acquisition of Pivotal (GlobeNewswire, 2019-12-30)](https://www.globenewswire.com/news-release/2019/12/30/1964966/0/en/VMware-Completes-Acquisition-of-Pivotal.html)
- [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)

### 16 November 2022 — Spring Framework 6.0 GA
**Spring Framework 6.0** went GA, announced by **Juergen Hoeller**, described as
"the start of a new framework generation for 2023 and beyond." It set a
**Java 17+** baseline, migrated to the **Jakarta EE 9+** namespace (targeting
Jakarta EE 10 APIs), introduced an **Ahead-Of-Time (AOT)** transformation
foundation enabling **GraalVM native image** support (via Spring Boot 3), and
added Micrometer-based observability.
- [Spring Framework 6.0 goes GA (spring.io, 2022-11-16)](https://spring.io/blog/2022/11/16/spring-framework-6-0-goes-ga/)

### 24 November 2022 — Spring Boot 3.0 GA
**Spring Boot 3.0** went GA (announced by **Andy Wilkinson**), the first major
revision since 2.0 (2018), requiring Spring Framework 6 / Java 17 and providing
first-class **GraalVM native-image** support. The release reflected ~12 months
and 5,700+ commits from 151 contributors.
- [Spring Boot 3.0 Goes GA (spring.io, 2022-11-24)](https://spring.io/blog/2022/11/24/spring-boot-3-0-goes-ga/)

### 22 November 2023 — Broadcom acquires VMware (Spring's current owner)
**Broadcom** completed its acquisition of **VMware** — a deal valued at about
**$61 billion** in cash and stock (plus assumption of ~$8B debt) — on
**22 November 2023**, after ~18 months of global regulatory review. Spring (via
VMware Tanzu) is therefore now owned by **Broadcom**.
- [Broadcom completes acquisition of VMware (Help Net Security, 2023-11-22)](https://www.helpnetsecurity.com/2023/11/22/broadcom-vmware-acquisition/)
- [Broadcom completes $61bn acquisition of VMware (Verdict, 2023)](https://www.verdict.co.uk/broadcom-acquires-vmware/)

> Note on price: headline figures for the Broadcom/VMware deal vary in the press
> between ~$61B and ~$69B depending on whether assumed debt and stock-price
> movement at close are included. The **$61 billion** announced deal value plus
> **~$8 billion assumed debt** is the most consistently cited breakdown.

### 18 April 2024 — Spring 1.0's 20th anniversary
Spring's founders **Rod Johnson** and **Juergen Hoeller** reunited on the
official "A Bootiful Podcast" to mark "more than 20 incredible years" since the
1.0 release.
- [A Bootiful Podcast: Spring founders Rod Johnson and Juergen Hoeller on the 20th Anniversary of Spring Framework 1.0 (spring.io, 2024-04-18)](https://spring.io/blog/2024/04/18/a-bootiful-podcast-spring-founders-rod-johnson-and-juergen-hoeller-on-the/)

### 20 May 2025 — Spring AI 1.0 GA
**Spring AI 1.0** went GA, bringing a portable `ChatClient` API across ~20 AI
model providers (Anthropic through ZhiPu), multi-modal I/O, and structured
output. A **1.1 GA** followed on **12 November 2025** with Model Context
Protocol integration.
- [Spring AI 1.0 GA Released (spring.io, 2025-05-20)](https://spring.io/blog/2025/05/20/spring-ai-1-0-GA-released/)
- [Spring AI 1.1 GA Released (spring.io, 2025-11-12)](https://spring.io/blog/2025/11/12/spring-ai-1-1-GA-released/)

---

## Key people & teams

- **Rod Johnson** — creator of Spring; author of *Expert One-on-One J2EE Design
  and Development* (2002). PhD in musicology (University of Sydney, 1996) before
  his Java career. Co-founder and CEO of Interface21/SpringSource; SVP/GM at
  VMware after the 2009 acquisition; left July 2012. Subsequent roles: chairman
  of **Neo4j Inc.** (from 2011), board member of **Typesafe** (from 2012), and
  founder of **Atomist** (2016). An active angel investor in the JVM ecosystem.
  - [Rod Johnson (programmer) — Wikipedia](https://en.wikipedia.org/wiki/Rod_Johnson_(programmer))
  - [Spring Creator Rod Johnson Leaves VMware (ADTmag, 2012-07)](https://adtmag.com/blogs/watersworks/2012/07/rod-johnson-leaves-vmware.aspx)
  - Note: the task brief suggested Atomist was founded in 2015; Wikipedia dates
    it to **2016**. The 2015 figure is **"Could not verify"** — primary/secondary
    sources point to 2016.

- **Juergen Hoeller** — co-founder and the long-time **lead architect** of the
  Spring Framework, still the announcing author of major releases (e.g. Spring
  6.0 in 2022). The continuity figure across every corporate owner.
  - [Spring Framework 6.0 goes GA (spring.io, 2022-11-16)](https://spring.io/blog/2022/11/16/spring-framework-6-0-goes-ga/)
  - [A Bootiful Podcast … 20th Anniversary (spring.io, 2024-04-18)](https://spring.io/blog/2024/04/18/a-bootiful-podcast-spring-founders-rod-johnson-and-juergen-hoeller-on-the/)

- **Yann Caroff** — third co-founder; persuaded Johnson to open-source the book
  code and coined the name **"spring"** (the "fresh start after the winter of
  J2EE"). Left the project early; later moved away from software.
  - [The Origins of a Project and a Name (spring.io, 2006-11-09)](https://spring.io/blog/2006/11/09/spring-framework-the-origins-of-a-project-and-a-name/)

- **Phil Webb & Dr. David (Dave) Syer** — co-founders/co-leads of **Spring
  Boot** (2014). Syer also led **Spring Batch** and was central to **Spring
  Cloud**.
  - [Spring Boot 1.0 GA Released (spring.io, 2014-04-01)](https://spring.io/blog/2014/04/01/spring-boot-1-0-ga-released/)

- **Ben Alex** — creator of **Acegi Security** (2003), which became **Spring
  Security**.
  - [Spring Security — Wikipedia](https://en.wikipedia.org/wiki/Spring_Security)

- **Keith Donald & Colin Sampaleanu** — cited in secondary sources as Interface21
  co-founders alongside Johnson and Hoeller (2004). **Could not verify** the
  full founder roster from a primary source.

- **Paul Maritz** — former VMware CEO; first CEO (then Chairman) of **Pivotal**.
  **Rob Mee** — Pivotal Labs founder; Pivotal CEO from August 2015.
  - [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)

---

## Company & corporate history (Interface21 → SpringSource → VMware → Pivotal → Broadcom)

The Spring technology stayed continuous while its corporate home changed hands
five times:

1. **Interface21 (2004–2007)** — consulting/support company around Spring,
   founded by Johnson, Hoeller, and others. Raised a $10M Series A from
   Benchmark (May 2007).
   [Interface21 becomes SpringSource (spring.io, 2007-11-19)](https://spring.io/blog/2007/11/19/interface21-becomes-springsource/)

2. **SpringSource (2007–2009)** — the rename to align with the product; pivoted
   from consulting to a software company. Went on an acquisition spree:
   **Covalent** (Jan 2008), **G2One / Groovy-Grails** (Nov 2008), **Hyperic**
   (May 2009).
   [Spring (company) — Wikipedia](https://en.wikipedia.org/wiki/Spring_(company))

3. **VMware (2009–2013)** — acquired SpringSource for **~$420M** (agreed Aug 10,
   2009; closed Sep 16, 2009). As a VMware division, SpringSource then acquired
   **Rabbit Technologies / RabbitMQ** (Apr 13, 2010 — see `history/rabbitmq.md`).
   Commercial products were rebadged as **vFabric**.
   [VMware Form 8-K (SEC, 2009)](https://www.sec.gov/Archives/edgar/data/0001124610/000119312509170650/dex991.htm)

4. **Pivotal (2013–2019)** — EMC + VMware spun Spring, **Cloud Foundry**,
   **Greenplum**, Pivotal Labs and others into **Pivotal Software** (announced
   Apr 24, 2013; GE invested $105M). Pivotal **IPO'd on the NYSE (PVTL) on
   Apr 20, 2018**, raising ~$555M.
   [EMC Form 8-K (SEC, 2013)](https://www.sec.gov/Archives/edgar/data/0000790070/000079007013000032/exhibit991.htm);
   [Pivotal Software — Wikipedia](https://en.wikipedia.org/wiki/Pivotal_Software)

5. **VMware (again) (2019–2023)** — VMware **re-acquired Pivotal** at a ~$2.7B
   enterprise value (agreed Aug 22, 2019; closed Dec 30, 2019); Spring folded
   into **VMware Tanzu**.
   [VMware Form 8-K (SEC, 2019)](https://www.sec.gov/Archives/edgar/data/0001124610/000119312519226899/d778820dex991.htm)

6. **Broadcom (2023–present)** — **Broadcom completed its ~$61B acquisition of
   VMware on Nov 22, 2023**, so Spring (via Tanzu) is today a Broadcom asset.
   [Broadcom completes acquisition of VMware (Help Net Security, 2023-11-22)](https://www.helpnetsecurity.com/2023/11/22/broadcom-vmware-acquisition/)

The shared corporate thread with `history/bosh.md` is **Cloud Foundry**: it
rode the same VMware → Pivotal → VMware → Broadcom path, and the
`history/rabbitmq.md` thread joins at step 3 (the April 2010 Rabbit
Technologies acquisition by SpringSource-under-VMware).

---

## The Spring ecosystem

Spring grew from a single IoC/AOP container into a broad "portfolio" of projects,
nearly all built on top of the core framework (and, after 2014, on Spring Boot):

- **Spring Framework** — core IoC container, AOP, transactions, JDBC, Spring MVC,
  and (from 5.0) the reactive **WebFlux** stack.
  [Spring WebFlux docs](https://docs.spring.io/spring-framework/reference/web/webflux.html)
- **Spring Security** — authentication/authorization; began as **Acegi Security**
  (2003) and was rebranded in 2008.
  [Spring Security — Wikipedia](https://en.wikipedia.org/wiki/Spring_Security)
- **Spring Batch** — batch processing (1.0, March 2008).
  [Spring Batch project](https://spring.io/projects/spring-batch/)
- **Spring Integration** — enterprise integration patterns / messaging (1.0,
  early 2009).
  [spring-integration-core 1.0.1 (Maven Central)](https://repo1.maven.org/maven2/org/springframework/integration/spring-integration-core/1.0.1.RELEASE/)
- **Spring Data** — uniform data-access abstractions across JPA, MongoDB, Redis,
  Neo4j, etc. (Spring Data JPA 1.0 GA, July 2011).
  [Spring Data JPA 1.0 GA (spring.io, 2011-07-21)](https://spring.io/blog/2011/07/21/spring-data-jpa-1-0-ga-released/)
- **Spring Boot** — convention-over-configuration, auto-configuration, starters
  (1.0, April 2014).
  [Spring Boot 1.0 GA (spring.io, 2014-04-01)](https://spring.io/blog/2014/04/01/spring-boot-1-0-ga-released/)
- **Spring Cloud** — distributed-systems patterns for microservices (1.0, March
  2015).
  [Spring Cloud 1.0.0 (spring.io, 2015-03-04)](https://spring.io/blog/2015/03/04/spring-cloud-1-0-0-available-now/)
- **Spring AI** — building blocks for AI/LLM applications (1.0 GA, May 2025).
  [Spring AI 1.0 GA (spring.io, 2025-05-20)](https://spring.io/blog/2025/05/20/spring-ai-1-0-GA-released/)

Adjacent technologies that entered the ecosystem via acquisition — **Groovy** and
**Grails** (G2One, 2008), **Tomcat** support (Covalent, 2008), **RabbitMQ**
(Rabbit Technologies, 2010), and **Hyperic** monitoring (2009) — are covered
above and (for RabbitMQ) in `history/rabbitmq.md`.

---

## Items flagged "Could not verify"

- Exact **month/day** of Interface21's incorporation (commonly cited as
  **August 2004**, but not confirmed from a primary source).
- The full **Interface21 founder roster** (Keith Donald, Colin Sampaleanu
  appear in secondary sources only).
- **Series B** amount/date (Accel + Benchmark, 2008) — confirmed as having
  happened, but no primary filing located.
- **Atomist founding year**: brief said 2015; sources indicate **2016**.
- **Yann Caroff's** later career (music) — only Johnson's blog and secondary
  retellings; no independent primary source.
- **Broadcom/VMware headline price** varies by source ($61B vs $69B depending on
  debt/stock treatment).
