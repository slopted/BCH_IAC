provider "azurerm" {
  features {}
}
resource "azurerm_cognitive_deployment" "deployment" {
  name                 = var.cognitive_deployment_name
  cognitive_account_id = var.cognitive_account_id
  model {
    format  = var.model_format #"OpenAI"
    name    = var.model_name
    version = var.model_version
  }

  scale {
    type = var.scale_type
    tier = var.scale_tier 
    size = var.scale_size
    family = var.scale_family
    capacity = var.scale_capacity

  }
}
