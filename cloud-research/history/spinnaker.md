# Spinnaker: A Chronological, Sourced History

Spinnaker is an open-source, multi-cloud **continuous-delivery (CD)** platform
created at Netflix as the successor to Netflix's earlier deployment tool
**Asgard**. It was open-sourced in November 2015 in collaboration with Google
(with Microsoft, Pivotal, Kenzan and others), and its governance was later moved
to the **Continuous Delivery Foundation (CDF)** under the Linux Foundation in
2019. This document is a dated timeline with every claim tied to a working
source URL. Items that could not be verified are flagged explicitly.

A note on scope: Spinnaker is a **release / deployment-pipeline** tool (build →
bake → deploy → verify → promote across environments and clouds). It is
**complementary** to infrastructure-as-code provisioning tools like Terraform —
Spinnaker orchestrates the *release* of application changes, whereas Terraform
*provisions* infrastructure. (This framing is the author's synthesis of the
"continuous delivery platform" descriptions in the sources below, e.g. the
Netflix and Google "continuous delivery" announcements; it is not a single
quoted claim.)

---

## Timeline

### Pre-history: Asgard (Netflix's AWS deployment tool)

- Asgard was Netflix's earlier internally developed web-based tool for managing
  application deployments on AWS. Per Netflix's own retrospective, "Asgard was
  developed for a single use case, for a single cloud platform (Amazon), and for
  a single region within Amazon." When other providers forked Asgard, merging
  contributions back proved problematic. Source:
  [opensource.com, "Netflix's Spinnaker tale," May 11, 2017](https://opensource.com/article/17/5/netflixs-spinnaker-tale).
- Spinnaker was conceived as the replacement for Asgard, building on many of its
  concepts. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).

### 2014 — Internal development begins; Google joins

- Google states it began working with the Netflix team that created Spinnaker
  "back in 2014": "Back in 2014, we started working with the Netflix team that
  created Spinnaker ... we collaborated with Netflix to bring Spinnaker to the
  public, and they open-sourced it in November 2015." Source:
  [Google Cloud Blog, "Spinnaker 1.0: a continuous delivery platform for cloud," June 7, 2017](https://cloud.google.com/blog/products/gcp/spinnaker-10-continuous-delivery).
- A secondary source states Netflix began consuming Spinnaker internally in 2014
  and open-sourced it the following year. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).
  ("Could not verify: an exact internal-adoption start month/date in 2014" from a
  first-party Netflix source.)

### September 2015 — "Moving from Asgard to Spinnaker"

- Netflix published "Moving from Asgard to Spinnaker," describing the transition
  from Asgard to the new continuous-delivery platform. Source:
  [Netflix TechBlog, "Moving from Asgard to Spinnaker"](https://netflixtechblog.com/moving-from-asgard-to-spinnaker-a000b2f7ed17)
  (also archived under the original techblog host at
  http://techblog.netflix.com/2015/09/moving-from-asgard-to-spinnaker.html ,
  which dates it to September 2015).
  ("Could not verify: exact day in September 2015" — the original techblog URL
  path indicates 2015/09; the post body's certificate could not be fetched
  directly during research, see Research notes below.)

### November 16, 2015 — Spinnaker open-sourced

- Spinnaker was released under the Apache License 2.0 on **November 16, 2015**.
  Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).
- Netflix announced "Global Continuous Delivery with Spinnaker" on the Netflix
  Tech Blog. Source:
  [Netflix TechBlog, "Global Continuous Delivery with Spinnaker"](https://netflixtechblog.com/global-continuous-delivery-with-spinnaker-2a6896c23ba7)
  (original techblog permalink: http://techblog.netflix.com/2015/11/global-continuous-delivery-with.html , dated November 2015).
- Same day, Google published "Netflix's Spinnaker available now on Google Cloud
  Platform," dated **Monday, November 16, 2015**. Source:
  [Google Cloud Platform Blog](https://cloudplatform.googleblog.com/2015/11/Netflixs-Spinnaker-available-now-on-Google-Cloud-Platform.html).
- Co-development partners: the Spinnaker team partnered with **Google, Microsoft
  and Pivotal** to deliver out-of-the-box cluster management and deployment.
  Sources:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software));
  [The Register, "Netflix and skill," Nov 17, 2015](https://www.theregister.com/2015/11/17/netflix_offers_up_spinnaker_for_cloud_devs/).
- A 2017 Netflix retrospective lists "Google, Microsoft, and Kenzan" as major
  partners and emphasizes that "From the start, Spinnaker was developed in the
  open." Source:
  [opensource.com, May 11, 2017](https://opensource.com/article/17/5/netflixs-spinnaker-tale).
- Press coverage of the open-sourcing: AWS Insider, "Netflix Replacing Open
  Source Cloud Deployment Tool Built for AWS," Nov 17, 2015. Source:
  [AWSInsider](https://awsinsider.net/articles/2015/11/17/netflix-cloud-deployment-tool.aspx).

### 2016 — Armory founded (commercial Spinnaker)

- Armory was founded in 2016 by Daniel R. ("DROdio") Odio, Isaac Mosquera, and
  Ben Mappen, and went through Y Combinator (Winter 2017 batch). Its business was
  commercializing and extending open-source Spinnaker (an enterprise distribution
  with proprietary features). Source (secondary; founder/YC details):
  [Y Combinator company page](https://www.ycombinator.com/companies/armory);
  [Crunchbase, "Armory"](https://www.crunchbase.com/organization/armory).
  ("Could not verify: exact founding month in 2016" from a first-party source.)

### June 7, 2017 — Spinnaker 1.0

- Google announced **Spinnaker 1.0** on June 7, 2017. By then the community had
  "grown to include dozens of organizations including Microsoft, Oracle, Target,
  Veritas, Schibsted, Armory and Kenzan." Spinnaker 1.0 shipped built-in support
  for Google Compute Engine, Google Container Engine, Google App Engine, AWS EC2,
  Microsoft Azure, Kubernetes, and OpenStack (with Oracle Bare Metal and DC/OS
  "coming soon"). Source:
  [Google Cloud Blog, "Spinnaker 1.0"](https://cloud.google.com/blog/products/gcp/spinnaker-10-continuous-delivery).

### March 12, 2019 — Spinnaker donated to the Continuous Delivery Foundation (CDF)

- The Linux Foundation announced the **Continuous Delivery Foundation (CDF)** at
  the Open Source Leadership Summit (Half Moon Bay, CA) on **March 12, 2019**.
  The CDF launched with four founding projects: **Jenkins, Jenkins X, Spinnaker,
  and Tekton**. Founding members (20+) included Alibaba, Armory.io, Autodesk,
  Capital One, CircleCI, CloudBees, GitLab, Google, IBM, Netflix, Puppet,
  Rancher, Red Hat, SAP, and others. Governance runs under an open model with a
  Technical Oversight Committee. Sources:
  [Linux Foundation press release, Mar 12, 2019](https://www.linuxfoundation.org/press/press-release/the-linux-foundation-announces-new-foundation-to-support-continuous-delivery-collaboration);
  [PRNewswire mirror](https://www.prnewswire.com/news-releases/the-linux-foundation-announces-new-foundation-to-support-continuous-delivery-collaboration-300811006.html).
- **Netflix and Google jointly donated Spinnaker** to the CDF. Per the CDF blog:
  "Netflix and Google are jointly donating Spinnaker to the newly created
  Continuous Delivery Foundation (or CDF)." Netflix also became a founding member.
  The blog notes Netflix and Google had previously "adopted a formalized project
  governance plan," which remained in place after the donation, with the goal of
  sharing "the responsibility of Spinnaker's direction." Source:
  [CD Foundation blog, "Spinnaker Sets Sail to the Continuous Delivery Foundation," Mar 12, 2019](https://cd.foundation/blog/2019/03/12/spinnaker-sets-sail-to-the-continuous-delivery-foundation/).

### November 2019 — Spinnaker Summit (San Diego)

- The 2019 Spinnaker Summit took place in San Diego, November 15–17. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).

### October 13, 2020 — Armory raises $40M Series C

- Armory raised a **$40 million Series C** (led by B Capital), continuing to
  commercialize the open-source Spinnaker project. Source:
  [TechCrunch, "Armory nabs $40M Series C," Oct 13, 2020](https://techcrunch.com/2020/10/13/armory-scores-a-40m-series-c-to-continue-commercializing-open-source-spinnaker-project/).

### May 4, 2021 — Netflix slows its open-source contribution cadence

- Netflix published "Evolving How Netflix Builds, Maintains, and Operates Their
  Spinnaker Distribution" (by Adam Jordens). It states that while Netflix will
  continue to contribute to Spinnaker, "the cadence of contribution and
  involvement will slow" — moving from nearly 100% of work originating in
  open-source repos to cherry-picking changes up and down between an internal
  distribution and the OSS project. Roughly 15 Netflix engineers had day-to-day
  responsibility for Spinnaker at Netflix at that time. Source:
  [The Spinnaker Community Blog, May 4, 2021](https://blog.spinnaker.io/evolving-how-netflix-builds-maintains-and-operates-their-spinnaker-distribution-33c844d0102c).
  ("Could not verify: a precise statement that Google formally took over
  day-to-day maintenance" — the sources document Netflix slowing its cadence and
  Google/Armory/OpsMx/Harness remaining active, but no single first-party source
  declares a maintenance hand-off.")

### 2021 — Spinnaker Summit co-located with cdCon (virtual)

- The 2021 Spinnaker Summit was co-located with the CD Foundation's cdCon as a
  virtual event. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).

### 2023 — Armory's commercial trajectory falters

- Coverage of Armory's distress is tied to the January 2024 acquisition (below).
  The acquisition reporting characterizes the deal as effectively a forced/
  distressed sale after Armory ran low on money. Source:
  [TechCrunch, "Harness acquires the assets of ... Armory," Jan 11, 2024](https://techcrunch.com/2024/01/11/harness-acquires-the-assets-of-continuous-deployment-service-armory/).
  ("Could not verify: specific Armory layoff events or headcount cuts dated to
  2023 from a reputable source." The provided/searched sources confirm financial
  distress and the 2024 sale but do not cite a specific 2023 layoff
  announcement. Add to DO_NEXT for follow-up.)
- Armory did continue shipping product into 2023 (e.g., a March 7, 2023 plugins
  announcement), indicating it was still operating commercially that year.
  Source:
  [PRNewswire, "New Armory Plugins Extend the Power of Open Source Spinnaker," Mar 7, 2023](https://www.prnewswire.com/news-releases/new-armory-plugins-extend-the-power-of-open-source-spinnaker-for-continuous-deployment-301764075.html).

### January 11, 2024 — Harness acquires Armory's assets

- Software-delivery vendor **Harness acquired the assets of Armory** for about
  **$7 million in cash**. Armory had raised more than **$82 million** total
  (including the $40M Series C). The deal was described as a distressed/forced
  sale; Harness planned to hire many Armory employees and support existing
  customers (e.g., LaunchDarkly, Autodesk, Patreon). Harness CEO Jyoti Bansal:
  "The economic environment has been definitely challenging for a lot of
  startups to continue to raise capital." Source:
  [TechCrunch, Jan 11, 2024](https://techcrunch.com/2024/01/11/harness-acquires-the-assets-of-continuous-deployment-service-armory/).
- Harness's own announcement pledges to "continue to lead and support the
  Spinnaker community," bolstered by Spinnaker contributors from Armory, and to
  migrate Armory customers to Harness. Source:
  [Harness blog, "Harness Acquires Armory" (page date observed: May 28, 2024)](https://www.harness.io/blog/harness-acquires-armory-assets).
  ("Could not verify: the Harness blog page's true original publish date" — the
  acquisition was announced Jan 11, 2024 per TechCrunch, but the Harness blog
  page surfaced a May 28, 2024 date during fetch; treat the Jan 11, 2024
  TechCrunch date as authoritative for the announcement.)

### 2026 — Current status

- Spinnaker remains under the CD Foundation and remains central to Netflix's own
  deployment infrastructure. A February 2026 CDF community post states:
  "Spinnaker is a multi-cloud continuous delivery platform that powers the vast
  majority of Netflix's software deployments." That post describes Netflix
  migrating Spinnaker's Cloud Operation orchestration to Temporal (an
  enhancement to, not a replacement of, Spinnaker). Source:
  [CD Foundation blog, "How Temporal Powers Reliable Cloud Operations at Netflix," Feb 3, 2026](https://cd.foundation/blog/community/2026/02/03/netflix-spinnaker/).
- Spinnaker continues to support multiple targets: Kubernetes, Google Cloud
  Platform, AWS, Microsoft Azure, and Oracle Cloud. Commercial/maintenance
  backers referenced across sources include Google, Harness (post-Armory), and
  OpsMx. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).

---

## Where Spinnaker fits in the "config / deployment as code" landscape

- Spinnaker is a **CD / release-orchestration** platform: it models application
  delivery as pipelines (build → bake images → deploy → automated canary /
  verification → promote across regions and clouds). This is the consistent
  framing in the Netflix and Google "continuous delivery platform" announcements.
  Sources:
  [Google Cloud Blog, "Spinnaker 1.0"](https://cloud.google.com/blog/products/gcp/spinnaker-10-continuous-delivery);
  [Netflix TechBlog, "Global Continuous Delivery with Spinnaker"](https://netflixtechblog.com/global-continuous-delivery-with-spinnaker-2a6896c23ba7).
- It is therefore **complementary to IaC provisioning** (e.g., Terraform):
  IaC tools declare and provision infrastructure; Spinnaker orchestrates the safe
  rollout/promotion of application releases onto that infrastructure. (This
  IaC-vs-CD contrast is the author's synthesis based on the CD-platform framing
  in the cited sources, not a single quoted source claim.)
- Netflix's "Managed Delivery" work later pushed Spinnaker toward a more
  declarative ("delivery config as code") model — declarative definitions of
  infrastructure/delivery requirements promoted through environments. Source:
  [The Spinnaker Community Blog, "Managed Delivery: Evolving Continuous Delivery at Netflix"](https://blog.spinnaker.io/managed-delivery-evolving-continuous-delivery-at-netflix-eb74877fb33c).
  ("Could not verify: exact publication date of the Managed Delivery post" — not
  confirmed during research.)

---

## Key people & teams

- **Netflix Spinnaker team** — original creators; built Spinnaker as Asgard's
  successor and developed it in the open from the start. Notable named author:
  **Adam Jordens** (Netflix), author of the May 2021 "Evolving How Netflix
  Builds..." post. **Dianne Marsh** (Netflix Director of Engineering Tools)
  presented Netflix's Spinnaker/open-source story at OSCON 2017. Sources:
  [The Spinnaker Community Blog, May 4, 2021](https://blog.spinnaker.io/evolving-how-netflix-builds-maintains-and-operates-their-spinnaker-distribution-33c844d0102c);
  [opensource.com, May 11, 2017](https://opensource.com/article/17/5/netflixs-spinnaker-tale).
- **Michael Galloway** (Netflix) — author of the "Managed Delivery: Evolving
  Continuous Delivery at Netflix" post. Source:
  [The Spinnaker Community Blog](https://blog.spinnaker.io/managed-delivery-evolving-continuous-delivery-at-netflix-eb74877fb33c).
- **Google (Google Cloud) team** — co-developed Spinnaker with Netflix from 2014,
  led the public open-sourcing collaboration, drove Kubernetes integration, and
  co-donated Spinnaker to the CDF. Source:
  [Google Cloud Blog, "Spinnaker 1.0"](https://cloud.google.com/blog/products/gcp/spinnaker-10-continuous-delivery).
- **Microsoft, Pivotal, Kenzan, Oracle** — early partners/contributors named in
  the launch and 1.0 milestones. Sources:
  [Wikipedia](https://en.wikipedia.org/wiki/Spinnaker_(software));
  [Google Cloud Blog, "Spinnaker 1.0"](https://cloud.google.com/blog/products/gcp/spinnaker-10-continuous-delivery).
- **Armory** — commercial Spinnaker vendor, founded 2016 by **Daniel "DROdio"
  Odio**, **Isaac Mosquera**, and **Ben Mappen** (YC W17). Isaac Mosquera (CTO)
  served on the Spinnaker steering committee. Acquired (assets) by Harness in
  Jan 2024. Sources:
  [Y Combinator](https://www.ycombinator.com/companies/armory);
  [Crunchbase](https://www.crunchbase.com/organization/armory);
  [TechCrunch, Jan 11, 2024](https://techcrunch.com/2024/01/11/harness-acquires-the-assets-of-continuous-deployment-service-armory/).
- **Harness** (CEO **Jyoti Bansal**) — acquired Armory's assets in 2024 and
  committed to continuing Spinnaker community leadership. Sources:
  [TechCrunch, Jan 11, 2024](https://techcrunch.com/2024/01/11/harness-acquires-the-assets-of-continuous-deployment-service-armory/);
  [Harness blog](https://www.harness.io/blog/harness-acquires-armory-assets).
- **OpsMx** — listed as a Spinnaker contributor/commercial backer. Source:
  [Wikipedia, "Spinnaker (software)"](https://en.wikipedia.org/wiki/Spinnaker_(software)).
- **CD Foundation / Linux Foundation** — governance home since 2019; **Jim
  Zemlin** (Linux Foundation Executive Director) announced the CDF. Source:
  [Linux Foundation press release, Mar 12, 2019](https://www.linuxfoundation.org/press/press-release/the-linux-foundation-announces-new-foundation-to-support-continuous-delivery-collaboration).

---

## Could not verify (open items)

1. **Exact internal-adoption start date in 2014** at Netflix from a first-party
   Netflix source (Google's blog says collaboration began "back in 2014";
   Wikipedia says Netflix began consuming it internally in 2014).
2. **Exact day in September 2015** for the "Moving from Asgard to Spinnaker" post
   (the original techblog URL path indicates 2015/09; the live Medium-hosted post
   body could not be fetched directly due to a TLS certificate error during
   research).
3. **Exact founding month of Armory in 2016** from a first-party source.
4. **Specific 2023 Armory layoff event(s)** — sources confirm financial distress
   leading to the Jan 2024 asset sale, but no reputable source citing a dated
   2023 layoff/headcount-cut announcement was found. (Recommend follow-up.)
5. **A formal "Google took over maintenance" hand-off** — sources show Netflix
   slowing contribution cadence (May 2021) and Google/Harness/OpsMx remaining
   active, but no single first-party source declares a maintenance hand-off.
6. **Exact publication date** of the "Managed Delivery: Evolving Continuous
   Delivery at Netflix" post.
7. **True original publish date** of the Harness "Harness Acquires Armory" blog
   page (page surfaced May 28, 2024; the announcement itself is Jan 11, 2024 per
   TechCrunch — the latter is treated as authoritative).

---

## Research notes / source-access caveats

- The Netflix Tech Blog (netflixtechblog.com) pages returned a TLS certificate
  verification error ("unable to verify the first certificate") during WebFetch,
  so their body text could not be quoted directly. Their existence, titles, and
  approximate dates are corroborated via the original `techblog.netflix.com`
  permalinks (visible in search) and secondary coverage. The URLs are retained
  as primary references.
- `web.archive.org` could not be fetched in this environment.
- DevOps.com returned HTTP 403 and was not used as a citation.
