# Setup private-endpoint
resource "azurerm_private_endpoint" "endpoint_sa" {
  name                = var.resource_private_endpoint_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.endpoint_resource_subnet_id  # subnet del resource

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.private_service_connection_subresource_names
    is_manual_connection           = var.private_service_connection_is_manual_connection  # default = false
  }

  private_dns_zone_group {
    name                 = var.pvt_dnszne_grp
    private_dns_zone_ids = var.private_dns_zone_ids
  }

}
