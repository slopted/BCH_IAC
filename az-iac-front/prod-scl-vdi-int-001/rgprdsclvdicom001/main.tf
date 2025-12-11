module "rg-prd-scl-vdi-com-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  source   = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_resource_group?ref=main"
  name     = "rg-prd-scl-vdi-com-001"
  location = "chilecentral"
}