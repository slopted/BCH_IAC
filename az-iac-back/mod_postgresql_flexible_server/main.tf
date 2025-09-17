resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  zone                = var.zone
  sku_name            = var.sku_name
  tags                = var.tags

  public_network_access_enabled = false

}

resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_name != null ? 1 : 0

  name                          = var.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "${var.private_endpoint_name}-nic"
  tags                          = var.tags

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = var.private_dns_zone_ids
  }

  private_service_connection {
    name                           = var.private_endpoint_name
    private_connection_resource_id = azurerm_postgresql_flexible_server.this.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  depends_on = [azurerm_postgresql_flexible_server.this]
}
