# Ultra-cheap & free compute on the internet (reputable providers)

A practical, **sourced** survey of where you can get **free or near-free compute** from
**reputable, sizable providers** — hyperscaler free tiers, CI/CD runners, free GPU/notebook
services, and free PaaS/dev environments. Aimed at someone who wants to run side projects,
CI, experiments, or ML workloads without (much of) a bill.

> **Currency & volatility warning.** All figures are **as of May 2026** and every row is
> linked to an official source. **Free tiers change constantly and usually shrink** — Heroku
> killed its free tier (Nov 2022), Railway (Aug 2023), Fly.io (Oct 2024), and Glitch (Jul
> 2025) all removed theirs; Gitpod dropped its free cloud tier. Re-check the source link
> before relying on any number. Anything that couldn't be confirmed from an official page is
> marked **"Could not verify (as of May 2026)."**
>
> **Scope:** reputable, generally sizable providers only — no fly-by-night "free VPS" sites.
> Companion to [`CLOUD_API_COMPARISON.md`](CLOUD_API_COMPARISON.md) and the
> [cloud-providers history/timeline](history/cloud-providers-timeline.md).

---

## TL;DR — the standouts

- **Most generous always-free *VM* compute:** **Oracle Cloud (OCI) Always Free** — up to
  **4 Arm OCPUs + 24 GB RAM** (Ampere A1) plus 2 small AMD VMs, **perpetually**, with **10 TB/mo
  egress**. Nothing else in the hyperscaler tier comes close for a real, persistent VM.
- **Most generous free *serverless/edge*:** **Cloudflare Workers** (100k req/day, unlimited
  bandwidth) and **Google Cloud Run** (2M req/mo) — perpetual, no card games.
- **Best free *CI*:** **GitHub Actions** — *free and unlimited* on standard runners for **public
  repos** (4 vCPU/16 GB); 2,000 min/mo for private. **Azure DevOps** gives 10 free parallel jobs
  for public projects.
- **Best free *GPU*:** **Kaggle Notebooks** (predictable ~30 GPU-hrs/week, T4×2 or P100) and
  **Google Colab** (T4 when available). For inference demos, **Hugging Face Spaces** (ZeroGPU).
- **Best free *dev environment*:** **GitHub Codespaces** (~120 core-hrs/mo) and **Google Cloud
  Shell** (free ephemeral VM).
- **The trap:** "free always-on dedicated VM" (the old Heroku model) is **effectively gone** from
  mainstream PaaS — survivors either scale-to-zero on idle (Render, Koyeb) or are edge-only.

---

### Hyperscaler & edge free tiers

*All figures current as of May 2026. Each row sourced; unconfirmed figures flagged inline.*

| Provider | Always-free compute (perpetual) | Time-limited credit / trial | Notable limits & gotchas | Source |
|---|---|---|---|---|
| **Oracle Cloud (OCI)** | **Up to 4 OCPU + 24 GB RAM** of Ampere A1 Arm (split across up to 4 VMs) **plus 2× AMD micro VMs** (1/8 OCPU + 1 GB each); 200 GB block storage; ~20 GB object storage; 2 Autonomous DBs | $300 credit / 30 days (trial), on top of Always Free | **10 TB/mo egress** (most generous). Card required. Arm capacity often "Out of capacity" in popular regions. Crypto mining banned. | [Oracle docs](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm), [oracle.com/cloud/free](https://www.oracle.com/cloud/free/) |
| **Google Cloud** | **1× e2-micro VM/mo** (only `us-west1`/`us-central1`/`us-east1`; 30 GB disk; 1 GB NA egress); **Cloud Run 2M req/mo**; Cloud Functions 2M/mo; BigQuery 1 TiB query + 10 GiB/mo; Cloud Storage 5 GB | **$300 credit / 90 days** | e2-micro is region-locked and tiny. Card required. Heavy mining needs approval. | [cloud.google.com/free](https://cloud.google.com/free) |
| **AWS** | **30+ always-free services** incl. Lambda 1M req/mo, DynamoDB 25 GB | **Since 2025-07-15: up to $200 credit** ($100 signup + $100 from onboarding tasks); Free Plan ends at **6 months or when credits run out**. (Pre-2025-07-15 accounts keep the legacy 12-month free incl. t2/t3.micro 750h.) | New Free Plan accounts blocked from some pricey services; auto-closed after expiry. Card required. Mining banned. | [AWS blog (2025 revamp)](https://aws.amazon.com/blogs/aws/aws-free-tier-update-new-customers-can-get-started-and-explore-aws-with-up-to-200-in-credits/), [aws.amazon.com/free](https://aws.amazon.com/free/) |
| **Microsoft Azure** | 12-month-free (e.g. **750h/mo B1s VM**) for first year; **65+ always-free** services incl. Functions 1M req/mo | **$200 credit / 30 days** | B1s 750h is **12-month, not perpetual** (common confusion). Card required. Mining prohibited. | [Azure free account](https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account) |
| **Cloudflare** | **Workers/Pages: 100k req/day**, unlimited bandwidth; R2 10 GB-mo + free ops; KV 1 GB; D1 5 GB; Durable Objects 100k req/day | None (perpetual free plan; no trial credit) | **Edge/serverless only — no full VMs.** 10 ms CPU/request cap. | [Workers pricing](https://developers.cloudflare.com/workers/platform/pricing/) |

**The standout — OCI Always Free.** Its Ampere A1 allowance (**4 OCPU + 24 GB RAM** of Arm
compute, perpetual, + 200 GB storage + **10 TB/mo egress**) is in a different league from the
other hyperscalers, whose perpetual compute is either a single tiny shared VM (GCP e2-micro),
serverless-only (AWS Lambda, Cloudflare Workers), or time-limited (Azure B1s is 12-month). The
practical catch is Arm capacity scarcity in popular regions. **Crypto-mining note:** all five
prohibit or restrict it; GCP permits lightweight PoS but requires approval for resource-intensive
mining — check each provider's current Acceptable Use Policy.

---

### Free CI/CD compute

*Current as of May 2026; from official pricing/docs where possible.*

| Provider | Free public-repo | Free private-repo | Standard Linux runner | Source |
|---|---|---|---|---|
| **GitHub Actions** | **Free + unlimited** on standard runners | 2,000 min/mo (Free); 3,000 (Pro/Team); 50,000 (Enterprise) | Public: 4 vCPU/16 GB; Private: 2 vCPU/8 GB | [Billing docs](https://docs.github.com/billing/managing-billing-for-github-actions/about-billing-for-github-actions) |
| **GitLab CI/CD** | Same 400-min quota on instance runners (GitLab-OSS contributors can request up to 300k) | 400 compute-min/mo (Free); self-hosted runners unlimited | "Small" SaaS Linux runner (1× cost factor) | [Compute minutes](https://docs.gitlab.com/ci/pipelines/compute_minutes/) |
| **Bitbucket Pipelines** | Shared plan pool | 50 build-min/mo (Free); 2,500 (Standard) | 4 GB memory/step default | [Atlassian pricing](https://www.atlassian.com/software/bitbucket/pricing) |
| **CircleCI** | OSS up to 400k credits/mo | 30,000 credits/mo (Free, ≤5 users) ≈ ~3,000 Linux min | "medium" = 2 vCPU/4 GB | [Pricing](https://circleci.com/pricing/) |
| **Travis CI** | No standing free-OSS plan since Dec 2020; case-by-case credits | 10,000-credit trial then paid | varies | [Billing FAQ](https://docs.travis-ci.com/user/billing-faq/) |
| **Azure DevOps Pipelines** | Free; **up to 10 Microsoft-hosted parallel jobs**, no monthly cap | 1 free parallel job, 1,800 min/mo (manual request to deter abuse) | 2 vCPU/7 GB | [Parallel jobs docs](https://learn.microsoft.com/en-us/azure/devops/pipelines/licensing/concurrent-jobs?view=azure-devops) |

**Minute multipliers (GitHub private repos):** macOS ≈ **10×** and Windows ≈ **2×** the Linux rate,
so allowances burn proportionally faster on those OSes.

**GitHub's TOS — CI, not arbitrary compute.** GitHub-hosted runners may be used *only* for the
"production, testing, deployment, or publication of the software project associated with the
repository," and **not** for crypto-mining, serverless/CDN hosting, or any disproportionate burden;
misuse → job termination / account suspension. ([Additional Product Terms](https://docs.github.com/en/site-policy/github-terms/github-terms-for-additional-products-and-features))

**The abuse problem.** Free CI minutes have been heavily abused for **crypto-mining**, which is the
direct reason free runners keep getting restricted:
- **GitHub** fights sustained Actions-mining campaigns (via PRs / stolen tokens) and null-routes
  known mining pools on its runners. ([InfoQ](https://www.infoq.com/news/2021/04/GitHub-actions-cryptomining/), [Sysdig](https://www.sysdig.com/blog/massive-cryptomining-operation-github-actions))
- **GitLab** saw a "massive uptick" and from **2021-05-17** required new free users to validate a
  **credit card** ($1 auth) before using shared runners. ([GitLab blog](https://about.gitlab.com/blog/prevent-crypto-mining-abuse/), [The Register](https://www.theregister.com/2021/05/19/gitlab_crypto/))
- **Azure DevOps** now grants the free private-project parallel job only on manual request "to
  address abuse." **Travis CI's** 2020 removal of open-ended free OSS is attributed to the same.

---

### Free notebooks & GPU compute

Every "free GPU" below carries the same trade-offs: **no guaranteed availability** (on-demand,
preemptible), **idle timeouts**, **per-session wall-clock caps**, and **weekly/daily quotas**. None
suit production or guaranteed long training. *Verified against official docs as of May 2026.*

| Provider | Free GPU / TPU | Quota / limits | Catch | Source |
|---|---|---|---|---|
| **Google Colab (free)** | NVIDIA **T4** (16 GB) *when available*; not guaranteed | Limits **unpublished**, demand-dependent; notebooks ≤12 h; idle timeouts; ~12 GB RAM | No guaranteed resources; **no crypto mining / non-interactive workers** | [Colab FAQ](https://research.google.com/colaboratory/faq.html) |
| **Kaggle Notebooks** | **T4 ×2** or **P100** (16 GB); **TPU v3-8** | **~30 GPU-hrs/week** (resets weekly); TPU ~20 h/wk; session ≤9 h; background execution | Hard weekly quota | [Kaggle GPU docs](https://www.kaggle.com/docs/efficient-gpu-usage) — *exact current hrs JS-rendered; "30/wk" widely reported, not byte-confirmed (May 2026)* |
| **Hugging Face Spaces** | CPU Basic free (2 vCPU/16 GB); **ZeroGPU** = NVIDIA **RTX Pro 6000 Blackwell** (48/96 GB) | ZeroGPU free: **5 min/day** GPU time; per-call ~60 s; CPU Space sleeps after 48 h idle | Hosting your *own* ZeroGPU Space needs PRO ($9/mo); **community GPU grants** exist on merit | [ZeroGPU docs](https://huggingface.co/docs/hub/en/spaces-zerogpu) |
| **Amazon SageMaker Studio Lab** | **Active** (no AWS account needed); free CPU **and GPU** | **GPU: 4 h/session, 4 h per 24 h**; CPU: 4 h/session, 8 h/24 h; 15 GB storage | Availability not guaranteed; no extensions | [Studio Lab docs](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-lab-overview.html) |
| **Paperspace Gradient (DigitalOcean)** | **Free GPU notebooks** (M4000…A100-80G, by availability) | Private workspaces only; auto-shutdown; "dev/test" only | Free GPUs often **unavailable at peak**; not for sustained training | [DO/Paperspace pricing](https://docs.digitalocean.com/products/paperspace/pricing/) |
| **GitHub Codespaces** | **No free GPU** (CPU-only free tier) | ~120 core-hrs/mo + 15 GB; GPU machine types are paid beta only | Free GPU simply **not offered** | [Codespaces billing](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces) |

**Notes.** *Best free GPU for sustained work:* **Kaggle** (most predictable) and **Colab**.
*ZeroGPU changed* — current docs list RTX Pro 6000 Blackwell at 5 min/day for free accounts (older
"H200, 3.5 min/day" figures are outdated). *SageMaker Studio Lab* is **still active** despite
wind-down rumors (those refer to the separate *Studio Classic*). *No free GPU* on GitHub
Codespaces or general Microsoft notebooks.

---

### Free PaaS, app-hosting & dev environments

*Current as of May 2026.* **Status** flags where a free tier was **removed** — important context.

#### Cloud dev environments
| Provider | Free offering | Idle/sleep | Status | Source |
|---|---|---|---|---|
| **GitHub Codespaces** | ~120 core-hrs/mo (~60 h on 2-core) + 15 GB | Stops after 30 min idle | Active | [Docs](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces) |
| **Gitpod → "Ona"** | **Free cloud tier removed**; rebranded to Ona, cloud Core now $20/mo; free only for **self-hosted** | n/a | **Removed** | [ona.com/pricing](https://ona.com/pricing) |
| **Replit** | Free "Starter": 1 vCPU/2 GiB, ~1,200 dev-min/mo, limited Agent credits (reduced vs pre-2023) | Workspaces idle out | Active (reduced) | [Replit pricing](https://replit.com/pricing) |
| **Google Cloud Shell** | Free ephemeral VM, 5 GB `$HOME`, ~50 h/week | Ends ~20 min idle; home deleted after 120 d inactivity | Active | [Cloud Shell quotas](https://docs.cloud.google.com/shell/docs/quotas-limits) |

#### App-hosting PaaS
| Provider | Free offering | Idle/sleep | Status | Source |
|---|---|---|---|---|
| **Render** | Free web services; 750 instance-hrs/mo; free static sites | **Spins down after 15 min** idle (~1 min cold start) | Active | [Render free](https://render.com/docs/free) |
| **Railway** | **No permanent free tier** — one-time $5 trial, then $1/mo credit | n/a | **Removed (Aug 2023)** | [Railway free-trial](https://docs.railway.com/pricing/free-trial) |
| **Fly.io** | **No free tier for new users** — pay-as-you-go + short trial credit | n/a | **Removed (2024-10-07)** | [Fly.io pricing](https://fly.io/docs/about/pricing/) |
| **Koyeb** | Free tier, one Free instance (scale-to-zero) | **Deep Sleep after 1 h** idle (1–5 s cold start) | Active | [Koyeb scale-to-zero](https://www.koyeb.com/docs/run-and-scale/scale-to-zero) |
| **Glitch** | **App hosting shut down 2025-07-08** (code downloads only) | n/a | **Removed/shut down** | [Glitch blog](https://blog.glitch.com/post/changes-are-coming-to-glitch) |
| **PythonAnywhere** | Free "Beginner": 1 web app, 100 CPU-s/day, 512 MiB, whitelisted outbound | Manual ~3-month renewal; no always-on tasks | Active (reduced) | [PythonAnywhere pricing](https://www.pythonanywhere.com/pricing/) |

#### Frontend / edge & serverless
| Provider | Free offering | Status | Source |
|---|---|---|---|
| **Vercel (Hobby)** | 100 GB bw/mo, 1M function invocations, 6,000 build-min/mo; **non-commercial only**; 10 s timeout | Active | [Vercel Hobby](https://vercel.com/docs/plans/hobby) |
| **Netlify (Free)** | 100 GB bw/mo, 300 build-min/mo, 125k functions + 1M edge invocations | Active | [Netlify pricing](https://www.netlify.com/pricing/) |
| **Cloudflare Pages/Workers** | Workers 100k req/day; Pages 500 builds/mo, unlimited bandwidth | Active | [Workers pricing](https://developers.cloudflare.com/workers/platform/pricing/) |
| **Deno Deploy** | 1M req/mo (~100k/day), 50 ms CPU/req, 1 GB KV, 100 GB egress | Active (Classic sunsets 2026-07-20) | [Deno Deploy limits](https://docs.deno.com/deploy/pricing_and_limits/) |
| **Val Town** | Up to 100,000 runs/day; new free vals public-only | Active | [Val Town pricing](https://www.val.town/pricing) |

#### The free-tier retreat (2022–2025)
The modern vanishing-free-tier era began when **Heroku eliminated all free product plans on
November 28, 2022** ([Heroku changelog #2461](https://devcenter.heroku.com/changelog-items/2461)) —
free Dynos/Postgres/Redis gone. Heroku's free dynos had been the default "deploy your first app for
free" path for a decade, so the removal reset expectations. A broader retreat followed: **Railway**
(Aug 2023), **Fly.io** (Oct 2024), **Glitch** (Jul 2025) all removed free hosting, and **Gitpod**
dropped its free cloud tier. Survivors split into two camps:
- **Edge/serverless** (Cloudflare, Netlify, Vercel Hobby, Deno Deploy, Val Town) — sustain generous
  free allowances because per-request edge compute is cheap.
- **Container PaaS** (Render, Koyeb) — keep free tiers alive only by **scaling to zero / spinning
  down on idle** (15 min Render, 1 h Koyeb), trading cold-start latency for cost.

The "always-on, free, dedicated VM" model is now effectively gone from mainstream PaaS — which is
exactly why **OCI Always Free** (a real persistent Arm VM) stands out so much.

---

## Cross-cutting caveats

1. **Free tiers shrink; re-check the source.** Treat every number here as a snapshot. The trend is
   downward (see the retreat above).
2. **Acceptable-use limits are real.** Every provider bans crypto-mining on free tiers; CI runners
   are for *building the repo's software*, not arbitrary compute. Abuse → suspension, and it's the
   reason free tiers keep tightening.
3. **"Free" usually wants a credit card.** OCI, GCP, AWS, Azure all require a card (for identity /
   overage), even for always-free resources. Watch for silent overage once you exceed the free line.
4. **Preemption & idle policies define usefulness.** Free GPU is preemptible and quota-capped; free
   PaaS scales to zero. Fine for dev/CI/experiments; not for SLAs.
5. **Best combos:** OCI Always Free (a real server) + Cloudflare (edge/CDN) + GitHub Actions (CI) +
   Kaggle/Colab (GPU) covers most hobby and learning needs at $0, from reputable providers.
