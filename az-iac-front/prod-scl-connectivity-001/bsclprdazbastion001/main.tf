# Azure Bastion

resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-prd-bastion-scl"
  location            = data.azurerm_resource_group.rg_prd_scl_hub_001.location
  resource_group_name = data.azurerm_resource_group.rg_prd_scl_hub_001.name

  allocation_method = "Static"
  sku               = "Standard"

  # Etiquetas opcionales
  tags = {}
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-scl-prd"
  location            = data.azurerm_resource_group.rg_prd_scl_hub_001.location
  resource_group_name = data.azurerm_resource_group.rg_prd_scl_hub_001.name
  sku                 = "Standard"

  ip_configuration {
    name                 = "bastion-ipconfig"
    subnet_id            = data.azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  # Etiquetas opcionales
  tags = {}
}
