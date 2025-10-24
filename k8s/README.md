## Kubernetes Manifests

This directory contains kustomize overlays for the two cluster add-ons that we previously managed through Terraform/Helm:

1. `k8s/ingress` – deploys the upstream `ingress-nginx` controller (v1.11.1) with additional policies (replicas=3, autoscaling, PDB, Azure load-balancer configuration, and stricter resource limits).
2. `k8s/monitoring` – deploys the official kube-prometheus stack (Prometheus Operator, Prometheus, Alertmanager, Grafana, node exporters, etc.) sourced from `github.com/prometheus-operator/kube-prometheus` and patched to use a single replica with in-cluster storage.

### Prerequisites

- `kubectl` v1.27+ with kustomize support (already built-in).
- `kubelogin` installed because the AKS cluster has AAD enabled.
- Access to the cluster (run the Terraform output from `terraform output -raw connect_to_aks`).

### Deploy / Update

```bash
# ensure kubectl context points to aks-devops-lama
az aks get-credentials --resource-group rg-devops-lama --name aks-devops-lama --file /home/lama/aks-config.yml --overwrite-existing
export KUBECONFIG=/home/lama/aks-config.yml

# Ingress controller
kubectl apply -k k8s/ingress

# Monitoring stack
kubectl apply -k k8s/monitoring
```

### Verify

- `kubectl get pods -n ingress`
- `kubectl get pods -n monitoring`
- `kubectl get svc -n ingress ingress-nginx-controller` → note the public IP to wire DNS/TLS.
- `kubectl port-forward -n monitoring svc/grafana 3000:3000` and login with the credentials stored in Key Vault.

### Cleanup

```bash
kubectl delete -k k8s/ingress
kubectl delete -k k8s/monitoring
```

> These overlays intentionally avoid storing secrets. Sensitive values (Grafana admin password, alertmanager receivers, etc.) should continue to be sourced from Azure Key Vault + CSI once those manifests are added for the application namespaces.
