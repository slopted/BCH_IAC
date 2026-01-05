module "vnet-sharedprd-scl-001" {
  source                  = "../../../az-iac-back/mod_virtual_network"
  name                    = "vnet-sharedprd-scl-001"
  resource_group_location = data.azurerm_resource_group.rg-prd-scl-shared-001.location
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-shared-001.name
  address_space           = ["10.133.11.0/24"]
  #dns_servers             = ["10.133.2.4"]
  tags = {}
}


# ===========================
#   ZABBIX | MONITOREO
# ===========================

module "snet-sharedprd-serv-001" {
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-sharedprd-scl-001]
  name                 = "snet-sharedprd-serv-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-shared-001.name
  virtual_network_name = module.vnet-sharedprd-scl-001.name
  address_prefixes     = ["10.133.11.0/26"]
}

# ===========================
# BALANCEADOR DE CARGA
# ===========================

module "snet-sharedprd-lbserv-001" {
  source               = "../../../az-iac-back/mod_subnet"
  depends_on           = [module.vnet-sharedprd-scl-001]
  name                 = "snet-sharedprd-lbserv-001"
  resource_group_name  = data.azurerm_resource_group.rg-prd-scl-shared-001.name
  virtual_network_name = module.vnet-sharedprd-scl-001.name
  address_prefixes     = ["10.133.11.64/27"]

}

