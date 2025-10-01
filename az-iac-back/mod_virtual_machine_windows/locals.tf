locals {
  network_interface_ids = flatten([resource.azurerm_network_interface.wvm-nic-01.id, var.network_interface_ids])
}