variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "storage_account_name" {
  description = "storage_account_name"
  type        = string
}

variable "storage_account_account_tier" {
  description = "storage_account_account_tier"
  type        = string
}

variable "storage_account_replication_type" {
  description = "storage_account_replication_type"
  type        = string
}

variable storage_account_pna_enabled{
  description = "storage_account_pna_enabled"
  type = bool
  default = false
}

variable "identity_name" {
  description = "identity_name"
  type        = string
  default     = null 
}

variable "identity_type" {
  description = "identity_type"
  type        = string
}

variable "storage_private_nic_name" {
  description = "storage_private_nic_name"
  type        = string
}

variable "nic_ip_config_name" {
  description = "nic_ip_config_name"
  type        = string
}

variable "nic_ip_config_subnet_id" {
  description = "nic_ip_config_subnet_id"
  type        = string
}

variable "nic_ipconfig_priv_ip_addr_alloc" {
  description = "nic_ipconfig_priv_ip_addr_alloc"
  type        = string
  default     = "Dynamic"
}

variable "storage_private_endpoint_name" {
  description = "storage_private_endpoint_name"
  type        = string
}

variable "endpoint_storage_account_subnet_id" {
  description = "endpoint_storage_account_subnet_id"
  type        = string
}

variable "private_service_connection_name" {
  description = "private_service_connection_name"
  type        = string
}

variable "private_service_connection_is_manual_connection" {
  description = "private_service_connection_is_manual_connection"
  type        = string
  default = "false"
}

variable "private_service_connection_subresource_names" {
  description = "private_service_connection_subresource_names"
  type        = list
  default     = ["queue"]
}

#variable "azurerm_private_dns_zone_name" {
#  description = "azurerm_private_dns_zone_name"
#  type        = string
#  default = "privatelink.queue.core.windows.net"
#}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

#Cambios aplicados
variable "pvt_dnszne_grp" {
  description = "pvt_dnszne_grp"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "private_dns_zone_ids"
  type        = list
}