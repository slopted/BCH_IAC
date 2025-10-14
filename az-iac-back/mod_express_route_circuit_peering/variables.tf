variable "peering_type" {
  description = "The type of BGP peering. Possible values are AzurePrivatePeering, MicrosoftPeering, or AzurePublicPeering."
  type        = string
}

variable "express_route_circuit_name" {
  description = "The name of the ExpressRoute circuit."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the ExpressRoute circuit exists."
  type        = string
}

variable "peer_asn" {
  description = "The Autonomous System Number (ASN) of the peering."
  type        = number
}
variable "primary_peer_address_prefix" {
  description = "The primary address prefix for the peering."
  type        = string

  validation {
    condition     = can(cidrhost(var.primary_peer_address_prefix, 0)) && can(cidrnetmask(var.primary_peer_address_prefix))
    error_message = "The primary_peer_address_prefix must be a valid IPv4 CIDR block (e.g., 10.0.0.0/30)."
  }
}

variable "secondary_peer_address_prefix" {
  description = "The secondary address prefix for the peering."
  type        = string

  validation {
    condition     = can(cidrhost(var.secondary_peer_address_prefix, 0)) && can(cidrnetmask(var.secondary_peer_address_prefix))
    error_message = "The secondary_peer_address_prefix must be a valid IPv4 CIDR block (e.g., 10.0.1.0/30)."
  }
}

variable "ipv4_enabled" {
  description = "Whether IPv4 peering is enabled."
  type        = bool
  default     = true
}
variable "route_filter_id" {
  description = "The ID of the Route Filter to be applied to the peering."
  type        = string
  default     = null

  validation {
    condition     = var.route_filter_id == null || can(regex("^/subscriptions/[a-f0-9-]+/resourceGroups/[^/]+/providers/Microsoft.Network/routeFilters/[^/]+$", var.route_filter_id))
    error_message = "If provided, route_filter_id must be a valid Azure resource ID for a Route Filter."
  }
}

variable "shared_key" {
  description = "The shared key for the peering."
  type        = string
  sensitive   = true
  default     = null
}

variable "vlan_id" {
  description = "The identifier of the VLAN."
  type        = number
}