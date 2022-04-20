resource "azurerm_log_analytics_workspace" "htw-logging" {
  name                = "${var.resourcePrefix}-workspace"
  location            = azurerm_resource_group.htw.location
  resource_group_name = azurerm_resource_group.htw.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "htw-logging" {
  name                = "${var.resourcePrefix}-appinsights"
  location            = azurerm_resource_group.htw.location
  resource_group_name = azurerm_resource_group.htw.name
  workspace_id        = azurerm_log_analytics_workspace.htw-logging.id
  application_type    = "web"

  tags = {
      "Application": "HTW-Demo"
  }
}