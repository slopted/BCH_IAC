data "azurerm_resource_group" "rg" {
  name = "rg-prd-scl-hub-001"
}

data "azurerm_virtual_network" "vnet_hubprd" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_mgmt" {
  name                 = "snet-hubprd-fwpl-mgmt-001"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_trust" {
  name                 = "snet-hubprd-fwpl-trust-001"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet_untrust2" {
  name                 = "snet-hubprd-fwpl-untrust-002"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

# NSGs existentes
data "azurerm_network_security_group" "nsg_mgmt" {
  name                = "nsg-prd-fwpan-mgmt-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_network_security_group" "nsg_trust" {
  name                = "nsg-prd-fwpan-trust-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_network_security_group" "nsg_untrust" {
  name                = "nsg-prd-fwpan-untrust-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# LB existente
data "azurerm_lb" "fwpan_lb" {
  name                = "lb-scl-prd-fwpan-trust-001"
  resource_group_name = data.azurerm_resource_group.rg.name
}
data "azurerm_lb_backend_address_pool" "fwpan_backend" {
  name            = "backend_fw"
  loadbalancer_id = data.azurerm_lb.fwpan_lb.id
}
