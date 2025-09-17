variable "app_name" {
  description = "App Name of the azure web app service"
  type        = string
}

variable "app_sku_name" {
  description = "The SKU name of the azure web app service"
  type        = string
  default     = "B1"

  validation {
    condition = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3",
      "I1v2", "I2v2", "I3v2", "I4v2", "I5v2", "I6v2", "P1v2", "P2v2", "P3v2", "P0v3",
      "P1v3", "P2v3", "P3v3", "P1mv3", "P2mv3", "P3mv3", "P4mv3", "P5mv3", "S1", "S2", "S3",
    "SHARED", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3", "Y1"], var.app_sku_name)
    error_message = "The value of 'app_sku_name' must be..."
  }
}

variable "resource_group_location" {
  description = "Location of resource group of the azure web app service"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group of the azure web app service"
  type        = string
}

variable "app_os_type" {
  description = "OS of the azure web app service"
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"], var.app_os_type)
    error_message = "The value of 'app_os_type' must be..."
  }
}

variable "tags" {
  description = "Tags to apply to the azure web app service"
  type        = map(string)
  default     = {}
}

variable "identity" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Linux Web App"
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity)
    error_message = "The value of 'identity' must be..."
  }
}

variable "app_settings" {
  description = "Settings env of the azure web app service"
  type        = map(string)
  default     = {}
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

variable "publisher_name" {
  description = "publisher_name"
  type        = string
}

variable "publisher_email" {
  description = "publisher_email"
  type        = string
}

variable "app_command_line"{
  description = "app_command_line"
  type = string
  default = null
}

variable "remote_debugging_enabled" {
  description = "remote_debugging_enabled"
  type        = bool
  default     = false
}

variable "vnet_route_all_enabled" {
  description = "vnet_route_all_enabled"
  type        = bool
  default     = false
}

#variable "maximum_elastic_worker_count" {
#  description = "maximum_elastic_worker_count"
#  type        = number
#  default     = 10
#}

variable "per_site_scaling_enabled" {
  description = "per_site_scaling_enabled"
  type        = bool
  default     = false
}

variable "worker_count" {
  description = "worker_count"
  type        = number
  default     = 1
}

variable "virtual_network_subnet_id" {
  description = "virtual_network_subnet_id"
  type        = string
}

variable "dotnet_version" {
  description = "dotnet_version"
  type        = string
  default     = null
}

variable "go_version" {
  description = "go_version"
  type        = string
  default     = null
}

variable "node_version" {
  description = "node_version"
  type        = string
  default     = null
}

variable "python_version" {
  description = "python_version"
  type        = string
  default     = null
}

variable "ruby_version" {
  description = "ruby_version"
  type        = string
  default     = null
}

variable "allowed_origins" {
  type    = list(string)
  default = []
}

#variable "kind" {
#  type    = string
#  default = "Linux"
#}