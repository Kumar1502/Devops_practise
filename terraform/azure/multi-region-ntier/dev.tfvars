#assignig variable values

primary_network_cidr = ["192.168.0.0/16"]
subnet_names         = ["web", "app", "db"]
subnet_cidrs         = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
web_nsg_rules = [{
  name                       = "openhttp"
  description                = "this opens port 80"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  access                     = "Allow"
  priority                   = 1000
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  }, { name                  = "openssh"
  description                = "this opens port 22"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  access                     = "Allow"
  priority                   = 1010
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}]
web_vm_info = {
    name            = "webvm"
    size            = "Standard_B1s"
    username        = "Dell"
    public_key_path = "~/.ssh/id_rsa.pub"
    publisher       = "Canonical"
    offer           = "0001-com-ubuntu-server-jammy"
    sku             = "22_04-lts"
    version         = "latest"

}
