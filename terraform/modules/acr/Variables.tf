# ===================================
# ACR Module - Variables
# ===================================

variable "acr_name" {
  description = "ACR name (alphanumeric only)"
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

variable "acr_sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
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
