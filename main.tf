/*
# Create a resource group
resource "azurerm_resource_group" "myrg-sonarcloud" {
  name = "myrg-sonarcloud-integration"
  location = "East US"
}

# Create Virtual Network
# Create Virtual Network
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-sonarcloud" {
  name                = "myvnet-sonarcloud-integration-demo"
  address_space       = ["10.1.0.0/24"]
  location            = azurerm_resource_group.myrg-sonarcloud.location
  resource_group_name = azurerm_resource_group.myrg-sonarcloud.name
}

# Create Subnet
resource "azurerm_subnet" "mysubnet-sonarcloud" {
  name                 = "mysubnet-sonarcloud-integration"
  resource_group_name  = azurerm_resource_group.myrg-sonarcloud.name
  virtual_network_name = azurerm_virtual_network.myvnet-sonarcloud.name
  address_prefixes     = ["10.1.0.0/27"]
}
*/


# Create a resource group
resource "azurerm_resource_group" "new-myrg-snyk" {
  name = "myrg-snyk-integration-new"
  location = "East US"
  
}

##Repeated commented lines to verify configured sonarcloud quality gate rule
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-snyk-new" {
  name                = "myvnet-snyk-integration-demo-new"
  address_space       = ["10.5.0.0/24"]
  location            = azurerm_resource_group.new-myrg-snyk.location
  resource_group_name = azurerm_resource_group.new-myrg-snyk.name

}

# Create Subnet
resource "azurerm_subnet" "mysubnet-snyk-new" {
  name                 = "mysubnet-snyk-integration-new"
  resource_group_name  = azurerm_resource_group.new-myrg-snyk.name
  virtual_network_name = azurerm_virtual_network.myvnet-snyk-new.name
  address_prefixes     = ["10.5.0.0/27"]
}


##creating allow all inbound firewall rule to verify synk SAST detection
resource "azurerm_network_security_group" "example-synk-new" {
  name                = "example-nsg-new"
  location            = azurerm_resource_group.new-myrg-snyk.location
  resource_group_name = azurerm_resource_group.new-myrg-snyk.name

  security_rule {
    name                       = "test123"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example-new" {
  subnet_id                 = azurerm_subnet.mysubnet-snyk-new.id
  network_security_group_id = azurerm_network_security_group.example-synk-new.id
}

