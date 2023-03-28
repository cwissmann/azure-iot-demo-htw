resource "azurerm_storage_account" "iotdemo-backend" {
  name                     = "${var.resourcePrefix}backendstorage"
  resource_group_name      = azurerm_resource_group.iotdemo.name
  location                 = azurerm_resource_group.iotdemo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
      "Application": "IoT-Demo"
  }
}

resource "azurerm_storage_container" "iotdemo-stream-analytics-job" {
  name                  = "iotdemo-stream-analytcs-job"
  storage_account_name  = azurerm_storage_account.iotdemo-backend.name
  container_access_type = "private"
}

resource "azurerm_service_plan" "iotdemo-backend" {
  name                = "${var.resourcePrefix}-backend-serviceplan"
  resource_group_name = azurerm_resource_group.iotdemo.name
  location            = azurerm_resource_group.iotdemo.location
  os_type             = "Windows"
  sku_name            = "Y1"

  tags = {
    "Application" = "IoT-Demo"
  }
}

resource "azurerm_windows_function_app" "iotdemo-backend" {
  name                = "${var.resourcePrefix}-backend-function"
  resource_group_name = azurerm_resource_group.iotdemo.name
  location            = azurerm_resource_group.iotdemo.location

  storage_account_name = azurerm_storage_account.iotdemo-backend.name
  storage_account_access_key = azurerm_storage_account.iotdemo-backend.primary_access_key
  service_plan_id      = azurerm_service_plan.iotdemo-backend.id

  tags = {
    "Application" = "IoT-Demo"
  }

  site_config {}

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY": azurerm_application_insights.iotdemo-logging.instrumentation_key,
    "IOT_EVENTHUB_ENDPOINT": "Endpoint=${azurerm_iothub.iotdemo.event_hub_events_endpoint};SharedAccessKeyName=${azurerm_iothub_shared_access_policy.iotdemo-service.name};SharedAccessKey=${azurerm_iothub_shared_access_policy.iotdemo-service.primary_key};EntityPath=${azurerm_iothub.iotdemo.event_hub_events_path}"
  }
}