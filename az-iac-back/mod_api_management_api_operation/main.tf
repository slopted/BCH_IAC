resource "azurerm_api_management_api_operation" "amao" {
  operation_id        = var.name
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template
  description         = var.description

  template_parameter {
    name     = lookup(var.template_parameters, "name", null)
    type     = lookup(var.template_parameters, "type", null)
    required = lookup(var.template_parameters, "required", null)
    values   = lookup(var.template_parameters, "values", null)
  }

  response {
    status_code = 200
  }
}
