
resource "azurerm_container_registry" "acr" {
  admin_enabled         = true
  data_endpoint_enabled = var.data_endpoint_enabled
  name                  = replace(lower(trimspace("${var.name}")), "-", "")
  network_rule_set    = var.sku == "Premium" ? var.network_rule_set : []
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  quarantine_policy_enabled = var.quarantine_policy_enabled
  tags                = var.tags

  # ACR geo-replication can only be applied when using the Premium Sku.
  dynamic "georeplications" {
    for_each = var.georeplication_locations != null && var.sku == "Premium" ? var.georeplication_locations : []

    content {
      location                  = try(georeplications.value.location, georeplications.value)
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
      tags                      = try(georeplications.value.tags, null)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, null)
    }
  }

  lifecycle {
    precondition {
      condition     = !var.data_endpoint_enabled || var.sku == "Premium"
      error_message = "Premium SKU is mandatory to enable the data endpoints."
    }
  }
  
  retention_policy {
    enabled = var.retention_policy_enabled
    days    = var.retention_policy_days
  }


}
