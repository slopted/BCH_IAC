output "id" {
  value       = azurerm_container_app.capp.id
}
output "principal_id" {
  value = azurerm_container_app.capp.identity[0].principal_id
}