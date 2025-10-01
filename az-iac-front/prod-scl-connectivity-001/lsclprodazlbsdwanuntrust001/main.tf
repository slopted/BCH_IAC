########################################
# Public IP (módulo de back) – ChileCentral
########################################

module "pip_sdwan_untrust" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_public_ip?ref=master"

  name                = "pip-sdwan-elb-untrust-001"
  location            = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg.name

  allocation_method    = "Static"
  sku                  = "Standard"
  ddos_protection_mode = "Disabled"

  # Debe ser único en la región
  domain_name_label = "sdwan-elb-fadfw4524f12345"
  tags              = {}
}

########################################
# Load Balancer Público – ChileCentral
########################################

resource "azurerm_lb" "sdwan_external" {
  name                = "lb-scl-prod-sdwan-untrust-001"
  location            = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = {}

  frontend_ip_configuration {
    name                 = "lb-scl-prod-sdwan-untrust-001-FrontEnd"
    public_ip_address_id = module.pip_sdwan_untrust.id
  }
}

resource "azurerm_lb_backend_address_pool" "untrust_backend" {
  name            = "lb-scl-prod-sdwan-untrust-001-BackEnd"
  loadbalancer_id = azurerm_lb.sdwan_external.id
}

resource "azurerm_lb_probe" "untrust_probe" {
  loadbalancer_id     = azurerm_lb.sdwan_external.id
  name                = "lbprobe"
  protocol            = "Tcp"
  port                = 8008
  interval_in_seconds = 5
  number_of_probes    = 2
  probe_threshold     = 1
}

########################################
# Reglas (calcadas de tu config original)
########################################

resource "azurerm_lb_rule" "public_http_80" {
  name                           = "PublicLBRule-FE1-http"
  loadbalancer_id                = azurerm_lb.sdwan_external.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-untrust-001-FrontEnd"

  protocol                 = "Tcp"
  frontend_port            = 80
  backend_port             = 80
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.untrust_backend.id]
  probe_id                 = azurerm_lb_probe.untrust_probe.id

  enable_floating_ip      = true
  disable_outbound_snat   = false
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 5
  load_distribution       = "Default"
}

resource "azurerm_lb_rule" "public_udp_10551" {
  name                           = "PublicLBRule-FE1-udp10551"
  loadbalancer_id                = azurerm_lb.sdwan_external.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-untrust-001-FrontEnd"

  protocol                 = "Udp"
  frontend_port            = 10551
  backend_port             = 10551
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.untrust_backend.id]
  probe_id                 = azurerm_lb_probe.untrust_probe.id

  enable_floating_ip      = true
  disable_outbound_snat   = false
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 5
  load_distribution       = "Default"
}

resource "azurerm_lb_rule" "public_udp_4500" {
  name                           = "PublicLBRule-FE1-udp4500"
  loadbalancer_id                = azurerm_lb.sdwan_external.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-untrust-001-FrontEnd"

  protocol                 = "Udp"
  frontend_port            = 4500
  backend_port             = 4500
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.untrust_backend.id]
  probe_id                 = azurerm_lb_probe.untrust_probe.id

  enable_floating_ip      = false
  disable_outbound_snat   = true
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 4
  load_distribution       = "Default"
}

resource "azurerm_lb_rule" "public_udp_500" {
  name                           = "PublicLBRule-FE1-udp500"
  loadbalancer_id                = azurerm_lb.sdwan_external.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-untrust-001-FrontEnd"

  protocol                 = "Udp"
  frontend_port            = 500
  backend_port             = 500
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.untrust_backend.id]
  probe_id                 = azurerm_lb_probe.untrust_probe.id

  enable_floating_ip      = false
  disable_outbound_snat   = true
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 4
  load_distribution       = "Default"
}

resource "azurerm_lb_rule" "public_https_443" {
  name                           = "PublicRule-FE1-HTTPS"
  loadbalancer_id                = azurerm_lb.sdwan_external.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-untrust-001-FrontEnd"

  protocol                 = "Tcp"
  frontend_port            = 443
  backend_port             = 443
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.untrust_backend.id]
  probe_id                 = azurerm_lb_probe.untrust_probe.id

  enable_floating_ip      = false
  disable_outbound_snat   = true
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 4
  load_distribution       = "Default"
}

########################################
# Asociación de NICs untrust al backend
########################################

resource "azurerm_network_interface_backend_address_pool_association" "sdwan_untrust_001" {
  network_interface_id    = data.azurerm_network_interface.sdwan_untrust_nic_001.id
  ip_configuration_name   = local.untrust_ipconfig_name_001
  backend_address_pool_id = azurerm_lb_backend_address_pool.untrust_backend.id

  depends_on = [
    azurerm_lb_rule.public_http_80,
    azurerm_lb_rule.public_udp_10551,
    azurerm_lb_rule.public_udp_4500,
    azurerm_lb_rule.public_udp_500,
    azurerm_lb_rule.public_https_443
  ]
}

resource "azurerm_network_interface_backend_address_pool_association" "sdwan_untrust_002" {
  network_interface_id    = data.azurerm_network_interface.sdwan_untrust_nic_002.id
  ip_configuration_name   = local.untrust_ipconfig_name_002
  backend_address_pool_id = azurerm_lb_backend_address_pool.untrust_backend.id

  depends_on = [
    azurerm_lb_rule.public_http_80,
    azurerm_lb_rule.public_udp_10551,
    azurerm_lb_rule.public_udp_4500,
    azurerm_lb_rule.public_udp_500,
    azurerm_lb_rule.public_https_443
  ]
}
