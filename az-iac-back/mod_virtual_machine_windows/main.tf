resource "azurerm_windows_virtual_machine" "wvm" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = var.network_interface_ids #list
  size                = var.size
  proximity_placement_group_id = var.proximity_placement_group_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  patch_mode = (var.source_image_reference_sku == "2025-datacenter-azure-edition" || var.source_image_reference_sku == "2022-datacenter-azure-edition-hotpatch") ? "AutomaticByPlatform" : null
  hotpatching_enabled = false

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

   source_image_reference {
        publisher = var.source_image_reference_publisher
        offer     = var.source_image_reference_offer
        sku       = var.source_image_reference_sku
        version   = var.source_image_reference_version
    }

    tags = var.tags    
}