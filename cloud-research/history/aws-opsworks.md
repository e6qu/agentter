# A Chronological History of AWS OpsWorks (Peritor/Scalarium → OpsWorks → retirement)

Focus: how AWS turned a German startup's Chef-based EC2 cluster manager into a
managed AWS service, the "AWS adopts a third-party open-source config-management
tool as a managed service" angle (a counterpoint to AWS's own CloudFormation),
the later managed *Chef/Puppet server* variants, and the eventual full retirement
of the entire OpsWorks family in 2024.

> **Sourcing note.** Every factual claim below carries an inline link to a
> primary or reputable secondary source. Where a claim could only be partially
> confirmed, or where a live AWS docs page could not be fetched directly, that is
> flagged explicitly in the text and in the "Could not verify" list at the end.
> Reported third-party claims are attributed to their source rather than stated
> as bare fact.

> **Cross-references.** This document is a counterpart to
> [`chef.md`](./chef.md) (Chef the tool/company, on which OpsWorks was built) and
> [`puppet.md`](./puppet.md) (Puppet, the engine behind the later
> "OpsWorks for Puppet Enterprise" variant). See those for the upstream histories
> of the configuration-management engines AWS wrapped.

---

## 2005–2008 — Origins at Peritor (Berlin)

- **Peritor** began as a Berlin, Germany IT consultancy. AWS's own pre-acquisition
  profile of the company describes it as having grown out of "an IT consultancy
  established in 2005 that specialized in helping clients scale their
  infrastructure," founded by **Jonathan Weiss** and **Thomas (Metschke)**.
  ([AWS Blog — "AWS Summer Startups: Peritor/Scalarium" (Sept 20, 2011)](https://aws.amazon.com/blogs/aws/aws-summer-startups-peritorscalarium/))
- Before Scalarium, Peritor was known in the Ruby/Rails community for
  **Webistrano**, an open-source web UI for managing **Capistrano** deployments,
  authored by Jonathan Weiss.
  ([GitHub — peritor/webistrano](https://github.com/peritor/webistrano))
- Peritor's founders were active in the Rails-deployment scene: Jonathan Weiss
  and Mathias Meyer presented "Deploying and Monitoring Ruby on Rails" at
  **RailsConf Europe 2008** in Berlin, billed as a Peritor GmbH talk.
  ([O'Reilly RailsConf Europe 2008 schedule](https://conferences.oreilly.com/railseurope2008/public/schedule/detail/3562);
  [SlideShare — "Deploying and Monitoring Rails"](https://www.slideshare.net/jweiss/deploying-and-monitoring-rails-presentation))
- **Scalarium** itself was created in **2008**. Secondary reporting dates the
  Scalarium product to July 2008. *(The exact founding/launch date of the
  Scalarium product, and the precise founder list beyond Weiss/Metschke/Meyer,
  could only be confirmed via secondary sources — see "Could not verify.")*

## September 20, 2011 — AWS profiles Scalarium (pre-acquisition)

- In its "Summer Startups" series, the AWS blog profiled Scalarium **well before
  acquiring it**. AWS described it as "an easy management service for EC2
  clusters" that "automates the initial setup and continuous configuration of
  servers," supporting Rails, Node.js, PHP, and Java.
  ([AWS Blog — "AWS Summer Startups: Peritor/Scalarium" (Sept 20, 2011)](https://aws.amazon.com/blogs/aws/aws-summer-startups-peritorscalarium/))
- Crucially, the same 2011 profile shows the design that would later become
  OpsWorks was **already present in Scalarium**:
  - **Scalarium already used Chef** for configuration management.
  - It ran on a **server lifecycle model with five event types — Setup,
    Configure, Deploy, Undeploy, and Shutdown** — essentially the same lifecycle
    events OpsWorks later exposed.
  - Customers kept **root access** to their own servers while Scalarium
    automated deployment.
  ([AWS Blog — "AWS Summer Startups: Peritor/Scalarium" (Sept 20, 2011)](https://aws.amazon.com/blogs/aws/aws-summer-startups-peritorscalarium/))

  This is the heart of the "AWS adopts a third-party open-source config-management
  tool" story: AWS did not build a config-management engine; it acquired a startup
  that had already wrapped **Chef** (an open-source CM tool — see [`chef.md`](./chef.md))
  into a managed EC2 service, then rebranded that as a first-party AWS offering.

## 2012 — AWS acquires Peritor

- AWS's own launch materials state plainly that **"AWS OpsWorks is built on
  technology developed by Berlin company Peritor, the creators of Scalarium,
  which was acquired by AWS in 2012."**
  ([Werner Vogels, All Things Distributed — "Expanding the Cloud – Introducing AWS OpsWorks" (Feb 18, 2013)](https://www.allthingsdistributed.com/2013/02/aws-opsworks.html);
  [Amazon Press Release / Business Wire (Feb 18, 2013)](https://press.aboutamazon.com/2013/2/amazon-web-services-launches-aws-opsworks))
- AWS stated it "recognized that Scalarium has strong capabilities that are
  broadly useful to many AWS customers" and committed to making OpsWorks "a great
  application management solution."
  ([deutsche-startups.de — "Amazon Web Services übernimmt Berliner Start-up peritor" (Mar 8, 2013)](https://www.deutsche-startups.de/2013/03/08/amazon-web-services-peritor-scalarium/))
- *The exact deal date and terms were not disclosed publicly; reporting noted the
  acquisition received "surprisingly little media coverage."* The "2012"
  acquisition year is AWS's own framing in the OpsWorks launch posts; a precise
  month/day was not found.
  ([deutsche-startups.de (Mar 8, 2013)](https://www.deutsche-startups.de/2013/03/08/amazon-web-services-peritor-scalarium/))

## February 18, 2013 — AWS OpsWorks launches

- AWS announced **AWS OpsWorks** on **February 18, 2013** (widely covered the
  following day, Feb 19). It was positioned as "a new application management
  service for managing applications of any scale or complexity on the AWS cloud,"
  covering "the complete application lifecycle, including resource provisioning,
  configuration management, application deployment, software updates, monitoring,
  and access control."
  ([AWS What's New — "Announcing AWS OpsWorks" (Feb 18, 2013)](https://aws.amazon.com/about-aws/whats-new/2013/02/18/announcing-aws-opsworks/);
  [Werner Vogels — "Expanding the Cloud" (Feb 18, 2013)](https://www.allthingsdistributed.com/2013/02/aws-opsworks.html))
- The OpsWorks Stacks user guide's own document history records its first entry as
  **February 18, 2013 — "Initial release of the AWS OpsWorks Stacks User Guide."**
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md))
- **The Chef angle.** AWS built OpsWorks on the **Chef framework**: "Because
  OpsWorks uses the Chef framework, developers can use existing recipes or
  leverage hundreds of community-built configurations."
  ([Werner Vogels — "Expanding the Cloud" (Feb 18, 2013)](https://www.allthingsdistributed.com/2013/02/aws-opsworks.html))
- **The core model.** OpsWorks organized infrastructure into **Stacks** and
  **Layers**: "Layers define how to configure a set of resources that are managed
  together. For example, you might define a web layer for your application that
  consists of EC2 instances, EBS volumes…"
  ([Werner Vogels — "Expanding the Cloud" (Feb 18, 2013)](https://www.allthingsdistributed.com/2013/02/aws-opsworks.html))
- AWS framed three pillars: **operational control** (conventions/defaults that
  remain fully customizable), **automation** (event-driven configuration plus
  deployment tooling — rollback, patch management, auto scaling, auto healing),
  and **flexibility** (any architecture, any software with scripted install).
  ([AWS What's New — "Announcing AWS OpsWorks" (Feb 18, 2013)](https://aws.amazon.com/about-aws/whats-new/2013/02/18/announcing-aws-opsworks/))
- AWS quote at launch: **Scott Wiltamuth**, VP of Developer Productivity & Tools,
  AWS, said "As our customers run more and more applications on AWS they are
  asking for more sophisticated tools to manage their AWS resources and automate
  how they deploy applications."
  ([Amazon Press Release (Feb 18, 2013)](https://press.aboutamazon.com/2013/2/amazon-web-services-launches-aws-opsworks);
  [Business Wire — "Amazon Web Services Launches AWS OpsWorks" (Feb 18, 2013)](https://www.businesswire.com/news/home/20130218005820/en/Amazon-Web-Services-Launches-AWS-OpsWorks))

### Chef's (Opscode's) side of the launch

- Two days later, **Opscode** (the company behind Chef — then still named Opscode;
  see [`chef.md`](./chef.md)) put out its own release confirming OpsWorks used
  Chef as its automation engine.
  ([PR Newswire — "Amazon Web Services Chooses Opscode Chef for AWS OpsWorks" (Feb 20, 2013)](https://www.prnewswire.com/news-releases/amazon-web-services-chooses-opscode-chef-for-aws-opsworks-192075341.html);
  [Chef blog — "AWS OpsWorks Uses Opscode Chef as Default Automation Engine"](https://www.chef.io/blog/aws-opsworks-uses-opscode-chef-as-default-automation-engine))
- **Adam Jacob**, then Chief Customer Officer at Opscode, framed it as validation
  of Chef: "Automation solves for this skills gap by enabling IT with the tools
  necessary to effectively build and manage large-scale cloud infrastructure."
  ([PR Newswire (Feb 20, 2013)](https://www.prnewswire.com/news-releases/amazon-web-services-chooses-opscode-chef-for-aws-opsworks-192075341.html))

### The juicy framing: PaaS disruptor / config-management counterpoint

- The press read OpsWorks as a competitive shot across several markets at once.
  **TechCrunch** called it "a potential PaaS disruptor," with commenters comparing
  it to **Heroku**, and noted that AWS embedding **Chef** "raises questions about
  how Puppet might be used in this environment."
  ([TechCrunch — "AWS Launches OpsWorks, A Potential PaaS Disruptor…" (Feb 19, 2013)](https://techcrunch.com/2013/02/19/aws-launches-opsworks-a-potential-paas-disruptor-to-automate-app-deployment-to-the-cloud/))
- **The Register** framed it as Amazon "muscling into cloud management."
  ([The Register — "Amazon releases OpsWorks, muscles into cloud management" (Feb 19, 2013)](https://www.theregister.com/2013/02/19/amazon_launches_opsworks_cloud_management/))
- Read alongside AWS's own **CloudFormation** (declarative, AWS-native
  provisioning; see [`cloudformation-cdk.md`](./cloudformation-cdk.md)), OpsWorks
  represented AWS offering an **imperative, recipe-driven config-management path
  built on a third-party open-source engine (Chef)** — a managed-CM counterpoint
  to AWS's home-grown infrastructure-as-code service. *(This synthesis is the
  research framing; AWS did not itself publish a "CloudFormation vs OpsWorks"
  positioning statement that was located.)*

## March–August 2013 — Scalarium wound down

- AWS migrated Scalarium customers onto OpsWorks and **discontinued Scalarium by
  August 31, 2013**; new Scalarium registrations were closed.
  ([deutsche-startups.de (Mar 8, 2013)](https://www.deutsche-startups.de/2013/03/08/amazon-web-services-peritor-scalarium/))

## May 14, 2013 — Early feature expansion

- OpsWorks added EBS-backed instances, Elastic Load Balancing, and CloudWatch
  monitoring support.
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md))

## 2015 — Windows support and Chef 12 ("OpsWorks Stacks")

- **May 18, 2015** — OpsWorks added **support for Windows stacks**.
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md))
- **December 3, 2015** — OpsWorks added **Chef 12 Linux support**. Over time the
  original service was branded **OpsWorks Stacks**, running **Chef 11** and
  **Chef 12** cookbooks (Chef 11 on older Linux stacks, Chef 12 on newer Linux
  and on Windows).
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md);
  [AWS docs — "Chef Versions"](https://web.archive.org/web/2id_/https://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-chef11.html))
  *(The precise calendar date on which AWS first applied the "Stacks" name to the
  original service — as distinct from the new server-based variants below — was
  not pinned down to a single announcement; see "Could not verify.")*

## December 1, 2016 — AWS OpsWorks for Chef Automate (managed Chef *server*)

- Announced at **re:Invent 2016**, **AWS OpsWorks for Chef Automate** was a
  different kind of product from OpsWorks Stacks: a **fully-managed Chef server**
  (Chef Automate + Chef server on EC2), as opposed to Stacks' agent-on-instances
  model. The OpsWorks document history dates the launch to **December 1, 2016**;
  Jeff Barr's announcement blog is dated **December 30, 2016**.
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md);
  [AWS Blog (Jeff Barr) — "New – AWS OpsWorks for Chef Automate" (Dec 30, 2016)](https://aws.amazon.com/blogs/aws/new-aws-opsworks-for-chef-automate/))
- It let users "launch the Chef Automate server with just 3 clicks," with AWS
  handling backups, restores, and version upgrades; it integrated with Auto
  Scaling Groups, on-premises servers, and community tools (Test Kitchen, Knife,
  Chef Supermarket).
  ([AWS Blog — "New – AWS OpsWorks for Chef Automate" (Dec 30, 2016)](https://aws.amazon.com/blogs/aws/new-aws-opsworks-for-chef-automate/);
  [Chef blog — "Inside the new AWS OpsWorks for Chef Automate service"](https://www.chef.io/blog/inside-the-new-aws-opsworks-for-chef-automate-service))

## November 16, 2017 — AWS OpsWorks for Puppet Enterprise (managed Puppet *server*)

- AWS extended the managed-server model to **Puppet**: **AWS OpsWorks for Puppet
  Enterprise**, a fully-managed **Puppet master / Puppet Enterprise** server,
  announced **November 16, 2017**. AWS noted Puppet Enterprise support "had been
  the most popular request for AWS OpsWorks."
  ([AWS What's New — "Announcing AWS OpsWorks for Puppet Enterprise" (Nov 16, 2017)](https://aws.amazon.com/about-aws/whats-new/2017/11/announcing-aws-opsworks-for-puppet-enterprise/);
  [AWS Blog — "New – AWS OpsWorks for Puppet Enterprise"](https://aws.amazon.com/blogs/aws/new-aws-opsworks-for-puppet-enterprise/))
- Puppet (the company; see [`puppet.md`](./puppet.md)) co-announced the
  collaboration, calling it a fully-managed Puppet master that runs modules from
  the Puppet Forge.
  ([DevOps.com — "Puppet Collaborates with Amazon Web Services…"](https://devops.com/puppet-collaborates-amazon-web-services-delivers-new-solution-empowering-enterprises-agility-cloud-migration/))

By late 2017 the OpsWorks family had three distinct members:
1. **OpsWorks Stacks** — the original Scalarium-derived service (agent + Chef 11/12 recipes).
2. **OpsWorks for Chef Automate** — a managed Chef server.
3. **OpsWorks for Puppet Enterprise** — a managed Puppet Enterprise server.
([AWS Cloud Operations Blog — "2017 Year in Review: AWS OpsWorks for Chef Automate and Puppet Enterprise"](https://aws.amazon.com/blogs/mt/2017-year-in-review-aws-opsworks-for-chef-automate-and-puppet-enterprise/))

## 2022 — Late maintenance and a migration on-ramp

- **February 2022** — OpsWorks for Chef Automate added support for a newer Chef
  Automate version.
  ([AWS What's New — "AWS OpsWorks for Configuration Management now supports new version of Chef Automate" (Feb 2022)](https://aws.amazon.com/about-aws/whats-new/2022/02/aws-opsworks-chef-automate-version-support/))
- **December 22, 2022** — AWS published a migration pathway for moving **OpsWorks
  Stacks to AWS Systems Manager Application Manager** — a signal of where AWS
  wanted customers to go next.
  ([AWS OpsWorks document history (awsdocs GitHub mirror)](https://github.com/awsdocs/aws-opsworks-user-guide/blob/master/doc_source/history.md))
- The OpsWorks user-guide GitHub mirror was **archived (made read-only) on
  June 15, 2023**, consistent with the service entering wind-down.
  ([awsdocs/aws-opsworks-user-guide (archived repo)](https://github.com/awsdocs/aws-opsworks-user-guide))

## 2023 — End-of-life announced

- On **May 26, 2023**, AWS announced that **AWS OpsWorks Stacks would reach end of
  life on May 26, 2024**, and stopped accepting new customers; existing customers
  could continue until the EOL date. AWS recommended migrating to **AWS Systems
  Manager**.
  ([AWS docs — OpsWorks Stacks EOL guidance, per AWS re:Post discussions](https://repost.aws/questions/QUmHQN4HGoQxav6nqlH-ZJIg/is-aws-ops-works-is-reaching-end-of-life);
  [HashiCorp Terraform AWS provider issue #35701 — "[Service EOL] AWS OpsWorks Stacks end of life"](https://github.com/hashicorp/terraform-provider-aws/issues/35701))
  *(The official AWS "stacks-eol-faqs" docs page returned HTTP 404/redirect to
  the WebFetch tool; the May 26, 2023 → May 26, 2024 framing is corroborated by
  the Terraform provider EOL issue and multiple AWS re:Post threads quoting the
  official notice — see "Could not verify.")*

## 2024 — The OpsWorks family is fully retired

The three services were sunset on three different dates in 2024:

- **AWS OpsWorks for Puppet Enterprise — end of life March 31, 2024.** After this
  date the API and console became unusable in all Regions; recommended path was
  running Puppet Enterprise yourself on EC2.
  ([Puppet — "AWS OpsWorks Deprecation: How to Keep Managing Servers After AWS OpsWorks EOL"](https://www.puppet.com/blog/puppet-aws-opsworks);
  AWS docs FAQ, see note below)
- **AWS OpsWorks for Chef Automate — end of life May 5, 2024.** API and console
  unusable in all Regions thereafter; recommended path included migrating to Chef
  SaaS.
  ([AWS docs — "AWS OpsWorks for Chef Automate End of Life FAQs"](https://web.archive.org/web/2id_/https://docs.aws.amazon.com/opsworks/latest/userguide/opscm-eol-faqs.html);
  [WizzDev — "AWS OpsWorks EOL and how you can migrate?"](https://wizzdev.com/blog/aws-opsworks-eol-and-how-you-can-migrate/))
- **AWS OpsWorks Stacks — end of life May 26, 2024.** On that date the OpsWorks
  **console, API, CLI, and CloudFormation resources were discontinued in all AWS
  Regions** and the service was disabled for new and existing customers. (Existing
  EC2 instances remained reachable via SSH; AWS pointed customers to **AWS Systems
  Manager**.)
  ([AWS re:Post — "AWS OpsWorks Stacks is reaching End of Life…"](https://repost.aws/questions/QUHveYilEOQLOx70lezRgX-A/aws-opsworks-stacks-is-reaching-end-of-life-how-will-this-affect-connected-ec2-instances-specifically-ssh-access);
  [HashiCorp Terraform AWS provider issue #35701](https://github.com/hashicorp/terraform-provider-aws/issues/35701);
  [WizzDev — "AWS OpsWorks EOL and how you can migrate?"](https://wizzdev.com/blog/aws-opsworks-eol-and-how-you-can-migrate/))

> **Docs-fetch caveat.** The live AWS EOL FAQ pages
> (`opscm-eol-faqs.html`, and the OpsWorks Stacks / Puppet EOL pages) consistently
> returned HTTP 404 / cross-host redirects to the automated fetch tool and could
> not be read line-by-line. The three EOL dates above (Mar 31, May 5, May 26 —
> all 2024) are nonetheless consistent across the AWS docs URLs that appear in
> search, the Terraform AWS provider EOL tracking issue, Puppet's own migration
> blog, and AWS re:Post threads. They are treated as confirmed-by-corroboration,
> not as a single verbatim primary read — see "Could not verify."

## Current status — Retired

As of the **2024 dates above, the entire AWS OpsWorks family (Stacks, Chef
Automate, Puppet Enterprise) is retired.** AWS's recommended successors are **AWS
Systems Manager** (for Stacks workloads) and self-managed Chef/Puppet on EC2 or
the vendors' SaaS offerings (for the managed-server variants).
([WizzDev — "AWS OpsWorks EOL and how you can migrate?"](https://wizzdev.com/blog/aws-opsworks-eol-and-how-you-can-migrate/);
[Puppet — "AWS OpsWorks Deprecation…"](https://www.puppet.com/blog/puppet-aws-opsworks))

---

## Key people & teams / origin

- **Peritor GmbH (Berlin)** — the startup AWS acquired. Grew out of a 2005 IT
  consultancy; known earlier for the open-source **Webistrano** Capistrano UI.
  ([AWS Blog — "AWS Summer Startups: Peritor/Scalarium" (Sept 20, 2011)](https://aws.amazon.com/blogs/aws/aws-summer-startups-peritorscalarium/);
  [GitHub — peritor/webistrano](https://github.com/peritor/webistrano);
  [NorthData — Peritor GmbH registration (Managing Director: Jonathan Weiss; Seat: Berlin)](https://www.northdata.com/?id=8002973))
- **Jonathan Weiss** — Peritor co-founder / managing director; author of
  Webistrano; central figure behind Scalarium's EC2-cluster management.
  ([NorthData — Peritor GmbH](https://www.northdata.com/?id=8002973);
  [NEXT Conference — Jonathan Weiss profile](https://nextconf.eu/person/jonathan-weiss/))
- **Thomas Metschke** and **Mathias Meyer** — named in reporting as part of the
  Peritor/Scalarium team; Meyer (later known for his work at Travis CI) co-presented
  Peritor's Rails-deployment talks. *(Attribution of the full founder list rests
  on secondary sources — see "Could not verify.")*
  ([O'Reilly RailsConf Europe 2008 schedule](https://conferences.oreilly.com/railseurope2008/public/schedule/detail/3562))
- **Scalarium** — the product: a managed EC2-cluster service that already used
  **Chef** and a Setup/Configure/Deploy/Undeploy/Shutdown lifecycle model. AWS
  rebranded it as **OpsWorks** and retired the Scalarium brand by Aug 31, 2013.
  ([AWS Blog — "AWS Summer Startups: Peritor/Scalarium" (Sept 20, 2011)](https://aws.amazon.com/blogs/aws/aws-summer-startups-peritorscalarium/);
  [deutsche-startups.de (Mar 8, 2013)](https://www.deutsche-startups.de/2013/03/08/amazon-web-services-peritor-scalarium/))
- **AWS-side launch voice:** **Werner Vogels** (CTO, the launch blog) and **Scott
  Wiltamuth** (VP Developer Productivity & Tools, the press release).
  ([Werner Vogels — "Expanding the Cloud" (Feb 18, 2013)](https://www.allthingsdistributed.com/2013/02/aws-opsworks.html);
  [Amazon Press Release (Feb 18, 2013)](https://press.aboutamazon.com/2013/2/amazon-web-services-launches-aws-opsworks))
- **Chef / Opscode-side voice:** **Adam Jacob** (then Chief Customer Officer at
  Opscode; see [`chef.md`](./chef.md)).
  ([PR Newswire (Feb 20, 2013)](https://www.prnewswire.com/news-releases/amazon-web-services-chooses-opscode-chef-for-aws-opsworks-192075341.html))

---

## Could not verify (open items)

- **Exact Peritor acquisition date / terms.** AWS says only "acquired by AWS in
  2012"; no precise month/day or deal value was found. Reporting noted the deal
  drew "surprisingly little media coverage."
  ([deutsche-startups.de (Mar 8, 2013)](https://www.deutsche-startups.de/2013/03/08/amazon-web-services-peritor-scalarium/))
- **Scalarium founding/launch date and complete founder list.** The "July 2008"
  Scalarium date and the Weiss/Metschke/Meyer trio rest on secondary sources; the
  AWS 2011 profile names only "Jonathan and Thomas." Not confirmed against a
  primary Peritor record beyond the NorthData company registration (Weiss as
  managing director).
- **Exact date the original service was renamed "OpsWorks Stacks."** The "Stacks"
  branding is clearly in use by 2015–2016 (the user guide is titled "OpsWorks
  Stacks User Guide"), but a single dated rename announcement was not located.
- **Verbatim AWS EOL FAQ pages.** The live AWS docs EOL pages returned HTTP
  404/redirect to the automated fetch tool and could not be read directly. The
  three 2024 EOL dates (Puppet Enterprise Mar 31, Chef Automate May 5, Stacks
  May 26) and the May 26, 2023 announcement date are corroborated across the
  Terraform AWS provider EOL issue, Puppet's migration blog, AWS re:Post threads,
  and search-surfaced AWS docs URLs, but not via a single clean primary read of
  the FAQ HTML.
- **"CloudFormation vs OpsWorks" positioning.** The framing of OpsWorks as a
  config-management counterpoint to CloudFormation is this research's synthesis
  (supported by contemporaneous press treating OpsWorks as a Chef-based
  management/PaaS play); no single AWS document explicitly positioning the two
  against each other was located.
