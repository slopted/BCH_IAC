variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "publisher_name" {
  type = string
}
variable "publisher_email" {
  type = string
}
variable "sku_name" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = null
    identity_ids = null
  }
}
variable "virtual_network_configuration" {
  type = object({
    type      = string
    subnet_id = string
  })
  default = {
    type      = "None"
    subnet_id = null
  }
}
variable "public_ip_address_id" {
  type = string
  default = null
}
variable "public_network_access_enabled" {
  type    = bool
  default = false
}
