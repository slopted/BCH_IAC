resource "azurerm_virtual_network_peering" "vnet-peer-hub-spoke" {
  name                         = local.Hub_to_Spoke_Peering_Name
  resource_group_name          = var.resource_group_name_Hub
  virtual_network_name         = data.azurerm_virtual_network.vnet_peering_Hub.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_peering_Spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
  provider                     = azurerm.hub
}

resource "azurerm_virtual_network_peering" "vnet-peer-spoke-hub" {
  name                         = local.Spoke_to_Hub_Peering_Name
  resource_group_name          = var.resource_group_name_Spoke
  virtual_network_name         = data.azurerm_virtual_network.vnet_peering_Spoke.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_peering_Hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = true
  provider                     = azurerm.spoke
}