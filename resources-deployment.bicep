targetScope = 'resourceGroup'

param location string
param vmname string
param virtualNetworkName string
param subnetName string
param adminUsername string
@secure()
param adminPassword string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: '${vmname}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${vmname}-IP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${vmname}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${virtualNetwork.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmname
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: vmname
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: {
        publisher: 'Debian'
        offer: 'debian-10'
        sku: '10'
        version: 'latest'
      }                
    }    
  }
}

