variable "name" {
  type = string
}

variable "resource_group_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "admin_username" {
  type    = string
}

variable "admin_password" {
  type    = string
}

variable "create_mode" {
  type    = string
}

variable "node_group_kind" {
  type    = string
  default = "Shard"
}

variable "node_group_nodeCount" {
  type    = number
  default = 1
}

variable "node_group_sku" {
  type    = string
  default = "M30"
}

variable "node_group_disk_sizeGB" {
  type    = number
  default = 32
}

variable "node_group_enableHa" {
  type    = bool
  default = false
}

variable "server_version" {
  type    = string
  default =  "6.0"
}

variable "tags" {
  type    = map(string)
  default = {}
}
