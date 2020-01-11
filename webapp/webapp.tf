locals {
<<<<<<< HEAD
  asp_name            = "asp-example"
  resource_group      = "RG-Web"
  as_name             = "web-example"
  vnet_name           = "vnet-web"
  subnet_name         = "subnet-web"
  vnet_resource_group = "RG-VNet"
}

data "azurerm_subnet" "web" {
  name                 = local.subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group
=======
  asp_name       = "asp-example"
  resource_group = "RG-Web"

  as_name = "web-example"
>>>>>>> 7c9f4eb... Add webapp
}

resource "azurerm_resource_group" "webapp" {
  name     = local.resource_group
  location = var.location
}

resource "azurerm_app_service_plan" "example" {
  name                = local.asp_name
  location            = var.location
  resource_group_name = azurerm_resource_group.webapp.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = local.as_name
  location            = var.location
  resource_group_name = azurerm_resource_group.webapp.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
<<<<<<< HEAD
    always_on = true
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_app_service.example.id
  subnet_id      = data.azurerm_subnet.web.id
}
=======
    always_on            = true
  }
}
>>>>>>> 7c9f4eb... Add webapp
