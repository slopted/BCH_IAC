provider "azurerm" {
  features {}
}

resource "azurerm_user_assigned_identity" "wwa_identity" {
  count = var.identity_name  != null ? 1 : 0
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type  = "Windows"
  sku_name = var.sku_name #"P1v2"
}

resource "azurerm_api_management" "am" {
  name                = var.api_management_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name  #"My Company"
  publisher_email     = var.publisher_email #"company@terraform.io"

  sku_name = "Developer_1"
}

resource "azurerm_api_management_api" "ama" {
  name                = var.azurerm_api_management_api_name
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.am.name
  revision            = var.azurerm_api_management_api_revision #"1"
  display_name        = var.azurerm_api_management_api_display_name
  path                = var.azurerm_api_management_api_path
  protocols           = var.azurerm_api_management_api_protocols

  import {
    content_format = var.azurerm_api_management_api_content_format #"swagger-link-json"
    content_value  = var.azurerm_api_management_api_content_value #"http://conferenceapi.azurewebsites.net/?format=json"
  }

}

resource "azurerm_windows_web_app" "wwa" {
  name                = var.web_app_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.sp.id
  https_only = var.windows_web_app_https_only
  public_network_access_enabled = var.windows_web_app_pna_enabled

  site_config {
    application_stack {
      current_stack  = var.current_stack
      dotnet_version = var.dotnet_version
    }
    api_management_api_id = azurerm_api_management_api.ama.id
  }

  app_settings = var.app_settings

  connection_string {
    name  = var.connection_string_name  #"Database"
    type  = var.connection_string_type  #"SQLServer"
    value = var.connection_string_value  #"Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

  identity{
    type = var.identity_type
#    identity_ids = [azurerm_user_assigned_identity.wwa_identity.id]
    identity_ids = var.identity_type=="UserAssigned"?[azurerm_user_assigned_identity.wwa_identity[0].id]:null    
  }

  virtual_network_subnet_id = var.virtual_network_subnet_id
  
  tags = var.tags
}