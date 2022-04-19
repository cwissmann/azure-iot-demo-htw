variable "resourceGroup" {
  type = string
  description = "Azure resourcegroup where resources will be created"
}

variable "location" {
  type = string
  description = "Azure region where resources will be created"
}

variable "resourcePrefix" {
  type = string
  description = "Resource prefix"
}