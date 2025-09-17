variable "name" {
  description = "name"
  type        = string
}

variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
}

variable "service_plan_name" {
  description = "service_plan_name"
  type        = string
}

variable "service_plan_worker_count" {
  description = "service_plan_worker_count"
  type        = string
  default = "1"
}

variable "service_plan_max_elastic_worker_count" {
  description = "service_plan_max_elastic_worker_count"
  type        = string
  default = "1"
}

variable "identity_name" {
  description = "identity_name"
  type        = string
  default     = null 
}

variable "identity_type" {
  description = "identity_type"
  type        = string
  default     = "SystemAssigned"
}

variable "storage_account_name" {
  description = "storage_account_name"
  type        = string
}

variable "storage_account_primary_access_key" {
  description = "storage_account_primary_access_key"
  type        = string
}

variable "python_version" {
  description = "python_version"
  type        = string
  default     = "3.9"
}

variable "swift_subnet_id" {
  description = "swift_subnet_id"
  type        = string
}

variable "vnet_route_all_enabled"{
  description = "vnet_route_all_enabled"
  type        = string
  default     = "true"
}

variable linux_function_app_https_only{
  description = "linux_function_app_https_only"
  type = bool
  default = true
}

variable linux_function_app_pna_enabled{
  description = "linux_function_app_pna_enabled"
  type = bool
  default = false
}

variable "tags" {
  description = "tags"
  type        = map
  default     = null
}

variable "linux_function_app_settings" {
  description = "app_settings"
  type        = map
  default     = null
}

variable "sku_name" {
  description = "sku_name"
  type        = string
  default = "Y1"
}

variable "deployment_type" {
  description = "Tipo de despliegue: 'container' o 'source'"
  type        = string
  default     = "source"
}

variable "container_image_name" {
  description = "Nombre de la imagen del contenedor"
  type        = string
}

variable "container_registry_url" {
  description = "URL del registro de contenedores"
  type        = string
}

#variable "source_code_path" {
#  description = "Ruta al código fuente"
#  type        = string
#}