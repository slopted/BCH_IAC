locals {
  location = "chilecentral"
  tags     = {}

  pan_image = {
    publisher = "paloaltonetworks"
    offer     = "vmseries-flex"
    sku       = "byol"
    version   = "10.2.1014"
  }

  pan_plan = {
    publisher = "paloaltonetworks"
    product   = "vmseries-flex"
    name      = "byol"
  }

  # NSG names
  nsg_mgmt_name    = "nsg-prd-fwpan-mgmt-001"
  nsg_trust_name   = "nsg-prd-fwpan-trust-001"
  nsg_untrust_name = "nsg-prd-fwpan-untrust-001"

  # LB interno (TRUST)
  lb_name    = "lb-scl-prd-fwpan-trust-001"
  lb_fe_name = "lb-scl-prd-fwpan-frontend-trust"
  lb_fe_ip   = "10.133.1.132"

  # IPs Nodo 1
  fw1_mgmt_ip    = "10.133.1.149"
  fw1_trust_ip   = "10.133.1.133"
  fw1_untrust_ip = "10.133.3.253"
}

# ============ Aceptar términos Marketplace PA
resource "azurerm_marketplace_agreement" "pan" {
  publisher = local.pan_image.publisher
  offer     = local.pan_image.offer
  plan      = local.pan_image.sku
}

# ============ NSG MGMT + reglas + asociación
module "nsg_mgmt" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_group?ref=master"
  name                = local.nsg_mgmt_name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = local.tags
  security_rule       = []
}

module "nsg_mgmt_rules" {
  source                      = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_rule?ref=master"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.nsg_mgmt.name

  rules = {
    allow-ssh = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    allow-https = {
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    allow-443-out = {
      priority                   = 125
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    }

    allow-icmp-out = {
      priority                   = 126
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Icmp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    }

    allow-any-out = {
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    deny-any-out = {
      priority                   = 130
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

module "assoc_mgmt_subnet_nsg" {
  source                    = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_subnet_network_security_group_association?ref=master"
  subnet_id                 = data.azurerm_subnet.snet_mgmt.id
  network_security_group_id = module.nsg_mgmt.id
}

# ============ NSG TRUST + reglas
module "nsg_trust" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_group?ref=master"
  name                = local.nsg_trust_name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = local.tags
  security_rule       = []
}

module "nsg_trust_rules" {
  source                      = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_rule?ref=master"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.nsg_trust.name

  rules = {
    AllowAnyCustomAnyInbound = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    AllowAnyCustomAnyOutbound = {
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# ============ NSG UNTRUST + reglas
module "nsg_untrust" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_group?ref=master"
  name                = local.nsg_untrust_name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = local.tags
  security_rule       = []
}

module "nsg_untrust_rules" {
  source                      = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_rule?ref=master"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.nsg_untrust.name

  rules = {
    AllowAnyCustomAnyInbound = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

    AllowAnyCustomAnyOutbound = {
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# ============ Route Table TRUST (Nodo 1) + asociación
resource "azurerm_route_table" "rt_trust" {
  name                          = "route-prd-fwpl-trust"
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false
  tags                          = local.tags

  # Default: todo sale por el HA IP del LB en TRUST (10.133.1.132)
  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.133.1.132"
  }
}

resource "azurerm_subnet_route_table_association" "assoc_rt_trust" {
  subnet_id      = data.azurerm_subnet.snet_trust.id
  route_table_id = azurerm_route_table.rt_trust.id
}

# ============ Route Table UNTRUST (Nodo 1) + asociación
resource "azurerm_route_table" "rt_untrust" {
  name                          = "route-prd-fwpl-untrust-001"
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false
  tags                          = local.tags

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.133.1.132"
  }
}

resource "azurerm_subnet_route_table_association" "assoc_rt_untrust" {
  subnet_id      = data.azurerm_subnet.snet_untrust1.id
  route_table_id = azurerm_route_table.rt_untrust.id
}

# ============ NAT Gateway para subnet UNTRUST ============

# IP pública del NAT Gateway
resource "azurerm_public_ip" "ngw_untrust_pip" {
  name                = "pip-ngw-untrust-001"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = local.tags
}

# NAT Gateway
resource "azurerm_nat_gateway" "ngw_untrust" {
  name                = "natgw-prd-scl-fwpan-untrust-001"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku_name            = "Standard"
  idle_timeout_in_minutes = 10
  zones               = ["1"]
  tags                = local.tags
}

# Asociar PIP al NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "ngw_untrust_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.ngw_untrust.id
  public_ip_address_id = azurerm_public_ip.ngw_untrust_pip.id
}

# Asociar NAT Gateway a la subnet UNTRUST
resource "azurerm_subnet_nat_gateway_association" "snet_untrust_ngw_assoc" {
  subnet_id      = data.azurerm_subnet.snet_untrust1.id
  nat_gateway_id = azurerm_nat_gateway.ngw_untrust.id
}

# ============ NICs Nodo 1
resource "azurerm_network_interface" "fw001_mgmt" {
  name                           = "lsclprdazvmfwpan001-mgmt"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = false
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw001-mgmt-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw1_mgmt_ip
    primary                       = true
  }
}

resource "azurerm_network_interface_security_group_association" "fw001_mgmt_assoc" {
  network_interface_id      = azurerm_network_interface.fw001_mgmt.id
  network_security_group_id = module.nsg_mgmt.id
}

resource "azurerm_network_interface" "fw001_untrust" {
  name                           = "lsclprdazvmfwpan001-untrust"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = true
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw001-untrust-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_untrust1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw1_untrust_ip
  }

  # Garantiza que el NAT Gateway esté asociado antes de esta NIC
  depends_on = [
    azurerm_subnet_nat_gateway_association.snet_untrust_ngw_assoc
  ]
}

resource "azurerm_network_interface_security_group_association" "fw001_untrust_assoc" {
  network_interface_id      = azurerm_network_interface.fw001_untrust.id
  network_security_group_id = module.nsg_untrust.id
}

resource "azurerm_network_interface" "fw001_trust" {
  name                           = "lsclprdazvmfwpan001-trust"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = true
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw001-trust-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_trust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw1_trust_ip
  }
}

resource "azurerm_network_interface_security_group_association" "fw001_trust_assoc" {
  network_interface_id      = azurerm_network_interface.fw001_trust.id
  network_security_group_id = module.nsg_trust.id
}

# ============ LB interno (TRUST)
resource "azurerm_lb" "fwpan_lb" {
  name                = local.lb_name
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = local.tags

  frontend_ip_configuration {
    name                          = local.lb_fe_name
    subnet_id                     = data.azurerm_subnet.snet_trust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.lb_fe_ip
    zones                         = ["1", "2", "3"]
  }
}

resource "azurerm_lb_backend_address_pool" "fwpan_backend" {
  name            = "backend_fw"
  loadbalancer_id = azurerm_lb.fwpan_lb.id
}

resource "azurerm_lb_probe" "fwpan_probe_ssh" {
  name                = "sondeo_LB_FW"
  loadbalancer_id     = azurerm_lb.fwpan_lb.id
  protocol            = "Tcp"
  port                = 22
  interval_in_seconds = 5
  number_of_probes    = 2
  probe_threshold     = 1
}

resource "azurerm_lb_rule" "fwpan_rule_ha" {
  name                           = "Rule1"
  loadbalancer_id                = azurerm_lb.fwpan_lb.id
  frontend_ip_configuration_name = local.lb_fe_name
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.fwpan_backend.id]
  probe_id                       = azurerm_lb_probe.fwpan_probe_ssh.id
  enable_floating_ip             = true
  disable_outbound_snat          = false
  enable_tcp_reset               = false
  idle_timeout_in_minutes        = 4
  load_distribution              = "Default"
}

resource "azurerm_network_interface_backend_address_pool_association" "fw001_trust_lb_assoc" {
  network_interface_id    = azurerm_network_interface.fw001_trust.id
  ip_configuration_name   = "fw001-trust-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.fwpan_backend.id
}

# ============ Route Table (MGMT) + asociación
resource "azurerm_route_table" "rt_mgmt" {
  name                          = "route-prd-fwpl-mgmt"
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.133.1.132"
  }

  route {
    name                   = "ruta_onprem_A"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  route {
    name                   = "ruta_onprem_B"
    address_prefix         = "152.139.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  route {
    name                   = "ruta_onprem_C"
    address_prefix         = "166.110.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  route {
    name                   = "ruta_onprem_D"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  route {
    name                   = "ruta_onprem_E"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  route {
    name                   = "ruta_onprem_F"
    address_prefix         = "200.14.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.99.41.22"
  }

  tags = local.tags
}

resource "azurerm_subnet_route_table_association" "assoc_rt_mgmt" {
  subnet_id      = data.azurerm_subnet.snet_mgmt.id
  route_table_id = azurerm_route_table.rt_mgmt.id
  depends_on     = [azurerm_route_table.rt_mgmt]
}

# ============ VM Nodo 1 (módulo back)
module "fwpan001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine?ref=master"
  name                = "lsclprodazvmfwpan001"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name

  network_interface_ids = [
    azurerm_network_interface.fw001_mgmt.id,
    azurerm_network_interface.fw001_untrust.id,
    azurerm_network_interface.fw001_trust.id
  ]

  size                         = "Standard_D8ds_v5"
  os_disk_name                 = "lsclprodazvmfwpan001-OsDisk_1"
  os_disk_caching              = "ReadWrite"
  os_disk_storage_account_type = "Premium_LRS"

  source_image_reference_publisher = local.pan_image.publisher
  source_image_reference_offer     = local.pan_image.offer
  source_image_reference_sku       = local.pan_image.sku
  source_image_reference_version   = local.pan_image.version

  computer_name                   = "lsclprodazvmfwpan001"
  admin_username                  = "bchuser"
  admin_password                  = "BCH_P@ssw0rd!"
  disable_password_authentication = false

  storage_account_uri          = null
  proximity_placement_group_id = null

  tags = local.tags

  zone           = "1"
  plan_publisher = local.pan_plan.publisher
  plan_product   = local.pan_plan.product
  plan_name      = local.pan_plan.name

  identity_enabled  = true
  data_disk_enabled = true

  depends_on = [
    azurerm_marketplace_agreement.pan,
    module.nsg_mgmt_rules,
    module.nsg_trust_rules,
    module.nsg_untrust_rules,
    module.assoc_mgmt_subnet_nsg,
    azurerm_network_interface_security_group_association.fw001_mgmt_assoc,
    azurerm_network_interface_security_group_association.fw001_trust_assoc,
    azurerm_network_interface_security_group_association.fw001_untrust_assoc,
    azurerm_network_interface_backend_address_pool_association.fw001_trust_lb_assoc,
    azurerm_subnet_route_table_association.assoc_rt_mgmt
  ]
}
