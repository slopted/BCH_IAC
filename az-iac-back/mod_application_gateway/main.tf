locals {
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  backend_address_pool_name      = "appgw-${var.app_gateway_name}-${local.location}-beap"
  frontend_ip_configuration_name = "appgw-${var.app_gateway_name}-${local.location}-feip"
  frontend_port_name             = "appgw-${var.app_gateway_name}-${local.location}-feport"
  gateway_ip_configuration_name  = "appgw-${var.app_gateway_name}-${local.location}-gwipc"
  http_setting_name              = "appgw-${var.app_gateway_name}-${local.location}-behtst"
  listener_name                  = "appgw-${var.app_gateway_name}-${local.location}-httplstn"
  request_routing_rule_name      = "appgw-${var.app_gateway_name}-${local.location}-rqrt"
  redirect_configuration_name    = "appgw-${var.app_gateway_name}-${local.location}-rdrcfg"
}

resource "azurerm_application_gateway" "agw" {
  name                = var.app_gateway_name
  location            = local.location
  resource_group_name = local.resource_group_name
  enable_http2        = true
  tags                = var.tags

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.autoscale_configuration == null ? var.sku.capacity : null
  }

  dynamic "identity" {
    for_each = var.requires_identity ? [1] : []

    content {
      type         = "UserAssigned"
      identity_ids = toset([var.user_managed_identity])
    }
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id
  }

  frontend_port {
    name = "${local.frontend_port_name}-http"
    port = 80
  }

  frontend_port {
    name = "${local.frontend_port_name}-https"
    port = 443
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = var.virtual_network_subnet_id
  }

  autoscale_configuration {
    max_capacity = var.autoscale_configuration.max_capacity
    min_capacity = var.autoscale_configuration.min_capacity
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "probe" {
    for_each = var.probe_settings
    content {
      name                                      = probe.value.name
      host                                      = probe.value.host
      interval                                  = probe.value.interval
      path                                      = probe.value.path
      protocol                                  = probe.value.protocol
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)

      match {
        body        = ""
        status_code = ["200-399", "401"]
      }
    }

  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      path                                = lookup(backend_http_settings.value, "path", "/")
      port                                = backend_http_settings.value.enable_https ? 443 : 80
      probe_name                          = backend_http_settings.value.probe_name
      protocol                            = backend_http_settings.value.enable_https ? "Https" : "Http"
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 30)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
      host_name                           = backend_http_settings.value.pick_host_name_from_backend_address == false ? lookup(backend_http_settings.value, "host_name") : null

      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining[*]
        content {
          enabled           = connection_draining.value.enable_connection_draining
          drain_timeout_sec = connection_draining.value.drain_timeout_sec
        }
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificate
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.keyvault_certificate_secret_id
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = "${local.frontend_port_name}-${http_listener.value.frontend_port_name}"
      host_name                      = lookup(http_listener.value, "host_name", null)
      host_names                     = lookup(http_listener.value, "host_names", [])
      protocol                       = lookup(http_listener.value, "protocol", "Http")
      require_sni                    = lookup(http_listener.value, "require_sni", false)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      firewall_policy_id             = lookup(http_listener.value, "firewall_policy_id", null)

      dynamic "custom_error_configuration" {
        for_each = http_listener.value.custom_error_configuration != null ? lookup(http_listener.value, "custom_error_configuration", {}) : []
        content {
          custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url", null)
          status_code           = lookup(custom_error_configuration.value, "status_code", null)
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      backend_address_pool_name   = request_routing_rule.value.redirect_configuration_enabled ? null : request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.redirect_configuration_enabled ? null : request_routing_rule.value.backend_http_settings_name
      http_listener_name          = request_routing_rule.value.http_listener_to
      rule_type                   = lookup(request_routing_rule.value, "rule_type", "Basic")
      priority                    = lookup(request_routing_rule.value, "priority", 100)
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_enabled ? request_routing_rule.value.redirect_configuration_name : null
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configuration != null ? var.redirect_configuration : []
    content {
      name                 = lookup(redirect_configuration.value, "name", null)
      redirect_type        = lookup(redirect_configuration.value, "redirect_type", null)
      target_listener_name = redirect_configuration.value.target_listener_name
      include_path         = lookup(redirect_configuration.value, "include_path", true)
      include_query_string = lookup(redirect_configuration.value, "include_query_string", true)
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration != null ? [var.waf_configuration] : []
    content {
      enabled                  = true
      firewall_mode            = lookup(waf_configuration.value, "firewall_mode", "Detection")
      rule_set_type            = "OWASP"
      rule_set_version         = lookup(waf_configuration.value, "rule_set_version", "3.1")
      file_upload_limit_mb     = lookup(waf_configuration.value, "file_upload_limit_mb", 100)
      request_body_check       = lookup(waf_configuration.value, "request_body_check", true)
      max_request_body_size_kb = lookup(waf_configuration.value, "max_request_body_size_kb", 128)
      dynamic "disabled_rule_group" {
        for_each = waf_configuration.value.disabled_rule_group
        content {
          rule_group_name = disabled_rule_group.value.rule_group_name
          rules           = disabled_rule_group.value.rules
        }
      }
      dynamic "exclusion" {
        for_each = waf_configuration.value.exclusion
        content {
          match_variable          = exclusion.value.match_variable
          selector_match_operator = exclusion.value.selector_match_operator
          selector                = exclusion.value.selector
        }
      }
    }
  }
}

