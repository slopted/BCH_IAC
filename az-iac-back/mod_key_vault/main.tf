data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  enabled_for_disk_encryption   = var.key_vault_enabled_for_disk_encryption
  enable_rbac_authorization     = var.enable_rbac_authorization
  location                      = var.resource_group_location
  name                          = var.key_vault_name
  public_network_access_enabled = var.public_network_access_enabled
  purge_protection_enabled      = var.key_vault_purge_protection_enabled
  resource_group_name           = var.resource_group_name
  sku_name                      = var.sku_name
  tags                          = var.tags
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = var.soft_delete_retention_days

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
      ip_rules                   = network_acls.value.ip_rules
    }
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get"]

    secret_permissions = ["Get", "Set", "Delete", "Recover"]

    storage_permissions = ["Get"]
  }

  dynamic "access_policy" {
    for_each = var.access_policy
    content {
      object_id               = access_policy.value.object_id
      tenant_id               = access_policy.value.tenant_id
      certificate_permissions = access_policy.value.certificate_permissions != null ? access_policy.value.certificate_permissions : []
      key_permissions         = access_policy.value.key_permissions != null ? access_policy.value.key_permissions : []
      secret_permissions      = access_policy.value.secret_permissions != null ? access_policy.value.secret_permissions : []
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "amds" {
  name               = var.monitor_diagnostic_setting_name
  target_resource_id = azurerm_key_vault.kv.id
  storage_account_id = var.storage_account_id

  log {
    category = "AuditEvent"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
