
resource "random_integer" "this" {
  max = 999999
  min = 100000
}
locals {
  account_name          = coalesce(var.cognitive_account_name, "azure-openai-${random_integer.this.result}")
  custom_subdomain_name = coalesce(var.custom_subdomain_name, "azure-openai-${random_integer.this.result}")
}
resource "azurerm_user_assigned_identity" "ca_identity" {
  count               = var.identity_name != null ? 1 : 0
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_cognitive_account" "ca" {
  custom_subdomain_name         = local.custom_subdomain_name
  kind                          = var.cognitive_account_kind
  local_auth_enabled            = var.local_auth_enabled
  location                      = var.resource_group_location
  name                          = var.cognitive_account_name
  resource_group_name           = var.resource_group_name
  public_network_access_enabled = var.cognitive_account_pna_enabled
  sku_name                      = var.cognitive_account_sku_name
  tags                          = var.tags

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id   = customer_managed_key.value.key_vault_key_id
      identity_client_id = customer_managed_key.value.identity_client_id
    }
  }

  network_acls {
    default_action = var.acls_default_action
    virtual_network_rules {
      subnet_id = var.acls_subnet_id
    }
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? [azurerm_user_assigned_identity.ca_identity[0].id] : null
  }
}
