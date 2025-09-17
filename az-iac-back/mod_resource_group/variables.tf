variable "name" {
  description = "name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

#Cambios aplicados
variable "role_definition_id" {
  description = "id rol"
  type        = string
  default     = null
#  default     = "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c" #Contributor
}

variable "principal_id" {
  description = "id account"
  type        = string
  default     = null
#  default     =  "383e90d3-ab7a-4319-8b2a-f0176cd1f8a5" #AZ_DVT_CLOUD_PLATAFORMA_PREPROD_ADMIN
}
