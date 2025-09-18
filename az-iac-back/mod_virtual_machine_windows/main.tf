# ============================================================
# Virtual Machine Network Interface
# ============================================================
resource "azurerm_network_interface" "wvm-nic-01" {
  name                = "${var.name}-nic-01"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.name}-ipconfig-01"
    subnet_id                     = var.ip_configuration.subnet_id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    private_ip_address            = var.ip_configuration.private_ip_address_allocation == "Static" ? var.ip_configuration.private_ip_address : null
    primary                       = true
  }
}
# ============================================================
# Virtual Machine Windows
# ============================================================
resource "azurerm_windows_virtual_machine" "wvm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [resource.azurerm_network_interface.wvm-nic-01.id]
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  patch_mode = contains([
    "2022-datacenter-azure-edition-core",
    "2022-datacenter-azure-edition-core-smalldisk",
    "2022-datacenter-azure-edition-hotpatch",
    "2022-datacenter-azure-edition-hotpatch-smalldisk"
  ], lower(var.source_image_reference.sku)) ? "AutomaticByPlatform" : var.patch_mode

  hotpatching_enabled = contains([
    "2022-datacenter-azure-edition-core",
    "2022-datacenter-azure-edition-core-smalldisk",
    "2022-datacenter-azure-edition-hotpatch",
    "2022-datacenter-azure-edition-hotpatch-smalldisk"
  ], lower(var.source_image_reference.sku)) ? true : var.hotpatching_enabled

  os_disk {
    name                 = "${var.name}-osdisk-01"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  tags = var.tags
}