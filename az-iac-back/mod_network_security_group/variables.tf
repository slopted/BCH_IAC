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

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "security_rule" {
  description = "The security_rule."
  type        = list(map(string))
  default     = []
}