variable "key_vault_name" {
  description = "key_vault_name"
  type        = string
}
variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}
variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}
variable "tags" {
  description = "tags"
  type        = map
  default     = null
}
variable key_vault_soft_delete_retention_days {
  description = "key_vault_soft_delete_retention_days"
  type        = number
  default     = 7
}
variable key_vault_purge_protection_enabled {
  description = "key_vault_purge_protection_enabled"
  type        = bool
}
variable sku_name {
  description = "sku_name"
  type = string
}
variable key_vault_pna_enabled{
  description = "key_vault_pna_enabled"
  type = bool
  default = false
}
variable "public_network_access_enabled" {
  description = "public_network_access_enabled"
  type        = bool
  default     = false
}
variable "network_acls" {
  description = "network_acls"
  type = object({
    bypass                     = string
    default_action             = string
    virtual_network_subnet_ids = optional(list(string))
    ip_rules                   = optional(list(string))
  })
  default = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = []
    ip_rules                   = []
  }
}
variable "access_policy" {
  description = "access_policy"
  type = list(object({
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    object_id               = string
    tenant_id               = string
  }))
  default = []
}
variable "tenant_id" {
  description = "tenant_id"
  type = string
}
variable "enable_rbac_authorization" {
  description = "enable_rbac_authorization"
  type        = bool
  default     = false
}
variable "key_vault_enabled_for_disk_encryption" {
  description = "key_vault_enabled_for_disk_encryption"
  type        = bool
  default     = false
}
variable "soft_delete_retention_days" {
  description = "soft_delete_retention_days"
  type        = number
  default     = 7
}
variable "monitor_diagnostic_setting_name" {
  description = "monitor_diagnostic_setting_name"
  type        = string
}
variable "storage_account_id" {
  description = "The ID of the storage account for diagnostic logs"
  type        = string
}