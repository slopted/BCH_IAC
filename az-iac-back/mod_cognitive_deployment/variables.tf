variable "cognitive_deployment_name" {
  description = "cognitive_deployment_name"
  type        = string
}

variable "cognitive_account_id" {
  description = "cognitive_account_id"
  type        = string
  default     = null
}

variable "model_format" {
  description = "model_format"
  type = string  
  default = "OpenAI"
}

variable "model_name" {
  description = "model_name"
  type = string  
}

variable "model_version" {
  description = "model_version"
  type = string  
  default = "1"
}

variable "scale_type" {
  description = "scale_type"
  type        = string
  default     = "Standard"
}
variable "scale_tier" {
  description = "scale_tier" 
  type        = string
  default     = null
}

variable "scale_size" {
  description = "scale_size"
  type        = string 
  default     = null
}

variable "scale_family" {
  description = "scale_family" 
  type        = string
  default     = null
}

variable "scale_capacity" {
  description = "scale_capacity"
  type        = number
  default     = null
}
