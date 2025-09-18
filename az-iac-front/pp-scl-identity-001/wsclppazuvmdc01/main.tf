module "wsclppazuvmdc01" {
  source              = "git::https://github.com/slopted/BCH_IAC//az-iac-back/mod_virtual_machine_windows?ref=main"
  name                = "wsclppazuvmdc01"
  location            = data.azurerm_resource_group.rg-pp-scl-dc-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-dc-001.name
  ip_configuration = {
    subnet_id                     = data.azurerm_subnet.snet-dcpp-addc-001.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.9.4"
  }
  size                = "Standard_D8s_v3"
  admin_username      = "bchuser"
  admin_password      = "BCH_P@ssw0rd!"
  patch_mode          = "AutomaticByPlatform"
  hotpatching_enabled = true
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