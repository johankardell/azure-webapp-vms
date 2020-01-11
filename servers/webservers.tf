locals {
  resource_group = "RG-WebServers"

  subnet_name         = "subnet-servers"
  vnet_name           = "vnet-web"
  vnet_resource_group = "RG-VNet"
}

data "azurerm_subnet" "web" {
  name                 = local.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group
}

module "webserver1" {
  source              = "../modules/webserver/"
  vm_name             = "vm-web1"
  location            = var.location
  resource_group_name = local.resource_group
  setup_script        = "../scripts/install_apache.sh"
  subnet_id           = data.azurerm_subnet.web.id
}

module "webserver2" {
  source              = "../modules/webserver/"
  vm_name             = "vm-web2"
  location            = var.location
  resource_group_name = local.resource_group
  setup_script        = "../scripts/install_apache.sh"
  subnet_id           = data.azurerm_subnet.web.id
}
