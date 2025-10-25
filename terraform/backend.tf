# Backend Configuration - Simple Setup
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-team-state"
    storage_account_name = "tfstatedevopsteamgroup"
    container_name       = "terraformstate"
    key                  = "aks-platform/terraform.tfstate"
  }
}