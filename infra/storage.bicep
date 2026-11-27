param location string = resourceGroup().location
param tags object = {
  projekt: 'ticketing'
  srodowisko: 'dev'
  wlasciciel: 'mateusz'
}


resource storage 'Microsoft.Storage/storageAccounts@2026-09-01' ={

  name: 'st${uniqueString(resourceGroup().id)}'
  location: location
  tags: tags
  sku: {name: 'Standard_LRS'}
  kind: 'StorageV2'
  properties:{
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false 
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices@2026-09-01' ={

  parent: storage
  name: 'default'

}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-09-01' = {
  parent: blob 
  name: 'backups'
  properties: {
    publicAccess: 'None'
  
  }
}

output storageAccountName string = storage.name
