# ============================================================
# Virtual Machine Network Interface - Variables
# ============================================================
variable "ip_configuration" {
  description = "IP configuration for the virtual machine's network interface"
  type = object({
    subnet_id                     = string
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    primary                       = optional(bool, true)
  })
}

# ============================================================
# Virtual Machine Windows - Variables
# ============================================================

variable "name" {
  description = "name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "size" {
  description = "size"
  type        = string
}

variable "admin_username" {
  description = "admin_username"
  type        = string
}

variable "admin_password" {
  description = "admin_password"
  type        = string
}

variable "patch_mode" {
  description = "Specifies the patch mode for the Windows virtual machine. Possible values are 'Manual', 'AutomaticByOS', or 'AutomaticByPlatform'."
  type        = string
  default     = "Manual"
}

variable "hotpatching_enabled" {
  description = "Specifies whether hotpatching is enabled for the Windows virtual machine. Set to true to enable hotpatching."
  type        = bool
  default     = false
}

variable "os_disk" {
  description = "Configuration for the OS disk of the virtual machine"
  type = object({
    name                      = optional(string)
    caching                   = optional(string, "ReadWrite")
    storage_account_type      = optional(string, "Standard_LRS")
    disk_size_gb              = optional(number)
    write_accelerator_enabled = optional(bool, false)
  })
  default = {}
}

variable "source_image_reference" {
  description = "The source image reference for the virtual machine."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "tags" {
  description = "tags"
  type        = map(any)
  default     = null
}

variable "algorithm" {
  description = "algorithm"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "rsa_bits"
  type        = number
  default     = 4096
}
