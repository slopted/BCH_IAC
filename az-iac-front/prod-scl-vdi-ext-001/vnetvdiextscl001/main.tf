module "vnet-vdi-ext-scl-001" {
  source                  = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network?ref=main"
  name                    = "vnet-vdi-ext-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-vdi-ext-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-vdi-ext-001.name
  address_space           = ["10.135.128.0/22"]
}


# ==========================================================
#  ESCRITORIOS AVD EXTERNOS (850 USUARIOS)
# ==========================================================

module "snet-vdi-ext-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-ext-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-ext-001.name
  virtual_network_name = module.vnet-vdi-ext-scl-001.name
  address_prefixes     = ["10.135.128.0/22"]
}