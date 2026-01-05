resource "azurerm_lb" "lb" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "${var.name}-fe-ip-config"
    public_ip_address_id = var.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_be_ap" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.lb_be_ap_name
}
/*
resource "azurerm_lb_backend_address_pool_address" "example" {
  name                    = "example"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.example.id
  virtual_network_id      = data.azurerm_virtual_network.example.id
  ip_address              = "10.0.0.1"
}
*/

resource "azurerm_lb_backend_address_pool_address" "lb_be_ap_address-1" {
  name                                = "address1"
  backend_address_pool_id             = data.azurerm_lb_backend_address_pool.backend-pool-cr.id
  backend_address_ip_configuration_id = azurerm_lb.backend-lb-R1.frontend_ip_configuration[0].id
}

resource "azurerm_lb_backend_address_pool_address" "lb_be_ap_address-2" {
  name                                = "address2"
  backend_address_pool_id             = data.azurerm_lb_backend_address_pool.backend-pool-cr.id
  backend_address_ip_configuration_id = azurerm_lb.backend-lb-R2.frontend_ip_configuration[0].id
}


resource "azurerm_lb_outbound_rule" "lb_out_rule" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}


resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "ssh-running-probe"
  port            = 22
}


resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}