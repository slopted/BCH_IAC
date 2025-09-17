resource "azurerm_network_security_rule" "nsgr" {
  for_each = var.rules

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name

  name      = each.key
  priority  = each.value.priority
  direction = each.value.direction
  access    = each.value.access
  protocol  = each.value.protocol

  source_port_range      = each.value.source_port_range
  destination_port_range = lookup(each.value, "destination_port_range", null)
  destination_port_ranges = lookup(each.value, "destination_port_ranges", null)

  # Manejo flexible de prefix/prefixes
  source_address_prefix        = lookup(each.value, "source_address_prefix", null)
  source_address_prefixes      = lookup(each.value, "source_address_prefixes", null)
  destination_address_prefix   = lookup(each.value, "destination_address_prefix", null)
  destination_address_prefixes = lookup(each.value, "destination_address_prefixes", null)
}
