# Cloud SDK & IaC Code-Generation Research

How the major cloud providers generate their multi-language **SDKs**, and how the
**infrastructure-as-code** tools (CDKs, Pulumi, Bicep, Terraform providers)
generate *their* bindings — researched from source, with commit-pinned citations
and locally reproduced generator runs.

## Deliverables

| Document | What it covers |
|---|---|
| [**CODE_GENERATION.md**](CODE_GENERATION.md) | The SDK layer: AWS (Smithy), GCP (Protobuf/GAPIC), Azure (AutoRest→TypeSpec), OCI (closed-source), Alibaba (Darabonba) — IDL, generators, pipelines, customization, cross-language verification, and per-provider reproductions. |
| [**IAC_CODEGEN.md**](IAC_CODEGEN.md) | The IaC layer: jsii/CDK, CDKTF, cdk8s, Pulumi, Bicep, Terraform core, and the per-cloud Terraform providers (AWS/awscc, Google Magic Modules, Azure pandora/azapi) — and the generation *chain* tying them back to the SDK layer. |
| [**sdks/**](sdks/README.md) | Per-SDK "how it's built" profiles for famous SDKs (boto3 vs the generated AWS Python v3, the AWS flagship SDKs, Stripe, Twilio, GitHub Octokit, Kubernetes client-go, Google Discovery clients) + a cross-SDK build-model matrix. |
| [**CLOUD_API_COMPARISON.md**](CLOUD_API_COMPARISON.md) | A CTO/senior-engineer-grade side-by-side comparison of the five clouds' **APIs, styles, and protocols** — REST vs gRPC vs GraphQL vs query-RPC, HTTP/1.1 vs HTTP/2, wire formats (JSON/Protobuf/XML/CBOR), auth/signing, LRO, pagination, errors, streaming — with decision-oriented takeaways. |
| [**FREE_COMPUTE.md**](FREE_COMPUTE.md) | A sourced, dated survey of **ultra-cheap/free compute** from reputable providers — hyperscaler always-free tiers (OCI/GCP/AWS/Azure/Cloudflare), free CI/CD (GitHub Actions, GitLab CI, …), free GPU/notebooks (Colab/Kaggle/HF), and free PaaS/dev environments — plus the 2022–2025 "free-tier retreat." |

## Reproduced builds (local generator runs)

Each directory below is a self-contained, documented reproduction (its `README.md`
has the toolchain, input spec, exact commands, output, and evidence).

### SDK layer
| Build | What it generates |
|---|---|
| [gcp/runs/cloudfunctions-python](gcp/runs/cloudfunctions-python/README.md) | `gapic-generator-python`: Cloud Functions v2 proto → Python (63 files) |
| [alicloud/runs/darabonba-multilang](alicloud/runs/darabonba-multilang/README.md) | `dara codegen`: one `.dara` module → Python **and** Go |
| [azure/runs/widget-autorest-python](azure/runs/widget-autorest-python/README.md) | AutoRest (legacy): Swagger 2.0 → Python |
| [azure/runs/widget-typespec-ts](azure/runs/widget-typespec-ts/README.md) | TypeSpec (new): `.tsp` → TypeScript |
| [aws/runs/sqs-typescript](aws/runs/sqs-typescript/README.md) | `smithy build`: real SQS Smithy model → TypeScript (46 files) |
| [oracle/runs](oracle/runs/README.md) | **Impossible** — `OracleSDKGenerator` is closed-source (documented non-run) |

### IaC layer  ([overview](iac/runs/README.md))
| Build | What it generates |
|---|---|
| [iac/runs/jsii](iac/runs/jsii/README.md) | jsii + jsii-pacmak: TS class → `.jsii` assembly → Python proxy package |
| [iac/runs/pulumi](iac/runs/pulumi/README.md) | `pulumi package gen-sdk`: one Package Schema → Python **and** Go SDKs |
| [iac/runs/bicep](iac/runs/bicep/README.md) | `bicep build`: `.bicep` DSL → ARM JSON |
| [iac/runs/terraform-schema](iac/runs/terraform-schema/README.md) | `terraform providers schema -json`: the schema CDKTF/Pulumi consume |
| [iac/runs/terraform-plugin-codegen](iac/runs/terraform-plugin-codegen/README.md) | `tfplugingen-framework`: provider code spec → Plugin Framework Go |

## Per-SDK build profiles ([index + matrix](sdks/README.md))

How individual famous SDKs are built, on the same build-model spectrum as the
clouds (runtime-interpreted → codegen-from-IDL → codegen-from-OpenAPI → gengo):

- **boto & the AWS family**: [boto3 / botocore](sdks/boto3.md) (data-driven; **vs** the generated [aws-sdk-python v3](sdks/aws-sdk-python-v3.md)), [aws-sdk-js-v3](sdks/aws-sdk-js-v3.md), [aws-sdk-go-v2](sdks/aws-sdk-go-v2.md), [aws-sdk-java-v2](sdks/aws-sdk-java-v2.md)
- **Non-cloud**: [Stripe](sdks/stripe.md), [Twilio](sdks/twilio.md), [GitHub Octokit](sdks/github-octokit.md), [Kubernetes client-go](sdks/kubernetes-client-go.md), [Google Discovery clients](sdks/google-apis-client.md)

## Major Terraform provider profiles ([index + matrix](terraform-providers/README.md))

How the five major cloud Terraform providers are built, across the
hand-written↔generated spectrum:
[AWS (`aws` + `awscc`)](terraform-providers/aws.md) ·
[Google (Magic Modules)](terraform-providers/google.md) ·
[Azure (`azurerm` + `azapi`)](terraform-providers/azure.md) ·
[OCI](terraform-providers/oci.md) ·
[Alibaba](terraform-providers/alibaba.md)

## History & controversies ([index + master timeline](history/README.md))

A large, chronological, fully-sourced history corpus (**92 docs, ~37.8k lines**)
covering the technologies and companies behind cloud infrastructure, databases,
data & messaging systems, version control, containers, IaC/config-management, web
frameworks, and developer tooling — including the spats, relicensing schisms,
forks, acquisitions, and the people, each attributed to a real source (and
unverifiable claims flagged). The [index](history/README.md) groups them into 15
categories — Foundations/cloud-APIs/storage · Databases · Data-infra/orchestration
· Messaging/streaming · Version-control/hosting · Config-management · Declarative-IaC
· Containers/orchestration · K8s-config/GitOps · CD/build/dev-env · Web/app-frameworks
· Business-workflow/automation · Reproducible/tooling · Dev-cloud-platforms/CDN ·
Next-gen/emerging — and includes a cross-corpus **master timeline** (1986→2026), the
recurring **themes** (the relicensing era + the PostgreSQL counterpoint, the
acquisition treadmill, founders-who-left-to-reinvent, the AI-native pivot, the
GitLab-2017→Replit-2025 database-deletion lineage), and a "claims we could NOT
verify" record. Each doc ends with **key people & teams** and **company & corporate
history** threads.

## Research notes (raw, per-topic, commit-pinned)

**SDK layer** — per provider: `notes.md` (questionnaire), `verification.md`
(cross-language testing), `links.md` (URL index):
[aws/](aws/) · [gcp/](gcp/) · [azure/](azure/) · [oracle/](oracle/) · [alicloud/](alicloud/)

**IaC layer** — [iac/cdk-jsii.md](iac/cdk-jsii.md) · [iac/pulumi.md](iac/pulumi.md) ·
[iac/bicep.md](iac/bicep.md) · [iac/terraform-core.md](iac/terraform-core.md) ·
[iac/terraform-aws.md](iac/terraform-aws.md) ·
[iac/terraform-google.md](iac/terraform-google.md) ·
[iac/terraform-azure.md](iac/terraform-azure.md)

## Project docs

[PLAN.md](PLAN.md) (methodology + phases) ·
[STATUS.md](STATUS.md) (current state) ·
[DO_NEXT.md](DO_NEXT.md) (next steps) ·
[WHAT_WE_DID.md](WHAT_WE_DID.md) (activity log) ·
[AGENTS.md](AGENTS.md) (purpose + rules; `CLAUDE.md` is a symlink to it)

## Conventions

- Every non-trivial claim links to a commit-pinned permalink (`/blob/<sha>/…`).
- Uncertain items are marked `?? verify` / `(unverified)` and tracked in `DO_NEXT.md`.
- `_work/` is scratch (venvs, clones, node_modules); every build is reproducible
  via its `cmd.sh`, so `_work/` is safe to delete. It is git-ignored and not
  committed — see [REBUILDING_WORK.md](REBUILDING_WORK.md) for how to rebuild and
  verify it.
