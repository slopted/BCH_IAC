module "expr-prd-scl-cdlv-cross-lgvl-pit-1577" {
  source              = "../../../az-iac-back/mod_express_route_circuit"
  bandwidth_in_mbps        = 1000
  location                 = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  name                     = "expr-prd-scl-cdlv-cross-lgvl-pit-1577"
  peering_location         = "Santiago"
  resource_group_name      = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  service_provider_name    = "PITChile"
  tags                     = {}
  sku = {
    family = "MeteredData"
    tier   = "Standard"
  }
}


module "expr-pp-scl-cdlv-cross-lgvl-pit-1577-peering" {
  source                        = "../../../az-iac-back/mod_express_route_circuit_peering"
  peering_type                  = "AzurePrivatePeering"
  express_route_circuit_name    = module.expr-pp-scl-cdlv-cross-lgvl-pit-1577.name
  resource_group_name           = data.azurerm_resource_group.rg-pp-scl-hub-001.name
  peer_asn                      = 64624
  primary_peer_address_prefix   = "10.209.241.16/30"
  secondary_peer_address_prefix = "10.209.241.8/30"
  vlan_id                       = 1578
  depends_on                    = [module.expr-pp-scl-cdlv-cross-lgvl-pit-1577]
}