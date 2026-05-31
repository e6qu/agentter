# OpenStack Heat — A Sourced History

OpenStack **Heat** is OpenStack's **Orchestration** program/service. It lets users
describe a collection of cloud resources (servers, volumes, floating IPs, networks,
software, etc.) in a declarative text template and then create, update, and tear them
down as a single "stack" — i.e. *infrastructure as code* for OpenStack clouds. Heat was
explicitly designed to be **AWS CloudFormation-compatible** (so existing CFN templates
could be consumed) while also introducing OpenStack's own native template format,
**HOT (Heat Orchestration Template)**, written in YAML. It is sometimes described as the
"CloudFormation for private clouds."

> Heat is "a service to orchestrate multiple composite cloud applications using
> templates, through both an OpenStack-native REST API and a CloudFormation-compatible
> Query API."
> — Heat README / OpenStack wiki, https://github.com/openstack/heat and https://wiki.openstack.org/wiki/Heat

---

## Context: OpenStack itself

- **July 2010** — Rackspace Hosting and NASA announced an open-source cloud-software
  initiative known as OpenStack.
  Source: https://en.wikipedia.org/wiki/OpenStack
- **21 October 2010** — OpenStack's first official release, code-named **Austin**, appeared.
  Source: https://en.wikipedia.org/wiki/OpenStack
- **September 2012** — The **OpenStack Foundation**, a non-profit corporate entity, was
  established to promote the software and community.
  Source: https://en.wikipedia.org/wiki/OpenStack
- **19 October 2020** — The OpenStack Foundation announced it would be renamed the
  **Open Infrastructure Foundation (OpenInfra)**, becoming fully operational on
  1 January 2021. The change reflected a broader scope beyond OpenStack (Airship, Kata
  Containers, StarlingX, Zuul, etc.).
  Sources: https://techcrunch.com/2020/10/19/the-openstack-foundation-becomes-the-open-infrastructure-foundation/ ,
  https://www.prnewswire.com/news-releases/openstack-foundation-announces-corporate-name-change-to-open-infrastructure-foundation-to-reflect-broader-commitment-to-open-source-software-301155690.html ,
  https://en.wikipedia.org/wiki/OpenStack

---

## Timeline

### 2012 — Origins (pre-incubation)

- **30 August 2012** — Steven Dake (then at Red Hat) presented "Heat API: OpenStack /
  AWS CloudFormation Orchestration" at **CloudOpen** (Thursday, 30 August 2012),
  evidencing Heat's existence as an early effort to bring CloudFormation-style
  orchestration to OpenStack.
  Source: https://dokumen.tips/documents/openstack-aws-cloudformation-orchestration-heat-api-openstack-aws-cloudformation.html
- **28 September 2012** — At the time of OpenStack's **Folsom** release, *The Register*
  reported that "The 'Heat' cloud orchestration and 'Ceilometer' metering projects have
  not yet been formally added to the OpenStack project, but that could happen between now
  and next April." So Heat existed as a project but was **not yet an official/integrated
  OpenStack project** in September 2012.
  Source: https://www.theregister.com/2012/09/28/openstack_folsom_released/
- **8 October 2012** — The Heat project was **registered on Launchpad by Steven Dake**.
  Launchpad describes it as an "Orchestration service for OpenStack" that "provisions
  resources such as OpenStack servers, volumes, floating IPs, and Linux applications into
  a running cloud stack based on a declarative template."
  Source: https://launchpad.net/heat
- **~October 2012 (Grizzly Design Summit, San Diego)** — Heat was discussed at the
  OpenStack Design Summit in San Diego (mid-October 2012). Steven Dake gave a talk,
  "Heat: A template based orchestration engine for OpenStack," at the San Diego 2012
  summit.
  Sources: https://www.theregister.com/2012/09/28/openstack_folsom_released/ ,
  https://www.openstack.org/videos/san-diego-2012/heat-a-template-based-orchestration-engine-for-openstack
- **Creator / early lead:** Steven Dake is widely credited with inventing OpenStack Heat
  and served as its initial Project Technical Lead (PTL). (See *Key people & teams* below
  for the verification caveat on which release cycles he led.)
  Sources: https://launchpad.net/heat , https://github.com/sdake

### 2013 — Incubation → Integration

- **Grizzly cycle (development through ~April 2013)** — Heat (along with the metering
  project Ceilometer) was **brought into the OpenStack incubation process during the
  Grizzly release** cycle.
  Sources: https://opensource.com/business/14/6/incubation-integration-openstack ,
  https://wiki.openstack.org/wiki/Heat (project history)
- **February 2013** — Heat and Ceilometer **graduated from Incubation to Integrated
  status**. Per the Foundation's Incubation update: "Ceilometer and Heat were recently
  graduated from Incubation and are considered Integrated projects," with the graduation
  noted as occurring "in February" (the update document is dated 3 April 2013). The two
  projects were to be branded **OpenStack Metering** and **OpenStack Orchestration**
  starting with the Havana cycle.
  Source: https://wiki.openstack.org/wiki/Governance/Foundation/IncubationUpdate2013
- **Grizzly release (the release itself shipped April 2013)** — Heat's release history on
  releases.openstack.org lists **Grizzly** as the earliest release series it participated
  in.
  Source: https://releases.openstack.org/teams/heat.html

### 17 October 2013 — Havana: Heat becomes an official integrated OpenStack project

- **17 October 2013** — Heat shipped as part of the **Havana** release as the fully
  integrated **OpenStack Orchestration** service. Wikipedia's OpenStack release table
  records Heat as first appearing in the Havana release on 17 October 2013, described as
  "a service to orchestrate multiple composite cloud applications using templates, through
  both an OpenStack-native REST API and a CloudFormation-compatible Query API."
  Sources: https://en.wikipedia.org/wiki/OpenStack ,
  https://wiki.openstack.org/wiki/Governance/Foundation/IncubationUpdate2013

> Note on terminology: incubation began during the **Grizzly** cycle (2012–early 2013),
> graduation to Integrated status occurred in **February 2013**, and Heat first shipped as
> an integrated component in the **Havana** release (17 October 2013). Different sources
> emphasize different points in this sequence; all three are consistent.

### CloudFormation compatibility & the HOT format

- Heat provides **two template paths**:
  1. An **AWS CloudFormation-compatible** template format and Query API. The
     `heat-api-cfn` component "provides an AWS-style Query API that is compatible with AWS
     CloudFormation." Heat "endeavours to provide compatibility with the AWS
     CloudFormation template format, so that many existing CloudFormation templates can be
     launched on OpenStack."
     Sources: https://wiki.openstack.org/wiki/Heat ,
     https://docs.openstack.org/heat/train/developing_guides/architecture.html
  2. The **native HOT (Heat Orchestration Template)** format, a YAML-based format usable
     only with OpenStack. HOT is **not** backwards-compatible with AWS CloudFormation
     templates.
     Source: https://docs.openstack.org/heat/yoga/template_guide/cfn.html
- Practical compatibility caveat: while Heat reproduces the CloudFormation *format*, the
  set of available *resources* differs between AWS and OpenStack, so many CFN templates
  need modification (or use resources that are incomplete/absent in Heat).
  Sources: https://docs.openstack.org/heat/yoga/template_guide/cfn.html ,
  https://medium.com/@gcoleman/is-openstack-heat-really-compatible-with-cloudformation-4c5378336b78 ,
  https://blog.scottlowe.org/2014/05/01/an-introduction-to-openstack-heat/

### 2014 onward — Continued releases

- Heat shipped in every subsequent OpenStack release series after Havana: Icehouse, Juno,
  Kilo, Liberty, Mitaka, Newton, Ocata, Pike, Queens, Rocky, Stein, Train, Ussuri,
  Victoria, Wallaby, Xena, Yoga, Zed, then the year-based names Antelope (2023.1), Bobcat
  (2023.2), Caracal (2024.1), Dalmatian (2024.2), Epoxy (2025.1), Flamingo (2025.2), and
  Gazpacho (2026.1).
  Source: https://releases.openstack.org/teams/heat.html

### Current status (as of 2026)

- Heat remains an **official, actively maintained OpenStack project** under the Open
  Infrastructure Foundation. Its OpenStack Technical Committee governance page lists it as
  a current Orchestration service with an active PTL and ~11 deliverables (heat,
  python-heatclient, heat-agents, heat-cfntools, os-apply-config, os-collect-config,
  os-refresh-config, heat-dashboard, heat-specs, heat-tempest-plugin, heat-templates,
  yaql). The governance page was last updated 19 May 2026.
  Source: https://governance.openstack.org/tc/reference/projects/heat.html
- Recent releases include 23.0.0 (October 2024), 24.0.0 (April 2025), 25.0.0 (October
  2025), and 26.0.0 (April 2026), with active stable branches.
  Sources: https://releases.openstack.org/teams/heat.html ,
  https://docs.openstack.org/releasenotes/heat/ ,
  https://opendev.org/openstack/heat
- Decline context: Heat's prominence faded alongside the broader industry shift from
  OpenStack-centric private clouds toward Kubernetes and public cloud, but the codebase
  is still maintained (e.g. ongoing modernization such as migrating database migrations
  from sqlalchemy-migrate to alembic, and deprecation of resources for now-inactive
  projects like monasca, sahara, and senlin in the 2024.1 cycle).
  Sources: https://docs.openstack.org/releasenotes/heat/2024.1.html ,
  https://docs.openstack.org/releasenotes/heat/

---

## Key people & teams

- **Steven Dake** — Credited as the inventor/creator of OpenStack Heat; registered the
  Heat project on Launchpad on 8 October 2012 and was its initial PTL. At the time he was
  at **Red Hat** (he presented the Heat API at CloudOpen in August 2012 using a
  `@redhat.com` address). He later worked at Cisco.
  Sources: https://launchpad.net/heat , https://github.com/sdake ,
  https://dokumen.tips/documents/openstack-aws-cloudformation-orchestration-heat-api-openstack-aws-cloudformation.html ,
  https://blogs.cisco.com/author/stevendake
  - *Could not verify (precisely):* One secondary search summary stated Dake served as
    Heat PTL "for Essex, Folsom, and Grizzly." This is inconsistent with the fact that
    Heat was only registered in October 2012 and incubated during Grizzly (Essex and
    Folsom predate Heat's incubation). Treat the exact set of cycles he led as
    **Could not verify: Steven Dake's exact PTL release tenure**; the safe, sourced claim
    is that he was Heat's *initial* PTL.

- **Steve Hardy** and **Zane Bitter** — Among the prominent early/long-term Heat
  developers (both appear in Heat contribution records; Zane Bitter shows substantial Heat
  commits as early as the Icehouse cycle). Steve Hardy is also strongly associated with
  Heat's role inside Red Hat's TripleO (OpenStack-on-OpenStack / RHOSP deployment, which
  uses Heat to drive the "overcloud" deployment).
  Sources: https://www.stackalytics.com/?company=&metric=commits&module=heat-group&project_type=all&release=icehouse&user_id=zaneb ,
  https://wiki.openstack.org/wiki/Heat/CoreTeam ,
  https://access.redhat.com/solutions/7021940
  - *Could not verify:* exact PTL terms / dates for Hardy and Bitter from primary sources
    in this pass.

- **Rico Lin** — Listed as Heat's Release Liaison on the current TC governance page; a
  long-time Heat contributor/leader.
  Source: https://governance.openstack.org/tc/reference/projects/heat.html

- **Takashi Kajinami** — Current (as of the 2026-05-19 governance snapshot) Heat PTL.
  Source: https://governance.openstack.org/tc/reference/projects/heat.html

### Companies / sponsors

- **Red Hat** — Home of Heat's creator (Steven Dake) and a major contributor; Heat
  underpins Red Hat's TripleO / Red Hat OpenStack Platform deployment tooling
  ("overcloud" deploy via Heat stacks).
  Sources: https://dokumen.tips/documents/openstack-aws-cloudformation-orchestration-heat-api-openstack-aws-cloudformation.html ,
  https://access.redhat.com/solutions/7021940
- **Rackspace** — Co-founder of OpenStack itself (with NASA, July 2010); Rackspace's
  "Cloud Orchestration" product is based on OpenStack Heat, and Rackspace published Heat
  documentation and contributed Heat resource types (e.g. RackspaceAutoScale).
  Sources: https://en.wikipedia.org/wiki/OpenStack ,
  https://docs.rackspacecloud.com/openstack-heat/ ,
  https://github.com/openstack/heat-templates/blob/master/contrib/rackspace/RackspaceAutoScale.yaml
- *Could not verify:* Specific, primary-sourced contribution shares for **Mirantis** and
  other vendors to Heat. Mirantis was a major OpenStack vendor generally, but a direct
  citation for its Heat-specific role was not confirmed in this pass — **Could not verify:
  Mirantis's specific Heat contribution.**

---

## Summary

OpenStack Heat is OpenStack's Orchestration service, providing infrastructure-as-code via
declarative templates. It was created in 2012 by Steven Dake (then at Red Hat) — the
project was registered on Launchpad on **8 October 2012**, existed but was not yet official
at the Folsom release (September 2012), was **brought into incubation during the Grizzly
cycle**, **graduated to Integrated status in February 2013**, and first shipped as an
official integrated OpenStack project in the **Havana** release on **17 October 2013**. Heat
deliberately mirrored **AWS CloudFormation** (a CFN-compatible template format and Query
API) while also introducing the native YAML **HOT** format — earning it the "CloudFormation
for private clouds" label. It rode the rise and partial decline of OpenStack, and as of 2026
remains an actively maintained official project under the Open Infrastructure Foundation
(latest releases through 26.0.0 in April 2026).

### Could-not-verify items
1. **Steven Dake's exact PTL release tenure** — a secondary summary's claim of "Essex,
   Folsom, Grizzly" conflicts with Heat's October 2012 registration; only his role as
   *initial* PTL is firmly sourced.
2. **Exact PTL terms/dates for Steve Hardy and Zane Bitter** — they are clearly major Heat
   developers, but per-cycle leadership dates were not pinned to a primary source here.
3. **Mirantis's specific contribution to Heat** — not confirmed from a primary source.
4. **Precise founding "month/day" of the first Heat code commit** — the GitHub/OpenDev repo
   page did not surface an unambiguous first-commit date; the firmest early date is the
   Launchpad registration (8 October 2012) and the CloudOpen talk (30 August 2012).
