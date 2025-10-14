variable "name" {
  description = "The name of the ExpressRoute connection."
  type        = string
}

variable "express_route_gateway_id" {
  description = "The ID of the ExpressRoute gateway."
  type        = string
}

variable "express_route_circuit_peering_id" {
  description = "The ID of the ExpressRoute circuit peering."
  type        = string
}

variable "authorization_key" {
  description = "The authorization key for the ExpressRoute connection."
  type        = string
  default     = null
}