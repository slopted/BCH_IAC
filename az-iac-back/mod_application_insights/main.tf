provider "azurerm" {
  features {}
}

resource "azurerm_application_insights" "app_insight" {
  name                        = var.app_insight_name
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  application_type            = var.application_type #"web"

  tags = var.tags
}