resource "azurerm_resource_group" "template" {
  name     = "${var.resourceGroupName}"
  location = "${var.location}"
}