###############################################################
#                Azure Event Hub Namespace Module             #
###############################################################

resource "azurerm_eventhub_namespace" "eh_nmspace" {
  name                          = var.namespace_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  auto_inflate_enabled          = var.auto_inflate_enabled
  dedicated_cluster_id          = var.dedicated_cluster_id
  maximum_throughput_units      = var.maximum_throughput_units
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version
  tags                          = var.tags

 dynamic "identity" {
    for_each = var.managed_identities != {} ? { this = var.managed_identities } : {}

    content {
      type         = identity.value.system_assigned && length(identity.value.user_assigned_resource_ids) > 0 ? "SystemAssigned, UserAssigned" : length(identity.value.user_assigned_resource_ids) > 0 ? "UserAssigned" : "SystemAssigned"
      identity_ids = identity.value.user_assigned_resource_ids
    }
  }

  dynamic "network_rulesets" {
    for_each = var.network_rulesets != null ? { this = var.network_rulesets } : {}

    content {
      default_action                 = network_rulesets.value.default_action
      public_network_access_enabled  = network_rulesets.value.public_network_access_enabled
      trusted_service_access_enabled = network_rulesets.value.trusted_service_access_enabled

      dynamic "ip_rule" {
        for_each = network_rulesets.value.ip_rule

        content {
          action  = ip_rule.value.action
          ip_mask = ip_rule.value.ip_mask
        }
      }
      dynamic "virtual_network_rule" {
        for_each = network_rulesets.value.virtual_network_rule

        content {
          ignore_missing_virtual_network_service_endpoint = virtual_network_rule.value.ignore_missing_virtual_network_service_endpoint
          subnet_id                                       = virtual_network_rule.value.subnet_id
        }
      }
    }
  }
}

###############################################################
#                    Azure Event Hub Module                   #
###############################################################

resource "azurerm_eventhub" "eh" {
  depends_on        = [resource.azurerm_eventhub_namespace.eh_nmspace]
  name              = var.eventhub_name
  namespace_id      = azurerm_eventhub_namespace.eh_nmspace.id
  partition_count   = var.partition_count
  message_retention = var.message_retention
  status            = var.status

  dynamic "retention_description" {
    for_each = var.retention_description != null ? [var.retention_description] : []
    content {
      cleanup_policy                    = retention_description.value.cleanup_policy
      retention_time_in_hours           = retention_description.value.retention_time_in_hours
      tombstone_retention_time_in_hours = retention_description.value.tombstone_retention_time_in_hours
    }
  }

  dynamic "capture_description" {
    for_each = var.capture_description != null ? [var.capture_description] : []
    content {
      enabled             = capture_description.value.enabled
      encoding            = capture_description.value.encoding
      interval_in_seconds = capture_description.value.interval_in_seconds
      size_limit_in_bytes = capture_description.value.size_limit_in_bytes
      skip_empty_archives = capture_description.value.skip_empty_archives

      dynamic "destination" {
        for_each = capture_description.value.destination != null ? [capture_description.value.destination] : []
        content {
          name                = capture_description.value.destination.name
          archive_name_format = capture_description.value.destination.archive_name_format
          blob_container_name = capture_description.value.destination.blob_container_name
          storage_account_id  = capture_description.value.destination.storage_account_id
        }
      }
    }
  }
}