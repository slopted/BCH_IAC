module "expr-prd-scl-lgvl-pit-1477" {
  source              = "../../../az-iac-back/mod_express_route_circuit"
  bandwidth_in_mbps        = 1000
  location                 = data.azurerm_resource_group.rg-prd-scl-hub-001.location
  name                     = "expr-prd-scl-lgvl-pit-1477"
  peering_location         = "Santiago"
  resource_group_name      = data.azurerm_resource_group.rg-prd-scl-hub-001.name
  service_provider_name    = "PITChile"
  tags                     = {}
  sku ={
    family = "MeteredData"
    tier   = "Standard"
  }
}