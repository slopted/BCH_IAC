resource "azurerm_private_dns_resolver_forwarding_rule" "pdnsrfr" {
  name                      = var.name
  dns_forwarding_ruleset_id = var.dns_forwarding_ruleset_id
  domain_name               = var.domain_name
  enabled                   = var.enabled
  target_dns_servers {
    ip_address = var.target_dns_servers.ip_address
    port       = var.target_dns_servers.port
  }
  metadata = var.metadata
}