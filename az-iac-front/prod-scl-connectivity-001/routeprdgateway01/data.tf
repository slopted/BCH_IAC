data "azurerm_resource_group" "rg-prd-scl-hub-001" {
  name = "rg-prd-scl-hub-001"
}

data "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = "vnet-hubprd-scl-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name  
}

import {
  to = module.route-prd-gateway-01.azurerm_route_table.rtb
  id = "/subscriptions/67e8f9c1-a3d9-405e-b72d-43e7c16a46d3/resourceGroups/rg-prd-scl-hub-001/providers/Microsoft.Network/routeTables/route-prd-gateway-01"
}