# ===================================
# Main Configuration - SIMPLIFIED
# ===================================

locals {
  project_name = var.project_name
  environment  = var.environment

  resource_group_name = "rg-${local.project_name}-${local.environment}"
  aks_cluster_name    = "aks-${local.project_name}-${local.environment}"
  sql_server_name     = "sql-${local.project_name}-${local.environment}"
  # Use lowercase and limit to 8 chars for key vault name uniqueness
  key_vault_suffix    = substr(lower(replace(sha256("${local.project_name}${local.environment}"), "-", "")), 0, 8)
  key_vault_name      = "kv${local.project_name}${local.environment}${local.key_vault_suffix}"
  log_analytics_name  = "log-${local.project_name}-${local.environment}"
  vnet_name           = "vnet-${local.project_name}-${local.environment}"
}
# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

# Networking
module "networking" {
  source = "./modules/networking"

  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  vnet_name                       = local.vnet_name
  vnet_address_space              = var.vnet_address_space
  aks_system_subnet_prefix        = var.aks_system_subnet_prefix
  aks_user_subnet_prefix          = var.aks_user_subnet_prefix
  private_endpoints_subnet_prefix = var.private_endpoints_subnet_prefix
  tags                            = var.tags
}

# Monitoring
module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  log_analytics_workspace_name = local.log_analytics_name
  application_insights_name    = "appi-${local.project_name}-${local.environment}"
  log_analytics_retention_days = var.log_analytics_retention_days
  tags                         = var.tags
}

# Key Vault
module "key_vault" {
  source = "./modules/key-vault"

  key_vault_name             = local.key_vault_name
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  private_endpoint_subnet_id = module.networking.private_endpoints_subnet_id
  private_dns_zone_id        = module.networking.keyvault_private_dns_zone_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  tags                       = var.tags

  depends_on = [module.networking]
}

# AKS with Prometheus & NGINX
module "aks" {
  source = "./modules/aks"

  cluster_name        = local.aks_cluster_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  dns_prefix          = "${local.project_name}-${local.environment}"
  kubernetes_version  = var.kubernetes_version

  # System Node Pool
  system_subnet_id    = module.networking.aks_system_subnet_id
  system_node_vm_size = var.system_node_vm_size
  system_min_count    = var.system_min_count
  system_max_count    = var.system_max_count

  # User Node Pool
  user_subnet_id    = module.networking.aks_user_subnet_id
  user_node_vm_size = var.user_node_vm_size
  user_min_count    = var.user_min_count
  user_max_count    = var.user_max_count

  # Network
  service_cidr   = var.service_cidr
  dns_service_ip = var.dns_service_ip

  # Integrations
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  grafana_admin_password     = var.grafana_admin_password

  tags = var.tags

  # depends_on = [module.networking, module.monitoring, module.acr]
}

# SQL Database
module "sql_database" {
  source = "./modules/sql-database"

  sql_server_name              = local.sql_server_name
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_password
  #azuread_admin_login          = var.azuread_sql_admin_login
  #azuread_admin_object_id      = var.azuread_sql_admin_object_id
  database_name              = var.sql_database_name
  sku_name                   = var.sql_sku_name
  max_size_gb                = var.sql_max_size_gb
  private_endpoint_subnet_id = module.networking.private_endpoints_subnet_id
  private_dns_zone_id        = module.networking.sql_private_dns_zone_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  key_vault_id               = module.key_vault.key_vault_id
  tags                       = var.tags

  depends_on = [module.networking, module.key_vault]
}

# AKS Key Vault Secrets User Role Assignment
resource "azurerm_role_assignment" "aks_kv_secrets_user" {
  principal_id                     = module.aks.key_vault_secrets_provider_identity_object_id
  role_definition_name             = "Key Vault Secrets User"
  scope                            = module.key_vault.key_vault_id
  skip_service_principal_aad_check = true

  depends_on = [module.aks, module.key_vault]
}
