variable "secret_name" {
  description = "secret_name"
  type        = string
}
variable "secret_value" {
  description = "secret_value"
  type        = string
  default     = null 
}
variable "key_vault_id" {
  description = "key_vault_id"
  type        = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
