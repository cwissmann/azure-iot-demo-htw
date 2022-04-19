terraform {
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.2.0"
        }
        azuread = {
        source = "hashicorp/azuread"
        version = "2.20.0"
     }
    }
    required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {
}

data "azuread_client_config" "current" {
}

resource "azurerm_resource_group" "dev" {
  name     = var.resourceGroup
  location = var.location
}