resource "azurerm_container_app" "capp" {
  name                         = "${var.name}-app"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = var.revision_mode
  tags                         = var.tags
  secret {
    name  = "registry-credentials"
    value = lookup(var.registry, "password_secret_name", null)
  }

  registry {
    server               = lookup(var.registry, "server", null)
    username             = lookup(var.registry, "username", null)
    password_secret_name = "registry-credentials"
  }

  ingress {
    allow_insecure_connections = lookup(var.container.ingress, "allow_insecure_connections", false)
    transport                  = lookup(var.container.ingress, "transport", "http")
    external_enabled           = lookup(var.container.ingress, "external_enabled", true)
    target_port                = lookup(var.container.ingress, "target_port", 80)
    exposed_port               = lookup(var.container.ingress, "exposed_port", null)
    traffic_weight {
      latest_revision = lookup(var.container.ingress, "traffic_weight.latest_revision", true)
      percentage      = lookup(var.container.ingress, "traffic_weight.percentage", 100)
    }
  }

  template {
    min_replicas = 1
    max_replicas = 2

    container {
      name   = lookup(var.container, "name", null)
      image  = lookup(var.container, "image", null)
      cpu    = lookup(var.container, "cpu", "0.5")
      memory = lookup(var.container, "memory", "1Gi")
      dynamic "env" {
        for_each = var.container.envs != null ? var.container.envs : []

        content {
          name        = env.value.name
          secret_name = env.value.secret_name != null ? env.value.secret_name : null
          value       = env.value.value != null ? env.value.value : null
        }
      }
    }
  }

  dynamic "secret" {
    for_each = var.container.secrets != null ? var.container.secrets : {}

    content {
      name  = secret.key
      value = secret.value
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      template.0.container["image"],
    ]
  }
}

locals {
  wait_for_conflict_resolution = [for _ in range(10) : null]
}
resource "null_resource" "wait_for_conflict_resolution" {
  triggers = {
    for idx, _ in local.wait_for_conflict_resolution : tostring(idx) => null
  }
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
