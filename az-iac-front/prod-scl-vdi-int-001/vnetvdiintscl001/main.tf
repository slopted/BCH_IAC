module "vnet-vdi-int-scl-001" {
  #source             = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network?ref=master"
  source                  = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network?ref=main"
  name                    = "vnet-vdi-int-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  address_space           = ["10.135.160.0/19", "10.135.192.0/19", "10.135.224.0/19"]
}

# ==========================================================
#  ESCRITORIOS AVD INTERNOS (4500 USUARIOS)
# ==========================================================

# WARNING: The following Azure ESCRITORIOS AVD INTERNOS (4500 USUARIOS) subnet configuration is pending review and approval by the project's team.
# Please verify address ranges, naming conventions, and requirements before deployment.

module "snet-vdi-int-com-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-com-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.160.0/23"]
}

module "snet-vdi-int-base-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-base-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.162.0/26"]
}

module "snet-vdi-int-cyf-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-cyf-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.162.64/26"]
}

module "snet-vdi-int-inter-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-inter-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.162.128/26"]
}

module "snet-vdi-int-basic-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-basic-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.162.192/26"]
}

module "snet-vdi-int-mda-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-mda-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.163.0/26"]
}

module "snet-vdi-int-infra-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-infra-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.163.64/26"]
}

module "snet-vdi-int-rrhh-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-rrhh-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.163.128/26"]
}

module "snet-vdi-int-corp-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-corp-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.163.192/26"]
}

module "snet-vdi-int-opmet-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-opmet-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.164.0/26"]
}

module "snet-vdi-int-blegal-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-blegal-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.164.64/26"]
}

module "snet-vdi-int-erp-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-erp-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.164.128/26"]
}

module "snet-vdi-int-maze-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-maze-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.164.192/26"]
}

module "snet-vdi-int-leasing-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-leasing-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.165.0/26"]
}

module "snet-vdi-int-win-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-win-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.192.0/19"]
}

module "snet-vdi-int-otros-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  name                 = "snet-vdi-int-otros-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-int-001.name
  virtual_network_name = module.vnet-vdi-int-scl-001.name
  address_prefixes     = ["10.135.224.0/19"]
}