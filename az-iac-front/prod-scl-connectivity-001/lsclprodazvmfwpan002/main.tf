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

  # IPs Nodo 2
  fw2_mgmt_ip    = "10.133.1.150"
  fw2_trust_ip   = "10.133.1.134"
  fw2_untrust_ip = "10.133.4.253"
}

# ============ NAT Gateway para Nodo 2 (subnet untrust2) ============

# IP pública del NAT Gateway
resource "azurerm_public_ip" "ngw_untrust2_pip" {
  name                = "pip-natgw-prd-scl-fwpan-untrust-002"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = local.tags
}

# NAT Gateway
resource "azurerm_nat_gateway" "ngw_untrust2" {
  name                    = "natgw-prd-scl-fwpan-untrust-002"
  location                = local.location
  resource_group_name     = data.azurerm_resource_group.rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["2"]
  tags                    = local.tags
}

# Asociar PIP al NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "ngw_untrust2_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.ngw_untrust2.id
  public_ip_address_id = azurerm_public_ip.ngw_untrust2_pip.id
}

# Asociar NAT Gateway a la subnet UNTRUST2
resource "azurerm_subnet_nat_gateway_association" "snet_untrust2_ngw_assoc" {
  subnet_id      = data.azurerm_subnet.snet_untrust2.id
  nat_gateway_id = azurerm_nat_gateway.ngw_untrust2.id
}

# ============ NICs Nodo 2
resource "azurerm_network_interface" "fw002_mgmt" {
  name                           = "lsclprdazvmfwpan002-mgmt"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = false
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw002-mgmt-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_mgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw2_mgmt_ip
    primary                       = true
  }
}

resource "azurerm_network_interface_security_group_association" "fw002_mgmt_assoc" {
  network_interface_id      = azurerm_network_interface.fw002_mgmt.id
  network_security_group_id = data.azurerm_network_security_group.nsg_mgmt.id
}

resource "azurerm_network_interface" "fw002_untrust" {
  name                           = "lsclprdazvmfwpan002-untrust"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = true
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw002-untrust-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_untrust2.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw2_untrust_ip
  }

  # Garantiza que el NAT Gateway esté asociado antes de levantar esta NIC
  depends_on = [
    azurerm_subnet_nat_gateway_association.snet_untrust2_ngw_assoc
  ]
}

resource "azurerm_network_interface_security_group_association" "fw002_untrust_assoc" {
  network_interface_id      = azurerm_network_interface.fw002_untrust.id
  network_security_group_id = data.azurerm_network_security_group.nsg_untrust.id
}

resource "azurerm_network_interface" "fw002_trust" {
  name                           = "lsclprdazvmfwpan002-trust"
  location                       = local.location
  resource_group_name            = data.azurerm_resource_group.rg.name
  ip_forwarding_enabled          = true
  accelerated_networking_enabled = true
  tags                           = local.tags

  ip_configuration {
    name                          = "fw002-trust-ipconfig"
    subnet_id                     = data.azurerm_subnet.snet_trust.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.fw2_trust_ip
  }
}

resource "azurerm_network_interface_security_group_association" "fw002_trust_assoc" {
  network_interface_id      = azurerm_network_interface.fw002_trust.id
  network_security_group_id = data.azurerm_network_security_group.nsg_trust.id
}

# Asociar TRUST del Nodo2 al backend del LB existente
resource "azurerm_network_interface_backend_address_pool_association" "fw002_trust_lb_assoc" {
  network_interface_id    = azurerm_network_interface.fw002_trust.id
  ip_configuration_name   = "fw002-trust-ipconfig"
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.fwpan_backend.id
}

# ============ Route Table UNTRUST (Nodo 2) + asociación
resource "azurerm_route_table" "rt_untrust_002" {
  name                          = "route-prd-fwpl-untrust-002"
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  bgp_route_propagation_enabled = false
  tags                          = local.tags

  # Default: todo 0.0.0.0/0 hacia el HA IP del LB (10.133.1.132)
  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.133.1.132"
  }
}

resource "azurerm_subnet_route_table_association" "assoc_rt_untrust_002" {
  subnet_id      = data.azurerm_subnet.snet_untrust2.id
  route_table_id = azurerm_route_table.rt_untrust_002.id
}



# ============ VM Nodo 2 (módulo back)
module "fwpan002" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine?ref=master"
  name                = "lsclprodazvmfwpan002"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name

  network_interface_ids = [
    azurerm_network_interface.fw002_mgmt.id,
    azurerm_network_interface.fw002_untrust.id,
    azurerm_network_interface.fw002_trust.id
  ]

  size                         = "Standard_D8ds_v5"
  os_disk_name                 = "lsclprodazvmfwpan002-OsDisk_1"
  os_disk_caching              = "ReadWrite"
  os_disk_storage_account_type = "Premium_LRS"

  source_image_reference_publisher = local.pan_image.publisher
  source_image_reference_offer     = local.pan_image.offer
  source_image_reference_sku       = local.pan_image.sku
  source_image_reference_version   = local.pan_image.version

  computer_name                   = "lsclprodazvmfwpan002"
  admin_username                  = "bchuser"
  admin_password                  = "BCH_P@ssw0rd!"
  disable_password_authentication = false

  storage_account_uri          = null
  proximity_placement_group_id = null

  tags = local.tags

  zone           = "2"
  plan_publisher = local.pan_plan.publisher
  plan_product   = local.pan_plan.product
  plan_name      = local.pan_plan.name

  identity_enabled  = true
  data_disk_enabled = true

  depends_on = [
    azurerm_network_interface_security_group_association.fw002_mgmt_assoc,
    azurerm_network_interface_security_group_association.fw002_trust_assoc,
    azurerm_network_interface_security_group_association.fw002_untrust_assoc,
    azurerm_network_interface_backend_address_pool_association.fw002_trust_lb_assoc
  ]
}
