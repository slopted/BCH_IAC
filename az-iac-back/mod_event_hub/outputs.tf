# Outputs
output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.eh_nmspace.id
}

output "eventhub_id" {
  value = azurerm_eventhub.eh.id
}