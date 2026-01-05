# NSG 
module "nsg_secpp_sensor_001" {
  source              = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_group?ref=master"
  name                = "nsg-secpp-sensor-001"
  location            = data.azurerm_resource_group.rg_sec.location
  resource_group_name = data.azurerm_resource_group.rg_sec.name
  tags                = {}
  security_rule       = [] # reglas se cargan con el módulo de reglas
}

# Reglas NSG vía módulo back
module "nsg_sensor_rules" {
  source                      = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_network_security_rule?ref=master"
  resource_group_name         = data.azurerm_resource_group.rg_sec.name
  network_security_group_name = module.nsg_secpp_sensor_001.name

  rules = {
    out-https-443 = {
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# NIC 
resource "azurerm_network_interface" "lsclppazcmvsensor01_nic_01" {
  name                           = "lsclppazcmvsensor01-nic-01"
  location                       = data.azurerm_resource_group.rg_sec.location
  resource_group_name            = data.azurerm_resource_group.rg_sec.name
  accelerated_networking_enabled = true
  tags                           = {}

  ip_configuration {
    name                          = "lsclppazcmvsensor01-ipcfg-01"
    subnet_id                     = data.azurerm_subnet.cstools.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.134.8.10"
  }
}

# Asociación NSG <-> NIC (recurso nativo)
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.lsclppazcmvsensor01_nic_01.id
  network_security_group_id = module.nsg_secpp_sensor_001.id
  depends_on                = [module.nsg_sensor_rules]
}

# VM DIRECTA (sin módulo, sin plan)
resource "azurerm_linux_virtual_machine" "lsclppazcmvsensor01" {
  name                         = "lsclppazcmvsensor01"
  location                     = data.azurerm_resource_group.rg_sec.location
  resource_group_name          = data.azurerm_resource_group.rg_sec.name
  size                         = "Standard_D4s_v3"
  computer_name                = "lsclppazcmvsensor01"
  network_interface_ids        = [azurerm_network_interface.lsclppazcmvsensor01_nic_01.id]
  proximity_placement_group_id = null

  depends_on = [azurerm_network_interface_security_group_association.nic_nsg]

  admin_username                  = "bchuser"
  admin_password                  = "BCH_P@ssw0rd!"
  disable_password_authentication = false

  zone = "1"
  tags = {}

  os_disk {
    name                 = "lsclppazcmvsensor01-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  # Ubuntu 24.04.x visible en tu suscripción (SIN plan)
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server" # si alguna reliquia exige Gen1: "server-gen1"
    version   = "latest" # cambia a la 24.04.1 exacta cuando toque
  }

  boot_diagnostics {
    storage_account_uri = null
  }
}
