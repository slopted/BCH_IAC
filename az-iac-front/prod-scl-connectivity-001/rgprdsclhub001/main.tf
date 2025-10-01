module "rg-prd-scl-hub-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  source = "../../../az-iac-back/mod_resource_group"
  name     = "rg-prd-scl-hub-001"
  location = "chilecentral"
}