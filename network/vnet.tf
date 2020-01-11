locals {
  vnet-resource-group = "RG-Vnet"

  web-vnet-name          = "vnet-web"
  web-vnet-address-space = "192.168.0.0/20"

  web-subnet-name           = "subnet-web"
  web-subnet-address-prefix = "192.168.0.0/24"

  servers-subnet-name           = "subnet-servers"
  servers-subnet-address-prefix = "192.168.1.0/24"

  bastion-subnet-name           = "AzureBastionSubnet"
  bastion-subnet-address-prefix = "192.168.2.0/24"
}

resource "azurerm_resource_group" "vnet" {
  name     = local.vnet-resource-group
  location = var.location
}

##### VNET

resource "azurerm_virtual_network" "web" {
  name                = local.web-vnet-name
  address_space       = [local.web-vnet-address-space]
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet.name
}

##### SUBNET

resource "azurerm_subnet" "web" {
  name                 = local.web-subnet-name
  address_prefix       = local.web-subnet-address-prefix
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.web.name

  delegation {
    name = "acctestdelegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "servers" {
  name                 = local.servers-subnet-name
  address_prefix       = local.servers-subnet-address-prefix
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.web.name
}

resource "azurerm_subnet" "bastion" {
  name                 = local.bastion-subnet-name
  address_prefix       = local.bastion-subnet-address-prefix
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.web.name
}
