resource "azurerm_storage_account" "template" {
  name                      = format("sa%03d%03s", var.id, var.environment)
  resource_group_name       = azurerm_resource_group.template.name
  location                  = azurerm_resource_group.template.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  tags = {
    usage       = var.usage
    environment = var.environment
  }
}