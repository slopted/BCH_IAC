module "pip_sdwan_untrust" {
  source                  = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_public_ip?ref=master"

  name                    = "lsclprdazvmsdwan001-untrust"
  location                = "chilecentral"
  resource_group_name     = data.azurerm_resource_group.rg-prd-scl-hub-001.name

  allocation_method       = "Static"
  sku                     = "Standard"
  domain_name_label       = null
  ddos_protection_mode    = "Disabled"
  ddos_protection_plan_id = null
  tags                    = {}
}

module "lsclprdazvmsdwan001" {
  source = "git::https://github.com/bch-devsecops/az-iac-back.git//mod_virtual_machine_sdwan?ref=master"

  name                = "lsclprdazvmsdwan001"
  resource_group_name = data.azurerm_resource_group.rg-prd-scl-hub-001.name

  data = {
    "vnet-hub-name"               = "vnet-hubprd-scl-001"
    "snet-hub-sdwan-untrust-name" = "snet-hubprd-sdwan-untrust-001"
    "snet-hub-sdwan-trust-name"   = "snet-hubprd-sdwan-trust-001"
    "snet-hub-sdwan-ha-name"      = "snet-hubprd-sdwan-ha-001"
    "snet-hub-sdwan-mgmt-name"    = "snet-hubprd-sdwan-mgmt-001"
  }

  private_ip_address = {
    sdwan-untrust-ip1 = "10.99.41.4"
    sdwan-trust-ip1   = "10.99.41.20"
    sdwan-ha-ip1      = "10.99.41.36"
    sdwan-mgmt-ip1    = "10.99.41.52"
  }

  # NUEVO: PIP para NIC untrust
  untrust_public_ip_id = module.pip_sdwan_untrust.id

  # Fortinet Marketplace
  accept       = true
  publisher    = "fortinet"
  offer        = "fortinet_fortigate-vm_v5"
  license_type = "byol"

  size                            = "Standard_F32s_v2"
  proximity_placement_group_id    = null
  computer_name                   = "lsclprdazvmsdwan001"
  admin_username                  = "bchuser"
  admin_password                  = "BCH_P@ssw0rd!"
  disable_password_authentication = false
  tags                            = {}
  zone                            = "1"

  source_image_reference = {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       = "fortinet_fg-vm"
    version   = "7.4.8"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  storage_account_uri = null
}
