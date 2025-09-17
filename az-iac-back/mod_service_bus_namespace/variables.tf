variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "service_bus_namespace_name" {
  description = "service_bus_namespace_name"
  type        = string
}

variable "identity_name" {
  description = "identity_name"
  type        = string
}

variable "identity_type" {
  description = "identity_type"
  type        = string
}

variable "sku_name" {
  description = "sku_name"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

