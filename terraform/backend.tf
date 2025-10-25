terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devops-lama-state"
    storage_account_name = "tfstatedevopslama"
    container_name       = "terraformstate"
    key                  = "aks-platform/terraform.tfstate"
  }
}
