resource "azurerm_iothub" "htw" {
  name                = "${var.resourcePrefix}iothub"
  resource_group_name = azurerm_resource_group.htw.name
  location            = azurerm_resource_group.htw.location

  tags = {
    "Application" = "HTW-Demo"
  }

  sku {
    name     = "F1"
    capacity = "1"
  }
}

resource "azurerm_iothub_shared_access_policy" "htw-service" {
  name                = "htw-service"
  resource_group_name = azurerm_resource_group.htw.name
  iothub_name         = azurerm_iothub.htw.name

  service_connect = true
}