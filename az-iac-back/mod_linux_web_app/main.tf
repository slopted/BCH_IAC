resource "azurerm_user_assigned_identity" "lwa_identity" {
  count = var.identity_name != null ? 1 : 0

  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

}

resource "azurerm_service_plan" "sp" {
  name                         = lower("appsrvp-${var.app_name}")
  location                     = var.resource_group_location
  resource_group_name          = var.resource_group_name
  os_type                      = var.app_os_type
  sku_name                     = var.app_sku_name
#  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  worker_count                 = var.worker_count
}

resource "azurerm_linux_web_app" "webapp" {
  name                = lower("${var.app_name}")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.sp.id

  https_only              = true
  client_affinity_enabled = true

  site_config {
    always_on               = true
    http2_enabled           = true
    ftps_state              = "Disabled"
    minimum_tls_version     = 1.2
    scm_minimum_tls_version = 1.2
    app_command_line        = var.app_command_line

    remote_debugging_enabled = var.remote_debugging_enabled
    vnet_route_all_enabled = var.vnet_route_all_enabled

    application_stack {
      dotnet_version = var.dotnet_version
      go_version     = var.go_version
      node_version   = var.node_version   #12-lts, 14-lts, 16-lts, and 18-lts
      python_version = var.python_version #3.7, 3.8, 3.9, 3.10 and 3.11
      ruby_version   = var.ruby_version   #2.6 and 2.7
    }

#    api_management_api_id = azurerm_api_management_api.ama.id
    cors {
      allowed_origins     = var.allowed_origins
    }
  }

  app_settings = var.app_settings

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? [azurerm_user_assigned_identity.lwa_identity[0].id] : null
  }

  # virtual_network_subnet_id = var.virtual_network_subnet_id

  tags = var.tags
}
