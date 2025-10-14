variable "allow_classic_operations" {
  description = "Whether classic operations are allowed on the ExpressRoute circuit."
  type        = bool
  default     = false
}

variable "authorization_key" {
  description = "The authorization key for the ExpressRoute circuit. Sensitive value."
  type        = string
  default     = null
  sensitive   = true
}

variable "bandwidth_in_gbps" {
  description = "The bandwidth in Gbps for the ExpressRoute circuit."
  type        = number
  default     = null
}

variable "bandwidth_in_mbps" {
  description = "The bandwidth in Mbps for the ExpressRoute circuit."
  type        = number
  default     = 1000
}

variable "location" {
  description = "The Azure location where the ExpressRoute circuit will be created."
  type        = string
}

variable "name" {
  description = "The name of the ExpressRoute circuit."
  type        = string
}

variable "peering_location" {
  description = "The peering location for the ExpressRoute circuit."
  type        = string
}

variable "rate_limiting_enabled" {
  description = "Whether rate limiting is enabled for the ExpressRoute circuit."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the ExpressRoute circuit."
  type        = string
}

variable "service_key" {
  description = "The service key for the ExpressRoute circuit. Sensitive value."
  type        = string
  default     = null
  sensitive   = true
}

variable "service_provider_name" {
  description = "The name of the service provider for the ExpressRoute circuit."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "sku" {
  description = "The SKU block for the ExpressRoute circuit."
  type = object({
    family = string
    tier   = string
  })
}