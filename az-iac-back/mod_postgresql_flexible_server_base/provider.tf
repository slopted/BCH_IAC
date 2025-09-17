provider "azurerm" {
  features {
  }
  use_cli                         = true
  use_oidc                        = false
  resource_provider_registrations = "none"
  subscription_id                 = "25002e42-ecf0-4876-afca-ad568fc370df"
  environment                     = "public"
  use_msi                         = false
}
