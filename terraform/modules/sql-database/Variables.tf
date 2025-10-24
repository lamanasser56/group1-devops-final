# ===================================
# SQL Database Module - Variables
# ===================================

variable "sql_server_name" {
  description = "SQL Server name"
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

variable "administrator_login" {
  description = "Administrator username"
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator password"
  type        = string
  sensitive   = true
}
/*
variable "azuread_admin_login" {
  description = "Azure AD admin login"
  type        = string
}

variable "azuread_admin_object_id" {
  description = "Azure AD admin object ID"
  type        = string
}
*/
variable "database_name" {
  description = "Database name"
  type        = string
}

variable "sku_name" {
  description = "Database SKU"
  type        = string
  default     = "S0"
}

variable "max_size_gb" {
  description = "Maximum database size in GB"
  type        = number
  default     = 2
}

variable "private_endpoint_subnet_id" {
  description = "Private endpoint subnet ID"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID for SQL"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
