variable "web_app_name" {
  description = "web_app_name"
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

variable windows_web_app_https_only{
  description = "windows_web_app_https_only"
  type = bool
  default = true
}

variable windows_web_app_pna_enabled{
  description = "windows_web_app_pna_enabled"
  type = bool
  default = false
}

variable "service_plan_name" {
  description = "service_plan_name"
  type        = string
}

variable "publisher_name" {
  description = "publisher_name"
  type        = string
}

variable "publisher_email" {
  description = "publisher_email"
  type        = string
}

variable "api_management_name" {
  description = "api_management_name"
  type        = string
}

variable "sku_name" {
  description = "sku_name"
  type        = string
  default     = "P1v2"
}

variable "connection_string_name" {
  description = "connection_string_name"
  type        = string
  default     = "Database"
}

variable "connection_string_type" {
  description = "connection_string_type"
  type        = string
  default     = "SQLServer"
}

variable "connection_string_value" {
  description = "connection_string_value"
  type        = string
}

variable "current_stack" {
  description = "current_stack"
  type        = string
  default     = "dotnet"
}

variable "dotnet_version" {
  description = "dotnet_version"
  type        = string
  default     = "v4.0"
}

variable "azurerm_api_management_api_name" {
  description = "azurerm_api_management_api_name"
  type        = string
}

variable "azurerm_api_management_api_revision" {
  description = "azurerm_api_management_api_revision"
  type        = string
}

variable "azurerm_api_management_api_display_name" {
  description = "azurerm_api_management_api_display_name"
  type        = string
}


variable "azurerm_api_management_api_path" {
  description = "azurerm_api_management_api_path"
  type        = string
}

variable "azurerm_api_management_api_content_format" {
  description = "azurerm_api_management_api_content_format"
  type        = string
}

variable "azurerm_api_management_api_content_value" {
  description = "azurerm_api_management_api_content_value"
  type        = string
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

variable "azurerm_api_management_api_protocols" {
  description = "azurerm_api_management_api_protocols"
  type        = list(string)
  default     = ["https"]
}

variable "virtual_network_subnet_id" {
  description = "virtual_network_subnet_id"
  type = string
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "app_settings" {
  description = "app_settings"
  type        = map
  default     = null
}
