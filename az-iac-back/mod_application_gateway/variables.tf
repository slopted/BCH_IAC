variable "app_gateway_name" {
  description = "app_gateway_name."
  type        = string
}
variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
  type        = string
}

variable "sku" {
  description = "The sku pricing model of v1 and v2."
  type = object({
    name     = string
    tier     = string
    capacity = optional(string)
  })
  default = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  nullable = false
}
variable "autoscale_configuration" {
  description = "Minimum or Maximum capacity for autoscaling. Accepted values are for Minimum in the range 0 to 100 and for Maximum in the range 2 to 125"
  type = object({
    min_capacity = number
    max_capacity = optional(number)
  })
  default  = null
  nullable = true
}
variable "virtual_network_subnet_id" {
  description = "virtual_network_subnet_id"
  type        = string
  default     = null
}
variable "identity_type" {
  description = "identity_type"
  type        = string
  default     = "SystemAssigned"
}
variable "waf_configuration" {
  description = "Web Application Firewall support for your Azure Application Gateway"
  type = object({
    firewall_mode            = string
    rule_set_version         = string
    file_upload_limit_mb     = optional(number)
    request_body_check       = optional(bool)
    max_request_body_size_kb = optional(number)
    disabled_rule_group = optional(list(object({
      rule_group_name = string
      rules           = optional(list(string))
    })))
    exclusion = optional(list(object({
      match_variable          = string
      selector_match_operator = optional(string)
      selector                = optional(string)
    })))
  })
  default = null
}
variable "enable_http2" {
  description = "enable_http2"
  type        = bool
  default     = false
}
variable "backend_address_pools" {
  description = "List of backend address pools"
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
}
variable "backend_http_settings" {
  description = "List of backend HTTP settings."
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    affinity_cookie_name                = optional(string)
    path                                = optional(string)
    enable_https                        = bool
    probe_name                          = optional(string)
    request_timeout                     = number
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool)
    authentication_certificate = optional(object({
      name = string
    }))
    trusted_root_certificate_names = optional(list(string))
    connection_draining = optional(object({
      enable_connection_draining = bool
      drain_timeout_sec          = number
    }))
  }))
}
variable "http_listeners" {
  description = "List of HTTP/HTTPS listeners. SSL Certificate name is required"
  type = list(object({
    name                 = string
    host_name            = optional(string)
    host_names           = optional(list(string))
    require_sni          = optional(bool)
    protocol             = optional(string)
    frontend_port_name   = optional(string)
    ssl_certificate_name = optional(string)
    firewall_policy_id   = optional(string)
    ssl_profile_name     = optional(string)
    custom_error_configuration = optional(list(object({
      status_code           = string
      custom_error_page_url = string
    })))
  }))
}
variable "redirect_configuration" {
  description = "list of maps for redirect configurations"
  type        = list(any)
  default     = []
}
variable "request_routing_rules" {
  description = "List of Request routing rules to be used for listeners."
  type = list(object({
    name                           = string
    rule_type                      = string
    http_listener_name             = optional(string)
    priority                       = optional(number)
    backend_address_pool_name      = optional(string)
    backend_http_settings_name     = optional(string)
    redirect_configuration_enabled = bool
    redirect_configuration_name    = optional(string)
    rewrite_rule_set_name          = optional(string)
    url_path_map_name              = optional(string)
    http_listener_to               = optional(string)
  }))
  default = []
}
variable "ssl_sectret_id" {
  description = "ssl_sectret_id"
  type        = string
  default     = null
  nullable    = true
}
variable "ssl_sectret_name" {
  description = "ssl_sectret_name"
  type        = string
  default     = null
  nullable    = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "frontend_ports" {
  description = "frontend_ip_configurations"
  type = list(object({
    name                          = string
    public_ip_address_id          = optional(string)
    private_ip_address            = optional(string)
    subnet_id                     = optional(string)
    private_ip_address_allocation = optional(string)
    zone                          = optional(number)
    port                          = optional(number)
  }))
  default = []
}
variable "firewall_policy_id" {
  type    = string
  default = null
}
variable "identity_id" {
  description = "identity_id"
  type        = string
}
variable "ssl_policy" {
  description = "identity_id"
  type        = map(string)
}
variable "requires_identity" {
  type    = bool
  default = true
}
variable "user_managed_identity" {
  description = "(optional) user manage identity Id, requires if 'requires_identity' field set to true"
  type        = string
}
variable "ssl_certificate" {
  description = "ssl_certificate"
  type        = list(map(any))
}


variable "probe_settings" {
  description = "probe_settings"
  type = list(object({
    name                                      = string
    protocol                                  = string
    host                                      = string
    path                                      = string
    interval                                  = number
    timeout                                   = number
    unhealthy_threshold                       = number
    pick_host_name_from_backend_http_settings = optional(bool)
  }))
  default = []
}
variable "public_ip_address_id" {
  description = "public_ip_address_id"
  type        = string
  nullable    = false
}
