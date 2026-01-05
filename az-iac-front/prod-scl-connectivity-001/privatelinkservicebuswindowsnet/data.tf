data "azurerm_resource_group" "rg-prd-scl-hub-001" {
  name = "rg-prd-scl-hub-001"
}

# VNet del HUB a la que vamos a asociar la Private DNS Zone
data "azurerm_virtual_network" "vnet-hubprd-scl-001" {
  name                = "vnet-hubprd-scl-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
}