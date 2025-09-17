data "azurerm_resource_group" "rg-pp-scl-dc-001" {
  name = "rg-pp-scl-dc-001"
}

data "azurerm_virtual_network" "vnet-dcpp-scl-001" {
  name                = "vnet-dcpp-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
}

data "azurerm_subnet" "snet-dcpp-addc-001" {
  name                 = "snet-dcpp-addc-001"
  virtual_network_name = data.azurerm_virtual_network.vnet-dcpp-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-pp-scl-dc-001.name
}