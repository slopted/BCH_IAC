variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "cognitive_account_name" {
  description = "cognitive_account_name"
  type        = string
}

variable "cognitive_account_kind" {
  description = "cognitive_account_kind"
  type        = string
}

variable "cognitive_account_sku_name" {
  description = "cognitive_account_sku_name"
  type        = string
}

variable "identity_name" {
  description = "identity_name"
  type        = string
  default     = null
}

variable "identity_type" {
  description = "identity_type"
  type        = string
  default     = "SystemAssigned"
}

variable "tags" {
  description = "tags"
  type        = map(any)
  default     = null
}

variable "custom_subdomain_name" {
  description = "custom_subdomain_name"
  type        = string
}

variable "acls_default_action" {
  description = "acls_default_action"
  type        = string
  default     = "Allow"
}

variable "acls_subnet_id" {
  description = "acls_subnet_id"
  type        = string
}

variable "cognitive_account_pna_enabled" {
  description = "cognitive_account_pna_enabled"
  type        = bool
  default     = false
}
variable "customer_managed_key" {
  type = object({
    key_vault_key_id   = string
    identity_client_id = optional(string)
  })
  default     = null
  description = <<-DESCRIPTION
    type = object({
      key_vault_key_id   = (Required) The ID of the Key Vault Key which should be used to Encrypt the data in this OpenAI Account.
      identity_client_id = (Optional) The Client ID of the User Assigned Identity that has access to the key. This property only needs to be specified when there're multiple identities attached to the OpenAI Account.
    })
  DESCRIPTION
}
variable "local_auth_enabled" {
  description = "local_auth_enabled"
  type        = bool
}
# variable "deployment" {
#   type = map(object({
#     name            = string
#     model_format    = string
#     model_name      = string
#     model_version   = string
#     scale_type      = string
#     rai_policy_name = optional(string)
#     capacity        = optional(number)
#   }))
#   default     = {}
#   description = <<-DESCRIPTION
#       type = map(object({
#         name                 = (Required) The name of the Cognitive Services Account Deployment. Changing this forces a new resource to be created.
#         cognitive_account_id = (Required) The ID of the Cognitive Services Account. Changing this forces a new resource to be created.
#         model = {
#           model_format  = (Required) The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI.
#           model_name    = (Required) The name of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created.
#           model_version = (Required) The version of Cognitive Services Account Deployment model.
#         }
#         scale = {
#           scale_type = (Required) Deployment scale type. Possible value is Standard. Changing this forces a new resource to be created.
#         }
#         rai_policy_name = (Optional) The name of RAI policy. Changing this forces a new resource to be created.
#         capacity = (Optional) Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute.
#       }))
#   DESCRIPTION
#   nullable    = false
# }
variable "network_acls" {
  type = set(object({
    default_action = string
    ip_rules       = optional(set(string))
    virtual_network_rules = optional(set(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    })))
  }))
  default     = null
  description = <<-DESCRIPTION
    type = set(object({
      default_action = (Required) The Default Action to use when no rules match from ip_rules / virtual_network_rules. Possible values are `Allow` and `Deny`.
      ip_rules                    = (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account.
      virtual_network_rules = optional(set(object({
        subnet_id                            = (Required) The ID of a Subnet which should be able to access the OpenAI Account.
        ignore_missing_vnet_service_endpoint = (Optional) Whether ignore missing vnet service endpoint or not. Default to `false`.
      })))
    }))
  DESCRIPTION
}