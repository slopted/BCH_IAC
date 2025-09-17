output "id" {
  description = "The CosmosDB Account ID."
  value       = azurerm_cosmosdb_account.cosmon.id
}
output "name" {
  description = "The CosmosDB Account Name."
  value       = azurerm_cosmosdb_account.cosmon.name
}
output "endpoint" {
  description = "The CosmosDB Account Endpoint."
  value       = azurerm_cosmosdb_account.cosmon.endpoint
}
output "read_endpoints" {
  description = "A list of read endpoints available for cosmon CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmon.read_endpoints
}
output "write_endpoints" {
  description = "A list of write endpoints available for cosmon CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmon.write_endpoints
}
output "primary_key" {
  sensitive   = true
  description = "The Primary key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmon.primary_key
}
output "secondary_key" {
  sensitive   = true
  description = "The Secondary key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmon.secondary_key
}
output "primary_readonly_key" {
  sensitive   = true
  description = "The primary_readonly_key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmon.primary_readonly_key
}
output "secondary_readonly_key" {
  sensitive   = true
  description = "The secondary_readonly_key for the CosmosDB Account."
  value       = azurerm_cosmosdb_account.cosmon.secondary_readonly_key
}
output "connection_strings" {
  sensitive = true
  description = "A connection string available for cosmon CosmosDB account."
  value       = azurerm_cosmosdb_account.cosmon.connection_strings
}
#output "cosmosdb_list_connectionstring_url" {
#  description = "The URL to get the connection string despite on System-assigned managed identity"
#  value       = "https://management.azure.com/subscriptions/${data.azurerm_subscription.primary.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${azurerm_cosmosdb_account.cosmon.name}/listConnectionStrings?api-version=2021-04-15"
#}
