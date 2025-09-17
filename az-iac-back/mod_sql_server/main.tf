provider "azurerm" {
  features {}
}
#resource "azurerm_user_assigned_identity" "dbaas_identity" {
#  name                = var.identity_name
#  location            = var.resource_group_location
#  resource_group_name = var.resource_group_name
#}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = var.sqlserver_version
  administrator_login          = var.sqlserver_administrator_login
  administrator_login_password = var.sqlserver_administrator_password
  minimum_tls_version          = var.sqlserver_minimum_tls_version
  public_network_access_enabled = var.sqlserver_pna_enabled

#  azuread_administrator {
#    login_username = azurerm_user_assigned_identity.dbaas_identity.name
#    object_id      = azurerm_user_assigned_identity.dbaas_identity.principal_id
#  }#

#  identity {
##    identity_ids = [azurerm_user_assigned_identity.dbaas_identity.id]
#    type = var.identity_type
#    identity_ids = var.identity_type=="UserAssigned"?[azurerm_user_assigned_identity.dbaas_identity[0].id]:null    
#  }

#  primary_user_assigned_identity_id = azurerm_user_assigned_identity.dbaas_identity.id

  tags = var.tags 
}


#resource "azurerm_subnet" "subnet_vni" {
#  name                 = var.subnet_vni_name
#  resource_group_name  = var.resource_group_name
#  virtual_network_name = var.virtual_network_name
#  address_prefixes     = var.subnet_vni_address_prefixes
#}
#
#resource "azurerm_app_service_virtual_network_swift_connection" "asv" {
#  app_service_id = azurerm_linux_function_app.lfa.id
#  subnet_id      = azurerm_subnet.subnet_vni.id
#}

