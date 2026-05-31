# Build: Terraform provider schema dump (the bridge input)

**Result: SUCCESS.** `terraform providers schema -json` dumped a provider's full
machine-readable schema as JSON. This artifact is the **source model** that
CDKTF (`cdktf get`) and pulumi-terraform-bridge (`tfgen`) consume to generate
their per-language bindings — i.e. the Terraform provider feeds a *second*
generation layer.

## Toolchain
- Terraform CLI 1.13.5

## Input (`input/`)
- `main.tf` — a `required_providers` block pinning `hashicorp/random` 3.6.3 (a
  tiny provider; no cloud credentials needed).

## Commands (`cmd.sh`)
```
terraform init                                  # downloads the provider plugin
terraform providers schema -json > schema.json
```

## Output (`output/`)
- `schema.json` — `format_version: 1.0`, with the `random` provider's
  `resource_schemas` (`random_string`, `random_password`, `random_uuid`, …), each
  resource's `block.attributes` (`length`, `lower`, `min_numeric`, …) with their
  `required`/`optional`/`computed` flags and types.

## The key evidence (the schema chain)
This JSON is a near-1:1 projection of the provider's **gRPC `GetProviderSchema`**
response (see `../../terraform-core.md`). It is the exact shape that downstream
generators read:
- **CDKTF** `cdktf get` → `TerraformProviderGenerator` → jsii → multi-language
  constructs.
- **Pulumi** `pulumi-terraform-bridge` `tfgen` → a Pulumi Package Schema → per-language
  SDKs (see `../pulumi/`).

So this build captures the hinge of the **generation chain**: API spec → SDK →
**Terraform provider → provider schema** → CDKTF/Pulumi bindings.

## Takeaway
Materializes the machine-readable provider schema that makes CDKTF and the Pulumi
bridge possible — the connective tissue between the Terraform ecosystem and the
multi-language IaC SDKs.
