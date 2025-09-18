module "vnet-dcpp-scl-001" {
  source   = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network?ref=main"
  name     = "vnet-dcpp-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-pp-scl-dc-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  address_space = ["10.134.9.0/24"]
}

# ===========================
#     DOMAIN CONTROLLER
# ===========================

module "snet-dcpp-addc-001" {
  source   = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on = [ module.vnet-dcpp-scl-001 ]
  name     = "snet-dcpp-addc-001"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  virtual_network_name = module.vnet-dcpp-scl-001.name
  address_prefixes = ["10.134.9.0/26"]
}