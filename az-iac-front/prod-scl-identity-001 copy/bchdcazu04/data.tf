data "azurerm_resource_group" "rg-prd-scl-dc-001" {
  name = "rg-prd-scl-dc-001"
}

data "azurerm_virtual_network" "vnet-dcprd-scl-001" {
  name                = "vnet-dcprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-dc-001.name
}

data "azurerm_subnet" "snet-dcprd-addc-001" {
  name                 = "snet-dcprd-addc-001"
  virtual_network_name = data.azurerm_virtual_network.vnet-dcprd-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-dc-001.name
}