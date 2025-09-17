resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azapi_resource" "mongo_cluster_vcore" {
  type      = "Microsoft.DocumentDB/mongoClusters@2023-09-15-preview"
  name      = "${var.name}-${random_integer.ri.result}"
  location  = var.location
  parent_id = var.resource_group_id
  tags      = var.tags

  body = jsonencode({
    properties = {
      administratorLogin         = var.admin_username
      administratorLoginPassword = var.admin_password
      createMode                 = var.create_mode
      nodeGroupSpecs = [
        {
          diskSizeGB = var.node_group_disk_sizeGB
          enableHa   = var.node_group_enableHa
          kind       = var.node_group_kind
          nodeCount  = var.node_group_nodeCount
          sku        = var.node_group_sku
        }
      ]
      serverVersion = var.server_version
    }
  })
}

resource "azapi_resource" "mongo_cluster_firewall_Rules" {
  type      = "Microsoft.DocumentDB/mongoClusters/firewallRules@2023-09-15-preview"
  name      = "AllowAllAzureServices"
  parent_id = azapi_resource.mongo_cluster_vcore.id

  body = jsonencode({
    properties = {
      startIpAddress : "0.0.0.0"
      endIpAddress : "0.0.0.0"
    }
  })

  depends_on = [azapi_resource.mongo_cluster_vcore]
}
