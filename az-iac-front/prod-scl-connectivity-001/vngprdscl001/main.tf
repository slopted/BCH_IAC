module "vng-prd-scl-001" {
  source              = "../../../az-iac-back/mod_virtual_network_gateway"
  name                = "vng-prd-scl-001"
  location            = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  generation          = "None"
  sku                 = "ErGw3AZ"
  type                = "ExpressRoute"
  vpn_type            = "PolicyBased"
  ip_configuration = {
    name                          = "default"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.GatewaySubnet.id
  }
  tags = {}
}