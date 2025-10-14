variable "name" {
  description = "The name of the Private DNS Resolver."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Private DNS Resolver."
  type        = string
}

variable "location" {
  description = "The Azure location where the Private DNS Resolver will be created."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link with the Private DNS Resolver."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}