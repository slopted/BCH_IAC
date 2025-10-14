variable "name" {
  description = "The name of the Private DNS Resolver Inbound Endpoint."
  type        = string
}

variable "private_dns_resolver_id" {
  description = "The ID of the Private DNS Resolver."
  type        = string
}

variable "location" {
  description = "The Azure location where the resource will be created."
  type        = string
}

variable "ip_configurations" {
  description = "IP configuration block for the inbound endpoint."
  type = object({
    private_ip_allocation_method = string
    subnet_id                    = string
    private_ip_address           = optional(string)
  })
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}