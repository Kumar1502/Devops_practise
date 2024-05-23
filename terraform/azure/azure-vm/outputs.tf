output "web-ip"{
    value=azurerm_linux_virtual_machine.webserv.public_ip_address
}

output "web-url" {
  value="http://${azurerm_linux_virtual_machine.webserv.public_ip_address}/preschool"
}