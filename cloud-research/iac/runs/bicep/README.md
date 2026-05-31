# Build: Bicep — DSL → ARM JSON, over a generated type system

**Result: SUCCESS.** `bicep build` transpiled a `.bicep` storage-account
definition into an ARM JSON deployment template. Bicep is a *single-language* DSL
(no multi-language bindings, unlike CDK/Pulumi), but its **type system is
generated** from the same Azure specs that feed the SDKs.

## Toolchain
- Bicep CLI 0.43.8 — a self-contained binary (no .NET install needed):
  `curl -sL https://github.com/Azure/bicep/releases/latest/download/bicep-osx-arm64`

## Input (`input/`)
- `main.bicep` — params (`storageAccountName`, an `@allowed` `sku`) and a typed
  `resource sa 'Microsoft.Storage/storageAccounts@2023-01-01'`. The resource type
  and its property schema (`sku`, `kind`, `properties.accessTier`, …) come from the
  **generated** Bicep type system, `Azure/bicep-types-az`, which is generated from
  `Azure/azure-rest-api-specs` (Swagger/TypeSpec) via an AutoRest extension — the
  *same* specs that drive AutoRest/TypeSpec SDK generation and `azapi`.

## Commands (`cmd.sh`)
```
./bicep build main.bicep --outfile main.json
```

## Output (`output/`)
- `main.json` — the ARM deployment template. Resource
  `Microsoft.Storage/storageAccounts` @ `2023-01-01`, the two parameters, and
  `metadata._generator: { name: "bicep", version: "0.43.8.12551", templateHash: … }`.

## The key evidence
Two things this build demonstrates:
1. **DSL → deployment IR.** Bicep compiles to ARM JSON; ARM templates are the
   substrate Azure actually deploys (the same IR `azurerm`/`azapi` partly target).
2. **Even a single-language DSL has codegen behind it.** The strong typing on
   `Microsoft.Storage/storageAccounts@2023-01-01` is only possible because the
   resource-type definitions are *generated* (`bicep-types-az`) from the ARM REST
   specs. So Bicep ties back to the same `azure-rest-api-specs` root as the Azure
   SDKs — see `../../bicep.md` and `../../terraform-azure.md`.

## Takeaway
Confirms the Bicep transpile path and, more importantly, that Bicep's type
authoring experience is itself a downstream of `azure-rest-api-specs` — making it
a sibling, at the IaC layer, of the AutoRest/TypeSpec SDK pipeline.
