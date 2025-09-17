variable "name" {
  description = "name"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "service_plan_name" {
  description = "service_plan_name"
  type        = string
}

variable "identity_name" {
  description = "identity_name"
  type        = string
}

variable "sa_identity_name" {
  description = "sa_identity_name"
  type        = string
}

variable "identity_type" {
  description = "identity_type"
  type        = string
  default     = "SystemAssigned"
}

variable "storage_account_name" {
  description = "storage_account_name"
  type        = string
}

variable "python_version" {
  description = "python_version"
  type        = string
  default     = "3.9"
}

variable "storage_account_primary_access_key" {
  description = "storage_account_primary_access_key"
  type        = string
}

variable linux_function_app_https_only{
  description = "windows_web_app_https_only"
  type = bool
  default = true
}

variable linux_function_app_pna_enabled{
  description = "windows_web_app_pna_enabled"
  type = bool
  default = false
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "linux_function_app_settings" {
  description = "app_settings"
  type        = map
  default     = null
}

variable "sku_name" {
  description = "sku_name"
  type        = string
  default = "Y1"
}



