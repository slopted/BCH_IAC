output "id" {
  value = azurerm_linux_web_app.webapp.id
}

output "name" {
  value = azurerm_linux_web_app.webapp.name
}

output "default_domain" {
  value = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

output "principal_id" {
  value = azurerm_linux_web_app.webapp.identity[0].principal_id
}
