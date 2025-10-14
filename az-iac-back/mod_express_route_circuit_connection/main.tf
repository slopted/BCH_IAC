# ============================================================
# Express Route Circuit
# ============================================================
resource "azurerm_express_route_circuit" "erc" {
  allow_classic_operations = var.allow_classic_operations
  authorization_key        = var.authorization_key # Masked sensitive attribute
  bandwidth_in_gbps        = var.bandwidth_in_gbps
  bandwidth_in_mbps        = var.bandwidth_in_mbps
  location                 = var.location
  name                     = var.name
  peering_location         = var.peering_location
  rate_limiting_enabled    = var.rate_limiting_enabled
  resource_group_name      = var.resource_group_name
  service_key              = var.service_key # Masked sensitive attribute
  service_provider_name    = var.service_provider_name
  tags                     = var.tags
  sku {
    family = var.sku.family
    tier   = var.sku.tier
  }
}