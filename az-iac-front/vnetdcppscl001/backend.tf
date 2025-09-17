/*
State Naming Convention Documentation

This file defines the naming convention for Terraform state files used in this project.

Naming Pattern:
  <csp>.<IAC_Language>.<environment>.<Project|Bussiness>.<Resource_Abbreviation>.<resource_group_name>.<state>

Where:
  - <csp>: Cloud Service Provider (e.g., Azure, AWS, GCP)
  - <IAC_Language>: Infrastructure as Code language (e.g., Terraform)
  - <environment>: Deployment environment (e.g., Test, QA, Prod)
  - <Project|Bussiness>: Name of the project or business unit (e.g., fani, lsc, murex)
  - <Resource_Abbreviation>: Resource Abbreviation (e.g., rg, vnet, vm)
  - <Resource_Name>: Name of the resource.
  - <state>: State file extension.

Variables:
  - <csp>
  - <environment>
  - <Project|Bussiness>
  - <Resource_Abbreviation>
  - <Resource_Name>
  - <resource_group_name>

Constants:
  - <IAC_Language>
  - <state>
*/

terraform {
  backend "azurerm" {
    subscription_id      = "fb591a13-981e-4a6f-a106-de39db876fdc"
    resource_group_name  = "rg-pp-scl-tfstate-001"
    storage_account_name = "stppscltfstate001"
    container_name       = "tfstates"
    key                  = "azure.terraform.pp.ldz.vnet.vnet-dcpp-scl-001.state"
  }
}