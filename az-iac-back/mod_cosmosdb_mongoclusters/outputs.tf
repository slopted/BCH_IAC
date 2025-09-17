output "id" {
  description = "The CosmosDB Account ID."
  value       = azapi_resource.mongo_cluster_vcore.id
}

output "cosmosdb_name" {
  description = "The CosmosDB Account Name."
  value       = azapi_resource.mongo_cluster_vcore.name
}

output "cosmosdb_endpoint" {
  sensitive = true
  description = "The endpoint used to connect to the CosmosDB account."
  value       = "mongodb+srv://${var.admin_username}:${var.admin_password}@${var.name}-${random_integer.ri.result}.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000"
}