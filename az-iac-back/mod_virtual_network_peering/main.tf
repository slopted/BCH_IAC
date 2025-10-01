resource "azurerm_virtual_network_peering" "vnet-peer-hub-spoke" {
  name                         = local.Hub_to_Spoke_Peering_Name
  resource_group_name          = var.resource_group_name_Hub
  virtual_network_name         = data.azurerm_virtual_network.vnet_peering_Hub.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_peering_Spoke.id
  allow_virtual_network_access = var.hub_to_spoke.allow_virtual_network_access
  allow_forwarded_traffic      = var.hub_to_spoke.allow_forwarded_traffic
  allow_gateway_transit        = var.hub_to_spoke.allow_gateway_transit
  use_remote_gateways          = var.hub_to_spoke.use_remote_gateways
  provider                     = azurerm.hub
}

resource "azurerm_virtual_network_peering" "vnet-peer-spoke-hub" {
  name                         = local.Spoke_to_Hub_Peering_Name
  resource_group_name          = var.resource_group_name_Spoke
  virtual_network_name         = data.azurerm_virtual_network.vnet_peering_Spoke.name
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet_peering_Hub.id
  allow_virtual_network_access = var.spoke_to_hub.allow_virtual_network_access
  allow_forwarded_traffic      = var.spoke_to_hub.allow_forwarded_traffic
  allow_gateway_transit        = var.spoke_to_hub.allow_gateway_transit
  use_remote_gateways          = var.spoke_to_hub.use_remote_gateways
  provider                     = azurerm.spoke
}