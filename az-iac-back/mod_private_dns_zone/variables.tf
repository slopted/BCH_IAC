variable "azurerm_private_dns_zone_name" {
    description = "azurerm_private_dns_zone_name"
    type = string  
}

variable "resource_group_name" {
  description = "resource_group_name"
  type = string
}

variable "pvt_dnszne_vnet_link_name" {
  description = "pvt_dnszne_vnet_link_name"
  type        = string
}

variable "vnet_id" {
  description = "vnet_id"
  type        = string
}

variable "create_dns_link" {
  type    = bool
  default = true
  description = "Controla si se crea el Virtual Network Link"
}

