module "route-pp-sec-001" {
  source                        = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_route_table?ref=master"
  name                          = "route-pp-sec-001"
  location                      = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name           = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  bgp_route_propagation_enabled = false
  route = [
    {
      address_prefix         = "172.16.0.0/12"
      name                   = "ns-route-pp-001"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "192.168.0.0/16"
      name                   = "ns-route-pp-002"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "10.0.0.0/8"
      name                   = "ns-route-pp-003"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "152.139.0.0/16"
      name                   = "ns-route-pp-004"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "200.14.0.0/16"
      name                   = "ns-route-pp-005"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "166.110.0.0/16"
      name                   = "ns-route-pp-006"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "200.10.0.0/23"
      name                   = "ns-route-pp-007"
      next_hop_in_ip_address = "10.134.6.4"
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "0.0.0.0/0"
      name                   = "ns-default-route-pp"
      next_hop_in_ip_address = "10.134.1.132"
      next_hop_type          = "VirtualAppliance"
    }

  ]
  subnet_id = [
    data.azurerm_subnet.snet-secpp-cstools-001.id, 
    data.azurerm_subnet.snet-secpp-lbcstools-001.id
    ]
  tags      = {}
}
