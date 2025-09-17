variable "resource_group_location" {
  description = "La ubicación de Azure donde se crearán los recursos"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
}

variable "vnet_address_space" {
  description = "Espacio de direcciones para la red virtual"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Nombre de la subred para la instancia de SQL"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Prefijo de dirección de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "mssql_instance_name" {
  description = "Nombre de la instancia administrada de SQL"
  type        = string
}

variable "admin_login" {
  description = "Nombre de usuario para el administrador de SQL"
  type        = string
}

variable "admin_password" {
  description = "Contraseña para el administrador de SQL"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "El SKU de la instancia administrada de SQL"
  type        = string
}

variable "storage_size_in_gb" {
  description = "Tamaño de almacenamiento para la instancia administrada en GB"
  type        = number
}

variable "public_data_endpoint_enabled" {
  description = "Habilitar el endpoint de datos públicos para la instancia de SQL"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "ID de la subred para la instancia administrada de SQL"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vcores" {
  description = "Número de núcleos virtuales para la instancia SQL"
  type        = number
}

variable "license_type" {
  description = "Tipo de licencia de la instancia SQL (BasePrice o LicenseIncluded)"
  type        = string
  default     = "LicenseIncluded"
}

variable "backup_storage_redundancy" {
  description = "Tipo de redundancia de almacenamiento de respaldo"
  type        = string
}