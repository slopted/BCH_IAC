variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "api_name" {
  type = string
}
variable "display_name" {
  type = string
}
variable "method" {
  type = string
}
variable "url_template" {
  type = string
}
variable "description" {
  type = string
}
variable "template_parameters" {
  type = object({
    name          = string
    type          = string
    required      = bool
    values        = optional(list(string))
  })
}
