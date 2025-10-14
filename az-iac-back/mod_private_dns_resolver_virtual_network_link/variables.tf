variable "name" {
  description = "The name of the Private DNS Resolver Virtual Network Link."
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "The ID of the DNS Forwarding Ruleset to link."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the Virtual Network to link."
  type        = string
}

variable "metadata" {
  description = "A mapping of metadata to associate with the resource."
  type        = map(string)
  default     = {}
}