terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.64.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  alias           = "spoke"
  subscription_id = data.azurerm_subscription.subscription_Spoke.subscription_id
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  alias           = "hub"
  subscription_id = data.azurerm_subscription.subscription_Hub.subscription_id
}
