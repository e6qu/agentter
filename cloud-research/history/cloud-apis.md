# Cloud Provider APIs and the Tooling Ecosystem: An Origins Overview

This is the connective "big picture" timeline that the per-tool histories in this
directory hang off (`terraform.md`, `ansible.md`, `chef.md`, `puppet.md`,
`saltstack.md`, `cloudformation-cdk.md`, `pulumi.md`, and the SDK histories under
`../sdks/`). It traces how cloud infrastructure first became reachable over an
HTTP API, how the first SDKs appeared, and how successive waves of third-party
tooling — language SDKs, config-management tools, then declarative
infrastructure-as-code — grew around those APIs.

Every factual claim below carries an inline source. Where a claim could not be
pinned to a primary source, it is marked **"Could not verify."**

---

## Part 1 — The birth of cloud web-service APIs (2004–2006)

The defining idea of the cloud era was *infrastructure delivered over an HTTP
web-service API* — request storage or compute with a signed HTTP call, pay per
use, no hardware procurement. Amazon Web Services shipped the first widely-used
examples.

### 2004-11-03 — Amazon SQS (the first AWS service, beta)

Amazon Simple Queue Service launched in preview/beta on **November 3, 2004**,
making it the very first AWS service — more than a year before S3 existed. AWS's
own 15th-anniversary blog post dates the beta to November 2004.
- AWS News Blog, "Amazon SQS – 15 Years and Still Queueing!":
  https://aws.amazon.com/blogs/aws/amazon-sqs-15-years-and-still-queueing/

SQS reached production (GA) the following summer. Jeff Barr's announcement
"Amazon Simple Queue Service" is dated **July 13, 2006** and states "SQS is now
in production," with unlimited queues per account and pay-as-you-go pricing.
- AWS News Blog, "Amazon Simple Queue Service":
  https://aws.amazon.com/blogs/aws/amazon_simple_q/

### 2006-03-14 — Amazon S3 (the service that started the modern run)

Amazon S3 launched on **March 14, 2006**. The AWS press release "Amazon Web
Services Launches" describes "a simple storage service that offers software
developers a highly scalable, reliable, and low-latency data storage
infrastructure at very low costs," priced at **$0.15/GB-month of storage and
$0.20/GB transferred**, with no minimum fee.
- AWS press release (March 14, 2006):
  https://press.aboutamazon.com/2006/3/amazon-web-services-launches
- AWS "What's New" announcement:
  https://aws.amazon.com/about-aws/whats-new/2006/03/13/announcing-amazon-s3---simple-storage-service/

AWS VP Andy Jassy is quoted: *"Amazon S3 is based on the idea that quality
Internet-based storage should be taken for granted."* (same press release).
AWS itself frames S3 as "the service that started it all" in its anniversary
retrospectives.
- Werner Vogels, "Happy 15th Birthday Amazon S3":
  https://www.allthingsdistributed.com/2021/03/happy-15th-birthday-amazon-s3.html
- AWS News Blog, "Twenty years of Amazon S3 and building what's next":
  https://aws.amazon.com/blogs/aws/twenty-years-of-amazon-s3-and-building-whats-next/

### 2006-08-25 — Amazon EC2 (compute via HTTP API, beta)

Amazon Elastic Compute Cloud opened for limited beta in August 2006. Jeff Barr's
AWS News Blog post "Amazon EC2 Beta" is dated **August 25, 2006** and announces
that EC2 is "now open for limited beta testing," renting virtual CPUs at "10
cents per clock hour."
- AWS News Blog, "Amazon EC2 Beta" (Aug 25, 2006):
  https://aws.amazon.com/blogs/aws/amazon_ec2_beta/

Note on the date: the corresponding AWS "What's New" entry is stamped **August
24, 2006**, one day earlier than Barr's blog post. Both are AWS primary sources;
secondary sources (e.g. Wikipedia) typically cite August 25, 2006 from Barr's
post.
- AWS "What's New," "Announcing Amazon Elastic Compute Cloud (Amazon EC2) - beta":
  https://aws.amazon.com/about-aws/whats-new/2006/08/24/announcing-amazon-elastic-compute-cloud-amazon-ec2---beta/
- Wikipedia (pointer to Barr's primary post): https://en.wikipedia.org/wiki/Amazon_Elastic_Compute_Cloud

EC2 dropped its beta label and reached full production on **October 23, 2008**
(see EC2 Wikipedia article, citing the AWS announcement). With S3 (storage) and
EC2 (compute) both exposed as signed HTTP APIs, "infrastructure via HTTP API"
became a usable reality, and the tooling ecosystem began forming around it.

---

## Part 2 — The first SDKs: boto (2006)

Raw HTTP + request signing is tedious, so language bindings appeared almost
immediately. The canonical early example is **boto**, the original AWS Python
library, started by **Mitch Garnaat in 2006**, shortly after S3's launch.

- The boto3 README confirms the name origin: *"Boto (pronounced boh-toh) was
  named after the fresh water dolphin native to the Amazon river. The name was
  chosen by the author of the original Boto library, Mitch Garnaat, as a
  reference to the company."*
  https://github.com/boto/boto3
- boto's own historical announcement (AWS) frames boto as having begun "soon
  after the launch of the Simple Storage Service from AWS on March 14, 2006."
  See AWS News Blog, "Now Available – AWS SDK For Python (Boto3)":
  https://aws.amazon.com/blogs/aws/now-available-aws-sdk-for-python-3-boto3/

Why early SDKs mattered: they turned a signed-HTTP protocol into ordinary
function calls in a host language, which is precisely what every later tooling
layer (config-management cloud modules, Terraform providers, Pulumi providers)
builds on top of. The detailed mechanics of boto/botocore — and how the modern
data-driven SDK is built from JSON service models — are covered in
`../sdks/boto3.md`.

> Could not verify (exact date): the precise first-commit/first-release date of
> boto in 2006 is not pinned to a primary source here; AWS and the boto README
> attest "2006" and "soon after S3's March 14, 2006 launch" but not a specific day.

---

## Part 3 — The config-management era bolts on cloud support (2005–2012)

The next wave of tooling did not originate in the cloud at all. These were
on-premises **configuration-management** tools — built to bring servers to a
desired state (packages, files, services) — that later "bolted on" cloud
provisioning modules as AWS and others grew.

### 2005 — Puppet (Luke Kanies / Reductive Labs)

Puppet's development started in **2005**, created by Luke Kanies at his company
Reductive Labs (later renamed Puppet Labs in 2010), written in Ruby, with
declarative "manifests."
- Wikipedia (pointer): https://en.wikipedia.org/wiki/Puppet_(software)
- Puppet company history (Luke Kanies author page): https://www.puppet.com/author/luke-kanies

### 2009-01-15 — Chef (Adam Jacob / Opscode)

Chef was first released to the public on **January 15, 2009**, created by Adam
Jacob and built into a product at Opscode. It was originally named "marionette,"
then renamed "Chef" (config units being "recipes").
- Wikipedia (pointer): https://en.wikipedia.org/wiki/Progress_Chef
- Chef Blog, "The History of Chef – What's in a Name?":
  https://blog.chef.io/2012/08/17/the-history-of-chef-%E2%80%93-whats-in-a-name/

### 2011-03 — Salt / SaltStack (Thomas S. Hatch)

Salt was released as open source under Apache 2.0 on **March 19, 2011**, created
by Thomas S. Hatch, originally a high-speed remote-execution engine (built on
ZeroMQ); the configuration-management (state) layer followed later in 2011 and
stabilized around Salt 0.9.3 in November 2011.
- Wikipedia (pointer): https://en.wikipedia.org/wiki/Salt_(software)

### 2012-02-20 — Ansible (Michael DeHaan)

Ansible's first release was made public on **February 20, 2012**, written by
Michael DeHaan; its agentless, SSH-based, module-based architecture made it easy
for the community to add cloud modules.
- Wikipedia (pointer): https://en.wikipedia.org/wiki/Ansible_(software)
- Opensource.com, "How Ansible got started and grew" (DeHaan's account):
  https://opensource.com/article/21/2/ansible-origin-story

These four tools were on-prem config managers first; cloud provisioning (EC2
instances, security groups, etc.) arrived as add-on modules/resource types as
the AWS API surface grew. Per-tool detail — including *when and how* each grew
its cloud modules — lives in `puppet.md`, `chef.md`, `saltstack.md`, and
`ansible.md` in this directory.

> Could not verify (precise dates): the exact first-shipping date of each tool's
> *cloud* provisioning module (as opposed to the tool's own first release) is not
> pinned to a primary source in this overview; that belongs in the per-tool docs.

---

## Part 4 — The shift to declarative, cloud-native IaC (2011–2018)

Config-management tools were imperative-ish and host-centric: great for
configuring a server's interior, awkward for *declaring an entire cloud
topology* (networks, IAM, managed services) and reconciling it. The next wave
was purpose-built for the cloud: declare desired infrastructure, let the tool
compute and apply the diff.

### 2011-02-25 — AWS CloudFormation

AWS CloudFormation was announced on **February 25, 2011** — "a simple way for
developers and businesses to create collections of related AWS resources and
provision them in an orderly and predictable fashion," via JSON templates, at no
additional charge.
- AWS press release (Feb 25, 2011):
  https://press.aboutamazon.com/2011/2/amazon-web-services-continues-to-make-it-easier-to-launch-applications-in-the-aws-cloud-introducing-aws-cloudformation
- AWS "What's New," "Introducing AWS CloudFormation":
  https://aws.amazon.com/about-aws/whats-new/2011/02/25/introducing-aws-cloudformation/

CloudFormation was AWS-only. Its template-driven, declarative model directly
inspired the cloud-agnostic tools that followed (see `cloudformation-cdk.md`).

### 2014-07-28 — Terraform (HashiCorp / Mitchell Hashimoto)

Terraform 0.1 was announced on **July 28, 2014**, described as "a tool for
safely and efficiently building, combining, and launching infrastructure… From
physical servers to containers to SaaS products." Its headline novelty was
**multi-provider composition** — e.g. a server on one provider plus a DNS record
on another, planned and applied together.
- HashiCorp blog, "HashiCorp Terraform" announcement (Jul 28, 2014):
  https://www.hashicorp.com/en/blog/terraform-announcement

The "why" is explicit in HashiCorp's own telling: Mitchell Hashimoto admired
CloudFormation but wanted an **open-source, cloud-agnostic** equivalent — an idea
he had floated as far back as a 2011 blog post.
- HashiCorp, "The Story of HashiCorp Terraform with Mitchell Hashimoto":
  https://www.hashicorp.com/en/resources/the-story-of-hashicorp-terraform-with-mitchell-hashimoto

Terraform reached 1.0 GA on **June 8, 2021**.
- HashiCorp, "Announcing HashiCorp Terraform 1.0 General Availability":
  https://www.hashicorp.com/en/blog/announcing-hashicorp-terraform-1-0-general-availability

Per-tool detail (provider model, HCL, plan/apply) is in `terraform.md`.

### 2018-06-18 — Pulumi (Joe Duffy / Eric Rudder)

Pulumi was founded in 2017 and **launched publicly as open source on June 18,
2018**, with Joe Duffy's "Hello, Pulumi!" post. Its distinguishing idea: author
infrastructure in **general-purpose programming languages** (JavaScript,
TypeScript, Python, Go on day one) across AWS, Azure, GCP, and Kubernetes —
loops, functions, classes, package managers — instead of a bespoke DSL or YAML.
- Joe Duffy, "Hello, Pulumi!" (Jun 18, 2018):
  https://joeduffyblog.com/2018/06/18/hello-pulumi/
- Pulumi blog, "Introducing Pulumi, a Cloud Development Platform":
  https://blog.pulumi.com/introducing-pulumi-a-cloud-development-platform

Pulumi 1.0 (GA as a platform) followed in 2019.
- Linux.com, "Pulumi Announces Pulumi 1.0 as Infrastructure As Code Platform":
  https://www.linux.com/news/pulumi-announces-pulumi-1-0-as-infrastructure-as-code-platform/

Per-tool detail is in `pulumi.md`.

**The arc of "why":** CloudFormation proved declarative, template-driven
provisioning but was single-cloud; Terraform generalized it to a cloud-agnostic
provider model with its own DSL (HCL); Pulumi pushed further by replacing the DSL
with real programming languages. Each step is a response to the limits of the
prior imperative/host-centric config-management approach for whole-cloud
topologies.

---

## Part 5 — The other hyperscalers' API/SDK timelines

AWS was first, but Google and Microsoft followed, each exposing their own APIs
and SDKs — broadening the surface that cross-cloud tooling (Terraform, Pulumi,
Ansible cloud modules) had to target.

### Google Cloud

- **2008-04-07 — Google App Engine** (preview), Google's first cloud offering,
  announced at Campfire One; a platform-as-a-service for running web apps on
  Google's infrastructure.
  - Google Cloud Platform Blog, "Introducing Google App Engine + our new blog"
    (Apr 7, 2008):
    https://cloudplatform.googleblog.com/2008/04/introducing-google-app-engine-our-new.html
  - Google Developers Blog, "Google App Engine at Campfire One":
    https://developers.googleblog.com/2008/04/google-app-engine-at-campfire-one.html
- **2012-06-28 — Google Compute Engine** announced (limited preview) at Google
  I/O 2012, Google's IaaS entry against EC2.
  - Google Cloud Platform Blog, "Google Compute Engine launches, expanding
    Google's cloud offerings":
    https://cloudplatform.googleblog.com/2012/06/google-compute-engine-launches.html
- **2013-12-02 — Compute Engine GA**, after roughly an 18-month preview.
  - Google Cloud Platform Blog, "Google Compute Engine is now Generally
    Available…":
    https://cloud.googleblog.com/2013/12/google-compute-engine-is-now-generally.html

### Microsoft Azure

- **2008-10 — Windows Azure announced** at the Professional Developers
  Conference (PDC) 2008, under the codename "Project Red Dog."
  - Wikipedia (pointer): https://en.wikipedia.org/wiki/Microsoft_Azure
- **2010-02-01 — Windows Azure general availability** in 21 countries, with full
  SLA support for production applications.
  - The Official Microsoft Blog, "Windows Azure General Availability"
    (Feb 1, 2010):
    https://blogs.microsoft.com/blog/2010/02/01/windows-azure-general-availability/

> Could not verify (exact day): the precise PDC 2008 announcement date for Azure
> from a Microsoft primary source is not pinned here; the Feb 1, 2010 GA date is
> confirmed by Microsoft's own blog above. The "October 2008 / Project Red Dog"
> framing is sourced to Wikipedia as a pointer.

---

## Part 6 — Standardized API descriptions: Swagger → OpenAPI (2010–2016)

As the number of cloud and SaaS APIs exploded, *machine-readable descriptions of
those APIs* became the lever for generating SDKs, docs, and tooling
automatically — a theme central to this project's `CODE_GENERATION.md`.

- **2010 (early) — Swagger** development begins, by **Tony Tam at Wordnik**, to
  describe Wordnik's JSON API and drive its developer console, server
  integration, and code generation.
  - Wikipedia (pointer): https://en.wikipedia.org/wiki/Swagger_(software)
  - InfoQ interview with Tony Tam: https://www.infoq.com/articles/swagger-interview-tony-tam/
- **2011-08 — Swagger Specification 1.0** published publicly by Tam.
  - Wikipedia / "A brief history of the OpenAPI Specification":
    https://dev.to/mikeralphson/a-brief-history-of-the-openapi-specification-3g27
- **2015-03 — SmartBear acquires Swagger** from Reverb Technologies (Wordnik's
  parent).
  - Wikipedia (pointer): https://en.wikipedia.org/wiki/OpenAPI_Specification
- **2015-11-05 — OpenAPI Initiative founded** under the Linux Foundation;
  SmartBear donates the Swagger specification. Founding members include Google,
  IBM, Microsoft, PayPal, Apigee, Capital One, Intuit, 3Scale, Restlet, and
  SmartBear.
  - Linux Foundation press release (Nov 5, 2015):
    https://www.linuxfoundation.org/press/press-release/new-collaborative-project-to-extend-swagger-specification-for-building-connected-applications-and-services
  - OpenAPI Initiative announcement:
    https://www.openapis.org/announcement/2015/11/05/new-collaborative-project-to-extend-swagger-specification-for-building-connected-applications-and-services
- **2016-01-01 — the spec is renamed** from "Swagger Specification" to "OpenAPI
  Specification."
  - Wikipedia (pointer): https://en.wikipedia.org/wiki/OpenAPI_Specification

Standardized, machine-readable API descriptions (OpenAPI, and adjacent
provider-specific IDLs like AWS Smithy, Google's protobuf/Discovery, Azure
TypeSpec) are what make *industrial-scale, multi-language SDK generation*
possible — the subject of this project's `CODE_GENERATION.md`. Tooling no longer
needs a hand-written client per service per language; it can generate them from
the spec.

---

## Consolidated timeline

| Date | Event | Primary source |
|------|-------|----------------|
| 2004-11-03 | Amazon SQS beta (first AWS service) | AWS blog (15-yr retro) |
| 2006-03-14 | Amazon S3 GA | AWS press release |
| 2006-07-13 | Amazon SQS production/GA | AWS News Blog |
| 2006-08-25 | Amazon EC2 beta (What's New stamped 08-24) | AWS News Blog (Barr) |
| 2006 | boto (original AWS Python SDK), Mitch Garnaat | boto3 README / AWS blog |
| 2008-04-07 | Google App Engine preview | Google Cloud Platform Blog |
| 2008-10 | Windows Azure announced (PDC, "Red Dog") | Wikipedia (pointer) |
| 2009-01-15 | Chef first public release | Wikipedia / Chef blog |
| 2010-02-01 | Windows Azure GA | Microsoft official blog |
| 2010 (early) | Swagger development begins (Tony Tam, Wordnik) | Wikipedia / InfoQ |
| 2011-02-25 | AWS CloudFormation announced | AWS press release |
| 2011-03-19 | Salt open-sourced (Thomas Hatch) | Wikipedia |
| 2011-08 | Swagger Spec 1.0 published | brief-history article |
| 2012-02-20 | Ansible first release (Michael DeHaan) | Wikipedia / Opensource.com |
| 2012-06-28 | Google Compute Engine preview (Google I/O) | Google Cloud Platform Blog |
| 2013-12-02 | Google Compute Engine GA | Google Cloud Platform Blog |
| 2014-07-28 | Terraform 0.1 announced (HashiCorp) | HashiCorp blog |
| 2015-11-05 | OpenAPI Initiative founded (Linux Foundation) | Linux Foundation PR |
| 2016-01-01 | Swagger Spec renamed OpenAPI Specification | Wikipedia (pointer) |
| 2018-06-18 | Pulumi public open-source launch | joeduffyblog.com |
| 2021-06-08 | Terraform 1.0 GA | HashiCorp blog |

(2005: Puppet development begins — Luke Kanies / Reductive Labs — no single
launch-day primary source; see `puppet.md`.)

---

## How this frames the per-family docs

- **SDKs first** (`../sdks/boto3.md`, etc.): turn signed HTTP into function calls.
- **Config-management cloud modules** (`puppet.md`, `chef.md`, `saltstack.md`,
  `ansible.md`): on-prem desired-state tools that grew cloud provisioning.
- **Declarative cloud-native IaC** (`cloudformation-cdk.md`, `terraform.md`,
  `pulumi.md`): purpose-built to declare and reconcile whole-cloud topologies.
- **Standardized API descriptions** (Swagger/OpenAPI, and the provider IDLs in
  `../CODE_GENERATION.md`): the substrate that lets all of the above be
  *generated* rather than hand-written, at industrial scale.

---

## Key people (chronological)

A "who built the foundations" thread for the early cloud APIs and their first
SDKs. As above, every factual claim carries an inline source. Where the record
is a **widely-repeated origin story** rather than primary evidence, that is
called out explicitly; where a claim could not be pinned, it is marked **"Could
not verify."**

### 2003 — Chris Pinkham & Benjamin Black: the EC2 vision paper (AWS)

The most concrete, first-person account of EC2's origins comes from **Benjamin
Black** himself. On his blog he recounts that in **2003** he and **Chris
Pinkham** wrote a short paper describing "a vision for Amazon infrastructure
that was completely standardized, completely automated, and relied extensively
on web services for things like storage," and that the paper closed by
mentioning "the possibility of selling virtual servers as a service." In early
2004, per Black, "Jeff [Bezos] was interested in the virtual server as a service
idea and asked for a more detailed write up." Black is careful to note his
initial design "looked almost nothing like the production EC2 service," crediting
the build team with the result.
- Benjamin Black, "EC2 Origins" (Jan 25, 2009) — **primary, first-person**:
  https://blog.b3k.us/2009/01/25/ec2-origins.html

This is **evidence** (the principal's own contemporaneous-ish account), as
distinct from the many second-hand retellings of the same story.

### 2004 (Dec) — Chris Pinkham and the Cape Town team build EC2 (AWS)

**Chris Pinkham**, then an Amazon infrastructure director, wanted to return home
to South Africa; rather than lose him, Amazon let him open an engineering office
in **Cape Town**, which stood up around **December 2004** to build what became
EC2. AWS's own retrospective (via TechCrunch, drawing on AWS interviews) names
**Dave Brown** — "VP of EC2 today, and who helped build the first versions of
the tech" — as hired around the time the office opened, working with Pinkham and
"a team of 14 people" on what was then called the "Amazon Execution Engine."
- TechCrunch, "How Amazon EC2 grew from a notion into a foundational element of
  cloud computing" (Aug 28, 2021) — quotes AWS's Dave Brown and Peter DeSantis:
  https://techcrunch.com/2021/08/28/how-amazon-ec2-grew-from-a-notion-into-a-foundational-element-of-cloud-computing/

> Naming caution (EVIDENCE vs ORIGIN STORY): secondary sources commonly name the
> Cape Town lead developer as **"Christopher Brown"** and also credit **Willem
> van Biljon** as a co-lead of the EC2 team. The AWS-sourced TechCrunch piece
> above names **"Dave Brown"** (current VP of EC2). Whether "Christopher Brown"
> and "Dave Brown" are the same person, and van Biljon's exact title, are not
> reconciled by a single primary source here.
> - Wikipedia, "Willem Van Biljon" (pointer, secondary):
>   https://en.wikipedia.org/wiki/Willem_Van_Biljon
> - Could not verify (single primary source): that "Christopher Brown" =
>   "Dave Brown," and van Biljon's precise role/title on the EC2 team.

### 2003 / 2006 — Andy Jassy: conceived and led the AWS business

**Andy Jassy** is the executive most associated with founding the AWS business.
By his own account, the idea crystallized out of a **2003** executive retreat at
Jeff Bezos's house, where Amazon realized it "had also become quite good at
running infrastructure services" (compute, storage, database) developed to solve
its own scaling problems. Jassy, then Bezos's chief of staff, went on to lead AWS
from its inception; he served as AWS CEO from April 2016 until becoming Amazon
CEO in July 2021.
- TechCrunch, "How AWS came to be" — based on Jassy's own retelling (Jul 2, 2016):
  https://techcrunch.com/2016/07/02/andy-jassys-brief-history-of-the-genesis-of-aws/
- Wikipedia, "Andy Jassy" (pointer, secondary, for AWS CEO 2016 / Amazon CEO 2021):
  https://en.wikipedia.org/wiki/Andy_Jassy

> Could not verify (against a primary source here): the often-cited detail that
> the AWS "OP1" operating plan asked for **57 people** to start. It appears in
> secondary retellings (e.g. John Furrier's account) but is not pinned to a
> primary AWS document in this overview.

### 2004–2005 — Werner Vogels: Amazon CTO and "everything fails all the time"

**Werner Vogels** (b. 3 Oct 1958), a former Cornell research scientist
(1994–2004), **joined Amazon in September 2004** as director of systems research
and was **named CTO in January 2005** (VP in March 2005). As CTO he became the
public technologist/evangelist for AWS and for "design for failure," popularizing
the maxim **"Everything fails all the time."**
- Wikipedia, "Werner Vogels" (secondary; dates of joining/CTO appointment):
  https://en.wikipedia.org/wiki/Werner_Vogels
- All Things Distributed (Vogels's own site / bio):
  https://www.allthingsdistributed.com/about.html

> EVIDENCE vs ORIGIN STORY: the quote is universally attributed to Vogels and is
> a genuine, oft-repeated theme of his talks, but the **single original source**
> (a specific interview/talk and date of first utterance) is not pinned here.
> The phrasing appears in, e.g., ACM's "Everything Fails All the Time":
> https://cacm.acm.org/opinion/everything-fails-all-the-time/
> - Could not verify: the exact first occasion/publication where Vogels first
>   said "everything fails all the time."

### 2006 — Mitch Garnaat: creator of boto, the first AWS Python SDK

**Mitch Garnaat** created **boto**, the original AWS Python library, in **2006**,
soon after S3's March 14, 2006 launch; he named it after the Amazon-river
dolphin. He later **joined AWS**, where he is a principal engineer and is
credited as the creator of boto, **botocore**, and the **AWS CLI** — the
data-driven foundation of the modern Python SDK. (Full mechanics and the boto →
botocore → boto3 lineage are in `../sdks/boto3.md`.)
- boto3 README — confirms Garnaat as the original boto author and the name origin:
  https://github.com/boto/boto3
- AWS News Blog, "Now Available – AWS SDK for Python (Boto3)" — frames boto as
  beginning soon after the March 14, 2006 S3 launch:
  https://aws.amazon.com/blogs/aws/now-available-aws-sdk-for-python-3-boto3/
- Mitch Garnaat, GitHub profile (@garnaat): https://github.com/garnaat

> Could not verify (see Part 2): the precise first-commit/first-release **day**
> of boto in 2006 is not pinned to a primary source.

### 2008 — Urs Hölzle: Google's infrastructure leader behind GCP

**Urs Hölzle**, Google's eighth employee and first VP of Engineering (joined
1999), became the long-running **SVP of Technical Infrastructure** and the
executive most associated with the systems underpinning Google's services and,
later, Google Cloud Platform. He led infrastructure during the era when **Google
App Engine** (2008 preview) and **Google Compute Engine** (2012 preview) shipped.
- Wikipedia, "Urs Hölzle" (secondary; role, tenure, GCP association):
  https://en.wikipedia.org/wiki/Urs_H%C3%B6lzle

> Could not verify (against primary sources here): that Hölzle was the *named*
> originator/lead of App Engine or Compute Engine specifically. The evidence
> supports him as the overarching technical-infrastructure leader, not as the
> attributed creator of either individual product. (App Engine / Compute Engine
> launch sourcing is in Part 5.)

### 2008 — Microsoft Azure: Ozzie (announce), Srivastava (lead), Cutler (hypervisor)

Three people anchor Azure's origin:

- **Ray Ozzie**, Microsoft's **Chief Software Architect** (the role he took over
  from Bill Gates), **unveiled Windows Azure** at PDC 2008 on **October 27,
  2008**, calling it "a turning point for Microsoft and the development
  community."
  - Microsoft News, "Microsoft Unveils Windows Azure at Professional Developers
    Conference" (Oct 27, 2008) — **primary**:
    https://news.microsoft.com/source/2008/10/27/microsoft-unveils-windows-azure-at-professional-developers-conference/
- **Amitabh Srivastava**, a Microsoft corporate VP, recognized the need for a
  cloud operating system and **led the "Red Dog" project** (Azure's codename);
  he recruited Dave Cutler onto it. He co-keynoted the PDC 2008 unveiling.
  - Microsoft Learn, PDC08 Day One Keynote (Ozzie, Srivastava, Muglia, Thompson):
    https://learn.microsoft.com/en-us/shows/pdc-pdc08/kyn01
  - Microsoft News feature (below) — Srivastava on recruiting Cutler.
- **Dave Cutler**, the engineer behind DEC's **VMS** (late 1970s) and **Windows
  NT** (the basis of every major Windows since 1993), **wrote the Azure
  hypervisor** for Red Dog. Srivastava: "Dave wrote the hypervisor; it's probably
  the most efficient you could think of."
  - Microsoft News, "The engineer's engineer… Dave Cutler" — **primary feature**,
    covers VMS, Windows NT, and the Azure/Red Dog hypervisor, with Srivastava's
    quotes:
    https://news.microsoft.com/features/the-engineers-engineer-computer-industry-luminaries-salute-dave-cutlers-five-decade-long-quest-for-quality/

All three Azure attributions are **evidence-backed** by Microsoft primary
sources above (announcement, keynote roster, and the Cutler feature), not merely
origin-story lore.

---

### Key-people timeline (condensed)

| When | Person(s) | Role in the foundations | Strength |
|------|-----------|-------------------------|----------|
| 2003 | Chris Pinkham & Benjamin Black | Wrote the AWS infra/"virtual server as a service" vision paper → EC2 | Evidence (Black's own account) |
| 2003 | Andy Jassy | Conceived the AWS business out of the Bezos retreat; later led/CEO'd AWS | Evidence (Jassy's retelling) + secondary |
| 2004-12 | Chris Pinkham + Cape Town team (Brown; van Biljon ??) | Built EC2 in Cape Town | Evidence; some names unreconciled |
| 2004–05 | Werner Vogels | Joined Amazon 9/2004; CTO 1/2005; "design for failure" evangelist | Evidence (dates); quote origin unpinned |
| 2006 | Mitch Garnaat | Created boto, the first AWS Python SDK; later AWS principal eng | Evidence |
| 2008+ | Urs Hölzle | Google's technical-infrastructure leader behind GCP | Evidence (role); not named product creator |
| 2008 | Ray Ozzie | Unveiled Windows Azure at PDC, 10/27/2008 (Chief Software Architect) | Evidence (MS primary) |
| 2008 | Amitabh Srivastava | Led the "Red Dog" (Azure) project | Evidence (MS primary) |
| 2008 | Dave Cutler | Wrote the Azure hypervisor (after VMS, Windows NT) | Evidence (MS primary) |
