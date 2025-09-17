provider "azurerm" {
  features {}
}

resource "azurerm_user_assigned_identity" "sbn_identity" {
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_servicebus_namespace" "sbn" {
  name                = var.service_bus_namespace_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.sku_name

  identity{
    type = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.sbn_identity.id]
  }

  tags = var.tags
}