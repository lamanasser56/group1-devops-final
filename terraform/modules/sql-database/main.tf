# ===================================
# SQL Database Module - Simplified
# ===================================

# SQL Server
resource "azurerm_mssql_server" "main" {
  name                          = var.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

/*
  azuread_administrator {
    login_username = var.azuread_admin_login
    object_id      = var.azuread_admin_object_id
  }*/

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "main" {
  name      = var.database_name
  server_id = azurerm_mssql_server.main.id
  sku_name  = var.sku_name
  collation = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = var.max_size_gb

  tags = var.tags
}

# Private Endpoint
resource "azurerm_private_endpoint" "sql" {
  name                = "${var.sql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.sql_server_name}-psc"
    private_connection_resource_id = azurerm_mssql_server.main.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# Diagnostic Settings - Server (Will be added manually after SQL Server creation)
# resource "azurerm_monitor_diagnostic_setting" "sql_server" {
#   name                       = "${var.sql_server_name}-diagnostics"
#   target_resource_id         = azurerm_mssql_server.main.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id
#
#   enabled_log {
#     category = "Errors"
#   }
#
#   metric {
#     category = "AllMetrics"
#     enabled  = true
#   }
# }

# Diagnostic Settings - Database
resource "azurerm_monitor_diagnostic_setting" "sql_database" {
  name                       = "${var.database_name}-diagnostics"
  target_resource_id         = azurerm_mssql_database.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "Errors"
  }

  metric {
    category = "Basic"
    enabled  = true
  }
}

# Store connection string in Key Vault (Will be added manually after permissions are set)
# resource "azurerm_key_vault_secret" "sql_connection_string" {
#   name         = "sql-connection-string"
#   value        = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${var.administrator_login};Password=${var.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
#   key_vault_id = var.key_vault_id
#
#   tags = var.tags
#
#   depends_on = [
#     azurerm_mssql_server.main,
#     azurerm_mssql_database.main
#   ]
# }
