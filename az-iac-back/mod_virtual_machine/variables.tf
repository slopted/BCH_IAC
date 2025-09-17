variable "name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "location" {
  description = "Ubicación de la máquina virtual"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del resource group"
  type        = string
}

variable "size" {
  description = "Tamaño de la VM"
  type        = string
}

variable "computer_name" {
  description = "Nombre del host dentro de la VM"
  type        = string
}

variable "network_interface_ids" {
  description = "Lista de NICs asociadas a la VM"
  type        = list(string)
}

variable "proximity_placement_group_id" {
  description = "ID opcional del Proximity Placement Group"
  type        = string
  default     = null
}

variable "os_disk_name" {
  description = "Nombre del disco OS"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching del disco OS"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Tipo de almacenamiento para el disco OS"
  type        = string
}

variable "source_image_reference_publisher" {
  description = "Publisher de la imagen"
  type        = string
}

variable "source_image_reference_offer" {
  description = "Offer de la imagen"
  type        = string
}

variable "source_image_reference_sku" {
  description = "SKU de la imagen"
  type        = string
}

variable "source_image_reference_version" {
  description = "Versión de la imagen"
  type        = string
}

variable "plan_publisher" {
  description = "Publisher del plan Marketplace"
  type        = string
}

variable "plan_product" {
  description = "Producto del plan Marketplace"
  type        = string
}

variable "plan_name" {
  description = "Nombre del plan Marketplace"
  type        = string
}

variable "storage_account_uri" {
  description = "URI de la storage account para boot diagnostics"
  type        = string
  default     = null
}

# -------------------------
# Variables genéricas añadidas
# -------------------------

variable "admin_username" {
  description = "Usuario administrador de la VM"
  type        = string
}

variable "admin_password" {
  description = "Password del admin (si se usa autenticación por password)"
  type        = string
  default     = null
}

variable "disable_password_authentication" {
  description = "Si true, fuerza autenticación por SSH key"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas comunes para la VM"
  type        = map(string)
  default     = {}
}

variable "zone" {
  description = "Zona de disponibilidad donde crear la VM"
  type        = string
  default     = null
}

variable "identity_enabled" {
  description = "Habilitar identidad administrada del sistema"
  type        = bool
  default     = false
}

variable "data_disk_enabled" {
  description = "Indica si la VM debe llevar un disco de datos adicional"
  type        = bool
  default     = false
}

variable "data_disk_size_gb" {
  description = "Tamaño del disco de datos si data_disk_enabled = true"
  type        = number
  default     = 30
}

variable "data_disk_storage_account_type" {
  description = "Tipo de almacenamiento del disco de datos"
  type        = string
  default     = "Premium_LRS"
}
