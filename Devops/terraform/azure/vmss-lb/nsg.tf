# Create network security grouop
resource "azurerm_network_security_group" "preschool" {
  name                = "preschool-nsg"
  resource_group_name = azurerm_resource_group.ntierlb.name
  location            = azurerm_resource_group.ntierlb.location
  security_rule {
    name                       = "openhttp"
    description                = " this is used to open http"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    direction                  = "Inbound"
    priority                   = "1000"

  }
  depends_on = [azurerm_resource_group.ntierlb]

  tags = {
    environment = "Dev"
  }
}

# Association between nsg and subnet
resource "azurerm_subnet_network_security_group_association" "nsg_sub" {
  network_security_group_id = azurerm_network_security_group.preschool.id
  subnet_id                 = azurerm_subnet.public[0].id
}
