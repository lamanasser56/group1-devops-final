# ===================================
# AKS Module - Variables
# ===================================

variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null
}

# System Node Pool
variable "system_subnet_id" {
  description = "System node pool subnet ID"
  type        = string
}

variable "system_node_vm_size" {
  description = "System node VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "system_min_count" {
  description = "System node minimum count"
  type        = number
  default     = 1
}

variable "system_max_count" {
  description = "System node maximum count"
  type        = number
  default     = 3
}

# User Node Pool
variable "user_subnet_id" {
  description = "User node pool subnet ID"
  type        = string
}

variable "user_node_vm_size" {
  description = "User node VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "user_min_count" {
  description = "User node minimum count"
  type        = number
  default     = 2
}

variable "user_max_count" {
  description = "User node maximum count"
  type        = number
  default     = 10
}

# Network
variable "service_cidr" {
  description = "Kubernetes service CIDR"
  type        = string
  default     = "10.255.0.0/16"
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP"
  type        = string
  default     = "10.255.0.10"
}

# Monitoring
variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

# ACR
variable "acr_id" {
  description = "ACR ID"
  type        = string
  default     = null
}

# Grafana
variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
