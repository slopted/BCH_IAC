variable "name" {
    description = "The name of the Virtual Network Gateway Connection."
    type        = string
}

variable "location" {
    description = "The Azure location where the resource will be created."
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which to create the resource."
    type        = string
}

variable "type" {
    description = "The type of the connection. Possible values are 'IPsec', 'Vnet2Vnet', 'ExpressRoute', or 'VPNClient'."
    type        = string

    validation {
        condition     = contains(["IPsec", "Vnet2Vnet", "ExpressRoute", "VPNClient"], var.type)
        error_message = "The type must be one of: 'IPsec', 'Vnet2Vnet', 'ExpressRoute', or 'VPNClient'."
    }
}

variable "virtual_network_gateway_id" {
    description = "The ID of the Virtual Network Gateway."
    type        = string
}

variable "express_route_circuit_id" {
    description = "The ID of the ExpressRoute Circuit. Required if type is 'ExpressRoute'."
    type        = string
    default     = null
}

variable "routing_weight" {
    description = "The routing weight."
    type        = number
    default     = 10
}

variable "authorization_key" {
    description = "The authorization key for the connection."
    type        = string
    default     = null
}

variable "enable_bgp" {
    description = "Whether BGP is enabled for this connection."
    type        = bool
    default     = false
}

variable "local_azure_ip_address_enabled" {
    description = "Whether the local Azure IP address is enabled."
    type        = bool
    default     = false
}

variable "connection_mode" {
    description = "The connection mode. Possible values are 'Default' or 'ResponderOnly'."
    type        = string
    default     = "Default"
}