resource "azurerm_api_management" "am" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  sku_name                      = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  identity {
    type         = lookup(var.identity, "type", null)
    identity_ids = lookup(var.identity, "identity_ids", null)
  }

  public_ip_address_id = var.public_ip_address_id

  virtual_network_type = lookup(var.virtual_network_configuration, "type", "None")

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_configuration.type != "None" ? [1] : []

    content {
      subnet_id = lookup(var.virtual_network_configuration, "subnet_id", null)
    }
  }
}
