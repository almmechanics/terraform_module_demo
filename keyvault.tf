data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "template" {
  name                        = format("kv%03d",var.environment)
  location                    = "${azurerm_resource_group.template.location}"
  resource_group_name         = "${azurerm_resource_group.template.name}"
  tenant_id = "${data.azurerm_client_config.current.tenant_id}"
  sku_name = "standard"
  
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}