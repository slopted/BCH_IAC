module "privatelink_servicebus_windows_net" {
  source = "../../../az-iac-back/mod_private_dns_zone"
  azurerm_private_dns_zone_name = "privatelink.servicebus.windows.net"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  create_dns_link = true
  pvt_dnszne_vnet_link_name = "link-servicebus-pdnszone-vnet-hubprd-scl-001"
  vnet_id = data.azurerm_virtual_network.vnet-hubprd-scl-001.id
}