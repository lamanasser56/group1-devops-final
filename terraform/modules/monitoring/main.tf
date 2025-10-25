# ===================================
# Monitoring Module - Simplified
# ===================================

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_days
  tags                = var.tags

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

# Container Insights Solution
resource "azurerm_log_analytics_solution" "container_insights" {
  solution_name         = "ContainerInsights"
  resource_group_name   = var.resource_group_name
  location              = var.location
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = var.tags
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  tags                = var.tags

  depends_on = [
    azurerm_log_analytics_workspace.main
  ]
}
