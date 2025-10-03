module "vnet-hubprd-scl-001" {
  #source                  = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network?ref=master"
  source = "../../../az-iac-back/mod_virtual_network"
  name                    = "vnet-hubprd-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  address_space           = ["10.133.0.0/24", "10.133.1.0/24", "10.133.2.0/24", "10.133.3.0/24", "10.133.4.0/24", "10.133.5.0/24", "10.133.7.0/24","10.99.141.1/32", "10.99.141.2/32", "10.99.141.3/32", "10.99.141.4/32", "10.99.41.0/24"]
}

# ===========================
#         Peerings
# ===========================

module "peering-hub-to-spoke-vnet-secprd-scl-001" {
#source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network_peering?ref=master"
  source = "../../../az-iac-back/mod_virtual_network_peering"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"0bf6c8d9-16da-4233-8bca-2c16e2733205"
  vnet_peering_Hub          = module.vnet-hubprd-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"74546d30-0916-4a80-ae4d-abfe681dafd5"
  vnet_peering_Spoke        = "vnet-secprd-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-sec-001"
}

module "peering-hub-to-spoke-vnet-dcprd-scl-001" {
  #source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network_peering?ref=master"
  source = "../../../az-iac-back/mod_virtual_network_peering"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"0bf6c8d9-16da-4233-8bca-2c16e2733205"
  vnet_peering_Hub          = module.vnet-hubprd-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"404cfa9e-3b50-486b-bc28-d6dd3530d2ab"
  vnet_peering_Spoke        = "vnet-dcprd-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-dc-001"
}
/*
module "peering-hub-to-spoke-vnet-bkprdp-scl-001" {
  source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network_peering?ref=master"
  subscription_id_Hub       = "0bf6c8d9-16da-4233-8bca-2c16e2733205"
  vnet_peering_Hub          = module.vnet-hubprd-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  subscription_id_Spoke     = "901a42d0-b1e4-4ab7-a50b-66f91a3e6d41"
  vnet_peering_Spoke        = "vnet-bkprdp-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-bkp-001"
}

module "peering-hub-to-spoke-vnet-sharedprd-scl-001" {
  source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network_peering?ref=master"
  subscription_id_Hub       = "0bf6c8d9-16da-4233-8bca-2c16e2733205"
  vnet_peering_Hub          = module.vnet-hubprd-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  subscription_id_Spoke     = "fb591a13-981e-4a6f-a106-de39db876fdc"
  vnet_peering_Spoke        = "vnet-sharedprd-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-shared-001"
}*/

module "peering-hub-to-hub-vnet-hub-vdi-scl-001" {
  #source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_network_peering?ref=master"
  source = "../../../az-iac-back/mod_virtual_network_peering"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"0bf6c8d9-16da-4233-8bca-2c16e2733205"
  vnet_peering_Hub          = module.vnet-hubprd-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" #"3121149b-8a94-423b-898f-f991ddf44a76"
  vnet_peering_Spoke        = "vnet-hub-vdi-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-vdi-hub-001"
}

# ===========================
#         SDWAN
# ===========================

module "snet-hubprd-sdwan-trust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.16/28"]
}

module "snet-hubprd-sdwan-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.0/28"]
}

module "snet-hubprd-sdwan-ha-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-sdwan-ha-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.99.41.32/28"]
}

module "snet-hubprd-sdwan-mgmt-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
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
  source = "../../../az-iac-back/mod_subnet"
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
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-dns-inbound-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.2.0/28"]
}

module "snet-hubprd-dns-outbound-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
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
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.1.128/28"]
}


module "snet-hubprd-fwpl-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.3.0/24"]
}

module "snet-hubprd-fwpl-untrust-002" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-untrust-002"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.4.0/24"]
}

module "snet-hubprd-fwpl-lb-untrust-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "snet-hubprd-fwpl-lb-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.5.0/24"]
}

module "snet-hubprd-fwpl-mgmt-001" {
  #source               = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet?ref=master"
  source = "../../../az-iac-back/mod_subnet"
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
  source = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-hubprd-scl-001]
  name                 = "GatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  virtual_network_name = module.vnet-hubprd-scl-001.name
  address_prefixes     = ["10.133.7.0/26"]
}

