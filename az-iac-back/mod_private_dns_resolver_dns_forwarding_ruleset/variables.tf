variable "name" {
  description = "The name of the Private DNS Resolver DNS Forwarding Ruleset."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the DNS Forwarding Ruleset."
  type        = string
}

variable "location" {
  description = "The Azure location where the DNS Forwarding Ruleset will be created."
  type        = string
}

variable "private_dns_resolver_outbound_endpoint_ids" {
  description = "A list of IDs of the Private DNS Resolver Outbound Endpoints."
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}