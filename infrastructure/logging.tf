resource "azurerm_log_analytics_workspace" "iotdemo-logging" {
  name                = "${var.resourcePrefix}-workspace"
  location            = azurerm_resource_group.iotdemo.location
  resource_group_name = azurerm_resource_group.iotdemo.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "iotdemo-logging" {
  name                = "${var.resourcePrefix}-appinsights"
  location            = azurerm_resource_group.iotdemo.location
  resource_group_name = azurerm_resource_group.iotdemo.name
  workspace_id        = azurerm_log_analytics_workspace.iotdemo-logging.id
  application_type    = "web"

  tags = {
      "Application": "IoT-Demo"
  }
}