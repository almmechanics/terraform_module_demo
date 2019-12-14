resource "azurerm_resource_group" "template" {
  name     = "${var.ResourceGroupName}"
  location = "${var.location}"
}