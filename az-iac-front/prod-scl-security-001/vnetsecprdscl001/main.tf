module "vnet-secprd-scl-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  source = "../../../az-iac-back/mod_virtual_network"
  name     = "vnet-secprd-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-sec-001.location
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-sec-001.name
  address_space = ["10.134.8.0/24"]
  #dns_servers   = ["10.134.2.4"]
  tags          = {}
}

# ========================================================
#   QRADAR | IMPERVA | DARKTRACE | CYBERARK | BALANCEADOR
# ========================================================

module "snet-secprd-cstools-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  source = "../../../az-iac-back/mod_subnet"
  depends_on = [ module.vnet-secprd-scl-001 ]
  name     = "snet-secprd-cstools-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-sec-001.name
  virtual_network_name = module.vnet-secprd-scl-001.name
  address_prefixes = ["10.134.8.0/27"]
}

# ===========================
#      BALANCEADOR
# ===========================

module "snet-secprd-lbcstools-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  source = "../../../az-iac-back/mod_subnet"
  depends_on = [ module.vnet-secprd-scl-001 ]
  name     = "snet-secprd-lbcstools-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-sec-001.name
  virtual_network_name = module.vnet-secprd-scl-001.name
  address_prefixes = ["10.134.8.32/27"]

}

