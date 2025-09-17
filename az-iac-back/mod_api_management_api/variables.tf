variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "api_management_name" {
  type = string
}
variable "display_name" {
  type = string
}
variable "path" {
  type = string
}
variable "protocols" {
  type = list(string)
}
variable "import" {
  type = object({
    content_format = string
    content_value  = string
  })
}
variable "revision" {
  type = number
}
variable "service_url" {
  type = string
  default = null
}
variable "subscription_required" {
  type = bool
  default = true
}