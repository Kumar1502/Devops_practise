# create a virtual network

resource "azurerm_virtual_network" "web" {
  resource_group_name = azurerm_resource_group.manual.name
  name                = var.virtual_network_info.name
  location            = azurerm_resource_group.manual.location
  address_space       = var.virtual_network_info.cidr
  tags = {
    createdBy   = "Terraform"
    Environment = "Dev"
  }

}

#create multiple subnets

resource "azurerm_subnet" "web" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.manual.name
  virtual_network_name = azurerm_virtual_network.web.name
  address_prefixes     = [var.subnet_cidr_range[count.index]]

  depends_on = [azurerm_resource_group.manual, azurerm_virtual_network.web]
}


