variable "name" {
    description = "Name of the Virtual Desktop Application Group."
    type        = string
}

variable "resource_group_name" {
    description = "Name of the resource group in which the Application Group will be created."
    type        = string
}

variable "location" {
    description = "Azure region where the Application Group will be created (e.g. eastus)."
    type        = string
}

variable "type" {
    description = "Type of the application group. Allowed values: 'RemoteApp' or 'Desktop'."
    type        = string

    validation {
        condition     = contains(["RemoteApp", "Desktop"], var.type)
        error_message = "The 'type' must be either 'RemoteApp' or 'Desktop'."
    }
}

variable "host_pool_id" {
    description = "Resource ID of the host pool to associate with this application group."
    type        = string
}

variable "friendly_name" {
    description = "Friendly display name for the Application Group."
    type        = string
    default     = null
}

variable "default_desktop_display_name" {
    description = "Default desktop display name (relevant for Desktop type application groups)."
    type        = string
    default     = null
}

variable "description" {
    description = "Description for the Application Group."
    type        = string
    default     = null
}

variable "tags" {
    description = "A map of tags to assign to the resource."
    type        = map(string)
    default     = {}
}