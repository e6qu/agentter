@description('Name of the storage account.')
param storageAccountName string

@allowed(['Standard_LRS', 'Standard_GRS'])
param sku string = 'Standard_LRS'

// A typed resource reference. The type Microsoft.Storage/storageAccounts@2023-01-01
// and its property schema come from the GENERATED Bicep type system (bicep-types-az,
// generated from azure-rest-api-specs — the same specs that feed the Azure SDKs).
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: resourceGroup().location
  sku: { name: sku }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}

output storageId string = sa.id
