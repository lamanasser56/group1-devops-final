# ===================================
# Networking Module - Variables (Simplified)
# ===================================

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_system_subnet_prefix" {
  description = "AKS system subnet CIDR"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "aks_user_subnet_prefix" {
  description = "AKS user subnet CIDR"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "private_endpoints_subnet_prefix" {
  description = "Private endpoints subnet CIDR"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
