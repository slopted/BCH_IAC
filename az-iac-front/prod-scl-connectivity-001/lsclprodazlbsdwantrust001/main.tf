########################################
# Load Balancer Interno – ChileCentral
########################################

resource "azurerm_lb" "sdwan_internal" {
  name                = "lb-scl-prod-sdwan-trust-001"
  location            = "chilecentral"
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = {}

  frontend_ip_configuration {
    name                          = "lb-scl-prod-sdwan-trust-001-FrontEnd"
    subnet_id                     = data.azurerm_subnet.snet_sdwan_trust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.99.41.22" # Asegúrate que pertenezca a la snet TRUST y esté libre
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_lb_backend_address_pool" "trust_backend" {
  name            = "lb-scl-prod-sdwan-trust-001-BackEnd"
  loadbalancer_id = azurerm_lb.sdwan_internal.id
}

resource "azurerm_lb_probe" "trust_probe" {
  loadbalancer_id     = azurerm_lb.sdwan_internal.id
  name                = "lbprobe"
  protocol            = "Tcp"
  port                = 8008
  interval_in_seconds = 5
  number_of_probes    = 2
  probe_threshold     = 1
}

# Regla tipo HA Ports (Protocolo All, puertos wildcard)
resource "azurerm_lb_rule" "ilb_rule_all" {
  name                           = "lbruleFE2all"
  loadbalancer_id                = azurerm_lb.sdwan_internal.id
  frontend_ip_configuration_name = "lb-scl-prod-sdwan-trust-001-FrontEnd"

  protocol                 = "All"
  frontend_port            = 0
  backend_port             = 0
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.trust_backend.id]
  probe_id                 = azurerm_lb_probe.trust_probe.id

  enable_floating_ip      = true
  disable_outbound_snat   = false
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 5
  load_distribution       = "Default"
}

########################################
# Asociación de NICs TRUST al backend
########################################

resource "azurerm_network_interface_backend_address_pool_association" "sdwan_trust_001" {
  network_interface_id    = data.azurerm_network_interface.sdwan_trust_nic_001.id
  ip_configuration_name   = local.trust_ipconfig_name_001
  backend_address_pool_id = azurerm_lb_backend_address_pool.trust_backend.id

  depends_on = [azurerm_lb_rule.ilb_rule_all]
}

resource "azurerm_network_interface_backend_address_pool_association" "sdwan_trust_002" {
  network_interface_id    = data.azurerm_network_interface.sdwan_trust_nic_002.id
  ip_configuration_name   = local.trust_ipconfig_name_002
  backend_address_pool_id = azurerm_lb_backend_address_pool.trust_backend.id

  depends_on = [azurerm_lb_rule.ilb_rule_all]
}
