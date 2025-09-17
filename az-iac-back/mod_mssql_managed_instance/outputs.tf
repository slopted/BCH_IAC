output "mssql_instance_id" {
  description = "ID de la instancia administrada de SQL"
  value       = azurerm_mssql_managed_instance.example_mssql_instance.id
}