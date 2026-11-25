terraform {
  required_version = ">= 1.11.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}
