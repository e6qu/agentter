# Ceph — A Sourced History

**Ceph** is an open-source, software-defined **distributed storage system** that
delivers **object, block, and file storage from a single unified cluster** running on
commodity hardware. Its foundation is **RADOS** (the Reliable Autonomic Distributed
Object Store), on top of which sit three access layers: **RBD** (block), **CephFS**
(POSIX file), and the **RADOS Gateway / RGW** (object, exposing **Amazon S3-** and
**OpenStack Swift-compatible** APIs). Data placement is computed — not looked up — by the
**CRUSH** algorithm.

> Ceph "uniquely delivers object, block, and file storage in one unified system."
> — Ceph architecture documentation, https://docs.ceph.com/en/latest/architecture/

Ceph began as **Sage Weil's PhD research at the University of California, Santa Cruz**
(~2004–2007), was open-sourced, merged into the Linux kernel in 2010, commercialized via
**Inktank** (2012), acquired by **Red Hat** (2014), governed under the **Linux
Foundation** as the **Ceph Foundation** (2018), and transferred — along with Red Hat's
Ceph team — to **IBM** (2022–2023), where it is now sold as **IBM Storage Ceph**.

### Cross-references (not duplicated here)

- **S3-compatible object storage** — Ceph's RADOS Gateway (RGW) is one of the leading
  self-hosted S3-compatible implementations. For the broader history of the S3 API and
  its ecosystem of compatible implementations, see `history/s3-object-storage.md`.
- **OpenStack** — Ceph is the de-facto storage backend for OpenStack (Cinder block,
  Glance images, and an alternative to Swift for objects). For OpenStack's own history
  and its orchestration program, see `history/openstack-heat.md`.

---

## Timeline

### 2004–2007 — Origins: a UC Santa Cruz PhD project

- **2004** — The first line of code that became Ceph was written by **Sage Weil** during
  a summer internship at **Lawrence Livermore National Laboratory (LLNL)**.
  Source: https://en.wikipedia.org/wiki/Ceph_(software)
- **2004** — An early related paper, **"Dynamic Metadata Management for Petabyte-Scale
  File Systems,"** by Sage Weil, Kristal Pollack, Scott A. Brandt, and Ethan L. Miller,
  appeared at SC '04 — foundational work for Ceph's metadata design.
  Source: https://ceph.com/publications/
- Ceph was created as **Sage Weil's doctoral research at UC Santa Cruz**, advised by
  Professor **Scott A. Brandt**, within the **Storage Systems Research Center (SSRC)**.
  Sources: https://en.wikipedia.org/wiki/Ceph_(software) ,
  https://en.wikipedia.org/wiki/Sage_Weil
- **The name "Ceph"** is a shortened form of **"cephalopod"**; per Wikipedia, the name
  (and the octopus logo) "suggests the highly parallel behavior of an octopus and was
  chosen to associate the file system with **'Sammy', the banana slug mascot of UCSC**."
  Source: https://en.wikipedia.org/wiki/Ceph_(software)
- **November 2006** — Ceph debuted publicly through two papers presented at major
  conferences:
  - **"Ceph: A Scalable, High-Performance Distributed File System"** — Sage A. Weil,
    Scott A. Brandt, Ethan L. Miller, Darrell D. E. Long, Carlos Maltzahn — at the
    **7th USENIX Symposium on Operating Systems Design and Implementation (OSDI '06)**,
    Seattle, WA.
    Sources: https://www.ssrc.ucsc.edu/Papers/weil-osdi06.pdf , https://ceph.com/publications/
  - **"CRUSH: Controlled, Scalable, Decentralized Placement of Replicated Data"** —
    Sage A. Weil, Scott A. Brandt, Ethan L. Miller, Carlos Maltzahn — at **SC '06**
    (the ACM/IEEE Supercomputing conference). **CRUSH** = *Controlled Replication Under
    Scalable Hashing*.
    Sources: https://ceph.com/assets/pdfs/weil-crush-sc06.pdf , https://dl.acm.org/doi/10.1145/1188455.1188582
- **2007** — The **RADOS** paper, **"RADOS: A Fast, Scalable, and Reliable Storage
  Service for Petabyte-scale Storage Clusters,"** by Sage A. Weil, Andrew W. Leung,
  Scott A. Brandt, and Carlos Maltzahn, appeared at the Petascale Data Storage Workshop
  (PDSW '07, at SC07).
  Source: https://ceph.com/publications/
- **2007** — Weil completed his **PhD thesis**, *"Ceph: Reliable, Scalable, and
  High-Performance Distributed Storage,"* University of California, Santa Cruz. (The
  thesis is dated 2007; the core OSDI/CRUSH papers were published in 2006, mid-PhD.)
  Sources: https://ceph.com/publications/ , https://en.wikipedia.org/wiki/Sage_Weil

### 2010 — Into the Linux kernel

- **March 19, 2010** — **Linus Torvalds merged the Ceph client (the CephFS kernel
  client) into the Linux kernel**, in version **2.6.34**, which was **released on
  May 16, 2010**. This put a native Ceph filesystem client into the mainline kernel.
  Source: https://en.wikipedia.org/wiki/Ceph_(software)

### 2012 — Commercialization: DreamHost incubation → Inktank

- After his PhD, Weil's Ceph work continued under the umbrella of **DreamHost** (the
  web-hosting company he co-founded in 1997 with fellow Harvey Mudd students), which
  funded and incubated Ceph development; DreamHost's object-storage product
  **DreamObjects** is powered by Ceph.
  Sources: https://en.wikipedia.org/wiki/Sage_Weil ,
  https://www.dreamhost.com/news/press-releases/dreamhost-says-well-done-son-to-inktank-on-acquisition-by-red-hat/
- **May 2012** — Weil founded **Inktank Storage** to provide professional services and
  support for Ceph. The decision to spin out a dedicated Ceph company was made at the
  beginning of 2012 by Weil with co-founder **Bryan Bogensberger** (who became CEO and
  built the business plan) and DreamHost CEO Simon Anderson; **DreamHost was Inktank's
  first customer.** Inktank was **initially funded by DreamHost, with later investment
  from Mark Shuttleworth** (and, per some reports, Citrix).
  Sources: https://thenewstack.io/the-new-stack-makers-dreamhost-co-founder-sage-weil-on-ceph-software-defined-storage-and-getting-back-to-open-source/ ,
  https://en.wikipedia.org/wiki/Inktank_Storage , https://en.wikipedia.org/wiki/Sage_Weil
  - Note on dates: Wikipedia's *Sage Weil* article says Inktank was "founded in 2011,"
    while the *Inktank Storage* article and The New Stack place the founding in
    **May 2012** with planning beginning in early 2012. This history uses **2012** as
    the founding year, with the 2011 figure flagged as a discrepancy.
- **July 3, 2012** — First named stable release, **Argonaut (v0.48)** — the start of
  Ceph's alphabetical, cephalopod-themed release naming.
  Source: https://en.wikipedia.org/wiki/Ceph_(software)

### 2014 — Red Hat acquires Inktank

- **April 30, 2014** — **Red Hat announced a definitive agreement to acquire Inktank for
  approximately $175 million in cash** (subject to adjustments at closing), with the deal
  expected to close in May 2014. Inktank's flagship product was **Inktank Ceph
  Enterprise**, and the press release noted Inktank's many "early adopters of OpenStack
  clouds." Combined with Red Hat's existing **GlusterFS**-based storage, the deal
  positioned Red Hat as a leader in open software-defined object, block, and file
  storage.
  Sources: https://www.redhat.com/en/about/press-releases/red-hat-acquire-inktank-provider-ceph ,
  https://techcrunch.com/2014/04/30/red-hat-buys-ceph-provider-inktank-for-175m-in-cash-to-beef-up-its-cloud-storage-offerings/
  > Sage Weil (Inktank founder and CTO): "Joining Red Hat will no doubt lead to
  > tremendous innovation that will ultimately serve the industry well."
  > Source: https://www.redhat.com/en/about/press-releases/red-hat-acquire-inktank-provider-ceph
- The acquisition had **UC Santa Cruz roots**, as covered by the university's news desk.
  Source: https://news.ucsc.edu/2014/04/ceph-inktank/
- Ceph was subsequently productized as **Red Hat Ceph Storage**.
  Source: https://en.wikipedia.org/wiki/Ceph_(software)

### 2014–2018 — OpenStack adoption and the unified-storage era

- Ceph became the **de-facto storage backend for OpenStack**, providing block storage to
  **Cinder**, image storage to **Glance** (images stored as Ceph block devices), and —
  via RGW — an object-storage alternative to **Swift**. The **April 2016 OpenStack User
  Survey** showed **Ceph at 57% of OpenStack storage**, far ahead of LVM (28%) and
  NetApp (9%).
  Sources: https://superuser.openinfra.org/articles/ceph-as-storage-for-openstack/ ,
  https://docs.ceph.com/en/reef/rbd/rbd-openstack/
  (For OpenStack's own history, see `history/openstack-heat.md`.)

### 2018 — The Ceph Foundation (under the Linux Foundation)

- **November 12, 2018** — **The Linux Foundation launched the Ceph Foundation**, a
  directed fund under the Linux Foundation, as a successor to the Ceph Community Advisory
  Board, with **30+** founding members. Founding **Premier** members included **Canonical,
  China Mobile, DigitalOcean, Intel, OVH, ProphetStor, Red Hat, SoftIron, SUSE, Western
  Digital, XSKY, ZTE, and Amihan**; general members included **Arm, Croit, EasyStack,
  QCT**, and others. The foundation organizes and distributes financial contributions to
  the project in a vendor-neutral fashion.
  Sources: https://www.linuxfoundation.org/press/press-release/the-linux-foundation-launches-ceph-foundation ,
  https://ceph.io/en/news/blog/2018/announce-the-ceph-foundation/ ,
  https://techcrunch.com/2018/11/12/the-ceph-storage-project-gets-a-dedicated-open-source-foundation/

### 2019 — IBM acquires Red Hat

- IBM's **$34 billion acquisition of Red Hat** closed in **July 2019**, bringing Red Hat
  (and therefore Red Hat Ceph Storage) under IBM ownership — the corporate precondition
  for Ceph's later move into IBM's storage business unit.
  Source: https://web.archive.org/web/2id_/https://newsroom.ibm.com/2019-07-09-IBM-Closes-Landmark-Acquisition-of-Red-Hat-for-34-Billion-Defines-Open-Hybrid-Cloud-Future
  *(Could not verify the exact close date against a Ceph-specific source; date above is
  from IBM's own newsroom announcing the close on July 9, 2019.)*

### 2021 — Sage Weil steps back from the project

- **2020** — Weil took a **leave of absence** (during the Pacific development cycle) to
  work on democracy/voting efforts, including with **VoteAmerica**.
  Sources: https://www.bu.edu/rhcollab/2021/04/08/colloquium-pause-for-democracy-leaving-open-source-storage-to-help-americans-vote-in-2020/ ,
  https://ceph.io/en/news/blog/2021/community-newsletter-november/
- **November 4, 2021** — The Ceph community newsletter announced that **"Sage Weil, the
  creator of Ceph, is stepping back from his leadership role after 17 years."** He planned
  to **contribute as a developer in the short term but to leave Red Hat in December**
  [2021].
  Source: https://ceph.io/en/news/blog/2021/community-newsletter-november/
  > "Sage will contribute as a developer for the short term but plans to leave Red Hat in
  > December." — Ceph Community Newsletter, November 2021
- To distribute Sage's responsibilities, the project introduced the **Ceph Executive
  Council**. The **first elected members were Josh Durgin, Neha Ojha, and Dan van der
  Ster.**
  Source: https://ceph.io/en/news/blog/2021/community-newsletter-november/

### 2022–2023 — The IBM era: "IBM Storage Ceph"

- **October 4, 2022** — IBM and Red Hat jointly announced that **Red Hat's storage
  portfolio and teams — including Red Hat Ceph Storage, Red Hat OpenShift Data Foundation
  (ODF), Rook, and NooBaa — would move to the IBM Storage business unit**, with the
  transaction expected to **complete by January 1, 2023**. **IBM assumed Red Hat's
  sponsorship of the Ceph Foundation** and committed to support Ceph's upstream test lab.
  Sources: https://newsroom.ibm.com/2022-10-04-IBM-Redefines-Hybrid-Cloud-Application-and-Data-Storage-Adding-Red-Hat-Storage-to-IBM-Offerings ,
  https://ceph.io/en/news/blog/2022/red-hats-ceph-team-is-moving-to-ibm/
  > "This is great news for upstream Ceph! Our project's governance model and operation
  > stays the same. Ceph continues to be 100% open-source, and IBM will continue to
  > contribute with an upstream-first approach."
  > — Ceph Executive Council (Neha Ojha, Josh Durgin, Dan van der Ster),
  > https://ceph.io/en/news/blog/2022/red-hats-ceph-team-is-moving-to-ibm/
- **March 2023** — IBM launched **IBM Storage Ceph** as part of a broader storage-brand
  reboot (dropping the "Spectrum" prefix), positioning Ceph as the foundation of its
  software-defined storage platform; IBM announced GA of scalable object storage on
  Ceph around the **Data and Innovation Summit** (early March 2023).
  Sources: https://blocksandfiles.com/2023/03/02/ibm-storage-reboot/ ,
  https://community.ibm.com/community/user/storage/blogs/david-wohlford1/2023/03/09/ceph-storage
- Subsequent IBM Storage Ceph GA milestones: **Pro Edition 5.3.0** on **May 19, 2023**,
  and **Premium Edition 7.0.0** on **December 8, 2023**.
  Sources: https://web.archive.org/web/2id_/https://www.ibm.com/support/pages/ibm-storage-ceph-pro-edition530 ,
  https://www.ibm.com/support/pages/node/7090392
  *(Could not fully verify exact GA dates beyond IBM's own support pages; treat as
  vendor-reported.)*

---

## Release history

Ceph's stable releases are named alphabetically after cephalopods. Selected/major
releases (version and release date):

| Release | Version | Date |
|---|---|---|
| Argonaut | 0.48 | July 3, 2012 |
| Bobtail | 0.56 | January 1, 2013 |
| Cuttlefish | 0.61 | May 7, 2013 |
| Dumpling | 0.67 | August 14, 2013 |
| Emperor | 0.72 | November 9, 2013 |
| Firefly | 0.80 | May 7, 2014 |
| Giant | 0.87 | October 29, 2014 |
| Hammer | 0.94 | April 7, 2015 |
| Infernalis | 9.2.0 | November 6, 2015 |
| Jewel | 10.2.0 | April 21, 2016 |
| Kraken | 11.2.0 | January 20, 2017 |
| Luminous | 12.2.0 | August 29, 2017 |
| Mimic | 13.2.0 | June 1, 2018 |
| Nautilus | 14.2.0 | March 19, 2019 |
| Octopus | 15.2.0 | March 23, 2020 |
| Pacific | 16.2.0 | March 31, 2021 |
| Quincy | 17.2.0 | April 19, 2022 |
| Reef | 18.2.0 | August 3, 2023 |
| Squid | 19.2.0 | September 26, 2024 |
| Tentacle | 20.2.0 | November 18, 2025 |

Source (full release table): https://en.wikipedia.org/wiki/Ceph_(software)

As of this writing (May 2026), **Squid (19.2.x)** and **Tentacle (20.2.x)** are the most
recent named release series; releases continue under the IBM-stewarded upstream project.

---

## Architecture (RADOS / CRUSH / RGW / RBD / CephFS)

All quotes below are from the Ceph architecture documentation,
https://docs.ceph.com/en/latest/architecture/ , unless otherwise noted.

- **RADOS (Reliable Autonomic Distributed Object Store)** is the foundation: "a reliable,
  distributed storage service that uses the intelligence in each of its nodes to secure
  the data it stores," forming "an infinitely scalable Ceph Storage Cluster." A RADOS
  cluster is built from **OSDs** (Object Storage Daemons, one per disk) coordinated by
  **monitors (MONs)**. Everything else in Ceph is a client of RADOS.
- **CRUSH (Controlled Replication Under Scalable Hashing)** is the deterministic data
  placement algorithm: "Ceph Clients and Ceph OSD Daemons both use the CRUSH algorithm to
  compute information about object location **instead of relying upon a central lookup
  table**." This decentralization "enables massive scale by distributing the work to all
  the OSD daemons in the cluster." CRUSH places replicas across the cluster's
  topology (hosts, racks, etc.) according to configurable rules. (Algorithm origin:
  the 2006 CRUSH/SC'06 paper, https://ceph.com/assets/pdfs/weil-crush-sc06.pdf .)
- **librados** is the native client library that exposes the RADOS object store; "a number
  of service interfaces [are] built on top of librados." The three higher-level access
  layers are:
  - **RBD (Ceph Block Device)** — block storage that "stripes a block device across the
    cluster for high performance," with thin-provisioned, snapshottable volumes. RBD is
    the layer OpenStack Cinder/Glance and hypervisors consume.
  - **CephFS** — a POSIX file system that "separates the metadata from the data, storing
    the metadata in the MDS [Metadata Server], and storing the file data in one or more
    objects." This is the layer whose kernel client was merged into Linux in 2010.
  - **RADOS Gateway (RGW)** — object storage exposing HTTP APIs: "The RADOS Gateway uses a
    unified namespace, which means you can use **either the OpenStack Swift-compatible API
    or the Amazon S3-compatible API**." RGW is a leading self-hosted **S3-compatible**
    implementation (see `history/s3-object-storage.md`).
- **"Unified storage"** — Ceph "uniquely delivers object, block, and file storage in one
  unified system," all backed by the same RADOS cluster.

---

## Key people & teams

- **Sage Weil** — creator of Ceph; wrote the first code in 2004 at LLNL; built Ceph as his
  **UC Santa Cruz PhD** (advisor **Scott A. Brandt**; thesis 2007). Co-founder of
  **DreamHost** (1997) and founder of **Inktank** (2012); became Red Hat's chief architect
  for Ceph after the 2014 acquisition; **stepped back from project leadership in November
  2021** and left Red Hat at the end of 2021. He has since focused on democracy/voting work
  (VoteAmerica) and other ventures.
  Sources: https://en.wikipedia.org/wiki/Sage_Weil ,
  https://ceph.io/en/news/blog/2021/community-newsletter-november/
- **UC Santa Cruz co-authors / advisors** — **Scott A. Brandt, Ethan L. Miller,
  Darrell D. E. Long, Carlos Maltzahn** (co-authors of the OSDI '06 / CRUSH papers via the
  Storage Systems Research Center). Weil later endowed the **Sage Weil Presidential Chair
  for Open Source Software** at UCSC with a **$3 million** gift in **May 2015**.
  Sources: https://ceph.com/publications/ , https://news.ucsc.edu/2015/05/sage-weil-gifts/
- **Bryan Bogensberger** — co-founder and CEO of Inktank (business plan and go-to-market).
  Source: https://thenewstack.io/the-new-stack-makers-dreamhost-co-founder-sage-weil-on-ceph-software-defined-storage-and-getting-back-to-open-source/
- **Ceph Executive Council** — the post-2021 leadership body that distributed Sage Weil's
  responsibilities; first members **Josh Durgin, Neha Ojha, and Dan van der Ster**.
  Source: https://ceph.io/en/news/blog/2021/community-newsletter-november/

---

## Company & corporate history

- **DreamHost (1997– )** — Web hosting company co-founded by Sage Weil; incubated and
  funded early Ceph development, and runs **DreamObjects** on Ceph.
  Sources: https://en.wikipedia.org/wiki/Sage_Weil ,
  https://www.dreamhost.com/news/press-releases/dreamhost-says-well-done-son-to-inktank-on-acquisition-by-red-hat/
- **Inktank Storage (2012–2014)** — Spun out of DreamHost to commercialize Ceph
  (professional services, support, and **Inktank Ceph Enterprise**). Funded by DreamHost
  with later investment from Mark Shuttleworth (and reportedly Citrix).
  Sources: https://en.wikipedia.org/wiki/Inktank_Storage ,
  https://thenewstack.io/the-new-stack-makers-dreamhost-co-founder-sage-weil-on-ceph-software-defined-storage-and-getting-back-to-open-source/
- **Red Hat (2014–2022)** — Acquired Inktank on **April 30, 2014** for **~$175M**;
  productized Ceph as **Red Hat Ceph Storage**; brought the majority of Ceph development
  in-house.
  Sources: https://www.redhat.com/en/about/press-releases/red-hat-acquire-inktank-provider-ceph ,
  https://en.wikipedia.org/wiki/Ceph_(software)
- **Linux Foundation / Ceph Foundation (2018– )** — Vendor-neutral governance and funding
  vehicle launched **November 12, 2018** with 30+ members.
  Source: https://www.linuxfoundation.org/press/press-release/the-linux-foundation-launches-ceph-foundation
- **IBM (2019/2022– )** — IBM acquired Red Hat (closed **July 2019**); on **October 4,
  2022** IBM and Red Hat announced the transfer of Red Hat's storage portfolio and Ceph
  team to the **IBM Storage** business unit (expected complete **Jan 1, 2023**); IBM
  assumed the Ceph Foundation sponsorship and launched **IBM Storage Ceph** in 2023, while
  pledging to keep the project 100% open-source and upstream-first.
  Sources: https://newsroom.ibm.com/2022-10-04-IBM-Redefines-Hybrid-Cloud-Application-and-Data-Storage-Adding-Red-Hat-Storage-to-IBM-Offerings ,
  https://ceph.io/en/news/blog/2022/red-hats-ceph-team-is-moving-to-ibm/

---

## Items not fully verified

- **Inktank founding year** — Wikipedia's *Sage Weil* article says "2011," while the
  *Inktank Storage* article and The New Stack say **May 2012** (planning began early
  2012). Resolved in favor of **2012** here, with the discrepancy flagged.
- **IBM–Red Hat close date (July 2019)** — Verified from IBM's own newsroom, not from a
  Ceph-specific source. **Could not verify** an exact date tied directly to Ceph.
- **IBM Storage Ceph GA dates (Pro 5.3.0 = May 19, 2023; Premium 7.0.0 = Dec 8, 2023)** —
  Sourced only to IBM support pages; treat as vendor-reported. **Could not verify** via an
  independent third party.
- **DreamHost's exact role/dates in "incubating" post-PhD Ceph development** — well
  attested in general (DreamObjects, funding Inktank) but the precise internal timeline of
  Ceph-at-DreamHost between ~2007 and 2012 **could not be pinned to a single authoritative
  dated source**.
