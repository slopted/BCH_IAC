module "policy" {
    source = "../../az-iac-back/mod_policy"
    name                = "PolicyDefinitionName"
    policy_type         = "Custom"
    mode                = "Indexed"
    display_name        = "Tags Policy"
    description         = "Policy to enforce tagging standards"
    management_group_id = "00000000-0000-0000-0000-000000000000"
    scope = "mg"
    metadata = jsonencode({
      category = "Tags"
      version  = "1.0.0"
    })
    policy_rule = jsonencode({
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Resources/subscriptions/resourceGroups"
          },
          {
            "anyOf": [
              {
                "field": "tags['environment']",
                "exists": "false"
              },
              {
                "not": {
                  "field": "tags['environment']",
                  "in": [
                    "dev",
                    "qa",
                    "prod"
                  ]
                }
              }
            ]
          }
        ]
      },
      "then": {
        "effect": "audit"
      }
    })
    parameters          = jsonencode(
    {
        "environment": {
            "type": "String",
            "allowedValues": [
                "dev",
                "qa",
                "prod"
            ],
            "metadata": {
                "description": "The environment tag must be one of: dev, qa, prod.",
                "displayName": "Environment"
            }
        }
    })
    mg = {
        name                 = "TagPolicyAssignmentMG"
        management_group_id  = data.azurerm_management_group.mg_id.id
        description          = "Management group for enforcing tag policy"
        display_name         = try(var.mg_display_name, "Default Management Group Display Name")
        enforce              = true
        identity             = data.azurerm_user_assigned_identity.mg_policy_identity != null ? {
            type         = "UserAssigned"
            identity_ids = [data.azurerm_user_assigned_identity.mg_policy_identity.id]
        } : null
    }
}