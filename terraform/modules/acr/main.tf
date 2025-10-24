# ===================================
# ACR Module - Simplified
# ===================================

# Azure Container Registry
resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Diagnostic Settings - Will be added manually after ACR creation
# resource "azurerm_monitor_diagnostic_setting" "acr" {
#   name                       = "${var.acr_name}-diagnostics"
#   target_resource_id         = azurerm_container_registry.main.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id
#
#   enabled_log {
#     category = "ContainerRegistryRepositoryEvents"
#   }
#
#   enabled_log {
#     category = "ContainerRegistryLoginEvents"
#   }
#
#   metric {
#     category = "AllMetrics"
#     enabled  = true
#   }
# }
