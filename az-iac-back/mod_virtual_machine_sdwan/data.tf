data "azurerm_resource_group" "rg-hub" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet-hub" {
  name                = var.data.vnet-hub-name
  resource_group_name = data.azurerm_resource_group.rg-hub.name
}

data "azurerm_subnet" "snet-hub-sdwan-untrust" {
  name                 = var.data.snet-hub-sdwan-untrust-name
  virtual_network_name = data.azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.rg-hub.name
}

data "azurerm_subnet" "snet-hub-sdwan-trust" {
  name                 = var.data.snet-hub-sdwan-trust-name
  virtual_network_name = data.azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.rg-hub.name
}

data "azurerm_subnet" "snet-hub-sdwan-ha" {
  name                 = var.data.snet-hub-sdwan-ha-name
  virtual_network_name = data.azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.rg-hub.name
}

data "azurerm_subnet" "snet-hub-sdwan-mgmt" {
  name                 = var.data.snet-hub-sdwan-mgmt-name
  virtual_network_name = data.azurerm_virtual_network.vnet-hub.name
  resource_group_name  = data.azurerm_resource_group.rg-hub.name
}