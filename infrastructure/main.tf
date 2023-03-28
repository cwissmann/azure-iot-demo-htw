terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.49.0"
        }
        azuread = {
        source = "hashicorp/azuread"
        version = "2.36.0"
     }
    }
    required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

data "azuread_client_config" "current" {
}

resource "azurerm_resource_group" "iotdemo" {
  name     = var.resourceGroup
  location = var.location
  tags = {
    "Application" = "IoT-Demo"
  }
}