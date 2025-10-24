# ===================================
# Key Vault Module - Simplified
# ===================================

data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "main" {
  name                       = var.key_vault_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  enable_rbac_authorization  = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  tags = var.tags
}

# RBAC: Give current user Key Vault Administrator
/*
resource "azurerm_role_assignment" "current_user_kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}
*/
# Private Endpoint
resource "azurerm_private_endpoint" "keyvault" {
  name                = "${var.key_vault_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.key_vault_name}-psc"
    private_connection_resource_id = azurerm_key_vault.main.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "keyvault-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  name                       = "${var.key_vault_name}-diagnostics"
  target_resource_id         = azurerm_key_vault.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
