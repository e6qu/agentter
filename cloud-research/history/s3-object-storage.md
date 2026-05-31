# Amazon S3 and the Object-Storage Paradigm: A Sourced History

This is a chronological, fully-sourced history of **Amazon Simple Storage Service
(S3)** and the object-storage paradigm it created. It traces the launch, the
design ideas (flat namespace + HTTP API + massive scale + durability), the rise
of the **S3 API as a de facto standard**, the consistency-model change, the
storage-class/pricing evolution, the major outage, and the competitive timeline.

This doc focuses on the **history and product/market story**. For how S3's API is
*modelled and code-generated* across AWS SDKs (Smithy model `s3-2006-03-01.json`,
the large S3-specific customization set, hand-written shims like the transfer
manager and presigners), see the object-storage case study in
[`../CODE_GENERATION.md`](../CODE_GENERATION.md) — cross-referenced here, not
duplicated.

Every factual claim below carries an inline source. Where a claim could not be
pinned to a primary source, it is marked **"Could not verify."**

---

## Timeline

### 2006-03-14 — Amazon S3 launches: "storage for the Internet"

Amazon S3 launched on **March 14, 2006**, one of the first AWS services. The AWS
press release "Amazon Web Services Launches" describes "a simple storage service
that offers software developers a highly scalable, reliable, and low-latency data
storage infrastructure at very low costs," tagged **"Storage for the Internet."**
It launched priced at **$0.15 per GB-month of storage and $0.20 per GB
transferred, with no minimum fee**.
- AWS press release (March 14, 2006):
  https://press.aboutamazon.com/2006/3/amazon-web-services-launches

The **bucket / object / key** model and the **REST and SOAP** APIs were there from
day one: the press release describes "standards-based REST and SOAP interfaces,"
unique developer-assigned keys for storage and retrieval, objects ranging from
**1 byte to 5 GB** with an unlimited number of objects, and the ability to make
objects private or public.
- Same press release: https://press.aboutamazon.com/2006/3/amazon-web-services-launches

AWS VP Andy Jassy is quoted in that release:
> "Amazon S3 is based on the idea that quality Internet-based storage should be
> taken for granted. It helps free developers from worrying about where they are
> going to store data, whether it will be safe and secure, if it will be
> available when they need it, the costs associated with server maintenance, or
> whether they have enough storage available."

**Date nuance (verify-worthy):** the AWS "What's New" announcement page for S3 is
stamped **March 13, 2006**, one day before the March 14 launch date used by the
press release and by AWS's own anniversary retrospectives. Both are AWS primary
sources; this is the same one-day offset seen on other early-AWS announcements
(e.g. EC2's What's New vs. Jeff Barr's blog post).
- AWS "What's New," "Announcing Amazon S3 - Simple Storage Service" (stamped
  2006-03-13):
  https://aws.amazon.com/about-aws/whats-new/2006/03/13/announcing-amazon-s3---simple-storage-service/
- AWS retrospectives use March 14, 2006: Werner Vogels, "Happy 15th Birthday
  Amazon S3":
  https://www.allthingsdistributed.com/2021/03/happy-15th-birthday-amazon-s3.html

**On the original durability claim:** the 2006 launch press release advertised
**"99.99% availability with no single points of failure"** — *not* the "eleven
nines" durability figure that S3 is famous for today. The 11-nines durability
design goal is a later articulation (see 2012/2019/2021 entries below). Be careful
not to retroject "11 nines" onto the 2006 launch.
- 2006 press release (99.99% availability):
  https://press.aboutamazon.com/2006/3/amazon-web-services-launches

### 2009 — S3 origins, per Werner Vogels

In his 15th-birthday retrospective, AWS CTO Werner Vogels recounts that S3 grew
out of Amazon's own storage problem circa 2005, built to five design criteria:
**Scalable, Reliable, Fast, Inexpensive, Simple.** He stresses the deliberate
minimalism of the first design — "we had no idea of all of the ways that customers
were going to use the service" — and the recurring theme of "simple experience
with deep engineering behind it."
- Werner Vogels, "Happy 15th Birthday Amazon S3" (dated 2021-03-23):
  https://www.allthingsdistributed.com/2021/03/happy-15th-birthday-amazon-s3.html

### 2010-02-01 — Microsoft Azure (with Blob Storage) goes commercially live

The Windows Azure platform — which included **Blob Storage** as its object-storage
service — became commercially available (billing turned on) on **February 1,
2010**. Microsoft's official blog announced general availability that day. (The
platform had been open for public sign-ups since the PDC-2009 timeframe, Nov
2009.)
- The Official Microsoft Blog, "Windows Azure General Availability" (2010-02-01):
  https://blogs.microsoft.com/blog/2010/02/01/windows-azure-general-availability/

**Could not verify** a distinct, separately-dated "general availability"
announcement for **Azure Blob Storage as a standalone service** apart from the
platform GA above; the primary sources treat Blob Storage as a component of the
Windows Azure platform GA.

### 2010-05-19 — Google announces "Google Storage for Developers" (preview)

Google announced **Google Storage for Developers** at **Google I/O 2010** on
**May 19, 2010** — a RESTful cloud object store ("fast, reliable storage
replicated across several US data centers"), initially a limited preview giving
developers up to 100 GB storage / 300 GB monthly bandwidth free. This is the
service later renamed **Google Cloud Storage**.
- Google Developers Blog, "Google Storage for Developers: A Preview"
  (2010-05-19):
  https://developers.googleblog.com/google-storage-for-developers-a-preview/

It opened to all developers (with new features) in **May 2011**.
- Official Google Cloud Blog, "Google Storage for Developers open to all, with
  new features" (2011-05):
  https://cloud.googleblog.com/2011/05/google-storage-for-developers-open-to.html

### 2012-08-20 — Amazon Glacier (cold/archival storage)

AWS announced **Amazon Glacier** on **August 20, 2012**: "secure, reliable, and
extremely low-cost storage designed for data archiving and backup," priced "as
low as **$0.01/GB/month**." Glacier introduced the **vault** abstraction, 3–5 hour
retrieval, and was "designed to provide average annual durability of
**99.999999999%** for each item stored" — i.e. **eleven nines**.
- AWS press release, "Amazon Web Services Announces Amazon Glacier" (2012-08-20):
  https://press.aboutamazon.com/2012/8/amazon-web-services-announces-amazon-glacier

Glacier later became the **S3 Glacier** family of storage classes; AWS marked its
10th anniversary in 2022.
- AWS News Blog, "Happy 10th Anniversary, Amazon S3 Glacier":
  https://aws.amazon.com/blogs/aws/happy-10th-anniversary-amazon-s3-glacier-a-decade-of-cold-storage-in-the-cloud/

### 2015-09-17 — S3 Standard-Infrequent Access (S3-IA / STANDARD_IA)

AWS introduced **S3 Standard - Infrequent Access** on **September 17, 2015**: same
durability/latency/throughput as S3 Standard but lower storage price (starting
around **$0.0125/GB-month**) plus a per-GB retrieval fee and a 30-day minimum —
aimed at backups, DR, and long-term but occasionally-accessed data.
- AWS S3 storage classes (current overview):
  https://aws.amazon.com/s3/storage-classes/
- Contemporary write-up dated 2015-09 (secondary, corroborates the date):
  https://web.archive.org/web/2id_/https://dazdaztech.wordpress.com/2015/09/25/new-aws-s3-storage-class-standard-infrequent-access/

**Note:** S3 later added **Intelligent-Tiering** (2018), **One Zone-IA** (2019),
**Glacier Instant Retrieval / Glacier Deep Archive**, and **S3 Express One Zone**
(2023). These are listed on the storage-classes page above; this doc does not
enumerate every class.

### 2017-02-28 — The us-east-1 S3 outage (see Notable incidents)

See the [Notable incidents](#notable-incidents) section for the full,
post-mortem-sourced account.

### 2019 — "Beyond eleven nines": S3's durability culture, on the record

At **re:Invent 2019**, AWS gave a session titled **"Beyond eleven nines: Lessons
from the Amazon S3 culture of durability"** (STG331-R1), making the **eleven nines
(99.999999999%) durability** design goal an explicit, named talking point and
describing the auditing/repair machinery behind it.
- AWS re:Invent 2019 session "Beyond eleven nines..." (STG331-R1):
  https://www.youtube.com/watch?v=DzRyrvUF-C0

### 2020-05-04 — Backblaze B2 adds an S3-compatible API

Backblaze added an **S3 Compatible API** to its **B2 Cloud Storage** on
**May 4, 2020** (public beta), framed as "our most requested feature," with launch
partners including IBM Aspera, Quantum, and Veeam. Buckets created before May 4,
2020 were not S3-compatible.
- Backblaze blog, "Backblaze B2 Cloud Storage Now Has S3 Compatible APIs"
  (2020-05-04):
  https://www.backblaze.com/blog/backblaze-b2-s3-compatible-api/

This is a concrete data point in the larger "the S3 API became the standard"
story (see [The S3 API as a de facto standard](#the-s3-api-as-a-de-facto-standard)).

### 2020-12-01 — S3 moves to strong read-after-write consistency

For roughly its first 14 years, S3 was **eventually consistent**: after a PUT
there was "a small time window where the data has been accepted and durably
stored, but not yet visible to all GET or LIST requests" — which spawned
workarounds like **EMRFS Consistent View** and **S3Guard** for data-lake
workloads. On **December 1, 2020** AWS announced that S3 now delivers **strong
read-after-write consistency** automatically for **all** applications, at no extra
cost and with no performance/availability hit.
- AWS News Blog (Jeff Barr), "Amazon S3 Update – Strong Read-After-Write
  Consistency" (2020-12-01):
  https://aws.amazon.com/blogs/aws/amazon-s3-update-strong-read-after-write-consistency/
- AWS "What's New" (2020-12-01) — note it explicitly says S3 "pioneered object
  storage in the cloud ... with eventual consistency" before this change:
  https://aws.amazon.com/about-aws/whats-new/2020/12/amazon-s3-now-delivers-strong-read-after-write-consistency-automatically-for-all-applications/

What became strongly consistent: per Barr's post, **GET, PUT, and LIST** plus
operations that change object **tags, ACLs, or metadata** — "What you write is
what you will read, and the results of a LIST will be an accurate reflection of
what's in the bucket."
- Barr post (above).

### 2021-09 — Cloudflare R2 announced (S3-compatible, zero egress fees)

Cloudflare announced **R2** in **September 2021**: an **S3-compatible** object
store explicitly positioned against S3's **egress (data-transfer-out) fees**, with
**no egress charges** and full S3 API compatibility "so you can migrate your apps
... without rewrites."
- Cloudflare blog, "Announcing Cloudflare R2 Storage: Rapid and Reliable Object
  Storage, minus the egress fees":
  https://blog.cloudflare.com/introducing-r2-object-storage/
- InfoQ coverage (2021-10), framing R2 as a challenge to AWS over egress:
  https://www.infoq.com/news/2021/10/cloudflare-r2-egress-aws/

### 2021-03 — S3 at 15: 100 trillion objects

For S3's 15th birthday (March 2021), AWS reported the service stored **over 100
trillion objects** and regularly peaked at tens of millions of requests per
second.
- AWS News Blog, "Amazon S3's 15th Birthday – It is Still Day 1 after 5,475 Days
  & 100 Trillion Objects":
  https://aws.amazon.com/blogs/aws/amazon-s3s-15th-birthday-it-is-still-day-1-after-5475-days-100-trillion-objects/

### 2026-03-13 — S3 at 20: 500+ trillion objects, 200M+ req/s

For S3's 20th anniversary, AWS reported S3 now holds **more than 500 trillion
objects** and serves **more than 200 million requests per second** globally,
across "hundreds of exabytes of data in 123 Availability Zones in 39 AWS Regions."
The post reiterates the five founding fundamentals — **Security, Durability,
Availability, Performance, Elasticity** — and states **"Durability is designed for
11 nines (99.999999999%), and we operate S3 to be lossless."** It also stresses
API backward compatibility: "the code you wrote for S3 in 2006 still works today,
unchanged."
- AWS News Blog, "Twenty years of Amazon S3 and building what's next"
  (dated 2026-03-13):
  https://aws.amazon.com/blogs/aws/twenty-years-of-amazon-s3-and-building-whats-next/

(So the project brief's "100+ trillion objects" is correct but conservative; the
**current** verified figure is **500+ trillion** as of March 2026. The 100T figure
is the March-2021 number.)

---

## The S3 API as a de facto standard

A major theme of object storage's history is that **the S3 HTTP API itself became
the industry standard**, independent of AWS the vendor. New object stores compete
on price/latency/egress while implementing "the S3 API" so existing tools and SDKs
work unchanged. The framing that **"the S3 API is the de facto standard for object
storage"** appears across vendor and practitioner sources.

- The de-facto-standard framing (secondary, but explicit): MinIO/Ceph comparison
  writeups state "the S3 API from AWS is the de-facto standard for object storage,
  and SDKs, CLI tools, and applications rely heavily on this interface."
  e.g. https://www.hostragons.com/en/blog/s3-compatible-storage-minio-and-ceph/
  **Attribution note:** this is a vendor/blog framing, not an AWS claim. I did
  **not** find a single canonical "the S3 API won" primary source; treat the
  phrase as a widely-repeated industry characterization rather than a sourced
  quotation. **Could not verify** a specific authoritative origin for the exact
  words "the S3 API won."

Concrete S3-compatible implementations and the standard's spread:

- **MinIO** — object store built around native S3 API compatibility ("Direct
  implementation of Amazon S3 API without translation layers"); commonly used as
  the reference S3-compatible server. https://min.io/
  (compatibility framing: https://www.automq.com/blog/minio-vs-ceph-distributed-storage-solutions-comparison)
- **Ceph RADOS Gateway (RGW)** — exposes both **S3-compatible** and **Swift**
  APIs over the Ceph object store. https://docs.ceph.com/en/latest/radosgw/s3/
- **Wasabi** — "hot cloud storage" marketed as S3-compatible.
  https://wasabi.com/
- **Backblaze B2** — added an **S3 Compatible API** on **May 4, 2020** (see
  timeline). https://www.backblaze.com/blog/backblaze-b2-s3-compatible-api/
- **Cloudflare R2** — S3-compatible, zero-egress (Sept 2021).
  https://blog.cloudflare.com/introducing-r2-object-storage/
- **Dell ECS** (Elastic Cloud Storage) — enterprise object platform with an
  S3-compatible API. https://www.dell.com/en-us/dt/storage/ecs/index.htm
  **Could not verify** a precise launch/feature date for ECS S3 support from a
  primary Dell source in this pass.
- **OpenStack Swift** — a **parallel/competing** object-storage API and
  implementation (not S3-derived). Swift has its own native API but is often
  *also* fronted with an S3-compatibility middleware ("swift3"/"s3api"); Ceph RGW
  similarly speaks both. So Swift is best framed as the main *non-S3* object API
  that nonetheless had to add S3 compatibility.
  https://docs.openstack.org/swift/latest/
- **Google Cloud Storage** — provides an **XML API** designed to interoperate with
  S3-style tooling (alongside its own JSON API), another sign of S3's gravitational
  pull. https://cloud.google.com/storage/docs/xml-api/overview

For how this de-facto standard shows up at the **SDK code-generation** layer (S3's
quirks — `S3ErrorWith200Status`, `S3UpdateEndpoint`, the `Error`→`S3Error` /
`Object`→`S3Object` renames, hand-written transfer managers and presigners), see
[`../CODE_GENERATION.md`](../CODE_GENERATION.md).

---

## Object storage vs block/file (the paradigm)

S3 popularized **object storage** as distinct from block and file storage:

- **Flat namespace.** Objects live in **buckets**, addressed by a **key**. There
  is no true directory tree — the "folders" in S3 are a UI convenience over
  key-name prefixes. (Bucket/object/key model: 2006 press release,
  https://press.aboutamazon.com/2006/3/amazon-web-services-launches)
- **HTTP API, not a filesystem mount.** Access is via REST/SOAP (now REST/HTTP)
  rather than POSIX file or block-device semantics. (Same source.)
- **Massive horizontal scale & elasticity** — virtually unlimited objects/data,
  scaling automatically (founding "Elasticity" fundamental:
  https://aws.amazon.com/blogs/aws/twenty-years-of-amazon-s3-and-building-whats-next/).
- **Durability over mountability.** The headline number is **eleven nines
  (99.999999999%) durability**, achieved by replicating across **at least 3
  Availability Zones** and continuously auditing/repairing data — a different
  optimization target than the low-latency random-write profile of block storage.
  (Durability design goal: re:Invent 2019 "Beyond eleven nines",
  https://www.youtube.com/watch?v=DzRyrvUF-C0; and the 20-year post,
  https://aws.amazon.com/blogs/aws/twenty-years-of-amazon-s3-and-building-whats-next/)

This is why object storage became the substrate for backups, data lakes, static
web assets, and media — and why **block** (e.g. EBS) and **file** (e.g. EFS)
remained separate AWS products.

---

## Key people & teams

- **Werner Vogels** — AWS **CTO**, longtime public voice on S3's design philosophy
  (eventual consistency, "simple experience with deep engineering behind it"). His
  15th-birthday retrospective is a primary narrative source.
  https://www.allthingsdistributed.com/2021/03/happy-15th-birthday-amazon-s3.html
  (Vogels is also widely associated with the "Eventually Consistent" essay that
  framed the consistency trade-offs object stores like S3 originally made.)
- **Andy Jassy** — at S3's 2006 launch the AWS VP quoted in the launch press
  release; later AWS CEO and then Amazon CEO. The 2006 quote (above) is the
  sourced datapoint. https://press.aboutamazon.com/2006/3/amazon-web-services-launches
- **Jeff Barr** — AWS Chief Evangelist; authored the canonical AWS News Blog posts
  for many S3 milestones, including the 2020 strong-consistency announcement.
  https://aws.amazon.com/blogs/aws/amazon-s3-update-strong-read-after-write-consistency/
- **Kevin Miller** — VP/GM of Amazon S3, the public S3 leadership voice in
  anniversary-era interviews (e.g. the "15 Years and 100 Trillion Objects"
  podcast). https://www.lastweekinaws.com/podcast/screaming-in-the-cloud/s3-15-years-and-100-trillion-objects-later-with-kevin-miller/

**Could not verify** the names of the *original* S3 engineering/founding team from
a primary source in this pass — AWS retrospectives credit "the team" but do not,
in the sources reviewed, enumerate the original builders. Marked here rather than
guessed.

---

## Notable incidents

### The February 28, 2017 us-east-1 S3 outage

On **February 28, 2017**, an S3 disruption in the **US-EAST-1 (N. Virginia)**
region took down or degraded a large swath of the web for roughly **four hours**.
AWS published an official post-mortem ("Summary of the Amazon S3 Service
Disruption in the Northern Virginia (US-EAST-1) Region").

**Official AWS post-mortem:** https://aws.amazon.com/message/41926/

Per that post-mortem:

- **Root cause — a mistyped command.** "At 9:37AM PST, an authorized S3 team
  member using an established playbook executed a command which was intended to
  remove a small number of servers for one of the S3 subsystems that is used by
  the S3 billing process. Unfortunately, **one of the inputs to the command was
  entered incorrectly and a larger set of servers was removed than intended.**"
- **Blast radius — two core subsystems went down.** The over-removal took out
  capacity for the **index subsystem** (manages metadata/location of all S3
  objects in the region; needed for GET, LIST, PUT, DELETE) and the **placement
  subsystem** (allocates storage for new objects). Both had to be **fully
  restarted**.
- **Slow restart.** AWS noted it "had not completely restarted the index
  subsystem or the placement subsystem in our larger regions for many years," and
  S3 had grown enough that the restart + safety checks "took longer than
  expected."
- **Timeline.** Disruption began **9:37 AM PST**; the **index subsystem** recovered
  enough to serve GET/LIST/DELETE by **12:26 PM PST**; **full S3 recovery** by
  **1:54 PM PST** — about **4h17m**.
- **Remediations.** AWS modified the capacity-removal tool to remove capacity more
  slowly and to **block removals that would take any subsystem below its minimum
  required capacity**, and committed to making the **Service Health Dashboard**
  resilient across regions (during the outage the dashboard itself depended on
  S3 us-east-1).
- All quotes/figures above: https://aws.amazon.com/message/41926/

**Impact (attribute to source, not to AWS).** The economic-impact figure widely
cited — that the outage cost S&P-500 companies about **$150 million** — comes from
**Cyence Inc.** (a cyber-risk-modeling startup), via press coverage, **not** from
AWS. Affected/degraded services reported in the press included Slack, Quora,
Medium, Trello, Coursera, Docker, Expedia, and others.
- Data Center Knowledge, "AWS Outage that Broke the Internet Caused by Mistyped
  Command" (cites Cyence's $150M figure):
  https://www.datacenterknowledge.com/outages/aws-outage-that-broke-the-internet-caused-by-mistyped-command
- NPR, "Amazon And The $150 Million Typo":
  https://www.npr.org/sections/thetwo-way/2017/03/03/518322734/amazon-and-the-150-million-typo

This incident is also a frequently-cited illustration of **us-east-1 as a single
point of failure** for the broader internet, and of the operational hazards of
manual "playbook" commands at scale.

---

## Sources (primary, consolidated)

- AWS press release — S3 launch (2006-03-14):
  https://press.aboutamazon.com/2006/3/amazon-web-services-launches
- AWS What's New — S3 launch (stamped 2006-03-13):
  https://aws.amazon.com/about-aws/whats-new/2006/03/13/announcing-amazon-s3---simple-storage-service/
- Werner Vogels — "Happy 15th Birthday Amazon S3" (2021-03-23):
  https://www.allthingsdistributed.com/2021/03/happy-15th-birthday-amazon-s3.html
- AWS News Blog — S3 15th birthday / 100 trillion objects (2021-03):
  https://aws.amazon.com/blogs/aws/amazon-s3s-15th-birthday-it-is-still-day-1-after-5475-days-100-trillion-objects/
- AWS News Blog — "Twenty years of Amazon S3..." / 500 trillion objects (2026-03-13):
  https://aws.amazon.com/blogs/aws/twenty-years-of-amazon-s3-and-building-whats-next/
- AWS — Amazon Glacier launch press release (2012-08-20):
  https://press.aboutamazon.com/2012/8/amazon-web-services-announces-amazon-glacier
- AWS — S3 storage classes (current): https://aws.amazon.com/s3/storage-classes/
- AWS News Blog — S3 strong read-after-write consistency (2020-12-01):
  https://aws.amazon.com/blogs/aws/amazon-s3-update-strong-read-after-write-consistency/
- AWS What's New — strong consistency (2020-12-01):
  https://aws.amazon.com/about-aws/whats-new/2020/12/amazon-s3-now-delivers-strong-read-after-write-consistency-automatically-for-all-applications/
- AWS — official S3 2017 outage post-mortem: https://aws.amazon.com/message/41926/
- AWS re:Invent 2019 — "Beyond eleven nines": https://www.youtube.com/watch?v=DzRyrvUF-C0
- Microsoft — Windows Azure GA (2010-02-01):
  https://blogs.microsoft.com/blog/2010/02/01/windows-azure-general-availability/
- Google — "Google Storage for Developers: A Preview" (2010-05-19):
  https://developers.googleblog.com/google-storage-for-developers-a-preview/
- Backblaze — B2 S3 Compatible API (2020-05-04):
  https://www.backblaze.com/blog/backblaze-b2-s3-compatible-api/
- Cloudflare — R2 announcement (2021-09):
  https://blog.cloudflare.com/introducing-r2-object-storage/
