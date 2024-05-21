# This creates public ip in azure
resource "azurerm_public_ip" "web" {
  name                = "web"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  allocation_method   = "Static"
  tags = {
    createdBy   = "User"
    Environment = "Dev"
  }
  depends_on = [azurerm_resource_group.group]

}
# This creates network security group in azure
resource "azurerm_network_security_group" "web" {
  name                = "webnsg"
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location

  tags = {
    createdBy   = "User"
    Environment = "Dev"
  }
  depends_on = [azurerm_resource_group.group]

}
# This creates network security group rules in azure
resource "azurerm_network_security_rule" "web" {
  count                       = length(var.web_nsg_rules)
  name                        = var.web_nsg_rules[count.index].name
  description                 = var.web_nsg_rules[count.index].description
  resource_group_name         = azurerm_resource_group.group.name
  network_security_group_name = azurerm_network_security_group.web.name
  protocol                    = var.web_nsg_rules[count.index].protocol
  source_port_range           = var.web_nsg_rules[count.index].source_port_range
  destination_port_range      = var.web_nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.web_nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.web_nsg_rules[count.index].destination_address_prefix
  access                      = var.web_nsg_rules[count.index].access
  priority                    = var.web_nsg_rules[count.index].priority
  direction                   = "Inbound"
  depends_on                  = [azurerm_resource_group.group, azurerm_network_security_group.web]

}

#creating network interface
resource "azurerm_network_interface" "web" {
  name                = "webnic"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  ip_configuration {
    name                          = "web"
    subnet_id                     = azurerm_subnet.subnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id

  }
  depends_on = [azurerm_subnet.subnets, azurerm_resource_group.group, azurerm_public_ip.web]
}

# Association between network interface and secuirty group

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id

  depends_on = [azurerm_network_interface.web, azurerm_network_security_group.web]
}

# create virtual machine
resource "azurerm_linux_virtual_machine" "web" {
  name                = var.web_vm_info.name
  size                = var.web_vm_info.size
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  admin_username      = var.web_vm_info.username

  admin_password                  = "Kumar@12345"
  disable_password_authentication = false


  # admin_ssh_key {
  #   username   = var.web_vm_info.username
  #   public_key = file(var.web_vm_info.public_key_path)
  # }
  network_interface_ids = [azurerm_network_interface.web.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }
  source_image_reference {
    publisher = var.web_vm_info.publisher
    offer     = var.web_vm_info.offer
    sku       = var.web_vm_info.sku
    version   = var.web_vm_info.version
  }

}
