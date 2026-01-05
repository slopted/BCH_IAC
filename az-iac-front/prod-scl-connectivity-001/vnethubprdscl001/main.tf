module "vnet-hubprd-scl-001" {
  #source                  = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network?ref=master"
  source                  = "../../../az-iac-back/mod_virtual_network"
  name                    = "vnet-hubprd-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  address_space           = ["10.133.0.0/24", "10.133.1.0/24", "10.133.2.0/24", "10.133.3.0/24", "10.133.4.0/24", "10.133.5.0/24", "10.133.7.0/24", "10.99.141.1/32", "10.99.141.2/32", "10.99.141.3/32", "10.99.141.4/32", "10.99.41.0/24"]
}

# ===========================
#         SDWAN
# ===========================

module "snet-hubprd-sdwan-trust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.16/28"]
}

module "snet-hubprd-sdwan-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.0/28"]
}

module "snet-hubprd-sdwan-ha-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-ha-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.32/28"]
}

module "snet-hubprd-sdwan-mgmt-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-mgmt-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.48/28"]
}
# ===========================
#         Bastion
# ===========================

module "AzureBastionSubnet" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.1.0/26"]
}

# ===========================
#       DNS Privada
# ===========================

module "snet-hubprd-dns-inbound-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-dns-inbound-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.2.0/28"]
}

module "snet-hubprd-dns-outbound-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-dns-outbound-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.2.16/28"]
}

# ===========================
#   Firewall Palo Alto
# ===========================

module "snet-hubprd-fwpl-trust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.1.128/28"]
}


module "snet-hubprd-fwpl-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.3.0/24"]
}

module "snet-hubprd-fwpl-untrust-002" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-untrust-002"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.4.0/24"]
}

module "snet-hubprd-fwpl-lb-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-lb-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.5.0/24"]
}

module "snet-hubprd-fwpl-mgmt-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-mgmt-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.1.144/28"]
}

# ===========================
#        VPN Gateway
# ===========================

module "GatewaySubnet" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "GatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.7.0/26"]
}