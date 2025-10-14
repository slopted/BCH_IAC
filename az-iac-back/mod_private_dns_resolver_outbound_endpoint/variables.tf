variable "name" {
  description = "The name of the Private DNS Resolver Outbound Endpoint."
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

variable "subnet_id" {
  description = "The ID of the subnet to which the outbound endpoint will be associated."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}