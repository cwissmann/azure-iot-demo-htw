resource "azurerm_iothub" "iotdemo" {
  name                = "${var.resourcePrefix}iothub"
  resource_group_name = azurerm_resource_group.iotdemo.name
  location            = azurerm_resource_group.iotdemo.location

  tags = {
    "Application" = "IoT-Demo"
  }

  sku {
    name     = "S1"
    capacity = "2"
  }
}

resource "azurerm_iothub_shared_access_policy" "iotdemo-service" {
  name                = "iotdemo-service"
  resource_group_name = azurerm_resource_group.iotdemo.name
  iothub_name         = azurerm_iothub.iotdemo.name

  service_connect = true
}

resource "azurerm_iothub_consumer_group" "iotdemo-stream" {
  name                   = "iotdemo-stream"
  iothub_name            = azurerm_iothub.iotdemo.name
  eventhub_endpoint_name = "events"
  resource_group_name    = azurerm_resource_group.iotdemo.name
}