# Setup private-endpoint
resource "azurerm_private_endpoint" "pe" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id # subnet del resource
  custom_network_interface_name = var.custom_network_interface_name

  private_service_connection {
    name                           = var.psc.name
    private_connection_resource_id = var.psc.private_connection_resource_id
    subresource_names              = var.psc.subresource_names
    is_manual_connection           = var.psc.is_manual_connection # default = false
  }

  private_dns_zone_group {
    name                 = var.pvt_dnsz_grp.name
    private_dns_zone_ids = var.pvt_dnsz_grp.private_dns_zone_ids
  }
}
