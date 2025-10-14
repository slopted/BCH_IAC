variable "name" {
  description = "The name of the subnet."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which the subnet belongs."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "delegation" {
  description = "A delegation block as defined in the azurerm_subnet resource."
  type = object({
    name = string
    service_delegation = object({
      actions = list(string)
      name    = string
    })
  })
  default = null
}