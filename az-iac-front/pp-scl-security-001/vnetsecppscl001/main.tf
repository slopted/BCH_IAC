module "vnet-secpp-scl-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network"
  name     = "vnet-secpp-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  address_space = ["10.134.8.0/24"]
  dns_servers   = ["10.134.2.4"]
  tags          = {}
}

# ========================================================
#   QRADAR | IMPERVA | DARKTRACE | CYBERARK | BALANCEADOR
# ========================================================

module "snet-secpp-cstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-secpp-scl-001 ]
  name     = "snet-secpp-cstools-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefixes = ["10.134.8.0/27"]
}

# ===========================
#      BALANCEADOR
# ===========================

module "snet-secpp-lbcstools-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet"
  depends_on = [ module.vnet-secpp-scl-001 ]
  name     = "snet-secpp-lbcstools-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  virtual_network_name = module.vnet-secpp-scl-001.name
  address_prefixes = ["10.134.8.32/27"]

}

