terraform{
  backend "local" {}
}

resource "random_string" "tester" {
  length           = 8
  override_special = "-_"
}

resource "random_integer" "tester" {
  min = 1
  max = 999
}

resource "azurerm_resource_group" "tester" {
  name     = format("rg_test_%s", random_string.tester.result)
  location = var.location
}

module "template" {
  source              = "../"
  location            = var.location
  id                  = var.id
  environment         = format("%03s%03d", var.environment, random_integer.tester.result)
  usage               = var.usage
  resource_group_name = azurerm_resource_group.tester.name
}