resource "azurerm_private_dns_resolver_inbound_endpoint" "pdnsrie" {
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location
  ip_configurations {
    private_ip_allocation_method = var.ip_configurations.private_ip_allocation_method
    subnet_id                    = var.ip_configurations.subnet_id
    private_ip_address           = var.ip_configurations.private_ip_address
  }
  tags = var.tags
}