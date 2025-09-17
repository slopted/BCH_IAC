output "postgresql_server_id" {
  description = "ID del servidor PostgreSQL Flexible"
  value       = azurerm_postgresql_flexible_server.this.id
}

output "postgresql_server_fqdn" {
  description = "FQDN del servidor PostgreSQL Flexible"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "private_endpoint_id" {
  description = "ID del Private Endpoint (si fue creado)"
  value       = length(azurerm_private_endpoint.this) > 0 ? azurerm_private_endpoint.this[0].id : null
}
