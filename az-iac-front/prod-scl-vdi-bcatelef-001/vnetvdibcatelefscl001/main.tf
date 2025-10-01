module "vnet-vdi-bcatelef-scl-001" {
  source                  = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network?ref=main"
  name                    = "vnet-vdi-bcatelef-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-vdi-bcatelef-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-vdi-bcatelef-001.name
  address_space           = ["10.135.132.0/22"]
}

# ==========================================================
#  Escritorios AVD Bca. Telefónica (524 Usuarios)
# ==========================================================

# WARNING: The following Azure Escritorios AVD internos USA (100 Usuarios) subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "snet-vdi-bcatelef-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-vdi-bcatelef-scl-001]
  name                 = "snet-vdi-bcatelef-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-bcatelef-001.name
  virtual_network_name = module.vnet-vdi-bcatelef-scl-001.name
  address_prefixes     = ["10.135.132.0/22"]
}