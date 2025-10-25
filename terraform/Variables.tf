# ===================================
# Variables - SIMPLIFIED
# ===================================

# General
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devops"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

# Network
variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_system_subnet_prefix" {
  description = "AKS system subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "aks_user_subnet_prefix" {
  description = "AKS user subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "private_endpoints_subnet_prefix" {
  description = "Private endpoints subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

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

# AKS
variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null
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

variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
}

# SQL
variable "sql_administrator_login" {
  description = "SQL admin username"
  type        = string
  default     = "sqladmin"
}

variable "sql_administrator_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "SQL database name"
  type        = string
  default     = "appdb"
}

variable "sql_sku_name" {
  description = "SQL database SKU"
  type        = string
  default     = "S0"
}

variable "sql_max_size_gb" {
  description = "SQL max size in GB"
  type        = number
  default     = 2
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    "ManagedBy" = "Terraform"
    "Project"   = "DevOps-Capstone"
  }
}

# Log Analytics
variable "log_analytics_retention_days" {
  description = "Log Analytics retention days"
  type        = number
  default     = 30
}
/*
variable "azuread_sql_admin_login" {
  description = "Azure AD admin email"
  type        = string
}

variable "azuread_sql_admin_object_id" {
  description = "Azure AD admin object ID"
  type        = string
}
*/
# ACR
variable "acr_sku" {
  description = "ACR SKU"
  type        = string
  default     = "Standard"
}
