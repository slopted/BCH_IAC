# ============================================================
# Express Route Circuit Peering
# ============================================================
resource "azurerm_express_route_circuit_peering" "example" {
  peering_type                  = var.peering_type
  express_route_circuit_name    = var.express_route_circuit_name
  resource_group_name           = var.resource_group_name
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  ipv4_enabled                  = var.ipv4_enabled
  vlan_id                       = var.vlan_id
  shared_key                    = var.shared_key
  route_filter_id               = var.route_filter_id

  dynamic "microsoft_peering_config" {
    for_each = var.advertised_public_prefixes != null && length(var.advertised_public_prefixes) > 0 ? [1] : []
    content {
      advertised_public_prefixes = var.advertised_public_prefixes
      customer_asn               = var.customer_asn
      routing_registry_name      = var.routing_registry_name
      advertised_communities     = var.advertised_communities
    }
  }

  dynamic "ipv6" {
    for_each = var.ipv6.enabled ? [1] : []
    content {
      primary_peer_address_prefix   = var.ipv6.primary_peer_address_prefix
      secondary_peer_address_prefix = var.ipv6.secondary_peer_address_prefix
      enabled                      = var.ipv6.enabled
      microsoft_peering {
        advertised_public_prefixes = var.ipv6.microsoft_peering.advertised_public_prefixes
        customer_asn               = var.ipv6.microsoft_peering.customer_asn
        routing_registry_name       = var.ipv6.microsoft_peering.routing_registry_name
        advertised_communities      = var.ipv6.microsoft_peering.advertised_communities
      }
    }
  }
}
