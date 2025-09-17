variable "name" {
  description = "name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "enable_accelerated_networking" {
  description = "enable_accelerated_networking"
  type        = bool
  default     = true
}

variable "ip_configuration_name" {
  description = "ip_configuration_name"
  type        = string
}

variable "ip_configuration_subnet_id" {
  description = "ip_configuration_subnet_id"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "private_ip_address_allocation"
  type        = string
  default     = "Dynamic"
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "network_security_group_id" {
  description = "network_security_group_id"
  type        = string
}