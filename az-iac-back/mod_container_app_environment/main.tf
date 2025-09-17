resource "azurerm_container_app_environment" "this" {
  name                           = "${var.name}-environment"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = var.internal_load_balancer_enabled
  tags                           = var.tags
    workload_profile {
    name                  = lookup(var.workload_profile, "name", null)
    workload_profile_type = lookup(var.workload_profile, "workload_profile_type", null)
    minimum_count         = lookup(var.workload_profile, "minimum_count", 1)
    maximum_count         = lookup(var.workload_profile, "maximum_count", 4)
  }

}
