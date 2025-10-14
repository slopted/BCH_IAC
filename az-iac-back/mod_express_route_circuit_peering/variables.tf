
variable "peering_type" {
  description = "The type of BGP peering. Possible values are AzurePrivatePeering, MicrosoftPeering, and AzurePublicPeering."
  type        = string
}

variable "express_route_circuit_name" {
  description = "The name of the ExpressRoute circuit."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the ExpressRoute circuit peering."
  type        = string
}

variable "peer_asn" {
  description = "The Autonomous System Number (ASN) of the customer/connectivity provider."
  type        = number
}

variable "primary_peer_address_prefix" {
  description = "The primary address prefix for the peering."
  type        = string
}

variable "secondary_peer_address_prefix" {
  description = "The secondary address prefix for the peering."
  type        = string
}

variable "ipv4_enabled" {
  description = "Whether IPv4 is enabled for the peering."
  type        = bool
  default     = true
}

variable "vlan_id" {
  description = "The identifier used for the VLAN."
  type        = number
}

variable "shared_key" {
  description = "The shared key for the peering."
  type        = string
  default     = null
}

variable "route_filter_id" {
  description = "The ID of the Route Filter associated with the peering."
  type        = string
  default     = null
}

variable "advertised_public_prefixes" {
  description = "A list of public prefixes to be advertised when using Microsoft Peering."
  type        = list(string)
  default     = []
}

variable "customer_asn" {
  description = "The ASN of the customer for Microsoft Peering."
  type        = number
  default     = null
}

variable "routing_registry_name" {
  description = "The name of the routing registry for Microsoft Peering."
  type        = string
  default     = null
}

variable "advertised_communities" {
  description = "A list of BGP community values to be advertised for Microsoft Peering."
  type        = list(string)
  default     = []
}

variable "ipv6" {
  description = "IPv6 configuration block."
  type = object({
    enabled                      = bool
    primary_peer_address_prefix   = string
    secondary_peer_address_prefix = string
    microsoft_peering = object({
      advertised_public_prefixes = list(string)
      customer_asn               = number
      routing_registry_name      = string
      advertised_communities     = list(string)
    })
  })
  default = {
    enabled                      = false
    primary_peer_address_prefix   = ""
    secondary_peer_address_prefix = ""
    microsoft_peering = {
      advertised_public_prefixes = []
      customer_asn               = null
      routing_registry_name      = null
      advertised_communities     = []
    }
  }
}