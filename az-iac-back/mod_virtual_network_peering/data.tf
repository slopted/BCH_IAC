data "azurerm_virtual_network" "vnet_peering_Hub" {
  name                = var.vnet_peering_Hub
  resource_group_name = var.resource_group_name_Hub
  provider            = azurerm.hub
}

data "azurerm_subscription" "subscription_Spoke" {
  subscription_id = var.subscription_id_Spoke
}

data "azurerm_subscription" "subscription_Hub" {
  subscription_id = var.subscription_id_Hub
}

data "azurerm_virtual_network" "vnet_peering_Spoke" {
  name                = var.vnet_peering_Spoke
  resource_group_name = var.resource_group_name_Spoke
  provider            = azurerm.spoke
}