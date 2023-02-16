@description('Name off app service plan')
param planName string

@description('Name of web app')
param appName string

@description('Docker image in format: DOCKER|phpipam/phpipam-www')
param dockerImage string

resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
  location: resourceGroup().location
  name: planName
  sku: {
    name: 'B1'
  }
  kind: 'linux'
  properties: {
    reserved: true
    name: planName
  }
}

resource app 'Microsoft.Web/sites@2022-03-01' = {
  location: resourceGroup().location
  name: appName
  kind: 'app,linux,container'
  properties: {
    enabled: true
    serverFarmId: plan.id
    reserved: true
    siteConfig: {
      linuxFxVersion: dockerImage
    }
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
  }
}
