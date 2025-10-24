output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}

output "storage_account_id" {
  value = azurerm_storage_account.tfstate.id
}

output "primary_access_key" {
  value     = azurerm_storage_account.tfstate.primary_access_key
  sensitive = true
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}
