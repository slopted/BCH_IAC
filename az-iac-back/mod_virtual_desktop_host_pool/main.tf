resource "azurerm_virtual_desktop_host_pool" "vdhp" {
  name                             = var.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  type                             = var.type
  load_balancer_type               = var.load_balancer_type
  friendly_name                    = var.friendly_name
  description                      = var.description
  validate_environment             = var.validate_environment
  start_vm_on_connect              = var.start_vm_on_connect
  custom_rdp_properties            = var.custom_rdp_properties
  personal_desktop_assignment_type = var.personal_desktop_assignment_type
  public_network_access            = var.public_network_access
  maximum_sessions_allowed         = var.maximum_sessions_allowed
  preferred_app_group_type         = var.preferred_app_group_type
  vm_template                      = var.vm_template
  tags                             = var.tags
  dynamic "scheduled_agent_updates" {
    for_each = var.scheduled_agent_updates.enabled ? [1] : []
    content {
      enabled                   = var.scheduled_agent_updates.enabled
      timezone                  = var.scheduled_agent_updates.timezone
      use_session_host_timezone = var.scheduled_agent_updates.use_session_host_timezone

      schedule {
        day_of_week = var.scheduled_agent_updates.schedule.day_of_week
        hour_of_day = var.scheduled_agent_updates.schedule.hour_of_day
      }
    }
  }
}