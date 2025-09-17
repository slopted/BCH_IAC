# ============================================================
# Public IP para la NIC Untrust
# ============================================================
resource "azurerm_public_ip" "sdwan-untrust-pip-01" {
  name                = "${var.name}-sdwan-untrust-pip-01"
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [var.zone]
}

# ============================================================
# SD-WAN Virtual Machine Network Interfaces
# ============================================================
resource "azurerm_network_interface" "sdwan-untrust-nic-01" {
  name                = "${var.name}-sdwan-untrust-nic-01"
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name

  ip_configuration {
    name                          = "${var.name}-sdwan-untrust-ipconfig-01"
    subnet_id                     = data.azurerm_subnet.snet-hub-sdwan-untrust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address.sdwan-untrust-ip1
    public_ip_address_id          = azurerm_public_ip.sdwan-untrust-pip-01.id
    primary                       = true
  }
}

resource "azurerm_network_interface" "sdwan-trust-nic-01" {
  name                = "${var.name}-sdwan-trust-nic-01"
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name

  ip_configuration {
    name                          = "${var.name}-sdwan-trust-ipconfig-01"
    subnet_id                     = data.azurerm_subnet.snet-hub-sdwan-trust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address.sdwan-trust-ip1
  }
}

resource "azurerm_network_interface" "sdwan-ha-nic-01" {
  name                = "${var.name}-sdwan-ha-nic-01"
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name

  ip_configuration {
    name                          = "${var.name}-sdwan-ha-ipconfig-01"
    subnet_id                     = data.azurerm_subnet.snet-hub-sdwan-ha.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address.sdwan-ha-ip1
  }
}

resource "azurerm_network_interface" "sdwan-mgmt-nic-01" {
  name                = "${var.name}-sdwan-mgmt-nic-01"
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name

  ip_configuration {
    name                          = "${var.name}-sdwan-mgmt-ipconfig-01"
    subnet_id                     = data.azurerm_subnet.snet-hub-sdwan-mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address.sdwan-mgmt-ip1
  }
}

# ============================================================
# Marketplace Agreement (autoacepta si no estaba)
# ============================================================
resource "azurerm_marketplace_agreement" "fortinet" {
  count     = var.accept ? 1 : 0
  publisher = var.source_image_reference.publisher
  offer     = var.source_image_reference.offer
  plan      = var.source_image_reference.sku
}

# ============================================================
# Data Disk (alineado con zona de la VM)
# ============================================================
resource "azurerm_managed_disk" "vm-sdwan-datadisk1" {
  name                 = "${var.name}-datadisk1"
  location             = data.azurerm_resource_group.rg-hub.location
  resource_group_name  = data.azurerm_resource_group.rg-hub.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
  zone                 = var.zone
}

# ============================================================
# VM Definition
# ============================================================
resource "azurerm_linux_virtual_machine" "vm-sdwan" {
  name                = var.name
  location            = data.azurerm_resource_group.rg-hub.location
  resource_group_name = data.azurerm_resource_group.rg-hub.name
  size                = var.size
  computer_name       = var.computer_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  tags                = var.tags
  zone                = var.zone

  network_interface_ids = [
    azurerm_network_interface.sdwan-untrust-nic-01.id, # PRIMARIA
    azurerm_network_interface.sdwan-trust-nic-01.id,
    azurerm_network_interface.sdwan-ha-nic-01.id,
    azurerm_network_interface.sdwan-mgmt-nic-01.id
  ]

  # Identidad administrada para integraciones (ej: Key Vault, Monitor, etc.)
  identity {
    type = "SystemAssigned"
  }

  # Imagen de Marketplace (Fortinet)
  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  # ⚠ Requerido por imágenes de Marketplace: debe alinear con la imagen
  plan {
    publisher = var.source_image_reference.publisher
    product   = var.source_image_reference.offer
    name      = var.source_image_reference.sku
  }

  os_disk {
    name                 = "${var.name}-OsDisk_1"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

depends_on = [
    azurerm_network_interface.sdwan-untrust-nic-01,
    azurerm_network_interface.sdwan-trust-nic-01,
    azurerm_network_interface.sdwan-ha-nic-01,
    azurerm_network_interface.sdwan-mgmt-nic-01,
    azurerm_managed_disk.vm-sdwan-datadisk1,
    azurerm_marketplace_agreement.fortinet
  ]
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm-sdwan-datadisk1-attachment" {
  managed_disk_id    = azurerm_managed_disk.vm-sdwan-datadisk1.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm-sdwan.id
  lun                = 0
  caching            = "None"
}