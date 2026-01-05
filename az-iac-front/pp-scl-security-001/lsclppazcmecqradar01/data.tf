data "azurerm_resource_group" "rg-pp-scl-sec-001" {
  name = "rg-pp-scl-sec-001"
}

data "azurerm_subnet" "snet-secpp-cstools-001" {
  name                 = "snet-secpp-cstools-001"
  virtual_network_name = "vnet-secpp-scl-001"
  resource_group_name  = data.azurerm_resource_group.rg-pp-scl-sec-001.name
}
