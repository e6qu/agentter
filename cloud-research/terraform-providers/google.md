# Terraform Google providers — Magic Modules

**Build model: code-generated from YAML resource definitions.** The Google
provider is the most thoroughly generated of the major cloud providers — one
generator produces **both** `terraform-provider-google` and
`terraform-provider-google-beta` from a single set of YAML definitions.

Full research with all citations: [`../iac/terraform-google.md`](../iac/terraform-google.md).

## The generator: Magic Modules (MMv1)
[`GoogleCloudPlatform/magic-modules`](https://github.com/GoogleCloudPlatform/magic-modules/tree/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1)
describes each resource as a
[`mmv1/products/<product>/<Resource>.yaml`](https://github.com/GoogleCloudPlatform/magic-modules/blob/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1/products/pubsub/Topic.yaml#L14-L56)
(fields, CRUD URLs, async/IAM behaviour) and renders it through Go `text/template`
`.tmpl` templates
([`resource.go.tmpl`](https://github.com/GoogleCloudPlatform/magic-modules/blob/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1/templates/terraform/resource.go.tmpl#L1-L21)).

- **Self-documenting headers.** Generated files carry a header (emitted by the
  [`CodeHeader`](https://github.com/GoogleCloudPlatform/magic-modules/blob/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1/api/resource.go#L2602-L2619)
  method) that cites the source YAML + template; `Type: MMv1` = generated,
  `Type: Handwritten` = a hand-written override.
- **One source → two providers.** GA and beta both regenerate from the *same*
  `Topic.yaml`; `min_version: 'beta'` gates beta-only surface. Output repos:
  `terraform-provider-google` (@ `e57828c`) and `-google-beta` (@ `6082338`).

## Generated vs hand-written
- **Generated:** the bulk of resources, from MMv1 YAML.
- **Hand-written:** resources MMv1 can't model live in
  [`mmv1/third_party/terraform/`](https://github.com/GoogleCloudPlatform/magic-modules/tree/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1/third_party/terraform)
  and are *copied into* the providers (e.g. `google_storage_bucket`, whose
  [`Bucket.yaml`](https://github.com/GoogleCloudPlatform/magic-modules/blob/8cc65df4a76512da5e02abe7fcfd39657374b906/mmv1/products/storage/Bucket.yaml#L14-L27)
  sets `exclude_resource: true`).

## Notable: the engine migrated Ruby → Go
At the pinned SHA the MMv1 engine is **Go** (`text/template`); the last Ruby
remnants *and* the older DCL-based `tpgtools` generator were both removed on
2026-05-18 in [PR #17608](https://github.com/GoogleCloudPlatform/magic-modules/pull/17608)
(15,415 deletions). So the DCL path is now historical.

**Plugin framework:** mostly **Plugin SDK v2** (the generated resources), with the
provider muxing in some Plugin Framework. **Contributor loop:** edit one YAML →
`make provider VERSION=ga/beta` → one PR regenerates both providers. License:
generator/configs **Apache-2.0**; `third_party` Go copied into providers is
**MPL-2.0**.
