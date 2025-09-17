variable "name" {
  type        = string
}
variable "location" {
  type        = string
  default     = "East US"
}
variable "resource_group_name" {
  type        = string
}
variable "allocation_method" {
  type        = string
}
variable "sku" {
  type        = string
  default     = "Basic"
}
variable "domain_name_label" {
  type        = string
}
variable "ddos_protection_mode" {
  type        = string
}
variable "ddos_protection_plan_id" {
  type        = string
  default     = null
#  nullable = true
}
variable "tags" {
  type        = map(string)
  default     = {}
}
