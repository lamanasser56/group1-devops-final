
# ===================================
# Networking Module - Outputs
# ===================================

output "vnet_id" {
  description = "VNet ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "VNet name"
  value       = azurerm_virtual_network.main.name
}

output "aks_system_subnet_id" {
  description = "AKS system subnet ID"
  value       = azurerm_subnet.aks_system.id
}

output "aks_user_subnet_id" {
  description = "AKS user subnet ID"
  value       = azurerm_subnet.aks_user.id
}

output "private_endpoints_subnet_id" {
  description = "Private endpoints subnet ID"
  value       = azurerm_subnet.private_endpoints.id
}

output "keyvault_private_dns_zone_id" {
  description = "Key Vault private DNS zone ID"
  value       = azurerm_private_dns_zone.keyvault.id
}

output "sql_private_dns_zone_id" {
  description = "SQL private DNS zone ID"
  value       = azurerm_private_dns_zone.sql.id
}
