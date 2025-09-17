variable "name" {
  type        = string
  description = "Nombre del servidor PostgreSQL Flexible"
}

variable "location" {
  type        = string
  description = "Ubicación del recurso"
}

variable "resource_group_name" {
  type        = string
  description = "Nombre del Resource Group"
}

variable "zone" {
  type        = string
  description = "Zona de disponibilidad para el servidor"
}

variable "sku_name" {
  type        = string
  description = "SKU del servidor PostgreSQL Flexible"
}

variable "tags" {
  type        = map(string)
  description = "Etiquetas aplicadas a los recursos"
}

variable "private_endpoint_name" {
  type        = string
  description = "Nombre del Private Endpoint (si aplica)"
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "ID de la subred para el Private Endpoint (si aplica)"
  default     = null
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Lista de IDs de zonas DNS privadas (si aplica)"
  default     = []
}
