
terraform {
  backend "azurerm" {
    subscription_id      = "d5f98e34-ac10-4a1e-b68f-d67b8f38f87b"
    resource_group_name  = "rg-prod-scl-tfstate-001"
    storage_account_name = "stprodscltfstate001"
    container_name       = "tfstates"
    key                  = "azure.terraform.prod.ldz.vm.lsclprdazvmsdwan002.state"
  }
}