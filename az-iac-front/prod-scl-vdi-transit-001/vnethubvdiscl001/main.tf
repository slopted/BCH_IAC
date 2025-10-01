module "vnet-hub-vdi-scl-001" {
  source                  = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network?ref=main"
  name                    = "vnet-hub-vdi-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  address_space = [
    "10.135.3.0/24",
    "10.135.4.0/24",
    "10.135.5.0/24"
  ]
}

# ===========================
#         Peerings
# ===========================

module "peering-hub-to-spoke-vnet-vdi-ext-scl-001" {
  source = "../../../az-iac-back/mod_virtual_network_peering"
  #source                    = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network_peering?ref=main"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 3121149b-8a94-423b-898f-f991ddf44a76
  vnet_peering_Hub          = module.vnet-hub-vdi-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 4139047f-8a25-4132-ad74-f3ca66ffb5af
  vnet_peering_Spoke        = "vnet-vdi-ext-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-vdi-ext-001"
}

module "peering-hub-to-spoke-vnet-vdi-int-scl-001" {
  source = "../../../az-iac-back/mod_virtual_network_peering"
  #source                    = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network_peering?ref=main"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 3121149b-8a94-423b-898f-f991ddf44a76
  vnet_peering_Hub          = module.vnet-hub-vdi-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 5a22757f-0fef-458e-b601-9249cfee6c5b
  vnet_peering_Spoke        = "vnet-vdi-int-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-vdi-int-001"
}

module "peering-hub-to-spoke-vnet-vdi-bcatelef-scl-001" {
  source = "../../../az-iac-back/mod_virtual_network_peering"
  #source                    = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_network_peering?ref=main"
  subscription_id_Hub       = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 3121149b-8a94-423b-898f-f991ddf44a76
  vnet_peering_Hub          = module.vnet-hub-vdi-scl-001.name
  resource_group_name_Hub   = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  subscription_id_Spoke     = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3" # 821a870e-e55f-43bd-ac17-61e19b0e416a
  vnet_peering_Spoke        = "vnet-vdi-bcatelef-scl-001"
  resource_group_name_Spoke = "rg-prd-scl-vdi-bcatelef-001"
}

# ===========================
#   Firewall Palo Alto
# ===========================

module "snet-hubprd-vdi-fwpl-trust-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.3.0/28"]
}

module "snet-hubprd-vdi-fwpl-trust-002" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-trust-002"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.4.0/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.3.16/28"]
}

module "snet-hubprd-vdi-fwpl-untrust-002" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-untrust-002"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.4.16/28"]
}

module "snet-hubprd-vdi-fwpl-lb-trust-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-lb-trust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.5.0/28"]
}

module "snet-hubprd-vdi-fwpl-lb-untrust-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-lb-untrust-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.5.16/28"]
}

module "snet-hubprd-vdi-fwpl-mgmt-001" {
  source               = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_subnet?ref=main"
  depends_on           = [module.vnet-hub-vdi-scl-001]
  name                 = "snet-hubprd-vdi-fwpl-mgmt-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-vdi-hub-001.name
  virtual_network_name = module.vnet-hub-vdi-scl-001.name
  address_prefixes     = ["10.135.3.32/28"]
}