resource "azurerm_api_management_policy" "amp" {
  api_management_id = var.api_management_id
  xml_content       = file(var.path_to_policy_file)
}
