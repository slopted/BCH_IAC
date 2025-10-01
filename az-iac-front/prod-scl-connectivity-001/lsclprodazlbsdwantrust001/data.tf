############################
# ChileCentral – Datos base
############################

data "azurerm_resource_group" "rg" {
  name = "rg-prd-scl-hub-001"
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_sdwan_trust" {
  name                 = "snet-hubprd-sdwan-trust-001"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

########################################
# Nombres canónicos y ipConfigs requeridas
########################################
locals {
  sdwan_trust_nic_001     = "lsclprdazvmsdwan001-sdwan-trust-nic-01"
  sdwan_trust_nic_002     = "lsclprdazvmsdwan002-sdwan-trust-nic-01"
  trust_ipconfig_name_001 = "lsclprdazvmsdwan001-sdwan-trust-ipconfig-01"
  trust_ipconfig_name_002 = "lsclprdazvmsdwan002-sdwan-trust-ipconfig-01"
}

#########################################################
# NICs TRUST de los SD-WAN (deben existir con ipconfig OK)
#########################################################

data "azurerm_network_interface" "sdwan_trust_nic_001" {
  name                = local.sdwan_trust_nic_001
  resource_group_name = data.azurerm_resource_group.rg.name

  lifecycle {
    postcondition {
      condition     = contains([for c in self.ip_configuration : c.name], local.trust_ipconfig_name_001)
      error_message = "La NIC ${local.sdwan_trust_nic_001} debe tener una ipConfiguration llamada ${local.trust_ipconfig_name_001}."
    }
  }
}

data "azurerm_network_interface" "sdwan_trust_nic_002" {
  name                = local.sdwan_trust_nic_002
  resource_group_name = data.azurerm_resource_group.rg.name

  lifecycle {
    postcondition {
      condition     = contains([for c in self.ip_configuration : c.name], local.trust_ipconfig_name_002)
      error_message = "La NIC ${local.sdwan_trust_nic_002} debe tener una ipConfiguration llamada ${local.trust_ipconfig_name_002}."
    }
  }
}

# (Opcional) IDs de las ipConfigs específicas
# output "sdwan_trust_nic_001_ipconfig_id" {
#   value       = one([for c in data.azurerm_network_interface.sdwan_trust_nic_001.ip_configuration : c.id if c.name == local.trust_ipconfig_name_001])
#   description = "ID de la ipConfiguration TRUST en la NIC 001."
# }
# output "sdwan_trust_nic_002_ipconfig_id" {
#   value       = one([for c in data.azurerm_network_interface.sdwan_trust_nic_002.ip_configuration : c.id if c.name == local.trust_ipconfig_name_002])
#   description = "ID de la ipConfiguration TRUST en la NIC 002."
# }
