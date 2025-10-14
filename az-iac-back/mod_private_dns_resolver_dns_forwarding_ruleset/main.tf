resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "pdnsrdnsfr" {
  name                                       = var.name
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = var.private_dns_resolver_outbound_endpoint_ids
  tags                                       = var.tags
}