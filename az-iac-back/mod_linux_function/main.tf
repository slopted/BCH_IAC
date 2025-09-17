provider "azurerm" {
  features {}
}

resource "azurerm_user_assigned_identity" "lf_identity" {
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "salf_identity" {
  name                = var.sa_identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity{
    type = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.salf_identity.id]
  }
}

resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = var.sku_name #"EP1"
}

resource "azurerm_linux_function_app" "lfa" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  https_only = var.linux_function_app_https_only
  public_network_access_enabled = var.linux_function_app_pna_enabled


  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {
    application_stack {
      python_version = var.python_version
    }
  }


  identity {
    type = var.identity_type
    identity_ids = [azurerm_user_assigned_identity.lf_identity.id]
  }

  app_settings = var.linux_function_app_settings
  tags = var.tags

}