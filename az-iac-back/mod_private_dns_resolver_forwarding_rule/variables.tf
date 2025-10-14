variable "name" {
  description = "The name of the Private DNS Resolver Forwarding Rule."
  type        = string
}

variable "dns_forwarding_ruleset_id" {
  description = "The ID of the DNS Forwarding Ruleset."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the forwarding rule."
  type        = string
}

variable "enabled" {
  description = "Whether the forwarding rule is enabled."
  type        = bool
}

variable "target_dns_servers" {
  description = "The target DNS servers for forwarding."
  type = object({
    ip_address = string
    port       = number
  })
}

variable "metadata" {
  description = "A mapping of metadata to assign to the resource."
  type        = map(string)
  default     = {}
}