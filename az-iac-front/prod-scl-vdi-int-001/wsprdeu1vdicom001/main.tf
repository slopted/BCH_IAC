module "ws-prd-eu1-vdi-com-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  source                        = "../../../az-iac-back/mod_virtual_desktop_workspace"
  name                          = "ws-prd-eu1-vdi-com-001"
  resource_group_name           = data.azurerm_resource_group.rg-prd-scl-vdi-com-001.name
  location                      = "eastus"
  friendly_name                 = "Escritorio Virtual Comercial"
  description                   = "Escritorio Virtual Comercial"
  public_network_access_enabled = true
  tags                          = {}
}