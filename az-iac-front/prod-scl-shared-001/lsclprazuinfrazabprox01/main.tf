module "lsclprazuinfrazabprox01" {
  source = "../../../az-iac-back/mod_virtual_machine"
  #  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine?ref=master"
  name                             = "lsclprazuinfrazabprox01"
  location                         = data.azurerm_resource_group.rg-prd-scl-shared-001.location
  resource_group_name              = data.azurerm_resource_group.rg-prd-scl-shared-001.name
  accept_marketplace_agreement     = true
  size                             = "Standard_D2s_v5"
  computer_name                    = "lsclprazuinfrazabprox01"
  admin_username                   = "bchuser"
  admin_password                   = "BCH_P@ssw0rd!"
  disable_password_authentication  = false
  tags                             = {}
  zone                             = "1"
  os_disk_name                     = "lsclprazuinfrazabprox01-osdisk"
  os_disk_caching                  = "ReadWrite"
  os_disk_storage_account_type     = "Premium_LRS"
  os_disk_disk_size_gb             = 128
  source_image_reference_publisher = "Oracle"
  source_image_reference_offer     = "Oracle-Linux"
  source_image_reference_sku       = "ol95-lvm-gen2"
  source_image_reference_version   = "latest"
  storage_account_uri              = null
  create_vm_nic                    = true
  vm-nic = {
    network_interface_name        = "lsclprazuinfrazabprox01-nic-01"
    ip_configuration_subnet_id    = data.azurerm_subnet.snet-sharedprd-serv-001.id
    ip_configuration_name         = "lsclprazuinfrazabprox01-ipcfg-01"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.133.11.11"
  }
}