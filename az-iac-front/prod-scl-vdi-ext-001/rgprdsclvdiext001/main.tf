module "rg-prd-scl-vdi-ext-001" {
  source   = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_resource_group?ref=main"
  name     = "rg-prd-scl-vdi-ext-001"
  location = "chilecentral"
}