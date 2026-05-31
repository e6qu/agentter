#!/usr/bin/env bash
# Azure NEW path — TypeSpec (.tsp -> TypeScript) via the Azure emitter.  Reproducible run.
set -euo pipefail
npm install @typespec/compiler @typespec/http @typespec/rest \
            @azure-tools/typespec-ts @azure-tools/typespec-client-generator-core
# tspconfig.yaml selects emit: ["@azure-tools/typespec-ts"].
npx tsp compile main.tsp
