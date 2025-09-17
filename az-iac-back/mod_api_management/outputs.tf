output "id" {
  value = azurerm_api_management.am.id
}
output "name" {
  value = azurerm_api_management.am.name
}
output "resource_group_name" {
  value = azurerm_api_management.am.resource_group_name
}
output "location" {
  value = azurerm_api_management.am.location
}
output "publisher_email" {
  value = azurerm_api_management.am.publisher_email
}
output "publisher_name" {
  value = azurerm_api_management.am.publisher_name
}
output "sku_name" {
  value = azurerm_api_management.am.sku_name
}
output "identity" {
  value = azurerm_api_management.am.identity
}
output "public_ip_address_id" {
  value = azurerm_api_management.am.public_ip_address_id
}
output "virtual_network_type" {
  value = azurerm_api_management.am.virtual_network_type
}
output "gateway_url" {
  value = azurerm_api_management.am.gateway_url
}
output "principal_id" {
  value = azurerm_api_management.am.identity.0.principal_id
}
output "public_ip_addresses" {
  value = azurerm_api_management.am.public_ip_addresses
}
output "private_ip_addresses" {
  value = azurerm_api_management.am.private_ip_addresses
}

