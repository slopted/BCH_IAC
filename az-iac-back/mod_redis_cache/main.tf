resource "azurerm_redis_cache" "redis" {
  name                = lower(var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version
  # replicas_per_master = var.replicas_per_master
  tags                = var.tags

  redis_configuration {
    maxmemory_reserved = var.redis_configuration.maxmemory_reserved
    maxmemory_delta    = var.redis_configuration.maxmemory_delta
    maxmemory_policy   = var.redis_configuration.maxmemory_policy
  }

  identity {
      type = var.identity.type
      # identity_ids =  identity.value.identity_type == "UserAssigned" ? [azurerm_user_assigned_identity.lwa_identity[0].id] : null
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
