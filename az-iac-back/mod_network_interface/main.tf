resource "azurerm_network_interface" "nic" {
    name                      = var.name
    location                  = var.location
    resource_group_name       = var.resource_group_name
	enable_accelerated_networking = var.enable_accelerated_networking
    ip_configuration {
        name                          = var.ip_configuration_name
        subnet_id                     = var.ip_configuration_subnet_id
        private_ip_address_allocation = var.private_ip_address_allocation
    }

    tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nicsga" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = var.network_security_group_id
}