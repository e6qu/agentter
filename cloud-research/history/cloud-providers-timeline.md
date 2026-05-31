# The cloud providers: a timeline of launches, people & acquisitions

A chronological, strictly-sourced history of the major cloud providers — **when each
launched, who built it, where those people went next, and what each bought** to get
where it is. Scope is the five providers this repository studies for SDK/API codegen:
**AWS, Microsoft Azure, Google Cloud, Oracle Cloud Infrastructure, and Alibaba Cloud.**
(Other clouds — IBM Cloud/SoftLayer, DigitalOcean, Tencent Cloud, etc. — are out of
scope here to keep every claim sourced.)

Sourcing rules (same as the rest of `history/`): every non-trivial date, name, role,
and acquisition carries a real source URL inline; anything that could not be tied to a
primary or reputable source is marked **"Could not verify"** rather than asserted.

---

## Cross-cloud master timeline

| Date | Event | Cloud |
|---|---|---|
| 2002-07-16 | "Amazon.com Web Services" launches — a retail/affiliate catalog API (not yet infrastructure) | AWS |
| 2004-11-03 | Amazon SQS launches in beta | AWS |
| 2006-03-14 | Amazon **S3** launches | AWS |
| 2006-08-24 | Amazon **EC2** announced (beta) | AWS |
| 2008-04-07 | Google **App Engine** preview | Google |
| 2008-10-27 | **Windows Azure** unveiled at PDC (Ray Ozzie keynote) | Azure |
| 2009 (Apr announced / 2010 Jan closed) | Oracle acquires **Sun Microsystems** (~$7.4B) — Java/Solaris | Oracle |
| 2009-09 | **Alibaba Cloud (Aliyun)** founded in Hangzhou; Larry Ellison publicly mocks "cloud computing" | Alibaba / Oracle |
| 2010-02-01 | Windows Azure reaches commercial **GA** | Azure |
| 2010 (≈) | Google Storage & BigQuery announced (Google I/O) | Google |
| 2012-06-28 | Google **Compute Engine** announced (GA 2013-12-02) | Google |
| 2013 | "Google Cloud Platform" branding in use; Alibaba solves the **"5K"** cluster problem & hits "de-IOE" milestones | Google / Alibaba |
| 2014-02-04 | **Satya Nadella** becomes Microsoft CEO; "Windows Azure" → "Microsoft Azure" (Apr 3) | Azure |
| 2015-04-23 | Amazon breaks out **AWS as a reporting segment** for the first time ($1.566B Q1 revenue) | AWS |
| 2015 | AWS acquires **Annapurna Labs** (~$350M → Nitro/Graviton silicon); Alibaba injects **$1B** into Aliyun; Google buys **Bebop**, installs **Diane Greene** to lead cloud | AWS / Alibaba / Google |
| 2016 | Oracle launches **bare-metal cloud**; buys **NetSuite** ($9.3B); Google buys **Apigee** ($625M); **Jeff Zhang** becomes Alibaba CTO | Oracle / Google / Alibaba |
| 2018-10-22 | Oracle brands OCI the **"Generation 2 Cloud"** | Oracle |
| 2018-11-16 | **Thomas Kurian** (ex-Oracle) named Google Cloud CEO, replacing Diane Greene | Oracle → Google |
| 2019 | Oracle–Azure **cloud interconnect** (Jun 5); Google launches **Anthos** (Apr); Diane Greene leaves Alphabet's board | Oracle / Azure / Google |
| 2021-07-05 | **Andy Jassy** becomes Amazon CEO; **Adam Selipsky** returns as AWS CEO | AWS |
| 2022 | Google closes **Mandiant** ($5.4B); Oracle closes **Cerner** ($28.3B) | Google / Oracle |
| 2023 | Alibaba announces then **cancels** its cloud spin-off (Nov, citing US chip export controls); **Urs Hölzle** steps back (Jul); **Daniel Zhang** abruptly exits Alibaba Cloud (Sep) | Alibaba / Google / Alibaba |
| 2024-06 | **Matt Garman** becomes AWS CEO (succeeding Selipsky) | AWS |
| 2025 | Google announces **Wiz** (~$32B, its largest deal); **Clay Magouyrk** (ex-AWS) promoted to Oracle co-CEO (Sep) | Google / Oracle |
| 2026-03-11 | Google **completes** the Wiz acquisition | Google |

---

## Amazon Web Services (Amazon)

### Launch & founding timeline

- **July 16, 2002** — Amazon.com launched the first "Amazon.com Web Services," a developer platform (SOAP/XML interfaces to the product catalog) tied to the Associates program — a retail/affiliate API, distinct from the later cloud-infrastructure AWS. ([Amazon Press Center, 2002-07-16](https://press.aboutamazon.com/2002/7/amazon-com-launches-web-services-developers-can-now-incorporate-amazon-com-content-and-features-into-their-own-web-sites-extends-welcome-mat-for-developers))
- **2003 (executive retreat)** — Amazon's leadership ran a "core competencies" exercise and realized infrastructure (compute, storage, database) was a competency built from internal scaling needs; Andy Jassy, then Bezos's chief of staff, authored the original AWS business plan. ([TechCrunch, "How AWS came to be," 2016-07-02](https://techcrunch.com/2016/07/02/andy-jassys-brief-history-of-the-genesis-of-aws/))
- **Late 2003** — Network engineers Benjamin Black and his manager Chris Pinkham wrote an internal paper that, near the end, floated "the possibility of selling virtual servers as a service" — the seed of EC2. ([Benjamin Black, "EC2 Origins," 2009-01-25](https://blog.b3k.us/2009/01/25/ec2-origins.html))
- **November 3, 2004** — Amazon SQS launched in beta, one of the earliest AWS infrastructure services. ([AWS News Blog, 2021](https://aws.amazon.com/blogs/aws/amazon-sqs-15-years-and-still-queueing/))
- **March 14, 2006** — Amazon S3 launched at $0.15/GB-month with no minimum fee. ([Amazon Press Center, 2006-03-14](https://press.aboutamazon.com/2006/3/amazon-web-services-launches); [AWS What's New](https://aws.amazon.com/about-aws/whats-new/2006/03/13/announcing-amazon-s3---simple-storage-service/))
- **August 24, 2006** — Amazon EC2 announced in beta, pay-for-what-you-use. ([AWS What's New, 2006-08-24](https://aws.amazon.com/about-aws/whats-new/2006/08/24/announcing-amazon-elastic-compute-cloud-amazon-ec2---beta/))
- **April 23, 2015** — Amazon broke out AWS as a standalone reporting segment for the first time (Q1 2015 10-Q): $1.566B net sales (~49% YoY), $265M segment operating income. ([SEC Q1 2015 10-Q](https://www.sec.gov/Archives/edgar/data/1018724/000101872415000038/amzn-20150331x10q.htm); [Channel Futures](https://www.channelfutures.com/cloud/amazon-com-breaks-out-aws-cloud-revenues-for-first-time-in-q1-report))
- **November 2017 → re:Invent 2018** — The AWS Nitro System (hardware + lightweight hypervisor on Annapurna silicon) was introduced, and AWS announced **Graviton**, its first in-house Arm server CPU. ([Uptime Institute](https://journal.uptimeinstitute.com/how-awss-own-silicon-and-software-deliver-cloud-scalability/); [AWS Graviton — Wikipedia](https://en.wikipedia.org/wiki/AWS_Graviton))

### Key people & founding teams

- **Andy Jassy** — Joined Amazon 1997; as Bezos's chief of staff wrote the original AWS plan and led AWS from inception (SVP/CEO of AWS, 2003–2021). ([TechCrunch](https://techcrunch.com/2016/07/02/andy-jassys-brief-history-of-the-genesis-of-aws/); [Wikipedia](https://en.wikipedia.org/wiki/Andy_Jassy))
- **Benjamin Black** & **Chris Pinkham** — Co-authored the late-2003 paper that first floated selling virtual servers; Pinkham then led the EC2 build, relocating to Cape Town and assembling a team (lead developer Christopher Brown) that built it. ([Benjamin Black, 2009](https://blog.b3k.us/2009/01/25/ec2-origins.html); [Gadgeteer SA](https://gadgeteer.co.za/chris-pinkham-south-african-who-helped-build-amazon-web-services-team-cape-town-engineers/))
- **Werner Vogels** — Joined from Cornell in September 2004; named CTO January 2005. ([Wikipedia](https://en.wikipedia.org/wiki/Werner_Vogels))
- **Matt Garman** — Joined as an MBA intern (2005) and full-time (2006) as one of AWS's first product managers, on early EC2. ([Technology Magazine](https://technologymagazine.com/cloud-computing/new-aws-ceo-matt-garman-everything-you-need-to-know))
- *Could not verify* precise tenure/title sequence for **Al Vermeulen** (an early Amazon CTO / AWS Distinguished Engineer) from a primary source.

### Later evolution of those people

- **Andy Jassy** — Became president and CEO of **Amazon** on July 5, 2021, with Bezos moving to executive chairman. ([CNBC, 2021-05-26](https://www.cnbc.com/2021/05/26/jeff-bezos-to-formally-step-down-as-amazon-ceo-on-july-5.html))
- **Chris Pinkham** — Left AWS in 2006; co-founded **Nimbula** with Willem van Biljon (2008) — later **acquired by Oracle** and used as a basis for its cloud — then joined Twitter as VP of engineering. ([Gadgeteer SA](https://gadgeteer.co.za/chris-pinkham-south-african-who-helped-build-amazon-web-services-team-cape-town-engineers/))
- **Benjamin Black** — Later at Microsoft, VMware, founded monitoring company Boundary, and joined Pivotal. ([Network World](https://www.networkworld.com/article/936248/the-myth-about-how-amazon-s-web-service-started-just-won-t-die.html))
- **Adam Selipsky** — An early AWS exec who left to run **Tableau** (through its 2019 Salesforce sale), returned as AWS CEO in 2021, and departed in mid-2024. ([TechCrunch, 2021-03-23](https://techcrunch.com/2021/03/23/tableau-ceo-adam-selipsky-is-returning-to-aws-to-replace-andy-jassy-as-ceo/); [CNBC, 2024-05-14](https://www.cnbc.com/2024/05/14/amazon-web-services-ceo-adam-selipsky-to-step-down.html))
- **Matt Garman** — Named AWS CEO effective June 2024. ([GeekWire, 2024-05-14](https://www.geekwire.com/2024/amazon-web-services-ceo-adam-selipsky-stepping-down-to-be-replaced-by-senior-exec-matt-garman/))
- **Werner Vogels** — Remains Amazon CTO. ([AWS Executive Insights](https://aws.amazon.com/executive-insights/content/werner-vogels-2026-tech-predictions/))

### Strategic acquisitions

| Acquisition | Year | ~Price | Why it mattered | Source |
|---|---|---|---|---|
| Annapurna Labs | 2015 (Jan) | ~$350M (reported; some say ~$370M) | Israeli chip startup → the foundation of AWS custom silicon: **Nitro**, **Graviton**, later Trainium/Inferentia | [GeekWire](https://www.geekwire.com/2015/amazon-reportedly-talks-buy-secret-israeli-chip-maker-annapurna-labs-350m/); [Globes](https://en.globes.co.il/en/article-amazon-acquires-annapurna-labs-for-350m-1001003315) |
| Elemental Technologies | 2015 (Oct) | ~$296M total (some outlets "~$500M") | Became AWS Elemental — media/video processing | [Crunchbase](https://www.crunchbase.com/acquisition/amazon-acquires-elemental-technologies--733dc0fa); [TechCrunch](https://techcrunch.com/2015/09/03/amazon-acquires-elemental-technologies-for-a-reported-500-million-in-cash/) |
| Sqrrl | 2018 (Jan) | Could not verify | Security analytics / threat hunting | [CIO Dive](https://www.ciodive.com/news/aws-amazon-cloudendure-tso-logic-backup-acquisition/546417/) |
| TSO Logic | 2019 (Jan) | Could not verify | Cloud cost/efficiency analysis for migration | [CIO Dive](https://www.ciodive.com/news/aws-amazon-cloudendure-tso-logic-backup-acquisition/546417/) |
| CloudEndure | 2019 (Jan) | ~$250M (reported) | Disaster recovery & migration | [CIO Dive](https://www.ciodive.com/news/aws-amazon-cloudendure-tso-logic-backup-acquisition/546417/) |
| E8 Storage | 2019 (Jul) | Could not verify | High-performance flash storage | [TechCrunch](https://techcrunch.com/2019/07/31/amazon-acquires-flash-based-cloud-storage-startup-e8-storage/) |
| Wickr | 2021 (Jun) | Could not verify (undisclosed) | End-to-end encrypted messaging (AWS Wickr; DoD use) | [TechCrunch](https://techcrunch.com/2021/06/25/aws-is-buying-encrypted-messaging-service-wickr/) |

AWS grew largely **organically**; its most strategically consequential buy was Annapurna, which turned into a custom-silicon advantage no competitor matched for years.

---

## Microsoft Azure (Microsoft)

### Launch & founding timeline

- **Origins — "Project Red Dog" (mid-2000s).** Chief Software Architect **Ray Ozzie** asked **Amitabh Srivastava** to lead a team to "servicize" Microsoft's platform — running a datacenter as an operating system — and Srivastava recruited **Dave Cutler**, lead architect of Windows NT. ([eWeek, "Who Let the Red Dogs Out?"](https://www.eweek.com/development/who-let-the-red-dogs-out/))
- **October 27, 2008** — Ray Ozzie announced **"Windows Azure"** at PDC2008; a limited CTP went to attendees. ([Microsoft, 2008-10-27](https://news.microsoft.com/source/2008/10/27/microsoft-unveils-windows-azure-at-professional-developers-conference/))
- **February 1, 2010** — Windows Azure and SQL Azure reached commercial **GA** (initially 21 countries). ([Official Microsoft Blog, 2010-02-01](https://blogs.microsoft.com/blog/2010/02/01/windows-azure-general-availability/))
- **March 25 / April 3, 2014** — "Windows Azure" renamed **"Microsoft Azure"** (effective at BUILD 2014), signaling Linux/Java/PHP/Python support, not Windows-only. ([The Next Web, 2014-03-25](https://thenextweb.com/microsoft/2014/03/25/microsoft-confirms-windows-azure-will-become-microsoft-azure-april-3/))
- **February 4, 2014** — **Satya Nadella**, who had led the cloud/server engineering org, became Microsoft's third CEO; the board cited his role in the move to the cloud. ([Microsoft, 2014-02-04](https://news.microsoft.com/source/2014/02/04/microsoft-board-names-satya-nadella-as-ceo/))

### Key people & founding teams

- **Amitabh Srivastava** — Corporate VP who led the "Red Dog"/Windows Azure effort (had earlier led Windows Vista). ([eWeek](https://www.eweek.com/development/who-let-the-red-dogs-out/))
- **Dave Cutler** — "Father of Windows NT," recruited onto the early Azure team to build a hypervisor-based cloud platform. ([Microsoft Stories](https://news.microsoft.com/features/the-engineers-engineer-computer-industry-luminaries-salute-dave-cutlers-five-decade-long-quest-for-quality/))
- **Ray Ozzie** — Chief Software Architect (Gates's successor in that role); initiated Azure and announced it at PDC2008. ([Microsoft, 2008](https://news.microsoft.com/source/2008/10/27/microsoft-unveils-windows-azure-at-professional-developers-conference/))
- **Satya Nadella** — President of Server & Tools (2011), then EVP Cloud & Enterprise (2013), before CEO (2014). ([Wikipedia](https://en.wikipedia.org/wiki/Satya_Nadella))
- **Scott Guthrie** — Co-inventor of ASP.NET; moved to lead the Windows Azure Application Platform team in a May 2011 reorg, and has led the **Cloud + AI** group since 2014. ([Virtualization Review, 2011-05-02](https://virtualizationreview.com/articles/2011/05/02/microsoft-repositions-guthrie-to-lead-azure-team.aspx))
- **Mark Russinovich** — Sysinternals/Winternals co-founder (joined Microsoft via the 2006 acquisition); **Azure CTO**. ([Wikipedia](https://en.wikipedia.org/wiki/Mark_Russinovich))

### Later evolution of those people

- **Ray Ozzie** — Left Microsoft end-2010; founded **Talko** (2012, sold back to Microsoft 2015) and IoT startup **Blues Wireless** (2020). ([Wikipedia](https://en.wikipedia.org/wiki/Raymond_Ozzie); [GeekWire](https://www.geekwire.com/2020/ray-ozzies-latest-project-former-microsoft-exec-raises-11m-iot-startup-blues-wireless/))
- **Amitabh Srivastava** — Left Microsoft in 2011, joined **EMC** as president of its Advanced Storage Division. ([AllThingsD, 2011-02-09](https://allthingsd.com/20110209/ripples-in-microsofts-cloud-as-amitabh-srivastava-leaves/))
- **Dave Cutler** — Stayed at Microsoft as a Senior Technical Fellow; later worked on the Hyper-V host OS for **Xbox One**; Computer History Museum Fellow (2016). ([Microsoft Bay Area Blog, 2016](https://blogs.microsoft.com/bayarea/2016/04/15/microsofts-dave-cutler-honored-for-his-five-decades-of-work-by-the-computer-history-museum/))
- **Satya Nadella** — CEO since 2014; also elected **chairman** of the board in June 2021. ([Microsoft, 2021-06-16](https://news.microsoft.com/source/2021/06/16/microsoft-board-of-directors-announces-role-changes-and-quarterly-dividend/))
- **Scott Guthrie** and **Mark Russinovich** — Continue as EVP Cloud + AI and Azure CTO respectively. ([Microsoft exec bio](https://blogs.microsoft.com/blog/author/scottguthrie/))

### Strategic acquisitions

| Acquisition | Year | ~Price | Why it mattered | Source |
|---|---|---|---|---|
| Cloudyn | 2017 | Could not verify (GeekWire reported ~$50M) | → Azure Cost Management | [Microsoft](https://blogs.microsoft.com/blog/2017/06/29/microsofts-acquisition-cloudyn-will-help-azure-customers-manage-optimize-cloud-usage/) |
| Cycle Computing | 2017 | Could not verify | HPC orchestration for Azure | [Microsoft](https://blogs.microsoft.com/blog/2017/08/15/microsoft-acquires-cycle-computing-accelerate-big-computing-cloud/) |
| Avere Systems | 2018 | Could not verify | High-performance hybrid file storage | [Microsoft](https://blogs.microsoft.com/blog/2018/01/03/microsoft-to-acquire-avere-systems-accelerating-high-performance-computing-innovation-for-media-and-entertainment-industry-and-beyond/) |
| **GitHub** | 2018 | **$7.5B** (stock) | Developer-platform reach; later central to AI (Copilot) | [Microsoft](https://news.microsoft.com/source/2018/06/04/microsoft-to-acquire-github-for-7-5-billion) |
| Citus Data | 2019 | Could not verify | Distributed PostgreSQL → Azure managed Postgres | [Microsoft](https://blogs.microsoft.com/blog/2019/01/24/microsoft-acquires-citus-data-re-affirming-its-commitment-to-open-source-and-accelerating-azure-postgresql-performance-and-scale/) |
| Affirmed Networks | 2020 | Could not verify (Bloomberg ~$1.35B) | Cloud-native mobile core → Azure telco/5G | [Microsoft](https://blogs.microsoft.com/blog/2020/03/26/microsoft-to-acquire-affirmed-networks-to-deliver-on-promise-of-5g/) |
| Metaswitch Networks | 2020 | Could not verify | Cloud-native comms → Azure for Operators | [Microsoft](https://blogs.microsoft.com/blog/2020/05/14/microsoft-announces-definitive-agreement-to-acquire-metaswitch-networks-expanding-approach-to-empower-operators-and-partner-with-network-equipment-providers-to-deliver-on-promise-of-5g/) |
| **Nuance** | 2021 (closed 2022) | **$19.7B** (all-cash) | Healthcare/conversational AI → industry cloud | [Microsoft](https://news.microsoft.com/source/2021/04/12/microsoft-accelerates-industry-cloud-strategy-for-healthcare-with-the-acquisition-of-nuance/) |

---

## Google Cloud Platform (Google / Alphabet)

### Launch & founding timeline

- **April 7, 2008** — Google announced an **App Engine** preview at Campfire One, limited to the first 10,000 developers. ([Google Cloud Blog, 2008-04-07](https://cloudplatform.googleblog.com/2008/04/introducing-google-app-engine-our-new.html); [TechCrunch](https://techcrunch.com/2008/04/07/google-jumps-head-first-into-web-services-with-google-app-engine/))
- **May 2010 → 2011** — **Google Storage for Developers** (object storage; later Cloud Storage) and **BigQuery** were *previewed* at Google I/O (Storage announced 2010-05-19; opened to all developers May 2011); **BigQuery reached GA in November 2011**. ([Google Code blog](http://googlecode.blogspot.com/2010/05/google-storage-for-developers-preview.html); [BigQuery — Wikipedia](https://en.wikipedia.org/wiki/BigQuery))
- **June 28, 2012 → December 2, 2013** — **Compute Engine** announced in limited preview at I/O, then declared **GA** (with live-migration maintenance and lower prices). ([Google Cloud Blog, 2013-12-02](https://cloudplatform.googleblog.com/2013/12/google-compute-engine-is-now-generally-available.html); [TechCrunch](https://techcrunch.com/2013/12/02/googles-compute-engine-hits-general-availability-drops-instance-prices-10-adds-new-16-core-instance-types-and-docker-support/))
- **2013** — Google was operating under the **"Google Cloud Platform"** name (the official blog ran under that banner). *Could not verify* a single precise date the brand was formally introduced. ([Google Cloud Blog, 2013 year-in-review](https://cloudplatform.googleblog.com/2013/12/2013-year-in-review-bringing-together-mobile-and-cloud.html))
- **November 19, 2015** — Google acquired **Bebop** and named its founder **Diane Greene** to lead a unified Google cloud business. ([TechCrunch](https://techcrunch.com/2015/11/19/google-buys-bebop-and-names-diane-greene-to-lead-enterprise-cloud-effort/); [Google 8-K](https://www.sec.gov/Archives/edgar/data/0001288776/000128877615000048/googexhibit991-111915.htm))
- **November 16, 2018 → early 2019** — Ex-Oracle exec **Thomas Kurian** named Google Cloud CEO, succeeding Greene (who served Dec 2015–Jan 2019). ([CNBC, 2018-11-16](https://www.cnbc.com/2018/11/16/google-cloud-ceo-greene-being-replaced-by-former-oracle-exec-kurian.html))
- **April 9, 2019** — **Anthos** (hybrid/multi-cloud platform on GKE) launched at Next '19. ([InfoQ](https://www.infoq.com/news/2019/04/gcp-anthos-ga/))
- Much of GCP's data-center, distributed-systems, and SDN foundation was built under **Urs Hölzle**, Google's first VP of Engineering. ([Wikipedia](https://en.wikipedia.org/wiki/Urs_H%C3%B6lzle))

### Key people & founding teams

- **Urs Hölzle** — Google's ~8th employee and first VP of Engineering; later SVP Technical Infrastructure and a Google Fellow; built the core infrastructure GCP runs on. ([Wikipedia](https://en.wikipedia.org/wiki/Urs_H%C3%B6lzle))
- **Pete Koomen** — ~3 years as a Google PM helping launch/grow App Engine, before co-founding **Optimizely** (2010). ([Tom Tunguz notes](https://tomtunguz.com/saas-office-hours-pete-koomen-notes/); [UIUC alumni profile](https://siebelschool.illinois.edu/about/awards/alumni-awards/alumni-awards-past-recipients/pete-koomen)) — *Paul McDonald is also commonly cited as an App Engine lead; could not verify a clean primary source for his exact role.*
- **Diane Greene** — VMware co-founder/CEO (1998–2008); led Google Cloud Dec 2015–Jan 2019. ([Wikipedia](https://en.wikipedia.org/wiki/Diane_Greene))
- **Thomas Kurian** — ~22-year Oracle veteran (President of Product Development) until his Sept 2018 resignation; Google Cloud CEO since early 2019. ([SiliconANGLE, 2018-09-30](https://siliconangle.com/2018/09/30/oracles-thomas-kurian-resigned-three-weeks-taking-extended-leave/))
- **Brian Stevens** — Former Red Hat CTO; joined Google in 2014 as VP of Cloud Platforms, later Google Cloud CTO. ([Computerworld, 2014](https://www.computerworld.com/article/2607178/former-red-hat-cto-now-head-of-google-cloud.html))

### Later evolution of those people

- **Diane Greene** — Stepped down Jan 2019; left Alphabet's board June 2019; later board roles (Wix, SAP, Stripe, Maersk, Khan Academy) and **chair of the MIT Corporation** (2020). ([GeekWire, 2019](https://www.geekwire.com/2019/former-google-cloud-ceo-diane-greene-longtime-google-ceo-eric-schmidt-leaving-alphabets-board-directors/); [MIT News, 2020](https://news.mit.edu/2020/diane-greene-elected-chair-corporation-0807))
- **Thomas Kurian** — Resigned Oracle Sept 28, 2018 (reporting tied it to disagreement with Ellison over running Oracle software on rival clouds); joined Google Cloud weeks later. ([SiliconANGLE](https://siliconangle.com/2018/09/30/oracles-thomas-kurian-resigned-three-weeks-taking-extended-leave/); [Oracle 8-K](https://www.sec.gov/Archives/edgar/data/0001341439/000119312518287698/d625872d8k.htm))
- **Urs Hölzle** — In July 2023 stepped back from running technical infrastructure (after ~24 years) to a Google Fellow IC role (succeeded by Chris Vonderhaar); his 2021 New Zealand relocation drew internal criticism amid RTO tensions. ([TechCrunch, 2023-07-12](https://techcrunch.com/2023/07/12/google-cloud-infrastructure-head-urs-holzle-stepping-down/); [CNBC](https://www.cnbc.com/2023/07/12/google-cloud-shakeup-urs-holzle-to-step-down-from-executive-management.html))
- **Pete Koomen** — Co-founded **Optimizely** (2010, with Dan Siroker); later a Group Partner at Y Combinator. ([UIUC profile](https://siebelschool.illinois.edu/about/awards/alumni-awards/alumni-awards-past-recipients/pete-koomen))

### Strategic acquisitions

| Acquisition | Year | ~Price | Why it mattered | Source |
|---|---|---|---|---|
| Bebop | 2015 | ~$380M (stock) | Brought in **Diane Greene** to lead cloud | [Google 8-K](https://www.sec.gov/Archives/edgar/data/0001288776/000128877615000048/googexhibit991-111915.htm) |
| Orbitera | 2016 | Undisclosed (reported >$100M) | Cloud commerce/billing, ISV marketplace | [Fortune](https://fortune.com/2016/08/08/google-orbitera-cloud-startup/) |
| **Apigee** | 2016 | **$625M** (all-cash) | Enterprise API management | [TechCrunch](https://techcrunch.com/2016/09/08/google-will-acquire-apigee-for-625-million/) |
| Alooma | 2019 | Could not verify (reported ~$150M) | Data pipeline/migration into GCP | [TechCrunch recap](https://techcrunch.com/2022/01/04/google-confirms-it-acquired-cybersecurity-specialist-siemplify-reportedly-for-500m-to-become-part-of-google-clouds-chronicle/) |
| CloudSimple | 2019 | Could not verify | VMware workloads on GCP | [CNBC](https://www.cnbc.com/2020/02/19/google-cloud-acquires-mainframe-company-cornerstone-technology.html) |
| **Looker** | 2019 (closed 2020) | **$2.6B** (all-cash) | BI/analytics; Kurian's first big deal | [Alphabet IR](https://abc.xyz/investor/news/news-details/2019/Google-to-Acquire-Looker-06-06-2019/default.aspx) |
| Cornerstone Technology | 2020 | Could not verify | Mainframe-to-GCP migration | [CNBC](https://www.cnbc.com/2020/02/19/google-cloud-acquires-mainframe-company-cornerstone-technology.html) |
| Actifio | 2020 | Could not verify | Backup / DR / copy-data mgmt | [Google Cloud Blog](https://cloud.google.com/blog/products/storage-data-transfer/google-enters-agreement-to-acquire-actifio) |
| Siemplify | 2022 | ~$500M (reported) | SOAR → Chronicle security | [TechCrunch](https://techcrunch.com/2022/01/04/google-confirms-it-acquired-cybersecurity-specialist-siemplify-reportedly-for-500m-to-become-part-of-google-clouds-chronicle/) |
| **Mandiant** | 2022 | **$5.4B** (all-cash) | Threat intel / incident response | [Google Cloud press](https://www.googlecloudpresscorner.com/2022-03-08-mgc); [TechCrunch](https://techcrunch.com/2022/09/12/google-closes-5-4b-mandiant-acquisition/) |
| **Wiz** | 2025 (closed 2026-03-11) | **$32B** (all-cash) | Cloud security; Google's largest deal ever | [Google blog](https://blog.google/inside-google/company-announcements/google-agreement-acquire-wiz/); [TechCrunch](https://techcrunch.com/2026/03/11/google-completes-32b-acquisition-of-wiz/) |

---

## Oracle Cloud Infrastructure (Oracle)

> Oracle's cloud story is unusually acquisition-driven, and the engineering org that built OCI was substantially staffed by **former AWS and Microsoft engineers**.

### Launch & founding timeline

- **2008–2009 — Ellison's public skepticism.** Larry Ellison repeatedly mocked "cloud computing"; in a September 2009 appearance he ranted that the industry had redefined everything as cloud, "all it is, is a computer attached to a network," adding "we'll make cloud computing announcements" because "we're not going to fight this thing." ([TechCrunch, 2009-10-01](https://techcrunch.com/2009/10/01/larry-ellison-still-hates-cloud-computing-nonsense-video/); [Data Center Knowledge, 2009-09-28](https://www.datacenterknowledge.com/archives/2009/09/28/larry-ellison-rants-about-cloud-computing)) (The "water vapor" framing was a commentator paraphrase, not a direct quote.)
- **The pivot to a real IaaS (~2015–2016).** Oracle built a second-generation infrastructure cloud largely with engineers recruited from AWS, Azure and Google into a Seattle-area org; VP of development Deepak Patil (15 years at Microsoft) said he was "surrounded by several hundred people who came from Amazon, Microsoft, Google." ([Data Center Knowledge](https://www.datacenterknowledge.com/data-center-career-development/oracle-s-cloud-built-by-former-aws-microsoft-engineers-comes-online); [SDxCentral](https://www.sdxcentral.com/news/heres-whats-inside-oracles-aws-killing-bare-metal-cloud/)) *Could not verify* the often-repeated "400 engineers from AWS" figure against a primary source.
  - IaaS lead **Don Johnson** (≈7 years at AWS) told OpenWorld 2016 to expect "quarterly, monthly, weekly, almost daily releases." ([VentureBeat, 2016-09-25](https://venturebeat.com/2016/09/25/oracle-cloud-iaas-strategy))
- **October 2016** — Oracle launched bare-metal cloud compute, the foundation of OCI. ([SiliconANGLE, 2016-10-21](https://siliconangle.com/2016/10/21/oracle-launches-bare-metal-cloud-servers-to-take-on-amazon/))
- **October 2, 2017** — Ellison unveiled the **Autonomous Database** at OpenWorld, OCI's flagship workload. ([PR Newswire, 2017-10-02](https://www.prnewswire.com/news-releases/oracle-unveils-worlds-first-autonomous-database-cloud-300528902.html))
- **October 22, 2018** — Ellison branded OCI the **"Generation 2 Cloud,"** with a separate-architecture control plane isolating customer code/data from cloud control code. ([Oracle, 2018-10-22](https://www.oracle.com/corporate/pressrelease/oow18-larry-ellison-keynote-102218.html); [Oracle blog](https://blogs.oracle.com/cloud-infrastructure/introducing-the-generation-2-cloud-at-oracle-openworld-2018))
- **June 5, 2019** — Oracle and Microsoft announced a **cloud interconnect** (direct network link + federated identity) between Azure and OCI. ([Microsoft Source, 2019-06-05](https://news.microsoft.com/source/2019/06/05/microsoft-and-oracle-to-interconnect-microsoft-azure-and-oracle-cloud/))

### Key people & founding teams

- **Larry Ellison** — Oracle co-founder; Executive Chairman & CTO; chief champion of Gen 2 Cloud and Autonomous Database. ([Oracle, 2018](https://www.oracle.com/corporate/pressrelease/oow18-larry-ellison-keynote-102218.html))
- **Thomas Kurian** — President of Product Development (22-year veteran); **resigned Sept 28, 2018**, reportedly after disagreements with Ellison over cloud direction. ([TechCrunch](https://techcrunch.com/2018/11/16/former-oracle-exec-thomas-kurian-to-replace-diane-greene-as-head-of-google-cloud/))
- **Don Johnson** — ex-AWS engineer who led the OCI / bare-metal build; rose to EVP of OCI. ([VentureBeat](https://venturebeat.com/2016/09/25/oracle-cloud-iaas-strategy))
- **Clay Magouyrk** — Joined Oracle in **2014 from AWS**; a "founding member of Oracle's cloud engineering team," oversaw OCI Gen 2's design, later President of OCI. ([Oracle / PR Newswire, 2025-09-22](https://www.prnewswire.com/news-releases/oracle-corporation-announces-promotion-of-clay-magouyrk-and-mike-sicilia-to-ceos-safra-catz-appointed-executive-vice-chair-of-the-board-of-directors-302562877.html))
- **Edward Screven** — EVP & Chief Corporate Architect (Oracle since 1986); retired Feb 2025. ([The Register, 2025-01-14](https://www.theregister.com/2025/01/14/oracle_chief_corporate_architect_retires/))
- *Could not verify* a specific OCI founding role for "Hari Rajaram" — omitted rather than guess.

### Later evolution of those people

- **Thomas Kurian** — Left Oracle (Sept 2018) → announced **CEO of Google Cloud** Nov 16, 2018, replacing Diane Greene. ([TechCrunch](https://techcrunch.com/2018/11/16/former-oracle-exec-thomas-kurian-to-replace-diane-greene-as-head-of-google-cloud/)) **This is the single most striking cross-cloud move: Oracle's top product exec now runs Google's cloud.**
- **Larry Ellison** — Stepped down as CEO Sept 2014 → Executive Chairman & CTO, with **Safra Catz** and **Mark Hurd** as co-CEOs. ([Oracle 8-K, 2014](https://www.sec.gov/Archives/edgar/data/0001341439/000119312514350215/d793532dex991.htm))
- **Mark Hurd** — Took medical leave Sept 2019, **died Oct 18, 2019**; **Safra Catz** continued as **sole CEO**. ([Oracle 8-K, 2019](https://www.sec.gov/Archives/edgar/data/0001341439/000119312519269943/d823419dex991.htm))
- **Clay Magouyrk** — President of OCI → on **Sept 22, 2025** promoted to **co-CEO of Oracle** (with Mike Sicilia); Safra Catz became Executive Vice Chair. ([Oracle / PR Newswire, 2025](https://www.prnewswire.com/news-releases/oracle-corporation-announces-promotion-of-clay-magouyrk-and-mike-sicilia-to-ceos-safra-catz-appointed-executive-vice-chair-of-the-board-of-directors-302562877.html)) **An ex-AWS engineer who built OCI now co-runs Oracle.**
- **Don Johnson** — the ex-AWS engineer who led the OCI build and rose to EVP; in **February 2025 he left Oracle to become CEO of Docker** — yet another node in the AWS→OCI→elsewhere talent chain. ([TechCrunch, 2025-02-13](https://techcrunch.com/2025/02/13/former-oracle-cloud-exec-don-johnson-takes-over-as-dockers-new-ceo/))

### Strategic acquisitions

| Acquisition | Year | ~Price | Why it mattered | Source |
|---|---|---|---|---|
| **Sun Microsystems** | 2009→2010 | **~$7.4B** | Java, Solaris, hardware — full stack for engineered systems & cloud | [Oracle](https://www.oracle.com/corporate/pressrelease/oracle-buys-sun-042009.html) |
| Nimbula | 2013 | Could not verify | IaaS orchestration; founded by **Chris Pinkham & Willem van Biljon (the EC2 team)** — EC2 pedigree into Oracle | [Data Center Knowledge](https://www.datacenterknowledge.com/archives/2013/03/13/oracle-acquires-nimbula-tech-giants-waking-up-to-cloud-potential); [Wikipedia](https://en.wikipedia.org/wiki/Nimbula) |
| Ravello Systems | 2016 | ~$500M (reported) | Nested virtualization across clouds | [Haaretz](https://www.haaretz.com/israel-news/business/2016-02-23/ty-article/.premium/ravello-is-acquired-by-oracle-for-about-half-a-billion-dollars/0000017f-db51-d3a5-af7f-fbff579f0000) |
| **NetSuite** | 2016 | **~$9.3B** | Cloud ERP/SaaS cornerstone | [Oracle](https://www.oracle.com/corporate/pressrelease/oracle-buys-netsuite-072816.html) |
| Dyn | 2016 | Could not verify (reported ~$600–700M) | Managed DNS / edge for Oracle Cloud | [Oracle](https://www.oracle.com/corporate/pressrelease/oracle-buys-dyn-112116.html); [TechCrunch](https://techcrunch.com/2016/11/21/oracle-acquires-dns-provider-dyn-subject-of-a-massive-ddos-attack-in-october/) |
| **Cerner** | 2022 | **~$28.3B** | Oracle's largest deal; EHR / healthcare cloud | [SEC 8-K](https://www.sec.gov/Archives/edgar/data/0000804753/000080475322000008/a991pressreleasedatedfebru.htm) |

Oracle's cloud was, more than any other, **assembled by acquisition** — from Sun (the stack) to Nimbula (literally the ex-EC2 founders) to NetSuite and Cerner (vertical SaaS).

---

## Alibaba Cloud (Alibaba Group)

> Unlike the others, Alibaba Cloud grew almost entirely **organically** out of an internal infrastructure crisis, tied to one founder-technologist — **Dr. Wang Jian** — and the patronage of **Jack Ma**.

### Launch & founding timeline

- **September 10, 2009** — Alibaba Cloud (Aliyun) founded in Hangzhou, on Alibaba Group's 10th anniversary. ([Alibaba Group](https://www.alibabagroup.com/en-US/about-alibaba-businesses-1747835448811585536); [Wikipedia](https://en.wikipedia.org/wiki/Alibaba_Cloud))
- **Wang Jian & the Apsara (飞天 / Feitian) project.** Wang Jian, a former assistant managing director at Microsoft Research Asia, joined Alibaba as chief architect (2008) and is identified by Alibaba Cloud as "the founder of Alibaba Cloud," building the **Apsara** cloud OS (core layers: **Pangu** storage, **Fuxi** scheduling). ([Alibaba Cloud — Apsara history](https://www.alibabacloud.com/blog/a-brief-history-of-alibaba-cloud-apsara-system_593843); [Wikipedia — Wang Jian](https://en.wikipedia.org/wiki/Wang_Jian_(computer_scientist)))
- **2013 — the "5K" milestone.** Running a single Apsara cluster of 5,000+ machines was solved mid-2013 — presented as China's first complete, self-developed cloud capability. ([Alibaba Cloud — Chronicles of Cloud Building](https://alibaba-cloud.medium.com/the-chronicles-of-cloud-building-in-hangzhou-part-1-ea9cae58625))
- **"De-IOE" campaign.** Removing **I**BM servers, **O**racle databases, **E**MC storage — reaching symbolic milestones in **May 2013** (last IBM server unplugged), amid years of internal skepticism, with Jack Ma's backing. ([ChinaFile / Caixin](https://www.chinafile.com/reporting-opinion/caixin-media/china-pulling-plug-foreign-mainframes))
- **2015–2016 — international expansion.** First **Singapore data center (2015)** as overseas HQ, plus **US (Silicon Valley)** capacity, part of a $1B internationalization push. *Could not verify* the exact US-datacenter go-live month. ([Alibaba Cloud Press Room](https://www.alibabacloud.com/press-room/alibaba-cloud-expands-singapore-data-center-and-achieves))
- **2023 — planned spin-off, then cancellation.** A March 2023 reorg slated the **Cloud Intelligence Group** for a full spin-off; on **November 16, 2023** Alibaba **scrapped** it, citing the October 2023 US expansion of advanced-chip export controls — shares fell ~$20B+. ([CNBC, 2023-11-17](https://www.cnbc.com/2023/11/17/alibaba-sheds-20-billion-in-market-cap-as-cloud-spinoff-scrapped.html); [SCMP](https://www.scmp.com/tech/big-tech/article/3241816/alibaba-hand-out-first-ever-annual-dividend-it-posts-9-revenue-growth-september-quarter-amid-chinas))

### Key people & founding teams

- **Jack Ma (马云)** — Alibaba founder & executive sponsor; committed **1B RMB/year for ten years** to the cloud program and gave Wang Jian cover for "de-IOE." ([Alibaba Cloud](https://www.alibabacloud.com/blog/a-brief-history-of-alibaba-cloud-apsara-system_593843); [ChinaFile](https://www.chinafile.com/reporting-opinion/caixin-media/china-pulling-plug-foreign-mainframes))
- **Dr. Wang Jian (王坚)** — Founder of Aliyun, architect of Apsara; Alibaba Group **CTO from 2012**. ([Wikipedia](https://en.wikipedia.org/wiki/Wang_Jian_(computer_scientist)))
- **Jeff Zhang / Zhang Jianfeng (张建锋)** — Succeeded Wang Jian as Alibaba Group **CTO (April 2016)**; later President of Alibaba Cloud. ([StreetInsider](https://www.streetinsider.com/Management+Changes/Alibaba+%28BABA%29+Names+Jeff+Zhang+at+CTO/11465307.html))
- **Daniel Zhang / Zhang Yong (张勇)** — Alibaba CEO/chairman who announced the $1B Aliyun investment (2015) and later took **direct charge of Alibaba Cloud (2022)**. ([TechCrunch, 2015](https://techcrunch.com/2015/07/29/alibillion/))
- **Eddie Wu / Wu Yongming (吴泳铭)** — Alibaba co-founder & original CTO (1999); became Group CEO in 2023 and took over the cloud unit. ([CNBC](https://www.cnbc.com/2023/06/20/who-is-alibabas-new-ceo-eddie-wu-and-chairman-joe-tsai.html))

### Later evolution of those people

- **Wang Jian** — Stepped down as Group CTO (2016), stayed as Technology Committee chairman; led the **City Brain** smart-city initiative; **elected an academician of the Chinese Academy of Engineering** (Nov 22, 2019); later headed a Zhejiang provincial AI lab. ([Yicai Global](https://www.yicaiglobal.com/news/alibaba-wang-jian-appointed-academician-); [Yicai Global — Zhejiang Lab](https://www.yicaiglobal.com/news/chinas-zhejiang-appoints-alibaba-clouds-founder-as-director-of-provincial-govt-backed-ai-lab))
- **Jack Ma** — Stepped down as chairman **Sept 10, 2019**; after his Oct 2020 Bund speech, the **~$35B Ant Group IPO was halted** (early Nov 2020) and Ma retreated from public life amid a regulatory crackdown. ([TechCrunch, 2019](https://techcrunch.com/2019/09/09/jack-ma-officially-retires-as-alibabas-chairman/); [Bloomberg](https://www.bloomberg.com/news/features/2020-12-22/jack-ma-s-empire-in-crisis-after-china-halts-ant-group-ipo))
- **Jeff Zhang** — Stepped down from leading the cloud business in the **December 2022** restructuring that followed a major cloud outage; Daniel Zhang took direct oversight. ([kr-asia](https://kr-asia.com/alibaba-announces-first-major-restructure-after-jack-mas-retirement-plan))
- **Daniel Zhang** — Took direct charge of Alibaba Cloud (2022); announced he'd step down as Group chairman/CEO to focus on cloud (effective Sept 10, 2023) — then **abruptly left the cloud unit and the company on Sept 11, 2023**; **Eddie Wu** took over. ([SCMP](https://www.scmp.com/tech/big-tech/article/3224693/alibaba-ceo-daniel-zhang-step-down-focus-cloud-business-corporate-shake-continues-e-commerce-giant); [CNN](https://www.cnn.com/2023/09/11/tech/china-alibaba-leadership-overhaul-intl-hnk))
- **Eddie Wu & Joe Tsai** — Effective **Sept 10, 2023**, Tsai became chairman and Wu CEO, succeeding Daniel Zhang; Wu also took direct leadership of the Cloud Intelligence Group. ([CNN](https://www.cnn.com/2023/06/20/tech/alibaba-chairman-ceo-succession-intl-hnk/index.html); [Business Wire](https://www.businesswire.com/news/home/20230619481579/en/Alibaba-Group-Announces-Chairman-and-CEO-Succession-Plan))

### Strategic acquisitions / investments

Alibaba Cloud grew **predominantly organically**; the most consequential moves were internal capital, not M&A.

| Move | Year | ~Price | Why it mattered | Source |
|---|---|---|---|---|
| $1B injection into Aliyun | 2015 | ~$1.0B | Funded international expansion (Singapore HQ, US, plans for Middle East/Japan/Europe) | [TechCrunch](https://techcrunch.com/2015/07/29/alibillion/) |
| Jack Ma's annual R&D commitment | from ~2009 | 1B RMB/yr × 10 | Long-horizon funding that sustained Apsara & "de-IOE" through years of skepticism | [Alibaba Cloud](https://www.alibabacloud.com/blog/a-brief-history-of-alibaba-cloud-apsara-system_593843) |
| $1B technology fund (tied to D. Zhang's 2023 exit) | 2023 | ~$1.0B | Fund (not an acquisition) supporting future-growth strategies | [TechXplore](https://techxplore.com/news/2023-09-ceo-china-alibaba-cloud-business.html) |

Specific cloud-relevant **acquisition** prices were largely not disclosed and could not be verified; the overseas footprint was built organically rather than acquired.

---

## Contemporary reactions (Hacker News) & major outages

A second corroboration pass, mining **Hacker News** (`news.ycombinator.com`) threads
around the crucial dates plus the **major outages** of each cloud. Caveat: **HN launched
~February 19, 2007**, so AWS's S3/EC2/SQS (2004–2006) have no contemporaneous threads —
their absence is noted, not faked. Western HN coverage of Chinese-cloud operational
events is genuinely thin; those absences are flagged honestly too. HN point counts are
from the HN Algolia API at research time.

### AWS — additions, outages & HN

Corroborated; date nuances worth noting: the S3 "What's New" page is dated **2006-03-13** though AWS cites **March 14** as the launch; EC2 beta spans the **Aug 24–25, 2006** AWS pages; **EC2 left beta / GA on 2008-10-23**; the first **re:Invent** was **Nov 27–29, 2012**; **AWS Lambda** launched **2014-11-13**.

| Outage | Date | What happened | Post-mortem | HN |
|---|---|---|---|---|
| EC2/EBS US-East | 2011-04-21 | A botched network change triggered an EBS "re-mirroring storm"; took down Reddit, Quora, Foursquare, Heroku for days | [aws.amazon.com/message/65648](https://aws.amazon.com/message/65648/) | [id=2473156](https://news.ycombinator.com/item?id=2473156) |
| S3 us-east-1 ("S3-pocalypse") | 2017-02-28 | A debugging-command **typo** removed too many servers; broke much of the web — and AWS's own status dashboard | [aws.amazon.com/message/41926](https://aws.amazon.com/message/41926/) | [id=13755673](https://news.ycombinator.com/item?id=13755673) (2,589 pts) |
| Kinesis us-east-1 | 2020-11-25 | New capacity pushed front-end servers past an OS thread limit; cascaded to Cognito, CloudWatch, Lambda | [aws.amazon.com/message/11201](https://aws.amazon.com/message/11201/) | [id=25209773](https://news.ycombinator.com/item?id=25209773) |
| us-east-1 networking | 2021-12-07 | Automated scaling overwhelmed internal networking; halted parts of Amazon's own warehouses/deliveries | [aws.amazon.com/message/12721](https://aws.amazon.com/message/12721/) | [id=29473630](https://news.ycombinator.com/item?id=29473630) (1,658 pts) |
| us-east-1 / DynamoDB DNS | 2025-10-20 | A race condition in DynamoDB's automated DNS management left an empty endpoint record; ~15 hrs of cascade | [aws.amazon.com/message/101925](https://aws.amazon.com/message/101925/) | [id=45640772](https://news.ycombinator.com/item?id=45640772) |

HN around milestones: **Lambda** [id=8602936](https://news.ycombinator.com/item?id=8602936) (526 pts); **Graviton/Arm** [id=18539297](https://news.ycombinator.com/item?id=18539297) (420 pts); **Annapurna** [id=8935574](https://news.ycombinator.com/item?id=8935574); **Bezos→exec-chairman / Jassy→CEO** [id=26006656](https://news.ycombinator.com/item?id=26006656) (1,941 pts); **Selipsky→Garman** [id=40355255](https://news.ycombinator.com/item?id=40355255). *(S3/EC2/SQS predate HN — no threads.)*

### Microsoft Azure — additions, outages & HN

Corroborated; nuances: GitHub was **announced 2018-06-04, closed October 2018**; Nuance **closed 2022-03-04**; the "cloud-first, mobile-first" framing is Nadella's first months (March 2014), not the Feb 4 appointment itself.

| Outage | Date | What happened | Source | HN |
|---|---|---|---|---|
| Leap-year ("Feb 29") | 2012-02-29 | Expired transfer certs with a **leap-day date-math bug** cascaded; ~8h down | [The Register](https://www.theregister.co.uk/2012/02/29/windows_azure_outage/) | [id=3647611](https://news.ycombinator.com/item?id=3647611) (151 pts) |
| Azure Storage global | 2014-11-18 | A perf-update config change was wrongly enabled for Blob front-ends, triggering an infinite loop; broad multi-region outage (human error) | [Azure final RCA](https://azure.microsoft.com/en-us/blog/final-root-cause-analysis-and-improvement-areas-nov-18-azure-storage-service-interruption/) | [id=8627630](https://news.ycombinator.com/item?id=8627630) (168 pts) |
| M365 / Azure AD auth | 2020-09-28 | An Azure AD change broke authentication; rollback initially failed | [ZDNet](https://www.zdnet.com/article/office-365-outage-ongoing-after-roll-back-fails/) | [id=24621746](https://news.ycombinator.com/item?id=24621746) (236 pts) |
| M365 / Azure global (WAN) | 2023-01-25 | A WAN router IP-change command forced every router to recompute forwarding tables; ~5.5h of worldwide connectivity loss | [The Register](https://www.theregister.com/2023/01/25/network_issues_causing_outage_in/) | [id=34515566](https://news.ycombinator.com/item?id=34515566) (300 pts) |
| Azure / M365 DDoS-defense | 2024-07-30 | A DDoS spike **plus an error in Microsoft's own DDoS defense** amplified the impact | [SecurityWeek](https://www.securityweek.com/microsoft-says-azure-outage-caused-by-ddos-attack-response/) | [id=41109047](https://news.ycombinator.com/item?id=41109047) |

HN around milestones: **Windows Azure announced** [id=345226](https://news.ycombinator.com/item?id=345226) (2008); **Azure GA** [id=1094367](https://news.ycombinator.com/item?id=1094367) (2010, tiny); **Microsoft buys GitHub** [id=17221527](https://news.ycombinator.com/item?id=17221527) (**2,873 pts** — one of HN's biggest); **Nuance** [id=26778780](https://news.ycombinator.com/item?id=26778780) (658 pts).

### Google Cloud — additions, outages & HN

Corroborated; additions: **Kubernetes** open-sourced June 2014, **GKE** GA late-2015; **Snap's** 2017 S-1 disclosed a **5-year, ≥$2B GCP commitment**; the **Bebop** price (~$380M) included Diane Greene **donating her ~$148M share**; Google first approached **Wiz at ~$23B in 2024** (Wiz walked away to pursue an IPO) before the 2025 ~$32B deal.

| Outage | Date | What happened | Source | HN |
|---|---|---|---|---|
| GCE global networking | 2016-04-11 | All Compute Engine external networking lost ~18 min; notable for a transparent public post-mortem | [Google post-mortem](https://status.cloud.google.com/incident/compute/16007) | [id=11489791](https://news.ycombinator.com/item?id=11489791) (799 pts) |
| GCP / Google network | 2019-06-02 | A config change cascaded into US network congestion; degraded GCP, YouTube, Gmail, Snapchat ~4h | [Wired](https://www.wired.com/story/google-cloud-outage-catch-22/) | [id=20077421](https://news.ycombinator.com/item?id=20077421) (1,395 pts) |
| Global auth outage | 2020-12-14 | An internal auth storage-quota issue took down Google's authenticated services worldwide ~45 min | [The Verge](https://www.theverge.com/2020/12/14/22173803/gmail-youtube-google-assistant-docs-down-outage) | [id=25415989](https://news.ycombinator.com/item?id=25415989) (2,316 pts) |
| Cloud / IAM control-plane | 2025-06-12 | A bad automated quota/policy update in Service Control caused a global control-plane outage cascading to Cloudflare, Spotify, etc. | [Google incident](https://status.cloud.google.com/incidents/ow5i3PPK96RduMcb1SsW) | [id=44260810](https://news.ycombinator.com/item?id=44260810) (1,468 pts) |
| UniSuper account deletion | 2024-05-09 | A Google Cloud **misconfiguration deleted a A$135B pension fund's entire subscription**; week-long restore from backups | [The Guardian](https://www.theguardian.com/australia-news/article/2024/may/09/unisuper-google-cloud-issue-account-access) | [id=40304666](https://news.ycombinator.com/item?id=40304666) |

HN around milestones: **App Engine launch** [id=157443](https://news.ycombinator.com/item?id=157443) (2008); **Compute Engine** [id=4172922](https://news.ycombinator.com/item?id=4172922) (448 pts); **Greene/Bebop** [id=10597896](https://news.ycombinator.com/item?id=10597896); **Looker** [id=20114214](https://news.ycombinator.com/item?id=20114214) (360 pts); **Mandiant** [id=30598841](https://news.ycombinator.com/item?id=30598841) (353 pts); **Wiz $32B** [id=43398518](https://news.ycombinator.com/item?id=43398518) (608 pts; the 2024 deal-collapse thread [id=41042034](https://news.ycombinator.com/item?id=41042034)).

### Oracle Cloud — additions, outages & HN

Corroborated; nuances/additions: bare-metal IaaS **GA October 2016**; Autonomous Database **announced Oct 2017, GA 2018**; Kurian's leave was announced **~Sept 5, 2018** and his resignation effective **Sept 28, 2018**; the **OCI Always Free** tier launched **Sept 2019**, and the **free Ampere Arm A1** instances (2021) became a cult HN favorite; **Stargate** (OpenAI/Oracle/SoftBank, up to $500B) was announced **2025-01-21**.

| Outage / incident | Date | What happened | Source | HN |
|---|---|---|---|---|
| Oracle Cloud (OCI Classic / SSO) breach | 2025 (disclosed Mar) | Actor "rose87168" claimed ~6M SSO/LDAP records via an unpatched Access Manager endpoint (CVE-2021-35587); Oracle initially denied, then privately confirmed | [The Register](https://www.theregister.com/2025/04/08/oracle_cloud_compromised/) | [id=43486945](https://news.ycombinator.com/item?id=43486945) (347 pts) |
| Oracle Health (Cerner) breach | 2025 (found Feb 20) | Stolen credentials accessed legacy Cerner data-migration servers, exposing US hospital patient data | [BleepingComputer](https://www.bleepingcomputer.com/news/security/oracle-health-breach-compromises-patient-data-at-us-hospitals/) | [id=43540814](https://news.ycombinator.com/item?id=43540814) |

*Could not verify* a single famous OCI **region** outage with a high-signal HN thread comparable to AWS's us-east-1 events. HN around milestones: **Ellison's "cloud nonsense" rant** [id=854696](https://news.ycombinator.com/item?id=854696); **Kurian→Google** [id=18470386](https://news.ycombinator.com/item?id=18470386); **free Ampere Arm instances** [id=29513946](https://news.ycombinator.com/item?id=29513946) (162 pts — the most-discussed OCI-free-tier thread); **TikTok deal** [id=24472181](https://news.ycombinator.com/item?id=24472181); **Stargate $500B** [id=42785891](https://news.ycombinator.com/item?id=42785891) (1,021 pts). *(The Gen 2 launch itself drew no major HN thread.)*

### Alibaba Cloud — additions, outages & HN

Corroborated; additions: the "**de-IOE**" idea was proposed by Wang Jian **~2008** (the May 2013 last-IBM-server retirement was its symbolic completion); the **"5K"** Apsara cluster milestone was **2013-08-15**; the **$1B** Aliyun injection was **July 2015** (Singapore HQ/DC followed Aug 2015); Alibaba launched the **Qwen (通义千问)** LLM in 2023 and open-sourced Qwen-7B (Aug 2023); on Singles' Day 2019 Apsara peaked at **544,000 orders/second**.

| Outage | Date | What happened | Source | HN |
|---|---|---|---|---|
| Hong Kong (Zone C) | 2022-12-18 | A data-center **cooling failure** triggered fire-suppression; ~10–12h down (Alibaba's longest large-scale outage in over a decade); hit OKX, Macao Monetary Authority | [The Register](https://www.theregister.com/2022/12/20/alibaba_cloud_hong_kong_outage/) | [id=34171802](https://news.ycombinator.com/item?id=34171802) (minimal) |
| Major global outage | 2023-11-12 | An unprecedented **simultaneous anomaly across all global regions** (console + API) ~3.5h; Taobao, DingTalk, Xianyu crashed | [TechNode](https://technode.com/2023/11/13/alibaba-cloud-suffers-second-outage-in-a-year-causing-major-apps-to-crash/) | *No substantive HN thread (honest absence)* |
| Second outage in a month | 2023-11-27 | A second disruption (database/auth-related) weeks after the Nov 12 event | [DCD](https://www.datacenterdynamics.com/en/news/alibaba-cloud-hit-by-outage-second-in-a-month/) | [id=38443602](https://news.ycombinator.com/item?id=38443602) (minimal) |

HN around milestones: **Ant IPO suspended** [id=24979327](https://news.ycombinator.com/item?id=24979327) (238 pts) and the **Xi-halted-IPO** thread [id=25084953](https://news.ycombinator.com/item?id=25084953) (570 pts); **MIIT pulls support over Log4j disclosure** [id=29658342](https://news.ycombinator.com/item?id=29658342) (316 pts); **GPU-pooling "cut Nvidia use 82%"** [id=45643163](https://news.ycombinator.com/item?id=45643163) (523 pts); **$1B Aliyun** [id=9971282](https://news.ycombinator.com/item?id=9971282). *The de-IOE/Apsara story and the Nov 12 2023 outage have **no notable English-language HN discussion** — honest absences.*

---

## Recurring patterns across the clouds

1. **The ex-AWS diaspora seeded the competition.** The very engineers who built EC2 —
   **Chris Pinkham & Willem van Biljon** — founded Nimbula, which **Oracle bought** and
   folded into its cloud; and OCI Gen 2 was built by ex-AWS/Microsoft engineers
   (**Don Johnson**, **Clay Magouyrk**, Deepak Patil). An ex-AWS engineer (Magouyrk) now
   **co-runs Oracle**; another (Johnson) left in 2025 to become **CEO of Docker**. AWS was
   not just a product but a talent factory for its rivals.
2. **Cloud became the path to the CEO chair.** **Andy Jassy** (AWS → Amazon CEO) and
   **Satya Nadella** (Server & Tools/cloud → Microsoft CEO) both rode the cloud business
   to the top job — a signal of how central cloud became to each parent company.
3. **The single most dramatic executive move:** **Thomas Kurian**, Oracle's product chief,
   leaving (reportedly over Ellison's refusal to run Oracle software on rival clouds) to
   **run Google Cloud** — the leadership of one cloud literally crossing to another.
4. **Acquisition-driven vs organic.** **Oracle** assembled its cloud by buying (Sun,
   Nimbula, NetSuite, Dyn, Ravello, Cerner). **Google** bought its way into BI and
   security (Apigee, Looker, Mandiant, Siemplify, and the $32B **Wiz**). **AWS** and
   **Alibaba** grew mostly **organically** — AWS's pivotal exception being **Annapurna**
   (custom silicon), Alibaba's being essentially none (Apsara + "de-IOE" were in-house).
5. **The skeptic-to-believer arc.** **Larry Ellison** publicly mocked "cloud computing"
   in 2008–2009, then built the "Generation 2 Cloud" — the loudest doubter became a
   late, aggressive builder.
6. **Custom silicon as a moat.** AWS's Annapurna buy (2015) → Nitro/Graviton/Trainium is
   the clearest case of a cloud turning an acquisition into a durable hardware advantage.
7. **Geopolitics is a first-class force for Alibaba.** US chip **export controls killed
   the 2023 cloud spin-off**, and founder **Jack Ma's** political risk (the halted Ant
   IPO) directly shaped the company — a dimension absent from the US clouds.

---

## Sourcing notes & "could not verify"

Per the corpus's strict-sourcing rule, these were explicitly **not** asserted as fact:
- AWS: precise title/tenure sequence for **Al Vermeulen**; the exact Elemental price (press said "~$500M," Crunchbase ~$296M total — both shown); undisclosed prices for Sqrrl/TSO Logic/E8/Wickr.
- Azure: most acquisition prices were undisclosed (Cloudyn ~$50M, Affirmed ~$1.35B were *press* figures); no primary-sourced Azure role for **Qi Lu**, so omitted.
- Google: exact "Google Cloud Platform" brand-introduction date; **Paul McDonald**'s specific App Engine role; undisclosed prices (Alooma/Elastifile/Siemplify shown as *reported*).
- Oracle: the "**400 ex-AWS engineers**" figure (used the sourced "several hundred from Amazon/Microsoft/Google" quote instead); **Hari Rajaram** as a named OCI founder (omitted); Ravello/Dyn/Nimbula prices (reported/undisclosed); the "water vapor" line (a paraphrase, not an Ellison quote).
- Alibaba: the exact **founding day** (Sept 10, 2009 widely cited; only "September 2009" anchored); the precise US-datacenter launch month; the exact date Alibaba Cloud first became #1 in China/APAC. (SEC 6-K primaries returned 403; CNBC/SCMP/Business Wire and Alibaba's own blog were used instead.)
