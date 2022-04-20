resource "azurerm_storage_account" "htw-backend" {
  name                     = "${var.resourcePrefix}backendstorage"
  resource_group_name      = azurerm_resource_group.htw.name
  location                 = azurerm_resource_group.htw.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
      "Application": "HTW-Demo"
  }
}

resource "azurerm_service_plan" "htw-backend" {
  name                = "${var.resourcePrefix}-backend-serviceplan"
  resource_group_name = azurerm_resource_group.htw.name
  location            = azurerm_resource_group.htw.location
  os_type             = "Windows"
  sku_name            = "Y1"

  tags = {
    "Application" = "HTW-Demo"
  }
}

resource "azurerm_windows_function_app" "htw-backend" {
  name                = "${var.resourcePrefix}-backend-function"
  resource_group_name = azurerm_resource_group.htw.name
  location            = azurerm_resource_group.htw.location

  storage_account_name = azurerm_storage_account.htw-backend.name
  storage_account_access_key = azurerm_storage_account.htw-backend.primary_access_key
  service_plan_id      = azurerm_service_plan.htw-backend.id

  tags = {
    "Application" = "HTW-Demo"
  }

  site_config {}
}