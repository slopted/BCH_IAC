resource "azurerm_postgresql_flexible_server" "res-0" {
  location                      = var.resource_location #"eastus"
  name                          = var.resource_name #"az-eastus-dev-langfuse-postgresql-aihub-001-server"
  public_network_access_enabled = var.public_network_access_enabled #false
  resource_group_name           = var.resource_group_name #"rg-chatbot-sarai-dev"
  tags = {
    responsable = "PabloCisterna"
  }
  zone = "1"
}
resource "azurerm_private_endpoint" "res-1" {
  custom_network_interface_name = "pg_pe_aihub_v2-nic"
  location                      = "eastus"
  name                          = "pg_pe_aihub_v2"
  resource_group_name           = "rg-chatbot-sarai-dev"
  subnet_id                     = "/subscriptions/25002e42-ecf0-4876-afca-ad568fc370df/resourceGroups/rg-chatbot-sarai-dev/providers/Microsoft.Network/virtualNetworks/iahub-v2-dev-vnet/subnets/iahub-v2-snet-postgresql"
  tags = var.tags
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["/subscriptions/25002e42-ecf0-4876-afca-ad568fc370df/resourceGroups/rg-chatbot-sarai-dev/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com"]
  }
  private_service_connection {
    name                           = "pg_pe_aihub_v2"
    private_connection_resource_id = "/subscriptions/25002e42-ecf0-4876-afca-ad568fc370df/resourceGroups/rg-chatbot-sarai-dev/providers/Microsoft.DBforPostgreSQL/flexibleServers/az-eastus-dev-langfuse-postgresql-aihub-001-server"
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
  depends_on = [
    azurerm_postgresql_flexible_server.res-0,
  ]
}
