variable "app_insight_name" {
  description = "app_insight_name"
  type        = string
}

variable "application_type" {
  description = "application_type"
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

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}
