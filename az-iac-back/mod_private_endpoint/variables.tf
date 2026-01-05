variable "name" {
  type        = string
  description = "Name of the private endpoint"
}

variable "location" {
  type        = string
  description = "Azure region for the private endpoint"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group containing the private endpoint"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the private endpoint to"
}

variable "custom_network_interface_name" {
  type        = string
  description = "Custom name for the network interface associated with the private endpoint"
  default     = null
}

variable "psc" {
  type = object({
    name                           = string
    private_connection_resource_id = string
    subresource_names              = list(string)
    is_manual_connection           = bool
  })
  description = "Private service connection configuration for the private endpoint"
  default = {
    name                           = ""
    private_connection_resource_id = ""
    subresource_names              = []
    is_manual_connection           = false
  }
}

variable "pvt_dnsz_grp" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  description = "Private DNS zone group configuration for the private endpoint"
  default = {
    name                 = ""
    private_dns_zone_ids = []
  }
}