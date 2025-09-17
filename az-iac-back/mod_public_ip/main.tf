resource "azurerm_public_ip" "this" {
  name                    = lower("pip-${var.name}")
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = var.allocation_method
  sku                     = var.sku
  domain_name_label       = var.domain_name_label
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id #ddos_protection_mode == "Enabled" ? var.ddos_protection_plan_id : null
  tags                    = var.tags
}
