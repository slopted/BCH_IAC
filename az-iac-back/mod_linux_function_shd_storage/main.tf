provider "azurerm" {
  features {}
}

resource "azurerm_user_assigned_identity" "lf_identity" {
  count = var.identity_name  != null ? 1 : 0
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location 
  os_type             = "Linux"
  sku_name            = var.sku_name #default = "Y1"
  worker_count                 = var.service_plan_worker_count  # default "1"
  maximum_elastic_worker_count = var.service_plan_max_elastic_worker_count  # default "1"
}

resource "azurerm_linux_function_app" "lfa" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  https_only = var.linux_function_app_https_only
#  public_network_access_enabled = var.linux_function_app_pna_enabled

 
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {
    always_on             = true
    vnet_route_all_enabled = var.vnet_route_all_enabled

    dynamic "application_stack" {
      for_each = var.deployment_type != "container" ? [1] : []
      content {
        python_version = var.python_version
      }
    }
  }

  identity {
    type = var.identity_type
    identity_ids = var.identity_type=="UserAssigned"?[azurerm_user_assigned_identity.lf_identity[0].id]:null
  }

  app_settings = merge(
    {
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    },
    var.deployment_type == "container" ? {
      "DOCKER_CUSTOM_IMAGE_NAME" = "${var.container_registry_url}/${var.container_image_name}"
      "DOCKER_REGISTRY_SERVER_URL" = "https://${var.container_registry_url}"
    } : {}
  )

  #app_settings = var.linux_function_app_settings
  tags = var.tags

}

#resource "azurerm_subnet" "subnet_vni" {
#  name                 = var.subnet_vni_name
#  resource_group_name  = var.resource_group_name
#  virtual_network_name = var.virtual_network_name
#  address_prefixes     = var.subnet_vni_address_prefixes
#}

resource "azurerm_app_service_virtual_network_swift_connection" "asv" {
  app_service_id = azurerm_linux_function_app.lfa.id
  subnet_id      = var.swift_subnet_id
}

#resource "azurerm_function_app_source_control" "source_control" {
#  count               = var.deployment_type == "source" ? 1 : 0
#  function_app_id     = azurerm_linux_function_app.lfa.id
#  repo_url            = var.source_code_path
#  branch              = "master"
#  use_mercurial       = false
#}