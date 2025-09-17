module "rg-pp-scl-dc-001" {
  source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  name     = "rg-pp-scl-dc-001"
  location = "chilecentral"
}