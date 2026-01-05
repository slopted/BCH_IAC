resource "azurerm_policy_definition" "policy_def" {
  name                = var.name
  policy_type         = var.policy_type
  mode                = var.mode
  display_name        = var.display_name
  description         = var.description
  management_group_id = var.management_group_id
  policy_rule         = var.policy_rule
  metadata            = var.metadata
  parameters          = var.parameters
}

resource "azurerm_management_group_policy_assignment" "policy_mg_assign" {
  count                = var.scope == "mg" ? 1 : 0
  name                 = var.mg.name
  policy_definition_id = resource.azurerm_policy_definition.policy_def.id
  management_group_id  = var.mg.management_group_id
  description = var.mg.description
  display_name = var.mg.display_name
  enforce = var.mg.enforce
  dynamic "identity" {
    for_each = var.mg.identity != null ? [var.mg.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  depends_on = [ resource.azurerm_policy_definition.policy_def ]
}