variable "primary_network_cidr" {
  type        = list(string)
  description = "this is primary network cidr"
  default     = ["192.168.0.0/16"]
}

variable "web_subnet_cidr" {
  type        = string
  description = "this is web subnet cidr"
  default     = "192.168.0.0/24"
}

variable "db_subnet_cidr" {
  type        = string
  description = "this is db subnet cidr"
  default     = "192.168.1.0/24"
}

variable "region" {
  type        = string
  description = "this is region "
  default     = "eastus"
}

variable "resource_group" {
  type        = string
  description = "this is resource group"
  default     = "myresource"
}
variable "subnet_names" {
  type        = list(string)
  description = "this is subnet names"
  default     = ["web", "app", "db"]

}
variable "subnet_cidrs" {
  type        = list(string)
  description = "this is subnet group"
  default     = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}

variable "web_nsg_rules" {
  type = list(object({
    name                       = string
    description                = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    access                     = string
    priority                   = number
    source_address_prefix      = string
    destination_address_prefix = string


  }))
  description = "web nsg rules"
  default = [{
    name                       = "openhttp"
    description                = "this opens port 80"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    access                     = "Allow"
    priority                   = 1000
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }]
}
variable "web_vm_info" {
  type = object({
    name            = string
    size            = string
    username        = string
    public_key_path = string
    publisher       = string
    offer           = string
    sku             = string
    version         = string

  })
  default = {
    name            = "webvm"
    size            = "Standard_B1s"
    username        = "Dell"
    public_key_path = "~/.ssh/id_rsa.pub"
    publisher       = "Canonical"
    offer           = "0001-com-ubuntu-server-jammy"
    sku             = "22_04-lts"
    version         = "latest"


  }
}
