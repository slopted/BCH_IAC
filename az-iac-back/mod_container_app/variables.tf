variable "name" {
  description = "resource name"
  type    = string
  default = "exampleazurebot"
}

variable "location" {
  description = "value of the location"
  type = string
}

variable "resource_group_name" {
  description = "resource group name"
  type = string
}

variable "container_app_environment_id" {
  description = "container app environment id where container app will be deployed"
  type = string
}

variable "registry" {
  description = "values for the container registry"
  type = object({
    server               = string
    username             = optional(string)
    password_secret_name = optional(string)
    identity             = optional(string)
  })
}
variable revision_mode{
  description = "values for the revision mode"  
  type = string
  default= "Single"
}

variable "container" {
  description = "values for the container app"
  type = object({
    name   = string
    image  = string
    cpu    = string
    memory = string
    volume_mounts = optional(object({
      name = string
      path = string
    }))
    envs = optional(list(object({
      name        = string
      secret_name = optional(string)
      value       = optional(string)
    })))
    secrets = map(string)
    ingress = optional(object({
      allow_insecure_connections = optional(bool, false)
      custom_domain              = optional(string)
      external_enabled           = optional(bool, false)
      ip_security_restriction = optional(object({
        action           = string
        description      = optional(string)
        ip_address_range = list(string)
        name             = string
      }))
      target_port  = number
      exposed_port = optional(number)
      transport    = optional(string)
      traffic_weight = object({
        label           = optional(string)
        latest_revision = optional(string)
        revision_suffix = optional(string)
        percentage      = number
      })
    }))
  })
}

variable "volume" {
  description = "values for the volume"
  type = object({
    name         = string
    storage_name = string
  })
  default = null
}

variable "tags" {
  description = "tags for the resource"
  type    = map(string)
  default = {}
}

