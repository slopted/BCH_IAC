variable "name" {
  description = "Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
  type        = string
}
variable "kind" {
  description = "Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB, MongoDB and Parse. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created."
  type        = string
}
variable "offer_type" {
  description = "Specifies the Offer Type to use for this CosmosDB Account; currently, this can only be set to Standard."
  type        = string
}
variable "capabilities_names" {
  description = "The capabilities which should be enabled for this Cosmos DB account. Value is a capabilities block as defined below."
  type        = list(string)
}
variable "identity_name" {
  description = "identity_name"
  type        = string
  default     = null
}
variable "identity_type" {
  description = "identity_type"
  type        = string
  default     = "SystemAssigned"
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "ip_range_filter" {
  description = "A list of IP addresses in CIDR format that are allowed to access the CosmosDB Account. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "public_network_access_enabled" {
  description = "public_network_access_enabled"
  type        = bool
  default     = false
}
variable "total_throughput_limit" {
  type    = number
  default = 100
}
variable "enable_automatic_failover" {
  type        = bool
  default     = true
}
variable "lst_virtual_network_rule" {
  type    = list(map(string))
  default = []
}

