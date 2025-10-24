# ===================================
# SQL Database Module - Outputs
# ===================================

output "sql_server_id" {
  description = "SQL Server ID"
  value       = azurerm_mssql_server.main.id
}

output "sql_server_name" {
  description = "SQL Server name"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "SQL Server FQDN"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "database_name" {
  description = "Database name"
  value       = azurerm_mssql_database.main.name
}

# output "connection_string_secret_id" {
#   description = "Key Vault secret ID for connection string"
#   value       = azurerm_key_vault_secret.sql_connection_string.id
# }

