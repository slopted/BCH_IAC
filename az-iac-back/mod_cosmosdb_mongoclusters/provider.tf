terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.63.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

