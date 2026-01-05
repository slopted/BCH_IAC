##################################################
# prd-shared-01
##################################################
data "azurerm_resource_group" "rg-prd-scl-shared-001" {
  name = "rg-prd-scl-shared-001"
}

data "azurerm_virtual_network" "vnet-sharedprd-scl-001" {
  name                = "vnet-sharedprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-shared-001.name
}

data "azurerm_subnet" "snet-sharedprd-lbserv-001" {
  name                 = "snet-sharedprd-lbserv-001"
  virtual_network_name = data.azurerm_virtual_network.vnet-sharedprd-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-shared-001.name
}

data "azurerm_subnet" "snet-sharedprd-serv-001" {
  name                 = "snet-sharedprd-serv-001"
  virtual_network_name = data.azurerm_virtual_network.vnet-sharedprd-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-shared-001.name
}

data "azurerm_resource_group" "rg-prd-scl-hub-001" {
  provider = azurerm.prd-connectivity-01
  name     = "rg-prd-scl-hub-001"
}

data "azurerm_firewall" "azfw-prd-scl" {
  provider            = azurerm.prd-connectivity-01
  name                = "azfw-prd-scl"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
}