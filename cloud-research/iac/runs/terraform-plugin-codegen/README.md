# Build: terraform-plugin-codegen — spec → Plugin Framework Go

**Result: SUCCESS.** `tfplugingen-framework` generated Terraform Plugin Framework
Go code (a resource schema + a typed data model) from a **provider code
specification** JSON. This is HashiCorp's spec-driven provider-code generation —
the IaC-layer analogue of the SDK generators in `../../../CODE_GENERATION.md`.

## Toolchain
- Go 1.26 — `go install github.com/hashicorp/terraform-plugin-codegen-framework/cmd/tfplugingen-framework@latest`

## Input (`input/`)
- `spec.json` — a `terraform-plugin-codegen-spec` **provider code specification**:
  one resource `widget` with string attributes `id` (computed), `name` (required),
  `color` (optional). Upstream, `tfplugingen-openapi` can *generate* this spec from
  an OpenAPI 3 document — so the full official pipeline is **OpenAPI → provider
  code spec → Go**.

## Commands (`cmd.sh`)
```
tfplugingen-framework generate resources --input spec.json --output gen
```

## Output (`output/`)
- `gen/resource_widget/widget_resource_gen.go`:
  ```go
  func WidgetResourceSchema(ctx context.Context) schema.Schema {
      return schema.Schema{ Attributes: map[string]schema.Attribute{
          "color": schema.StringAttribute{ Optional: true },
          "id":    schema.StringAttribute{ Computed: true },
          "name":  schema.StringAttribute{ Required: true, ... },
      }}
  }
  type WidgetModel struct {
      Color types.String `tfsdk:"color"`
      Name  types.String `tfsdk:"name"`
      ...
  }
  ```

## The key evidence (and an important limit)
- This is the **newer official Terraform codegen** path: a declarative spec
  deterministically yields the Plugin Framework schema + `tfsdk`-tagged model.
- **It generates schema + data model only — CRUD bodies stay hand-written.** That
  is the central nuance of every Terraform provider: even the "generated" ones
  (and HashiCorp's spec pipeline) generate the *shape*, while behaviour is either
  hand-authored (azurerm, terraform-provider-aws) or delegated to a generic API
  (awscc via Cloud Control). See `../../terraform-core.md`,
  `../../terraform-aws.md`.

## Takeaway
A working reproduction of HashiCorp's spec → provider-Go generation, showing both
its power (deterministic typed schemas) and its boundary (no generated CRUD) — the
key reason Terraform providers sit across the hand-written↔generated spectrum.
