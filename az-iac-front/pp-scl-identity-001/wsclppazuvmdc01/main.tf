module "wsclppazuvmdc01" {
  depends_on = [ module.wsclppazuvmdc01_nic2 ]
  source              = "../../../az-iac-back/mod_virtual_machine_windows"
# source              = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_machine_windows?ref=main"
  name                = "wsclppazuvmdc01"
  location            = data.azurerm_resource_group.rg-pp-scl-dc-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  ip_configuration = {
    subnet_id                     = data.azurerm_subnet.snet-dcpp-addc-001.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.9.4"
  }
  network_interface_ids = [module.wsclppazuvmdc01_nic2.id]
  size                = "Standard_D8s_v3"
  admin_username      = "bchuser"
  admin_password      = "BCH_P@ssw0rd!"
  patch_mode          = "AutomaticByPlatform"
  hotpatching_enabled = false
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 128
  }
  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
  tags = {}
}

module "wsclppazuvmdc01_nic2" {
  source              = "../../../az-iac-back/mod_network_interface"
  name                = "wsclppazuvmdc01-nic2"
  location            = data.azurerm_resource_group.rg-pp-scl-dc-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  enable_accelerated_networking = false
  ip_configuration_name        = "wsclppazuvmdc01-ipconfig-02"
  ip_configuration_subnet_id   = data.azurerm_subnet.snet-dcpp-addc-001.id
  private_ip_address_allocation = "Dynamic"
  network_security_group_id    = module.wsclppazuvmdc01_nsg2.id
  tags = {}
}

module "wsclppazuvmdc01_nsg2" {
    source              = "../../../az-iac-back/mod_network_security_group"
    name                = "wsclppazuvmdc01-nsg2"
  location            = data.azurerm_resource_group.rg-pp-scl-dc-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
    tags = {}
}