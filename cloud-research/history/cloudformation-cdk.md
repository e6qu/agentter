# AWS Native IaC: CloudFormation, SAM, and the CDK — A Chronological History

A dated history of Amazon Web Services' first-party Infrastructure-as-Code (IaC)
stack, with particular attention to the dynamics between AWS's own tools and the
open-source IaC ecosystem (Terraform, Pulumi), and to the **partnerships** that
complicate any simple "rivalry" framing.

Every factual claim below carries an inline source URL. Where a claim could not be
verified against a primary source, it is explicitly flagged.

---

## Timeline

### February 25, 2011 — AWS CloudFormation launches: the first major cloud-native IaC

AWS announced CloudFormation on February 25, 2011. The Amazon press release framed
it as letting "Developers and businesses ... automate the creation and provisioning
of their AWS infrastructure resources," and quoted a customer saying CloudFormation
"eliminates the manual processes and allows our developers to fire up infrastructure
stacks at will"
([Amazon press release, Feb 25 2011](https://press.aboutamazon.com/2011/2/amazon-web-services-continues-to-make-it-easier-to-launch-applications-in-the-aws-cloud-introducing-aws-cloudformation);
[AWS What's New, Feb 25 2011](https://aws.amazon.com/about-aws/whats-new/2011/02/25/introducing-aws-cloudformation/)).

- **Template model.** At launch the template was a single text file. The AWS
  What's New post describes it only as "a simple text file called a template" and
  does not name the format
  ([AWS What's New](https://aws.amazon.com/about-aws/whats-new/2011/02/25/introducing-aws-cloudformation/)).
  In practice the original 2011 template language was **JSON**; the template format
  version string is `2010-09-09`, still the only valid value today
  ([AWS docs: template format version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/format-version-structure.html)).
  **YAML support was added later, in 2016**
  ([AWS docs: template formats](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-formats.html)).
- **Resource-provider / stack model.** CloudFormation introduced the durable
  concepts — templates, stacks, parameters, outputs, intrinsic functions, and typed
  resources — that AWS itself notes "still mean what they meant in 2011"
  ([AWS DevOps Blog: history and future roadmap of the CloudFormation Registry](https://aws.amazon.com/blogs/devops/cloudformation-coverage/)).
- **Pricing.** Free; customers pay only for the underlying resources
  ([Amazon press release](https://press.aboutamazon.com/2011/2/amazon-web-services-continues-to-make-it-easier-to-launch-applications-in-the-aws-cloud-introducing-aws-cloudformation)).

This made CloudFormation the first widely used cloud-vendor-native declarative IaC
service. (HashiCorp's Terraform would not arrive until July 2014 — outside the scope
of this AWS-focused document, but useful context for the "vs open source" framing
below.)

### November 18, 2016 — AWS SAM (Serverless Application Model)

AWS introduced the Serverless Application Model — originally codenamed "Project
Flourish" — as an **extension of CloudFormation** for serverless apps, providing
shorthand resource types (`AWS::Serverless::Function`, `::Api`, `::SimpleTable`)
that expand into full CloudFormation
([AWS What's New: Introducing the AWS Serverless Application Model](https://aws.amazon.com/about-aws/whats-new/2016/11/introducing-the-aws-serverless-application-model/)).

- SAM is technically a **CloudFormation macro/transform**: "The AWS SAM transform is
  a AWS CloudFormation macro that transforms SAM templates into CloudFormation
  templates"
  ([aws/serverless-application-model on GitHub](https://github.com/aws/serverless-application-model)).
- It was released under the **Apache 2.0 license**, explicitly to let the ecosystem
  adopt it
  ([AWS What's New](https://aws.amazon.com/about-aws/whats-new/2016/11/introducing-the-aws-serverless-application-model/)).

### July 17, 2018 — AWS CDK developer preview

AWS announced the Cloud Development Kit as a developer preview. The CDK lets
developers define infrastructure in general-purpose programming languages, which the
toolkit then **synthesizes into CloudFormation templates** for deployment
([AWS CDK — Wikipedia, citing the 2018 preview](https://en.wikipedia.org/wiki/AWS_Cloud_Development_Kit)).
*(Could not verify an exact-day primary AWS blog/permalink for the July 17, 2018
preview date; the July 2018 developer-preview timing is reported by Wikipedia's CDK
article and corroborated by the GA post below, but the precise day should be treated
as reported rather than confirmed from an AWS primary source.)*

### June 2018 / September 2019 — Pulumi (third-party context)

Pulumi — the other major "use a real programming language for IaC" tool that emerged
alongside CDK — had its **open-source launch in June 2018** and reached **1.0 in
September 2019**, per founder Joe Duffy
([Joe Duffy, "Journey to Pulumi 1.0," Sep 5 2019](https://joeduffyblog.com/2019/09/05/journey-to-pulumi-1-0/)).
Unlike CDK, Pulumi runs programs through its own deployment engine rather than
synthesizing CloudFormation, and is multi-cloud
([Pulumi vs. AWS CDK comparison](https://www.pulumi.com/docs/iac/comparisons/aws-cdk/)).

### July 11, 2019 — AWS CDK reaches General Availability

AWS announced CDK GA on July 11, 2019, with **TypeScript and Python** generally
available and **C# and Java in developer preview**
([AWS News Blog: AWS CDK GA, Jul 11 2019](https://aws.amazon.com/blogs/aws/aws-cloud-development-kit-cdk-typescript-and-python-are-now-generally-available/)).

- **Relationship to CloudFormation (synthesis).** The GA post demonstrates `cdk
  synth`, which "outputs more than 800 lines of plain CloudFormation YAML" — CDK is
  a higher-level abstraction that compiles down to CloudFormation, which still does
  the actual provisioning
  ([AWS News Blog](https://aws.amazon.com/blogs/aws/aws-cloud-development-kit-cdk-typescript-and-python-are-now-generally-available/)).
- **jsii multi-language.** CDK's polyglot support comes from **jsii**: AWS authors
  the construct libraries once in TypeScript and projects them into other languages.
  AWS describes jsii as "the technology that enables the CDK to deliver polyglot
  libraries from a single codebase"
  ([AWS CDK FAQs](https://aws.amazon.com/cdk/faqs/)).

### July 16, 2020 — CDK for Terraform (CDKTF): the AWS × HashiCorp **partnership**

This is the key partnership the user asked to source. AWS and HashiCorp jointly
announced a preview of **CDK for Terraform (cdktf)** — applying the CDK construct
programming model and jsii to generate **Terraform** configuration (JSON) instead of
CloudFormation. The AWS Developer Tools Blog post, **co-authored by Chris Fife (AWS
Senior Product Manager) and Anubhav Mishra (HashiCorp Technical Advisor)**, states:
"The AWS CDK and HashiCorp Terraform teams collaborated to create this new project
by leveraging two key technologies" — the CDK construct model and jsii
([AWS Developer Tools Blog: "Introducing the Cloud Development Kit for Terraform (Preview)," Jul 16 2020](https://aws.amazon.com/blogs/developer/introducing-the-cloud-development-kit-for-terraform-preview/)).

- The preview also involved **Terrastack**, alongside AWS and HashiCorp
  ([InfoQ, Jul 2020](https://www.infoq.com/news/2020/07/cdk-terraform/)).
- HashiCorp later confirmed the framing from its side: "Two years ago, we announced
  a collaboration with Amazon Web Services (AWS) and its Cloud Development Kit (CDK)
  team, to offer a community preview of Cloud Development Kit for Terraform (CDKTF)"
  ([HashiCorp blog: "CDK for Terraform Is Now Generally Available," Aug 1 2022](https://www.hashicorp.com/en/blog/cdk-for-terraform-now-generally-available)).
- **This is explicitly cooperation, not rivalry:** AWS's own CDK team helped build a
  tool whose output drives a competing, open-source provisioning engine. The 2020
  post describes HashiCorp as "an AWS Partner Network (APN) Advanced Technology
  Partner and member of the AWS DevOps Competency"
  ([AWS Developer Tools Blog, Jul 16 2020](https://aws.amazon.com/blogs/developer/introducing-the-cloud-development-kit-for-terraform-preview/)).

### September 30, 2021 — AWS Cloud Control API (and the CloudFormation Registry behind it)

AWS announced **General Availability of Cloud Control API**, a uniform set of five
CRUDL "verbs" — `CreateResource`, `GetResource`, `UpdateResource`,
`DeleteResource`, `ListResources` — for managing AWS (and third-party) resources
([AWS What's New: GA of AWS Cloud Control API, Sep 30 2021](https://aws.amazon.com/about-aws/whats-new/2021/09/aws-announces-cloud-control-api/);
[AWS News Blog: Announcing AWS Cloud Control API](https://aws.amazon.com/blogs/aws/announcing-aws-cloud-control-api/)).

- **Launch partners were the competition.** AWS's own announcement names **HashiCorp
  Terraform and Pulumi** as integration launch partners, so that those tools "can
  access new AWS services typically on the day they launch"
  ([AWS What's New, Sep 30 2021](https://aws.amazon.com/about-aws/whats-new/2021/09/aws-announces-cloud-control-api/)).
  This is another concrete instance of AWS building infrastructure to *help*
  third-party IaC tools rather than to lock them out.
- **The CloudFormation Registry underpins this.** AWS launched the **CloudFormation
  Registry in 2019** (private resource types via the open-source CloudFormation CLI,
  using standardized CRUDL handlers), then a **public registry in 2021** for APN
  partners to publish extensions. Cloud Control API exposes those registry resource
  types through generic APIs
  ([AWS DevOps Blog: history and future roadmap of the CloudFormation Registry](https://aws.amazon.com/blogs/devops/cloudformation-coverage/)).

### August 2022 — CDKTF reaches GA; CDK v2 / Construct Hub GA

- **CDKTF GA.** AWS and HashiCorp announced CDK for Terraform general availability.
  AWS's open-source blog: "Today, we are pleased to announce with HashiCorp that CDK
  for Terraform (CDKTF) is now generally available"; CDKTF supports C#, Python,
  TypeScript, Java, and Go, "Built on top of the open source JSII library"
  ([AWS Open Source Blog: "Announcing CDK for Terraform on AWS," Aug 9 2022](https://aws.amazon.com/blogs/opensource/announcing-cdk-for-terraform-on-aws/);
  [HashiCorp GA blog, Aug 1 2022](https://www.hashicorp.com/en/blog/cdk-for-terraform-now-generally-available)).
- **CDK v2 + Construct Hub GA** also landed in this period, consolidating the AWS
  Construct Library into a single `aws-cdk-lib` package
  ([AWS News Blog: GA of Construct Hub and AWS CDK v2](https://aws.amazon.com/blogs/aws/announcing-general-availability-of-construct-hub-and-aws-cloud-development-kit-version-2/)).

### 2023 — AWS leans *into* Terraform across its own product surface

A cluster of 2023 announcements shows AWS actively integrating Terraform into
first-party services — strong evidence against a "war on Terraform" reading:

- **April 2023:** AWS Service Catalog adds support for **Terraform open source**
  ([AWS What's New, Apr 2023](https://aws.amazon.com/about-aws/whats-new/2023/04/aws-service-catalog-terraform-open-source/)).
- **August 2023:** AWS Service Catalog adds support for **HashiCorp Terraform Cloud**
  ([AWS What's New, Aug 2023](https://aws.amazon.com/about-aws/whats-new/2023/08/aws-service-catalog-hashicorp-terraform-cloud/)).
- **November 2023:** Amazon CodeCatalyst adds **Terraform** support
  ([AWS What's New, Nov 2023](https://aws.amazon.com/about-aws/whats-new/2023/11/amazon-codecatalyst-supports-terraform/)).
- **October 11, 2023:** AWS publishes a celebratory blog, "Two billion downloads of
  the Terraform AWS Provider shows value of IaC," describing Terraform as "one of the
  world's most widely adopted IaC tools, with thousands of commercial customers, over
  3,000 Terraform providers, and an extensive library of 12,000 modules," and listing
  joint AWS×HashiCorp initiatives (Cloud Control provider, Service Catalog for
  Terraform Cloud, CDKTF, SAM support for Terraform)
  ([AWS Insights blog, Oct 11 2023](https://aws.amazon.com/blogs/aws-insights/two-billion-downloads-of-the-terraform-aws-provider-shows-value-of-iac-for-infrastructure-management/)).

### 2025 — CDKTF wind-down (third-party context)

CDKTF, the AWS×HashiCorp collaboration, was **deprecated and scheduled for archival
around December 10, 2025**, per reporting
([Pulumi blog: "CDKTF is deprecated: What's next for your team?"](https://www.pulumi.com/blog/cdktf-is-deprecated-whats-next-for-your-team/);
[Hacker News discussion: "The future of Terraform CDK"](https://news.ycombinator.com/item?id=46222165)).
*(Could not verify a HashiCorp/AWS primary-source deprecation notice with an exact
date; the December 10, 2025 archival date is reported by Pulumi and HN commentary,
not confirmed here from a HashiCorp primary doc. Flagged for follow-up.)*

---

## The "AWS vs Terraform" framing — verified analysis

The user asked specifically to verify the claim that AWS wants to **"promote
CloudFormation and CDK against open-source solutions like Terraform."** The evidence
is **nuanced**, and the primary sources point much more toward cooperation than a
"war." Both sides, sourced:

### Evidence of competition / AWS promoting its own tools
- AWS builds, markets, and prices its own first-party stack (CloudFormation free,
  CDK, SAM) and naturally positions them for AWS-only shops. AWS's own guidance says:
  "If you are managing your infrastructure entirely on AWS, then AWS CloudFormation
  and the AWS Cloud Development Kit (AWS CDK) are good options. They provide
  out-of-the-box state management, and you can also natively use new features or AWS
  resources"
  ([AWS Prescriptive Guidance: Choosing an IaC tool](https://docs.aws.amazon.com/prescriptive-guidance/latest/choose-iac-tool/choose-tool.html)).
  This is competitive positioning — but it is framed as "good options," not as a
  case against Terraform.
- That CDK and CloudFormation get same-day support for new AWS resources, while
  third-party tools historically lagged, is a structural advantage AWS controls
  (CloudFormation Registry / Cloud Control API are AWS's mechanisms to *close* that
  gap for partners)
  ([AWS DevOps Blog](https://aws.amazon.com/blogs/devops/cloudformation-coverage/)).

### Evidence of cooperation / AWS embracing Terraform (stronger, more direct)
- **AWS co-built a Terraform tool.** The AWS CDK team itself helped create CDKTF, a
  tool that emits Terraform config
  ([AWS Developer Tools Blog, Jul 16 2020](https://aws.amazon.com/blogs/developer/introducing-the-cloud-development-kit-for-terraform-preview/)).
- **AWS made Terraform a launch partner** for Cloud Control API
  ([AWS What's New, Sep 30 2021](https://aws.amazon.com/about-aws/whats-new/2021/09/aws-announces-cloud-control-api/)).
- **AWS integrated Terraform into its own services** (Service Catalog, CodeCatalyst)
  in 2023
  ([Apr 2023](https://aws.amazon.com/about-aws/whats-new/2023/04/aws-service-catalog-terraform-open-source/),
  [Aug 2023](https://aws.amazon.com/about-aws/whats-new/2023/08/aws-service-catalog-hashicorp-terraform-cloud/),
  [Nov 2023](https://aws.amazon.com/about-aws/whats-new/2023/11/amazon-codecatalyst-supports-terraform/)).
- **AWS publicly praises Terraform's adoption** ("two billion downloads")
  ([AWS Insights, Oct 11 2023](https://aws.amazon.com/blogs/aws-insights/two-billion-downloads-of-the-terraform-aws-provider-shows-value-of-iac-for-infrastructure-management/)).
- **AWS officially recommends Terraform** for multi-cloud/hybrid in its own
  Prescriptive Guidance, which evaluates five tools — CloudFormation, SAM, CDK,
  Terraform, and Pulumi — side by side and states there is "no one-size-fits-all
  model," recommending Terraform where platform-agnosticism matters
  ([AWS Prescriptive Guidance: Choosing an IaC tool](https://docs.aws.amazon.com/prescriptive-guidance/latest/choose-iac-tool/introduction.html);
  [Terraform page](https://docs.aws.amazon.com/prescriptive-guidance/latest/choose-iac-tool/terraform.html);
  [Pulumi page](https://docs.aws.amazon.com/prescriptive-guidance/latest/choose-iac-tool/pulumi.html)).
- HashiCorp is a formal **AWS Partner Network** partner; the Terraform AWS provider is
  owned and maintained by HashiCorp and is one of the most-downloaded providers
  ([hashicorp/aws on Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest)).

**Verdict on the user's claim:** The notion that AWS *promotes its own tools* is
defensible as ordinary first-party positioning (AWS does market CloudFormation/CDK
and gives them structural day-one advantages). But the stronger, more specific
framing — that AWS is *pushing its tools against* Terraform / treating it as an
adversary — is **not supported by primary sources**. The documented record is one of
**active partnership**: AWS co-developed CDKTF, made Terraform a Cloud Control API
launch partner, integrated Terraform into its own services, and officially
recommends Terraform in its own decision guidance. The relationship is best
described as *coopetition*, weighted toward cooperation in the public record.

---

## Adoption: Terraform's dominance vs CloudFormation (sourced)

- **Datadog, State of DevSecOps 2024:** "Over 71 percent of organizations use IaC
  through at least one popular IaC technology such as Terraform, CloudFormation, or
  Pulumi" on AWS (vs ~55% on Google Cloud). Datadog found **"Terraform is the most
  popular technology ... coming just before cloud-specific IaC tools, namely
  CloudFormation and Google Deployment Manager."** Datadog does **not** publish an
  exact Terraform-vs-CloudFormation percentage split
  ([Datadog: State of DevSecOps 2024](https://www.datadoghq.com/state-of-devsecops-2024/);
  [Datadog press release](https://www.datadoghq.com/about/latest-news/press-releases/datadogs-state-of-devsecops-2024-report-finds-organizations-arent-fully-embracing-automation-for-securing-cloud-deployments/)).
- Azure data was excluded from that report because "Azure Activity Logs don't log
  HTTP user agents"
  ([Datadog: State of DevSecOps 2024](https://www.datadoghq.com/state-of-devsecops-2024/)).
- Broader market-share figures (e.g., a "Firefly State of IaC 2025" estimate of
  ~33–62% for Terraform depending on segmentation) appear in secondary write-ups but
  **could not be verified against a Firefly primary source here** — flagged for
  follow-up rather than relied upon.

---

## Third-party IaC on AWS — brief landscape

- **Terraform (HashiCorp, GA July 2014):** the dominant cross-cloud IaC tool; its AWS
  provider is HashiCorp-owned and among the most downloaded
  ([hashicorp/aws registry](https://registry.terraform.io/providers/hashicorp/aws/latest)).
  (HashiCorp re-licensed Terraform under the BUSL in 2023, prompting the OpenTofu
  fork — beyond this document's scope but part of the broader IaC landscape;
  see [CIO on OpenTofu](https://www.cio.com/article/3479887/opentofu-liberating-iac-and-devops-beyond-terraform.html).)
- **Pulumi (OSS launch June 2018, 1.0 Sep 2019):** real-programming-language IaC with
  its own engine, multi-cloud; a Cloud Control API launch partner alongside Terraform
  ([Joe Duffy, Sep 5 2019](https://joeduffyblog.com/2019/09/05/journey-to-pulumi-1-0/);
  [AWS What's New, Sep 30 2021](https://aws.amazon.com/about-aws/whats-new/2021/09/aws-announces-cloud-control-api/)).
- AWS's **Prescriptive Guidance** treats all of these as legitimate choices, even
  publishing dedicated pages for Terraform and Pulumi on AWS
  ([Choosing an IaC tool](https://docs.aws.amazon.com/prescriptive-guidance/latest/choose-iac-tool/introduction.html)).

---

## Claims that could NOT be fully verified (flagged for follow-up)

1. **AWS CDK developer-preview exact date (July 17, 2018).** Reported by Wikipedia
   and consistent with the GA post, but no AWS primary-source permalink with that
   exact day was located.
2. **CDKTF deprecation/archival date (~Dec 10, 2025).** Reported by Pulumi's blog and
   HN discussion, not confirmed from a HashiCorp/AWS primary source.
3. **Firefly "State of IaC 2025" Terraform market-share figures (33–62%).** Seen only
   in secondary write-ups; no Firefly primary source verified.
4. **The user's "AWS promotes CloudFormation/CDK *against* Terraform" framing.** The
   "against" / adversarial part is **not supported** by primary sources; the record
   shows partnership (CDKTF, Cloud Control launch partner, Service Catalog/CodeCatalyst
   integrations, official Terraform recommendation in AWS guidance). See the dedicated
   analysis section above.

---

## Key people & teams (chronological)

AWS, as a matter of corporate practice, rarely attaches individual names to its
service launches — press releases and "What's New" posts credit "the team" or quote
executives, not engineers. As a result, the people-thread below is a mix of
**EVIDENCE** (named in primary sources: AWS blogs, GitHub profiles, press releases)
and **INFERENCE** (reasonable conclusions drawn from those sources). Each entry is
labeled. Where a name is simply not findable, that is stated plainly rather than
guessed.

### 2011 — CloudFormation origins: no individual builders publicly documented

- **EVIDENCE (absence):** The CloudFormation launch materials — the Amazon press
  release and the AWS "What's New" post — name **no individual engineers or a
  named launch lead**. They credit AWS as an organization
  ([Amazon press release, Feb 25 2011](https://press.aboutamazon.com/2011/2/amazon-web-services-continues-to-make-it-easier-to-launch-applications-in-the-aws-cloud-introducing-aws-cloudformation);
  [AWS What's New, Feb 25 2011](https://aws.amazon.com/about-aws/whats-new/2011/02/25/introducing-aws-cloudformation/)).
  **The 2011 CloudFormation founding team / owner is not publicly documented.**
- **EVIDENCE (org context):** **Werner Vogels** has been Amazon's CTO and VP since
  2004–2005 and is the executive most associated with AWS's technical direction in
  this era; he is the standing technical-leadership context for any 2011 AWS launch,
  though the primary launch sources do not tie him personally to building
  CloudFormation
  ([Werner Vogels — Wikipedia](https://en.wikipedia.org/wiki/Werner_Vogels)).
  *(Could not verify a Werner Vogels primary-source blog post specifically authoring
  or claiming the CloudFormation launch; his "All Things Distributed" blog was not
  retrievable here — flagged.)*
- **EVIDENCE (team, not individuals):** AWS's own retrospective confirms that early
  resource development "was done by the CloudFormation team itself," i.e. a single
  internal team owned the engine and resource coverage — but again names no people
  ([AWS DevOps Blog: history and future roadmap of the CloudFormation Registry](https://aws.amazon.com/blogs/devops/cloudformation-coverage/)).

### 2016 — SAM ("Project Flourish")

- **EVIDENCE (absence):** The SAM launch post names no individual creators; SAM was
  presented as an AWS team effort and open-sourced under Apache 2.0
  ([AWS What's New: Introducing the AWS Serverless Application Model](https://aws.amazon.com/about-aws/whats-new/2016/11/introducing-the-aws-serverless-application-model/)).
  **SAM's individual authors are not publicly documented.**

### 2018–2019 — CDK and jsii: Elad Ben-Israel (the central named figure)

This is the one part of AWS's IaC story where individuals **are** well documented,
largely because CDK and jsii are open-source and their lead author has a public
profile.

- **EVIDENCE — Elad Ben-Israel created the AWS CDK, jsii, cdk8s, and projen at AWS.**
  His own GitHub profile bio reads: *"Founded: Winglang, AWS CDK, Projen. Ex-AWS,
  Microsoft,"* and pins the **Wing**, **AWS CDK**, **jsii**, and **Projen**
  repositories
  ([Elad Ben-Israel — GitHub profile (eladb)](https://github.com/eladb)).
- **EVIDENCE — role.** He is described across primary/secondary coverage as the
  creator who **led the AWS CDK project** and is the author behind **jsii** and the
  CDK construct model; jsii is "the technology that enables the AWS Cloud Development
  Kit to deliver polyglot libraries from a single codebase"
  ([aws/jsii on GitHub](https://github.com/aws/jsii);
  [AWS CDK FAQs](https://aws.amazon.com/cdk/faqs/)).
  He is referred to in the platform-engineering community as "the guy behind jsii and
  constructs and much of the CDK"
  ([Elad Ben-Israel (GitHub)](https://github.com/eladb)).
- **INFERENCE — single-author origin emphasis.** Calling him *the* creator is an
  inference of degree: CDK and jsii were team efforts, but the public record
  consistently centers Ben-Israel as the originating architect/lead rather than one
  contributor among equals. Treat "creator/lead" as well-supported and "sole author"
  as not claimed.

### 2018–present — other named CDK / jsii team members

- **EVIDENCE — Romain Marcadier (a.k.a. Romain Muller).** A **Senior Software
  Development Engineer at AWS** who **"leads cross-language efforts for the Cloud
  Development Kit"** and is a core author/maintainer of **jsii**; he wrote AWS's
  own explainer on jsii's design and origins
  ([AWS Open Source Blog: "How the jsii open source framework meets developers where they are," by Romain Marcadier](https://aws.amazon.com/blogs/opensource/how-the-jsii-open-source-framework-meets-developers-where-they-are/);
  [Romain Marcadier, "Why jsii?", Oct 3 2022](https://romainmuller.dev/posts/2022-10-03/)).
- **EVIDENCE — Rico Huijbers.** An AWS engineer associated with the **CDK v2**
  developer-preview announcement and CDK best-practices guidance, indicating a senior
  role on the CDK team
  ([AWS DevOps Blog: CDK Corner — April 2021](https://aws.amazon.com/blogs/devops/cdk-corner-april-2021/)).
  *(Could not verify a single primary AWS post that states Huijbers's exact title;
  his CDK-team involvement is evidenced by authorship/announcement credits — flagged
  as "role inferred from authorship.")*

### 2020 — CDKTF: the AWS × HashiCorp × Terrastack collaboration (named people)

- **EVIDENCE — joint-blog authors.** The CDK-for-Terraform preview announcement was
  **co-authored by Chris Fife (AWS Senior Product Manager) and Anubhav Mishra
  (HashiCorp Technical Advisor)**, and explicitly frames it as a collaboration between
  "the AWS CDK and HashiCorp Terraform teams"
  ([AWS Developer Tools Blog: "Introducing the Cloud Development Kit for Terraform (Preview)," Jul 16 2020](https://aws.amazon.com/blogs/developer/introducing-the-cloud-development-kit-for-terraform-preview/)).
- **EVIDENCE — Terrastack.** A third party, **Terrastack**, was named as a
  collaborator in the preview alongside AWS and HashiCorp
  ([InfoQ, Jul 2020](https://www.infoq.com/news/2020/07/cdk-terraform/)).
  *(The specific Terrastack individuals are not named in the AWS primary post — only
  the project is credited; individual Terrastack contributors are not publicly
  documented here.)*
- **EVIDENCE — cross-team jsii work.** Romain Marcadier (above) is documented as
  working **with HashiCorp** to improve jsii code-generation performance for CDKTF,
  another concrete people-level link between the two organizations
  ([AWS Open Source Blog, jsii](https://aws.amazon.com/blogs/opensource/how-the-jsii-open-source-framework-meets-developers-where-they-are/)).

### April 2022 — the juicy people-thread: Elad Ben-Israel LEAVES AWS to found Wing

- **EVIDENCE — departure + new company.** Ben-Israel left AWS and, in **April 2022**,
  co-founded **Wing Cloud** with **Shai Ber** (a former Microsoft engineer). Wing
  Cloud built **Winglang / Wing**, an open-source "programming language for the
  cloud" that compiles a unified infrastructure+runtime program down to IaC
  (Terraform, CloudFormation, etc.) plus runtime code — i.e. a next-generation take
  on the very problem CDK addresses
  ([The Times of Israel: "Israeli startup Wing Cloud emerges from stealth with $20 million," 2023](https://www.timesofisrael.com/israeli-startup-wing-cloud-emerges-from-stealth-with-20-million-in-funding/);
  [winglang/wing on GitHub](https://github.com/winglang/wing);
  [Elad Ben-Israel — GitHub profile](https://github.com/eladb)).
  His bio confirms the "Ex-AWS" status and Wing/AWS CDK/Projen founding
  ([GitHub: eladb](https://github.com/eladb)).
- **EVIDENCE — the framing.** This is the notable people-thread the record actually
  supports: **the CDK's creator left AWS to build a successor / next-generation
  approach** to cloud programming, rather than to a direct AWS rival in the
  enterprise-sales sense. Ben-Israel laid out the thesis in his 2022 manifesto
  ([Elad Ben-Israel, "Cloud, why so difficult? — A manifesto for cloud-oriented programming," Nov 2022](https://medium.com/@hackingonstuff/cloud-why-so-difficult-%EF%B8%8F-4e9ef1446a64)).

### July 2023 — Wing Cloud exits stealth

- **EVIDENCE.** Wing Cloud emerged from stealth in **July 2023** with a **$20M seed
  round** led by **Battery Ventures, Grove Ventures, and StageOne Ventures**
  ([The Times of Israel, 2023](https://www.timesofisrael.com/israeli-startup-wing-cloud-emerges-from-stealth-with-20-million-in-funding/);
  [Jewish Business News, Jul 19 2023](https://jewishbusinessnews.com/2023/07/19/israeli-open-source-language-developer-wing-cloud-exits-stealth-with-20-million/)).

### April 2025 — Wing Cloud shuts down

- **EVIDENCE.** Wing Cloud **ceased operations in April 2025** (reporting dated
  **April 9, 2025**), less than two years after exiting stealth. Ben-Israel's stated
  reason: developer experience, while loved by engineers, "is not always seen as
  business-critical by most companies"
  ([Calcalist (Ctech): "Wing Cloud shuts down after raising $20 million," Apr 2025](https://www.calcalistech.com/ctechnews/article/bj90wnmrjl)).
- **EVIDENCE — what he did next.** His GitHub bio now lists him as **"CTO at Bellboy
  Robotics,"** confirming the post-Wing move
  ([GitHub: eladb](https://github.com/eladb)).

### People-thread summary

- **CloudFormation (2011) / SAM (2016):** individual builders **not publicly
  documented**; owned by internal AWS teams; Werner Vogels is the era's
  technical-leadership context (org-level, not attributed to building it).
- **CDK / jsii (2018–):** **Elad Ben-Israel** is the well-documented creating
  lead; **Romain Marcadier (Romain Muller)** leads cross-language/jsii work; **Rico
  Huijbers** is a documented senior CDK-team voice.
- **CDKTF (2020):** AWS's **Chris Fife** + HashiCorp's **Anubhav Mishra** co-announced
  it; **Terrastack** credited as a third collaborator (individuals unnamed).
- **The thread that pays off:** CDK's creator **Elad Ben-Israel left AWS (~April
  2022)** to found **Wing/Winglang**, a next-gen cloud language — which **shut down in
  April 2025**, after which he became **CTO at Bellboy Robotics**.

### Could not verify (people section)

1. **Any named CloudFormation (2011) or SAM (2016) individual creator/lead** — not
   publicly documented in primary sources.
2. **A Werner Vogels primary-source post personally claiming/authoring the
   CloudFormation launch** — his "All Things Distributed" blog was not retrievable
   here (HTTP 403); his role is asserted only at org-leadership level.
3. **Rico Huijbers's exact AWS job title** — his CDK-team role is inferred from
   authorship/announcement credits, not from a title statement in a primary post.
4. **Individual Terrastack contributors on CDKTF** — only the project is credited in
   the AWS primary post; no people named.
5. **Exact day of Ben-Israel's AWS departure** — sources establish Wing was founded
   ~April 2022 and that he is "Ex-AWS," but an exact resignation date is not
   documented.

---

## Company & corporate context (chronological)

Scoped corporate context for AWS as a business — only what bears on its
Infrastructure-as-Code (IaC) tooling strategy. AWS is a vast business; this section
deliberately covers just the financial scale, leadership, and business-model framing
that explain *why* AWS gives its IaC tools away.

- **AWS as Amazon's most profitable segment — revenue first broken out in Q1 2015.**
  Amazon disclosed AWS as a separate reportable segment for the first time in its
  Q1 2015 earnings (reporting AWS net sales of $1.566B for the quarter, plus restated
  2013–2014 history). Before this, AWS revenue had been folded into "North America,
  Other"
  ([Channel Futures: "Amazon.com Breaks Out AWS Cloud Revenues for First Time"](https://www.channelfutures.com/cloud/amazon-com-breaks-out-aws-cloud-revenues-for-first-time-in-q1-report);
  [Amazon Q1 2015 8-K (SEC)](https://www.sec.gov/Archives/edgar/data/0001018724/000101872415000036/amzn-20150331xex993.htm)).
- **$100B+ annual run rate reached in 2024.** On the Q1 2024 earnings call AWS hit a
  ~$100B annualized revenue run rate; Q1 2024 AWS revenue was ~$25B, up 17% YoY
  ([The Register, May 1 2024](https://www.theregister.com/2024/05/01/amazon_q1_2024/);
  [Constellation Research](https://www.constellationr.com/insights/news/aws-annual-revenue-run-rate-hits-100-billion-growth-accelerates)).
- **Full-year 2024: $107.6B revenue, $39.8B operating income.** For full-year 2024,
  AWS segment sales rose 19% YoY to $107.6B, with segment operating income of $39.8B
  (up from $24.6B in 2023) — AWS remains a minority of Amazon's revenue but the
  majority of its operating income
  ([Amazon Q4 2024 earnings release (PDF)](https://s2.q4cdn.com/299287126/files/doc_financials/2024/q4/AMZN-Q4-2024-Earnings-Release.pdf);
  [Constellation Research: "AWS revenue up 19% in Q4"](https://www.constellationr.com/blog-news/insights/aws-revenue-19-q4-amazon-results-shine)).
  *(Note: secondary write-ups variously frame AWS as ~57% or ~65.7% of Amazon
  operating income depending on quarter vs full-year; treat the precise share as
  approximate. The $107.6B / $39.8B full-year figures are consistent across sources.)*
- **AWS CEO succession.** **Andy Jassy** led AWS from its early days until 2021, when
  he became Amazon CEO. **Adam Selipsky** became AWS CEO in March 2021. In May 2024
  Selipsky announced he would step down, with **Matt Garman** (a longtime AWS
  executive, ex-intern from 2005) succeeding him **effective June 3, 2024** — the
  current AWS CEO
  ([About Amazon: "10 things to know about AWS CEO Matt Garman"](https://www.aboutamazon.com/news/aws/aws-ceo-matt-garman-things-to-know);
  [GeekWire, May 14 2024](https://www.geekwire.com/2024/amazon-web-services-ceo-adam-selipsky-stepping-down-to-be-replaced-by-senior-exec-matt-garman/);
  [The Week: "June 3 ... Matt Garman's tenure will begin"](https://www.theweek.in/news/biz-tech/2024/05/15/june-3-adam-selipsky-confirms-when-matt-garman-s-tenure-will-begin-as-new-aws-chief-cloud-computing.html)).
- **Strategic core: AWS's IaC tools are FREE features that drive *consumption*.**
  CloudFormation, SAM, CDK, and Cloud Control API carry no charge for AWS-native
  resources — customers pay only for the underlying resources provisioned. CDK FAQ:
  "There is no additional charge for AWS CDK. You pay for AWS resources ... created
  using AWS CDK in the same way as if you created them manually." CloudFormation is
  likewise free for `AWS::*` and `Alexa::*` resource types
  ([AWS CDK FAQs](https://aws.amazon.com/cdk/faqs/);
  [AWS CloudFormation Pricing](https://aws.amazon.com/cloudformation/pricing/)).
  The economic logic is that easier provisioning increases AWS consumption — the IaC
  tooling is a complement to, not a substitute for, the metered cloud revenue.
- **Business-model contrast: HashiCorp/Pulumi sell the *tool*; AWS sells the *cloud*.**
  For HashiCorp and Pulumi the IaC tooling *is* the product. HashiCorp runs a
  product-led, open-core model — free open-source Terraform/Vault funneling to paid
  enterprise and HashiCorp Cloud Platform (HCP) offerings; it IPO'd on NASDAQ in
  December 2021 at a ~$14B valuation on ~$212M FY revenue, and guided to ~$643–647M
  revenue for FY2025
  ([Meritech: HashiCorp IPO S-1 Breakdown](https://web.archive.org/web/2id_/https://www.meritechcapital.com/blog/hashicorp-ipo-s-1-breakdown);
  [SiliconANGLE, Nov 4 2021](https://siliconangle.com/2021/11/04/filing-ipo-hashicorp-discloses-212m-annual-revenues-fast-growth/)).
  Because the tool is the revenue, HashiCorp's commercial posture is sharper — e.g.
  its 2023 BUSL re-license (noted above). AWS, by contrast, can give CloudFormation/
  CDK away precisely because its money is made downstream on consumption.
- **HashiCorp's tools-as-product model culminated in an acquisition.** IBM **completed
  its $6.4B acquisition of HashiCorp on February 27, 2025** (announced April 2024),
  underscoring that for HashiCorp the IaC tooling was itself an acquirable business —
  a contrast to AWS, where IaC is an embedded free feature of a much larger consumption
  business
  ([IBM Newsroom, Feb 27 2025](https://newsroom.ibm.com/2025-02-27-ibm-completes-acquisition-of-hashicorp,-creates-comprehensive,-end-to-end-hybrid-cloud-platform);
  [TechCrunch, Feb 27 2025](https://techcrunch.com/2025/02/27/ibm-closes-6-4b-hashicorp-acquisition/)).
- **Open-source posture reinforces the consumption strategy.** AWS releases its IaC
  toolchain under permissive licenses — the **AWS CDK is Apache-2.0**, as is SAM (see
  above) — and CDK's polyglot reach comes from the Apache-2.0 **jsii** projection
  layer. Open-sourcing the tools lowers adoption friction without sacrificing revenue,
  since AWS does not monetize the tools themselves
  ([aws/aws-cdk on GitHub (Apache-2.0)](https://github.com/aws/aws-cdk);
  [AWS CDK FAQs](https://aws.amazon.com/cdk/faqs/)).

### Could not verify (corporate-context section)

1. **Exact share of Amazon operating income from AWS in 2024** — secondary sources
   give both ~57% (full-year) and ~65.7% (a quarter); the underlying $39.8B operating
   income figure is well-sourced, but a single canonical "% of Amazon operating
   income" varies by period and is reported, not confirmed to one figure here.
2. **Adam Selipsky's exact AWS CEO start date** — sourced as "March 2021"; an
   exact-day primary source was not separately confirmed beyond secondary reporting.
