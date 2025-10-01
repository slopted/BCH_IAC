############################
# ChileCentral – Datos base b
############################

data "azurerm_resource_group" "rg" {
  name = "rg-prd-scl-hub-001"
}

########################################
# data.tf — NICs UNTRUST SD-WAN (existentes)
# Valida que las ipConfigurations tengan los nombres requeridos
########################################

locals {
  untrust_ipconfig_name_001 = "lsclprdazvmsdwan001-sdwan-untrust-ipconfig-01"
  untrust_ipconfig_name_002 = "lsclprdazvmsdwan002-sdwan-untrust-ipconfig-01"
}

data "azurerm_network_interface" "sdwan_untrust_nic_001" {
  name                = "lsclprdazvmsdwan001-sdwan-untrust-nic-01"
  resource_group_name = data.azurerm_resource_group.rg.name

  # Asegura que la NIC tenga una ipConfiguration con el nombre esperado
  lifecycle {
    postcondition {
      condition     = contains([for c in self.ip_configuration : c.name], local.untrust_ipconfig_name_001)
      error_message = "La NIC lsclprdazvmsdwan001-sdwan-untrust-nic-01 debe tener una ipConfiguration llamada ${local.untrust_ipconfig_name_001}. Renómbrala (o recrea la NIC) para continuar."
    }
  }
}

data "azurerm_network_interface" "sdwan_untrust_nic_002" {
  name                = "lsclprdazvmsdwan002-sdwan-untrust-nic-01"
  resource_group_name = data.azurerm_resource_group.rg.name

  lifecycle {
    postcondition {
      condition     = contains([for c in self.ip_configuration : c.name], local.untrust_ipconfig_name_002)
      error_message = "La NIC lsclprdazvmsdwan002-sdwan-untrust-nic-01 debe tener una ipConfiguration llamada ${local.untrust_ipconfig_name_002}. Renómbrala (o recrea la NIC) para continuar."
    }
  }
}

# (Opcional) Si necesitas referenciar el ID de esa ipConfiguration específica:
# output "sdwan_untrust_nic_001_ipconfig_id" {
#   value = one([for c in data.azurerm_network_interface.sdwan_untrust_nic_001.ip_configuration : c.id if c.name == local.untrust_ipconfig_name_001])
# }
# output "sdwan_untrust_nic_002_ipconfig_id" {
#   value = one([for c in data.azurerm_network_interface.sdwan_untrust_nic_002.ip_configuration : c.id if c.name == local.untrust_ipconfig_name_002])
# }

