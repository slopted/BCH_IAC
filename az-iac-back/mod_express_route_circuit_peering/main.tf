# ============================================================
# Express Route Circuit Peering
# ============================================================
resource "azurerm_express_route_circuit_peering" "ercp" {
  peering_type                  = var.peering_type
  express_route_circuit_name    = var.express_route_circuit_name
  resource_group_name           = var.resource_group_name
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  ipv4_enabled                  = var.ipv4_enabled
  route_filter_id               = var.route_filter_id
  shared_key                    = var.shared_key # Masked sensitive attribute
  vlan_id                       = var.vlan_id
}