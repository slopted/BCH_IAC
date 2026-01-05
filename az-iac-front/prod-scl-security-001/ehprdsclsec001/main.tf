module "eh-prd-scl-sec-001" {
  source                        = "../../../az-iac-back/mod_event_hub"
  namespace_name                = "eh-ns-prd-scl-sec-001"
  location                      = data.azurerm_resource_group.rg-prd-scl-sec-audit-001.location
  resource_group_name           = data.azurerm_resource_group.rg-prd-scl-sec-audit-001.name
  sku                           = "Standard"
  capacity                      = 2
  auto_inflate_enabled          = true
  maximum_throughput_units      = 20
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  eventhub_name     = "eh-prd-scl-sec-001"
  partition_count   = 4
  message_retention = 7
  status            = "Active"

  tags = {}

  network_rulesets = {
    default_action                 = "Deny"
    public_network_access_enabled  = false
    trusted_service_access_enabled = true
  }
}

module "pe-eh-prd-scl-sec-001" {
  depends_on                    = [module.eh-prd-scl-sec-001]
  source                        = "../../../az-iac-back/mod_private_endpoint"
  name                          = "pe-prd-scl-sec-eh-001"
  location                      = data.azurerm_resource_group.rg-prd-scl-sec-audit-001.location
  resource_group_name           = data.azurerm_resource_group.rg-prd-scl-sec-audit-001.name
  subnet_id                     = data.azurerm_subnet.snet-secprd-cstools-001.id
  custom_network_interface_name = "pe-prd-scl-sec-eh-001-nic"

  psc = {
    name                           = "psc-prd-scl-sec-eh-001"
    private_connection_resource_id = module.eh-prd-scl-sec-001.eventhub_namespace_id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  pvt_dnsz_grp = {
    name                 = "pdnszonegrp-prd-scl-sec-eh-001"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
  }
}