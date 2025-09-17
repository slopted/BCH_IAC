variable "sqlserver_name" {
  description = "sqlserver_name"
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

variable "sqlserver_version" {
  description = "sqlserver_version"
  type        = string
}

variable "sqlserver_administrator_login" {
  description = "sqlserver_administrator_login"
  type        = string
}

variable "sqlserver_administrator_password" {
  description = "sqlserver_administrator_password"
  type        = string
}

variable "sqlserver_minimum_tls_version" {
  description = "sqlserver_minimum_tls_version"
  type        = string
}

#variable "identity_type" {
#description = "identity type"
#type        = string
#}
#
#variable "identity_name" {
#description = "sqlserver_minimum_tls_version"
#type        = string
#}

variable "sqlserver_pna_enabled"{
  description="sqlserver_pna_enabled"
  type = bool
  default = false
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}
