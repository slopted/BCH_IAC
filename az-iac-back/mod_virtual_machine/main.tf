resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.size
  computer_name                   = var.computer_name
  network_interface_ids           = var.network_interface_ids
  proximity_placement_group_id    = var.proximity_placement_group_id

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication

  tags = var.tags
  zone = var.zone

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  plan {
    publisher = var.plan_publisher
    product   = var.plan_product
    name      = var.plan_name
  }

  dynamic "identity" {
    for_each = var.identity_enabled ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

# ==============================
# Disco de datos opcional
# ==============================
resource "azurerm_managed_disk" "data_disk" {
  count                = var.data_disk_enabled ? 1 : 0
  name                 = "${var.name}-datadisk1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
  zone                 = var.zone
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
  count              = var.data_disk_enabled ? 1 : 0
  managed_disk_id    = azurerm_managed_disk.data_disk[0].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = 0
  caching            = "None"
}
