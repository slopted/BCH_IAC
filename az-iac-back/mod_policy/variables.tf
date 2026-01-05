variable "name" {
  description = "The name of the policy definition."
  type        = string
}

variable "policy_type" {
  description = "The type of the policy definition (e.g., Custom, BuiltIn, NotSpecified)."
  type        = string
}

variable "mode" {
  description = "The policy definition mode (e.g., All, Indexed, Microsoft.KeyVault.Data)."
  type        = string
}

variable "display_name" {
  description = "The display name of the policy definition."
  type        = string
}

variable "description" {
  description = "The description of the policy definition."
  type        = string
}

variable "management_group_id" {
  description = "The ID of the management group where the policy will be assigned."
  type        = string
}

variable "policy_rule" {
  description = "The policy rule JSON object."
  type        = any
}

variable "metadata" {
  description = "The metadata for the policy definition."
  type        = any
  default     = null
}

variable "parameters" {
  description = "The parameters for the policy definition."
  type        = any
  default     = null
}

variable "scope" {
  description = "The scope at which the policy will be applied. Allowed values: mg (management group), subs (subscription), rg (resource group), vm (virtual machine)."
  type        = string
  validation {
    condition     = contains(["mg", "subs", "rg", "vm"], var.scope)
    error_message = "Scope must be one of: mg, subs, rg, vm."
  }
}

variable "mg" {
  description = "Management group configuration."
  type = object({
    name                 = string
    management_group_id  = string
    description          = string
    display_name         = string
    enforce              = bool
    identity             = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
  })
  default = null
}
