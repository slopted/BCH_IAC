variable "name" {
  description = "Name of the Virtual Desktop Host Pool."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the host pool."
  type        = string
}

variable "location" {
  description = "Azure location for the host pool."
  type        = string
}

variable "type" {
  description = "Host pool type (e.g. \"Pooled\" or \"Personal\")."
  type        = string
}

variable "load_balancer_type" {
  description = "Load balancer type for session hosts (e.g. \"BreadthFirst\", \"DepthFirst\")."
  type        = string
}

variable "friendly_name" {
  description = "Friendly display name for the host pool."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description for the host pool."
  type        = string
  default     = ""
}

variable "validate_environment" {
  description = "Whether to validate the environment for the host pool."
  type        = bool
  default     = false
}

variable "start_vm_on_connect" {
  description = "Whether to start session host VMs when users connect."
  type        = bool
  default     = true
}

variable "custom_rdp_properties" {
  description = "Custom RDP properties applied to session hosts."
  type        = string
  default     = ""
}

variable "personal_desktop_assignment_type" {
  description = "Assignment type for personal desktops when host pool type is Personal."
  type        = string
  default     = ""
}

variable "public_network_access" {
  description = "Public network access setting for the host pool."
  type        = string
  default     = ""
}

variable "maximum_sessions_allowed" {
  description = "Maximum concurrent sessions allowed per session host."
  type        = number
  default     = 1
}

variable "preferred_app_group_type" {
  description = "Preferred app group type for the host pool."
  type        = string
  default     = ""
}

variable "vm_template" {
  description = "ID or resource identifier of the VM template for session hosts."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the host pool resource."
  type        = map(string)
  default     = {}
}

variable "scheduled_agent_updates" {
  description = "Scheduled agent update configuration block."
  type = object({
    enabled                   = bool
    timezone                  = string
    use_session_host_timezone = bool
    schedule = object({
      day_of_week = string
      hour_of_day = number
    })
  })
  default = {
    enabled                   = false
    timezone                  = "UTC"
    use_session_host_timezone = false
    schedule = {
      day_of_week = ""
      hour_of_day = 0
    }
  }
}