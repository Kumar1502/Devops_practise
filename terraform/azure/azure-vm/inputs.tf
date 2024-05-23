variable "resource_group_info" {
  type = object({
    name        = string
    location    = string
    createdby   = string
    environment = string
  })
  description = "resource group information"
}

variable "virtual_network_info" {
  type = object({
    name = string
    cidr = list(string)

  })
}
variable "subnet_names" {
  type = list(string)

}
variable "subnet_cidr_range" {
  type = list(string)


}



variable "web_nsg_rules" {
  type = list(object({
    name                       = string
    description                = string
    priority                   = number
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

}
 variable "web_vm_info"{
    type = object({
      name =string
      size=string
      username=string
      public_key_path=string
      publisher=string
      sku=string
      version=string
      offer=string
    })
 }