output "id" {
  value = azurerm_linux_function_app.lfa.id
}
output "principal_id" {
  value = var.identity_name  != null ? azurerm_user_assigned_identity.lf_identity[0].principal_id:azurerm_linux_function_app.lfa.identity[0].principal_id
 }