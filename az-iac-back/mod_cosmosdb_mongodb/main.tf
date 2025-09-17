resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_user_assigned_identity" "this" {
  count = var.identity_name != null ? 1 : 0

  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_cosmosdb_account" "cosmon" {
  name                          = "cosmon-${var.name}-${random_integer.ri.result}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  offer_type                    = var.offer_type
  kind                          = var.kind
  enable_automatic_failover     = var.enable_automatic_failover
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  ip_range_filter               = var.ip_range_filter

  dynamic "capabilities" {
    for_each = var.capabilities_names
    content {
      name = capabilities.value
    }
  }

  consistency_policy {
    consistency_level = "Strong"
  }

  geo_location {
    location          = "westus"
    failover_priority = 0
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? [azurerm_user_assigned_identity.this[0].id] : null
  }

  dynamic "virtual_network_rule" {
    for_each = var.lst_virtual_network_rule
    content {
        # Add missing argument or block definition here
        id = virtual_network_rule.value["id"]
        ignore_missing_vnet_service_endpoint = virtual_network_rule.value["ignore_missing_vnet_service_endpoint"]
    }
  }
}
