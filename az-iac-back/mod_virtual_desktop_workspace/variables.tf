variable "name" {
  description = "Name of the Virtual Desktop workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the workspace will be created."
  type        = string
}

variable "location" {
  description = "Azure location (region) for the workspace."
  type        = string
}

variable "friendly_name" {
  description = "Friendly display name for the workspace."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the workspace."
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the workspace."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the workspace."
  type        = map(string)
  default     = {}
}