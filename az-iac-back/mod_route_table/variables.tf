variable "name" {
  description = "The name of the route table."
  type        = string
}

variable "location" {
  description = "The Azure location where the route table will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the route table."
  type        = string
}

variable "bgp_route_propagation_enabled" {
  description = "Whether BGP route propagation is enabled for the route table."
  type        = bool
  default     = false
}

variable "route" {
  description = "A list of route objects to be added to the route table."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "Lista de IDs de subredes para asociar con la tabla de rutas"
  type        = list(string)
  default     = []
}