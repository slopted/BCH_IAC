variable "name" {
  description = "Name of resource group"
  type        = string
}
variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US"
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the Redis Cache"
  type        = string
}
variable "sku_name" {
  description = "The SKU name of the Redis Cache to use"
  type        = string
  default     = "Basic"
}
variable "family" {
  description = "The SKU family of the Redis Cache to use"
  type        = string
  default     = "C"
}
variable "capacity" {
  description = "The size of the Redis Cache to use"
  type        = number
  default     = 1
}
variable "enable_non_ssl_port" {
  description = "If the non-ssl port (6379) is enabled"
  type        = bool
  default     = true
}
variable "minimum_tls_version" {
  description = "The minimum TLS version for the Redis Cache"
  type        = string
  default     = "1.2"
}
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "public_network_access_enabled" {
  description = "Whether to enable public network access for the Redis Cache"
  type        = bool
  default     = false
}
variable "subnet_id" {
  description = "The ID of the Subnet in the Virtual Network to place the Redis Cache"
  type        = string
  default     = ""
}
variable "enable_authentication" {
  description = "If the Redis Cache should require a password to access"
  type        = bool
  default     = true
}
variable "replicas_per_master" {
  description = "The number of replicas to be created per master"
  type        = number
  default     = 1
}
variable "redis_configuration" {
  description = "The Redis Configuration"
  type = object({
    maxmemory_reserved = number
    maxmemory_delta    = number
    maxmemory_policy   = string
  })
  default = {
    maxmemory_reserved = 10
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }
}
variable "identity" {
  description = "The Identity block"
  type = object({
    type = string
  })
  default = {
    type = "SystemAssigned"
    # identity_ids = Optional(list(string))
  }
}

