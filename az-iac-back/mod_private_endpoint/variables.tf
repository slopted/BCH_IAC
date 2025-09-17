variable "resource_private_endpoint_name" {
  description = "resource_private_endpoint_name"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "endpoint_resource_subnet_id" {
  description = "endpoint_resource_subnet_id"
  type        = string
}

variable "private_service_connection_name" {
  description = "private_service_connection_name"
  type        = string
}

variable "private_connection_resource_id" {
  description = "private_connection_resource_id"
  type        = string
}

variable "private_service_connection_subresource_names" {
  description = "private_service_connection_subresource_names"
  type        = list
  default     = ["queue"]
}

variable "private_service_connection_is_manual_connection" {
  description = "private_service_connection_is_manual_connection"
  type        = string
  default = "false"
}

variable "pvt_dnszne_grp" {
  description = "pvt_dnszne_grp"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "private_dns_zone_ids"
  type        = list
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}
