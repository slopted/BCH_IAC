variable "resource_group_name_Hub" {
  description = "Name of the hub resource group."
  type        = string
}
variable "resource_group_name_Spoke" {
  description = "Name of the spoke resource group."
  type        = string
}

variable "vnet_peering_Hub" {
  description = "Name of the hub virtual network peering."
  type        = string
}

variable "vnet_peering_Spoke" {
  description = "Name of the spoke virtual network peering."
  type        = string
}

variable "subscription_id_Spoke" {
  description = "Name of the spoke subscription."
  type        = string
}

variable "subscription_id_Hub" {
  description = "Name of the hub subscription."
  type        = string
}

variable "hub_to_spoke" {
  description = "Configuration for hub-to-spoke peering."
  type = object({
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  })
  default = {
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }
}

variable "spoke_to_hub" {
  description = "Configuration for spoke-to-hub peering."
  type = object({
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  })
  default = {
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}