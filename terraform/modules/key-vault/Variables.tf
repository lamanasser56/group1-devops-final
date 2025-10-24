# ===================================
# Key Vault Module - Variables
# ===================================

variable "key_vault_name" {
  description = "Key Vault name"
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

variable "private_endpoint_subnet_id" {
  description = "Private endpoint subnet ID"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID for Key Vault"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
