variable "resource_group_name" {
  description = "Resource group donde se despliega el SD-WAN"
  type        = string
}

# ============================================================
# SD-WAN Virtual Machine Network Interfaces and Configuration
# ============================================================

variable "data" {
  description = "Nombres de objetos de red del hub"
  type = object({
    vnet-hub-name               = string
    snet-hub-sdwan-untrust-name = string
    snet-hub-sdwan-trust-name   = string
    snet-hub-sdwan-ha-name      = string
    snet-hub-sdwan-mgmt-name    = string
  })
}

variable "private_ip_address" {
  description = "IPs privadas para cada NIC del SD-WAN"
  type = object({
    sdwan-untrust-ip1 = string
    sdwan-trust-ip1   = string
    sdwan-ha-ip1      = string
    sdwan-mgmt-ip1    = string
  })
  validation {
    condition = (
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.private_ip_address.sdwan-untrust-ip1)) &&
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.private_ip_address.sdwan-trust-ip1))   &&
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.private_ip_address.sdwan-ha-ip1))      &&
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.private_ip_address.sdwan-mgmt-ip1))
    )
    error_message = "Cada IP de NIC del SD-WAN debe ser IPv4 válida."
  }
}

# ============================================================
# SD-WAN Fortinet Marketplace Agreement
# ============================================================

variable "accept" {
  description = "Si true, acepta el acuerdo de Marketplace; si false, asume que ya está aceptado"
  type        = bool
  default     = false
}

variable "publisher" {
  description = "Publisher de la imagen Fortinet"
  type        = string
  default     = "fortinet"
}

variable "offer" {
  description = "Offer de la imagen Fortinet"
  type        = string
  default     = "fortinet_fortigate-vm_v5"
}

variable "license_type" {
  description = "Tipo de licencia: byol o payg"
  type        = string
  default     = "byol"
  validation {
    condition     = contains(["byol", "payg"], var.license_type)
    error_message = "license_type debe ser 'byol' o 'payg'."
  }
}

variable "fgtsku" {
  description = "SKU por tipo de licencia para el plan de Marketplace"
  type        = map(string)
  default = {
    byol = "fortinet_fg-vm"
    payg = "fortinet_fg-vm_payg_2023"
  }
}

# ============================================================
# SD-WAN Linux Virtual Machine Definition
# ============================================================

variable "name" {
  description = "Nombre del recurso VM"
  type        = string
}

variable "size" {
  description = "Tamaño de la VM"
  type        = string
}

variable "proximity_placement_group_id" {
  description = "ID del PPG (opcional)"
  type        = string
  default     = null
}

variable "computer_name" {
  description = "Hostname del sistema"
  type        = string
}

variable "admin_username" {
  description = "Usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Password administrador (si aplica)"
  type        = string
  sensitive   = true
}

variable "disable_password_authentication" {
  description = "Deshabilitar autenticación por password"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
  default     = {}
}

variable "zone" {
  description = "Availability Zone (1, 2 o 3). Puede ser null"
  type        = string
  default     = null
  validation {
    condition     = var.zone == null || contains(["1", "2", "3"], var.zone)
    error_message = "zone debe ser '1', '2' o '3' si se especifica."
  }
}

# Fuente de imagen de Marketplace
variable "source_image_reference" {
  description = "Referencia de imagen"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

# Disco del SO
variable "os_disk" {
  description = "Configuración del disco del SO"
  type = object({
    caching              = string
    storage_account_type = string
  })
}

# Boot diagnostics
variable "storage_account_uri" {
  description = "URI de la cuenta de storage para boot diagnostics (opcional)"
  type        = string
  default     = null
}

# ============================================================
# Extras
# ============================================================

variable "untrust_public_ip_id" {
  description = "ID de la Public IP a asociar a la NIC untrust (opcional)"
  type        = string
  default     = null
}
