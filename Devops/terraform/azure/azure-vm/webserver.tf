# create public ip
resource "azurerm_public_ip" "web" {
  name                = "web"
  resource_group_name = azurerm_resource_group.manual.name
  location            = azurerm_resource_group.manual.location
  allocation_method   = "Static"
  tags = {
    createdBy   = "Terraform"
    Environment = "Dev"
  }
  depends_on = [azurerm_resource_group.manual]
}
# create network security group
resource "azurerm_network_security_group" "web" {
  name                = "webnsg"
  location            = azurerm_resource_group.manual.location
  resource_group_name = azurerm_resource_group.manual.name
  tags = {
    createdBy   = "Terraform"
    Environment = "Dev"
  }

  depends_on = [azurerm_resource_group.manual]

}
# netwokr security group rules

resource "azurerm_network_security_rule" "web" {
  resource_group_name         = azurerm_resource_group.manual.name
  count                       = length(var.web_nsg_rules)
  name                        = var.web_nsg_rules[count.index].name
  description                 = var.web_nsg_rules[count.index].description
  priority                    = var.web_nsg_rules[count.index].priority
  access                      = var.web_nsg_rules[count.index].access
  network_security_group_name = azurerm_network_security_group.web.name
  protocol                    = var.web_nsg_rules[count.index].protocol
  direction                   = "Inbound"
  source_port_range           = var.web_nsg_rules[count.index].source_port_range
  destination_port_range      = var.web_nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.web_nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.web_nsg_rules[count.index].destination_address_prefix

  depends_on = [azurerm_resource_group.manual, azurerm_network_security_group.web]

}

# creating network interface
resource "azurerm_network_interface" "web" {
  name     = "webnic"
  location = azurerm_resource_group.manual.location
  ip_configuration {
    name                          = "web"
    subnet_id                     = azurerm_subnet.web[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }
  resource_group_name = azurerm_resource_group.manual.name
  tags = {
    createdBy   = "Terraform"
    Environment = "Dev"
  }
  depends_on = [azurerm_resource_group.manual, azurerm_subnet.web]
}

# Associatin between network security group and network intereface

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id

  depends_on = [azurerm_network_interface.web, azurerm_network_security_group.web]
}

# creating virtual linux machine
resource "azurerm_linux_virtual_machine" "webserv" {
  name                  = var.web_vm_info.name
  resource_group_name   = azurerm_resource_group.manual.name
  location              = azurerm_resource_group.manual.location
  size                  = var.web_vm_info.size
  network_interface_ids = [azurerm_network_interface.web.id]
  admin_username        = var.web_vm_info.username
  admin_ssh_key {
    username   = var.web_vm_info.username
    public_key = file(var.web_vm_info.public_key_path)
  }
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
  user_data = base64encode(file("install.sh"))
  #network_interface_ids = [azurerm_network_interface.web.id]

}
