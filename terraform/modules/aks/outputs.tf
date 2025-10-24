# ===================================
# AKS Module - Outputs
# ===================================

output "cluster_id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.main.id
}

output "cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.main.name
}

output "cluster_fqdn" {
  description = "AKS cluster FQDN"
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "kubernetes_version" {
  description = "Kubernetes version"
  value       = azurerm_kubernetes_cluster.main.kubernetes_version
}

output "kube_config" {
  description = "Kubernetes config"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "Kubelet identity object ID"
  value       = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}

output "key_vault_secrets_provider_identity_object_id" {
  description = "Key Vault secrets provider identity object ID"
  value       = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id
}

