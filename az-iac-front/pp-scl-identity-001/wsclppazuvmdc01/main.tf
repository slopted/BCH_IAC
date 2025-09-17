module "nsg-nic-wsclppazuvmdc01" {
  source              = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_network_security_group?ref=main"
  name                = "nsg-nic-wsclppazuvmdc01"
  location            = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
}

module "nic-wsclppazuvmdc01" {
  depends_on                      = [module.nsg-nic-wsclppazuvmdc01]
  source                         = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_network_interface?ref=main"
  name                           = "nic-wsclppazuvmdc01"
  location                       = "chilecentral"
  resource_group_name            = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  ip_configuration_name          = "ipconfig-wsclppazuvmdc01"
  ip_configuration_subnet_id     = data.azurerm_subnet.snet-dcpp-addc-001.id
  private_ip_address_allocation  = "Dynamic"
  network_security_group_id      = module.nsg-nic-wsclppazuvmdc01.id
}

module "wsclppazuvmdc01" {
  depends_on                         = [module.nic-wsclppazuvmdc01]
  source                             = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_machine_windows?ref=main"
  name                               = "wsclppazuvmdc01"
  location                           = "chilecentral"
  resource_group_name                = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  network_interface_ids              = [module.nic-wsclppazuvmdc01.id]
  size                               = "Standard_D8s_v3"
  proximity_placement_group_id       = null
  admin_username                     = "bchuser"
  admin_password                     = "BCH_P@ssw0rd!"
  os_disk_caching                    = "ReadWrite"
  os_disk_storage_account_type       = "Premium_LRS"
  source_image_reference_publisher   = "MicrosoftWindowsServer"
  source_image_reference_offer       = "WindowsServer"
  source_image_reference_sku         = "2025-datacenter-azure-edition"
  source_image_reference_version     = "latest"
  tags                               = {}
}