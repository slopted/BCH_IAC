variable "name" {
  description = "The name of the Virtual Network Gateway."
  type        = string
  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 80
    error_message = "Name must be between 1 and 80 characters."
  }
}

variable "location" {
  description = "The Azure location where the Virtual Network Gateway will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "active_active" {
  description = "Is Active-Active mode enabled?"
  type        = bool
  default     = false
}

variable "bgp_route_translation_for_nat_enabled" {
  description = "Is BGP route translation for NAT enabled?"
  type        = bool
  default     = false
}

variable "dns_forwarding_enabled" {
  description = "Is DNS forwarding enabled?"
  type        = bool
  default     = false
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region."
  type        = string
  default     = null
}

variable "enable_bgp" {
  description = "Is BGP enabled?"
  type        = bool
  default     = false
}

variable "generation" {
  description = "The generation of the Virtual Network Gateway. Possible values are 'Generation1' and 'Generation2'."
  type        = string
  validation {
    condition     = var.generation == "Generation1" || var.generation == "Generation2" || var.generation == "None"
    error_message = "generation must be 'Generation1', 'Generation2', or 'None'."
  }
}

variable "ip_sec_replay_protection_enabled" {
  description = "Is IPsec replay protection enabled?"
  type        = bool
  default     = true
}

variable "private_ip_address_enabled" {
  description = "Is private IP address enabled?"
  type        = bool
  default     = false
}

variable "remote_vnet_traffic_enabled" {
  description = "Is remote VNet traffic enabled?"
  type        = bool
  default     = true
}

variable "sku" {
  description = "The SKU of the Virtual Network Gateway. Possible values are 'Basic', 'Standard', 'HighPerformance', 'UltraPerformance', 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw4', 'VpnGw5', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3AZ', 'VpnGw4AZ', 'VpnGw5AZ', 'ErGw1AZ', 'ErGw2AZ', 'ErGw3AZ'."
  type        = string
  validation {
    condition = contains([
      "Basic", "Standard", "HighPerformance", "UltraPerformance",
      "VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4", "VpnGw5",
      "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ", "VpnGw4AZ", "VpnGw5AZ",
      "ErGw1AZ", "ErGw2AZ", "ErGw3AZ"
    ], var.sku)
    error_message = "sku must be one of the allowed values."
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "type" {
  description = "The type of the Virtual Network Gateway. Possible values are 'Vpn' and 'ExpressRoute'."
  type        = string
  validation {
    condition     = var.type == "Vpn" || var.type == "ExpressRoute"
    error_message = "type must be 'Vpn' or 'ExpressRoute'."
  }
}

variable "virtual_wan_traffic_enabled" {
  description = "Is Virtual WAN traffic enabled?"
  type        = bool
  default     = true
}

variable "vpn_type" {
  description = "The type of the VPN. Possible values are 'PolicyBased' and 'RouteBased'."
  type        = string
  validation {
    condition     = var.vpn_type == "PolicyBased" || var.vpn_type == "RouteBased"
    error_message = "vpn_type must be 'PolicyBased' or 'RouteBased'."
  }
}
variable "ip_configuration" {
  description = "IP configuration block for the Virtual Network Gateway."
  type = object({
    name                          = string
    private_ip_address_allocation = string
    subnet_id                     = string
    public_ip_address_id          = optional(string,null)
  })
  validation {
    condition     = var.ip_configuration.private_ip_address_allocation == "Dynamic" || var.ip_configuration.private_ip_address_allocation == "Static"
    error_message = "private_ip_address_allocation must be 'Dynamic' or 'Static'."
  }
}
