# ===================================
# Outputs - SIMPLIFIED
# ===================================

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_cluster_fqdn" {
  value = module.aks.cluster_fqdn
}

/*
output "acr_login_server" {
  value = module.acr.acr_login_server
}
*/

output "key_vault_uri" {
  value = module.key_vault.key_vault_uri
}

output "sql_server_fqdn" {
  value = module.sql_database.sql_server_fqdn
}

output "connect_to_aks" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${module.aks.cluster_name}"
}

output "grafana_access" {
  value = "kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3000:80"
}

output "prometheus_access" {
  value = "kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 9090:9090"
}
