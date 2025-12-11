module "ag-prd-eu1-vdi-com-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  source                       = "../../../az-iac-back/mod_virtual_desktop_application_group"
  name                         = "ag-prd-eu1-vdi-com-001"
  resource_group_name          = data.azurerm_resource_group.rg-prd-scl-vdi-com-001.name
  location                     = "eastus"
  type                         = "Desktop"
  host_pool_id                 = data.azurerm_virtual_desktop_host_pool.hp-prd-eu1-vdi-com-001.id
  friendly_name                = "Aplicaciones Virtuales Comercial"
  default_desktop_display_name = "Aplicaciones Virtuales Comercial"
  description                  = "Aplicaciones Virtuales Comercial"
  tags                         = {}
}