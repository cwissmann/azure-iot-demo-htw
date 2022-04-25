resource "azurerm_stream_analytics_job" "htw" {
  name                                     = "${var.resourcePrefix}-stream-analytics"
  resource_group_name                      = azurerm_resource_group.htw.name
  location                                 = azurerm_resource_group.htw.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 1

  tags = {
    Application = "HTW-Demo"
  }

  transformation_query = <<QUERY
    SELECT
    temperature AS Temperature,
    humidity AS Humidity
    INTO
    HtwBlobOutput
    FROM
    HtwHubInput
    WHERE temperature>30
QUERY

}

resource "azurerm_stream_analytics_stream_input_iothub" "htwhub" {
  name                         = "HtwHubInput"
  stream_analytics_job_name    = azurerm_stream_analytics_job.htw.name
  resource_group_name          = azurerm_stream_analytics_job.htw.resource_group_name
  endpoint                     = "messages/events"
  eventhub_consumer_group_name = azurerm_iothub_consumer_group.htw-stream.name
  iothub_namespace             = azurerm_iothub.htw.name
  shared_access_policy_key     = azurerm_iothub_shared_access_policy.htw-service.primary_key
  shared_access_policy_name    = azurerm_iothub_shared_access_policy.htw-service.name

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_blob" "htwblob" {
  name                      = "HtwBlobOutput"
  stream_analytics_job_name = azurerm_stream_analytics_job.htw.name
  resource_group_name       = azurerm_stream_analytics_job.htw.resource_group_name
  storage_account_name      = azurerm_storage_account.htw-backend.name
  storage_account_key       = azurerm_storage_account.htw-backend.primary_access_key
  storage_container_name    = azurerm_storage_container.htw-stream-analytics-job.name
  path_pattern              = "some-pattern"
  date_format               = "yyyy-MM-dd"
  time_format               = "HH"

  serialization {
    type            = "Csv"
    encoding        = "UTF8"
    field_delimiter = ","
  }
}