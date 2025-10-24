# ===================================
# AKS Module - Simplified
# With Prometheus & NGINX
# ===================================

# AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = "Standard"

  # System Node Pool
  default_node_pool {
    name                         = "system"
    vm_size                      = var.system_node_vm_size
    vnet_subnet_id               = var.system_subnet_id
    enable_auto_scaling          = true
    min_count                    = var.system_min_count
    max_count                    = var.system_max_count
    max_pods                     = 30
    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "33%"
    }

    # Temporary name for rotation when updating node pool
    temporary_name_for_rotation = "systemtemp"
  }

  # Network
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = var.dns_service_ip
    service_cidr      = var.service_cidr
    load_balancer_sku = "standard"
  }

  # Identity
  identity {
    type = "SystemAssigned"
  }

  # Azure AD RBAC (Updated for v4.0 compatibility)
  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  # Monitoring
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  # Key Vault Secrets Provider
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  tags = var.tags
}

# User Node Pool
resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.user_node_vm_size
  vnet_subnet_id        = var.user_subnet_id
  enable_auto_scaling   = true
  min_count             = var.user_min_count
  max_count             = var.user_max_count
  max_pods              = 30
  mode                  = "User"

  upgrade_settings {
    max_surge = "33%"
  }

  tags = var.tags
}

# ACR Pull Role
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}

# Helm Charts will be deployed manually after AKS creation
# This includes:
# - NGINX Ingress Controller
# - Prometheus Stack (Grafana + Prometheus)
# - Other monitoring tools