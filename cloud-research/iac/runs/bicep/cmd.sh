#!/usr/bin/env bash
# Bicep — DSL -> ARM JSON transpile. Reproducible run.
set -euo pipefail
# bicep CLI is a self-contained binary (no .NET install needed):
curl -sL https://github.com/Azure/bicep/releases/latest/download/bicep-osx-arm64 -o bicep
chmod +x bicep
./bicep build main.bicep --outfile main.json
# main.bicep references Microsoft.Storage/storageAccounts@2023-01-01; that resource
# type + its property schema come from the GENERATED Bicep type system
# (Azure/bicep-types-az, generated from azure-rest-api-specs).
