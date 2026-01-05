module "route-prd-shared-001" {
  source                        = "../../../az-iac-back/mod_route_table"
  name                          = "route-prd-shared-001"
  location                      = data.azurerm_resource_group.rg-prd-scl-shared-001.location
  resource_group_name           = data.azurerm_resource_group.rg-prd-scl-shared-001.name
  bgp_route_propagation_enabled = false
  route = [
    {
      address_prefix         = "172.16.0.0/12"
      name                   = "ns-route-prd-001"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "192.168.0.0/16"
      name                   = "ns-route-prd-002"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "10.0.0.0/8"
      name                   = "ns-route-prd-003"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "152.139.0.0/16"
      name                   = "ns-route-prd-004"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "200.14.0.0/16"
      name                   = "ns-route-prd-005"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "166.110.0.0/16"
      name                   = "ns-route-prd-006"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "200.10.0.0/23"
      name                   = "ns-route-prd-007"
      next_hop_in_ip_address = data.azurerm_firewall.azfw-prd-scl.ip_configuration[0].private_ip_address
      next_hop_type          = "VirtualAppliance"
    },
    {
      address_prefix         = "0.0.0.0/0"
      name                   = "ns-default-route-prd"
      next_hop_in_ip_address = "10.133.1.132"
      next_hop_type          = "VirtualAppliance"
    }

  ]
  subnet_id = [
    data.azurerm_subnet.snet-sharedprd-lbserv-001.id,
    data.azurerm_subnet.snet-sharedprd-serv-001.id
  ]
  tags = {}
}
