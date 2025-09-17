resource "azurerm_api_management_subscription" "ams" {
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name        = "OpenAI API Subscription for ${var.api_management_name}"
  state               = var.state
  api_id              = var.api_id != null ? var.api_id : null
}
