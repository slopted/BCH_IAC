data "azurerm_resource_group" "rg-prd-scl-vdi-com-001" {
  name = "rg-prd-scl-vdi-com-001"
}

data "azurerm_virtual_desktop_host_pool" "hp-prd-eu1-vdi-com-001" {
  name                = "hp-prd-eu1-vdi-com-001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-vdi-com-001.name
}