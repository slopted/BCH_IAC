output "vm-nic-id" {
  value = azurerm_network_interface.vm-nic[0].id
}

output "id" {
  value = azurerm_linux_virtual_machine.vm.id
}
