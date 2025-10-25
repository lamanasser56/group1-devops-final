# Use local backend temporarily
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Original Azure backend - uncomment when Storage Account is created
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-devops-lama-state"
#     storage_account_name = "tfstatedevopslama"
#     container_name       = "terraformstate"
#     key                  = "aks-platform/terraform.tfstate"
#   }
# }
