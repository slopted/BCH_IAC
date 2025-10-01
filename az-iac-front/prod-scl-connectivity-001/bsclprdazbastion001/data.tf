# ===== Resource Group
data "azurerm_resource_group" "rg_prd_scl_hub_001" {
  name = "rg-prd-scl-hub-001"
}

# ===== VNet existente
data "azurerm_virtual_network" "vnet_hubprd_scl_001" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg_prd_scl_hub_001.name
}

# ===== Subnet de Bastion existente (debe llamarse exactamente AzureBastionSubnet)
data "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = data.azurerm_virtual_network.vnet_hubprd_scl_001.name
  resource_group_name  = data.azurerm_resource_group.rg_prd_scl_hub_001.name
}
