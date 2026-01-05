variable "namespace_name" {
  description = "The name of the Event Hub Namespace."
  type        = string
}

variable "location" {
  description = "The Azure location where the Event Hub Namespace will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Event Hub Namespace."
  type        = string
}

variable "sku" {
  description = "The SKU for the Event Hub Namespace."
  type        = string
}

variable "capacity" {
  description = "The capacity of the Event Hub Namespace. Applies to certain SKUs."
  type        = number
  default     = null
}

variable "auto_inflate_enabled" {
  description = "Is Auto Inflate enabled for the Event Hub Namespace?"
  type        = bool
  default     = false
}

variable "dedicated_cluster_id" {
  description = "The ID of the dedicated cluster for the Event Hub Namespace."
  type        = string
  default     = null
}

variable "maximum_throughput_units" {
  description = "The maximum throughput units for the Event Hub Namespace."
  type        = number
  default     = null
}

variable "local_authentication_enabled" {
  description = "Is local authentication enabled for the Event Hub Namespace?"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the Event Hub Namespace?"
  type        = bool
  default     = true
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the Event Hub Namespace."
  type        = string
  default     = "1.2"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = <<DESCRIPTION
  Controls the Managed Identity configuration on this resource. The following properties can be specified:

  - `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.
  - `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource.
  DESCRIPTION
  nullable    = false
}

variable "network_rulesets" {
  type = object({
    default_action                 = optional(string, "Deny")
    public_network_access_enabled  = bool
    trusted_service_access_enabled = bool
    ip_rule = optional(list(object({
      # since the `action` property only permits `Allow`, this is hard-coded.
      action  = optional(string, "Allow")
      ip_mask = string
    })), [])
    virtual_network_rule = optional(list(object({
      # since the `action` property only permits `Allow`, this is hard-coded.
      ignore_missing_virtual_network_service_endpoint = optional(bool)
      subnet_id                                       = string
    })), [])
  })
  default     = null
  description = <<DESCRIPTION
The network rule set configuration for the resource.
Requires Premium SKU.

- `default_action` - (Optional) The default action when no rule matches. Possible values are `Allow` and `Deny`. Defaults to `Deny`.
- `ip_rule` - (Optional) A list of IP rules in CIDR format. Defaults to `[]`.
  - `action` - Only "Allow" is permitted
  - `ip_mask` - The CIDR block from which requests will match the rule.
- `virtual_network_rule` - (Optional) When using with Service Endpoints, a list of subnet IDs to associate with the resource. Defaults to `[]`.
  - `ignore_missing_virtual_network_service_endpoint` - Are missing virtual network service endpoints ignored?
  - `subnet_id` - The subnet id from which requests will match the rule.

DESCRIPTION

  validation {
    condition     = var.network_rulesets == null ? true : contains(["Allow", "Deny"], var.network_rulesets.default_action)
    error_message = "The default_action value must be either `Allow` or `Deny`."
  }
}





variable "eventhub_name" {
  description = "The name of the Event Hub."
  type        = string
}

variable "partition_count" {
  description = "The number of partitions for the Event Hub."
  type        = number
}

variable "message_retention" {
  description = "The number of days to retain messages in the Event Hub."
  type        = number
}

variable "status" {
  description = "The status of the Event Hub."
  type        = string
  default     = "Active"
}

variable "retention_description" {
  description = "The retention description block for the Event Hub."
  type = object({
    cleanup_policy                    = string
    retention_time_in_hours           = number
    tombstone_retention_time_in_hours = number
  })
  default = null
}

variable "capture_description" {
  description = "The capture description block for the Event Hub."
  type = object({
    enabled             = bool
    encoding            = string
    interval_in_seconds = number
    size_limit_in_bytes = number
    skip_empty_archives = bool
    destination = object({
      name                = string
      archive_name_format = string
      blob_container_name = string
      storage_account_id  = string
    })
  })
  default = null
}