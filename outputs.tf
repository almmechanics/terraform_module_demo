output "keyvault_id" {
  value = azurerm_key_vault.template.id
}

output "storage_account_id" {
  value = azurerm_storage_account.template.id
}