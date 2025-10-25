# ===================================
# Networking Module - Simplified
# Only Required Components
# ===================================

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = var.tags

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

# AKS System Subnet
resource "azurerm_subnet" "aks_system" {
  name                 = "${var.vnet_name}-aks-system-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_system_subnet_prefix
}

# AKS User Subnet
resource "azurerm_subnet" "aks_user" {
  name                 = "${var.vnet_name}-aks-user-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.aks_user_subnet_prefix

  depends_on = [
    azurerm_virtual_network.main
  ]
}

# Private Endpoints Subnet
resource "azurerm_subnet" "private_endpoints" {
  name                 = "${var.vnet_name}-pe-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.private_endpoints_subnet_prefix

  depends_on = [
    azurerm_virtual_network.main
  ]
}

# NSG for AKS System
resource "azurerm_network_security_group" "aks_system" {
  name                = "${var.vnet_name}-aks-system-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# NSG for AKS User
resource "azurerm_network_security_group" "aks_user" {
  name                = "${var.vnet_name}-aks-user-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# NSG for Private Endpoints
resource "azurerm_network_security_group" "private_endpoints" {
  name                = "${var.vnet_name}-pe-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Associate NSGs with Subnets
resource "azurerm_subnet_network_security_group_association" "aks_system" {
  subnet_id                 = azurerm_subnet.aks_system.id
  network_security_group_id = azurerm_network_security_group.aks_system.id
}

resource "azurerm_subnet_network_security_group_association" "aks_user" {
  subnet_id                 = azurerm_subnet.aks_user.id
  network_security_group_id = azurerm_network_security_group.aks_user.id
}

resource "azurerm_subnet_network_security_group_association" "private_endpoints" {
  subnet_id                 = azurerm_subnet.private_endpoints.id
  network_security_group_id = azurerm_network_security_group.private_endpoints.id
}

# Private DNS Zone for Key Vault
resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Private DNS Zone for SQL
resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link DNS Zones to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {
  name                  = "${var.vnet_name}-keyvault-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = azurerm_virtual_network.main.id
  tags                  = var.tags

  depends_on = [
    azurerm_virtual_network.main,
    azurerm_private_dns_zone.keyvault
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "${var.vnet_name}-sql-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.main.id
  tags                  = var.tags

  depends_on = [
    azurerm_virtual_network.main,
    azurerm_private_dns_zone.sql
  ]
}
