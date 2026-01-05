terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3"
}
/*
provider "azurerm" {
  features {}
  alias = "connectivity"
  subscription_id = data.azurerm_subscription.prd-connectivity-01.id
}*/