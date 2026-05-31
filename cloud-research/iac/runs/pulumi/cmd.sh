#!/usr/bin/env bash
# Pulumi — one Package Schema -> per-language SDKs (Python + Go). Reproducible run.
set -euo pipefail
# schema.json = a Pulumi Package Schema (the IDL: resources/types/functions).
# For real cloud providers this schema is emitted by pulumi-terraform-bridge tfgen
# from the corresponding Terraform provider's schema.
pulumi package gen-sdk schema.json --language python -o out
pulumi package gen-sdk schema.json --language go     -o out
# Note: when not logged in, the pulumi CLI may create an ephemeral cloud account;
# `package gen-sdk` codegen itself is local/offline and needs no account.
