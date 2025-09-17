variable "name" {
  type    = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "log_analytics_workspace_id" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "infrastructure_subnet_id" {
  type = string
  default = null
}
variable "zone_redundancy_enabled" {
  type = bool
  default = false
}
variable "internal_load_balancer_enabled" {
  type = bool
  default = false
}

##worload

variable "workload_profile" {
  type = object({
    name = string
    workload_profile_type  = string
    minimum_count  = number
    maximum_count  = number  
  })
}
