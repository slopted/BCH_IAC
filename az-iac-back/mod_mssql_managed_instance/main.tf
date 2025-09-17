# Instancia administrada de SQL
resource "azurerm_mssql_managed_instance" "example_mssql_instance" {
  name                         = var.mssql_instance_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  sku_name                     = var.sku_name
  storage_size_in_gb           = var.storage_size_in_gb
  subnet_id                    = var.subnet_id
  public_data_endpoint_enabled = var.public_data_endpoint_enabled
  vcores                       = var.vcores
  license_type                 = var.license_type

  tags                         = var.tags
}