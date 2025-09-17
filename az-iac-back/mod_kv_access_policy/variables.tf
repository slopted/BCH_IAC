variable "key_vault_id" {
  type        = string
}
variable "tenant_id" {
  type        = string
}
variable "object_id" {
  type        = string
}
variable "secret_permissions" {
  type        = list(string)
  default     = []
}
variable "certificate_permissions" {
  type        = list(string)
  default     = []
}
variable "key_permissions" {
  type        = list(string)
  default     = []
}