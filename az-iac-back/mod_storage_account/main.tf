resource "azurerm_user_assigned_identity" "sa_identity" {
  count = var.identity_name  != null ? 1 : 0
  name                = var.identity_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.storage_account_account_tier #"Standard"
  account_replication_type = var.storage_account_replication_type #"LRS"
  public_network_access_enabled = var.storage_account_pna_enabled
  
  identity{
    type = var.identity_type
    identity_ids = var.identity_type=="UserAssigned"?[azurerm_user_assigned_identity.sa_identity[0].id]:null
#    identity_ids = [azurerm_user_assigned_identity.sa_identity.id]
  }
}

#Virtual network interface
resource "azurerm_network_interface" "nic" {
  name                = var.storage_private_nic_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

    ip_configuration {
      name                          = var.nic_ip_config_name
      subnet_id                     = var.nic_ip_config_subnet_id  #subnet de los recursos que se conectan 
      private_ip_address_allocation = var.nic_ipconfig_priv_ip_addr_alloc #default = "Dynamic"
    }
}

# Setup private-link
resource "azurerm_private_endpoint" "endpoint_sa" {
  name                = var.storage_private_endpoint_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.endpoint_storage_account_subnet_id  # subnet del storage account

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = var.private_service_connection_is_manual_connection  # default = false
    subresource_names              = var.private_service_connection_subresource_names   # default = ["queue"]
  }

  private_dns_zone_group {
    name                 = var.pvt_dnszne_grp
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}

#resource "azurerm_private_dns_zone" "pvdnszone" {
#  name                = var.azurerm_private_dns_zone_name  # default = "privatelink.blob.core.windows.net"
#  resource_group_name = var.resource_group_name
#}

