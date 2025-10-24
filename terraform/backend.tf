/*
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstate<unique>"
    container_name       = "tfstate"
    key                  = "burger-builder/terraform.tfstate"
  }
}
*/
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
