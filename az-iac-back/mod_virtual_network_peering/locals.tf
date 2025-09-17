locals {
  Hub_to_Spoke_Peering_Name = "hub-to-spoke-${data.azurerm_virtual_network.vnet_peering_Spoke.name}-peering"
  Spoke_to_Hub_Peering_Name = "spoke-to-hub-${data.azurerm_virtual_network.vnet_peering_Hub.name}-peering"
}