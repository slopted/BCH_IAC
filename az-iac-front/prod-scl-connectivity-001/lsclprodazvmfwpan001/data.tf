data "azurerm_resource_group" "rg" {
  name = "rg-prd-scl-hub-001"
}

data "azurerm_virtual_network" "vnet_hubprd" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_mgmt" {
  name                 = "snet-hubprd-fwpl-mgmt-001"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_trust" {
  name                 = "snet-hubprd-fwpl-trust-001"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_untrust1" {
  name                 = "snet-hubprd-fwpl-untrust-001"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_untrust2" {
  name                 = "snet-hubprd-fwpl-untrust-002"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}
