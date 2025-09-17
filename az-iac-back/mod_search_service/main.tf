resource "random_integer" "this" {
  max = 999999
  min = 100000
}

locals {
  search_service_name = coalesce(var.name, "azurerm-search-service-${random_integer.this.result}")
}

resource "azurerm_search_service" "this" {
  name                = local.search_service_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  replica_count       = var.replica_count
  partition_count     = var.partition_count

  local_authentication_enabled = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

locals {
  wait_for_conflict_resolution = [for _ in range(10) : null]
}

resource "null_resource" "wait_for_conflict_resolution" {
  triggers = {
    for idx, _ in local.wait_for_conflict_resolution : tostring(idx) => null
  }

  provisioner "local-exec" {
    command = "sleep 30s"
  }

  depends_on = [
    azurerm_search_service.this
  ]
}
