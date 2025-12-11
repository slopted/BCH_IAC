resource "azurerm_virtual_desktop_application_group" "vdag" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  type                         = var.type
  host_pool_id                 = var.host_pool_id
  friendly_name                = var.friendly_name
  default_desktop_display_name = var.default_desktop_display_name
  description                  = var.description
  tags                         = var.tags
}