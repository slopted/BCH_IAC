variable "name" {
  description = "name"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "virtual_network_name" {
  description = "virtual_network_name"
  type        = string
}

variable "address_prefixes" {
  description = "address_prefixes"
  type        = list(string)
}
