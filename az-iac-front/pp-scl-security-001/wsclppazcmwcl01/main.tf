module "wsclppazcmwcl1" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine_windows?ref=master"
  name                = "wsclppazcmwcl1"
  location            = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  ip_configuration = {
    subnet_id                     = data.azurerm_subnet.snet-secpp-cstools-001.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.8.13"
  }
  size                = "Standard_F16s"
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
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  tags = {}
}
