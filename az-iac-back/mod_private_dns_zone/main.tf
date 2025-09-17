resource "azurerm_private_dns_zone" "pdnsz" {
  name                = var.azurerm_private_dns_zone_name
  resource_group_name = var.resource_group_name
}
# Setup private-link
resource "azurerm_private_dns_zone_virtual_network_link" "dzvneln" {
  name                  = var.pvt_dnszne_vnet_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pdnsz.name
  virtual_network_id    = var.vnet_id
}
