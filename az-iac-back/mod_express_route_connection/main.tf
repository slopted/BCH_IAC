# ============================================================
# Express Route Connection
# ============================================================
resource "azurerm_express_route_connection" "erconn" {
  name                             = var.name
  express_route_gateway_id         = var.express_route_gateway_id
  express_route_circuit_peering_id = var.express_route_circuit_peering_id
  authorization_key                = var.authorization_key
}