# outputs.tf — versión que sí valida

output "vm-sdwan-id" {
  value = azurerm_linux_virtual_machine.vm-sdwan.id
}

# identity es una LISTA; usa [0]. try() evita reventar si no hay identidad configurada.
output "vm-sdwan-principal_id" {
  value = try(azurerm_linux_virtual_machine.vm-sdwan.identity[0].principal_id, null)
}

# os_disk también es LISTA y no expone 'id'. Devolvemos el NOMBRE del disco del SO.
# Si de verdad quieres el ID, hay que resolverlo con un data source (otro archivo), cosa que NO quieres.
output "vm-sdwan-os_disk" {
  value = azurerm_linux_virtual_machine.vm-sdwan.os_disk[0].name
}

# Esta salida estaba bien.
output "vm-sdwan-private_ip_addresses" {
  value = azurerm_linux_virtual_machine.vm-sdwan.private_ip_addresses
}
