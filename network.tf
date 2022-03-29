resource "azurerm_virtual_network" "vt_network" {
  name                = "vt_network_eduvalor"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.final_resource.location
  resource_group_name = azurerm_resource_group.final_resource.name
}

resource "azurerm_subnet" "subnet_internalA" {
  name                 = "subnetA"
  resource_group_name  = azurerm_resource_group.final_resource.name
  virtual_network_name = azurerm_virtual_network.vt_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet_internalB" {
  name                 = "subnetB"
  resource_group_name  = azurerm_resource_group.final_resource.name
  virtual_network_name = azurerm_virtual_network.vt_network.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_network_security_group" "internal_sec_groups" {
  name = "eduvalor_sg"
  location = azurerm_resource_group.final_resource.location
  resource_group_name = azurerm_resource_group.final_resource.name
}

resource "azurerm_network_security_rule" "sg_rule1" {
  name                       = "reverse-prox"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.final_resource.name
    network_security_group_name = azurerm_network_security_group.internal_sec_groups.name
}

resource "azurerm_network_security_rule" "sg_rule2" {
  name                       = "main-proj"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "4000"
    destination_port_range     = "5000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.final_resource.name
    network_security_group_name = azurerm_network_security_group.internal_sec_groups.name
}

resource "azurerm_network_security_rule" "sg_rule3" {
  name                       = "grafana-loki"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3000"
    destination_port_range     = "3100"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.final_resource.name
    network_security_group_name = azurerm_network_security_group.internal_sec_groups.name
}

resource "azurerm_network_security_rule" "sg_rule4" {
  name                       = "prometheus"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "9000"
    destination_port_range     = "9091"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.final_resource.name
    network_security_group_name = azurerm_network_security_group.internal_sec_groups.name
}

resource "azurerm_public_ip" "public_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.final_resource.name
  location            = azurerm_resource_group.final_resource.location
  allocation_method   = "Static"
}