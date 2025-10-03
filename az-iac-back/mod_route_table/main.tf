# ============================================================
# Route Table
# ============================================================
resource "azurerm_route_table" "rtb" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = var.bgp_route_propagation_enabled
  route                         = var.route
  tags                          = var.tags
}

resource "azurerm_subnet_route_table_association" "subnet_assoc" {
  for_each       = var.subnet_id != [] ? { for idx, val in var.subnet_id : idx => val } : {}
  subnet_id      = each.value
  route_table_id = azurerm_route_table.rtb.id
}