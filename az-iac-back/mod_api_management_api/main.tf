resource "azurerm_api_management_api" "ama" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  api_management_name   = var.api_management_name
  revision              = var.revision
  display_name          = var.display_name
  path                  = var.path
  protocols             = var.protocols
  service_url           = var.service_url
  subscription_required = var.subscription_required

  import {
    content_format = lookup(var.import, "content_format", "openapi-link")
    content_value  = lookup(var.import, "content_value", "https://example.com/swagger.json")
  }
}
