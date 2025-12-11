module "hp-prd-eu1-vdi-com-001" {
  #source   = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_resource_group?ref=master"
  source                           = "../../../az-iac-back/mod_virtual_desktop_host_pool"
  name                             = "hp-prd-eu1-vdi-com-001"
  resource_group_name              = data.azurerm_resource_group.rg-prd-scl-vdi-com-001.name
  location                         = "eastus"
  type                             = "Pooled"
  load_balancer_type               = "BreadthFirst"
  friendly_name                    = "Escritorio Virtual Comercial"
  description                      = "Escritorio Virtual Comercial"
  validate_environment             = false
  start_vm_on_connect              = false
  custom_rdp_properties            = ""
  personal_desktop_assignment_type = "Automatic"
  public_network_access            = "Enabled"
  maximum_sessions_allowed         = 16
  preferred_app_group_type         = "Desktop"
  vm_template                      = ""
  tags                             = {}
}