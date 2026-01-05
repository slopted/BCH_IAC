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

variable "private_endpoint_network_policies" {
  description = "Specifies whether private endpoint network policies are enabled or disabled on the subnet. Possible values are 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', or 'RouteTableEnabled'."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "private_endpoint_network_policies must be one of: Disabled, Enabled, NetworkSecurityGroupEnabled, or RouteTableEnabled."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Specifies whether private link service network policies are enabled on the subnet. Possible values are 'true' or 'false'."
  type        = bool
  default     = true
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