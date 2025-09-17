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

variable "network_interface_ids" {
  description = "network_interface_ids"
  type        = list(string)
}

variable "size" {
  description = "size"
  type        = string
}

variable "proximity_placement_group_id" {
  description = "proximity_placement_group_id"
  type        = string
}

variable "os_disk_caching" {
  description = "os_disk_caching"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "os_disk_storage_account_type"
  type        = string
}

variable "source_image_reference_publisher" {
  description = "source_image_reference_publisher"
  type        = string
}

variable "source_image_reference_offer" {
  description = "source_image_reference_offer"
  type        = string
}

variable "source_image_reference_sku" {
  description = "source_image_reference_sku"
  type        = string
}

variable "source_image_reference_version" {
  description = "source_image_reference_version"
  type        = string
}

variable "computer_name" {
  description = "computer_name"
  type        = string
}

variable "admin_username" {
  description = "admin_username"
  type        = string
}

variable "admin_password" {
  description = "admin_password"
  type        = string
}

variable "storage_account_uri" {
  description = "storage_account_uri"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "algorithm" {
  description = "algorithm"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "rsa_bits"
  type        = number
  default     = 4096
}