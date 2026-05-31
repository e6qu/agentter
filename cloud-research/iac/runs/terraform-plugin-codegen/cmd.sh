#!/usr/bin/env bash
# Terraform — HashiCorp's spec-based provider codegen: provider code spec -> Plugin Framework Go.
set -euo pipefail
go install github.com/hashicorp/terraform-plugin-codegen-framework/cmd/tfplugingen-framework@latest
# spec.json = a terraform-plugin-codegen-spec "provider code specification".
# (Upstream, tfplugingen-openapi can GENERATE this spec from an OpenAPI 3 document.)
tfplugingen-framework generate resources --input spec.json --output gen
# -> gen/resource_widget/widget_resource_gen.go : WidgetResourceSchema() + tfsdk model.
