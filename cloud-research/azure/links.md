# Azure SDK Codegen — Referenced URLs (deduplicated)

## Spec repo: Azure/azure-rest-api-specs (@ 0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96)
- https://github.com/Azure/azure-rest-api-specs
- https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Getting-started-with-TypeSpec-specifications.md
- https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Conversion
- https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specificationRepositoryConfiguration.json
- Blob (legacy swagger): https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/data-plane/Microsoft.BlobStorage/readme.md
- Blob (TypeSpec folder): https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage
- Blob client.tsp: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/client.tsp
- Blob tspconfig.yaml: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/storage/Microsoft.BlobStorage/tspconfig.yaml
- Service Bus mgmt TypeSpec dir: https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus
- Service Bus mgmt readme.md: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/readme.md
- Service Bus mgmt readme.python.md: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/readme.python.md
- Service Bus mgmt tspconfig.yaml: https://github.com/Azure/azure-rest-api-specs/blob/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/servicebus/resource-manager/Microsoft.ServiceBus/ServiceBus/tspconfig.yaml
- App Service / Functions mgmt (Microsoft.Web/AppService): https://github.com/Azure/azure-rest-api-specs/tree/0079cf063ea0162adc7b8e0eec7f6e7c7b67ad96/specification/web/resource-manager/Microsoft.Web/AppService

## AutoRest (legacy generator)
- https://github.com/Azure/autorest
- https://github.com/Azure/autorest/blob/69fa4acb21d0c9275df3a09c398bb2ca2191a12c/readme.md
- https://github.com/Azure/autorest/blob/69fa4acb21d0c9275df3a09c398bb2ca2191a12c/packages/extensions/core/package.json
- Deprecation tracking issue: https://github.com/Azure/autorest/issues/5175
- https://github.com/Azure/autorest.python/blob/28a5851a2a370d70b5661278f4b7a7d22d236919/README.md
- https://github.com/Azure/autorest.go/blob/cedbfc541d4af3af0fed5fbbfb04b07be6adc9d9/README.md
- https://github.com/Azure/autorest.java
- https://github.com/Azure/autorest.typescript

## TypeSpec (new generator stack)
- https://typespec.io/
- https://github.com/microsoft/typespec
- https://github.com/Azure/typespec-azure
- https://github.com/Azure/typespec-azure/tree/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages
- typespec-python emitter: https://github.com/Azure/typespec-azure/tree/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/typespec-python
- typespec-ts emitter: https://github.com/Azure/autorest.typescript/tree/ffd258b12699f9996917596299e319092876a4ef/packages
- typespec-go emitter: https://github.com/Azure/autorest.go/tree/cedbfc541d4af3af0fed5fbbfb04b07be6adc9d9/packages
- TypeSpec data-plane migration tips: https://azure.github.io/typespec-azure/docs/migrate-swagger/checklists/migrate-dp-tips/
- TypeSpec ARM migration tips: https://azure.github.io/typespec-azure/docs/migrate-swagger/checklists/migrate-arm-tips/

## Pipeline / orchestration
- tsp-client (typespec-client-generator-cli): https://github.com/Azure/azure-sdk-tools/blob/main/tools/tsp-client/README.md
- npm @azure-tools/typespec-client-generator-cli: https://www.npmjs.com/package/@azure-tools/typespec-client-generator-cli
- Go swagger_to_sdk_config.json: https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/eng/swagger_to_sdk_config.json
- tsp-location.yaml example (azure-data-tables): https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/tables/azure-data-tables/tsp-location.yaml
- Generate code from TypeSpec (Java wiki): https://github.com/Azure/azure-sdk-for-java/wiki/Generate-code-from-TypeSpec
- Migrating to TypeSpec (JS wiki): https://github.com/Azure/azure-sdk-for-js/wiki/Migrating-to-TypeSpec
- Generate Swagger and TypeSpec in Package (Python wiki): https://github.com/Azure/azure-sdk-for-python/wiki/Generate-Swagger-and-TypeSpec-in-Package

## Per-language SDK repos & case-study outputs
- Python: https://github.com/Azure/azure-sdk-for-python
  - Blob package: https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob
  - Blob _generated client (AutoRest header): https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob/_generated/_azure_blob_storage.py
  - Blob _generated/_patch.py: https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/storage/azure-storage-blob/azure/storage/blob/_generated/_patch.py
  - Service Bus mgmt _metadata.json: https://github.com/Azure/azure-sdk-for-python/blob/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/servicebus/azure-mgmt-servicebus/_metadata.json
  - Service Bus mgmt package: https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/servicebus/azure-mgmt-servicebus
  - App Service / Functions mgmt package: https://github.com/Azure/azure-sdk-for-python/tree/ff6370fda6d53389c143a781ffe8b7c3221d3580/sdk/appservice/azure-mgmt-web
- Go: https://github.com/Azure/azure-sdk-for-go
  - azblob: https://github.com/Azure/azure-sdk-for-go/tree/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob
  - azblob generated dir: https://github.com/Azure/azure-sdk-for-go/tree/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob/internal/generated
  - azblob generated autorest.md (directives): https://github.com/Azure/azure-sdk-for-go/blob/e542d7a5b3b684f928a04ae23ee2cd45f8f57260/sdk/storage/azblob/internal/generated/autorest.md
- Java: https://github.com/Azure/azure-sdk-for-java
- JS: https://github.com/Azure/azure-sdk-for-js
  - storage-blob src: https://github.com/Azure/azure-sdk-for-js/tree/39edf9562a7adbd1383a124cb55ed9ada844b0e2/sdk/storage/storage-blob/src
  - storage-blob swagger/README.md (protocol layer + directives): https://github.com/Azure/azure-sdk-for-js/blob/39edf9562a7adbd1383a124cb55ed9ada844b0e2/sdk/storage/storage-blob/swagger/README.md

## Dashboards / docs
- Azure REST API Specs inventory dashboard: https://azure.github.io/azure-sdk/releases/latest/specs.html
- Azure SDK releases (latest): https://azure.github.io/azure-sdk/

## Cross-language verification (see verification.md)

### Spec-driven scenario suite: spector / http-specs (@ pinned SHAs)
- spector tool README (microsoft/typespec @ 8d9f7f7f3e4679bcf60f121df5582f3f162d4298): https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/spector/README.md
- @typespec/http-specs package.json: https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/package.json
- @azure-tools/azure-http-specs package.json (Azure/typespec-azure @ d0d2d7c83897ad72314d55ebae0dcbc28e62ee61): https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/package.json
- Scenario example (neutral) authentication/api-key main.tsp: https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/specs/authentication/api-key/main.tsp
- Scenario example (neutral) authentication/api-key mockapi.ts: https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-specs/specs/authentication/api-key/mockapi.ts
- Scenario example (azure) azure/core/basic main.tsp: https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/specs/azure/core/basic/main.tsp
- Scenario example (azure) azure/core/basic mockapi.ts: https://github.com/Azure/typespec-azure/blob/d0d2d7c83897ad72314d55ebae0dcbc28e62ee61/packages/azure-http-specs/specs/azure/core/basic/mockapi.ts
- Emitter regenerate (consumes node_modules specs): https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/eng/scripts/ci/regenerate.ts
- Emitter pytest conftest (starts tsp-spector serve on :3000): https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/tests/conftest.py
- Emitter run-tests CI driver: https://github.com/microsoft/typespec/blob/8d9f7f7f3e4679bcf60f121df5582f3f162d4298/packages/http-client-python/eng/scripts/ci/run-tests.ts
- cadl-ranch archived README (redirects to microsoft/typespec): https://github.com/Azure/cadl-ranch/blob/5d668a3386950a71640df1e620ffd5668ad973e5/README.md
- cadl-ranch -> typespec migration tracking issue #4015: https://github.com/microsoft/typespec/issues/4015

### test-proxy (record/replay)
- test-proxy README (Azure/azure-sdk-tools @ 249712c6c20bd30210c44b7f666b2c54dfed16c7): https://github.com/Azure/azure-sdk-tools/blob/249712c6c20bd30210c44b7f666b2c54dfed16c7/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md
- asset-sync README (assets.json + azure-sdk-assets): https://github.com/Azure/azure-sdk-tools/blob/249712c6c20bd30210c44b7f666b2c54dfed16c7/tools/test-proxy/documentation/asset-sync/README.md
- External recordings repo: https://github.com/Azure/azure-sdk-assets
- Real assets.json example (python tables): https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/tables/azure-data-tables/assets.json

### AutoRest-era equivalent: autorest.testserver
- Repo: https://github.com/Azure/autorest.testserver
- README (Test server V2) @ c04d3fe530c00a8095cfc6288d5f7bf1c7f61f38: https://github.com/Azure/autorest.testserver/blob/c04d3fe530c00a8095cfc6288d5f7bf1c7f61f38/README.md
- npm @microsoft.azure/autorest.testserver: https://www.npmjs.com/package/@microsoft.azure/autorest.testserver
- writing-mock-apis doc: https://github.com/Azure/autorest.testserver/blob/main/docs/writing-mock-apis.md
- example swagger (paging.json): https://github.com/Azure/autorest.testserver/blob/main/swagger/paging.json
- markdown mock-server PR #245 (spector lineage): https://github.com/Azure/autorest.testserver/pull/245
