#### CYBERARK / PREPROD - Windows Server 2022 ####

# NSG vía módulo back + reglas
module "nsg_secpp_cyberark_001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_group?ref=master"
  name                = "nsg-secpp-cyberark-001"
  location            = data.azurerm_resource_group.rg_sec.location
  resource_group_name = data.azurerm_resource_group.rg_sec.name
  tags                = {}
  security_rule       = []
}

module "nsg_cyberark_rules" {
  source                      = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_rule?ref=master"
  resource_group_name         = data.azurerm_resource_group.rg_sec.name
  network_security_group_name = module.nsg_secpp_cyberark_001.name

  rules = {
    out-dns-53 = {
      priority                   = 1000
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "53"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    out-ntp-123 = {
      priority                   = 1010
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "123"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    out-https-443 = {
      priority                   = 1020
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

########################################
# NIC nativa con IP estática y AN
########################################
resource "azurerm_network_interface" "wsclppazupcc01_nic_01" {
  name                           = "wsclppazupcc01-nic-01"
  location                       = data.azurerm_resource_group.rg_sec.location
  resource_group_name            = data.azurerm_resource_group.rg_sec.name
  accelerated_networking_enabled = true
  tags                           = {}

  ip_configuration {
    name                          = "wsclppazupcc01-ipcfg-01"
    subnet_id                     = data.azurerm_subnet.cstools.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.8.11"
    primary                       = true
  }
}

# Asociación NSG <-> NIC
resource "azurerm_network_interface_security_group_association" "cyberark_nic_nsg" {
  network_interface_id      = azurerm_network_interface.wsclppazupcc01_nic_01.id
  network_security_group_id = module.nsg_secpp_cyberark_001.id
  depends_on                = [module.nsg_cyberark_rules]
}

########################################
# Data disk 512 GB (mismo RG 'rg-pp-scl-sec-001')
########################################
resource "azurerm_managed_disk" "wsclprazudiskpcc01" {
  name                 = "wsclprazudiskpcc01"
  location             = data.azurerm_resource_group.rg_sec.location
  resource_group_name  = data.azurerm_resource_group.rg_sec.name
  storage_account_type = "StandardSSD_LRS"  # LRS de SSD estándar
  create_option        = "Empty"
  disk_size_gb         = 512
  tags                 = {}
}

########################################
# VM Windows (módulo back REMOTO) — inputs soportados por tu back
########################################
module "wsclppazupcc01" {
  source = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine_windows?ref=master"

  name                         = "wsclppazupcc01"
  #computer_name                = "wsclppazupcc01"
  location                     = data.azurerm_resource_group.rg_sec.location
  resource_group_name          = data.azurerm_resource_group.rg_sec.name
  network_interface_ids        = [azurerm_network_interface.wsclppazupcc01_nic_01.id]
  size                         = "Standard_D4s_v3"
  proximity_placement_group_id = null
  admin_username               = "bchuser"
  admin_password               = "BCH_P@ssw0rd!"
  tags                         = {}

  os_disk_caching              = "ReadWrite"
  os_disk_storage_account_type = "Premium_LRS"

  source_image_reference_publisher = "MicrosoftWindowsServer"
  source_image_reference_offer     = "WindowsServer"
  source_image_reference_sku       = "2022-datacenter"
  source_image_reference_version   = "latest"

  #storage_account_uri = null

  depends_on = [azurerm_network_interface_security_group_association.cyberark_nic_nsg]
}

# Attach del data disk (LUN 0) a la VM
resource "azurerm_virtual_machine_data_disk_attachment" "wsclppazupcc01_data_attach" {
  managed_disk_id    = azurerm_managed_disk.wsclprazudiskpcc01.id
  virtual_machine_id = coalesce(
    try(module.wsclppazupcc01.vm_id, null),
    try(module.wsclppazupcc01.id, null)
  )
  lun                = 0
  caching            = "ReadOnly"
  depends_on         = [module.wsclppazupcc01]
}
