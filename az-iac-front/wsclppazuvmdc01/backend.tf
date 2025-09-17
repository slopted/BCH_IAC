terraform {
  backend "azurerm" {    
    subscription_id      = "fb591a13-981e-4a6f-a106-de39db876fdc"
    resource_group_name  = "rg-pp-scl-tfstate-001"
    storage_account_name = "stppscltfstate001"
    container_name       = "tfstates"
    key                  = "azure.terraform.prod.ldz.vm.wsclppazuvmdc01.state"
  }
}
