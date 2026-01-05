module "law-prd-scl-001" {
  source              = "../../../az-iac-back/mod_log_analytics_workspace"
  name                = "law-prd-scl-001"
  location            = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-law-001.name
  sku                 = "PerGB2018"
  retention_in_days   = "30"
  tags                = {}
}