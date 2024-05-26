#Creating resource group
resource "azurerm_resource_group" "ntierlb" {
  name     = "ntierlb"
  location = "East US"
  tags = {
    environment = "Dev"
  }
}

# Creating virtual network
resource "azurerm_virtual_network" "web" {
  name                = "webntier"
  location            = azurerm_resource_group.ntierlb.location
  resource_group_name = azurerm_resource_group.ntierlb.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Dev"
  }

}

# Creating subnets
resource "azurerm_subnet" "public" {
  resource_group_name  = azurerm_resource_group.ntierlb.name
  virtual_network_name = azurerm_virtual_network.web.name
  count                = length(var.subnets_info)
  address_prefixes     = [var.subnets_info[count.index].cidr]
  name                 = var.subnets_info[count.index].name

  depends_on = [azurerm_resource_group.ntierlb, azurerm_virtual_network.web]

}
