resource "azurerm_network_interface" "lsclppazcmecqradar01_nic_01" {
  name                           = "lsclppazcmecqradar01-nic-01"
  location                       = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name            = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  accelerated_networking_enabled = true
  tags                           = {}

  ip_configuration {
    name                          = "lsclppazcmecqradar01-ipcfg-01"
    subnet_id                     = data.azurerm_subnet.snet-secpp-cstools-001.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.8.12"
  }
}

module "lsclppazcmecqradar01" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine?ref=master"
  name                = "lsclppazcmecqradar01"
  location            = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  size                = "Standard_F16s"
  computer_name       = "lsclppazcmecqradar01"
  network_interface_ids = [
    azurerm_network_interface.lsclppazcmecqradar01_nic_01.id
  ]


  admin_username                  = "bchuser"
  admin_password                  = "BCH_P@ssw0rd!"
  disable_password_authentication = false
  tags                            = {}
  zone                            = "1"

  os_disk_name                 = "lsclppazcmecqradar01-osdisk"
  os_disk_caching              = "ReadWrite"
  os_disk_storage_account_type = "Premium_LRS"

  source_image_reference_publisher = "ibm"
  source_image_reference_offer     = "qradar750"
  source_image_reference_sku       = "qradar750up9"
  source_image_reference_version   = "latest"

  plan_name      = "qradar750up9"
  plan_publisher = "ibm"
  plan_product   = "qradar750"

  storage_account_uri = null
}

# Disco adicional
resource "azurerm_managed_disk" "lsclppazcmecqradar01-datadisk" {
  name                 = "lsclppazcmecqradar01-datadisk"
  location             = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name  = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
  tags                 = {}
  zone                 = "1"
}

# Asociar el disco adicional a la VM
resource "azurerm_virtual_machine_data_disk_attachment" "lsclppazcmecqradar01-datadisk_attach" {
  managed_disk_id    = azurerm_managed_disk.lsclppazcmecqradar01-datadisk.id
  virtual_machine_id = module.lsclppazcmecqradar01.id
  lun                = 0
  caching            = "ReadWrite"
}
resource "azurerm_managed_disk" "lsclppazcmecqradar02-datadisk" {
  name                 = "lsclppazcmecqradar02-datadisk"
  location             = data.azurerm_resource_group.rg-pp-scl-sec-001.location
  resource_group_name  = data.azurerm_resource_group.rg-pp-scl-sec-001.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
  tags                 = {}
  zone                 = "1"
}

# Asociar el disco adicional a la VM
resource "azurerm_virtual_machine_data_disk_attachment" "lsclppazcmecqradar02-datadisk_attach" {
  managed_disk_id    = azurerm_managed_disk.lsclppazcmecqradar02-datadisk.id
  virtual_machine_id = module.lsclppazcmecqradar01.id
  lun                = 1
  caching            = "ReadWrite"
}
