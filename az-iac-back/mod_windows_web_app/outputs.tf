output "id" {
  value = azurerm_windows_web_app.wwa.id
}

output "principal_id" {
#  value = azurerm_user_assigned_identity.wwa_identity.principal_id 
  value = var.identity_type=="UserAssigned"?azurerm_user_assigned_identity.wwa_identity[0].principal_id:azurerm_windows_web_app.wwa.identity[0].principal_id
 }