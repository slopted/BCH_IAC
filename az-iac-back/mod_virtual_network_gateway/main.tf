# ============================================================
# Virtual Network Gateway
# ============================================================
resource "azurerm_virtual_network_gateway" "vng" {
  name                                  = var.name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  active_active                         = var.active_active
  bgp_route_translation_for_nat_enabled = var.bgp_route_translation_for_nat_enabled
  dns_forwarding_enabled                = var.dns_forwarding_enabled
  edge_zone                             = var.edge_zone
  enable_bgp                            = var.enable_bgp
  generation                            = var.generation
  ip_sec_replay_protection_enabled      = var.ip_sec_replay_protection_enabled
  private_ip_address_enabled            = var.private_ip_address_enabled
  remote_vnet_traffic_enabled           = var.remote_vnet_traffic_enabled
  sku                                   = var.sku
  tags                                  = var.tags
  type                                  = var.type
  virtual_wan_traffic_enabled           = var.virtual_wan_traffic_enabled
  vpn_type                              = var.vpn_type
  ip_configuration {
    name                          = var.ip_configuration_name
    private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
    subnet_id                     = var.ip_configuration_subnet_id
    public_ip_address_id          = var.ip_configuration_public_ip_address_id
  }
}