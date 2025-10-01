resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  provisioned_billing_model_version = var.provisioned_billing_model_version
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled

  share_properties {
    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 200
    }
    retention_policy {
      days    = 7
      permanent_delete_enabled = false
    }
    smb {
      versions = ["SMB3.0"]
      authentication_types = [ "NTLMv2"]
      kerberos_ticket_encryption_type = ["RC4_HMAC"]
      channel_encryption_type = ["AES-128-GCM", "AES-256-GCM"]
      multichannel_enabled = false
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = var.subnet_ids
    private_link_access {
      endpoint_resource_id = ""
      endpoint_tenant_id = "<TENANT_ID>"
    }
  }

  identity {
    type = var.identity_type
    identity_ids = var.identity_type=="UserAssigned"?[azurerm_user_assigned_identity.sa_identity[0].id]:null
  }
}