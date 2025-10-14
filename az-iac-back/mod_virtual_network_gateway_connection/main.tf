# ============================================================
# Virtual Network Gateway Connection
# ============================================================
resource "azurerm_virtual_network_gateway_connection" "vngc" {
  name                           = var.name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  type                           = var.type
  virtual_network_gateway_id     = var.virtual_network_gateway_id
  express_route_circuit_id       = var.express_route_circuit_id
  routing_weight                 = var.routing_weight
  authorization_key              = var.authorization_key
  enable_bgp                     = var.enable_bgp
  local_azure_ip_address_enabled = var.local_azure_ip_address_enabled
  connection_mode                = var.connection_mode
}