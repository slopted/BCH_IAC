data "azurerm_subscription" "prd-connectivity-01" {
  subscription_id = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3"
}

data "azurerm_resource_group" "rg-prd-scl-sec-audit-001" {
  name = "rg-prd-scl-sec-audit-001"
}

data "azurerm_resource_group" "rg-prd-scl-sec-001" {
  name = "rg-prd-scl-sec-001"
}

data "azurerm_resource_group" "rg-prd-scl-hub-001" {
  name = "rg-prd-scl-hub-001"
  #provider = azurerm.connectivity
}

data "azurerm_virtual_network" "vnet-secprd-scl-001" {
  name                = "vnet-secprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-sec-001.name
}

data "azurerm_subnet" "snet-secprd-cstools-001" {
  name                 = "snet-secprd-cstools-001"
  virtual_network_name = data.azurerm_virtual_network.vnet-secprd-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-sec-001.name
}

data "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  #provider            = azurerm.connectivity
}