data "azurerm_resource_group" "rg-prd-scl-hub-001" {
  name = "rg-prd-scl-hub-001"
}

data "azurerm_virtual_network" "vnet-hubprd-scl-001" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
}

data "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = data.azurerm_virtual_network.vnet-hubprd-scl-001.name
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
}
/*
import {
  to = module.vng-prd-scl-001.resource.azurerm_virtual_network_gateway.vng
  id = "/subscriptions/0bf6c8d9-16da-4233-8bca-2c16e2733205/resourceGroups/rg-prd-scl-hub-001/providers/Microsoft.Network/routeTables/route-prd-gateway-01"
}*/