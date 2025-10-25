project_name = "devops"
environment  = "lama22"
location     = "canadacentral"

# Network
vnet_address_space              = ["10.0.0.0/16"]
aks_system_subnet_prefix        = ["10.0.1.0/24"]
aks_user_subnet_prefix          = ["10.0.2.0/24"]
private_endpoints_subnet_prefix = ["10.0.3.0/24"]
service_cidr                    = "10.255.0.0/16"
dns_service_ip                  = "10.255.0.10"

# AKS
kubernetes_version  = null
system_node_vm_size = "Standard_DC2ds_v3"
system_min_count    = 1
system_max_count    = 2
user_node_vm_size   = "Standard_DC2ds_v3"
user_min_count      = 1
user_max_count      = 3

# Passwords
grafana_admin_password     = "lama22@"
sql_administrator_password = "MySecurePassword123!"

# Azure AD
#azuread_sql_admin_object_id = "YOUR-OBJECT-ID-HERE"
#azuread_sql_admin_login = "YOUR-EMAIL-HERE"



# SQL Database
sql_administrator_login = "sqladmin"
sql_database_name       = "appdb"
sql_sku_name            = "S0"
sql_max_size_gb         = 2

# ACR
# acr_sku = "Standard"
