module "route-prd-gateway-01" {
  #source              = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_route_table?ref=main"
  source                        = "../../../az-iac-back/mod_route_table"
  name                          = "route-prd-gateway-01"
  location                      = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  resource_group_name           = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  bgp_route_propagation_enabled = true
  route = [
    {
      address_prefix         = "10.99.141.1/32"
      name                   = "cdlv-loopback-prod-sdwan"
      next_hop_in_ip_address = "10.99.41.22"
      next_hop_type          = "VirtualAppliance"
      }, {
      address_prefix         = "10.99.141.2/32"
      name                   = "lgvl-loopback-prod-sdwan"
      next_hop_in_ip_address = "10.99.41.22"
      next_hop_type          = "VirtualAppliance"
      }, {
      address_prefix         = "10.99.141.3/32"
      name                   = "cdlv-cross-lgvl-loopback-prod-sdwan"
      next_hop_in_ip_address = "10.99.41.22"
      next_hop_type          = "VirtualAppliance"
      }, {
      address_prefix         = "10.99.141.4/32"
      name                   = "lgvl-cross-cdlv-loopback-prod-sdwan"
      next_hop_in_ip_address = "10.99.41.22"
      next_hop_type          = "VirtualAppliance"
  }]
  subnet_id = [data.azurerm_subnet.GatewaySubnet.id]
  tags = {
    environment = "prd"
    project     = "scl"
    owner       = "ldz"
  }
}

  