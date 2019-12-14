data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "template" {
  name                        = format("kv%03d%03s", var.id, var.environment)
  location                    = data.azurerm_resource_group.template.location
  resource_group_name         = data.azurerm_resource_group.template.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    usage = var.usage
    environment = var.environment
  }
}