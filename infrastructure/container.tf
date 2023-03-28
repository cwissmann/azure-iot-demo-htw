resource "azurerm_container_registry" "iotdemo-acr" {
  name                = "${var.resourcePrefix}cr"
  resource_group_name = azurerm_resource_group.iotdemo.name
  location            = azurerm_resource_group.iotdemo.location
  sku                 = "Basic"
  admin_enabled       = true
}