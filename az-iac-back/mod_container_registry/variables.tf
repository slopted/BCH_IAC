variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "exampleazurebot"

}

variable "location" {
  type        = string
  description = "Desired Azure Region"
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "sku" {
  description = "The SKU name of the the container registry. Possible values are `Classic` (which was previously `Basic`), `Basic`, `Standard` and `Premium`."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The value of 'sku' must be 'Basic, Standard' or 'Premium'."
  }
}

variable "quarantine_policy_enabled" {
  description = "Enable Quarantine Policy for the Azure Container Registry"
  type        = bool
  default     = true  
}

variable "retention_policy_enabled" {
  description = "Enable retention policy for the Azure Container Registry"
  type        = bool
  default     = true
}
  
variable "retention_policy_days" {
  description = "The number of days to retain untagged manifests. If set to -1, untagged manifests will not be deleted."
  type        = number
  default     = 7 
}

variable "tags" {
  type        = map(string)
  description = "Tags to the Azure Container Registry"
  default     = {}
}

variable "georeplication_locations" {
  description = <<DESC
  A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  or this can be a list of `string` (each element is a location)
DESC
  type        = any
  default     = []
}

variable "network_rule_set" {
  description = "Network rule set configuration for the container registry"
  type = list(object({
    default_action = string
    ip_rule = list(object({
      action   = string
      ip_range = string
    }))
    virtual_network = list(object({
      action    = string
      subnet_id = string
    }))
  }))
  default = []
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = false
  type        = bool
}
