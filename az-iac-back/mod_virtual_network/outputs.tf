output "id" {
  value = azurerm_virtual_network.vnet.id
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "guid" {
  value = azurerm_virtual_network.vnet.guid
}

output "subnet" {
  value = azurerm_virtual_network.vnet.subnet
}
