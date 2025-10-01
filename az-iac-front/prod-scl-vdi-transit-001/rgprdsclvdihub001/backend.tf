terraform {
  backend "azurerm" {
    subscription_id      = "67e8f9c1-a3d9-405e-b72d-43e7c16a46d3"
    resource_group_name  = "AR-TFstate"
    storage_account_name = "sttf1727848146"
    container_name       = "slopted-tfstate"
    key                  = "azure.terraform.prod.ldz.rg.rg-prd-scl-vdi-hub-001.state"
  }
}