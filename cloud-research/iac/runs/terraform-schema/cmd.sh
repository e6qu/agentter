#!/usr/bin/env bash
# Terraform — dump the machine-readable provider schema that CDKTF + Pulumi consume.
set -euo pipefail
terraform init                         # downloads hashicorp/random provider
terraform providers schema -json > schema.json
# schema.json is the gRPC-protocol schema (format_version 1.0): resources, data
# sources, attributes, nesting. CDKTF `cdktf get` and pulumi-terraform-bridge
# `tfgen` both read this shape to generate per-language bindings.
