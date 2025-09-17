variable "name" {
  description = "name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}


variable "storage_account_type" {
  description = "storage_account_type"
  type        = string
  default     = "Premium_LRS"
}

variable "create_option" {
  description = "create_option"
  type        = string
  default     = "Empty"
}

variable "disk_size_gb" {
  description = "disk_size_gb"
  type        = number
}

variable "virtual_machine_id" {
  description = "virtual_machine_id"
  type        = string
}

variable "caching" {
  description = "caching"
  type        = string
  default     = "ReadWrite"
}

variable "lun" {
  description = "lun"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}