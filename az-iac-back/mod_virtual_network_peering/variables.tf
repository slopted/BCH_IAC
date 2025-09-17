variable "resource_group_name_Hub" {
  description = "Name of the hub resource group."
  type        = string
}
variable "resource_group_name_Spoke" {
  description = "Name of the spoke resource group."
  type        = string
}

variable "vnet_peering_Hub" {
  description = "Name of the hub virtual network peering."
  type        = string
}

variable "vnet_peering_Spoke" {
  description = "Name of the spoke virtual network peering."
  type        = string
}

variable "subscription_id_Spoke" {
  description = "Name of the spoke subscription."
  type        = string
}

variable "subscription_id_Hub" {
  description = "Name of the hub subscription."
  type        = string
}